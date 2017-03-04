library(rdrop2)
library(readr)

token = readRDS("droptoken.rds")
drop_acc(dtoken = token)
pathPrefix = "biohack_singlecell"

listDatasets <- function() {
  filesInfo = drop_dir(pathPrefix)
  filesInfo$path
}

loadData <- function(name) {
  barcodesPath = paste0(name, "/", 'barcodes.tsv')
  genesPath = paste0(name, "/", 'genes.tsv')
  tsnePath = paste0(name, "/", "tsne.tsv")

  drop_get(barcodesPath, overwrite = TRUE, local_file = "barcodes.tsv")
  drop_get(genesPath, overwrite = TRUE, local_file = "genes.tsv")
  drop_get(tsnePath, overwrite = TRUE, local_file = "tsne.tsv")

  barcodes =
    read_tsv("barcodes.tsv", col_names = 'Barcode')
  genes = read_tsv("genes.tsv", col_names = c('ID','Symbol'))
  tsne = read_tsv("tsne.tsv", skip= 1,
                  col_name = c('barcode','tSNE_1', 'tSNE_2','cluster_id', 'id'),
                  col_types = cols(id = col_character()))

  file.remove("barcodes.tsv")
  file.remove("genes.tsv")
  file.remove("tsne.tsv")

  return(c(barcodes, genes, tsne))
}

