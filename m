Return-Path: <linux-btrfs+bounces-7812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF396C021
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 16:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96F441C24A00
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Sep 2024 14:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C7A1DEFDD;
	Wed,  4 Sep 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtrXcr7E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CD1D79B2;
	Wed,  4 Sep 2024 14:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459577; cv=none; b=jnmkIp2ndgVZ3I3aQJWNu1ij2KJNxTbyO5/IakWAZkJB3t6HhAPmF38Rk0kyu0CKQkwmvYrVG9gVl2/ZcQEibrXU4+tuyiMDvuqQOzzG098mMgcxd43SFTe7QQRZ3KAKotl1W95/K8+/5rK8sXXz7Nj7uqJUFfuCZgCH42EQU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459577; c=relaxed/simple;
	bh=b0Rm8bfC5WGTb2Xi7XUJQqaF9v/l0p1rHvQyUa+BJKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdZap3ilFxoeg5BQQXB/dPFmlsLkR/1xMSd0QG3R+zKl0x5fKTf//Dykyh1NIREei7lIJumUpFwesoAT9pzuiNEZTSMdl98TVS8dkIvar1K0ZXFI4vTxodfwu9/KfgE9+4S1WASx8lvptJPOSHLbcV4ce4KsF/eSWmTeLwjbyLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtrXcr7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD6DC4CEC2;
	Wed,  4 Sep 2024 14:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725459576;
	bh=b0Rm8bfC5WGTb2Xi7XUJQqaF9v/l0p1rHvQyUa+BJKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EtrXcr7EfnsmJExo86A5UVTkAa/qTPvwE0a1OxiBYA7q9wMdfwdKwtALV7N3jbE41
	 6lmHaKO7x6pVYT6thxpixd5mkXDh6tWIgn57N60ZWqk/wvvqnbokOGM/UEDu4a7OPi
	 /Meflx58nlXzs4bZv0GdBiibgMOgkKeHNE0JhkgxFD2CVMXZFqDt+s4Ml6Xy9lSI2r
	 HlFMNG1acalXdpMMmQ2G5c/iW0XQrgv9aB812ryUw7rRMZTqNK4lDNiCAAchEx/NSC
	 XB7p5XsntsMPYFGPwrrXXdn4Ay9ffD+UYd/JYJc71+gAzUzeTZDgk2kqv9DYt/WiQ8
	 aME9AbaJJQUhA==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86acbaddb4so799456966b.1;
        Wed, 04 Sep 2024 07:19:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWLvlMqIbS9L4hBaN/79EsHJ+e+DRK2oWN6gmpfQxK8li2PaEYxMOQCxoH1tGcHJlLpPZAVC8kbPAyyAw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0RBKtuDB3xj79VpSgBpC7WlDiGp6xW3nWRVhm5D7+BJy2AmUA
	YA+0z48UL9x5u3IzFFtM2RorYHSlGBteY+0c0PihLZLC7opnph7PcX9fWVn4eTeV7AX8o0puHch
	ewlexG45FEWK8crxvIMcn/PXlZnM=
X-Google-Smtp-Source: AGHT+IGtesHk65MgFULkS1cWOGqbUMSTNDyX7+yBU3VKCkGRqwnsU1QZXfAv7052/525WfvhsGbsIvIeseWP9OktrcI=
X-Received: by 2002:a17:907:6d24:b0:a72:44d8:3051 with SMTP id
 a640c23a62f3a-a897f84bcd1mr1450986866b.16.1725459575032; Wed, 04 Sep 2024
 07:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
 <20240902202856.e5mqgsbwmiwxs4qe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7vDpoG=k55yh9rJQWw=sit5fMkjPZMpVfwf7629b_hsA@mail.gmail.com>
 <20240903040907.gqfprq4ul6x7s2kt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4WSd7woy_cDmQ-1Z45zgMDdyfSS-2uzhOqkHisQewWXw@mail.gmail.com> <20240904111313.derzz3rcr7nyklfn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240904111313.derzz3rcr7nyklfn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 4 Sep 2024 15:18:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6-ii04vbr8NkE_7Zd1cC+qVYrharfFg75XNqcRJSY1pA@mail.gmail.com>
