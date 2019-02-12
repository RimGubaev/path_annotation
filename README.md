# path_annotation
Рим Губаев, 2017

Скрипт path_annotation.r предназначен для того, чтобы присвоить транскриптам *Lentinula edodes*, собранным de novo с помощью ассемблера Trinity, названия их продуктов и распределить собранные транскрипты по метаболическим путям *Agaricus bisphorus*, а также всем известным путям в базе данных KEGG. С помощью данного скрипта можно присвоить транскриптам *L. edodes* соответствующие идентификационные номера генов *Penicillium rubens*, для дальнейшего функционального анализа диференциально экспрессирующихся генов в BioCyc.
Для того, чтобы присвоить названия продуктов, собранным *de novo* транскриптам других видов, а также произвести их классификацию по метаболическим путям с помощью данного скрипта нужно подготовить входные данные в соответствии с примерами, представленными в директории ./path_annotation и описанными ниже.

Входные данные:

1) Таблицы abi_blast, blasted_pen, полученные с помощью BLAST+. Каждая таблица содержит номер аминокислотной последовательности близкородственного вида, которой соответствует идентификационный номер гомологичного продукта собранного de novo транскрипта. В данном случае был проведен поиск гомологов продуктов собранных транскриптов *L. edodes* среди аминокислотных последователностей *A. bisphorus* (ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/300/575/GCF_000300575.1_Agabi_varbisH97_2/GCF_000300575.1_Agabi_varbisH97_2_protein.faa.gz) и *P. rubens* (ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/226/395/GCF_000226395.1_PenChr_Nov2007/GCF_000226395.1_PenChr_Nov2007_protein.faa.gz).

2) Таблицы abi_gene_protein, pen_prot, содержащие номера генов, кодирующих аминокислотные последовательности *A. bisphorus* и *P.rubens*. Таблицы были получены с помощью базы данных UniProt.

3) Таблица abi_protein_names, содержащая названия белков аминокислотных последовательностей *A. bisphorus*. Таблица была получена с помощью базы данных UniProt.

4) Таблица abi_pathway_gene, содержащая идентификационные номера генов близкородственного вида (*A. bisphorus*) с присвоенными номерами метаболических путей. Получена c помощью KEGG API (http://rest.kegg.jp/link/abv/pathway).

5) Таблица abi_pathway_name, содержащая названия и номера путей для близкородственного вида (*A. bisphorus*). Получена c помощью KEGG API (http://rest.kegg.jp/list/pathway/abv).

6) Таблица KAAS, содержащая номера собранных транскриптов с присвоенными k-номерами базы данных KEGG Orthology. Таблица была получена с помощью KEGG Automatic Annotation Server (http://www.genome.jp/tools/kaas).

7) Таблица ko_map, содержащая k-номера базы данных KEGG Ontology с присвоенными номерами метаболических путей KEGG Orthology. Получена c помощью KEGG API (http://rest.kegg.jp/link/pathway/ko).

Выполняемые операции:

На первом этапе собранным транскриптам с соответствующими номерами белков присваиваются номера генов *A. bisphorus*. Затем, используя идентификационные номера генов *A. bisphorus*, а также k-номера, собранные транскрипты классифицируются по метболическим путям в соответствии с данными, предстваленными в KEGG (http://rest.kegg.jp/link/abv/pathway, http://rest.kegg.jp/list/pathway/abv, http://rest.kegg.jp/link/pathway/ko).
Используя идентификационный номера белковых последовательностей близкородственного вида (*A. bisphorus*)  собранным транскриптам присваиваются названия продуктов.
Для проведения дальнейшего анализа дифференциально экспрессирующихся генов с помощью ресурса BioCyc собранным транскриптам с соответствующими номерами белков присваиваются номера генов *P. rubens*.

Все манипуляции, производимые с входными данными, описаны непосредственно в R скрипте, в коментариях к командам (строки, начинающиеся с символа "#").

Выходные данные:

1. Таблица Led_products.csv, содержащая идентификационные номера собранных транскриптов с соответствующими идентификацонными номерами белков известного вида (*A. bisphorus*) и их названием.

2. Таблица Led_Abi_pathways.csv, содержащая идентификационные номера собранных транскриптов с присвоенными идентификационными номерами путей для известного вида (*A. bisphorus*) и их названием.

3. Таблица Pru_transcript_to_loci.csv, содержащая идентификационные номера собранных транскриптов, которым присвоены идентификационные номера генов известного вида (*P. rubens*).

4. Таблица Led_KEGG_pathways.csv, содержащая идентификационные номера собранных транскриптов, которым присвоены идентификационные номера путей KEGG.

Email: rimgubaev@gmail.com

Rim Gubaev, 2017

The script path_annotation.r is intended to assign the names of their products to the *Lentinula edodes* transcripts assembled *de novo* using Trinity assembler and bin the collected transcripts to the metabolic pathways of *Agaricus bisphorus*, as well as to all known paths in the KEGG database. Using this script, one can assign *L. edodes* transcripts corresponding to identification numbers of genes of *Penicillium rubens* for further functional analysis of differentially expressed genes in BioCyc. In order to assign the names of products assembled by *de novo* transcripts of other types as well as to classify them by metabolic paths using this script, you need to prepare the input data in accordance with the examples presented in the ./path_annotation directory and described below.

Input data:

1) Tables abi_blast, blasted_pen, obtained using BLAST+. Each table contains the amino acid sequence number of a closely related species, which corresponds to the identification number of the homologous product of the *de novo* assembled transcript. In this case, a search was conducted for homologs of the products of the assembled *L. edodes* transcripts among the amino acid sequences of *A. bisphorus* (ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/300/575/GCF_000300575.1_Agabi_varbisH97_2/ GCF_000300575.1_Agabi_varbisH97_2_protein.faa.gz) and *P. rubens* (ftp://ftp.ncbi.nlm.nih.gov/genomes/Al/GCF/000/226/395/GCF_000226395.1_PenChr_Nov2007/GCF_00022/9595/GCF_000226395.1_PenChr_Nov2007/GCF_00022/9595/GCF_000226395.1_PenCr_NV/NG200/GCF/CG/AFV/AIN/CF_00022/GRF_000226395.1_PenCrc).

2) Tables abi_gene_protein, pen_prot, containing the numbers of genes encoding the amino acid sequences of *A. bisphorus* and *P. rubens*. The tables were obtained using the UniProt database.

3) Table abi_protein_names, containing the protein names of the amino acid sequences of *A. bisphorus*. The table was obtained using the UniProt database.

