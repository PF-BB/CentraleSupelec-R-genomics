TP4
===

Cette session sera consacrée à l'interprétation biologique des résultats. Une des analyses possible est d'effectuer des analyses d'enrichissement à partir d'une liste de gènes d'intérêt. On appelle aussi cette étape 'analyse fonctionnelle'. 

Plusieurs bases de données publiques permettent d'annoter une liste de gènes. Chez l'humain, on citera surtout : 

* `Gene Ontology <geneontology.org/>`_
* `KEGG <www.genome.jp/kegg/>`_
* `Reactome <www.reactome.org/>`_
* Les signatures oncogéniques du Broad Institute : `catalogue C6 <http://software.broadinstitute.org/gsea/msigdb/collections.jsp#C6>`_

Le test exact de Fisher est généralement utilisé pour ce type d'analyse. Différents outils en ligne sont disponibles : 

* `DAVID <://david.ncifcrf.gov/>`_
* `GSEA - Investigate Gene Sets <http://software.broadinstitute.org/gsea/msigdb/annotate.jsp>`_
* `AMIGO <http://amigo.geneontology.org/amigo>`_ 

Il existe aussi des packages R capables de réaliser ces analyses. Pour ce TP, nous utiliserons la package `clusterProfiler <http://bioconductor.org/packages/release/bioc/vignettes/clusterProfiler/inst/doc/clusterProfiler.html>`_.


* Présentation de clusterProfiler :   :download:`slides  <TP4/TP4.pptx>`
* Exercices :   :download:`exercices  <TP4/TP4_exercides.pdf>`
* Données à télécharger :  :download:`TP4_data.zip <TP4/data.zip>`
