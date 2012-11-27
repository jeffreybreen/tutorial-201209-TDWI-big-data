#!/bin/sh

sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-7.noarch.rpm
sudo yum -y install git wget R

sudo ln -s /etc/default/hadoop-0.20-mapreduce /etc/profile.d/hadoop.sh 
cat  /etc/profile.d/hadoop.sh | sed 's/export //g' > ~/.Renviron

wget http://download2.rstudio.org/rstudio-server-0.97.173-x86_64.rpm

# using yum update because of dependancies
sudo yum -y install --nogpgcheck rstudio-server-0.97.173-x86_64.rpm
rm rstudio-server*

sudo R --no-save << EOF
install.packages( c('Rcpp','RJSONIO', 'digest', 'functional','stringr'), repos="http://cran.revolutionanalytics.com", INSTALL_opts=c('--byte-compile') )
EOF

# Download the RHadoop Git Repo for rmr2
git clone https://github.com/RevolutionAnalytics/RHadoop.git
cd RHadoop

# rmr-2.0.0 & rmr-2.0.1 appears to have installation dependances issues 
# Based on Antonio's comments in the Hadoop Google Group, these issues are resolved in the next rmr2 release.

# For now you need to use the development branch
git checkout origin/dev
sudo R CMD INSTALL rmr2/pkg
