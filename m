Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB572DD0C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 12:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgLQLsl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 06:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQLsl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 06:48:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0FC061794;
        Thu, 17 Dec 2020 03:48:00 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d11so13101880qvo.11;
        Thu, 17 Dec 2020 03:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Af3tm1xt8wYwm8j6oQ/0kOdtDzjZw+QAhW23vn4YdTU=;
        b=lh6miXxWM7UlU4PGAL6DaQq8ZUi2u6KDX/sm/1/t6GE05W9lWx8Qpak1YiyWcHfwTp
         EFSGiPNN5AH4e4i6/gUE/PUCybyFqXOYYIdc6eljm3MSdKscMmy0pwo7y34WcuAx0wv0
         dD4tZY1E1DYOVucfnq75C+EG1uOkMJGJV6IvHp6OPkRTFzYsANjNiah0YoU1hZeHL85t
         un2CIt2AVdGFLwk1IZjbl1V+QfHKxRZFcTyh76p9S2/EHwmriVFygR8tCs8Xb3etj0nD
         DuLF3ZLFiMYG3QYbZIwPdcG6ZfPI4i6gXGmh3d4TVSgIzF/1WpERxSYtqDQWe1MleFAD
         mCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Af3tm1xt8wYwm8j6oQ/0kOdtDzjZw+QAhW23vn4YdTU=;
        b=PFnYBX2S8rfFlMDYwlitGC9fuJ3UvEYsr5o+iCawXPFs0lT0g7o/pGC8MzdYYMA77f
         BGJzn025dQkwo0jG6WYduDa5Ld/OLGzEu+TzkGlPYB1ua4R2FNYSWKIhsLB8V3wtQYBO
         8YaKq4grf5Bu2Vquc3Adi4xcL9ZHq0EGYMOm078EW5sr6Q0SzrnHkgF2vEGbDLNlBVNH
         WQr0RQ9Rx5UJAvXAoIhWlPAkomjKXHI6eUNA8yu44zT0AL6quL4fysF9GluyTRJzPA/o
         m1UtFziHWXUOYHJseKmqaZnxFFJGFVJDHC5mJwnx8KxuKJ5Fotp18+o/5kcYDVW6DxtN
         jW6Q==
X-Gm-Message-State: AOAM532RD+b5c7yQUTPhdANYQwUsURXw7JsvyT0oE47W5kz0SCPurjZR
        qC+FTQVg8CqcizOTdCemXXRz1qzuYRZW2zp07Y/+mMNvfFKl8Q==
X-Google-Smtp-Source: ABdhPJyQAdHfiblw/q7WqCtntOkyQE/fbqCvWdjGyK7J0o1u3IfXbiduL31ck9Y1sTAKOeOaLPk7fEq3k0U8LXqBXQI=
X-Received: by 2002:a0c:da87:: with SMTP id z7mr27727439qvj.41.1608205680052;
 Thu, 17 Dec 2020 03:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20201215035906.233272-1-ethanwu@synology.com>
