FROM quay.io/pypa/manylinux1_x86_64
ENV TAG v0.18.1

RUN mkdir /src && mkdir /wheelhouse
RUN git clone https://github.com/pydata/pandas /src/pandas && cd /src/pandas && git checkout $TAG

COPY build-wheels.sh /src/pandas
RUN chmod +x /src/pandas/build-wheels.sh
WORKDIR /src/pandas

# RUN sh build-wheels.sh
CMD ["sh", "build-wheels.sh"]
