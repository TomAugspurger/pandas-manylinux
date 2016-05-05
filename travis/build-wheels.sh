#!/bin/bash
set -e -x

# Directory to store wheels
mkdir unfixed_wheels

# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ ${PYBIN} != *"26"* ]] && [[ ${PYBIN} != *"33"* ]]; then
        ${PYBIN}/pip install -r /io/pandas/ci/requirements_dev.txt
        ${PYBIN}/pip wheel /io/pandas/ -w wheelhouse/
    else
        echo "skipping ${PYBIN}"
    fi
done


for whl in wheelhouse/pandas*.whl; do
    if [[ ${whl} == *"pandas"* ]]; then
        auditwheel repair $whl -w /io/wheelhouse/
    fi
done

for PYBIN in /opt/python/*/bin/; do
    if [[ ${PYBIN} != *"26"* ]] && [[ ${PYBIN} != *"33"* ]]; then
         ${PYBIN}/pip install pandas --no-index -f /io/wheelhouse
        (cd $HOME; ${PYBIN}/nosetests pandas)
    else
        echo "skipping ${PYBIN}"
    fi
done

