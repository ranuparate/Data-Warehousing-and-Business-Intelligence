#PDF Scrapping Unstructured
#install.packages("tabulizerjars")
library(tabulizer)
library(tidyverse)
tab2 <- extract_tables("C:/Users/Ranu/Desktop/adidas/Automation/gb_2009_en.pdf")
tab2[151]
x <- cbind(tab2[[151]][5:5,3:9])
x
colnames(x) <- c("NetSales_MillionEuros")
x
dataX <- data.frame(x)
tab1 <- extract_tables("C:/Users/Ranu/Desktop/adidas/Automation/annual_report_gb-2017_en_secured.pdf")
tab1[280]
x1 <- cbind(tab1[[280]][0:1,2:11])
x1
colnames(x1) <- c("NetSales_MillionEuros")
dataX1 <- data.frame(x1)
Merged <- do.call("rbind", list(dataX1,dataX))
Merged1 = Merged[-c(16),]
x1 <- as.data.frame(Merged1)
colnames(x1) <- c("NetSales_MillionEuros")
x1
x2=x1[order(-1:-16),] 
x2
x2 <- as.data.frame(x2)
colnames(x2) <- c("NetSales_MillionEuros")
x2
x2$Year <- c("2002", "2003", "2004","2005", "2006", "2007","2008", "2009", "2010","2011","2012", "2013", "2014","2015", "2016", "2017")
x2
x2$ID <- 1:nrow(x2)
x2
colnames(x2) <- c("NetSales_MillionEuros","NetSaleYear","NetSale_ID")
write.csv(x2 ,"C:/Users/Ranu/Documents/R/NetSaleWorldwide.csv", row.names = FALSE)

#Kaggle cleaning Structured Data
File1 =  read.csv(file= "C:/Users/Ranu/Desktop/adidas/Automation/Regionwise.csv" ,header=TRUE, sep=",")
File1= File1[-c(1,2,3,4,5,6,7,8), -c(2,6,7)]
File1$ID <- 1:nrow(File1)
File1=as.data.frame(File1)
library(tidyr)
df <- data.frame(File1)
foo <- data.frame(do.call('rbind', strsplit(as.character(File1$date),'|',fixed=TRUE)))
colnames(foo) = c("Year","Quarter")
foo
Merged2 <- do.call("cbind", list(File1,foo))
Merged3 = Merged2[,-c(1)]
colnames(Merged3) <- c("US_GDP","Europe_GDP","CHN_GDP_US","Region_ID","YearRegion","Quarter")
write.csv(Merged3 ,"C:/Users/Ranu/Documents/R/NetSaleRegionwise.csv", row.names = FALSE)					


# convert the Excel to CSV for Statista Dataset
# Install library
#install.packages("readxl")
library("readxl")
StatistaFile1 <- read_excel("C:/Users/Ranu/Desktop/adidas/Automation/GrossProfit.xlsx", sheet=2)
StatistaFile1 <- data.frame(StatistaFile1)
#View(StatistaFile1)
StatistaFile1 <- StatistaFile1[-c(1,2),]
#install.packages("data.table")
library(data.table)
setnames(StatistaFile1, old = c('Global.gross.profit.of.the.adidas.Group.from.2000.to.2017','X__1'), new = c('GrossProfitYear','GrossProfit_MillionEuros'))
StatistaFile1 <- StatistaFile1[-c(1,2),]
StatistaFile1$GrossProfit_ID <- 1:nrow(StatistaFile1)
#View(StatistaFile1)
write.csv(StatistaFile1 ,"C:/Users/Ranu/Documents/R/GrossProfit.csv", row.names = FALSE)					

# convert the Excel to CSV for Statista Dataset
# Install library
#install.packages("readxl")
library("readxl")
StatistaFile2 <- read_excel("C:/Users/Ranu/Desktop/adidas/Automation/Productwise.xlsx", sheet=2)
StatistaFile2 <- data.frame(StatistaFile2)
#View(StatistaFile2)
StatistaFile2 <- StatistaFile2[-c(1,2),]
#install.packages("data.table")
library(data.table)
setnames(StatistaFile2, old = c('Adidas.Group.s.global.net.sales.from.2002.to.2017..by.product.category','X__1','X__2','X__3'), new = c('Year','Footwear', 'Apparel','Hardware'))
StatistaFile2$Product_ID <- 1:nrow(StatistaFile2)
#View(StatistaFile2)
write.csv(StatistaFile2 ,"C:/Users/Ranu/Documents/R/SalesProductwise.csv", row.names = FALSE)					

print("complete")
