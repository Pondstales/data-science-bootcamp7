# install.packages("tidyverse")
# install.packages("rvest")
library(tidyverse)
library(rvest)
url <- "https://en.wikipedia.org/wiki/Friends"

# vectors to dataframe
infobox_label <- url %>%
  read_html() %>%
  html_elements("th.infobox-label") %>%
  html_text2()

infobox_data <- url %>%
  read_html() %>%
  html_elements(c("td.infobox-data", "div.plainlist")) %>%
  html_text2()

friends_df <- data.frame(infobox_label, infobox_data)
View(friends_df)

# h2
url %>%
  read_html() %>%
  html_elements("h2") %>%
  html_text2()

# strings to dataframe
cast_char <- url %>%
  read_html() %>%
  html_elements("div.gallerytext") %>%
  html_text2()

friends <- data.frame(cast_char)
friends %>%
  separate(cast_char, sep = " as\n", into = c("Cast", "Characters")) %>%
  View()
