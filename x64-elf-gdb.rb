require 'formula'

class X64ElfGdb < Formula
  homepage 'http://gcc.gnu.org'
  url 'http://ftp.gnu.org/gnu/gdb/gdb-7.6.tar.bz2'
  sha256 'a410e8f35ee70cce83dbbf1da9e2a8373f271ac0e4b71db4336ae293fc7bdf1b'

  depends_on 'x64-elf-binutils'
  depends_on 'x64-elf-gcc'

  def install
    mkdir 'build' do
      system '../configure', '--target=x86_64-pc-linux', "--prefix=#{prefix}",'--disable-werror'
      system 'make'
      system 'make install'
      FileUtils.rm_rf share/"locale"
      FileUtils.mv lib, libexec
    end
  end

  def patches
    # When debugging 64-bit kernels via qemu, gdb has a tough time on the switch
    # to long mode, and this patch helps it out by making sure that gdb keeps up
    # with the switches in architecture that qemu makes
    DATA
  end
end
