FCC=ifort
#FCC=gfortran
#FCC=f77

all: write read

write: write.f90
	$(FCC) write.f90 -o write
read: read.f90
	$(FCC) read.f90 -o read

.PHONY : clean
clean :
	rm write read