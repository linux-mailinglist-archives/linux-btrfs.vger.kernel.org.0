Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9AB1D62F7
	for <lists+linux-btrfs@lfdr.de>; Sat, 16 May 2020 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgEPRSf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 16 May 2020 13:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbgEPRSf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 16 May 2020 13:18:35 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA3EC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat, 16 May 2020 10:18:35 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id k3so1969271ual.8
        for <linux-btrfs@vger.kernel.org>; Sat, 16 May 2020 10:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=0dnG57TJRPaZ+VSblAxD4CPy1vBnHmXFXI5pfSmaKok=;
        b=oWHz/vnMH2CiSHwCXUeOQqk2GeOI16iLTt7VkAuTNBtmoJOSST2Xzb5x0U8bUAa58f
         vwtsnllmNCf7T0nwjwaP7h9MuGwzv+ZUiChZIGUN8nDptaI756yAMhv8QOe9f3OP1olQ
         w+KblxBtsfQrhaaM1W7eNg4fUKk5+n0lOmS+uaEZHglW7L97wXlGGTVhstCJZFusCq0N
         Be1LL7M/qnH23T5XADyintdxHRmyc9f9Mmsqrpjb+65z4YgofzdjmeH1QGevc2K33vUX
         VauYilX5lZraBFzQwd4Jt8f5wsLjsvoQk/l6Hy7D2ojPq4OVAtmoha/bWrRfXEPGrJLJ
         9eIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=0dnG57TJRPaZ+VSblAxD4CPy1vBnHmXFXI5pfSmaKok=;
        b=n6GA0tY9kq6nabTIZUlUVusIBbNNs+nkwto1hFDW+VXs6mgiJzMuUdwl/Dp90++6w4
         s9ETiWi5fD9/iToijdrJkUmybeN+3Qss0zVQYR5XBGPzEOq4Bx7UBSdhPxalotrspfVB
         Wee5k+Ts84mePVtv2E5YAJykfjUbSSvNm4UuucffPtAnuly+sq8pxFCLR5oXocWWes+5
         leAhiNgjxllnMfJTed326mrXm25KQGusLCj7vzQL00QglXobA1IyV8+Ns+igXuQAAFPP
         XOkp0n06/clU8+uqjk5qU93I21Vl+P8KqBJAjZ4QFTToG0QABYw3r950WJsRUJfiyCV5
         C4Cw==
X-Gm-Message-State: AOAM533Q7+4k8P6OKAhqxfkC/t2WG7gWYSTqmIFphsyRXJdkFCr8hXAr
        OsMIKXuJZKht7LU7BJ2UyI6IwHTVTK/q7fwy7APxzg==
X-Google-Smtp-Source: ABdhPJwO+REL0BkB6bW12rtckky/2VUW36jXqyieDi1G14gsfrFwBKtnrb3iMysxukEqiCd326I/z+2HUlTYQNbd3qg=
X-Received: by 2002:ab0:6806:: with SMTP id z6mr6698362uar.0.1589649513496;
 Sat, 16 May 2020 10:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <b3f880.1227fea8.1721e54aeeb@lechevalier.se>
In-Reply-To: <b3f880.1227fea8.1721e54aeeb@lechevalier.se>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Sat, 16 May 2020 18:18:22 +0100
Message-ID: <CAL3q7H4zkS=9U2+ig=6a3WDF2NXDDZkmnw9havUKi5EbB0t6Og@mail.gmail.com>
Subject: Re: cp -a leaves some compressed data.
To:     A L <mail@lechevalier.se>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 16, 2020 at 5:51 PM A L <mail@lechevalier.se> wrote:
>
> Dear all,
>
> I did some testing on copying files with the +c (compression) xattrs set.
>
> As far as I can tell, 'cp - a' only sets any xattrs after copying the dat=
a. This means that a compressed file should end up without compression, but=
 still with the +c xattr set. However this is not entirely true. Some small=
 amount of data is still getting compressed.
>
> I would like to understand why.

As discussed on the mailing list:

