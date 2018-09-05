library(seqinr)

# setwd("/Users/anaraven/Documents/2019/IU/Faruk/finalproject")
y <- read.table("no3d_prob.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
y$V6 <- NULL

prot_ends <- which(diff(y$V1)<0)
p <- read.fasta("../no3d_prots/no3d_prots.faa")
names <- getName(p)

show_prob <- function(i, col="V5") {
    if(i==1) {
        start <- 1
    } else {
        start <- prot_ends[i-1]+1
    }
    end <- prot_ends[i]
    plot(y[start:end, col], type="l", ylab="Probability", ylim=c(0,1))
    abline(h=0.5, col="red")
}

# show_prob(which(names=="P41003"))
# getAnnot(p[names=="O42709"])
# i <- which(names=="Q9P3W6")
# start <- prot_ends[i-1]+1
# end <- prot_ends[i]
# which(y[start:end, 5]>0.5)
# diff(which(y[start:end, 5]>0.5))>1

