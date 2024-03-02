buildUI <- function() {
    fluidPage(
        tags$head(
            tags$link(rel = "stylesheet", type = "text/css", href = "custom.css"),
            tags$link(rel = "stylesheet", type = "text/css", href = "default.min.css"),
            tags$script(src = "highlight.min.js")
        ),
        useShinyjs(),
        useKeys(),
        keysInput("activate", "command+enter", global = TRUE),
        theme = bslib::bs_theme(bootswatch = "lux"),
        div(
            class = "container",
            # title row
            div(
                style = "width: 100%; height: 120px; position: relative;",
                div(
                    style = "padding-top:10px;",
                    h1("io, the Wisp", class = "center"),
                    h3(html("艾 欧 精 灵"), class = "center")
                )
            ),
            # input row
            fluidRow(
                column(
                    width = 11,
                    # query goes here
                    textInput(
                        inputId = "qn",
                        label = "",
                        placeholder = "在此输入文字，点击右侧按钮进行提问",
                        width = "100%"
                    )
                ),
                column(
                    width = 1,
                    br(),
                    actionButton(
                        inputId = "btn",
                        label = "try?",
                        class = "btn-light s-2"
                    )
                ),
                column(
                    width = 12,
                    # common examples
                    uiOutput("examples")
                ),
                column(width = 12, br())
            ),
            # output row
            fluidRow(
                tabsetPanel(
                    id = "tabs",
                    type = "tabs",
                    tabPanel(
                        "结果展示",
                        tags$div(
                            class = "res",
                            shinycssloaders::withSpinner(
                                uiOutput("display"),
                                type  = 4,
                                size  = 0.5,
                                proxy.height = "200px",
                                color = "lightgray"
                            )
                        )
                    ),
                    tabPanel(
                        "查询语法",
                        uiOutput("query")
                    )
                )
            ),
            
            # footer and guides
            fluidRow(
                tags$span(
                    tags$hr(),
                    actionLink("helpguide", "点击这里显示帮助文档"),
                    tags$h6("BACC | 商业智能")
                )
                
            )
        )
    )
}