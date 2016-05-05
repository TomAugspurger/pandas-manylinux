FROM quay.io/pypa/manylinux1_x86_64
COPY . /io/ && mkdir /io/wheelhouse
RUN git clone https://github.com/pydata/pandas /io/pandas
RUN cd /io/pandas && git checkout v0.18.1
RUN chmod +x /io/travis/build-wheels.sh
RUN /io/travis/build-wheels.sh

