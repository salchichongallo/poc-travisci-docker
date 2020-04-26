FROM elasticsearch:7.3.0

ENV PYTHONPATH=.
ENV PYTHON_VERSION="3.8.0"
ENV SRC_DIRECTORY="/usr/share/src"

WORKDIR /usr/share/src

RUN yum update -y \
    && yum install -y gcc openssl-devel bzip2-devel libffi-devel make wget \
    && cd /usr/src/ \
    && wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar xzf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make altinstall \
    && rm /usr/src/Python-${PYTHON_VERSION}.tgz \
    && sed -i 's/-Xms1g/-Xms128m/g; s/-Xmx1g/-Xmx128m/g' /usr/share/elasticsearch/config/jvm.options

ADD requirements.txt ${SRC_DIRECTORY}

RUN cd ${SRC_DIRECTORY} \
    && python3.8 -m pip install --no-cache-dir -r requirements.txt

COPY . ${SRC_DIRECTORY}

USER elasticsearch

CMD ["ptw", "tests/functional", "--", "-s"]