Message-ID: <CAL3q7H6-ii04vbr8NkE_7Zd1cC+qVYrharfFg75XNqcRJSY1pA@mail.gmail.com>
Subject: Re: [PATCH] generic: test concurrent direct IO writes and fsync using
 same fd
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 12:13=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Tue, Sep 03, 2024 at 10:41:06AM +0100, Filipe Manana wrote:
> > On Tue, Sep 3, 2024 at 5:09=E2=80=AFAM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Mon, Sep 02, 2024 at 10:45:33PM +0100, Filipe Manana wrote:
> > > > On Mon, Sep 2, 2024 at 9:29=E2=80=AFPM Zorro Lang <zlang@redhat.com=
> wrote:
> > > > >
> > > > > On Fri, Aug 30, 2024 at 12:10:21AM +0100, fdmanana@kernel.org wro=
te:
> > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > Test that a program that has 2 threads using the same file desc=
riptor and
> > > > > > concurrently doing direct IO writes and fsync doesn't trigger a=
ny crash
> > > > > > or deadlock.
> > > > > >
> > > > > > This is motivated by a bug found in btrfs fixed by the followin=
g patch:
> > > > > >
> > > > > >   "btrfs: fix race between direct IO write and fsync when using=
 same fd"
> > > > > >
> > > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > > ---
> > > > > >  .gitignore                    |   1 +
> > > > > >  src/Makefile                  |   2 +-
> > > > > >  src/dio-write-fsync-same-fd.c | 106 ++++++++++++++++++++++++++=
++++++++
> > > > > >  tests/generic/363             |  30 ++++++++++
> > > > > >  tests/generic/363.out         |   2 +
> > > > > >  5 files changed, 140 insertions(+), 1 deletion(-)
> > > > > >  create mode 100644 src/dio-write-fsync-same-fd.c
> > > > > >  create mode 100755 tests/generic/363
> > > > > >  create mode 100644 tests/generic/363.out
> > > > > >
> > > > > > diff --git a/.gitignore b/.gitignore
> > > > > > index 36083e9d..57519263 100644
> > > > > > --- a/.gitignore
> > > > > > +++ b/.gitignore
> > > > > > @@ -76,6 +76,7 @@ tags
> > > > > >  /src/dio-buf-fault
> > > > > >  /src/dio-interleaved
> > > > > >  /src/dio-invalidate-cache
> > > > > > +/src/dio-write-fsync-same-fd
> > > > > >  /src/dirhash_collide
> > > > > >  /src/dirperf
> > > > > >  /src/dirstress
> > > > > > diff --git a/src/Makefile b/src/Makefile
> > > > > > index b3da59a0..b9ad6b5f 100644
> > > > > > --- a/src/Makefile
> > > > > > +++ b/src/Makefile
> > > > > > @@ -20,7 +20,7 @@ TARGETS =3D dirstress fill fill2 getpagesize =
holes lstat64 \
> > > > > >       t_get_file_time t_create_short_dirs t_create_long_dirs t_=
enospc \
> > > > > >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault al=
locstale \
> > > > > >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault=
 rewinddir-test \
> > > > > > -     readdir-while-renames dio-append-buf-fault
> > > > > > +     readdir-while-renames dio-append-buf-fault dio-write-fsyn=
c-same-fd
> > > > > >
> > > > > >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw=
_pattern_reader \
> > > > > >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx loo=
ptest \
> > > > > > diff --git a/src/dio-write-fsync-same-fd.c b/src/dio-write-fsyn=
c-same-fd.c
> > > > > > new file mode 100644
> > > > > > index 00000000..79472a9e
> > > > > > --- /dev/null
> > > > > > +++ b/src/dio-write-fsync-same-fd.c
> > > > > > @@ -0,0 +1,106 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Re=
served.
> > > > > > + */
> > > > > > +
> > > > > > +/*
> > > > > > + * Test two threads working with the same file descriptor, one=
 doing direct IO
> > > > > > + * writes into the file and the other just doing fsync calls. =
We want to verify
> > > > > > + * that there are no crashes or deadlocks.
> > > > > > + *
> > > > > > + * This program never finishes, it starts two infinite loops t=
o write and fsync
> > > > > > + * the file. It's meant to be called with the 'timeout' progra=
m from coreutils.
> > > > > > + */
> > > > > > +
> > > > > > +/* Get the O_DIRECT definition. */
> > > > > > +#ifndef _GNU_SOURCE
> > > > > > +#define _GNU_SOURCE
> > > > > > +#endif
> > > > > > +
> > > > > > +#include <stdio.h>
> > > > > > +#include <stdlib.h>
> > > > > > +#include <unistd.h>
> > > > > > +#include <stdint.h>
> > > > > > +#include <fcntl.h>
> > > > > > +#include <errno.h>
> > > > > > +#include <string.h>
> > > > > > +#include <pthread.h>
> > > > > > +
> > > > > > +static int fd;
> > > > > > +
> > > > > > +static ssize_t do_write(int fd, const void *buf, size_t count,=
 off_t offset)
