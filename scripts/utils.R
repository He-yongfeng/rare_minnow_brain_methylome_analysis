dir_create_safe <- function(x){
  if(!dir.exists(x)) dir.create(x, recursive = TRUE)
}

fetch_figshare <- function(url, dest){
  if(!file.exists(dest)){
    download.file(url, dest, mode = "wb")
  }
}