In-Reply-To: <20201215035906.233272-1-ethanwu@synology.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 17 Dec 2020 11:47:49 +0000
Message-ID: <CAL3q7H412cHxC4p7Nx+qLFYJCUzdt5CP4JGw0JtM3jDqycnrog@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: test if rename handles dir item collision correctly
To:     ethanwu <ethanwu@synology.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 15, 2020 at 4:16 AM ethanwu <ethanwu@synology.com> wrote:
>
> This is a regression test for the issue fixed by the kernel commit titled
> "btrfs: correctly calculate item size used when item key collision happen=
s"
>
> In this case, we'll simply rename many forged filename that cause collisi=
on
> under a directory to see if rename failed and filesystem is forced readon=
ly.
>
> Signed-off-by: ethanwu <ethanwu@synology.com>
> ---
> v2:
> - Add a python script to generate the forged name at run-time rather than
> from hardcoded names
> - Fix , Btrfs->btrfs, and typo mentioned in v1
>
>  src/btrfs_crc32c_forged_name.py | 92 +++++++++++++++++++++++++++++++++
>  tests/btrfs/228                 | 72 ++++++++++++++++++++++++++
>  tests/btrfs/228.out             |  2 +
>  tests/btrfs/group               |  1 +
>  4 files changed, 167 insertions(+)
>  create mode 100755 src/btrfs_crc32c_forged_name.py
>  create mode 100755 tests/btrfs/228
>  create mode 100644 tests/btrfs/228.out
>
> diff --git a/src/btrfs_crc32c_forged_name.py b/src/btrfs_crc32c_forged_na=
me.py
> new file mode 100755
> index 00000000..d8abedde
> --- /dev/null
> +++ b/src/btrfs_crc32c_forged_name.py
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +import struct
> +import sys
> +import os
> +import argparse
> +
> +class CRC32(object):
> +  """A class to calculate and manipulate CRC32."""
> +  def __init__(self):
> +    self.polynom =3D 0x82F63B78
> +    self.table, self.reverse =3D [0]*256, [0]*256
> +    self._build_tables()
> +
> +  def _build_tables(self):
> +    for i in range(256):
> +      fwd =3D i
> +      rev =3D i << 24
> +      for j in range(8, 0, -1):
> +        # build normal table
> +        if (fwd & 1) =3D=3D 1:
> +          fwd =3D (fwd >> 1) ^ self.polynom
> +        else:
> +          fwd >>=3D 1
> +        self.table[i] =3D fwd & 0xffffffff
> +        # build reverse table =3D)
> +        if rev & 0x80000000 =3D=3D 0x80000000:
> +          rev =3D ((rev ^ self.polynom) << 1) | 1
> +        else:
> +          rev <<=3D 1
> +        rev &=3D 0xffffffff
> +        self.reverse[i] =3D rev
> +
> +  def calc(self, s):
> +    """Calculate crc32 of a string.
> +       Same crc32 as in (binascii.crc32)&0xffffffff.
> +    """
> +    crc =3D 0xffffffff
> +    for c in s:
> +      crc =3D (crc >> 8) ^ self.table[(crc ^ ord(c)) & 0xff]
> +    return crc^0xffffffff
> +
> +  def forge(self, wanted_crc, s, pos=3DNone):
> +    """Forge crc32 of a string by adding 4 bytes at position pos."""
> +    if pos is None:
> +      pos =3D len(s)
> +
> +    # forward calculation of CRC up to pos, sets current forward CRC sta=
te
> +    fwd_crc =3D 0xffffffff
> +    for c in s[:pos]:
> +      fwd_crc =3D (fwd_crc >> 8) ^ self.table[(fwd_crc ^ ord(c)) & 0xff]
> +
> +    # backward calculation of CRC up to pos, sets wanted backward CRC st=
ate
> +    bkd_crc =3D wanted_crc^0xffffffff
> +    for c in s[pos:][::-1]:
> +      bkd_crc =3D ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >=
> 24]
> +      bkd_crc ^=3D ord(c)
> +
> +    # deduce the 4 bytes we need to insert
> +    for c in struct.pack('<L',fwd_crc)[::-1]:
> +      bkd_crc =3D ((bkd_crc << 8) & 0xffffffff) ^ self.reverse[bkd_crc >=
> 24]
> +      bkd_crc ^=3D ord(c)
> +
> +    res =3D s[:pos] + struct.pack('<L', bkd_crc) + s[pos:]
> +    return res
> +
> +  def parse_args(self):
> +    parser =3D argparse.ArgumentParser()
> +    parser.add_argument("-d", default=3Dos.getcwd(), dest=3D'dir',
> +                        help=3D"directory to generate forged names")
> +    parser.add_argument("-c", default=3D1, type=3Dint, dest=3D'count',
> +                        help=3D"number of forged names to create")
> +    return parser.parse_args()
> +
> +if __name__=3D=3D'__main__':
> +
> +  crc =3D CRC32()
> +  wanted_crc =3D 0x00000000
> +  count =3D 0
> +  args =3D crc.parse_args()
> +  dirpath=3Dargs.dir
> +  while count < args.count :
> +    origname =3D os.urandom (89).encode ("hex")[:-1].strip ("\x00")
> +    forgename =3D crc.forge(wanted_crc, origname, 4)
> +    if ("/" not in forgename) and ("\x00" not in forgename):
> +      srcpath=3Ddirpath + '/' + str(count)
> +      dstpath=3Ddirpath + '/' + forgename
> +      file (srcpath, 'a').close()
> +      os.rename(srcpath, dstpath)
> +      os.system('btrfs fi sync %s' % (dirpath))
> +      count+=3D1;
> +
> diff --git a/tests/btrfs/228 b/tests/btrfs/228
> new file mode 100755
> index 00000000..e38da19b
> --- /dev/null
> +++ b/tests/btrfs/228
> @@ -0,0 +1,72 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Synology.  All Rights Reserved.
> +#
> +# FS QA Test 228
> +#
> +# Test if btrfs rename handle dir item collision correctly
> +# Without patch fix, rename will fail with EOVERFLOW, and filesystem
> +# is forced readonly.
> +#
> +# This bug is going to be fixed by a patch for kernel titled
> +# "btrfs: correctly calculate item size used when item key collision hap=
pens"
> +#
> +seq=3D`basename $0`
> +seqres=3D$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=3D`pwd`
> +tmp=3D/tmp/$$
> +status=3D1       # failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +       cd /
> +       rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +_supported_fs btrfs
> +_require_scratch
> +_require_command $PYTHON2_PROG python2
> +
> +rm -f $seqres.full
> +
> +# Currently in btrfs the node/leaf size can not be smaller than the page
> +# size (but it can be greater than the page size). So use the largest
> +# supported node/leaf size (64Kb) so that the test can run on any platfo=
rm
> +# that Linux supports.
> +_scratch_mkfs "--nodesize 65536" >>$seqres.full 2>&1
> +_scratch_mount
> +
> +#
> +# In the following for loop, we'll create a leaf fully occupied by
> +# only one dir item with many forged collision names in it.
> +#
> +# leaf 22544384 items 1 free space 0 generation 6 owner FS_TREE
> +# leaf 22544384 flags 0x1(WRITTEN) backref revision 1
> +# fs uuid 9064ba52-3d2c-4840-8e26-35db08fa17d7
> +# chunk uuid 9ba39317-3159-46c9-a75a-965ab1e94267
> +#    item 0 key (256 DIR_ITEM 3737737011) itemoff 25 itemsize 65410
> +#    ...
> +#
> +
> +$PYTHON2_PROG $here/src/btrfs_crc32c_forged_name.py -d $SCRATCH_MNT -c 3=
10
> +
> +ISRW=3D$(_fs_options $SCRATCH_DEV | grep -w "rw")
> +if [ -n "$ISRW" ]; then
> +       echo "FS is Read-Write Test OK"
> +else
> +       echo "FS is Read-Only. Test Failed"
> +       status=3D1
> +       exit
> +fi

