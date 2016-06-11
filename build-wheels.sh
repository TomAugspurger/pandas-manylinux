# Compile wheels
for PYBIN in /opt/python/*/bin; do
    if [[ ${PYBIN} != *"26"* ]] && [[ ${PYBIN} != *"33"* ]]; then
        ${PYBIN}/pip install -r /src/pandas/ci/requirements_dev.txt
        ${PYBIN}/pip wheel /src/pandas/ -w /wheelhouse/
    else
        echo "skipping ${PYBIN}"
    fi
done


for whl in /wheelhouse/pandas*.whl; do
    if [[ ${whl} == *"pandas"* ]]; then
        auditwheel repair $whl -w /wheelhouse/
    fi
done
