Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC6F25AF28
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 17:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgIBPeY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 11:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgIBPUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 11:20:01 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A3BC061244;
        Wed,  2 Sep 2020 08:18:47 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n193so1301385vkf.12;
        Wed, 02 Sep 2020 08:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=E+yt0viUWUz07T36u9ksoBWKpv7KEu2DuhAuJWIF6rA=;
        b=iR95piBKTE5ko2G5QwJzW07/c17KiWFZzteB4d5hIPprS9ydhDWH3YSCbZe7bXdS1n
         74gP5EXqcULzqeIE9H8ZsP2xmgN3sT3O9LzhjqjHnDo0HSkbkn440GH5kA8ci9sbeMRM
         loWr2G9mNiWyV+PLRi+ahUWiHUwhoWHmgTsugJ6l2c55nD0DGPOFOxT5rA4gZ6dN6/W3
         +P4MQzeCngGWVLi6nFij/YCl4kWrFBSN9HOr4U1xnU2C0rMhZd6sTb0+AEJ6JR9gC44c
         HskbgM0qO6kbx73dEDYTRYyhUOApo0l9u4lxDeF6DUmEgCqnMgW4Iniz+mxm0k+ZEzx8
         pVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=E+yt0viUWUz07T36u9ksoBWKpv7KEu2DuhAuJWIF6rA=;
        b=kHZNIgl0a0uuMxlm4o80R/f4T2UxFhLuAvTExlmTSw8p0Sgon2jIi2o5pV+RKDh0kY
         y9kmCd4krOmQ2oyY1blj4yLONCUbxZRXSoxJtsZ1j7SHoAE05c5Av3CRohmNqxczb1TG
         qg/u/VO/1J14SSJU1jdme4ooDWLVdZmYw9hQled1OfpIjqR9+7bjIkpnbl5li/C9YjuG
         4BEPzmrbnHClD9YO8G0joFaxk7X8KFFFFHDqbARoVFtlUfCJLS3Vmq5VkVd6cpGdzEoF
         HKPX38TDKHgMQJPUIWFka9TOqi84+AhgpPKft1w/an4oHC5VHyx6hVizk6SnRl5q1WGs
         i7yA==
X-Gm-Message-State: AOAM533b5jOlnDEbHuRGW3LaNIFTQUVZswo4j1XuK/NeWumF10Q2M+XU
        TfIdAcgknpzv1risBL6tbvEuexBxxNjN8pV4MdE=
X-Google-Smtp-Source: ABdhPJz2FVUPBIzy6jeujVloMKlCs4mxJ7C8tYmiJ/2TQb1Q8QT+4rRVzqYRVklsb60ZB3nWQgPSd+pEVdBKYHRyt2g=
X-Received: by 2002:a1f:a20b:: with SMTP id l11mr5705913vke.28.1599059925519;
 Wed, 02 Sep 2020 08:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
