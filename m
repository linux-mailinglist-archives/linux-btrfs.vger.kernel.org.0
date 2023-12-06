Return-Path: <linux-btrfs+bounces-700-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BB806BD4
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 11:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2160D281810
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 10:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98202D7B3;
	Wed,  6 Dec 2023 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVdBGS9q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DDE1A29C;
	Wed,  6 Dec 2023 10:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60487C433C7;
	Wed,  6 Dec 2023 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701858159;
	bh=KdbtOaq9BASBRADbkfDAGNBgK859lQO2m1H/aISSYLI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OVdBGS9qBFIUGZc2rQzHK2meXXb+gR6DRrHEtTc61Xc3GNNGz2MBl0d1qNkoFUPHV
	 vifXWrzvsJjnuoD16xYFEyl0837o9CmR8KbCX0LnvWXHE36quuGA8OmJ4yDkHv5BOc
	 8LTj9sRTWjq67Q8hPjRPvPnmS3SRAGcrhxenSvn0DtHRD0Gcj/O2NUtSgl0FY0wEMK
	 z5bMy5ghtUbhSuCrGmBoM3j8Vi6Vcep0sC8x0AA3rmdr3J3s2GYUTUQd7Z0cGfNt5X
	 SdsJE7BtgjHVKlDUez5ZLp0Qp9XykhAngbO5pa4aZW/XdYPxZp2xFKO+DSc7uuCZg3
	 0wmFgf+jouGGw==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a1cee2c1620so83250166b.2;
        Wed, 06 Dec 2023 02:22:39 -0800 (PST)
X-Gm-Message-State: AOJu0YztNZZn4cIeqeQz/GIIJ0WqivF3ApOwOxAOor0epGKeZHPTh6hM
	OmACE6K2/EwGJw5NZRtSndr87RV/EDyrKgbMlRg=
X-Google-Smtp-Source: AGHT+IHbNX1yoSze9AfQeh/QGZATjceagLiTpO7KtU6XOAV1FZjnZNXHnjYpFXONEe+r6ZZ28OOlmt0aYnbYULNPGtI=
X-Received: by 2002:a17:906:10c6:b0:a19:a1ba:bae7 with SMTP id
 v6-20020a17090610c600b00a19a1babae7mr262606ejv.141.1701858157712; Wed, 06 Dec
 2023 02:22:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e54239e625f794c62b962c35d06db04571bf73d5.1701794007.git.fdmanana@suse.com>
 <20231206081747.5rr7zzsfivenaag5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20231206081747.5rr7zzsfivenaag5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 6 Dec 2023 10:22:00 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4y4_fFuxw736vtEC9+mUMAQ=WSuf5+DfMjCX4tRu8f-g@mail.gmail.com>
Message-ID: <CAL3q7H4y4_fFuxw736vtEC9+mUMAQ=WSuf5+DfMjCX4tRu8f-g@mail.gmail.com>
Subject: Re: [PATCH] generic: test reading a large directory while renaming
 its files
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 8:17=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote:
>
> On Tue, Dec 05, 2023 at 04:39:20PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that on a fairly large directory if we keep renaming files while
> > holding the directory open and doing readdir(3) calls, we don't end up
> > in an infinite loop.
> >
> > This exercise a bug that existed in btrfs and was fixed in kernel 6.5
> > by commit 9b378f6ad48c ("btrfs: fix infinite directory reads").
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
>
> This patch looks good to me, I'll add this case into "rename" group too
> when I merge it.

Sounds good, thanks.

