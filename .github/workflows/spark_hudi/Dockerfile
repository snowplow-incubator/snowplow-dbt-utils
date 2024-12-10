FROM apache/spark:3.4.0

USER root

# Install Python and required packages
RUN apt-get update && apt-get install -y \
    python3-pip \
    curl \
    rsync \
    ssh \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
RUN pip3 install --no-cache-dir \
    boto3 \
    pandas \
    pyarrow

# Create log directory
RUN mkdir -p /opt/spark/logs && \
    chmod -R 777 /opt/spark/logs && \
    mkdir -p /tmp && \
    chmod -R 777 /tmp

# Set versions
ENV HUDI_VERSION=0.13.1
ENV SCALA_VERSION=2.12
ENV SPARK_VERSION=3.4

# Download Hudi and AWS dependencies
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/org/apache/hudi/hudi-spark3.4-bundle_2.12/0.14.0/hudi-spark3.4-bundle_2.12-0.14.0.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.3.2/hadoop-aws-3.3.2.jar && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.12.262/aws-java-sdk-bundle-1.12.262.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.2/hadoop-common-3.3.2.jar

WORKDIR /opt/spark/work-dir