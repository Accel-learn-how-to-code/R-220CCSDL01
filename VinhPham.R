library(RJSONIO)
library(gdata)
download.file("https://data.cityofnewyork.us/api/views/gyrw-gvqc/rows.json?accessType=DOWNLOAD", destfile = "D:/cameras1.json")
parksCrowdsRaw<-fromJSON("D:/Code/JSONdata/cameras1.json")
parksCrowds<-parksCrowdsRaw[['data']]
cat("\n---Some Parks Crowds---\n")

#create data frame
fmNames<-sapply(parksCrowds, function(x) x[[14]])

#Grab Mutli Data
grabInfo<-function(var){
  temp<-sapply(parksCrowds, function(x) returnData(x, var))
}

returnData<-function(x, var){
  if(!is.null(x[[var]])){
    return(trim(x[[var]]))
  }else{
    return(NA)
  }
}

# do the extraction and assembly
fmDataDF<-data.frame(sapply(10:16,grabInfo),stringsAsFactors=FALSE)
print(fmDataDF)