cp copies the xattr only after copying the file data. Since the data
is written to the destination using buffered IO, it is possible that
while copying the data the system flushes dirty pages for whatever
reason (due to memory pressure, someone called sync(2), etc) - this
data will not be compressed since the file doesn't have yet the
compression xattr. If the remaining data is flushed after cp finishes,
then that data can end up compressed, since the file has the
compression xattr at that point. Typically for small files, all the
data ends up getting flushed after cp finishes, so we don't see any
surprising behaviour.

I'll look into changing 'cp''s behaviour to copy xattrs before file
data next week, unless you or someone else is interested in doing it.

Thanks.

>
> Here is a small test case:
>
> File test-comp.sh:
> #!/bin/bash
> mkdir -p test test/a test/b
> chattr +c test/a
> touch test/a/foo
> dd if=3D/dev/zero of=3Dtest/a/foo bs=3D1024 count=3D1M
> cp -a test/a test/b/
>
> Now check the output with the compsize tool:
>
> # compsize test/a
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL        3%       32M         1.0G         1.0G
> zlib         3%       32M         1.0G         1.0G
>
> # compsize test/b
> Type       Perc     Disk Usage   Uncompressed Referenced
> TOTAL       63%      652M         1.0G         1.0G
> none       100%      640M         640M         640M
> zlib         3%       12M         384M         384M
> /mnt/test #
>
>
> As you see, the copy ended up with 384M compressed data. When running thi=
s test several times, the amount changes between runs.
>
> I did an strace too see what was going on. It is clear that the setfxattr=
() is called after all the data was written to the file.
>
>
>
> # strace -s8 -xx cp -av a/foo b/
> execve("\x2f\x62\x69\x6e\x2f\x63\x70", ["\x63\x70", "\x2d\x61\x76", "\x61=
\x2f
> \x66\x6f\x6f", "\x62\x2f"], 0x7fff9d6acb68 /* 44 vars */) =3D 0
> brk(NULL)                               =3D 0x556e7cf7c000
> access("\x2f\x65\x74\x63\x2f\x6c\x64\x2e\x73\x6f\x2e\x70\x72\x65\x6c\x6f\=
x61\
> x64", R_OK) =3D -1 ENOENT (No such file or directory)
> openat(AT_FDCWD, "\x2f\x65\x74\x63\x2f\x6c\x64\x2e\x73\x6f\x2e\x63\x61\x6=
3\x6
> 8\x65", O_RDONLY|O_CLOEXEC) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D122526, ...}) =3D 0
> mmap(NULL, 122526, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7f5f04d8b000
> close(3)                                =3D 0
> openat(AT_FDCWD, "\x2f\x6c\x69\x62\x36\x34\x2f\x6c\x69\x62\x61\x63\x6c\x2=
e\x7
> 3\x6f\x2e\x31", O_RDONLY|O_CLOEXEC) =3D 3
> read(3, "\x7f\x45\x4c\x46\x02\x01\x01\x00"..., 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D39240, ...}) =3D 0
> mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x
> 7f5f04d89000
> mmap(NULL, 41568, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f5f0=
4d7e00
> 0
> mmap(0x7f5f04d80000, 20480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MA=
P_DE
> NYWRITE, 3, 0x2000) =3D 0x7f5f04d80000
> mmap(0x7f5f04d85000, 8192, PROT_READ, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE=
, 3,
>  0x7000) =3D 0x7f5f04d85000
> mmap(0x7f5f04d87000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MA=
P_DE
> NYWRITE, 3, 0x8000) =3D 0x7f5f04d87000
> close(3)                                =3D 0
> openat(AT_FDCWD, "\x2f\x6c\x69\x62\x36\x34\x2f\x6c\x69\x62\x61\x74\x74\x7=
2\x2
> e\x73\x6f\x2e\x31", O_RDONLY|O_CLOEXEC) =3D 3
> read(3, "\x7f\x45\x4c\x46\x02\x01\x01\x00"..., 832) =3D 832
> fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D26720, ...}) =3D 0
> mmap(NULL, 29016, PROT_READ, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) =3D 0x7f5f0=
4d7600
> 0
> mmap(0x7f5f04d78000, 12288, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MA=
P_DE
> NYWRITE, 3, 0x2000) =3D 0x7f5f04d78000
> write(1, "\x27\x61\x2f\x66\x6f\x6f\x27\x20"..., 19'a/foo' -> 'b/foo'
> ) =3D 19
> openat(AT_FDCWD, "\x61\x2f\x66\x6f\x6f", O_RDONLY|O_NOFOLLOW) =3D 3
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D1048576, ...}) =3D 0
> openat(AT_FDCWD, "\x62\x2f\x66\x6f\x6f", O_WRONLY|O_CREAT|O_EXCL, 0600) =
=3D 4
> fstat(4, {st_mode=3DS_IFREG|0600, st_size=3D0, ...}) =3D 0
> fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) =3D 0
> mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D
> 0x7f5f0440f000
> read(3, "\x00\x00\x00\x00\x00\x00\x00\x00"..., 131072) =3D 131072
> write(4, "\x00\x00\x00\x00\x00\x00\x00\x00"..., 131072) =3D 131072
> ...
> snip
> ...
> read(3, "", 131072)                     =3D 0
> utimensat(4, NULL, [{tv_sec=3D1589642969, tv_nsec=3D260647830} /* 2020-05=
-16T17:2
> 9:29.260647830+0200 */, {tv_sec=3D1589643713, tv_nsec=3D971537549} /* 202=
0-05-16T
> 17:41:53.971537549+0200 */], 0) =3D 0
> flistxattr(3, NULL, 0)                  =3D 18
> flistxattr(3, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., 18) =3D 18
> openat(AT_FDCWD, "\x2f\x65\x74\x63\x2f\x78\x61\x74\x74\x72\x2e\x63\x6f\x6=
e\x6
> 6", O_RDONLY) =3D 5
> fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D642, ...}) =3D 0
> read(5, "\x23\x20\x2f\x65\x74\x63\x2f\x78"..., 4096) =3D 642
> read(5, "", 4096)                       =3D 0
> close(5)                                =3D 0
> openat(AT_FDCWD, "\x2f\x75\x73\x72\x2f\x6c\x69\x62\x36\x34\x2f\x67\x63\x6=
f\x6
> e\x76\x2f\x67\x63\x6f\x6e\x76\x2d\x6d\x6f\x64\x75\x6c\x65\x73\x2e\x63\x61=
\x63
> \x68\x65", O_RDONLY) =3D 5
> fstat(5, {st_mode=3DS_IFREG|0644, st_size=3D26988, ...}) =3D 0
> mmap(NULL, 26988, PROT_READ, MAP_SHARED, 5, 0) =3D 0x7f5f04da2000
> close(5)                                =3D 0
> fgetxattr(3, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., NULL, 0) =3D 4
> fgetxattr(3, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., "\x7a\x6c\x69\x62", 4=
) =3D
> 4
> fsetxattr(4, "\x62\x74\x72\x66\x73\x2e\x63\x6f"..., "\x7a\x6c\x69\x62", 4=
, 0)
>  =3D 0
> fgetxattr(3, "\x73\x79\x73\x74\x65\x6d\x2e\x70"..., 0x7fff8daf2580, 132) =
=3D -1
>  ENODATA (No data available)
> fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D1048576, ...}) =3D 0
> fsetxattr(4, "\x73\x79\x73\x74\x65\x6d\x2e\x70"..., "\x02\x00\x00\x00\x01=
\x00
> \x06\x00"..., 28, 0) =3D 0
> close(4)                                =3D 0
> close(3)                                =3D 0
> munmap(0x7f5f0440f000, 139264)          =3D 0
> lseek(0, 0, SEEK_CUR)                   =3D -1 ESPIPE (Illegal seek)
> close(0)                                =3D 0
> close(1)                                =3D 0
> close(2)                                =3D 0
> exit_group(0)                           =3D ?
> +++ exited with 0 +++



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
