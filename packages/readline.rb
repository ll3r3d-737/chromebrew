require 'package'

class Readline < Package
  description 'The GNU Readline library provides a set of functions for use by applications that allow users to edit command lines as they are typed in.'
  homepage 'http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html'
  version '6.3p8-1'
  source_url 'https://ftpmirror.gnu.org/gnu/readline/readline-6.3.tar.gz'
  source_sha256 '56ba6071b9462f980c5a72ab0023893b65ba6debb4eeb475d7a563dc65cafd43'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/readline-6.3p8-1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'bb0ad30615c12e9559fcc7158a87d76cda4f216b4ccd79e0434064cd071e197c',
     armv7l: 'bb0ad30615c12e9559fcc7158a87d76cda4f216b4ccd79e0434064cd071e197c',
       i686: 'a3015ee22758606e1bb85e4add62335bb6ce36da2cb99805da051609b04843c6',
     x86_64: '77227d45ffa89f861ddbc7dba8433c0a8401333ab527d11c0c809f81de53d567',
  })

  def self.build
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-001 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-002 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-003 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-004 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-005 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-006 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-007 -P readline-6.3-patches"
    system "wget -r -N -nd --no-parent ftp://ftp.gnu.org/gnu/readline/readline-6.3-patches/readline63-008 -P readline-6.3-patches"
    # system "for i in readline-6.3-patches/*.sig; do gpg $i; done"
    system "for i in readline-6.3-patches/readline63-???; do patch < $i; done"

    system "CC='gcc' ./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --disable-static --with-curses"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    system "ln", "-sf", "/#{ARCH_LIB}/libreadline.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libreadline.so.6"
    system "ln", "-sf", "/#{ARCH_LIB}/libreadline.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libreadline.so.6.3"
    system "ln", "-sf", "/#{ARCH_LIB}/libreadline.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libreadline.so"
    system "ln", "-sf", "/#{ARCH_LIB}/libhistory.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libhistory.so.6"
    system "ln", "-sf", "/#{ARCH_LIB}/libhistory.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libhistory.so.6.3"
    system "ln", "-sf", "/#{ARCH_LIB}/libhistory.so.6.3", "#{CREW_DEST_LIB_PREFIX}/libhistory.so"
  end
end
