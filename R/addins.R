#' Menambahkan repositori GitHub
#'
#' Menambahkan repositori GitHuB sebagai remote repository
#'
#' @import shiny miniUI

tambah_repo_github <- function(){
  ui <- miniPage(
    gadgetTitleBar(
      title = "Menambahkan Repositori GitHub",
      left = miniTitleBarCancelButton(
        inputId = "batal",
        label = "Batalkan",
        primary = TRUE
      ),
      right = miniTitleBarButton(
        inputId = "ok",
        label = "OK",
        primary = TRUE
      )
    ),
    miniContentPanel(
      fillCol(
        flex = c(1, 1, NA, NA),
        fillRow(
          textInput(
            inputId = "akun_github",
            "Akun GitHub:",
            value = "aswansyahputra",
            width = "90%"
          ),
          textInput(
            inputId = "repo_github",
            "Repositori GitHub:",
            value = "repoku",
            width = "90%"
          )
        ),
        fillRow(
          textInput(
            inputId = "nama_remote",
            "Nama repositori:",
            value = "origin",
            width = "90%"
          ),
          radioButtons(
            "metode",
            label = "Metode",
            choices = c("SSH", "HTTPS")
          )
        ),
        strong("Kode:"),
        verbatimTextOutput("teks_skrip")
      )
    )
  )
  
  server <- function(input, output, session) {
    
    skrip <- reactive({
      paste0(
        "git remote add ",
        input$nama_remote,
        " ",
        switch(input$metode,
               "SSH" = "git@github.com:",
               "HTTPS" = "https://github.com/"
        ),
        input$akun_github,
        "/",
        input$repo_github,
        ".git"
      )
    })
    
    output$teks_skrip <- renderText({
      skrip()
    })
    
    observeEvent(input$batal, {
      stopApp()
    })
    
    observeEvent(input$ok, {
      
      if (!dir.exists(".git")) {
        stopApp("Aktifkan sistem git pada direktori kerja terlebih dahulu!")
      } else{
        system(skrip())
        stopApp(
          rstudioapi::showDialog(
            title = "",
            message = "Repositori GitHub telah berhasil ditambahkan! Silakan mulai ulang sesi R terlebih dahulu."
          )
        )
      }
    })
  }
  runGadget(app = ui, server = server, viewer = paneViewer(275), stopOnCancel = FALSE)
}

#' Cadangkan nama paket
#'
#' Mencadangkan nama paket yang saat ini telah terpasang

cadangkan_nama_paket <- function(){
  pkgs <- unname(installed.packages()[,1])
  pkgs <- pkgs[!pkgs %in% c("stats", "graphics", "grDevices", "utils", "datasets", "methods", "base")]
  target <- rstudioapi::selectFile(caption = "Save File",
                                   label = "Save",
                                   filter = "Rda(*.rda)",
                                   existing = FALSE)
  save(pkgs, file = paste0(target, ".rda"))
}

#' Pasang paket tercadangkan
#'
#' Memasang paket-paket yang sebelumnya telah dicadangkan

pasang_paket_tercadangkan <- function(){
  path <- rstudioapi::selectFile(caption = "Pilih berkas nama paket",
                                 filter = "Rda Files (*.rda)",
                                 existing = TRUE)
  load(path)
  install.packages(pkgs)
}

