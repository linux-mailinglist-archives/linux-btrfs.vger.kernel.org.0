Return-Path: <linux-btrfs+bounces-6812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A1893E5C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 17:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9243B2111A
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 15:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F0D4A9B0;
	Sun, 28 Jul 2024 15:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fldH9HMN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E9E3FE55;
	Sun, 28 Jul 2024 15:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722179722; cv=none; b=rvUw63g+16Fn9rnrBBsn5R52sWxtGhIvWIbZ4QDNK6m2ci+aqPJ6uKWfS1fZEVAF0sme12NsGjO3bQCuzwShgXAs4V+HLSVke72yrfgTzGF+pcQiwoEeF59djwwxQyp4zvGxkGcTRviQWL/p9JyAaoiQAGZsMCZbDtyS/gXP/AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722179722; c=relaxed/simple;
	bh=+JrOosRZhLpWqPpbwY4kMoLc1KjiRx+0PaVTmlQHO9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufcQcfnjGfpcxlcqNXwWJNfGYDtUTYKWnwwnj+JBsRQGUMG+lDdrUYiIXNBU2IYg+an2oYZ1U5pHV/tPtqdZyKrKFJpi5ccW67O5QYAvS428N+mr06pWTu0hpiVy4P1kWVnpFGdj8cj2kGmMAtER0EBogs/TERElygd1JVcyoow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fldH9HMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C2DC4AF0E;
	Sun, 28 Jul 2024 15:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722179721;
	bh=+JrOosRZhLpWqPpbwY4kMoLc1KjiRx+0PaVTmlQHO9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fldH9HMNrPf/IDwkc5ADymEkar37A9eSlwWB7ojs/mVV8Rpz2dB+IPwH++7gH6yif
	 9V9wjvq5YpZFQLa+fTwWgS9hvTPK2BWiyzRlU1poeXpda5eea/4ZcxJ06XW804iP9V
	 kWffX1fHPcfMsTEQY6R/1NZuqtohTOy3GJ8CKLdWaYPKEpZtcl7RJpkT6xjqadLviN
	 614y7MzT1sD1Lc7AxGPnNt/uxSIH4PwCjGGBRtsPKb8tnAhLWNc06HlcMMBHMaopuM
	 uJGVM0Wwunoh78RzLqq/hxvq4bkNPA8dTBooAbAoVVPk6v2/6o37bNsmpLyYob7o0k
	 7djl31oTlw1Zw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so6057041e87.0;
        Sun, 28 Jul 2024 08:15:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr9G6GYUsaiSddlh/koUu3WQ74NO78AC5vLpYVpre1Ka/LYRNuL8irTt3wQwDYSgSsSRBoAYgocSPGfRETFtnwKIBh4zQt+pmHDZI=
X-Gm-Message-State: AOJu0YzTsqhi5F+49QNGA8zqfRMz3mjBFvfdJ3HG9AqyKW86PXvXexKD
	XS1il6Vu0YQkiauArrYeb1kR62AdGW/97q1ugigyZDbry2um5wAFvsiBRymNuKCjZl2EGQiVj5x
	ruG0hG+1yweAerCFGNP6IH1hS64A=
X-Google-Smtp-Source: AGHT+IEEvnR85JOR+IgTo6e1BjBLDfamDZ9ft7FdmLgA1c9TwaZ4PJzfPQ3BS/nFDVrm3nEQqxLB0insYn/Q/+U/51E=
X-Received: by 2002:ac2:5e76:0:b0:52c:df83:a740 with SMTP id
 2adb3069b0e04-5309b299a60mr3037663e87.30.1722179719651; Sun, 28 Jul 2024
 08:15:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com> <20240728142842.iquah6ckxj7rfmvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240728142842.iquah6ckxj7rfmvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 28 Jul 2024 16:14:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4bo=1ZMQohRrAH+9B-M_gpdzXc7wYqXESpYWgwb77v6g@mail.gmail.com>
