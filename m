Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF31D62B9
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 May 2020 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgEPQsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 May 2020 12:48:51 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:21802
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgEPQsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 May 2020 12:48:50 -0400
X-Greylist: delayed 963 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 May 2020 12:48:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lechevalier.se; s=20191106;
        h=content-transfer-encoding:content-type:mime-version:subject:message-id:to:
         from:date:from;
        bh=QY3F3VJ6UMlg/OSxyBzGLx10kzCEp80DcUZK5+irh68=;
        b=b6mtNlFZVaXoJw+LdrPt8DLyT9VN9oumZK0ABctZ6Cn05VHkmF5m9LMhOdYhPBDS1QO+7ycLJdP9H
         LBq6bom0lsr4U/sM+1PyYFNcsYmKgbi3IcvHfIkbOl/Rs47PJimRDcaurzEZBohWARcKANC/vxZyez
         Ri0OHxWm3Dp27etkrvJtlV7JM22cF8ZhyzyWAqoM/16mEyyvE5mgrNUuWSRycqwOt7fFTAlkdhzG1j
         5jingMiOSutvuobe2DiSyj83j8uxRK8ZkIjsWsRiP6QiUg45KgBD00KuMI4PKvXYdTq8+0gwO66bkl
         dG+jjP5rHWyhdxIKe6NO3jCnVS9m/Ow==
X-HalOne-Cookie: 87b3b756f6234bcc6ac4dde62ab288631668e674
X-HalOne-ID: df4776b5-9792-11ea-9551-d0431ea8a290
Received: from [192.168.0.126] (h-131-138.a357.priv.bahnhof.se [81.170.131.138])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id df4776b5-9792-11ea-9551-d0431ea8a290;
        Sat, 16 May 2020 16:32:45 +0000 (UTC)
Date:   Sat, 16 May 2020 18:32:45 +0200 (GMT+02:00)
From:   A L <mail@lechevalier.se>
To:     linux-btrfs@vger.kernel.org
Message-ID: <b3f880.1227fea8.1721e54aeeb@lechevalier.se>
Subject: cp -a leaves some compressed data.
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Mailer: R2Mail2
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear all,

I did some testing on copying files with the +c (compression) xattrs set.

As far as I can tell, 'cp - a' only sets any xattrs after copying the data.=
 This means that a compressed file should end up without compression, but s=
till with the +c xattr set. However this is not entirely true. Some small a=
mount of data is still getting compressed.=20

I would like to understand why.=20

Here is a small test case:

File test-comp.sh:
#!/bin/bash
mkdir -p test test/a test/b
chattr +c test/a
touch test/a/foo
dd if=3D/dev/zero of=3Dtest/a/foo bs=3D1024 count=3D1M
cp -a test/a test/b/

Now check the output with the compsize tool:

# compsize test/a
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL        3%       32M         1.0G         1.0G
zlib         3%       32M         1.0G         1.0G

# compsize test/b
Type       Perc     Disk Usage   Uncompressed Referenced
TOTAL       63%      652M         1.0G         1.0G
none       100%      640M         640M         640M
zlib         3%       12M         384M         384M
/mnt/test #=20


As you see, the copy ended up with 384M compressed data. When running this =
test several times, the amount changes between runs.

I did an strace too see what was going on. It is clear that the setfxattr()=
 is called after all the data was written to the file.=20



