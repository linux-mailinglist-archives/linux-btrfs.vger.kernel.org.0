Return-Path: <linux-btrfs+bounces-3474-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F88813B4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FD2282357
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4334879E;
	Wed, 20 Mar 2024 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHSoHK0Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AD1EEE8;
	Wed, 20 Mar 2024 14:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946363; cv=none; b=oFyqiPPF4Xb8Qb+MARyU+mMCMenCl+VFkGnMf/9zFHMqywWfF498NDpctXEIeraMfoMvQLuMUdRrDP2mX60zWFwYlBGBm1BvIJ5uVuiIkrFHgn5hUM9c0HhmeQQIEQPikr5ank2VfI9bzNfX0TAm8FmZznxekjMDsmG42LpFIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946363; c=relaxed/simple;
	bh=fRbF43tNR5LaOasnSZnpHwYr16/BZe/ldjMrxKzQ+8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ULUuG97ley5XHtwG7K4nGUgkj2pEUIixHdvXzdwmIBipTPC1/3A27Na1ilxCBzxp9pUQ3dOcybL7b+UoaR2jzgmyYVMh0tocvj4bQ8NwZ/fFZrxA9/6FqspWoU3EcTO2OkDIT+TdxyoTQ6tGv4S66zjEWcMzXhwwr9l8btQwFUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHSoHK0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441ABC433C7;
	Wed, 20 Mar 2024 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946363;
	bh=fRbF43tNR5LaOasnSZnpHwYr16/BZe/ldjMrxKzQ+8s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JHSoHK0Q8o7bBD7NxsRV4OKA0Mj+LpjFZ5iy3lROg6ovzOGJmJHKTYTAUsrGyfSw7
	 JJiTr80xACaz7PXY94Nld+qn962BZBAuXkIipCtXWgWHa0Exrfl7ROkJF1GYXVR6mG
	 s16jLEm8ve3RPkUqz2Vz3L7SfZvuRjtYpBA0eLd25RL1G/GaC08cM+PF+5lc6txAuK
	 TjOuytLhIRxtXNUwAVxOQI8iUH6rHfasXzY5VFesxcb5Uc73NrcnsnF6oCjBEd0jix
	 cXAz9VkKYKHdkp+FrU5Gv720MU3atkoKTsyf/yjPCfNMl+KiaKy9SFNzIgRJuCfSVS
	 3KeSjKH9AhMIA==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46dd7b4bcbso270113866b.3;
        Wed, 20 Mar 2024 07:52:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUc7V/8MNyywZ1Jp9mHo/SDiiyzxjK5QB4varr2/NO3iMugYYsZhoPp5RysZYbU/acgA+wh2rNJhKRMdqjjAcacj5YUkuK0tJqanT4=
X-Gm-Message-State: AOJu0YzpiBHRUuRaadQYewdyixr9LKQrmL2GfKz87zsSRn/ALercseS9
	QHlSzL/lu8xE6baMOyqxOteaOZIBjfSIdO7rKFEwuOPZ8V0LiTR6Kn2Vcx4NCDlUJgcvVuYAquG
	rPxQFwZe90k3jZorrUEemI/vZqnU=
X-Google-Smtp-Source: AGHT+IGR1ZHMVFjR9FEAFzRaXWGxNLcDiZVyTfcjsTREJCNk2pGYM0KvdSzIZeUXy8yrR2yzIqApgo/HvEALsfumqF4=
X-Received: by 2002:a17:906:1707:b0:a46:708d:a9d3 with SMTP id
 c7-20020a170906170700b00a46708da9d3mr11075106eje.71.1710946361795; Wed, 20
 Mar 2024 07:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
In-Reply-To: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 20 Mar 2024 14:52:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4CE5WSWXhDF4qy+yPjmkGiTPw2nUVFauOazbYyMUkw6Q@mail.gmail.com>
Message-ID: <CAL3q7H4CE5WSWXhDF4qy+yPjmkGiTPw2nUVFauOazbYyMUkw6Q@mail.gmail.com>
Subject: Re: [PATCH v3] generic/808: add a regression test for fiemap into an
 mmap range
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:36=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good to me now, thanks.