Message-ID: <CAL3q7H4bo=1ZMQohRrAH+9B-M_gpdzXc7wYqXESpYWgwb77v6g@mail.gmail.com>
Subject: Re: [PATCH v2] generic: test page fault during direct IO write with O_APPEND
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 3:28=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Sat, Jul 27, 2024 at 12:28:16PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that doing a direct IO append write to a file when the input buffe=
r
> > was not yet faulted in, does not result in an incorrect file size.
> >
> > This exercises a bug on btrfs reported by users and which is fixed by
> > the following kernel patch:
> >
> >    "btrfs: fix corruption after buffer fault in during direct IO append=
 write"
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >
> > V2: Deal with partial writes by looping and writing any remaining data.
> >     Don't exit when the first test fails, instead let the second test
> >     run as well.
>
> With this change I got two error lines this time [1]. Last time (V1) I
> only got "Wrong file size after first write, got 8192 expected 4096".

Yes, it's expected.
As the changelog for v2 says, now the second test is run even if the
first one failed.

> Does this mean this v2 change help this case to be better?

I prefer it like that.
It's common in fstests to let all steps of a test run if possible
(i.e. we don't exit, call _fail, or anything equivalent, everywhere
unless the test can't proceed anymore).

>
> Thanks,
> Zorro
>
> [1]
> [root@dell-per750-41 xfstests]# ./check -s default generic/362
> SECTION       -- default
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 dell-xx-xxxxxx 6.10.0-0.rc7.20240712git43db=
1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC 2024
> MKFS_OPTIONS  -- /dev/sda6
> MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda6 /mnt/=
scratch
>
> generic/362 0s ... - output mismatch (see /root/git/xfstests/results//def=
ault/generic/362.out.bad)
>     --- tests/generic/362.out   2024-07-28 22:22:06.098982182 +0800
>     +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-07-2=
8 22:23:16.622577397 +0800
>     @@ -1,2 +1,4 @@
>      QA output created by 362
>     +Wrong file size after first write, got 8192 expected 4096
>     +Wrong file size after second write, got 12288 expected 8192
>      Silence is golden
>
>
> >
> >  .gitignore                 |   1 +
> >  src/Makefile               |   2 +-
> >  src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++++++
> >  tests/generic/362          |  28 +++++++
> >  tests/generic/362.out      |   2 +
> >  5 files changed, 177 insertions(+), 1 deletion(-)
> >  create mode 100644 src/dio-append-buf-fault.c
> >  create mode 100755 tests/generic/362
> >  create mode 100644 tests/generic/362.out
> >
> > diff --git a/.gitignore b/.gitignore
> > index b5f15162..97c7e001 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -72,6 +72,7 @@ tags
> >  /src/deduperace
> >  /src/detached_mounts_propagation
> >  /src/devzero
> > +/src/dio-append-buf-fault
> >  /src/dio-buf-fault
> >  /src/dio-interleaved
> >  /src/dio-invalidate-cache
> > diff --git a/src/Makefile b/src/Makefile
> > index 99796137..559209be 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -20,7 +20,7 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
> >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
> > -     readdir-while-renames
> > +     readdir-while-renames dio-append-buf-fault
> >
> >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern=
_reader \
> >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.c
> > new file mode 100644
> > index 00000000..72c23265
> > --- /dev/null
> > +++ b/src/dio-append-buf-fault.c
> > @@ -0,0 +1,145 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> > + */
> > +
> > +/*
> > + * Test a direct IO write in append mode with a buffer that was not fa=
ulted in
> > + * (or just partially) before the write.
> > + */
> > +
> > +/* Get the O_DIRECT definition. */
> > +#ifndef _GNU_SOURCE
> > +#define _GNU_SOURCE
> > +#endif
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <stdint.h>
> > +#include <fcntl.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <sys/stat.h>
> > +
> > +static ssize_t do_write(int fd, const void *buf, size_t count)
> > +{
> > +        while (count > 0) {
> > +             ssize_t ret;
> > +
> > +             ret =3D write(fd, buf, count);
> > +             if (ret < 0) {
> > +                     if (errno =3D=3D EINTR)
> > +                             continue;
> > +                     return ret;
> > +             }
> > +             count -=3D ret;
> > +             buf +=3D ret;
> > +     }
> > +     return 0;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct stat stbuf;
> > +     int fd;
> > +     long pagesize;
> > +     void *buf;
> > +     ssize_t ret;
> > +
> > +     if (argc !=3D 2) {
> > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > +             return 1;
> > +     }
> > +
> > +     /*
> > +      * First try an append write against an empty file of a buffer wi=
th a
> > +      * size matching the page size. The buffer is not faulted in befo=
re
> > +      * attempting the write.
> > +      */
> > +
> > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_=
APPEND, 0666);
> > +     if (fd =3D=3D -1) {
> > +             perror("Failed to open/create file");
> > +             return 2;
> > +     }
> > +
> > +     pagesize =3D sysconf(_SC_PAGE_SIZE);
> > +     if (pagesize =3D=3D -1) {
> > +             perror("Failed to get page size");
> > +             return 3;
> > +     }
> > +
> > +     buf =3D mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     if (buf =3D=3D MAP_FAILED) {
> > +             perror("Failed to allocate first buffer");
> > +             return 4;
> > +     }
> > +
> > +     ret =3D do_write(fd, buf, pagesize);
> > +     if (ret < 0) {
> > +             perror("First write failed");
> > +             return 5;
> > +     }
> > +
> > +     ret =3D fstat(fd, &stbuf);
> > +     if (ret < 0) {
> > +             perror("First stat failed");
> > +             return 6;
> > +     }
> > +
> > +     /* Don't exit on failure so that we run the second test below too=
. */
> > +     if (stbuf.st_size !=3D pagesize)
> > +             fprintf(stderr,
> > +                     "Wrong file size after first write, got %jd expec=
ted %ld\n",
> > +                     (intmax_t)stbuf.st_size, pagesize);
> > +
> > +     munmap(buf, pagesize);
> > +     close(fd);
> > +
> > +     /*
> > +      * Now try an append write against an empty file of a buffer with=
 a
> > +      * size matching twice the page size. Only the first page of the =
buffer
> > +      * is faulted in before attempting the write, so that the second =
page
> > +      * should be faulted in during the write.
> > +      */
> > +     fd =3D open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_=
APPEND, 0666);
> > +     if (fd =3D=3D -1) {
> > +             perror("Failed to open/create file");
> > +             return 7;
> > +     }
> > +
> > +     buf =3D mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > +     if (buf =3D=3D MAP_FAILED) {
> > +             perror("Failed to allocate second buffer");
> > +             return 8;
> > +     }
> > +
> > +     /* Fault in first page of the buffer before the write. */
> > +     memset(buf, 0, 1);
> > +
> > +     ret =3D do_write(fd, buf, pagesize * 2);
> > +     if (ret < 0) {
> > +             perror("Second write failed");
> > +             return 9;
> > +     }
> > +
> > +     ret =3D fstat(fd, &stbuf);
> > +     if (ret < 0) {
> > +             perror("Second stat failed");
> > +             return 10;
> > +     }
> > +
> > +     if (stbuf.st_size !=3D pagesize * 2)
> > +             fprintf(stderr,
> > +                     "Wrong file size after second write, got %jd expe=
cted %ld\n",
> > +                     (intmax_t)stbuf.st_size, pagesize * 2);
> > +
> > +     munmap(buf, pagesize * 2);
> > +     close(fd);
> > +
> > +     return 0;
> > +}
> > diff --git a/tests/generic/362 b/tests/generic/362
> > new file mode 100755
> > index 00000000..2c127347
> > --- /dev/null
> > +++ b/tests/generic/362
> > @@ -0,0 +1,28 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 362
> > +#
> > +# Test that doing a direct IO append write to a file when the input bu=
ffer was
> > +# not yet faulted in, does not result in an incorrect file size.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick
> > +
> > +_require_test
> > +_require_odirect
> > +_require_test_program dio-append-buf-fault
> > +
> > +[ $FSTYP =3D=3D "btrfs" ] && \
> > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: fix corruption after buffer fault in during direct IO app=
end write"
> > +
> > +# On error the test program writes messages to stderr, causing a golde=
n output
> > +# mismatch and making the test fail.
> > +$here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/362.out b/tests/generic/362.out
> > new file mode 100644
> > index 00000000..0ff40905
> > --- /dev/null
> > +++ b/tests/generic/362.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 362
> > +Silence is golden
> > --
> > 2.43.0
> >
> >
>

