# description
Doofenshmirtz is an assembler for a parallel CPU architecture that runs on an FPGA. The language allows you to define specialized cores and the programs that run on them.

# build
For building on linux, you can use the install script provided in [nt33](https://github.com/ve5li/nt33) to install the entire toolchain. Simply clone the repository and execute the installer as such:
```
git clone https://github.com/ve5li/nt33
cd nt33/untility
./install.sh
```

# usage
Source files can be passed as command line arguments, the order does not matter. The output file will be called 'output.uni' by default but you can specify another name with the ```-o``` flag. If there seems to be an error in the compiler itself, you can turn on debug mode with the ```-d``` flag.

For an example you can check out [this file](https://github.com/vE5li/nt33/blob/master/example/main.asm) in [nt33](https://github.com/ve5li/nt33).
