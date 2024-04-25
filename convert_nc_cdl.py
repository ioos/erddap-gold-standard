from netCDF4 import Dataset


def convert_nc_to_cdl(nc_fname):
    cdl_fname = nc_fname.with_suffix(".cdl")
    if cdl_fname.exists():
        print(f"The {cdl_fname} file already exists, not overwriting it.")
        return
    with Dataset(nc_fname) as nc:
        print(f"Converting {nc_fname} to {cdl_fname}.")
        nc.tocdl(coordvars=True, data=True, outfile=cdl_fname)

def convert_cdl_to_nc(cdl_name):
    nc_fname = cdl_fname.with_suffix(".nc")
    if nc_fname.exists():
        print(f"The {nc_fname} file already exists, not overwriting it.")
        return
    print(f"Converting {cdl_fname} to {nc_fname}.")
    Dataset.fromcdl(cdl_fname)


if __name__ == "__main__":
    from pathlib import Path
    
    datasets_path = Path("datasets")
    for nc_fname in datasets_path.glob("*.nc"):
        convert_nc_to_cdl(nc_fname)
    
    for cdl_fname in datasets_path.glob("*.cdl"):
        convert_cdl_to_nc(cdl_fname)
