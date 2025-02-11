FROM python:3.12
RUN apt-get update && apt-get --yes install libhdf5-serial-dev netcdf-bin libnetcdf-dev
RUN pip install uv
RUN uv pip install --system netCDF4 h5netcdf xarray