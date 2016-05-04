FROM quay.io/pypa/manylinux1_x86_64
COPY . /io/
RUN chmod +x /io/travis/build-wheels.sh
RUN /io/travis/build-wheels.sh