In-Reply-To: <f5ba8625d6277035b69e466f6ea87f19620f7fcb.1599058822.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 2 Sep 2020 16:18:34 +0100
Message-ID: <CAL3q7H5VEHK3rduT5gELdSd9EF3g8LLqJgkyHKdA-VUYSni37w@mail.gmail.com>
Subject: Re: [PATCH] fstests: add generic/609 to test O_DIRECT|O_DSYNC
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 2, 2020 at 4:03 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> We had a problem recently where btrfs would deadlock with
> O_DIRECT|O_DSYNC because of an unexpected dependency on ->fsync in
> iomap.  This was only caught by chance with aiostress, because weirdly
> we don't actually test this particular configuration anywhere in
> xfstests.  Fix this by adding a basic test that just does
> O_DIRECT|O_DSYNC writes.  With this test the box deadlocks right away
> with Btrfs, which would have been helpful in finding this issue before
> the patches were merged.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  .gitignore                      |  1 +
>  src/aio-dio-regress/dio-dsync.c | 61 +++++++++++++++++++++++++++++++++
>  tests/generic/609               | 44 ++++++++++++++++++++++++
>  tests/generic/group             |  1 +
>  4 files changed, 107 insertions(+)
>  create mode 100644 src/aio-dio-regress/dio-dsync.c
>  create mode 100755 tests/generic/609
>
> diff --git a/.gitignore b/.gitignore
> index 5f5c4a0f..07c8014b 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -175,6 +175,7 @@
>  /src/aio-dio-regress/aio-last-ref-held-by-io
>  /src/aio-dio-regress/aiocp
>  /src/aio-dio-regress/aiodio_sparse2
> +/src/aio-dio-regress/dio-dsync
>  /src/log-writes/replay-log
>  /src/perf/*.pyc
>
> diff --git a/src/aio-dio-regress/dio-dsync.c b/src/aio-dio-regress/dio-ds=
ync.c
> new file mode 100644
> index 00000000..53cda9ac
> --- /dev/null
> +++ b/src/aio-dio-regress/dio-dsync.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-or-newer
> +/*
> + * Copyright (c) 2020 Facebook.
> + * All Rights Reserved.
> + *
> + * Do some O_DIRECT writes with O_DSYNC to exercise this path.
> + */
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <errno.h>
> +#include <string.h>
> +
> +int main(int argc, char **argv)
> +{
> +       struct stat st;
> +       char *buf;
> +       ssize_t ret;
> +       int fd, i;
> +       int bufsize;
> +
> +       if (argc !=3D 2) {
> +               printf("Usage: %s filename\n", argv[0]);
> +               return 1;
> +       }
> +
> +       fd =3D open(argv[1], O_DIRECT | O_RDWR | O_TRUNC | O_CREAT | O_DS=
YNC,
> +                 0644);
> +       if (fd < 0) {
> +               perror(argv[1]);
> +               return 1;
> +       }
> +
> +       if (fstat(fd, &st)) {
> +               perror(argv[1]);
> +               return 1;
> +       }
> +       bufsize =3D st.st_blksize * 10;
> +
> +       ret =3D posix_memalign((void **)&buf, st.st_blksize, bufsize);
> +       if (ret) {
> +               errno =3D ret;
> +               perror("allocating buffer");
> +               return 1;
> +       }
> +
> +       memset(buf, 'a', bufsize);
> +       for (i =3D 0; i < 10; i++) {
> +               ret =3D write(fd, buf, bufsize);
> +               if (ret < 0) {
> +                       perror("writing");
> +                       return 1;
> +               }
> +       }
> +       free(buf);
> +       close(fd);
> +       return 0;
> +}
> diff --git a/tests/generic/609 b/tests/generic/609
> new file mode 100755
> index 00000000..8a888eb9
> --- /dev/null
> +++ b/tests/generic/609
> @@ -0,0 +1,44 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2020 Josef Bacik.  All Rights Reserved.
> +#
> +# FS QA Test 609
> +#
> +# iomap can call generic_write_sync() if we're O_DSYNC, so write a basic=
 test to
> +# exercise O_DSYNC so any unsuspecting file systems will get lockdep war=
nings if
> +# they're locking isn't compatible.
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
> +       rm -rf $TEST_DIR/file
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_aiodio dio-dsync
> +
> +$AIO_TEST $TEST_DIR/file

This can be triggered with xfs_io and without adding a new test program:

#!/bin/bash

mkfs.btrfs -f /dev/sdj
mount /dev/sdj /mnt/sdj

xfs_io -f -d -c "pwrite -D -V 1 0 4K" /mnt/sdj/foobar

umount /mnt/sdj

It triggers the bug right away:

[22674.919276] BTRFS: device fsid 90a97705-b2ca-46a9-a686-87a131f91786
devid 1 transid 5 /dev/sdj scanned by mkfs.btrfs (1325449)
[22674.960097] BTRFS info (device sdj): disk space caching is enabled
[22674.960101] BTRFS info (device sdj): has skinny extents
[22674.960103] BTRFS info (device sdj): flagging fs with big metadata featu=
re
[22674.965914] BTRFS info (device sdj): checking UUID tree

