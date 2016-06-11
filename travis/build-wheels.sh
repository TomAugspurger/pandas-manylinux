#!/bin/bash
set -e -x

git clone https://github.com/pydata/pandas /io/pandas
cd /io/pandas
git checkout v0.18.1

set PYBIN=/opt/python/${PYVER}/bin
# Compile wheels
echo "building for ${PYBIN}"
${PYBIN}/pip install -r /io/pandas/ci/requirements_dev.txt
${PYBIN}/pip wheel /io/pandas/ -w wheelhouse/

for whl in wheelhouse/pandas*.whl; do
    auditwheel repair $whl -w /io/wheelhouse/
done

${PYBIN}/pip install pandas --no-index -f /io/wheelhouse
cd $HOME; ${PYBIN}/nosetests pandas

