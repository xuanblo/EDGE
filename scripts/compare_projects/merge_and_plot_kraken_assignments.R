# load library
require(MetaComp)
#
# configure runtime
options(echo = TRUE)
args <- commandArgs(trailingOnly = TRUE)
#
# print provided args
print(paste("provided args: ", args))
#
# acquire values
srcFile <- args[1]
destFile <- args[2]
taxonomyLevelArg <- args[3]
plotTitleArg <- args[4]
plotFileArg <- args[5]
#
# extended functionality was added in the release #3, and we don't want to break the legacy systems
#
if (length(args) > 5) {
  rowLimitArg <- args[6]
  sortingOrderArg <- args[7]
} else {
  rowLimitArg <- 60
  sortingOrderArg <- "abundance"
}
#
# read the data and produce the merged table
merged <- merge_kraken_assignments(load_kraken_assignments(srcFile))
#
# write the merge table as a TAB-delimeted file
write.table(merged, file = destFile, col.names = T, row.names = F, quote = T, sep = "\t")
#
# produce a PDF of the merged assignment
plot_merged_assignment(assignment = merged, taxonomy_level = taxonomyLevelArg,
                       sorting_order = sortingOrderArg, row_limit = base::strtoi(rowLimitArg),
                       plot_title = plotTitleArg, filename = plotFileArg)
