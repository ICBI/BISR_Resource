library(openxlsx)
library(enrichR)

funcEnrichment <- function(dblist, genes1, outputFileName) {
        #browser()
        #Loop through every database
        iCount = 1
        while(iCount <= nrow(dblist)) {
            oneDB = dblist[iCount,] 
            enriched1 <- enrichR::enrichr(unlist(genes1), oneDB)
            result1 = enriched1[[oneDB]]
            
            #If you are using openxlsx , then sheet name must be 31 characters before saving
            if(nchar(oneDB) > 31) {
                xx = unlist(strsplit(x = oneDB, split = "" ))
                xxx = paste(xx[1:31], collapse = "")
                oneDB = xxx #reduced the sheet name to 31 characters
            } 
            
            if(iCount == 1) {
                #If its the first database, create a new one
                wb = createWorkbook()
                addWorksheet(wb, sheetName = oneDB)
                writeDataTable(x = result1, wb = wb, sheet = oneDB)
                saveWorkbook(wb, file = outputFileName, overwrite = TRUE)
            } else {
                #If its not the first database, it means workbook exists already, so open and use that
                wb = loadWorkbook(outputFileName) #load already existing workbook
                addWorksheet(wb, sheetName = oneDB)
                writeDataTable(x = result1, wb = wb, sheet = oneDB)
                saveWorkbook(wb, file = outputFileName, overwrite = T)
            }
            iCount = iCount + 1
        }
    }