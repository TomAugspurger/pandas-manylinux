#!/bin/bash
set -e -x

# Manylinux, openblas version, lex_ver
source /io/common_vars.sh

# Directory to store wheels
rm_mkdir unfixed_wheels

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    ${PYBIN}/pip install -r /io/dev-requirements.txt
    ${PYBIN}/pip wheel /io/ -w wheelhouse/
done


for whl in wheelhouse/*.whl; do
    auditwheel repair $whl -w /io/wheelhouse/
done

for PYBIN in /opt/python/*/bin/; do
    ${PYBIN}/pip install python_manylinux_demo --no-index -f /io/wheelhouse
    (cd $HOME; ${PYBIN}/nosetests pymanylinuxdemo)
done
