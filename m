Return-Path: <linux-btrfs+bounces-6985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A65947DB9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 17:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3F8281CA9
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62B5154C0E;
	Mon,  5 Aug 2024 15:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dvs+q0+m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B8B13BC0C;
	Mon,  5 Aug 2024 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870585; cv=none; b=kn1TiXBeMOaxU/suptbEq4SKauVD2mDroz4Hia22+mq0XlbRcBX7fRe/7BIm1wQkHLwruiiHP23NC50QhP8lhBrRgVivBvVdG/20E28HCcxqEn51EzzmI55yN7bbcaXyzkRaOHepIgpvPquwrlg37RDaggPvv+1V2aMMrz9ap7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870585; c=relaxed/simple;
	bh=bxlu9baGgADmy9cMKGBkLuTZzzXUhGPgF4ki4tHIFC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bKXgJpbTFzAqndbbtqpSwQsdo2p1RKRuyvjk1FHVIsR8DCGOQ9PyizXKVwTevln6F2OMKu4TI2KGhvmM8+mvk5Zz5n2VlolF+WV6VFE6lzq1hbKJs1Q1Uyj081PqC7U7KIPecnD/Yspk0WoDdbSsnQ0DgR+BMpo0B2Rnq0toilw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dvs+q0+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804DDC32782;
	Mon,  5 Aug 2024 15:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722870584;
	bh=bxlu9baGgADmy9cMKGBkLuTZzzXUhGPgF4ki4tHIFC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dvs+q0+mhIuC2QSupQUdyruEyrD6ft01OPZP9mEDM0SLiK8uFEdD9retaUA3ixA+I
	 uwSb9euoucm6ZhWW1rDVWGqIde9CKnd7F3wWcI2USEko9b/go1EFoquz+cX3OZAxp4
	 R2iX5NNKxbLJyZUy7z3YFm7VBuSNuHFlb4p8c8diEftwOrhefDOlKEgIiTmefNljH1
	 yoljs0J9d35B9hyUuplFC/46Zi3Ha8nvV5Mc2lDGMBQODMaMsmagnGfASP2CACUagH
	 5Otrcc9In26zM+ScbVd5/rIiqdwf9GyTCrmnyitI7J/m7kkK8oXetXUfu0g49ot2//
	 yTHnHLgQuPyAw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a975fb47eso1408554266b.3;
        Mon, 05 Aug 2024 08:09:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxW4rGOv43Jw3M9HCKtprETRVMoX887lAx2GGD4Hla2C50DH0Hi4gOUJnVCkXhgIsATUoYLMwsY1DY4q8Dw4tjayYAyCOeUlN99E8=
X-Gm-Message-State: AOJu0YxT8cNRtTxRK2TKPw1KbAGZbC6tmYidk+H0ZW4WxYGGqJLvvH1G
	ACDYmI/xfKZFf2YgR5mh/pxGkjQPFKchzZH8RFIMtJgo+E82FFH14YPELYUMFaiLNuzP5KxpVDV
	kdsFwIZwgAkhzR2z4Hea819mC6MQ=
X-Google-Smtp-Source: AGHT+IHVPGkePsp69tcyok7VvPK2QbTf2vNZLX9YPhYhx7i9DV9eqHj1zB5YFDOVaUpSLac/Kvd85mtbUmx0V8BHWxo=
X-Received: by 2002:a17:907:7f29:b0:a77:cd4f:e4f5 with SMTP id
 a640c23a62f3a-a7dc50feb0cmr974363566b.68.1722870582975; Mon, 05 Aug 2024
 08:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com>
 <20240728142842.iquah6ckxj7rfmvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4bo=1ZMQohRrAH+9B-M_gpdzXc7wYqXESpYWgwb77v6g@mail.gmail.com> <20240728165905.f2jofq7o55uo6ywa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240728165905.f2jofq7o55uo6ywa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Aug 2024 16:09:06 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4avzHN03WDiQ=hB0nwUOMoTPwru+dCtqLiXnc4hc6j9A@mail.gmail.com>
