FROM quay.io/pypa/manylinux1_x86_64
COPY . /io/ && mkdir /io/wheelhouse
RUN git clone https://github.com/pydata/pandas /io/pandas
VOLUME ["/io/wheelhouse"]
RUN chmod +x /io/travis/build-wheels.sh
WORKDIR /io/pandas
ENV TAG v0.18.1

RUN git checkout $TAG && /io/travis/build-wheels.sh
