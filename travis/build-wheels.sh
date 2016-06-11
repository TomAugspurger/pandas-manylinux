#!/bin/bash
set -e -x

echo ${PYVER}

git clone https://github.com/pydata/pandas
cd pandas
# git checkout v0.18.1

PYBIN=/opt/python/${PYVER}/bin
# Compile wheels
echo "building for ${PYBIN}"
${PYBIN}/pip install -r ci/requirements_dev.txt
${PYBIN}/pip wheel --no-deps -w wheelhouse/ .

for whl in wheelhouse/pandas*.whl; do
    auditwheel repair $whl -w /io/wheelhouse/
done

${PYBIN}/pip install pandas --no-index -f /io/wheelhouse
cd $HOME; ${PYBIN}/nosetests pandas