Message-ID: <CAL3q7H4avzHN03WDiQ=hB0nwUOMoTPwru+dCtqLiXnc4hc6j9A@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test page fault during direct IO write with O_APPEND
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 5:59=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Sun, Jul 28, 2024 at 04:14:42PM +0100, Filipe Manana wrote:
> > On Sun, Jul 28, 2024 at 3:28=E2=80=AFPM Zorro Lang <zlang@redhat.com> w=
rote:
> > >
> > > On Sat, Jul 27, 2024 at 12:28:16PM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test that doing a direct IO append write to a file when the input b=
uffer
> > > > was not yet faulted in, does not result in an incorrect file size.
> > > >
> > > > This exercises a bug on btrfs reported by users and which is fixed =
by
> > > > the following kernel patch:
> > > >
> > > >    "btrfs: fix corruption after buffer fault in during direct IO ap=
pend write"
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >
> > > > V2: Deal with partial writes by looping and writing any remaining d=
ata.
> > > >     Don't exit when the first test fails, instead let the second te=
st
> > > >     run as well.
> > >
> > > With this change I got two error lines this time [1]. Last time (V1) =
I
> > > only got "Wrong file size after first write, got 8192 expected 4096".
> >
> > Yes, it's expected.
> > As the changelog for v2 says, now the second test is run even if the
> > first one failed.
>
> Thanks, I'd like to merge this patch:
>
> Reviewed-by: Zorro Lang <zlang@redhat.com>

The kernel patch landed in Linus' tree, with a commit ID of 939b656bc8ab20.
Do you want me to send a new version replacing the xxxxxxxxxxx with
939b656bc8ab20, or can you do that when you pick the patch?

Thanks.

>
> >
> > > Does this mean this v2 change help this case to be better?
> >
> > I prefer it like that.
> > It's common in fstests to let all steps of a test run if possible
> > (i.e. we don't exit, call _fail, or anything equivalent, everywhere
> > unless the test can't proceed anymore).
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > [1]
> > > [root@dell-per750-41 xfstests]# ./check -s default generic/362
> > > SECTION       -- default
> > > FSTYP         -- btrfs
> > > PLATFORM      -- Linux/x86_64 dell-xx-xxxxxx 6.10.0-0.rc7.20240712git=
43db1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC =
2024
> > > MKFS_OPTIONS  -- /dev/sda6
> > > MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda6 /=
mnt/scratch
> > >
> > > generic/362 0s ... - output mismatch (see /root/git/xfstests/results/=
/default/generic/362.out.bad)
> > >     --- tests/generic/362.out   2024-07-28 22:22:06.098982182 +0800
> > >     +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-=
07-28 22:23:16.622577397 +0800
> > >     @@ -1,2 +1,4 @@
> > >      QA output created by 362
> > >     +Wrong file size after first write, got 8192 expected 4096
> > >     +Wrong file size after second write, got 12288 expected 8192
> > >      Silence is golden
> > >
> > >
> > > >
> > > >  .gitignore                 |   1 +
> > > >  src/Makefile               |   2 +-
> > > >  src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++=
++++
> > > >  tests/generic/362          |  28 +++++++
> > > >  tests/generic/362.out      |   2 +
> > > >  5 files changed, 177 insertions(+), 1 deletion(-)
> > > >  create mode 100644 src/dio-append-buf-fault.c
> > > >  create mode 100755 tests/generic/362
> > > >  create mode 100644 tests/generic/362.out
> > > >
> > > > diff --git a/.gitignore b/.gitignore
> > > > index b5f15162..97c7e001 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -72,6 +72,7 @@ tags
> > > >  /src/deduperace
> > > >  /src/detached_mounts_propagation
> > > >  /src/devzero
> > > > +/src/dio-append-buf-fault
> > > >  /src/dio-buf-fault
> > > >  /src/dio-interleaved
> > > >  /src/dio-invalidate-cache
> > > > diff --git a/src/Makefile b/src/Makefile
> > > > index 99796137..559209be 100644
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
> > > > -     readdir-while-renames
> > > > +     readdir-while-renames dio-append-buf-fault
> > > >
> > > >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pat=
tern_reader \
> > > >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptes=
t \
> > > > diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.=
c
> > > > new file mode 100644
> > > > index 00000000..72c23265
> > > > --- /dev/null
> > > > +++ b/src/dio-append-buf-fault.c
> > > > @@ -0,0 +1,145 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserv=
ed.
> > > > + */
> > > > +
> > > > +/*
> > > > + * Test a direct IO write in append mode with a buffer that was no=
t faulted in
> > > > + * (or just partially) before the write.
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
> > > > +#include <sys/mman.h>
> > > > +#include <sys/stat.h>
> > > > +
> > > > +static ssize_t do_write(int fd, const void *buf, size_t count)
> > > > +{
> > > > +        while (count > 0) {
> > > > +             ssize_t ret;
> > > > +
> > > > +             ret =3D write(fd, buf, count);
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
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +     struct stat stbuf;
> > > > +     int fd;
> > > > +     long pagesize;
> > > > +     void *buf;
> > > > +     ssize_t ret;
> > > > +
> > > > +     if (argc !=3D 2) {
> > > > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > > > +             return 1;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * First try an append write against an empty file of a buffe=
r with a
> > > > +      * size matching the page size. The buffer is not faulted in =
before
> > > > +      * attempting the write.
> > > > +      */
> > > > +
> > > > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT =
| O_APPEND, 0666);
> > > > +     if (fd =3D=3D -1) {
> > > > +             perror("Failed to open/create file");
> > > > +             return 2;
> > > > +     }
> > > > +
> > > > +     pagesize =3D sysconf(_SC_PAGE_SIZE);
> > > > +     if (pagesize =3D=3D -1) {
> > > > +             perror("Failed to get page size");
> > > > +             return 3;
> > > > +     }
> > > > +
> > > > +     buf =3D mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> > > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > > +     if (buf =3D=3D MAP_FAILED) {
> > > > +             perror("Failed to allocate first buffer");
> > > > +             return 4;
> > > > +     }
> > > > +
> > > > +     ret =3D do_write(fd, buf, pagesize);
> > > > +     if (ret < 0) {
> > > > +             perror("First write failed");
> > > > +             return 5;
> > > > +     }
> > > > +
> > > > +     ret =3D fstat(fd, &stbuf);
> > > > +     if (ret < 0) {
> > > > +             perror("First stat failed");
> > > > +             return 6;
> > > > +     }
> > > > +
> > > > +     /* Don't exit on failure so that we run the second test below=
 too. */
