library(rvest)
library(stringr)
library(xlsx)

url <- "http://xuanvinh.vn/ASUS"

#get the img url
imgSource <- read_html(url) %>% html_node(".product-item:nth-child(1) img") %>% html_attr('src')

#lưu cái imgName vào 1 data frame
imgName <- str_sub(imgSource, 28)
imgName <- paste0("Img\\", imgName)
test = data.frame(imgName, stringsAsFactors = FALSE)
print(imgName)

#save to excel
write.xlsx(test, "test.xlsx", sheetName = "book", col.names = TRUE, append = FALSE)

# download
download.file(imgSource, imgName, mode = "wb")