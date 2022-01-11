# R Wrapper for Google Translate

library(httr)
library(jsonlite)

r_google_translate <- function(q,
                               target,
                               format,
                               source,
                               model,
                               key,
                               sleep=0){
  
  url <- paste0("https://translation.googleapis.com/language/translate/v2?q=",q,"&target=",target,"&format=",format,"&source=",source,"&model=",model,"&key=",key)
  
  url <- utils::URLencode(url)
  get_url <- GET(url)
  get_url_content <- httr::content(get_url, as = "text", encoding = "UTF-8")
  df <- jsonlite::fromJSON(get_url_content,flatten = TRUE)
  
  out <- df$data$translations$translatedText
  
  Sys.sleep(sleep)
  
  return(out)
}

r_google_translate_vec <- function(q_vec,
                                   target,
                                   format,
                                   source,
                                   model,
                                   key,
                                   sleep = 0.02){
  
  out <- lapply(q_vec, 
                r_google_translate, 
                target=target,
                format=format,
                source=source,
                model=model,
                key=key,
                sleep=sleep) %>%
    unlist()
  
  return(out)
  
}