# strace -s8 -xx cp -av a/foo b/
execve("\x2f\x62\x69\x6e\x2f\x63\x70", ["\x63\x70", "\x2d\x61\x76", "\x61\x=
2f
\x66\x6f\x6f", "\x62\x2f"], 0x7fff9d6acb68 /* 44 vars */) =3D 0
brk(NULL)                               =3D 0x556e7cf7c000
access("\x2f\x65\x74\x63\x2f\x6c\x64\x2e\x73\x6f\x2e\x70\x72\x65\x6c\x6f\x6=
1\
x64", R_OK) =3D -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "\x2f\x65\x74\x63\x2f\x6c\x64\x2e\x73\x6f\x2e\x63\x61\x63\=
x6
8\x65", O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D122526, ...}) =3D 0
mmap(NULL, 122526, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f5f04d8b000
close(3)                                =3D 0
openat(AT_FDCWD, "\x2f\x6c\x69\x62\x36\x34\x2f\x6c\x69\x62\x61\x63\x6c\x2e\=
x7
3\x6f\x2e\x31", O_RDONLY|O_CLOEXEC) =3D 3
read(3, "\x7f\x45\x4c\x46\x02\x01\x01\x00"..., 832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D39240, ...}) =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x
7f5f04d89000
mmap(NULL, 41568, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f5f04d=
7e00
0
mmap(0x7f5f04d80000, 20480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_=
DE
NYWRITE, 3, 0x2000) =3D 0x7f5f04d80000
mmap(0x7f5f04d85000, 8192, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, =
3,
 0x7000) =3D 0x7f5f04d85000
mmap(0x7f5f04d87000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
DE
NYWRITE, 3, 0x8000) =3D 0x7f5f04d87000
close(3)                                =3D 0
openat(AT_FDCWD, "\x2f\x6c\x69\x62\x36\x34\x2f\x6c\x69\x62\x61\x74\x74\x72\=
x2
e\x73\x6f\x2e\x31", O_RDONLY|O_CLOEXEC) =3D 3
read(3, "\x7f\x45\x4c\x46\x02\x01\x01\x00"..., 832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D26720, ...}) =3D 0
mmap(NULL, 29016, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f5f04d=
7600
0
mmap(0x7f5f04d78000, 12288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_=
DE
NYWRITE, 3, 0x2000) =3D 0x7f5f04d78000
write(1, "\x27\x61\x2f\x66\x6f\x6f\x27\x20"..., 19'a/foo' -> 'b/foo'
) =3D 19
openat(AT_FDCWD, "\x61\x2f\x66\x6f\x6f", O_RDONLY|O_NOFOLLOW) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D1048576, ...}) =3D 0
openat(AT_FDCWD, "\x62\x2f\x66\x6f\x6f", O_WRONLY|O_CREAT|O_EXCL, 0600) =3D=
 4
fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) =3D 0
mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D
0x7f5f0440f000
read(3, "\x00\x00\x00\x00\x00\x00\x00\x00"..., 131072) =3D 131072
write(4, "\x00\x00\x00\x00\x00\x00\x00\x00"..., 131072) =3D 131072
...=20
snip=20
...=20
read(3, "", 131072)                     =3D 0
utimensat(4, NULL, [{tv_sec=3D1589642969, tv_nsec=3D260647830} /* 2020-05-1=
6T17:2
9:29.260647830+0200 */, {tv_sec=3D1589643713, tv_nsec=3D971537549} /* 2020-=
05-16T
17:41:53.971537549+0200 */], 0) =3D 0
flistxattr(3, NULL, 0)                  =3D 18
flistxattr(3, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., 18) =3D 18
openat(AT_FDCWD, "\x2f\x65\x74\x63\x2f\x78\x61\x74\x74\x72\x2e\x63\x6f\x6e\=
x6
6", O_RDONLY) =3D 5
fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D642, ...}) =3D 0
read(5, "\x23\x20\x2f\x65\x74\x63\x2f\x78"..., 4096) =3D 642
read(5, "", 4096)                       =3D 0
close(5)                                =3D 0
openat(AT_FDCWD, "\x2f\x75\x73\x72\x2f\x6c\x69\x62\x36\x34\x2f\x67\x63\x6f\=
x6
e\x76\x2f\x67\x63\x6f\x6e\x76\x2d\x6d\x6f\x64\x75\x6c\x65\x73\x2e\x63\x61\x=
63
\x68\x65", O_RDONLY) =3D 5
fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D26988, ...}) =3D 0
mmap(NULL, 26988, PROT_READ, MAP_SHARED, 5, 0) =3D 0x7f5f04da2000
close(5)                                =3D 0
fgetxattr(3, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., NULL, 0) =3D 4
fgetxattr(3, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., "\x7a\x6c\x69\x62", 4) =
=3D
4
fsetxattr(4, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., "\x7a\x6c\x69\x62", 4, =
0)
 =3D 0
fgetxattr(3, "\x73\x79\x73\x74\x65\x6d\x2e\x70"..., 0x7fff8daf2580, 132) =
=3D -1
 ENODATA (No data available)
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D1048576, ...}) =3D 0
fsetxattr(4, "\x73\x79\x73\x74\x65\x6d\x2e\x70"..., "\x02\x00\x00\x00\x01\x=
00
\x06\x00"..., 28, 0) =3D 0
close(4)                                =3D 0
close(3)                                =3D 0
munmap(0x7f5f0440f000, 139264)          =3D 0
lseek(0, 0, SEEK_CUR)                   =3D -1 ESPIPE (Illegal seek)
close(0)                                =3D 0
close(1)                                =3D 0
close(2)                                =3D 0
exit_group(0)                           =3D ?
+++ exited with 0 +++
