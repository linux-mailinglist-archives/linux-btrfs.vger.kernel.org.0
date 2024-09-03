Return-Path: <linux-btrfs+bounces-7784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46ED969961
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 11:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D67D285C17
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 09:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F2B1A0BD8;
	Tue,  3 Sep 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfeN6C31"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83371A0BC4;
	Tue,  3 Sep 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356506; cv=none; b=IzrorjPJivKdrhrootR/jQFQrjMp0ALN2AwnlXfCWK1tLaQ5HQVwTx2aaolKMALJE/n6Gi+HQ3cL4FE6Koak1imBef0Z08T/4bWWEK5LiSNWjHF5iqO4n4KJgvOz+sVQL7m7v6NYBuqlwxyDhpAufUBE4V4Urob2PXpRcoL+DNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356506; c=relaxed/simple;
	bh=UsLtkIMrCVO1jFS55hc0SDXHECb51spK43lxv7AtjCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTinZladKz8HFtVONGwJeINZcpESVbnRKNrbIE2dk2sX/Fy6mLEGDoylORhaqDB0Ziq9UWRPM0JMyFaWzQH4fC1AQBkMJCcxNSX2dlm3lCXVv9hgvpw71H/ADB/BYScHFjZSqXUZYItRJ6Bw8YIk+1+8T9DEhFg9K7eR8cd9X1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfeN6C31; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554E8C4CEC4;
	Tue,  3 Sep 2024 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725356505;
	bh=UsLtkIMrCVO1jFS55hc0SDXHECb51spK43lxv7AtjCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YfeN6C313RneThsdFWqwnselQrKi/h9OxMIJ6Ex7EDbGepZEx4itZDyPOoauWQ/J3
	 h/ak2urac7MuGScF2nJC4LvswvSlzIRXvk5jgWBRfUxaDDCk8NxOm/hWKPe89Bz1/N
	 4kIj6+93Nq/Op5VSmn93hHsQs0MAg9dyLkO0THpvCOXC/BgtBsMkCX1jMgj3NV7K/w
	 TNYvCGPNja8u4N7blW9PFJPqcgguExhP+9ZFeNziselvTee/7DqL++j0shFaKPx0b6
	 3oEicifcfi2fk1bxHj1tsl3TzQFXzC2YhKvmfU7W1QhNCl7pidI/P5M/RIXCgMNyD8
	 Ynyvtb7+J5GUQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86b46c4831so561300166b.1;
        Tue, 03 Sep 2024 02:41:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWJdBwZpXkvymexCZqIB71wB1OuoQiH/vG5m2J5Nmb6FZNr4jwfLYycqkbe0wTjfsPWF5RLkCIOkxg+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgBni8vO+RnCpo3oanQthR7m3Rutp6VAFBTOTXEmVJ2N8p9kuu
	K59nXTM9D3vNB3w+fSjEQHrAyGHptJL4AJ+B/cgDr+oiOkew04wBVUCqo/lWG6Esx2BCt50bjvH
	ytFfxvN5ckr+JTd1RDBsKTYAMQv4=
X-Google-Smtp-Source: AGHT+IHN/44ZMPfQoTqLfZsKc1Dd+P8lTdRHHB2uSZA5C7q/h9bebkWzggz5z03ZrLS4/u3hjOA7OUoq+Z4Dv7ofFeg=
X-Received: by 2002:a17:906:dc94:b0:a86:821e:8a28 with SMTP id
 a640c23a62f3a-a89d884953amr636476566b.54.1725356503737; Tue, 03 Sep 2024
 02:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
 <20240902202856.e5mqgsbwmiwxs4qe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7vDpoG=k55yh9rJQWw=sit5fMkjPZMpVfwf7629b_hsA@mail.gmail.com> <20240903040907.gqfprq4ul6x7s2kt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240903040907.gqfprq4ul6x7s2kt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 3 Sep 2024 10:41:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4WSd7woy_cDmQ-1Z45zgMDdyfSS-2uzhOqkHisQewWXw@mail.gmail.com>
