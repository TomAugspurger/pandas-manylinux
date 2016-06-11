#!/bin/bash
set -e -x

git clone https://github.com/pydata/pandas
cd pandas
git checkout v0.18.1

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ ${PYBIN} != *"26"* ]] && [[ ${PYBIN} != *"33"* ]]; then
        echo "building for ${PYBIN}"
        ${PYBIN}/pip install -r ci/requirements_dev.txt
        ${PYBIN}/pip wheel --no-deps -w wheelhouse/ .
    else
        echo "skipping ${PYBIN}"
    fi
done


for whl in wheelhouse/pandas*.whl; do
    if [[ ${whl} == *"pandas"* ]]; then
        auditwheel repair $whl -w /io/wheelhouse/
    fi
done
