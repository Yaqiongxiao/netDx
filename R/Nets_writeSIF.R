#' write patient networks in Cytoscape's .sif format
#'
#' @details Converts a set of binary interaction networks into Cytoscape's
#' sif format.
#' (http://wiki.cytoscape.org/Cytoscape_User_Manual/Network_Formats)
#' This utility permits visualization of feature selected networks.
#'
#' @param netPath (char): vector of path to network files; file suffix
#' should be '_cont.txt' 
#' networks should be in format: A B 1
#' where A and B are nodes, and 1 indicates an edge between them
#' @param outFile (char) path to .sif file 
#' @param netSfx (char) suffix for network file name
#' @return No value. Side effect of writing all networks to \code{outFile}
#' @examples
#' netDir <- system.file("extdata","example_nets",package="netDx")
#' netFiles <- paste(netDir,dir(netDir,pattern='txt$'),
#'	sep=getFileSep())
#' writeNetsSIF(netFiles,'merged.sif',netSfx='.txt')
#' @export
writeNetsSIF <- function(netPath, 
	outFile=paste(tempdir(),"out.sif",sep=getFileSep()),
	netSfx = "_cont.txt") {
    if (.Platform$OS.type=="unix") {
	if (file.exists(outFile)) unlink(outFile)
	file.create(outFile)
    } 
    for (n in netPath) {
        netName <- sub(netSfx, "", basename(n))
        message(sprintf("%s\n", netName))
        
        dat <- read.delim(n, sep = "\t", header = FALSE, as.is = TRUE)
        dat2 <- cbind(dat[, 1], netName, dat[, 2])
        
        write.table(dat2, file = outFile, append = TRUE, sep = "\t", 
						col.names = FALSE, 
            row.names = FALSE, quote = FALSE)
    }
    
}