> > > > > > +{
> > > > > > +        while (count > 0) {
> > > > > > +             ssize_t ret;
> > > > > > +
> > > > > > +             ret =3D pwrite(fd, buf, count, offset);
> > > > > > +             if (ret < 0) {
> > > > > > +                     if (errno =3D=3D EINTR)
> > > > > > +                             continue;
> > > > > > +                     return ret;
> > > > > > +             }
> > > > > > +             count -=3D ret;
> > > > > > +             buf +=3D ret;
> > > > > > +     }
> > > > > > +     return 0;
> > > > > > +}
> > > > > > +
> > > > > > +static void *fsync_loop(void *arg)
> > > > > > +{
> > > > > > +     while (1) {
> > > > > > +             int ret;
> > > > > > +
> > > > > > +             ret =3D fsync(fd);
> > > > > > +             if (ret !=3D 0) {
> > > > > > +                     perror("Fsync failed");
> > > > > > +                     exit(6);
> > > > > > +             }
> > > > > > +     }
> > > > > > +}
> > > > > > +
> > > > > > +int main(int argc, char *argv[])
> > > > > > +{
> > > > > > +     long pagesize;
> > > > > > +     void *write_buf;
> > > > > > +     pthread_t fsyncer;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     if (argc !=3D 2) {
> > > > > > +             fprintf(stderr, "Use: %s <file path>\n", argv[0])=
;
> > > > > > +             return 1;
> > > > > > +     }
> > > > > > +
> > > > > > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIR=
ECT, 0666);
> > > > > > +     if (fd =3D=3D -1) {
> > > > > > +             perror("Failed to open/create file");
> > > > > > +             return 1;
> > > > > > +     }
> > > > > > +
> > > > > > +     pagesize =3D sysconf(_SC_PAGE_SIZE);
> > > > > > +     if (pagesize =3D=3D -1) {
> > > > > > +             perror("Failed to get page size");
> > > > > > +             return 2;
> > > > > > +     }
> > > > > > +
> > > > > > +     ret =3D posix_memalign(&write_buf, pagesize, pagesize);
> > > > > > +     if (ret) {
> > > > > > +             perror("Failed to allocate buffer");
> > > > > > +             return 3;
> > > > > > +     }
> > > > > > +
> > > > > > +     ret =3D pthread_create(&fsyncer, NULL, fsync_loop, NULL);
> > > > > > +     if (ret !=3D 0) {
> > > > > > +             fprintf(stderr, "Failed to create writer thread: =
%d\n", ret);
> > > > > > +             return 4;
> > > > > > +     }
> > > > > > +
> > > > > > +     while (1) {
> > > > > > +             ret =3D do_write(fd, write_buf, pagesize, 0);
> > > > > > +             if (ret !=3D 0) {
> > > > > > +                     perror("Write failed");
> > > > > > +                     exit(5);
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > diff --git a/tests/generic/363 b/tests/generic/363
> > > > > > new file mode 100755
> > > > > > index 00000000..21159e24
> > > > > > --- /dev/null
> > > > > > +++ b/tests/generic/363
> > > > > > @@ -0,0 +1,30 @@
> > > > > > +#! /bin/bash
> > > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Rese=
rved.
> > > > > > +#
> > > > > > +# FS QA Test 363
> > > > > > +#
> > > > > > +# Test that a program that has 2 threads using the same file d=
escriptor and
> > > > > > +# concurrently doing direct IO writes and fsync doesn't trigge=
r any crash or
> > > > > > +# deadlock.
> > > > > > +#
> > > > > > +. ./common/preamble
> > > > > > +_begin_fstest auto quick
> > > > > > +
> > > > > > +_require_test
> > > > > > +_require_odirect
> > > > > > +_require_test_program dio-write-fsync-same-fd
> > > > > > +_require_command "$TIMEOUT_PROG" timeout
> > > > > > +
> > > > > > +[ $FSTYP =3D=3D "btrfs" ] && \
> > > > > > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > > > > +     "btrfs: fix race between direct IO write and fsync when u=
sing same fd"
> > > > > > +
> > > > > > +# On error the test program writes messages to stderr, causing=
 a golden output
> > > > > > +# mismatch and making the test fail.
> > > > > > +$TIMEOUT_PROG 10s $here/src/dio-write-fsync-same-fd $TEST_DIR/=
dio-write-fsync-same-fd
> > > > >
> > > > > Hi Filipe,
> > > > >
> > > > > Thanks for this new test case. How reproducible is this test? I t=
ried to run it on
> > > > > a linux v6.11-rc3+ without above kernel fix, but test passed. Doe=
s this reproducer
> > > > > need some specical test conditions?
> > > >
> > > > It's a race condition so it may not trigger so easily in every mach=
ine.
> > > >
> > > > In my box it takes less than 1 second, so I left the timeout in the
> > > > test at 10s. You can try to increase that, say, 30 seconds, 60 seco=
nds
> > > > and see if it triggers.
> > > > Don't know what distro you are using, but make sure that the kernel
> > > > config has CONFIG_BTRFS_ASSERT=3Dy, which is a default in some dist=
ros
> > > > like SUSE ones.
> > > >
> > > > When the test fails it should have a trace like this in dmesg:
> > >
> > > Oh, so this test depends on CONFIG_BTRFS_ASSERT=3Dy, or it always tes=
t passed? I tested
> > > on general kernel of fedora 42, which doesn't enable this config.
> > >
> > > There's a _require_xfs_debug helper in common/xfs (and _require_no_xf=
s_debug
> > > too), does btrfs have similar method to check that?
> >
> > No, we don't.
> >
> > I don't think we should make the test run only if the kernel config
> > has CONFIG_BTRFS_ASSERT=3Dy.
> >
> > This particular regression is easily detected with
> > CONFIG_BTRFS_ASSERT=3Dy, and btrfs developers and the CI we use have
> > that setting enabled.
> >
> > The fact that this regression happened shows that fstests didn't have
> > this type of scenario covered, which happens in practice with qemu's
> > workload (from two user reports).
> >
> > I'm adding the test not just to prove the assertion can be triggered
> > for this particular regression, but also to make sure no other types
> > of regressions happen in the future which may be unrelated to the
> > reason for the current regression.
> >
> > Hope that makes sense.
>
> Sure, I don't tend to NACK this patch, just ask how reproducible, due to
> I tried to do below loop testing over night.
>
>  # which true;do ./check -s default generic/363 || break;done
>
> How about we add a comment on the _fixed_by line, to explain "better
> to have CONFIG_BTRFS_ASSERT=3Dy to reproduce this bug"?
>
> I can add that line when I merge it, if you agree with that too.

Something like this on top of the the _fixed_by_kernel_commit line:

# Triggers very frequently with kernel config CONFIG_BTRFS_ASSERT=3Dy.

Thanks.

>
> Thanks,
> Zorro
>
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > >
> > > > [362164.748435] run fstests generic/363 at 2024-09-02 22:40:19
> > > > [362165.667172] assertion failed: inode_is_locked(&inode->vfs_inode=
),
> > > > in fs/btrfs/ordered-data.c:1018
> > > > [362165.668629] ------------[ cut here ]------------
> > > > [362165.669542] kernel BUG at fs/btrfs/ordered-data.c:1018!
> > > > [362165.670902] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > > > [362165.682061] CPU: 3 UID: 0 PID: 3687221 Comm: dio-write-fsync No=
t
> > > > tainted 6.11.0-rc5-btrfs-next-172+ #1
> > > > [362165.684672] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6),
> > > > BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > > > [362165.687682] RIP:
> > > > 0010:btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> > > > [362165.689592] Code: 00 e8 22 3a ac e3 e9 1b ff ff ff b9 fa 03 00 =
00
> > > > 48 c7 c2 61 39 e3 c0 48 c7 c6 20 d1 e3 c0 48 c7 c7 30 cf e3 c0 e8 d=
e
> > > > 10 64 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90=
 90
> > > > 90 90
> > > > [362165.693968] RSP: 0018:ffffb9f1c264fe20 EFLAGS: 00010246
> > > > [362165.694959] RAX: 0000000000000055 RBX: ffff962c3d01bd88 RCX:
> > > > 0000000000000000
> > > > [362165.696778] RDX: 0000000000000000 RSI: ffffffffa544b924 RDI:
> > > > 00000000ffffffff
> > > > [362165.698751] RBP: ffff962b5da07f00 R08: 0000000000000000 R09:
> > > > ffffb9f1c264fc68
> > > > [362165.700707] R10: 0000000000000001 R11: 0000000000000001 R12:
> > > > ffff962c3d01bc00
> > > > [362165.702273] R13: ffff962b215af800 R14: 0000000000000001 R15:
> > > > 0000000000000000
> > > > [362165.704168] FS:  00007fe3630006c0(0000) GS:ffff962e2fac0000(000=
0)
> > > > knlGS:0000000000000000
> > > > [362165.706002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [362165.707258] CR2: 00007fe362ffff78 CR3: 00000002a3f5e005 CR4:
> > > > 0000000000370ef0
> > > > [362165.708844] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > > 0000000000000000
> > > > [362165.710344] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > 0000000000000400
> > > > [362165.711926] Call Trace:
> > > > [362165.712563]  <TASK>
> > > > [362165.713122]  ? __die_body+0x1b/0x60
> > > > [362165.713933]  ? die+0x39/0x60
> > > > [362165.714648]  ? do_trap+0xe4/0x110
> > > > [362165.715466]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b=
0 [btrfs]
> > > > [362165.717253]  ? do_error_trap+0x6a/0x90
> > > > [362165.718257]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b=
0 [btrfs]
> > > > [362165.720057]  ? exc_invalid_op+0x4e/0x70
> > > > [362165.721062]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b=
0 [btrfs]
> > > > [362165.722822]  ? asm_exc_invalid_op+0x16/0x20
> > > > [362165.723934]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b=
0 [btrfs]
> > > > [362165.725751]  btrfs_sync_file+0x227/0x510 [btrfs]
> > > > [362165.726923]  do_fsync+0x38/0x70
> > > > [362165.727732]  __x64_sys_fsync+0x10/0x20
> > > > [362165.728679]  do_syscall_64+0x4a/0x110
> > > > [362165.729642]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > > > [362165.730741] RIP: 0033:0x7fe36315397a
> > > > [362165.731598] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 =
00
> > > > 48 83 ec 18 89 7c 24 0c e8 b3 49 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 0=
0
> > > > 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 13 4a f8 ff=
 8b
> > > > 44 24
> > > > [362165.735846] RSP: 002b:00007fe362fffeb0 EFLAGS: 00000293 ORIG_RA=
X:
> > > > 000000000000004a
> > > > [362165.737208] RAX: ffffffffffffffda RBX: 00007fe363000cdc RCX:
> > > > 00007fe36315397a
> > > > [362165.738763] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > > > 0000000000000003
> > > > [362165.740062] RBP: 0000000000000000 R08: 0000000000000000 R09:
> > > > 00007fe3630006c0
> > > > [362165.741463] R10: 00007fe363067400 R11: 0000000000000293 R12:
> > > > ffffffffffffff88
> > > > [362165.743280] R13: 0000000000000000 R14: 00007fffaa292c10 R15:
> > > > 00007fe362800000
> > > > [362165.744494]  </TASK>
> > > > [362165.744954] Modules linked in: btrfs xfs dm_zero dm_snapshot
> > > > dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_write=
s
> > > > dm_dust dm_flakey dm_mod loop blake2b_generic xor raid6_pq libcrc32=
c
> > > > overlay intel_rapl_msr intel_rapl_common crct10dif_pclmul
> > > > ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_inte=
l
> > > > gf128mul crypto_simd cryptd bochs rapl drm_vram_helper drm_ttm_help=
er
> > > > ttm input_leds led_class drm_kms_helper pcspkr sg button evdev
> > > > serio_raw qemu_fw_cfg binfmt_misc drm ip_tables x_tables autofs4 ex=
t4
> > > > crc32c_generic crc16 mbcache jbd2 sd_mod virtio_net net_failover
> > > > virtio_scsi failover ata_generic ata_piix libata crc32_pclmul scsi_=
mod
> > > > crc32c_intel virtio_pci virtio psmouse virtio_pci_legacy_dev i2c_pi=
ix4
> > > > virtio_pci_modern_dev virtio_ring i2c_smbus scsi_common [last
> > > > unloaded: btrfs]
> > > > [362165.756697] ---[ end trace 0000000000000000 ]---
> > > > [362165.757582] RIP:
> > > > 0010:btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> > > > [362165.758955] Code: 00 e8 22 3a ac e3 e9 1b ff ff ff b9 fa 03 00 =
00
> > > > 48 c7 c2 61 39 e3 c0 48 c7 c6 20 d1 e3 c0 48 c7 c7 30 cf e3 c0 e8 d=
e
> > > > 10 64 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90=
 90
> > > > 90 90
> > > > [362165.762283] RSP: 0018:ffffb9f1c264fe20 EFLAGS: 00010246
> > > > [362165.763164] RAX: 0000000000000055 RBX: ffff962c3d01bd88 RCX:
> > > > 0000000000000000
> > > > [362165.764414] RDX: 0000000000000000 RSI: ffffffffa544b924 RDI:
> > > > 00000000ffffffff
> > > > [362165.765774] RBP: ffff962b5da07f00 R08: 0000000000000000 R09:
> > > > ffffb9f1c264fc68
> > > > [362165.767001] R10: 0000000000000001 R11: 0000000000000001 R12:
> > > > ffff962c3d01bc00
> > > > [362165.768223] R13: ffff962b215af800 R14: 0000000000000001 R15:
> > > > 0000000000000000
> > > > [362165.769369] FS:  00007fe3630006c0(0000) GS:ffff962e2fac0000(000=
0)
> > > > knlGS:0000000000000000
> > > > [362165.771117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [362165.772435] CR2: 00007fe362ffff78 CR3: 00000002a3f5e005 CR4:
> > > > 0000000000370ef0
> > > > [362165.773934] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > > 0000000000000000
> > > > [362165.775357] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > 0000000000000400
> > > >
> > > >
> > > > >
> > > > >   # ./check -s default generic/363
> > > > >   SECTION       -- default
> > > > >   FSTYP         -- btrfs
> > > > >   PLATFORM      -- Linux/x86_64 dell-xxxxx-xx 6.11.0-0.rc3.202408=
14git6b0f8db921ab.32.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14 16:46:57=
 UTC 2024
> > > > >   MKFS_OPTIONS  -- /dev/sda6
> > > > >   MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/=
sda6 /mnt/scratch
> > > > >
> > > > >   generic/363 10s ...  10s
> > > > >   Ran: generic/363
> > > > >   Passed all 1 test
> > > > >
> > > > > Thanks,
> > > > > Zorro
> > > > >
> > > > > > +
> > > > > > +# success, all done
> > > > > > +echo "Silence is golden"
> > > > > > +status=3D0
> > > > > > +exit
> > > > > > diff --git a/tests/generic/363.out b/tests/generic/363.out
> > > > > > new file mode 100644
> > > > > > index 00000000..d03d2dc2
> > > > > > --- /dev/null
> > > > > > +++ b/tests/generic/363.out
> > > > > > @@ -0,0 +1,2 @@
> > > > > > +QA output created by 363
> > > > > > +Silence is golden
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
>

