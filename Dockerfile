FROM ubuntu:16.04
WORKDIR /app
ADD . /app
RUN apt-get update && apt-get install -y \
        python3 \
        python3-pip \
        gcc \
        make \
        vim  \
        ssh  \
        wget
RUN mkdir local
RUN wget -O jdk.tar.gz --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u131-linux-x64.tar.gz
RUN wget -O spark.tgz https://www.apache.org/dyn/closer.lua/spark/spark-2.1.1/spark-2.1.1-bin-without-hadoop.tgz
RUN wget -O hadoop.tar.gz http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.0.0-alpha2/hadoop-3.0.0-alpha2.tar.gz
RUN tar -zxf jdk.tar.gz && rm jdk.tar.gz && mv jdk1.8.0_131 local/jdk
RUN tar -zxf spark.tgz && rm spark.tgz && mv spark-2.1.1-bin-without-hadoop local/spark
RUN tar -zxf hadoop.tar.gz && rm hadoop.tar.gz && mv hadoop-3.0.0-alpha2 local/hadoop
RUN pip3 install --upgrade pip
RUN pip3 install oss2 pymysql
RUN mv spark-env.sh /app/local/spark/conf
RUN echo export HADOOP_OPTIONAL_TOOLS=\"hadoop-aliyun\" >> /app/local/hadoop/etc/hadoop/hadoop-env.sh
ENV JAVA_HOME=/app/local/jdk
ENV PATH $JAVA_HOME/bin:/app/local/hadoop/bin:$PATH
ENV PYSPARK_PYTHON=python3
