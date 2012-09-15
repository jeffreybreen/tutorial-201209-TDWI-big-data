#!/bin/sh

sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
sudo yum -y install git wget R

sudo ln -s /etc/default/hadoop-0.20 /etc/profile.d/hadoop.sh
cat  /etc/profile.d/hadoop.sh | sed 's/export //g' > ~/.Renviron

wget http://download2.rstudio.org/rstudio-server-0.96.331-x86_64.rpm
sudo rpm -Uvh rstudio-server-0.96.331-x86_64.rpm

sudo R --no-save << EOF
install.packages(c('RJSONIO', 'itertools', 'digest', 'Rcpp', 'plyr'), repos="http://cran.revolutionanalytics.com", INSTALL_opts=c('--byte-compile') )
EOF

wget https://github.com/downloads/RevolutionAnalytics/RHadoop/rmr_1.3.1.tar.gz
sudo R CMD INSTALL rmr_1.3.1.tar.gz
