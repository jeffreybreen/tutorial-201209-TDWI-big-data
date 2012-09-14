Configuring Cloudera's Demo VM for the Tutorial
===============================================


Download Cloudera's Demo VM
----------------------------

We'll use the latest CDH3, but everything should work with CDH4 as well.

https://ccp.cloudera.com/display/SUPPORT/Cloudera%27s+Hadoop+Demo+VM

Configure the VM
----------------

With the VM turned off, now is the time to fiddle with RAM, etc. settings.

With VMware, I had some problems using the default NAT, so I switched to 
Bridged networking.

Once booted, you will want to install VMware Tools and take advantage
of shared folders to access your PC's file system:

```{bash}
$ sudo mkdir /mnt/vmware
$ sudo mount /dev/hda /mnt/vmware
$ tar zxf /mnt/vmware/VMwareTools-8.4.7-683826.tar.gz 
$ cd vmware-tools-distrib/
$ sudo ./vmware-install.pl 

$ ln -s /mnt/hgfs/projects/tutorial-201209-TDWI-big-data/ ~/.
```

Next, add the EPEL repository so we can easily install some utilities and R:

```{bash}
$ sudo rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
$ sudo yum -y install git wget R
```

Set Hadoop environment variables so R and RStudio can find them:

**CDH3:**
```{bash}
$ sudo ln -s /etc/default/hadoop-0.20 /etc/profile.d/hadoop.sh
$ cat  /etc/profile.d/hadoop.sh | sed 's/export //g' > ~/.Renviron
```

**CDH4:**
```{bash}
$ sudo ln -s /etc/default/hadoop-0.20-mapreduce /etc/profile.d/hadoop.sh
$ cat /etc/profile.d/hadoop.sh | sed 's/export //g' > ~/.Renviron
```


Download and install RStudio
----------------------------

Current download link and instructions at http://rstudio.org/download/server

```{bash}
$ wget http://download2.rstudio.org/rstudio-server-0.96.331-x86_64.rpm
$ sudo rpm -Uvh rstudio-server-0.96.331-x86_64.rpm
```

Should start up and be accessible from browser via port 8787 (_e.g.,_ http://192.168.1.132:8787/)


Download and install RHadoop and other packages
-----------------------------------------------

First, get the prerequisites:

```{r}
$ sudo R
[...]
> install.packages( c('RJSONIO', 'itertools', 'digest', 'Rcpp'), 
repos='http://cran.revolutionanalytics.com')
```

Optionally install any other R packages you might use, like plyr:

```{r}
> install.packages( c('plyr'), dependencies=T, repos='http://cran.revolutionanalytics.com')
```

Then download and install RHadoop's rmr package:

```{bash}
$ wget https://github.com/downloads/RevolutionAnalytics/RHadoop/rmr_1.3.1.tar.gz
$ sudo R CMD INSTALL rmr_1.3.1.tar.gz
```



Apache Whirr 0.8

http://apache.mirrors.pair.com/whirr/whirr-0.8.0/whirr-0.8.0.tar.gz