> > > > +     if (stbuf.st_size !=3D pagesize)
> > > > +             fprintf(stderr,
> > > > +                     "Wrong file size after first write, got %jd e=
xpected %ld\n",
> > > > +                     (intmax_t)stbuf.st_size, pagesize);
> > > > +
> > > > +     munmap(buf, pagesize);
> > > > +     close(fd);
> > > > +
> > > > +     /*
> > > > +      * Now try an append write against an empty file of a buffer =
with a
> > > > +      * size matching twice the page size. Only the first page of =
the buffer
> > > > +      * is faulted in before attempting the write, so that the sec=
ond page
> > > > +      * should be faulted in during the write.
> > > > +      */
> > > > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT =
| O_APPEND, 0666);
> > > > +     if (fd =3D=3D -1) {
> > > > +             perror("Failed to open/create file");
> > > > +             return 7;
> > > > +     }
> > > > +
> > > > +     buf =3D mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > > +     if (buf =3D=3D MAP_FAILED) {
> > > > +             perror("Failed to allocate second buffer");
> > > > +             return 8;
> > > > +     }
> > > > +
> > > > +     /* Fault in first page of the buffer before the write. */
> > > > +     memset(buf, 0, 1);
> > > > +
> > > > +     ret =3D do_write(fd, buf, pagesize * 2);
> > > > +     if (ret < 0) {
> > > > +             perror("Second write failed");
> > > > +             return 9;
> > > > +     }
> > > > +
> > > > +     ret =3D fstat(fd, &stbuf);
> > > > +     if (ret < 0) {
> > > > +             perror("Second stat failed");
> > > > +             return 10;
> > > > +     }
> > > > +
> > > > +     if (stbuf.st_size !=3D pagesize * 2)
> > > > +             fprintf(stderr,
> > > > +                     "Wrong file size after second write, got %jd =
expected %ld\n",
> > > > +                     (intmax_t)stbuf.st_size, pagesize * 2);
> > > > +
> > > > +     munmap(buf, pagesize * 2);
> > > > +     close(fd);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > diff --git a/tests/generic/362 b/tests/generic/362
> > > > new file mode 100755
> > > > index 00000000..2c127347
> > > > --- /dev/null
> > > > +++ b/tests/generic/362
> > > > @@ -0,0 +1,28 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved=
.
> > > > +#
> > > > +# FS QA Test 362
> > > > +#
> > > > +# Test that doing a direct IO append write to a file when the inpu=
t buffer was
> > > > +# not yet faulted in, does not result in an incorrect file size.
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick
> > > > +
> > > > +_require_test
> > > > +_require_odirect
> > > > +_require_test_program dio-append-buf-fault
> > > > +
> > > > +[ $FSTYP =3D=3D "btrfs" ] && \
> > > > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > > +     "btrfs: fix corruption after buffer fault in during direct IO=
 append write"
> > > > +
> > > > +# On error the test program writes messages to stderr, causing a g=
olden output
> > > > +# mismatch and making the test fail.
> > > > +$here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
> > > > +
> > > > +# success, all done
> > > > +echo "Silence is golden"
> > > > +status=3D0
> > > > +exit
> > > > diff --git a/tests/generic/362.out b/tests/generic/362.out
> > > > new file mode 100644
> > > > index 00000000..0ff40905
> > > > --- /dev/null
> > > > +++ b/tests/generic/362.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 362
> > > > +Silence is golden
> > > > --
> > > > 2.43.0
> > > >
> > > >
> > >
> >
>

