# Fortran Data Compression

Sample programs demonstrating the ability to compress/decompress data on the fly
when writing to or reading from a file in Fortran using named pipes (FIFOs).

## Compilation

* Set your compiler in `Makefile` (`ifort`, `gfortran` or `f77`)
* Run `make`

## Usage

### Writing to file

Run: `./write <N> [F] [L]`<br>
where:<br>
`N` - number of lines to write to the file [required]<br>
`F` - compression filter (`gzip`, `pigz`, `lz4c`, `lzop`) [optional]<br>
`L` - compression level (from `-1` to `-9`) [optional]<br>

Data will be written to the `data.*` file.
If no compression filter is specified, data will not be compressed.

### Reading from file

Run `./read [F]`<br>
where:<br>
`F` - compression filter (use the same as for writing) [optional]<br>