Message-ID: <CAL3q7H4WSd7woy_cDmQ-1Z45zgMDdyfSS-2uzhOqkHisQewWXw@mail.gmail.com>
Subject: Re: [PATCH] generic: test concurrent direct IO writes and fsync using
 same fd
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 5:09=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Mon, Sep 02, 2024 at 10:45:33PM +0100, Filipe Manana wrote:
> > On Mon, Sep 2, 2024 at 9:29=E2=80=AFPM Zorro Lang <zlang@redhat.com> wr=
ote:
> > >
> > > On Fri, Aug 30, 2024 at 12:10:21AM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test that a program that has 2 threads using the same file descript=
or and
> > > > concurrently doing direct IO writes and fsync doesn't trigger any c=
rash
> > > > or deadlock.
> > > >
> > > > This is motivated by a bug found in btrfs fixed by the following pa=
tch:
> > > >
> > > >   "btrfs: fix race between direct IO write and fsync when using sam=
e fd"
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  .gitignore                    |   1 +
> > > >  src/Makefile                  |   2 +-
> > > >  src/dio-write-fsync-same-fd.c | 106 ++++++++++++++++++++++++++++++=
++++
> > > >  tests/generic/363             |  30 ++++++++++
> > > >  tests/generic/363.out         |   2 +
> > > >  5 files changed, 140 insertions(+), 1 deletion(-)
> > > >  create mode 100644 src/dio-write-fsync-same-fd.c
> > > >  create mode 100755 tests/generic/363
> > > >  create mode 100644 tests/generic/363.out
> > > >
> > > > diff --git a/.gitignore b/.gitignore
> > > > index 36083e9d..57519263 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -76,6 +76,7 @@ tags
> > > >  /src/dio-buf-fault
> > > >  /src/dio-interleaved
> > > >  /src/dio-invalidate-cache
> > > > +/src/dio-write-fsync-same-fd
> > > >  /src/dirhash_collide
> > > >  /src/dirperf
> > > >  /src/dirstress
> > > > diff --git a/src/Makefile b/src/Makefile
> > > > index b3da59a0..b9ad6b5f 100644
> > > > --- a/src/Makefile
> > > > +++ b/src/Makefile
> > > > @@ -20,7 +20,7 @@ TARGETS =3D dirstress fill fill2 getpagesize hole=
s lstat64 \
> > > >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enos=
pc \
> > > >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocs=
tale \
> > > >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rew=
inddir-test \
> > > > -     readdir-while-renames dio-append-buf-fault
> > > > +     readdir-while-renames dio-append-buf-fault dio-write-fsync-sa=
me-fd
> > > >
> > > >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pat=
tern_reader \
> > > >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptes=
t \
> > > > diff --git a/src/dio-write-fsync-same-fd.c b/src/dio-write-fsync-sa=
me-fd.c
> > > > new file mode 100644
> > > > index 00000000..79472a9e
> > > > --- /dev/null
> > > > +++ b/src/dio-write-fsync-same-fd.c
> > > > @@ -0,0 +1,106 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserv=
ed.
> > > > + */
> > > > +
> > > > +/*
> > > > + * Test two threads working with the same file descriptor, one doi=
ng direct IO
> > > > + * writes into the file and the other just doing fsync calls. We w=
ant to verify
> > > > + * that there are no crashes or deadlocks.
> > > > + *
> > > > + * This program never finishes, it starts two infinite loops to wr=
ite and fsync
> > > > + * the file. It's meant to be called with the 'timeout' program fr=
om coreutils.
> > > > + */
> > > > +
> > > > +/* Get the O_DIRECT definition. */
> > > > +#ifndef _GNU_SOURCE
> > > > +#define _GNU_SOURCE
> > > > +#endif
> > > > +
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <unistd.h>
> > > > +#include <stdint.h>
> > > > +#include <fcntl.h>
> > > > +#include <errno.h>
> > > > +#include <string.h>
> > > > +#include <pthread.h>
> > > > +
> > > > +static int fd;
> > > > +
> > > > +static ssize_t do_write(int fd, const void *buf, size_t count, off=
_t offset)
> > > > +{
> > > > +        while (count > 0) {
> > > > +             ssize_t ret;
> > > > +
> > > > +             ret =3D pwrite(fd, buf, count, offset);
> > > > +             if (ret < 0) {
> > > > +                     if (errno =3D=3D EINTR)
> > > > +                             continue;
> > > > +                     return ret;
> > > > +             }
> > > > +             count -=3D ret;
> > > > +             buf +=3D ret;
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void *fsync_loop(void *arg)
> > > > +{
> > > > +     while (1) {
> > > > +             int ret;
> > > > +
> > > > +             ret =3D fsync(fd);
> > > > +             if (ret !=3D 0) {
> > > > +                     perror("Fsync failed");
> > > > +                     exit(6);
> > > > +             }
> > > > +     }
> > > > +}
> > > > +
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +     long pagesize;
> > > > +     void *write_buf;
> > > > +     pthread_t fsyncer;
> > > > +     int ret;
> > > > +
> > > > +     if (argc !=3D 2) {
> > > > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > > > +             return 1;
> > > > +     }
> > > > +
> > > > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT,=
 0666);
> > > > +     if (fd =3D=3D -1) {
> > > > +             perror("Failed to open/create file");
> > > > +             return 1;
> > > > +     }
> > > > +
> > > > +     pagesize =3D sysconf(_SC_PAGE_SIZE);
> > > > +     if (pagesize =3D=3D -1) {
> > > > +             perror("Failed to get page size");
> > > > +             return 2;
> > > > +     }
> > > > +
> > > > +     ret =3D posix_memalign(&write_buf, pagesize, pagesize);
> > > > +     if (ret) {
> > > > +             perror("Failed to allocate buffer");
> > > > +             return 3;
> > > > +     }
> > > > +
> > > > +     ret =3D pthread_create(&fsyncer, NULL, fsync_loop, NULL);
> > > > +     if (ret !=3D 0) {
> > > > +             fprintf(stderr, "Failed to create writer thread: %d\n=
", ret);
> > > > +             return 4;
> > > > +     }
> > > > +
> > > > +     while (1) {
> > > > +             ret =3D do_write(fd, write_buf, pagesize, 0);
> > > > +             if (ret !=3D 0) {
> > > > +                     perror("Write failed");
> > > > +                     exit(5);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     return 0;
> > > > +}
> > > > diff --git a/tests/generic/363 b/tests/generic/363
> > > > new file mode 100755
> > > > index 00000000..21159e24
> > > > --- /dev/null
> > > > +++ b/tests/generic/363
> > > > @@ -0,0 +1,30 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved=
.
> > > > +#
> > > > +# FS QA Test 363
> > > > +#
> > > > +# Test that a program that has 2 threads using the same file descr=
iptor and
> > > > +# concurrently doing direct IO writes and fsync doesn't trigger an=
y crash or
> > > > +# deadlock.
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick
> > > > +
> > > > +_require_test
> > > > +_require_odirect
> > > > +_require_test_program dio-write-fsync-same-fd
> > > > +_require_command "$TIMEOUT_PROG" timeout
> > > > +
> > > > +[ $FSTYP =3D=3D "btrfs" ] && \
> > > > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > > +     "btrfs: fix race between direct IO write and fsync when using=
 same fd"
> > > > +
> > > > +# On error the test program writes messages to stderr, causing a g=
olden output
> > > > +# mismatch and making the test fail.
> > > > +$TIMEOUT_PROG 10s $here/src/dio-write-fsync-same-fd $TEST_DIR/dio-=
write-fsync-same-fd
> > >
> > > Hi Filipe,
> > >
> > > Thanks for this new test case. How reproducible is this test? I tried=
 to run it on
> > > a linux v6.11-rc3+ without above kernel fix, but test passed. Does th=
is reproducer
> > > need some specical test conditions?
> >
> > It's a race condition so it may not trigger so easily in every machine.
> >
> > In my box it takes less than 1 second, so I left the timeout in the
> > test at 10s. You can try to increase that, say, 30 seconds, 60 seconds
> > and see if it triggers.
> > Don't know what distro you are using, but make sure that the kernel
> > config has CONFIG_BTRFS_ASSERT=3Dy, which is a default in some distros
> > like SUSE ones.
> >
> > When the test fails it should have a trace like this in dmesg:
>
> Oh, so this test depends on CONFIG_BTRFS_ASSERT=3Dy, or it always test pa=
ssed? I tested
> on general kernel of fedora 42, which doesn't enable this config.
>
> There's a _require_xfs_debug helper in common/xfs (and _require_no_xfs_de=
bug
> too), does btrfs have similar method to check that?

No, we don't.

I don't think we should make the test run only if the kernel config
has CONFIG_BTRFS_ASSERT=3Dy.

This particular regression is easily detected with
CONFIG_BTRFS_ASSERT=3Dy, and btrfs developers and the CI we use have
that setting enabled.

The fact that this regression happened shows that fstests didn't have
this type of scenario covered, which happens in practice with qemu's
workload (from two user reports).

I'm adding the test not just to prove the assertion can be triggered
for this particular regression, but also to make sure no other types
of regressions happen in the future which may be unrelated to the
reason for the current regression.

Hope that makes sense.

>
> Thanks,
> Zorro
>
> >
> > [362164.748435] run fstests generic/363 at 2024-09-02 22:40:19
> > [362165.667172] assertion failed: inode_is_locked(&inode->vfs_inode),
> > in fs/btrfs/ordered-data.c:1018
> > [362165.668629] ------------[ cut here ]------------
> > [362165.669542] kernel BUG at fs/btrfs/ordered-data.c:1018!
> > [362165.670902] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > [362165.682061] CPU: 3 UID: 0 PID: 3687221 Comm: dio-write-fsync Not
> > tainted 6.11.0-rc5-btrfs-next-172+ #1
> > [362165.684672] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> > [362165.687682] RIP:
> > 0010:btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> > [362165.689592] Code: 00 e8 22 3a ac e3 e9 1b ff ff ff b9 fa 03 00 00
> > 48 c7 c2 61 39 e3 c0 48 c7 c6 20 d1 e3 c0 48 c7 c7 30 cf e3 c0 e8 de
> > 10 64 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
> > 90 90
> > [362165.693968] RSP: 0018:ffffb9f1c264fe20 EFLAGS: 00010246
> > [362165.694959] RAX: 0000000000000055 RBX: ffff962c3d01bd88 RCX:
> > 0000000000000000
> > [362165.696778] RDX: 0000000000000000 RSI: ffffffffa544b924 RDI:
> > 00000000ffffffff
> > [362165.698751] RBP: ffff962b5da07f00 R08: 0000000000000000 R09:
> > ffffb9f1c264fc68
> > [362165.700707] R10: 0000000000000001 R11: 0000000000000001 R12:
> > ffff962c3d01bc00
> > [362165.702273] R13: ffff962b215af800 R14: 0000000000000001 R15:
> > 0000000000000000
> > [362165.704168] FS:  00007fe3630006c0(0000) GS:ffff962e2fac0000(0000)
> > knlGS:0000000000000000
> > [362165.706002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [362165.707258] CR2: 00007fe362ffff78 CR3: 00000002a3f5e005 CR4:
> > 0000000000370ef0
> > [362165.708844] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [362165.710344] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [362165.711926] Call Trace:
> > [362165.712563]  <TASK>
> > [362165.713122]  ? __die_body+0x1b/0x60
> > [362165.713933]  ? die+0x39/0x60
> > [362165.714648]  ? do_trap+0xe4/0x110
> > [362165.715466]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [b=
trfs]
> > [362165.717253]  ? do_error_trap+0x6a/0x90
> > [362165.718257]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [b=
trfs]
> > [362165.720057]  ? exc_invalid_op+0x4e/0x70
> > [362165.721062]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [b=
trfs]
> > [362165.722822]  ? asm_exc_invalid_op+0x16/0x20
> > [362165.723934]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [b=
trfs]
> > [362165.725751]  btrfs_sync_file+0x227/0x510 [btrfs]
> > [362165.726923]  do_fsync+0x38/0x70
> > [362165.727732]  __x64_sys_fsync+0x10/0x20
> > [362165.728679]  do_syscall_64+0x4a/0x110
> > [362165.729642]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [362165.730741] RIP: 0033:0x7fe36315397a
> > [362165.731598] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00
> > 48 83 ec 18 89 7c 24 0c e8 b3 49 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 13 4a f8 ff 8b
> > 44 24
> > [362165.735846] RSP: 002b:00007fe362fffeb0 EFLAGS: 00000293 ORIG_RAX:
> > 000000000000004a
> > [362165.737208] RAX: ffffffffffffffda RBX: 00007fe363000cdc RCX:
> > 00007fe36315397a
> > [362165.738763] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 0000000000000003
> > [362165.740062] RBP: 0000000000000000 R08: 0000000000000000 R09:
> > 00007fe3630006c0
> > [362165.741463] R10: 00007fe363067400 R11: 0000000000000293 R12:
> > ffffffffffffff88
> > [362165.743280] R13: 0000000000000000 R14: 00007fffaa292c10 R15:
> > 00007fe362800000
> > [362165.744494]  </TASK>
> > [362165.744954] Modules linked in: btrfs xfs dm_zero dm_snapshot
> > dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes
> > dm_dust dm_flakey dm_mod loop blake2b_generic xor raid6_pq libcrc32c
> > overlay intel_rapl_msr intel_rapl_common crct10dif_pclmul
> > ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel
> > gf128mul crypto_simd cryptd bochs rapl drm_vram_helper drm_ttm_helper
> > ttm input_leds led_class drm_kms_helper pcspkr sg button evdev
> > serio_raw qemu_fw_cfg binfmt_misc drm ip_tables x_tables autofs4 ext4
> > crc32c_generic crc16 mbcache jbd2 sd_mod virtio_net net_failover
> > virtio_scsi failover ata_generic ata_piix libata crc32_pclmul scsi_mod
> > crc32c_intel virtio_pci virtio psmouse virtio_pci_legacy_dev i2c_piix4
> > virtio_pci_modern_dev virtio_ring i2c_smbus scsi_common [last
> > unloaded: btrfs]
> > [362165.756697] ---[ end trace 0000000000000000 ]---
> > [362165.757582] RIP:
> > 0010:btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> > [362165.758955] Code: 00 e8 22 3a ac e3 e9 1b ff ff ff b9 fa 03 00 00
> > 48 c7 c2 61 39 e3 c0 48 c7 c6 20 d1 e3 c0 48 c7 c7 30 cf e3 c0 e8 de
> > 10 64 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
> > 90 90
> > [362165.762283] RSP: 0018:ffffb9f1c264fe20 EFLAGS: 00010246
> > [362165.763164] RAX: 0000000000000055 RBX: ffff962c3d01bd88 RCX:
> > 0000000000000000
> > [362165.764414] RDX: 0000000000000000 RSI: ffffffffa544b924 RDI:
> > 00000000ffffffff
> > [362165.765774] RBP: ffff962b5da07f00 R08: 0000000000000000 R09:
> > ffffb9f1c264fc68
> > [362165.767001] R10: 0000000000000001 R11: 0000000000000001 R12:
> > ffff962c3d01bc00
> > [362165.768223] R13: ffff962b215af800 R14: 0000000000000001 R15:
> > 0000000000000000
> > [362165.769369] FS:  00007fe3630006c0(0000) GS:ffff962e2fac0000(0000)
> > knlGS:0000000000000000
> > [362165.771117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [362165.772435] CR2: 00007fe362ffff78 CR3: 00000002a3f5e005 CR4:
> > 0000000000370ef0
> > [362165.773934] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [362165.775357] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> >
> >
> > >
> > >   # ./check -s default generic/363
> > >   SECTION       -- default
> > >   FSTYP         -- btrfs
> > >   PLATFORM      -- Linux/x86_64 dell-xxxxx-xx 6.11.0-0.rc3.20240814gi=
t6b0f8db921ab.32.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14 16:46:57 UTC=
 2024
> > >   MKFS_OPTIONS  -- /dev/sda6
> > >   MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda6=
 /mnt/scratch
> > >
> > >   generic/363 10s ...  10s
> > >   Ran: generic/363
> > >   Passed all 1 test
> > >
> > > Thanks,
> > > Zorro
> > >
> > > > +
> > > > +# success, all done
> > > > +echo "Silence is golden"
> > > > +status=3D0
> > > > +exit
> > > > diff --git a/tests/generic/363.out b/tests/generic/363.out
> > > > new file mode 100644
> > > > index 00000000..d03d2dc2
> > > > --- /dev/null
> > > > +++ b/tests/generic/363.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 363
> > > > +Silence is golden
> > > > --
> > > > 2.43.0
> > > >
> > > >
> > >
> >
>

