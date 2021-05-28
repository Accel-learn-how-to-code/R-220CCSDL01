library(selectr)
library(xml2)
library(rvest)
library(jsonlite)
library(stringr)
scrappedurl<-"https://www.amazon.in/OnePlus-Mirror-Black64GB-Memory/dp/B0756Z43QS?tag=googinhydr18418-%2021&tag=googinkenshoo-21&ascsubtag=aee9a916-6%20-4409-92ca3bdbeb549f80"
Amazonwebpage<- read_html(scrappedurl)
html_text(Amazonwebpage)
title_html <- html_nodes(Amazonwebpage, "span#productTitle")
title <- html_text(title_html)
clearTitle <- str_replace_all(title, "[\r\n]", "")
print(clearTitle)

title_html <- html_nodes(Amazonwebpage, "span#productTitle")
title <- html_text(title_html)

title_html <- html_nodes(Amazonwebpage, "span#productTitle")
title <- html_text(title_html)

desc_html <- html_nodes(Amazonwebpage, "div#productDescription")
desc <- html_text(desc_html)

title_html <- html_nodes(Amazonwebpage, "span#productTitle")
title <- html_text(title_html)

product_data <- data.frame(Title = title, Price = price,Description = desc, Rating = rate, Size = size, Color = color)
json_data <- toJSON(product_data)