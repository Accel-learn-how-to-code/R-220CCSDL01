library(RJSONIO)
library(gdata)
url<-"https://data.ny.gov/api/views/2fni-raj8/rows.json?accessType=DOWNLOAD"
dataPath<-"D:/Code/JSONdata/solarElectric2.json"
#Vo Dinh Hoang Long - 1811505310323

#Neu khong ton tai thu muc JSON data thi create directory
if (!file.exists("D:/Code/JSONdata")) { 
  dir.create("D:/Code/JSONdata") 
}

#Download file json neu file chua download
if (!file.exists("D:/Code/JSONdata/solarElectric2.json")) {
  #Get the data from solarElectric
  download.file(url, destfile = dataPath, method="curl")
}

solarElectricRaw<-fromJSON(dataPath)
solarElectric<-solarElectricRaw[['data']]
cat("\n---Some Solar Electrics---\n")

#Get column co field name
colnames <- solarElectricRaw[['meta']][['view']][['columns']]


#Grab data
grabInfo<-function(var){
  temp<-sapply(solarElectric, function(x) returnData(x, var))
}

returnData<-function(x, var){
  if(!is.null(x[[var]])){
    return(trim(x[[var]]))
  }else{
    return(NA)
  }
}

#Get field name cho moi column
getFieldName<-function(x){
  if(is.null(colnames[[x]]$subColumnTypes)){
    return(colnames[[x]]$name)
  }else{
    return(colnames[[x]]$subColumnTypes)
  }
}

# tao data frame va gan field name cho moi column
fmDataDF<-data.frame(sapply(1:7,grabInfo))
fmNames<-unlist(sapply(1:7, getFieldName))
names(fmDataDF)<-fmNames
print(fmDataDF)