library(RJSONIO)
library(gdata)
path <- "D:/cameras1.json"

#Download the JSON file if it doesnt exist
if (!file.exists(path)) {
  #Get the data
  download.file("https://data.ny.gov/api/views/9a8c-vfzj/rows.json?accessType=DOWNLOAD", destfile = path)
}

#grab raw data
FoodMarketsRaw<-fromJSON(path)
foodMarkets<-FoodMarketsRaw[['data']]

#Grab Mutili Data
grabInfo<-function(var){
  temp<-sapply(foodMarkets, function(x) returnData(x, var))
}

returnData<-function(x, var){
  if(!is.null(x[[var]])){
    return(trim(x[[var]]))
  }else{
    return(NA)
  }
}

# Do the extraction and assembly from field 5 to field 14
#in tư field 5 -> 14, co the duoc thay doi cho phu hop bai lam
fmDataDF<-data.frame(sapply(5:14,grabInfo),stringsAsFactors=FALSE)
print(fmDataDF)