4) Table abi_pathway_gene, containing identification numbers of genes of a closely related species (*A. bisphorus*) with assigned numbers of metabolic pathways. Obtained using the KEGG API (http://rest.kegg.jp/link/abv/pathway).

5) Table abi_pathway_name, containing the names and numbers of paths for a closely related species (*A. bisphorus*). Obtained using the KEGG API (http://rest.kegg.jp/list/pathway/abv).

6) The KAAS table containing the numbers of the collected transcripts with the assigned k-numbers of the KEGG Orthology database. The table was obtained using KEGG Automatic Annotation Server (http://www.genome.jp/tools/kaas).

7) A ko_map table containing the KEGG Ontology database k-numbers with assigned KEGG Orthology metabolic path numbers. Obtained using the KEGG API (http://rest.kegg.jp/link/pathway/ko).

Operations performed:

At the first stage the assembled transcripts with the corresponding protein numbers are assigned gene numbers of *A. bisphorus*. Then, using the identification numbers of *A. bisphorus* genes, as well as the k-numbers, the collected transcripts are classified by metbolic paths in accordance with the data presented in KEGG (http://rest.kegg.jp/link/abv/pathway, http://rest.kegg.jp/list/pathway/abv, http://rest.kegg.jp/link/pathway/ko). Using the identification number of protein sequences of a closely related species (*A. bisphorus*), product names are assigned to the assembled transcripts. For further analysis of differentially expressed genes using the BioCyc resource, the assembled transcripts with the corresponding protein numbers are assigned gene numbers of *P. rubens*.

All manipulations made with the input data are described directly in the R script within the comments to the commands (lines starting with the "#" character).

Output:

1) Table Led_products.csv containing the identification numbers of the assembled transcripts with the corresponding identification numbers of proteins of a known species (*A. bisphorus*) and their name.

2) Table Led_Abi_pathways.csv, containing the identification numbers of the collected transcripts with the assigned path identification numbers for a known species (*A. bisphorus*) and their name.

3) Table Pru_transcript_to_loci.csv, containing the identification numbers of the collected transcripts, which are assigned identification numbers of genes of a known species (*P. rubens*).

4) Table Led_KEGG_pathways.csv containing the identification numbers of the collected transcripts to which the identification numbers of the KEGG paths are assigned.

Email: rimgubaev@gmail.com
