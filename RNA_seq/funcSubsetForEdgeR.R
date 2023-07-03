#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install("edgeR")
#library(edgeR)

######### function to subset data
funcSubsetForEdgeR <- function(inputData , #input Data Matrix
                       groupLabels, #list of all labels
                       baselineGrp, #name of baseline group label
                       compGrp,  #name of comparison group label
                       outputFileLocation ="../output/edgeR") { #location of output folder
    #browser()
    
    #Min value has to be 0
    inputData[inputData < 0] = 0 #assume everything less than 0 (NA) = 0
    
    #Convert labels into factor variable
    group_subset <- factor(as.character(groupLabels)) # this will change number of levels in the factor also
    group_subset <<- relevel(group_subset, ref = baselineGrp )
    
    # Change min value to 2
    if(min(inputData) < 0) {
        # adding 2 to all rows and columns, so that there are no 0 values
        input2_Subset <<- inputData + 2
    } else {
        input2_Subset <<- inputData
    }
    
    #Call function to run EdgeR
    funcEdgeR(inputData = input2_Subset, 
              grpData = group_subset, 
              outFile = outputFileLocation)
}
#values to send to function -- input2_Subset, group_subset

#########function to run EdgeR
funcEdgeR <- function(inputData, grpData, bcv=0.4, outFile) {
    #browser()
    
    ## Steps in EdgeR
    y <- DGEList(counts=inputData,group=grpData)
    
    #We filter out lowly expressed genes using the following commands 
    keep <- rowSums(cpm(y)>1) >= 2
    y <- y[keep, , keep.lib.sizes=FALSE]
    
    y <- calcNormFactors(y)
    design <- model.matrix(~grpData)
    
    ## data exploration
    pdf(paste(outFile,"_MDSPlot.pdf",sep=""), width=5, height=5)
    plotMDS(y,pch = "*")
    dev.off()
    
    #estimate dispersion 
    # y <- estimateDisp(y,design, robust = TRUE)
    y <- estimateGLMCommonDisp(y,design)
    
    #EdgeR is meant for biolog rep. For data without biological rep, human, assume n BCV (squareroot-dispersion) = 0.4
    bcv <- 0.4
    et <- exactTest(y, dispersion=bcv^2)
    #head(et$table)
    resultsET <- topTags(et , n = nrow(et$table) ,
                         sort.by = "p.value")$table
    write.csv(resultsET, file = paste(outFile,"_ExactTest.csv",sep=""),
              quote = FALSE,row.names = TRUE)
    
    ## GLM - likelihood ratio test
    fit <- glmFit(y,design,dispersion=bcv^2)
    lrt <- glmLRT(fit,coef=2) 
    #head(lrt$table)
    resultsLRT <- topTags(lrt , n = nrow(lrt$table) ,
                          sort.by = "PValue")$table
    write.csv(resultsLRT, file = paste(outFile,"_GLM_LRT.csv",sep=""),
              quote = FALSE,row.names = TRUE)
    
    ## GLM - quasi likelihood F tests
    fitQ <- glmQLFit(y,design,dispersion =bcv^2)
    qlfQ <- glmQLFTest(fitQ,coef=2)
    head(qlfQ$table)
    resultsQLF <- topTags(qlfQ , n = nrow(qlfQ$table) ,
                          sort.by = "PValue")$table
    
    write.csv(resultsQLF, file = paste(outFile,"_GLM_QLF.csv",sep=""),
              quote = FALSE,row.names = TRUE)
    
    
    #### merge Exact Test results with the input2_subset data
    merged1 <- merge(x = resultsET, y = inputData, by.x = "row.names",by.y = "row.names")
    write.csv(merged1, file = paste(outFile,"_mergedData.csv",sep=""),
              quote = FALSE,row.names = F)
}