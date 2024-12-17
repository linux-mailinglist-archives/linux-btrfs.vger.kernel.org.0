Return-Path: <linux-btrfs+bounces-10478-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE0D9F4C56
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 14:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E33170095
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2024 13:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBE31F4263;
	Tue, 17 Dec 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ejQRTVRP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AA1F2360
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441874; cv=none; b=X2qPPzwz8tFeBwexvxnTDe6fC3UXUoKHuPxgl/ZTSLrHplyS6l0kteL5UdA5Vpkf/ooqACJ28igDO/QO94sUCd0uJTjmg9t3OJfgTOljKvhJCF/wHhgFx0WrfOy4w2odzj5Jt+SdFo6SmU4E7Lv20OCrbeOKYSA2Hiyd918Ohz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441874; c=relaxed/simple;
	bh=BVMVof95yjGd1h7eiFJfm4GHTe4XY0yB0OIVnDfxwQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPaRk3kpyE0igS0UCfbkrgN8D/Ztk4pZ594Wov3bh9hHY9greI1H1hUGWFXjxVVDWmNNBjuI9noyIC9dFd3qMrHH8DZawCRipbFzXoKib23h91Ve04Gg95BCSkN9bwIbLhC5f2l7oe7DjdjYEbopq40gbTGLVN9JcLrR3gtvcbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ejQRTVRP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa662795ca3so1212911566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2024 05:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734441868; x=1735046668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FZXWXjOULxqx3i9Ox+njJuXm5fNcbWBhkQ/O+MkcAr0=;
        b=ejQRTVRPlIZV2fALwyLStypAZLhFQ+ygjdyEhU6crGdLXAVy1ITddUSS/QEKwygN67
         6u+/yq9WfnBd4J76gXnnaez7c0EaRQ4I72GTPYM16Rj22iRZ78F9Ufi4cwJfkQFIJSY7
         SSier8LJRvrzm0jeg8AAFhTwDIsMoPS9a5rUhiA1+ssKmPPPBj11TjDiZEJLyYraGVlh
         rOobY/YZ/wUODuPL3sAP4ue8sz/fBWlRUJpwijGx6hONA+xB+9bjKyO5tBVlYiSy1qm3
         NDlxpcFmX8InJyiYObSrMVUtXM/uTvFUmZb7YvzeKRCw/oI3Hs36bHEUJT1IuGjc7Aul
         ckaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734441868; x=1735046668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FZXWXjOULxqx3i9Ox+njJuXm5fNcbWBhkQ/O+MkcAr0=;
        b=FG4a9dWdtD64FSaMOGJK2cN18Fth+Vnb5pfU4DvUHi9LpWCejPJFWTgoN9Y0PQuzFA
         JNeaaTquHmAOlyUpnqeBCESkRi+2sxywdFtk0FfUwqKb3WIkxTCOlMmDBLAqYBC97bvX
         +yLvLRmpJQIxsvLe5YfjQ/5qWFLpNcDQW2mfGMxts04JbS/H/jZnu2jWG5hKkfyL4Id6
         JoCDq0tW/Im2AorB2Hem8xfQ328de0NMHtIjJEI7PCsXjYRogd/2s3goqh5haJ9YT6jw
         2AUEPOFf0eOcLJWnE5qNO9+RJidzm8yA3yC+p3RJUVtBRTQ8ponWDqt5A59WQUGeA5I/
         EG6w==
X-Forwarded-Encrypted: i=1; AJvYcCXtxQZcJidlTHGewCTTEJZSdEK3et9EDSo8kuA9OFe8BVj2wTBeWfacG5Q0YtLmaFilVBhj2wjgnnGm1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmpxsezryVLHNsu6U33D17SsqR8JrlN10zlJvjViUvBSqhP5vo
	1jgnmb1GoKZXFEY0ah59T8Re5FsJw44nkUWPYpPFCaRXsoaOMQ0VowTsbQkWYaH4nejNmAornoj
	wDY0TivWwuFSG9PIg0E9+nFSqWQUyTVwVxc1FPLmosykrD8EEJwA=
X-Gm-Gg: ASbGncs2IEdYXjdUKeQyIu5cIMUbEnPoYDVW+Imj10DuxYsaPIJC4dgBeq5lSCsoEgU
	DuFoQ0Op33tg0GWRKubS0GKBIodEIBB1U0pwi
