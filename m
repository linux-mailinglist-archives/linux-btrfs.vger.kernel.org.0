Return-Path: <linux-btrfs+bounces-6797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1341893DF28
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 13:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 645A6B2387C
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F65558AD0;
	Sat, 27 Jul 2024 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IFNVE8NU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CFB1859;
	Sat, 27 Jul 2024 11:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722079871; cv=none; b=a7jKiYrBzN6YMbqkkbp1iRz92rlXT8/6oFecfza98nY9ubnUU6jmL6p6hYEN1BCNoXUFvAcdycoJ4fknNfiHt83DZUlfcgPY0uCVdjRDTEkdX7WC/muamcwQMIzzfk54Fh3ADqOjAwuCz/tmI+eIGZUvMdPnqFsVrAowyoDoq0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722079871; c=relaxed/simple;
	bh=zJWXtAlxqmGTFhHMhY2KIAGRJqo8UrtlyEoN7pDrGSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e59NOnJqg1Cl4cab/hC1sefmYlGzVsdWwe2+F3NpiI584Y3uoBbfGnpQ0ZVAcg1sCiGqW1aLU/kzQLwFz2F8Xv42OHEpKPwxOIq3u8WnXCiJh1qBlJYOLEMZ/SiyPV5OlkiBmZot+nn5nMssIFiIATAayOsnEpjtat9bpmXOEko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IFNVE8NU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D123C4AF0A;
	Sat, 27 Jul 2024 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722079871;
	bh=zJWXtAlxqmGTFhHMhY2KIAGRJqo8UrtlyEoN7pDrGSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IFNVE8NU+6Sx+oE21dNhLYZ5N87j3sDk6sYdxEyqUZBjczJMiy1xjyXsllLZplcTp
	 WgPm0RW91jTID5QjxKTWHrQkhWtRD5m5D7WYFDQZS+cC1ZK1V37xPsu+56wCQi/sro
	 lfCv2k3JFsxsz85RCjS2hnyu/5z4j83lI1N7IxtwDNCkF8MQa3PogTS1EOp9KUbYHP
	 ylhD/PRZt66pHCnJpdcEBXsHivY+qKvH2+zhb/3MsM0MlWde14HakKsGcAkIs+bazX
	 1bty3bnBxST0pHlb0uMr/C5MSbkHIActAw+qUWMpp0s/4yresRR4GYI7/a6UrFwVa1
	 U3ts2QN7DwY/Q==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so285240166b.1;
        Sat, 27 Jul 2024 04:31:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwamkp9jz5NYjYXlCMCOfeaCgp8APZFaerlVDZBdS82rzA+ktY6rO1xbXJQvPWtzH0GbCrlEsbm8Fb8xnC8yDGOybqj2Nrtvad8Oo=
X-Gm-Message-State: AOJu0YyD3DAi0dGDJIM4fvJtLXfI+5Ucu3Zyrtws0Z0l6z+Lak6AhteE
	0Kc1NpE3omiQEO4O07UpkPWCZRnGcpaGrqMYxdJK3H6TQScjgZKqH8QsjKCGDbt07zDHGbSNeag
	MayX1ZRt91fqfSjPGRxVKUWAzsx4=
X-Google-Smtp-Source: AGHT+IGVVKHpLGue3NoTWlHT03sfq3uBKPZ91sSFZ9Lv4Q78P5HfrRBOt568FC0xmlcSH+nk2w2h07ydLqcL4qMTfzk=
X-Received: by 2002:a17:906:fe42:b0:a7a:cc10:667c with SMTP id
 a640c23a62f3a-a7d3ff9f305mr128968166b.16.1722079869614; Sat, 27 Jul 2024
 04:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <20240726175837.jtq4df4u7rol3qac@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6RMX=1EPCESDc5-OXB=dF4W56u6PY72Dv2wN78TdGw3w@mail.gmail.com> <20240727082706.gmi2bkdt5piy4bgp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20240727082706.gmi2bkdt5piy4bgp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sat, 27 Jul 2024 12:30:32 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5ag=1WRe-3vEH4eNGJ-KPZBF2nV8aWGx1CHqfC28nN7w@mail.gmail.com>
