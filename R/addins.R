#' R for Data Science
#'
#' Baca buku R for Data Science
#' 
#' @importFrom rstudioapi viewer
#' @importFrom utils browseURL

baca_r4ds <- function() {
  if (rstudioapi::hasFun("viewer")) {
    rstudioapi::viewer("https://r4ds.had.co.nz/")
  } else {
    utils::browseURL("https://r4ds.had.co.nz/")
  }
}

#' R for Data Science: Exercise Solutions
#'
#' Baca solusi dari latihan soal dalam buku R for Data Science
#' 
#' @importFrom rstudioapi viewer
#' @importFrom utils browseURL

baca_solusi_r4ds <- function() {
  if (rstudioapi::hasFun("viewer")) {
    rstudioapi::viewer("https://jrnold.github.io/r4ds-exercise-solutions/")
  } else {
    utils::browseURL("https://jrnold.github.io/r4ds-exercise-solutions/")
  }
}

#' Cadangkan nama paket
#'
#' Mencadangkan nama paket yang saat ini telah terpasang
#' 
#' @importFrom utils installed.packages
#' @importFrom rstudioapi selectFile

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
#' 
#' @importFrom utils install.packages 
#' @importFrom rstudioapi selectFile

pasang_paket_tercadangkan <- function(){
  path <- rstudioapi::selectFile(caption = "Pilih berkas nama paket",
                                 filter = "Rda Files (*.rda)",
                                 existing = TRUE)
  load(path)
  install.packages(pkgs)
}