[22675.034231] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[22675.034835] WARNING: possible recursive locking detected
[22675.035444] 5.9.0-rc3-btrfs-next-67 #1 Not tainted
[22675.036049] --------------------------------------------
[22675.036657] xfs_io/1325480 is trying to acquire lock:
[22675.037273] ffff9cd0b4aea658
(&sb->s_type->i_mutex_key#15){++++}-{3:3}, at:
btrfs_sync_file+0x179/0x600 [btrfs]
[22675.037936]
               but task is already holding lock:
[22675.039143] ffff9cd0b4aea658
(&sb->s_type->i_mutex_key#15){++++}-{3:3}, at:
btrfs_file_write_iter+0x86/0x5f0 [btrfs]
[22675.039791]
               other info that might help us debug this:
[22675.041007]  Possible unsafe locking scenario:

[22675.042234]        CPU0
[22675.042838]        ----
[22675.043433]   lock(&sb->s_type->i_mutex_key#15);
[22675.044025]   lock(&sb->s_type->i_mutex_key#15);
[22675.044624]
                *** DEADLOCK ***

[22675.046238]  May be due to missing lock nesting notation

[22675.047326] 3 locks held by xfs_io/1325480:
[22675.047855]  #0: ffff9cd0ad8ac470 (sb_writers#14){.+.+}-{0:0}, at:
vfs_writev+0xd8/0xf0
[22675.048439]  #1: ffff9cd0b4aea658
(&sb->s_type->i_mutex_key#15){++++}-{3:3}, at:
btrfs_file_write_iter+0x86/0x5f0 [btrfs]
[22675.049038]  #2: ffff9cd0b4aea4c8 (&ei->dio_sem){++++}-{3:3}, at:
btrfs_direct_IO+0x113/0x160 [btrfs]
[22675.049633]
               stack backtrace:
[22675.050727] CPU: 0 PID: 1325480 Comm: xfs_io Not tainted
5.9.0-rc3-btrfs-next-67 #1
[22675.051275] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[22675.052399] Call Trace:
[22675.052976]  dump_stack+0x8d/0xc0
[22675.053559]  __lock_acquire.cold+0x210/0x2e9
[22675.054145]  ? rcu_read_lock_sched_held+0x5d/0x90
[22675.054777]  lock_acquire+0xb1/0x470
[22675.055352]  ? btrfs_sync_file+0x179/0x600 [btrfs]
[22675.055923]  down_write+0x40/0x130
[22675.056496]  ? btrfs_sync_file+0x179/0x600 [btrfs]
[22675.057044]  btrfs_sync_file+0x179/0x600 [btrfs]
[22675.057593]  ? __do_sys_kcmp+0x980/0xce0
[22675.058143]  iomap_dio_complete+0x112/0x130
[22675.058679]  ? iomap_dio_rw+0x2c4/0x620
[22675.059199]  iomap_dio_rw+0x494/0x620
[22675.059723]  ? btrfs_direct_IO+0xd5/0x160 [btrfs]
[22675.060238]  btrfs_direct_IO+0xd5/0x160 [btrfs]
[22675.060738]  btrfs_file_write_iter+0x215/0x5f0 [btrfs]
[22675.061221]  do_iter_readv_writev+0x169/0x1f0
[22675.061698]  do_iter_write+0x80/0x1b0
[22675.062170]  vfs_writev+0xa6/0xf0
[22675.062643]  ? syscall_enter_from_user_mode+0xb4/0x270
[22675.063114]  ? find_held_lock+0x32/0x90
[22675.063581]  ? syscall_enter_from_user_mode+0xb4/0x270
[22675.064045]  do_pwritev+0x8f/0xd0
[22675.064489]  do_syscall_64+0x33/0x80
[22675.064934]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[22675.065372] RIP: 0033:0x7fac51c898b9
[22675.065792] Code: 89 fd 53 44 89 c3 48 83 ec 18 64 8b 04 25 18 00
00 00 85 c0 0f 85 97 00 00 00 45 89 c1 49 89 ca 45 31 c0 b8 48 01 00
00 0f 05 <48> 3d 00 f0 ff ff 0f 87 cb 00 00 00 48 85 c0 79 44 4c 8b 2d
9f 75
[22675.066692] RSP: 002b:00007ffdae24ecd0 EFLAGS: 00000246 ORIG_RAX:
0000000000000148
[22675.067155] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fac51c=
898b9
[22675.067628] RDX: 0000000000000001 RSI: 000055990bc5bf90 RDI: 00000000000=
00003
[22675.068113] RBP: 0000000000000003 R08: 0000000000000000 R09: 00000000000=
00002
[22675.068592] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000=
00000
[22675.069074] R13: 0000000000000000 R14: 0000000000000001 R15: 00000000000=
00002

Or is there anything I missed?

Thanks.

> +
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/generic/group b/tests/generic/group
> index aa969bcb..ae2567a0 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -611,3 +611,4 @@
>  606 auto attr quick dax
>  607 auto attr quick dax
>  608 auto attr quick dax
> +609 auto quick
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