>
> Reviewed-by: Zorro Lang <zlang@redhat.com>
>
> >  .gitignore                  |   1 +
> >  src/Makefile                |   3 +-
> >  src/readdir-while-renames.c | 146 ++++++++++++++++++++++++++++++++++++
> >  tests/generic/734           |  37 +++++++++
> >  tests/generic/734.out       |   2 +
> >  5 files changed, 188 insertions(+), 1 deletion(-)
> >  create mode 100644 src/readdir-while-renames.c
> >  create mode 100755 tests/generic/734
> >  create mode 100644 tests/generic/734.out
> >
> > diff --git a/.gitignore b/.gitignore
> > index 4c32ac42..7508b6e8 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -121,6 +121,7 @@ tags
> >  /src/punch-alternating
> >  /src/pwrite_mmap_blocked
> >  /src/randholes
> > +/src/readdir-while-renames
> >  /src/rename
> >  /src/renameat2
> >  /src/resvtest
> > diff --git a/src/Makefile b/src/Makefile
> > index 8160a0e8..d79015ce 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -19,7 +19,8 @@ TARGETS =3D dirstress fill fill2 getpagesize holes ls=
tat64 \
> >       t_ofd_locks t_mmap_collision mmap-write-concurrent \
> >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale=
 \
> > -     t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test
> > +     t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewindd=
ir-test \
> > +     readdir-while-renames
> >
> >  LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize preallo_rw_pattern=
_reader \
> >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > diff --git a/src/readdir-while-renames.c b/src/readdir-while-renames.c
> > new file mode 100644
> > index 00000000..afeefb04
> > --- /dev/null
> > +++ b/src/readdir-while-renames.c
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2023 SUSE Linux Products GmbH.  All Rights Reserved.
> > + */
> > +#include <dirent.h>
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +#include <unistd.h>
> > +#include <sys/stat.h>
> > +
> > +/* Number of files we add to the test directory. */
> > +#define NUM_FILES 5000
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     struct dirent *entry;
> > +     DIR *dir =3D NULL;
> > +     char *dir_path =3D NULL;
> > +     int dentry_count =3D 0;
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     if (argc !=3D 2) {
> > +             fprintf(stderr, "Usage:  %s <directory>\n", argv[0]);
> > +             ret =3D 1;
> > +             goto out;
> > +     }
> > +
> > +     dir_path =3D malloc(strlen(argv[1]) + strlen("/testdir") + 1);
> > +     if (!dir_path) {
> > +             fprintf(stderr, "malloc failure\n");
> > +             ret =3D ENOMEM;
> > +             goto out;
> > +     }
> > +     i =3D strlen(argv[1]);
> > +     memcpy(dir_path, argv[1], i);
> > +     memcpy(dir_path + i, "/testdir", strlen("/testdir"));
> > +     dir_path[i + strlen("/testdir")] =3D '\0';
> > +
> > +     ret =3D mkdir(dir_path, 0700);
> > +     if (ret =3D=3D -1) {
> > +             fprintf(stderr, "Failed to create test directory: %d\n", =
errno);
> > +             ret =3D errno;
> > +             goto out;
> > +     }
> > +
> > +     ret =3D chdir(dir_path);
> > +     if (ret =3D=3D -1) {
> > +             fprintf(stderr, "Failed to chdir to the test directory: %=
d\n", errno);
> > +             ret =3D errno;
> > +             goto out;
> > +     }
> > +
> > +     /* Now create all files inside the directory. */
> > +     for (i =3D 1; i <=3D NUM_FILES; i++) {
> > +             char file_name[32];
> > +             FILE *f;
> > +
> > +             sprintf(file_name, "%s/%d", dir_path, i);
> > +             f =3D fopen(file_name, "w");
> > +             if (f =3D=3D NULL) {
> > +                     fprintf(stderr, "Failed to create file number %d:=
 %d\n",
> > +                             i, errno);
> > +                     ret =3D errno;
> > +                     goto out;
> > +             }
> > +             fclose(f);
> > +     }
> > +
> > +     dir =3D opendir(dir_path);
> > +     if (dir =3D=3D NULL) {
> > +             fprintf(stderr, "Failed to open directory: %d\n", errno);
> > +             ret =3D errno;
> > +             goto out;
> > +     }
> > +
> > +     /*
> > +      * readdir(3) returns NULL when it reaches the end of the directo=
ry or
> > +      * when an error happens, so reset errno to 0 to distinguish betw=
een
> > +      * both cases later.
> > +      */
> > +     errno =3D 0;
> > +     while ((entry =3D readdir(dir)) !=3D NULL) {
> > +             dentry_count++;
> > +             /*
> > +              * The actual number of dentries returned varies per file=
system
> > +              * implementation. On a 6.7-rc4 kernel, on x86_64 with de=
fault
> > +              * mkfs options, xfs returns 5031 dentries while ext4, f2=
fs and
> > +              * btrfs return 5002 (the 5000 files plus "." and ".."). =
These
> > +              * variations are fine and valid according to POSIX, as s=
ome of
> > +              * the renames may be visible or not while calling readdi=
r(3).
> > +              * We only want to check we don't enter into an infinite =
loop,
> > +              * so let the maximum number of dentries be 3 * NUM_FILES=
, which
> > +              * is very reasonable.
> > +              */
> > +             if (dentry_count > 3 * NUM_FILES) {
> > +                     fprintf(stderr,
> > +                             "Found too many directory entries (%d)\n"=
,
> > +                             dentry_count);
> > +                     ret =3D 1;
> > +                     goto out;
> > +             }
> > +             /* Can't rename "." and "..", skip them. */
> > +             if (strcmp(entry->d_name, ".") =3D=3D 0 ||
> > +                 strcmp(entry->d_name, "..") =3D=3D 0)
> > +                     continue;
> > +             ret =3D rename(entry->d_name, "TEMPFILE");
> > +             if (ret =3D=3D -1) {
> > +                     fprintf(stderr,
> > +                             "Failed to rename '%s' to TEMPFILE: %d\n"=
,
> > +                             entry->d_name, errno);
> > +                     ret =3D errno;
> > +                     goto out;
> > +             }
> > +             ret =3D rename("TEMPFILE", entry->d_name);
> > +             if (ret =3D=3D -1) {
> > +                     fprintf(stderr,
> > +                             "Failed to rename TEMPFILE to '%s': %d\n"=
,
> > +                             entry->d_name, errno);
> > +                     ret =3D errno;
> > +                     goto out;
> > +             }
> > +     }
> > +
> > +     if (errno) {
> > +             fprintf(stderr, "Failed to read directory: %d\n", errno);
> > +             ret =3D errno;
> > +             goto out;
> > +     }
> > +
> > +     /* It should return at least NUM_FILES entries +2 (for "." and ".=
."). */
> > +     if (dentry_count < NUM_FILES + 2) {
> > +             fprintf(stderr,
> > +                     "Found less directory entries than expected (%d b=
ut expected %d)\n",
> > +                     dentry_count, NUM_FILES + 2);
> > +             ret =3D 2;
> > +     }
> > +out:
> > +     free(dir_path);
> > +     if (dir !=3D NULL)
> > +             closedir(dir);
> > +
> > +     return ret;
> > +}
> > diff --git a/tests/generic/734 b/tests/generic/734
> > new file mode 100755
> > index 00000000..ea3dfb2d
> > --- /dev/null
> > +++ b/tests/generic/734
> > @@ -0,0 +1,37 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 734
> > +#
> > +# Test that on a fairly large directory if we keep renaming files whil=
e holding
> > +# the directory open and doing readdir(3) calls, we don't end up in an=
 infinite
> > +# loop.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick dir
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -fr $tmp.*
> > +     rm -fr $target_dir
> > +}
> > +
> > +_supported_fs generic
> > +_require_test
> > +_require_test_program readdir-while-renames
> > +
> > +[ $FSTYP =3D=3D "btrfs" ] && _fixed_by_kernel_commit 9b378f6ad48c \
> > +     "btrfs: fix infinite directory reads"
> > +
> > +target_dir=3D"$TEST_DIR/test-$seq"
> > +rm -fr $target_dir
> > +mkdir $target_dir
> > +
> > +$here/src/readdir-while-renames $target_dir
> > +
> > +# success, all done
> > +echo "Silence is golden"
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/734.out b/tests/generic/734.out
> > new file mode 100644
> > index 00000000..4299839b
> > --- /dev/null
> > +++ b/tests/generic/734.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 734
> > +Silence is golden
> > --
> > 2.40.1
> >
> >
>

