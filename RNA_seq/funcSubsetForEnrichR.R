#install.packages("enrichR")
#library(enrichR)

funcSubsetForEnrichR <- function(shortListResults, #short listed matrix
                                filename1, #full path and full file name for CSV file
                                optionName1 = "option1"){ #name of option
    
    #save shortlisted results
    write.csv(x = shortListResults, file = filename1)
    
    #### Function to clean gene names
    funcSplit <- function(rep_gene) {
        rep_gene_split <- unlist(strsplit(x = rep_gene, split = "|", fixed = TRUE))
        gene <- rep_gene_split[1]
        return(gene)
    }
    geneListSplit <- apply(X = as.matrix(row.names(shortListResults)), 
                           MARGIN = 1, FUN = funcSplit )
    
    
    #remove duplicates, and NA values
    geneListSplit1 <- unique(geneListSplit)
    geneListSplit2 <- na.omit(geneListSplit1)
    
    #Save list of unique genes
    write.table(x = geneListSplit2, 
                file = paste("../output/", optionName1, "_shortListedUniqueGenes.tsv", sep=""),
                quote = F, sep = "\t", row.names = FALSE, col.names = F)
    
    
    #### Load Databases for Enrichr R package
    dbs <- enrichR::listEnrichrDbs()
    
    #List of 15 databases for which enrichment will be done
    dblist1 <- read.csv(file = "../input/20201203-EnrichR-Databases.txt", 
                        header = F, stringsAsFactors = F)
    
    # set output file name
    outputFileName2 <- paste("../output/", optionName1, "_EnrichR.xlsx", sep="")
    
    source(file = "funcEnrichment.R") 
    
    #call function to run Enrichment
    funcEnrichment(dblist1, #list of databases
                   geneListSplit2,  # unique gene names list
                   outputFileName2) #output file name
    
}