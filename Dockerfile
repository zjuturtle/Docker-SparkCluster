FROM ubuntu:16.04
WORKDIR /app
ADD . /app
RUN mkdir local
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u131-linux-x64.tar.gz
wget https://www.apache.org/dyn/closer.lua/spark/spark-2.1.1/spark-2.1.1-bin-without-hadoop.tgz
wget http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.0.0-alpha2/hadoop-3.0.0-alpha2.tar.gz
RUN tar -zxf jdk-8u131-linux-x64.tar.gz && rm jdk-8u131-linux-x64.tar.gz && mv jdk1.8.0_131 local/jdk
RUN tar -zxf spark-2.1.1-bin-without-hadoop.tgz && rm spark-2.1.1-bin-without-hadoop.tgz && mv spark-2.1.1-bin-without-hadoop local/spark
RUN tar -zxf hadoop-3.0.0-alpha2.tar.gz && rm hadoop-3.0.0-alpha2.tar.gz && mv hadoop-3.0.0-alpha2 local/hadoop
RUN apt-get update && apt-get install -y \
        python3 \
        python3-pip \
        gcc \
        make \
        vim  \
        ssh
RUN pip3 install --upgrade pip
RUN pip3 install oss2 pymysql
RUN mv spark-env.sh /app/local/spark/conf
RUN echo export HADOOP_OPTIONAL_TOOLS=\"hadoop-aliyun\" >> /app/local/hadoop/etc/hadoop/hadoop-env.sh
ENV JAVA_HOME=/app/local/jdk
ENV PATH $JAVA_HOME/bin:/app/local/hadoop/bin:$PATH
ENV PYSPARK_PYTHON=python3
