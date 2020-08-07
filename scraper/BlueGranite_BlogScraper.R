############################
## R Script to Scrape All ##
## BlueGranite Blog Posts ##
## ---------------------- ##
##   By: Colby T. Ford    ##
############################

library(rvest)
library(dplyr)
library(stringr)

page <- read_html("https://www.blue-granite.com/blog")

links <- page %>%
  html_nodes("a") %>%
  html_attr("href") %>% 
  as.data.frame() %>% 
  unique()

colnames(links) <- c("link")

bloglinks <- links %>%
  filter(str_detect(link, 'https://www.blue-granite.com/blog/'))

blogbodies <- c()

for (i in 1:nrow(bloglinks)){
  
  iterlink <- as.character(bloglinks$link[i])
  
  cat("Scraping: ", iterlink, "\n")
  
  iterpage <- read_html(iterlink)
  
  blogbody <- iterpage %>% 
    html_nodes(xpath = '//*[@id="hs_cos_wrapper_post_body"]') %>% 
    html_text() %>% 
    str_replace_all(pattern = "[\n]", replacement = " ")
  
  blogbodies <- c(blogbodies, blogbody)
}

write.table(blogbodies, "BlueGranite_BlogBodies.txt",
            quote = FALSE, row.names = FALSE, col.names = FALSE,
            fileEncoding = "UTF-8")
