#install.packages ('selectr')
#install.packages ('xml2')
#install.packages ('rvest')
#install.packages("writexl")
#install.packages("magick")
#install.packages("xlsx")

#loading the package:
library(xml2)
library(xlsx)
library(rvest)
library(stringr)
library(writexl)

#url <- 'http://xuanvinh.vn/msi'

url <- 'http://xuanvinh.vn/DELL'
#Reading the HTML code from the website
webpage <- read_html(url)

#scrape title of the product> 
title_html <- html_nodes(webpage, '.product-title')
TenSP <- html_text(title_html)

LinkHinhAnh <- html_nodes(webpage, xpath="//*[@class='product-item']/div/a/img")%>%html_attr("src")
imgSource <- read_html(url) %>% html_nodes(".product-item:nth-child(1) img") %>% html_attr('src')
#dowLoad the Url Img
for(num in 1:length(LinkHinhAnh)){
  
  temp=LinkHinhAnh[[num]]
  imgName=str_sub(temp,28)
  cat("Dowloading image: ", imgName,"\n")
  imgName=paste0("E:\\CDCSDL_CK\\img",imgName)
  download.file(temp,destfile = imgName,mode = "wb")
}

price_html <- html_nodes(webpage, 'p.fleft.gia')
GiaTienKhuyenMai <- html_text(price_html)

price_html <- html_nodes(webpage, 'p.fright.gia_cu')
GiaTien <- html_text(price_html)

product_item_html <- html_nodes(webpage, '.product-list ')
product_item <- html_text(product_item_html)


str_replace_all(product_item, "[\r\n]" , "")
df <- data.frame(TenSP= str_replace_all(TenSP, "[\r\n]" , ""),
                 LinkHinhAnh= str_replace_all(LinkHinhAnh, "[\r\n]" , ""), 
                 GiaTienKhuyenMai= str_replace_all(GiaTienKhuyenMai, "[\r\n]" , ""), 
                 GiaTien= str_replace_all(GiaTien, "[\r\n]" , "")) 
write.xlsx(df, file="E:\\CDCSDL_CK\\data\\data.xlsx", sheetName="SP_dell4", append=TRUE)



