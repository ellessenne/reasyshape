function(input, output, session) {

  ### Reading data
  data <- shiny::reactive({
    shiny::req(input$loadData)
    inFile <- input$loadData
    ptn <- "\\.[[:alnum:]]{1,8}$"
    suf <- tolower(regmatches(inFile$name, regexpr(ptn, inFile$name)))
    df <- switch(
      suf,
      ".csv" = readr::read_csv(inFile$datapath),
      ".dta" = haven::read_dta(inFile$datapath),
      ".sav" = haven::read_sav(inFile$datapath),
      ".sas7bdat" = haven::read_sas(inFile$datapath),
      ".rds" = readRDS(inFile$datapath)
    )
    attr(df, "spec") <- NULL
    df <- labelled::remove_labels(df, user_na_to_na = TRUE)
    df <- tibble::as_tibble(df)
    return(df)
  })

  ### Put columns in Values and Names select inputs
  shiny::observe({
    shiny::req(data())
    shiny::updateSelectInput(
      session,
      inputId = "valuesInput",
      choices = names(data())
    )
    shiny::updateSelectInput(
      session,
      inputId = "namesInput",
      choices = names(data())
    )
    shiny::updateSelectInput(
      session,
      inputId = "colsInput",
      choices = names(data())
    )
  })

  ### Reshape
  reshape <- shiny::reactive({
    shiny::req(data())
    msg <- "Please define inputs appropriately."
    if (input$wideOrLong == "wide") {
      shiny::validate(
        shiny::need(!is.null(input$valuesInput) & !is.null(input$namesInput), message = msg)
      )
      tidyr::pivot_wider(
        data = data(),
        names_from = tidyr::one_of(input$namesInput),
        values_from = tidyr::one_of(input$valuesInput)
      )
    } else {
      shiny::validate(
        shiny::need(!is.null(input$colsInput) & input$namesTo != "" & input$valuesTo != "", message = msg)
      )
      tidyr::pivot_longer(
        data = data(),
        cols = tidyr::one_of(input$colsInput),
        names_to = input$namesTo,
        values_to = input$valuesTo
      )
    }
  })

  ### Make download buttons only when data() is loaded
  shiny::observe({
    shiny::req(reshape())
    output$downloadButtonUI <- shiny::renderUI(
      shiny::downloadButton(
        outputId = "downloadButton",
        label = "Download!",
        icon = shiny::icon("download")
      )
    )
  })

  ### Downloader
  output$downloadButton <- shiny::downloadHandler(
    filename = function() {
      extension <- switch(
        input$fileFormat,
        "csv" = ".csv",
        "tsv" = ".tsv",
        "r" = ".rds",
        "stata" = ".dta",
        "spss" = ".sav",
        "sas" = ".sas7bdat"
      )
      paste0(input$fileName, extension)
    },
    content = function(file) {

      ### Here goes the code to save data
      out <- reshape()

      if (input$fileFormat == "csv") {
        readr::write_csv(x = out, path = file)
      } else if (input$fileFormat == "tsv") {
        readr::write_tsv(x = out, path = file)
      } else if (input$fileFormat == "r") {
        saveRDS(object = out, file = file)
      } else if (input$fileFormat == "stata") {
        haven::write_dta(data = out, path = file)
      } else if (input$fileFormat == "spss") {
        haven::write_sav(data = out, path = file)
      } else if (input$fileFormat == "sas") {
        haven::write_sas(data = out, path = file)
      }
    }
  )

  output$previewInput <- DT::renderDT({
    shiny::req(data())
    data()
  })

  output$previewReshape <- DT::renderDT({
    shiny::req(reshape())
    reshape()
  })
}
