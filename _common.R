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


# In HTML, creates a bootstrap modal with embedded iframe to a modular environment, e.g. DISTRHO/Cardinal
# Creates NOTHING in other formats. See modular_caption for providing a caption/crossref and placeholder for other formats
modular_modal <- function(id, instructions_html="",solution_html="",iframe_url = "https://cardinal.olney.ai",starter_file="") {
  if (knitr::is_html_output(excludes = "epub")) {
    # populate template
    id = stringr::str_replace_all(id,"-","_") #bookdown references like -, javascript likes _ for variable names
    final_iframe_url = iframe_url
    if( starter_file != '' ) final_iframe_url <- str_c(iframe_url,'?patchurl=',starter_file)
    html = htmltools::htmlTemplate("images/modular-iframe-template.html",id=id,instructions_html=instructions_html,solution_html=solution_html,iframe_url=final_iframe_url)
    return(html)
  }
}

# Creates captions appropriately for different formats
# Note for pdf/epub, will also include static image in the figure
modular_caption <- function(id="", instructions_html="",solution_html="",iframe_url = "https://cardinal.olney.ai", starter_file="",default_img="images/launch-virtual-modular-button.png") {
  if (knitr::is_html_output(excludes = "epub")) {
    current <- knitr::opts_current$get()
    options <- current #fig.cap is non-null in current, needed by .img.cap
    options$fig.num <- 1 #fig.num appears to be the number of figures in the chunk, needed by .img.cap
    options$fig.cur = knitr:::plot_counter()
    reduced = knitr:::reduce_plot_opts(options)
    cap = knitr:::.img.cap(reduced)
    
    # bare caption, empty figure with minimal space above
    figure_div <- sprintf( '<div class="figure" style="margin-top: 0px;padding-top: 0px;"><p class="caption">%s</p></div>',cap )
    html <- htmltools::HTML( figure_div )
    
    #asis_output needed to remove html fencing in md, which is needed for cross referencing to work
    html <- knitr::asis_output(html)
    
    return(html)
  } else {
    return(knitr::include_graphics(default_img))
  }
}

#This works for gifs at least; may work for others with some mods
embed_linked_media <- function(url) {
  # If web
  if (knitr::is_html_output(excludes = "epub")) {
    return(knitr::include_graphics(url))
  # If everything else
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
        # print(file_path)
      }
    } else {
      file_path <- str_c(dir_path, '/', knitr::opts_current$get()$label, '.', ext)
      if (!file.exists(file_path)) download.file( url, destfile = file_path)
      # print(file_path)
    }
    return(knitr::include_graphics(file_path))
  }
}