> ---
> v2->v3:
> - Add fiemap-fault to .gitignore
> - Added a _cleanup() helper
> - Just let the output of fiemap-fault go instead of using || _fail
> - Added the munmap
> - Moved $dst to $TEST_DIR/$seq
>
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/fiemap-fault.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/808     | 48 ++++++++++++++++++++++++++++
>  tests/generic/808.out |  2 ++
>  5 files changed, 126 insertions(+), 1 deletion(-)
>  create mode 100644 src/fiemap-fault.c
>  create mode 100755 tests/generic/808
>  create mode 100644 tests/generic/808.out
>
> diff --git a/.gitignore b/.gitignore
> index 3b160209..f0fb72bd 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -205,6 +205,7 @@ tags
>  /src/vfs/mount-idmapped
>  /src/log-writes/replay-log
>  /src/perf/*.pyc
> +/src/filemap-fault
>
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index e7442487..ab98a06f 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize pre=
allo_rw_pattern_reader \
>         attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles=
 \
>         fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail=
 \
>         detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -       uuid_ioctl t_snapshot_deleted_subvolume
> +       uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
>
>  EXTRA_EXECS =3D dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/fiemap-fault.c b/src/fiemap-fault.c
> new file mode 100644
> index 00000000..73260068
> --- /dev/null
> +++ b/src/fiemap-fault.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> + */
> +
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +#include <linux/fiemap.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include <unistd.h>
> +
> +int prep_mmap_buffer(int fd, void **addr)
> +{
> +       struct stat st;
> +       int ret;
> +
> +       ret =3D fstat(fd, &st);
> +       if (ret)
> +               err(1, "failed to stat %d", fd);
> +
> +       *addr =3D mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED=
, fd, 0);
> +       if (*addr =3D=3D MAP_FAILED)
> +               err(1, "failed to mmap %d", fd);
> +
> +       return st.st_size;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       struct fiemap *fiemap;
> +       size_t sz, last =3D 0;
> +       void *buf =3D NULL;
> +       int ret, fd;
> +
> +       if (argc !=3D 2)
> +               errx(1, "no in and out file name arguments given");
> +
> +       fd =3D open(argv[1], O_RDWR, 0666);
> +       if (fd =3D=3D -1)
> +               err(1, "failed to open %s", argv[1]);
> +
> +       sz =3D prep_mmap_buffer(fd, &buf);
> +
> +       fiemap =3D (struct fiemap *)buf;
> +       fiemap->fm_flags =3D 0;
> +       fiemap->fm_extent_count =3D (sz - sizeof(struct fiemap)) /
> +                                 sizeof(struct fiemap_extent);
> +
> +       while (last < sz) {
> +               int i;
> +
> +               fiemap->fm_start =3D last;
> +               fiemap->fm_length =3D sz - last;
> +
> +               ret =3D ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
> +               if (ret < 0)
> +                       err(1, "fiemap failed %d", errno);
> +               for (i =3D 0; i < fiemap->fm_mapped_extents; i++)
> +                      last =3D fiemap->fm_extents[i].fe_logical +
> +                              fiemap->fm_extents[i].fe_length;
> +       }
> +
> +       munmap(buf, sz);
> +       close(fd);
> +       return 0;
> +}
> diff --git a/tests/generic/808 b/tests/generic/808
> new file mode 100755
> index 00000000..36015f35
> --- /dev/null
> +++ b/tests/generic/808
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 808
> +#
> +# Test fiemap into an mmaped buffer of the same file
> +#
> +# Create a reasonably large file, then run a program which mmaps it and =
uses
> +# that as a buffer for an fiemap call.  This is a regression test for bt=
rfs
> +# where we used to hold a lock for the duration of the fiemap call which=
 would
> +# result in a deadlock if we page faulted.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto fiemap
> +[ $FSTYP =3D=3D "btrfs" ] && \
> +       _fixed_by_kernel_commit b0ad381fa769 \
> +               "btrfs: fix deadlock with fiemap and extent locking"
> +
> +_cleanup()
> +{
> +       rm -f $dst
> +       cd /
> +       rm -r -f $tmp.*
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=3D$TEST_DIR/$seq/fiemap-fault
> +
> +mkdir -p $TEST_DIR/$seq
> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +       $XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done
> +
> +$here/src/fiemap-fault $dst
> +
> +# success, all done
> +status=3D$?
> +exit
> +
> diff --git a/tests/generic/808.out b/tests/generic/808.out
> new file mode 100644
> index 00000000..88253428
> --- /dev/null
> +++ b/tests/generic/808.out
> @@ -0,0 +1,2 @@
> +QA output created by 808
> +Silence is golden
> --
> 2.43.0
>
>

