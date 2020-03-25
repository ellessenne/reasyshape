shiny::navbarPage(
  title = "reasyshape",
  inverse = TRUE,
  collapsible = TRUE,
  fluid = TRUE,
  theme = shinythemes::shinytheme("flatly"),
  shiny::tabPanel(
    title = "Import Data",
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::fileInput(
          inputId = "loadData",
          label = "Input file"
        )
      ),
      shiny::mainPanel(
        DT::DTOutput(outputId = "previewInput")
      )
    )
  ),
  shiny::tabPanel(
    title = "Reshape Data",
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::radioButtons(
          inputId = "wideOrLong",
          label = "Direction:",
          choices = c(
            "Long to Wide" = "wide",
            "Wide to Long" = "long"
          )
        ),
        shiny::conditionalPanel(
          condition = "input.wideOrLong == 'wide'",
          shiny::selectInput(
            inputId = "valuesInput",
            label = "Values from:",
            choices = "",
            multiple = TRUE
          ),
          shiny::selectInput(
            inputId = "namesInput",
            label = "Names from:",
            choices = "",
            multiple = TRUE
          )
        ),
        shiny::conditionalPanel(
          condition = "input.wideOrLong == 'long'",
          shiny::selectInput(
            inputId = "colsInput",
            label = "Columns:",
            choices = "",
            multiple = TRUE
          ),
          shiny::textInput(
            inputId = "namesTo",
            label = "Column with column names:",
            value = "name"
          ),
          shiny::textInput(
            inputId = "valuesTo",
            label = "Column with column values:",
            value = "value"
          )
        )
      ),
      shiny::mainPanel(
        DT::DTOutput(outputId = "previewReshape")
      )
    )
  ),
  shiny::tabPanel(
    title = "Export Data",
    shiny::sidebarPanel(
      shiny::textInput(
        inputId = "fileName",
        label = "File name:",
        value = "new-file"
      ),
      shiny::selectInput(
        inputId = "fileFormat",
        label = "Format of the file to export:",
        choices = c(
          "Comma-separated" = "csv",
          "Tab-separated" = "tsv",
          "R" = "r",
          "Stata" = "stata",
          "SPSS" = "spss",
          "SAS" = "sas"
        ),
        selected = "csv"
      ),
      shiny::uiOutput(outputId = "downloadButtonUI")
    ),
    shiny::mainPanel()
  )
)
