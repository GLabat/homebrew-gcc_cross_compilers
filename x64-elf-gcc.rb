require 'formula'

class X64ElfGcc < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftpmirror.gnu.org/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  mirror 'http://ftp.gnu.org/gnu/gcc/gcc-4.8.0/gcc-4.8.0.tar.bz2'
  sha256 'b037fe5132b71ecad2ea7141ec92292b5d32427bf90fd90cde432b1d5abacc2c'

  depends_on 'gmp'
  depends_on 'libmpc'
  depends_on 'mpfr'
  depends_on 'x64-elf-binutils'

  def install
    binutils = Formula.factory 'x64-elf-binutils'

    ENV['CC'] = '/usr/local/bin/gcc-4.8'
    ENV['CXX'] = '/usr/local/bin/g++-4.8'
    ENV['CPP'] = '/usr/local/bin/cpp-4.8'
    ENV['LD'] = '/usr/local/bin/gcc-4.8'
    ENV['PATH'] += ":#{binutils.prefix/"bin"}"

    mkdir 'build' do
      system '../configure', '--disable-nls', '--target=x86_64-elf','--disable-werror',
                             "--prefix=#{prefix}",
                             "--enable-languages=c",
                             "--without-headers"
      system 'make all-gcc'
      system 'make install-gcc'
      FileUtils.ln_sf binutils.prefix/"x86_64-elf", prefix/"x86_64-elf"
      system 'make all-target-libgcc'
      system 'make install-target-libgcc'
      FileUtils.rm_rf share/"man"/"man7"
    end
  end
end
