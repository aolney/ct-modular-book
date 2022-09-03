# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
  )

library(stringr)
library(magick)
embed_youtube <- function(youtube_id,start_time=0,end_time=NULL) {
  if (knitr::is_html_output(excludes = "epub")) {
    url <- str_c("https://www.youtube.com/embed/", youtube_id, "?start=",start_time)
    if( !is.null(end_time)) {
      url <- str_c(url,"&end=",end_time)
    }
    return(knitr::include_url(url))
  } else {
    # Download thumbnail and use that
    dir_path <- 'downloadFigs4latex'
    if (!dir.exists(dir_path)) dir.create(dir_path)
    file_path <- str_c(dir_path, '/', knitr::opts_current$get()$label, '.jpg')
    if (!file.exists(file_path)) download.file( str_c("https://img.youtube.com/vi/", youtube_id, "/mqdefault.jpg"), destfile = file_path)
    return(knitr::include_graphics(file_path))
  }
}

#This works for gifs
embed_linked_media <- function(url) {
  if (knitr::is_html_output(excludes = "epub")) {
    return(knitr::include_graphics(url))
  } else {
    # Download thumbnail and use that
    dir_path <- 'downloadFigs4latex'
    if (!dir.exists(dir_path)) dir.create(dir_path)
    ext <- tools::file_ext(url)
    # if gif, convert
    file_path <- "EMPTY"
    if( ext =="gif") {
      file_path <- str_c(dir_path, '/', knitr::opts_current$get()$label, '.jpg')
      if (!file.exists(file_path)) {
        temp_img <- image_read(url)
        image_write(temp_img, path = file_path, format = "jpg")
      }
    } else {
      file_path <- str_c(dir_path, '/', knitr::opts_current$get()$label, '.', ext)
      if (!file.exists(file_path)) download.file( url, destfile = file_path)
    }
    return(knitr::include_graphics(file_path))
  }
}