You don't need to print these messages. In case the test fails:

1) There's a warning stack trace in dmesg, that alone makes the test
fail since fstests checks for warnings in dmesg and reports the test
as failed is any exist;
2) The test script results in python dumping a stack trace, which
causes a mismatch with the golden output, therefore making the test
fail:

Traceback (most recent call last):
  File "/home/fdmanana/git/hub/xfstests/src/btrfs_crc32c_forged_name.py",
line 89, in <module>
    os.rename(srcpath, dstpath)
OSError: [Errno 75] Value too large for defined data type

Anyway, it's a minor thing, if Eryu doesn't like it, I suppose we can
remove that if-then-else and just replace it with "echo Silence is
golden".

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thank you very much for writing the test case Ethan!

> +
> +# success, all done
> +status=3D0; exit
> diff --git a/tests/btrfs/228.out b/tests/btrfs/228.out
> new file mode 100644
> index 00000000..eae514f0
> --- /dev/null
> +++ b/tests/btrfs/228.out
> @@ -0,0 +1,2 @@
> +QA output created by 228
> +FS is Read-Write Test OK
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index d18450c7..f8021668 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -228,3 +228,4 @@
>  224 auto quick qgroup
>  225 auto quick volume seed
>  226 auto quick rw snapshot clone prealloc punch
> +228 auto quick
> --
> 2.25.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
