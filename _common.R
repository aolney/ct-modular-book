# example R options set globally
options(width = 60)

# example chunk options set globally
knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE
  )

library(stringr)
embed_youtube <- function(youtube_id,start_time=0) {
  if (knitr::is_html_output(excludes = "epub")) {
    url <- str_c("https://www.youtube.com/embed/", youtube_id, "?start=",start_time)
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