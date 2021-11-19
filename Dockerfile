FROM java:8
# 基础镜像

MAINTAINER 448972995@qq.com
# 作者

ENV http_proxy ""
ENV https_proxy ""

RUN mkdir /test && \
    chmod -R 777 /test
# 创建/test目录，用于存放jmx脚本、jtl结果文件、html测试报告文件

ENV JMETER_VERSION=5.4
ENV JMETER_HOME=/usr/local/apache-jmeter-${JMETER_VERSION}
ENV JMETER_PATH=${JMETER_HOME}/bin:${PATH}
ENV PATH=${JMETER_HOME}/bin:${PATH}
# 设置JMeter环境变量

ADD apache-jmeter-${JMETER_VERSION}.tgz /usr/local
# 添加JMeter

RUN tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C ${JMETER_HOME} \
    sed -i '$a sampleresult.default.encoding=UTF-8' /usr/local/apache-jmeter-${JMETER_VERSION}/bin/jmeter.properties && \
    sed -i '159s/256/512/g' /usr/local/apache-jmeter-${JMETER_VERSION}/bin/jmeter
# 修改JMeter配置文件

ADD jmeter-prometheus-plugin-0.6.0.jar /usr/local/apache-jmeter-${JMETER_VERSION}/lib/ext/jmeter-prometheus-plugin-0.6.0.jar
# 添加JMeter plugin

RUN ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Taipei" > /etc/timezone