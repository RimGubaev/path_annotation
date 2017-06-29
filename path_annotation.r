# Устанавливаем рабочую директорию
setwd("~/your/working/directory/")

############################################
# 1 Группируем собранные транскрипты L. edodes (Led) в пути представленные в KEGG для A. bisporus, а также пути KEGG для всех организмов
############################################

# Загружаем выходные данные Blastx, где собранным транскриптам Led были присвоены номера аминокислотных последовательностей A. bisporus (Abi)
blast <- read.csv(file = "abi_blast", sep = "\t", header = F)
blast <- data.frame(assembled_transcript=blast$V1, Abi_protein=blast$V2)

# Загружаем таблицу номер гена - номер белка Abi
genes <- read.csv(file = "abi_gene_protein", sep = "\t", header = F)
genes <- data.frame(Abi_gene=genes$V1, Abi_protein=genes$V2) 

# Присваеваем собранным транскриптам Led номер белка и гена Abi
transcript_protein_gene <- merge(x=genes, y=blast, by = "Abi_protein")

# Загружаем файл с генами Abi, с соответствующими номерами метаболических путей (http://rest.kegg.jp/link/abv/pathway)
paths <- read.csv(file = "abi_pathway_gene", sep = "\t", header = F)
paths <- data.frame(path_num=paths$V1, Abi_gene=paths$V2)

# Совмещаем пути Abi с таблицей "транскрипт Led - белок Abi - ген Abi"
paths <- merge(x=transcript_protein_gene, y=paths, by = "Abi_gene")

# Загружаем файл, содержащий названия путей Abi (http://rest.kegg.jp/list/pathway/abv) 
path_names <- read.csv(file = "abi_pathway_name", sep = "\t", header = F) 
path_names <- data.frame(path_num=path_names$V1, path_name=path_names$V2)

# Записываем csv файл, содержащий транскрипты Led, рапределенные по метаболическим путям Abi
Led_pathways <- merge(x=path_names, y=paths, by = "path_num")
write.csv(x = Led_pathways[ ,c(5,1,2)], file = "Led_Abi_pathways.csv", row.names = F)

# Загружаем выходные данные KAAS, где собранным транскриптам Led были присвоены номера ортологичных генов из базы данных KEGG
Led_KEGG_pathways <- read.csv(file = "KAAS", sep = "\t", header = F)
colnames(Led_KEGG_pathways) <- c("locus","ko") 

ko_map <- read.csv(file = "ko_map", sep = "\t", header = F)
colnames(ko_map) <- c("ko","map")

Led_KEGG_pathways <- merge(Led_KEGG_pathways, ko_map, by = "ko")
Led_KEGG_pathways <- Led_KEGG_pathways[ ,c(2,1,3)]

map_names <- read.csv(file = "KEGG_pathway_name", sep = "\t", header = F)
colnames(map_names) <- c("map","path_name")

Led_KEGG_pathways <- merge(Led_KEGG_pathways, map_names, by = "map")

# Записываем csv файл, содержащий транскрипты Led, рапределенные по метаболическим путям Abi
write.csv(x = Led_KEGG_pathways[ ,-3], file = "Led_KEGG_pathways.csv", row.names = F)

############################################
# 2 Присваеваем транскриптам Led номера белков и названия продуктов генов, согласно аннотации по Abi и БД Fungi
############################################

# Загружаем файл, содержащий названия белков Abi
Abi_products <- read.csv(file = "abi_protein_names", sep = "\t", header = F)
Abi_products <- data.frame(Abi_protein=Abi_products$V1, Abi_product=Abi_products$V2)

# Совмещаем названия белков Abi с собранными транскриптами Led
Led_products <- merge(x = Abi_products, y = blast, by = "Abi_protein")

# Загружаем файл (созданный способом описанным выше), содержащий номера и названия белков из БД Fungi, присвоенных Led
Led_fungi_products <- read.csv(file = "fungi_annotated", sep = ",", header = T)

# Записываем в файл аннотацию транскриптов Led, сделланную по Abi и БД Fungi, 
Led_products <- merge(x=Led_products, y=Led_fungi_products, by = "assembled_transcript", all = T)
write.csv(x = Led_products, file = "Led_products.csv", row.names = F)

############################################
# 3 Присваеваем собранным транскриптам Led идентификационные номера белков и генов P. rubens (Pru)
############################################

# Загружаем таблицу "транскрипт Led - номер аминокислотной последовательности Pru"
Pru_products <- (read.csv(file = "Blasted_pen", sep = "\t", header = F))
Pru_products <- data.frame(assembled_transcript=Pru_products$V1, Pru_protein_num=Pru_products$V2)

# Загружаем таблицу "номер аминокислотной последовательности Pru - номер гена Pru"
Pru_prot_to_loci <- (read.csv(file = "pen_prot", sep = "\t", header = T))
Pru_prot_to_loci <- data.frame(Pru_protein_num=Pru_prot_to_loci$Protein.product, Pru_locus=Pru_prot_to_loci$Locus.tag)

# Записываем таблицу "транскрипт Led - номер гена Pru"
Pru_transcript_to_loci <- merge(x=Pru_products, y=Pru_prot_to_loci, by = "Pru_protein_num")
write.csv(x = Pru_transcript_to_loci[ ,c(2,3)], "Pru_transcript_to_loci.csv", row.names = F)