X-Google-Smtp-Source: AGHT+IEOWPAHJ/SK9lj56UnZQkUXPAdfX56xTcWpcTgy7F7zBfrM9XfAgXLz+CjnKtT7h4kQ5ztaz8pH7T0l3cCooH4=
X-Received: by 2002:a17:907:2ce4:b0:aab:882e:921e with SMTP id
 a640c23a62f3a-aabdc881570mr338007266b.2.1734441868319; Tue, 17 Dec 2024
 05:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217123249.2481120-1-maharmstone@fb.com> <20241217123249.2481120-2-maharmstone@fb.com>
In-Reply-To: <20241217123249.2481120-2-maharmstone@fb.com>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 17 Dec 2024 14:24:17 +0100
Message-ID: <CAPjX3Fe44Emr0j9bVQshku=MiH96B7iG4wRTxc2RYcj2t-a-pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: add test for encoded reads
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Johannes.Thumshirn@wdc.com
Content-Type: text/plain; charset="UTF-8"

Hello Mark,

On Tue, 17 Dec 2024 at 13:33, Mark Harmstone <maharmstone@fb.com> wrote:
> diff --git a/tests/btrfs/333 b/tests/btrfs/333
> new file mode 100755
> index 00000000..8e4de4c0
> --- /dev/null
> +++ b/tests/btrfs/333
> @@ -0,0 +1,220 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/333
> +#
> +# Test btrfs encoded reads
> +
> +. ./common/preamble
> +_begin_fstest auto quick compress rw
> +
> +. ./common/filter
> +. ./common/btrfs
> +
> +_supported_fs btrfs
> +
> +do_encoded_read() {
> +    local fn=$1
> +    local type=$2
> +    local exp_ret=$3
> +    local exp_len=$4
> +    local exp_unencoded_len=$5
> +    local exp_unencoded_offset=$6
> +    local exp_compression=$7
> +    local exp_md5=$8
> +
> +    local tmpfile=`mktemp`
> +
> +    echo "running btrfs_encoded_read $type $fn 0 > $tmpfile" >>$seqres.full
> +    src/btrfs_encoded_read $type $fn 0 > $tmpfile
> +
> +    if [[ $? -ne 0 ]]; then
> +        echo "btrfs_encoded_read failed" >>$seqres.full
> +        rm $tmpfile
> +        return 1
> +    fi
> +
> +    exec {FD}< $tmpfile
> +
> +    read -u ${FD} ret
> +
> +    if [[ $ret == -95 && $type -eq "io_uring" ]]; then
> +        echo "btrfs io_uring encoded read failed with -EOPNOTSUPP, skipping" >>$seqres.full
> +        exec {FD}<&-
> +        return 1
> +    fi
> +
> +    if [[ $ret -lt 0 ]]; then
> +        if [[ $ret == -1 ]]; then
> +            echo "btrfs encoded read failed with -EPERM; are you running as root?" >>$seqres.full
> +        else
> +            echo "btrfs encoded read failed (errno $ret)" >>$seqres.full
> +        fi
> +        exec {FD}<&-
> +        return 1
> +    fi
> +
> +    local status=0
> +
> +    if [[ $ret -ne $exp_ret ]]; then
> +        echo "$fn: btrfs encoded read returned $ret, expected $exp_ret" >>$seqres.full
> +        status=1
> +    fi
> +
> +    read -u ${FD} len
> +    read -u ${FD} unencoded_len
> +    read -u ${FD} unencoded_offset
> +    read -u ${FD} compression
> +    read -u ${FD} encryption
> +
> +    local filesize=`stat -c%s $tmpfile`
> +    local datafile=`mktemp`
> +
> +    dd if=$tmpfile of=$datafile bs=1 count=$ret skip=$(($filesize-$ret)) status=none

tail -c +$((1+$filesize-$ret)) $tmpfile >$datafile

Using `bs=1` is not really best as `dd` is doing a syscall for each
one byte then. At the moment there is a UAF race in encoded read
eventually crashing the kernel. While chasing it I was running this
test in a busy loop (and moreover in 27 parallel threads and also
parallelizing the `test_file` function here resulting in load of about
200). But I found that most of the time was spent in those `dd`s and
not with the encoded read itself. Using tail is way faster here.

# while ./check btrfs/333; do true; done

> +
> +    exec {FD}<&-
> +    rm $tmpfile
> +
> +    local md5=`md5sum $datafile | cut -d ' ' -f 1`
> +    rm $datafile
> +
> +    if [[ $len -ne $exp_len ]]; then
> +        echo "$fn: btrfs encoded read had len of $len, expected $exp_len" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $unencoded_len -ne $exp_unencoded_len ]]; then
> +        echo "$fn: btrfs encoded read had unencoded_len of $unencoded_len, expected $exp_unencoded_len" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $unencoded_offset -ne $exp_unencoded_offset ]]; then
> +        echo "$fn: btrfs encoded read had unencoded_offset of $unencoded_offset, expected $exp_unencoded_offset" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $compression -ne $exp_compression ]]; then
> +        echo "$fn: btrfs encoded read had compression of $compression, expected $exp_compression" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $encryption -ne 0 ]]; then
> +        echo "$fn: btrfs encoded read had encryption of $encryption, expected 0" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $md5 != $exp_md5 ]]; then
> +        echo "$fn: data returned had hash of $md5, expected $exp_md5" >>$seqres.full
> +        status=1
> +    fi
> +
> +    return $status
> +}
> +
> +do_encoded_write() {
> +    local fn=$1
> +    local exp_ret=$2
> +    local len=$3
> +    local unencoded_len=$4
> +    local unencoded_offset=$5
> +    local compression=$6
> +    local data_file=$7
> +
> +    local tmpfile=`mktemp`
> +
> +    echo "running btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_offset $compression < $data_file > $tmpfile" >>$seqres.full
> +    src/btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_offset $compression < $data_file > $tmpfile
> +
> +    if [[ $? -ne 0 ]]; then
> +        echo "btrfs_encoded_write failed" >>$seqres.full
> +        rm $tmpfile
> +        return 1
> +    fi
> +
> +    exec {FD}< $tmpfile
> +
> +    read -u ${FD} ret
> +
> +    if [[ $ret -lt 0 ]]; then
> +        if [[ $ret == -1 ]]; then
> +            echo "btrfs encoded write failed with -EPERM; are you running as root?" >>$seqres.full
> +        else
> +            echo "btrfs encoded write failed (errno $ret)" >>$seqres.full
> +        fi
> +        exec {FD}<&-
> +        return 1
> +    fi
> +
> +    exec {FD}<&-
> +    rm $tmpfile
> +
> +    return 0
> +}
> +
> +test_file() {
> +    local size=$1
> +    local len=$2
> +    local unencoded_len=$3
> +    local unencoded_offset=$4
> +    local compression=$5
> +
> +    local tmpfile=`mktemp -p $SCRATCH_MNT`
> +    local randfile=`mktemp`
> +
> +    dd if=/dev/urandom of=$randfile bs=1 count=$size status=none

dd if=/dev/urandom of=$randfile bs=$size count=1 status=none

Ditto. Don't use `bs=1` but rather `count=1` and `bs=$size`. This can
be easily done in one system call instead of {$size} of them.

--nX

On Tue, 17 Dec 2024 at 13:33, Mark Harmstone <maharmstone@fb.com> wrote:
>
> Add btrfs/333 and its helper programs btrfs_encoded_read and
> btrfs_encoded_write, in order to test encoded reads.
>
> We use the BTRFS_IOC_ENCODED_WRITE ioctl to write random data into a
> compressed extent, then use the BTRFS_IOC_ENCODED_READ ioctl to check
> that it matches what we've written. If the new io_uring interface for
> encoded reads is supported, we also check that that matches the ioctl.
>
> Note that what we write isn't valid compressed data, so any non-encoded
> reads on these files will fail.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
> (This is a resend, with changes made to ensure that it compiles on old
> versions of liburing.)
>
>  .gitignore                |   2 +
>  m4/package_liburing.m4    |   2 +
>  src/Makefile              |   3 +-
>  src/btrfs_encoded_read.c  | 186 ++++++++++++++++++++++++++++++++
>  src/btrfs_encoded_write.c | 217 +++++++++++++++++++++++++++++++++++++
>  tests/btrfs/333           | 220 ++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/333.out       |   2 +
>  7 files changed, 631 insertions(+), 1 deletion(-)
>  create mode 100644 src/btrfs_encoded_read.c
>  create mode 100644 src/btrfs_encoded_write.c
>  create mode 100755 tests/btrfs/333
>  create mode 100644 tests/btrfs/333.out
>
> diff --git a/.gitignore b/.gitignore
> index f16173d9..efd47773 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -62,6 +62,8 @@ tags
>  /src/attr_replace_test
>  /src/attr-list-by-handle-cursor-test
>  /src/bstat
> +/src/btrfs_encoded_read
> +/src/btrfs_encoded_write
>  /src/bulkstat_null_ocount
>  /src/bulkstat_unlink_test
>  /src/bulkstat_unlink_test_modified
> diff --git a/m4/package_liburing.m4 b/m4/package_liburing.m4
> index 0553966d..7fbf4a5f 100644
> --- a/m4/package_liburing.m4
> +++ b/m4/package_liburing.m4
> @@ -1,6 +1,8 @@
>  AC_DEFUN([AC_PACKAGE_WANT_URING],
>    [ PKG_CHECK_MODULES([LIBURING], [liburing],
>      [ AC_DEFINE([HAVE_LIBURING], [1], [Use liburing])
> +      AC_DEFINE_UNQUOTED([LIBURING_MAJOR_VERSION], [`$PKG_CONFIG --modversion liburing | cut -d. -f1`], [liburing major version])
> +      AC_DEFINE_UNQUOTED([LIBURING_MINOR_VERSION], [`$PKG_CONFIG --modversion liburing | cut -d. -f2`], [liburing minor version])
>        have_uring=true
>      ],
>      [ have_uring=false ])
> diff --git a/src/Makefile b/src/Makefile
> index a0396332..b42b8147 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -34,7 +34,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>         attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>         fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>         detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -       uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
> +       uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> +       btrfs_encoded_read btrfs_encoded_write
>
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>               btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
> new file mode 100644
> index 00000000..c3ec7a9b
> --- /dev/null
> +++ b/src/btrfs_encoded_read.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Meta Platforms, Inc. and affiliates.
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/uio.h>
> +#include <sys/ioctl.h>
> +#include <linux/btrfs.h>
> +#include "config.h"
> +
> +#ifdef HAVE_LIBURING
> +#include <liburing.h>
> +#endif
> +
> +/* IORING_OP_URING_CMD defined from liburing 2.2 onwards */
> +#if defined(HAVE_LIBURING) && (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 2))
> +#define IORING_OP_URING_CMD 46
> +#endif
> +
> +#define BTRFS_MAX_COMPRESSED 131072
> +#define QUEUE_DEPTH 1
> +
> +static int encoded_read_ioctl(const char *filename, long long offset)
> +{
> +       int ret, fd;
> +       char buf[BTRFS_MAX_COMPRESSED];
> +       struct iovec iov;
> +       struct btrfs_ioctl_encoded_io_args enc;
> +
> +       fd = open(filename, O_RDONLY);
> +       if (fd < 0) {
> +               fprintf(stderr, "open failed for %s\n", filename);
> +               return 1;
> +       }
> +
> +       iov.iov_base = buf;
> +       iov.iov_len = sizeof(buf);
> +
> +       enc.iov = &iov;
> +       enc.iovcnt = 1;
> +       enc.offset = offset;
> +       enc.flags = 0;
> +
> +       ret = ioctl(fd, BTRFS_IOC_ENCODED_READ, &enc);
> +
> +       if (ret < 0) {
> +               printf("%i\n", -errno);
> +               close(fd);
> +               return 0;
> +       }
> +
> +       close(fd);
> +
> +       printf("%i\n", ret);
> +       printf("%llu\n", enc.len);
> +       printf("%llu\n", enc.unencoded_len);
> +       printf("%llu\n", enc.unencoded_offset);
> +       printf("%u\n", enc.compression);
> +       printf("%u\n", enc.encryption);
> +
> +       fwrite(buf, ret, 1, stdout);
> +
> +       return 0;
> +}
> +
> +static int encoded_read_io_uring(const char *filename, long long offset)
> +{
> +#ifdef HAVE_LIBURING
> +       int ret, fd;
> +       char buf[BTRFS_MAX_COMPRESSED];
> +       struct iovec iov;
> +       struct btrfs_ioctl_encoded_io_args enc;
> +       struct io_uring ring;
> +       struct io_uring_sqe *sqe;
> +       struct io_uring_cqe *cqe;
> +
> +       io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
> +
> +       fd = open(filename, O_RDONLY);
> +       if (fd < 0) {
> +               fprintf(stderr, "open failed for %s\n", filename);
> +               ret = 1;
> +               goto out_uring;
> +       }
> +
> +       iov.iov_base = buf;
> +       iov.iov_len = sizeof(buf);
> +
> +       enc.iov = &iov;
> +       enc.iovcnt = 1;
> +       enc.offset = offset;
> +       enc.flags = 0;
> +
> +       sqe = io_uring_get_sqe(&ring);
> +       if (!sqe) {
> +               fprintf(stderr, "io_uring_get_sqe failed\n");
> +               ret = 1;
> +               goto out_close;
> +       }
> +
> +       io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
> +
> +       /* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
> +#if (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 3))
> +       sqe->off = BTRFS_IOC_ENCODED_READ;
> +#else
> +       sqe->cmd_op = BTRFS_IOC_ENCODED_READ;
> +#endif
> +
> +       io_uring_submit(&ring);
> +
> +       ret = io_uring_wait_cqe(&ring, &cqe);
> +       if (ret < 0) {
> +               fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
> +               ret = 1;
> +               goto out_close;
> +       }
> +
> +       io_uring_cqe_seen(&ring, cqe);
> +
> +       if (cqe->res < 0) {
> +               printf("%i\n", cqe->res);
> +               ret = 0;
> +               goto out_close;
> +       }
> +
> +       printf("%i\n", cqe->res);
> +       printf("%llu\n", enc.len);
> +       printf("%llu\n", enc.unencoded_len);
> +       printf("%llu\n", enc.unencoded_offset);
> +       printf("%u\n", enc.compression);
> +       printf("%u\n", enc.encryption);
> +
> +       fwrite(buf, cqe->res, 1, stdout);
> +
> +       ret = 0;
> +
> +out_close:
> +       close(fd);
> +
> +out_uring:
> +       io_uring_queue_exit(&ring);
> +
> +       return ret;
> +#else
> +       fprintf(stderr, "liburing not linked in\n");
> +       return 1;
> +#endif
> +}
> +
> +static void usage()
> +{
> +       fprintf(stderr, "Usage: btrfs_encoded_read ioctl|io_uring filename offset\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       const char *filename;
> +       long long offset;
> +
> +       if (argc != 4) {
> +               usage();
> +               return 1;
> +       }
> +
> +       filename = argv[2];
> +
> +       offset = atoll(argv[3]);
> +       if (offset == 0 && errno != 0) {
> +               usage();
> +               return 1;
> +       }
> +
> +       if (!strcmp(argv[1], "ioctl")) {
> +               return encoded_read_ioctl(filename, offset);
> +       } else if (!strcmp(argv[1], "io_uring")) {
> +               return encoded_read_io_uring(filename, offset);
> +       } else {
> +               usage();
> +               return 1;
> +       }
> +}
> diff --git a/src/btrfs_encoded_write.c b/src/btrfs_encoded_write.c
> new file mode 100644
> index 00000000..98f4a5b2
> --- /dev/null
> +++ b/src/btrfs_encoded_write.c
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) Meta Platforms, Inc. and affiliates.
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/uio.h>
> +#include <sys/ioctl.h>
> +#include <linux/btrfs.h>
> +#include "config.h"
> +
> +#ifdef HAVE_LIBURING
> +#include <liburing.h>
> +#endif
> +
> +/* IORING_OP_URING_CMD defined from liburing 2.2 onwards */
> +#if defined(HAVE_LIBURING) && (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 2))
> +#define IORING_OP_URING_CMD 46
> +#endif
> +
> +#define BTRFS_MAX_COMPRESSED 131072
> +#define QUEUE_DEPTH 1
> +
> +static int encoded_write_ioctl(const char *filename, long long offset,
> +                              long long len, long long unencoded_len,
> +                              long long unencoded_offset, int compression,
> +                              char *buf, size_t size)
> +{
> +       int ret, fd;
> +       struct iovec iov;
> +       struct btrfs_ioctl_encoded_io_args enc;
> +
> +       fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
> +       if (fd < 0) {
> +               fprintf(stderr, "open failed for %s\n", filename);
> +               return 1;
> +       }
> +
> +       iov.iov_base = buf;
> +       iov.iov_len = size;
> +
> +       memset(&enc, 0, sizeof(enc));
> +       enc.iov = &iov;
> +       enc.iovcnt = 1;
> +       enc.offset = offset;
> +       enc.len = len;
> +       enc.unencoded_len = unencoded_len;
> +       enc.unencoded_offset = unencoded_offset;
> +       enc.compression = compression;
> +
> +       ret = ioctl(fd, BTRFS_IOC_ENCODED_WRITE, &enc);
> +
> +       if (ret < 0) {
> +               printf("%i\n", -errno);
> +               close(fd);
> +               return 0;
> +       }
> +
> +       printf("%i\n", ret);
> +
> +       close(fd);
> +
> +       return 0;
> +}
> +
> +static int encoded_write_io_uring(const char *filename, long long offset,
> +                                 long long len, long long unencoded_len,
> +                                 long long unencoded_offset, int compression,
> +                                 char *buf, size_t size)
> +{
> +#ifdef HAVE_LIBURING
> +       int ret, fd;
> +       struct iovec iov;
> +       struct btrfs_ioctl_encoded_io_args enc;
> +       struct io_uring ring;
> +       struct io_uring_sqe *sqe;
> +       struct io_uring_cqe *cqe;
> +
> +       io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
> +
> +       fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
> +       if (fd < 0) {
> +               fprintf(stderr, "open failed for %s\n", filename);
> +               ret = 1;
> +               goto out_uring;
> +       }
> +
> +       iov.iov_base = buf;
> +       iov.iov_len = size;
> +
> +       memset(&enc, 0, sizeof(enc));
> +       enc.iov = &iov;
> +       enc.iovcnt = 1;
> +       enc.offset = offset;
> +       enc.len = len;
> +       enc.unencoded_len = unencoded_len;
> +       enc.unencoded_offset = unencoded_offset;
> +       enc.compression = compression;
> +
> +       sqe = io_uring_get_sqe(&ring);
> +       if (!sqe) {
> +               fprintf(stderr, "io_uring_get_sqe failed\n");
> +               ret = 1;
> +               goto out_close;
> +       }
> +
> +       io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
> +
> +       /* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
> +#if (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 3))
> +       sqe->off = BTRFS_IOC_ENCODED_WRITE;
> +#else
> +       sqe->cmd_op = BTRFS_IOC_ENCODED_WRITE;
> +#endif
> +
> +       io_uring_submit(&ring);
> +
> +       ret = io_uring_wait_cqe(&ring, &cqe);
> +       if (ret < 0) {
> +               fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
> +               ret = 1;
> +               goto out_close;
> +       }
> +
> +       io_uring_cqe_seen(&ring, cqe);
> +
> +       if (cqe->res < 0) {
> +               printf("%i\n", cqe->res);
> +               ret = 0;
> +               goto out_close;
> +       }
> +
> +       printf("%i\n", cqe->res);
> +
> +       ret = 0;
> +
> +out_close:
> +       close(fd);
> +
> +out_uring:
> +       io_uring_queue_exit(&ring);
> +
> +       return ret;
> +#else
> +       fprintf(stderr, "liburing not linked in\n");
> +       return 1;
> +#endif
> +}
> +
> +static void usage()
> +{
> +       fprintf(stderr, "Usage: btrfs_encoded_write ioctl|io_uring filename offset len unencoded_len unencoded_offset compression\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       const char *filename;
> +       long long offset, len, unencoded_len, unencoded_offset;
> +       int compression;
> +       char buf[BTRFS_MAX_COMPRESSED];
> +       size_t size;
> +
> +       if (argc != 8) {
> +               usage();
> +               return 1;
> +       }
> +
> +       filename = argv[2];
> +
> +       offset = atoll(argv[3]);
> +       if (offset == 0 && errno != 0) {
> +               usage();
> +               return 1;
> +       }
> +
> +       len = atoll(argv[4]);
> +       if (len == 0 && errno != 0) {
> +               usage();
> +               return 1;
> +       }
> +
> +       unencoded_len = atoll(argv[5]);
> +       if (unencoded_len == 0 && errno != 0) {
> +               usage();
> +               return 1;
> +       }
> +
> +       unencoded_offset = atoll(argv[6]);
> +       if (unencoded_offset == 0 && errno != 0) {
> +               usage();
> +               return 1;
> +       }
> +
> +       compression = atoi(argv[7]);
> +       if (compression == 0 && errno != 0) {
> +               usage();
> +               return 1;
> +       }
> +
> +       size = fread(buf, 1, BTRFS_MAX_COMPRESSED, stdin);
> +
> +       if (!strcmp(argv[1], "ioctl")) {
> +               return encoded_write_ioctl(filename, offset, len, unencoded_len,
> +                                          unencoded_offset, compression, buf,
> +                                          size);
> +       } else if (!strcmp(argv[1], "io_uring")) {
> +               return encoded_write_io_uring(filename, offset, len,
> +                                             unencoded_len, unencoded_offset,
> +                                             compression, buf, size);
> +       } else {
> +               usage();
> +               return 1;
> +       }
> +}
> diff --git a/tests/btrfs/333 b/tests/btrfs/333
> new file mode 100755
> index 00000000..8e4de4c0
> --- /dev/null
> +++ b/tests/btrfs/333
> @@ -0,0 +1,220 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/333
> +#
> +# Test btrfs encoded reads
> +
> +. ./common/preamble
> +_begin_fstest auto quick compress rw
> +
> +. ./common/filter
> +. ./common/btrfs
> +
> +_supported_fs btrfs
> +
> +do_encoded_read() {
> +    local fn=$1
> +    local type=$2
> +    local exp_ret=$3
> +    local exp_len=$4
> +    local exp_unencoded_len=$5
> +    local exp_unencoded_offset=$6
> +    local exp_compression=$7
> +    local exp_md5=$8
> +
> +    local tmpfile=`mktemp`
> +
> +    echo "running btrfs_encoded_read $type $fn 0 > $tmpfile" >>$seqres.full
> +    src/btrfs_encoded_read $type $fn 0 > $tmpfile
> +
> +    if [[ $? -ne 0 ]]; then
> +        echo "btrfs_encoded_read failed" >>$seqres.full
> +        rm $tmpfile
> +        return 1
> +    fi
> +
> +    exec {FD}< $tmpfile
> +
> +    read -u ${FD} ret
> +
> +    if [[ $ret == -95 && $type -eq "io_uring" ]]; then
> +        echo "btrfs io_uring encoded read failed with -EOPNOTSUPP, skipping" >>$seqres.full
> +        exec {FD}<&-
> +        return 1
> +    fi
> +
> +    if [[ $ret -lt 0 ]]; then
> +        if [[ $ret == -1 ]]; then
> +            echo "btrfs encoded read failed with -EPERM; are you running as root?" >>$seqres.full
> +        else
> +            echo "btrfs encoded read failed (errno $ret)" >>$seqres.full
> +        fi
> +        exec {FD}<&-
> +        return 1
> +    fi
> +
> +    local status=0
> +
> +    if [[ $ret -ne $exp_ret ]]; then
> +        echo "$fn: btrfs encoded read returned $ret, expected $exp_ret" >>$seqres.full
> +        status=1
> +    fi
> +
> +    read -u ${FD} len
> +    read -u ${FD} unencoded_len
> +    read -u ${FD} unencoded_offset
> +    read -u ${FD} compression
> +    read -u ${FD} encryption
> +
> +    local filesize=`stat -c%s $tmpfile`
> +    local datafile=`mktemp`
> +
> +    dd if=$tmpfile of=$datafile bs=1 count=$ret skip=$(($filesize-$ret)) status=none
> +
> +    exec {FD}<&-
> +    rm $tmpfile
> +
> +    local md5=`md5sum $datafile | cut -d ' ' -f 1`
> +    rm $datafile
> +
> +    if [[ $len -ne $exp_len ]]; then
> +        echo "$fn: btrfs encoded read had len of $len, expected $exp_len" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $unencoded_len -ne $exp_unencoded_len ]]; then
> +        echo "$fn: btrfs encoded read had unencoded_len of $unencoded_len, expected $exp_unencoded_len" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $unencoded_offset -ne $exp_unencoded_offset ]]; then
> +        echo "$fn: btrfs encoded read had unencoded_offset of $unencoded_offset, expected $exp_unencoded_offset" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $compression -ne $exp_compression ]]; then
> +        echo "$fn: btrfs encoded read had compression of $compression, expected $exp_compression" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $encryption -ne 0 ]]; then
> +        echo "$fn: btrfs encoded read had encryption of $encryption, expected 0" >>$seqres.full
> +        status=1
> +    fi
> +
> +    if [[ $md5 != $exp_md5 ]]; then
> +        echo "$fn: data returned had hash of $md5, expected $exp_md5" >>$seqres.full
> +        status=1
> +    fi
> +
> +    return $status
> +}
> +
> +do_encoded_write() {
> +    local fn=$1
> +    local exp_ret=$2
> +    local len=$3
> +    local unencoded_len=$4
> +    local unencoded_offset=$5
> +    local compression=$6
> +    local data_file=$7
> +
> +    local tmpfile=`mktemp`
> +
> +    echo "running btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_offset $compression < $data_file > $tmpfile" >>$seqres.full
> +    src/btrfs_encoded_write ioctl $fn 0 $len $unencoded_len $unencoded_offset $compression < $data_file > $tmpfile
> +
> +    if [[ $? -ne 0 ]]; then
> +        echo "btrfs_encoded_write failed" >>$seqres.full
> +        rm $tmpfile
> +        return 1
> +    fi
> +
> +    exec {FD}< $tmpfile
> +
> +    read -u ${FD} ret
> +
> +    if [[ $ret -lt 0 ]]; then
> +        if [[ $ret == -1 ]]; then
> +            echo "btrfs encoded write failed with -EPERM; are you running as root?" >>$seqres.full
> +        else
> +            echo "btrfs encoded write failed (errno $ret)" >>$seqres.full
> +        fi
> +        exec {FD}<&-
> +        return 1
> +    fi
> +
> +    exec {FD}<&-
> +    rm $tmpfile
> +
> +    return 0
> +}
> +
> +test_file() {
> +    local size=$1
> +    local len=$2
> +    local unencoded_len=$3
> +    local unencoded_offset=$4
> +    local compression=$5
> +
> +    local tmpfile=`mktemp -p $SCRATCH_MNT`
> +    local randfile=`mktemp`
> +
> +    dd if=/dev/urandom of=$randfile bs=1 count=$size status=none
> +    local md5=`md5sum $randfile | cut -d ' ' -f 1`
> +
> +    do_encoded_write $tmpfile $size $len $unencoded_len $unencoded_offset \
> +        $compression $randfile || _fail "encoded write ioctl failed"
> +
> +    rm $randfile
> +
> +    do_encoded_read $tmpfile ioctl $size $len $unencoded_len \
> +        $unencoded_offset $compression $md5 || _fail "encoded read ioctl failed"
> +    do_encoded_read $tmpfile io_uring $size $len $unencoded_len \
> +        $unencoded_offset $compression $md5 || _fail "encoded read io_uring failed"
> +
> +    rm $tmpfile
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +sector_size=$(_scratch_btrfs_sectorsize)
> +
> +if [[ $sector_size -ne 4096 && $sector_size -ne 65536 ]]; then
> +    _notrun "sector size $sector_size not supported by this test"
> +fi
> +
> +_scratch_mount "-o max_inline=2048"
> +
> +if [[ $sector_size -eq 4096 ]]; then
> +    test_file 40960 97966 98304 0 1 # zlib
> +    test_file 40960 97966 98304 0 2 # zstd
> +    test_file 40960 97966 98304 0 3 # lzo 4k
> +    test_file 40960 97966 110592 4096 1 # bookended zlib
> +    test_file 40960 97966 110592 4096 2 # bookended zstd
> +    test_file 40960 97966 110592 4096 3 # bookended lzo 4k
> +elif [[ $sector_size -eq 65536 ]]; then
> +    test_file 65536 97966 131072 0 1 # zlib
> +    test_file 65536 97966 131072 0 2 # zstd
> +    test_file 65536 97966 131072 0 7 # lzo 64k
> +    # can't test bookended extents on 64k, as max is only 2 sectors long
> +fi
> +
> +# btrfs won't create inline files unless PAGE_SIZE == sector size
> +if [[ "$(_get_page_size)" -eq $sector_size ]]; then
> +    test_file 892 1931 1931 0 1 # inline zlib
> +    test_file 892 1931 1931 0 2 # inline zstd
> +
> +    if [[ $sector_size -eq 4096 ]]; then
> +        test_file 892 1931 1931 0 3 # inline lzo 4k
> +    elif [[ $sector_size -eq 65536 ]]; then
> +        test_file 892 1931 1931 0 7 # inline lzo 64k
> +    fi
> +fi
> +
> +_scratch_unmount
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/btrfs/333.out b/tests/btrfs/333.out
> new file mode 100644
> index 00000000..60a15898
> --- /dev/null
> +++ b/tests/btrfs/333.out
> @@ -0,0 +1,2 @@
> +QA output created by 333
> +Silence is golden
> --
> 2.45.2
>
>

