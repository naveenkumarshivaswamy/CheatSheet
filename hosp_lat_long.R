
setwd("/Users/sumanthnandamuri/Downloads")
library(RSelenium)
require(RSelenium)
remDr <- remoteDriver(remoteServerAddr = "localhost" 
                      , port = 5556
                      , browserName = "chrome")
remDr$open()
library(rvest)
wiki <- read_html("http://theagapecenter.com/Hospitals/California.htm#Top")
Hosp_list1 <- wiki %>% html_nodes("table~ table font") %>% html_text()
#Hosp_list2 <- wiki %>% html_nodes("td td td a") %>% html_text()
#Hosp_list <- cbind(Hosp_list1, Hosp_list2)
#Hosp_list
ll <- write.csv("More_Hosp.csv")
ll <- t(ll)
t <- (ll=="<U+00B0> ' / <U+00B0> '")
remDr$navigate("http://www.worldatlas.com/aatlas/findlatlong.htm")
latlong <- c(1:736)
 #col_list <- gsub("<U+00A0>", "", col_list, fixed = TRUE)
for ( i in 1:736){
          if(t){
           remDr$navigate("http://www.worldatlas.com/aatlas/findlatlong.htm")
           inp <- remDr$findElement(using = 'css selector', "#user_address")
           inp$sendKeysToElement(list(Hosp_list1[i]))
           button <- remDr$findElement(using = 'css selector', "#submitButton")
           button$clickElement()
           Sys.sleep(2)
           elem <- remDr$findElement(using = 'css selector', ".latlog_answer")
           Sys.sleep(9)
           latlong[i] <- elem$getElementText()
          }
        } 