Message-ID: <CAL3q7H5ag=1WRe-3vEH4eNGJ-KPZBF2nV8aWGx1CHqfC28nN7w@mail.gmail.com>
Subject: Re: [PATCH] generic: test page fault during direct IO write with O_APPEND
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 9:27=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Fri, Jul 26, 2024 at 07:12:34PM +0100, Filipe Manana wrote:
> > On Fri, Jul 26, 2024 at 6:58=E2=80=AFPM Zorro Lang <zlang@redhat.com> w=
rote:
> > >
> > > On Fri, Jul 26, 2024 at 04:55:46PM +0100, fdmanana@kernel.org wrote:
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
> > > >  .gitignore                 |   1 +
> > > >  src/Makefile               |   2 +-
> > > >  src/dio-append-buf-fault.c | 131 +++++++++++++++++++++++++++++++++=
++++
> > > >  tests/generic/362          |  28 ++++++++
> > > >  tests/generic/362.out      |   2 +
> > > >  5 files changed, 163 insertions(+), 1 deletion(-)
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
> > > > index 00000000..f4be4845
> > > > --- /dev/null
> > > > +++ b/src/dio-append-buf-fault.c
> > > > @@ -0,0 +1,131 @@
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
> > > > +     ret =3D write(fd, buf, pagesize);
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
> > > > +     if (stbuf.st_size !=3D pagesize) {
> > > > +             fprintf(stderr,
> > > > +                     "Wrong file size after first write, got %jd e=
xpected %ld\n",
> > > > +                     (intmax_t)stbuf.st_size, pagesize);
> > > > +             return 7;
> > > > +     }
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
> > > > +             return 8;
> > > > +     }
> > > > +
> > > > +     buf =3D mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > > +     if (buf =3D=3D MAP_FAILED) {
> > > > +             perror("Failed to allocate second buffer");
> > > > +             return 9;
> > > > +     }
> > > > +
> > > > +     /* Fault in first page of the buffer before the write. */
> > > > +     memset(buf, 0, 1);
> > > > +
> > > > +     ret =3D write(fd, buf, pagesize * 2);
> > > > +     if (ret < 0) {
> > > > +             perror("Second write failed");
> > >
> > > Hi Filipe,
> > >
> > > This patch looks good to me, just a question about this part. Is it p=
ossible
> > > to get (0 < ret < pagesize * 2) at here? Is so, should we report fail=
 too?
> >
> > It is possible, if a short write happens.
> > If that's the case, we detect the failure below when checking the file
> > size with the stat call.
> >
> > >
> > > > +             return 10;
> > > > +     }
> > > > +
> > > > +     ret =3D fstat(fd, &stbuf);
> > > > +     if (ret < 0) {
> > > > +             perror("Second stat failed");
> > > > +             return 11;
> > > > +     }
> > > > +
> > > > +     if (stbuf.st_size !=3D pagesize * 2) {
> > > > +             fprintf(stderr,
> > > > +                     "Wrong file size after second write, got %jd =
expected %ld\n",
> > > > +                     (intmax_t)stbuf.st_size, pagesize * 2);
> > >
> > > Does this try to check the stbuf.st_size isn't equal to the write(2) =
return
> > > value? Or checks stbuf.st_size !=3D pagesize * 2, when the return val=
ue is
> > > good (equal to pagesize * 2) ?
> >
> > It checks if it is equals to pagesize * 2, which is supposed to be the
> > final file size, meaning the write succeeded and wrote all the
> > expected data (pagesize * 2).
>
> Thanks for your explanation.
>
> I noticed that the "Wrong file size after second write, got %jd expected =
%ld\n"
> line means the bug is triggered:

Correct.

>
>   # ./check -s default generic/362
>   SECTION       -- default
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 dell-xxxxx-xxx 6.10.0-0.rc7.20240712git43=
db1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC 20=
24
>   MKFS_OPTIONS  -- /dev/sda6
>   MOUNT_OPTIONS -- -o context=3Dsystem_u:object_r:root_t:s0 /dev/sda6 /mn=
t/scratch
>
>   generic/362 1s ... - output mismatch (see /root/git/xfstests/results//d=
efault/generic/362.out.bad)
>       --- tests/generic/362.out   2024-07-27 01:38:47.810847933 +0800
>       +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-07=
-27 01:41:50.126428012 +0800
>       @@ -1,2 +1,3 @@
>        QA output created by 362
>       +Wrong file size after first write, got 8192 expected 4096

Yes, that's expected with unpatched btrfs.

>        Silence is golden
>       ...
>       (Run 'diff -u /root/git/xfstests/tests/generic/362.out /root/git/xf=
stests/results//default/generic/362.out.bad'  to see the entire diff)
>
>   HINT: You _MAY_ be missing kernel fix:
>         xxxxxxxxxxxx btrfs: fix corruption after buffer fault in during d=
irect IO append write
>
>   Ran: generic/362
>   Failures: generic/362
>   Failed 1 of 1 tests
>
> I thought a "short write" isn't a bug, just a rare test failure (or we us=
e a loop
> write to avoid that?). So we might can make sure the write() returns "pag=
esize * 2"
> at first, then check (stbuf.st_size !=3D pagesize * 2) for the bug itself=
.
>
> What do you think?

Fine ok.

I've just sent a v2 with that change plus a minor one to always let
the second test run even if the first one fails:

https://lore.kernel.org/linux-btrfs/6c52fe9ce75354a931afdc6d2f7fb638c7f06b0=
0.1722079321.git.fdmanana@suse.com/

Thanks.

>
> Thanks,
> Zorro
>
> >
> > Thanks.
> >
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > > +             return 12;
> > > > +     }
> > > > +
> > > > +     munmap(buf, pagesize * 2);
> > > > +     close(fd);
> > > > +
> > > > +     return 0;
> > > > +}
> > >
> > > [snip]
> > >
> >
>

