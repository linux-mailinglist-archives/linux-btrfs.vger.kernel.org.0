Return-Path: <linux-btrfs+bounces-10711-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA0AA00BE0
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 17:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA9D116450E
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jan 2025 16:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2F91FBE8D;
	Fri,  3 Jan 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="vl2VFTj/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4331FAC46
	for <linux-btrfs@vger.kernel.org>; Fri,  3 Jan 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920801; cv=none; b=hKi4Ta2Mx2PpAlAEO/xHBTNEDH5HcUf8g3dIy0aDtY6vnqo9HbyBkTWsOnN8eO55VD0YRXAUBSRtUYKVBcuZdAOTV3sbbqAmLnxtdJTi6jkeWQ/R5yCghz4W0sGH95fsPmUL1As424HhLskJ4yaC4liDX7cSWDxf/m/nfV0wIig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920801; c=relaxed/simple;
	bh=v677yCb+SsNAE2iBgdo2bsKmHT5B9ywfUM8/wWkxdKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7KdgjVHdcvGyucyLC/68MNlnsykQHDCcnMrmHS8eykeVTFYRsGGwJ3mXULMkLOKBclRNxLFAf4rtvnBprznMdnx9vSqZhKB3ByeHVb8LXh5a5kviLOjhXMESJBoCL6QIA8YFk32PiugEXpsHRzzgm+Ir5sKc2uuGb0cJSM4IV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=vl2VFTj/; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6e8fe401eso1040012985a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 03 Jan 2025 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1735920797; x=1736525597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mVLPkKaREXXl1/ZDEYlstXn/XrSPom1WN2ycVv7auhg=;
        b=vl2VFTj/Zp87FhqVkUiVM+JLkN9EDHfyEoI7Hz7WOHUT8KZ6XgY3CAqjpcMaudKlfh
         N6TIU9EFGwL3q4+E8ExTdocA/RM6qsAk5SthjCGecUP8jkYNkQbB9mp4L2wGfxUIc/U6
         5XmYN7SYJOwQO2HubHDEIncHI19vQwhRez9w5NiuOJWpmDmnNXTtrbx5PbxfSX4svIPH
         mWUSUY7xe8odCvXaYER99vdNi1Rj+k5FkfXQq9WHZubw3dIPN0H2MLOlMy1zVVLGqRyq
         SNaxpUdz2DUpQD0bdRyZUYb9PKBGgrxwgYeB4vtwY6kKpi52kFmw8uLtMlou5+f19zNy
         1YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735920797; x=1736525597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVLPkKaREXXl1/ZDEYlstXn/XrSPom1WN2ycVv7auhg=;
        b=sYh4kVU0bw6CiytEhioYIykDFfAqEJ419i6ibVlHhzEyekoikifiziGkH1L0uudCu7
         7LXSC8ENDTDMKWsNeqxxQQutiUZARWXtJrYuJAKfHvJM4S30B0pT0eVmCW15MT89C4jZ
         3EjVt0H7+qLyRUxF802DmzVJaDlpsgzkwHkyTcJndJ5v5JV2jH9mWtEsw90ZKNTFc8NP
         0ligfrVVhqL+7UiT0eKDfmWearxVpXbRloUVcZpeZetbWhbrNHegfp7iAepujyRShpOD
         otfA/TBabZWEZ4Seb6a9jRSp/V/k9mvb25G8ka2aFDDVVVEkJxls3YMJ333W/VFuLFXC
         5ISg==
X-Forwarded-Encrypted: i=1; AJvYcCWskZjnU6jm5gMsJPglnC75atA3ZjDnYGlCUuiL++GKUITqwW38SYRenmLcqYIPsRDX/Vx8bpt18mLupA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJnucsf8Nrv/YJK6Jl0m4Qx+T5BHwpXJrDdV5L7lEoQ/PfuUCl
	q11ZYAFZTn/gEPfMqVJLqI5wkEMEq6UqdevTLZkijaOWrnJ1/SAbq2yVuNP3bFIIR8qanwlZGvJ
	bAEc=
X-Gm-Gg: ASbGncsCA2lX0u+xZKOepaw6Y3mfQJqvSCL7bPBwFCw0NSpRuc8GgelCPVMdGZsQ7nD
	Q1CmIAIToOnl1q1PvijH7q1kEMsZrewBFLqzuSd5eOf4/Tn0HCdG1r4ds1Ypk/F3l/CsS6pvxHi
	b9RuT1BxoPLNHkNuz5YvrNLIGaCXYLaZAZl6DyelNuzPAJ/EAkCIJixcftNNOs2WDHJezn3/czA
	j4ftqyI7zZIE4rxj4/UW+m+cV9ViqrdO8INmt5MuyNQ0zIjghpcc/Mvc5BWqJGzGEczeCb6iD7v
	mrSQD1HVN5Q+HZuiaQ==
X-Google-Smtp-Source: AGHT+IF8QYOGUmg9GNJSX5QhzyyWCV63lJISOfpHNKqqfLY8kMPUaPBhH4GJBe7wqYsHr+N6UXGVNQ==
X-Received: by 2002:ad4:5967:0:b0:6d8:b371:6a0f with SMTP id 6a1803df08f44-6dd233970e4mr765868786d6.31.1735920796752;
        Fri, 03 Jan 2025 08:13:16 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd58598d98sm90189816d6.35.2025.01.03.08.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 08:13:15 -0800 (PST)
Date: Fri, 3 Jan 2025 11:13:14 -0500
From: Josef Bacik <josef@toxicpanda.com>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, neelx@suse.com,
	Johannes.Thumschirn@wdc.com, anand.jain@oracle.com
Subject: Re: [PATCH v3 2/2] btrfs: add test for encoded reads
Message-ID: <20250103161314.GA4067957@perftesting>
References: <20241219145608.3925261-1-maharmstone@fb.com>
 <20241219145608.3925261-2-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219145608.3925261-2-maharmstone@fb.com>

On Thu, Dec 19, 2024 at 02:55:56PM +0000, Mark Harmstone wrote:
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
> This should now work on systems with old versions of liburing, and
> systems with old versions of the btrfs.h header.
> 
> I've also included Daniel Vacek's suggestions for reducing the amount of
> time spent doing dd.
> 
>  .gitignore                |   2 +
>  m4/package_liburing.m4    |   2 +
>  src/Makefile              |   3 +-
>  src/btrfs_encoded_read.c  | 203 +++++++++++++++++++++++++++++++++
>  src/btrfs_encoded_write.c | 234 ++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/333           | 220 +++++++++++++++++++++++++++++++++++
>  tests/btrfs/333.out       |   2 +
>  7 files changed, 665 insertions(+), 1 deletion(-)
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
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment
> +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault min_dio_alignment \
> +	btrfs_encoded_read btrfs_encoded_write
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> diff --git a/src/btrfs_encoded_read.c b/src/btrfs_encoded_read.c
> new file mode 100644
> index 00000000..2e4079b0
> --- /dev/null
> +++ b/src/btrfs_encoded_read.c
> @@ -0,0 +1,203 @@
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
> +#ifndef BTRFS_IOC_ENCODED_READ
> +struct btrfs_ioctl_encoded_io_args {
> +	const struct iovec *iov;
> +	unsigned long iovcnt;
> +	__s64 offset;
> +	__u64 flags;
> +	__u64 len;
> +	__u64 unencoded_len;
> +	__u64 unencoded_offset;
> +	__u32 compression;
> +	__u32 encryption;
> +	__u8 reserved[64];
> +};
> +
> +#define BTRFS_IOC_ENCODED_READ _IOR(BTRFS_IOCTL_MAGIC, 64, struct btrfs_ioctl_encoded_io_args)
> +#endif
> +
> +#define BTRFS_MAX_COMPRESSED 131072
> +#define QUEUE_DEPTH 1
> +
> +static int encoded_read_ioctl(const char *filename, long long offset)
> +{
> +	int ret, fd;
> +	char buf[BTRFS_MAX_COMPRESSED];
> +	struct iovec iov;
> +	struct btrfs_ioctl_encoded_io_args enc;
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "open failed for %s\n", filename);
> +		return 1;
> +	}
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = sizeof(buf);
> +
> +	enc.iov = &iov;
> +	enc.iovcnt = 1;
> +	enc.offset = offset;
> +	enc.flags = 0;
> +
> +	ret = ioctl(fd, BTRFS_IOC_ENCODED_READ, &enc);
> +
> +	if (ret < 0) {
> +		printf("%i\n", -errno);
> +		close(fd);
> +		return 0;
> +	}
> +
> +	close(fd);
> +
> +	printf("%i\n", ret);
> +	printf("%llu\n", enc.len);
> +	printf("%llu\n", enc.unencoded_len);
> +	printf("%llu\n", enc.unencoded_offset);
> +	printf("%u\n", enc.compression);
> +	printf("%u\n", enc.encryption);
> +
> +	fwrite(buf, ret, 1, stdout);
> +
> +	return 0;
> +}
> +
> +static int encoded_read_io_uring(const char *filename, long long offset)
> +{
> +#ifdef HAVE_LIBURING

Instead of doing this, add

ifeq ($(HAVE_LIBURING),true)
LINUX_TARGETS += btrfs_encoded_read btrfs_encoded_write
endif

and then in your test you add 

_require_command src/btrfs_encoded_read
_require_command src/btrfs_encoded_write

And then you can remove all this extra code to check for liburing.

> +	int ret, fd;
> +	char buf[BTRFS_MAX_COMPRESSED];
> +	struct iovec iov;
> +	struct btrfs_ioctl_encoded_io_args enc;
> +	struct io_uring ring;
> +	struct io_uring_sqe *sqe;
> +	struct io_uring_cqe *cqe;
> +
> +	io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
> +
> +	fd = open(filename, O_RDONLY);
> +	if (fd < 0) {
> +		fprintf(stderr, "open failed for %s\n", filename);
> +		ret = 1;
> +		goto out_uring;
> +	}
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = sizeof(buf);
> +
> +	enc.iov = &iov;
> +	enc.iovcnt = 1;
> +	enc.offset = offset;
> +	enc.flags = 0;
> +
> +	sqe = io_uring_get_sqe(&ring);
> +	if (!sqe) {
> +		fprintf(stderr, "io_uring_get_sqe failed\n");
> +		ret = 1;
> +		goto out_close;
> +	}
> +
> +	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
> +
> +	/* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
> +#if (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 3))
> +	sqe->off = BTRFS_IOC_ENCODED_READ;
> +#else
> +	sqe->cmd_op = BTRFS_IOC_ENCODED_READ;
> +#endif
> +
> +	io_uring_submit(&ring);
> +
> +	ret = io_uring_wait_cqe(&ring, &cqe);
> +	if (ret < 0) {
> +		fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
> +		ret = 1;
> +		goto out_close;
> +	}
> +
> +	io_uring_cqe_seen(&ring, cqe);
> +
> +	if (cqe->res < 0) {
> +		printf("%i\n", cqe->res);
> +		ret = 0;
> +		goto out_close;
> +	}
> +
> +	printf("%i\n", cqe->res);
> +	printf("%llu\n", enc.len);
> +	printf("%llu\n", enc.unencoded_len);
> +	printf("%llu\n", enc.unencoded_offset);
> +	printf("%u\n", enc.compression);
> +	printf("%u\n", enc.encryption);
> +
> +	fwrite(buf, cqe->res, 1, stdout);
> +
> +	ret = 0;
> +
> +out_close:
> +	close(fd);
> +
> +out_uring:
> +	io_uring_queue_exit(&ring);
> +
> +	return ret;
> +#else
> +	fprintf(stderr, "liburing not linked in\n");
> +	return 1;
> +#endif
> +}
> +
> +static void usage()
> +{
> +	fprintf(stderr, "Usage: btrfs_encoded_read ioctl|io_uring filename offset\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *filename;
> +	long long offset;
> +
> +	if (argc != 4) {
> +		usage();
> +		return 1;
> +	}
> +
> +	filename = argv[2];
> +
> +	offset = atoll(argv[3]);
> +	if (offset == 0 && errno != 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	if (!strcmp(argv[1], "ioctl")) {
> +		return encoded_read_ioctl(filename, offset);
> +	} else if (!strcmp(argv[1], "io_uring")) {
> +		return encoded_read_io_uring(filename, offset);
> +	} else {
> +		usage();
> +		return 1;
> +	}
> +}
> diff --git a/src/btrfs_encoded_write.c b/src/btrfs_encoded_write.c
> new file mode 100644
> index 00000000..1b063fa1
> --- /dev/null
> +++ b/src/btrfs_encoded_write.c
> @@ -0,0 +1,234 @@
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
> +#ifndef BTRFS_IOC_ENCODED_WRITE
> +struct btrfs_ioctl_encoded_io_args {
> +	const struct iovec *iov;
> +	unsigned long iovcnt;
> +	__s64 offset;
> +	__u64 flags;
> +	__u64 len;
> +	__u64 unencoded_len;
> +	__u64 unencoded_offset;
> +	__u32 compression;
> +	__u32 encryption;
> +	__u8 reserved[64];
> +};
> +
> +#define BTRFS_IOC_ENCODED_WRITE _IOW(BTRFS_IOCTL_MAGIC, 64, struct btrfs_ioctl_encoded_io_args)
> +#endif
> +
> +#define BTRFS_MAX_COMPRESSED 131072
> +#define QUEUE_DEPTH 1
> +
> +static int encoded_write_ioctl(const char *filename, long long offset,
> +			       long long len, long long unencoded_len,
> +			       long long unencoded_offset, int compression,
> +			       char *buf, size_t size)
> +{
> +	int ret, fd;
> +	struct iovec iov;
> +	struct btrfs_ioctl_encoded_io_args enc;
> +
> +	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
> +	if (fd < 0) {
> +		fprintf(stderr, "open failed for %s\n", filename);
> +		return 1;
> +	}
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = size;
> +
> +	memset(&enc, 0, sizeof(enc));
> +	enc.iov = &iov;
> +	enc.iovcnt = 1;
> +	enc.offset = offset;
> +	enc.len = len;
> +	enc.unencoded_len = unencoded_len;
> +	enc.unencoded_offset = unencoded_offset;
> +	enc.compression = compression;
> +
> +	ret = ioctl(fd, BTRFS_IOC_ENCODED_WRITE, &enc);
> +
> +	if (ret < 0) {
> +		printf("%i\n", -errno);
> +		close(fd);
> +		return 0;
> +	}
> +
> +	printf("%i\n", ret);
> +
> +	close(fd);
> +
> +	return 0;
> +}
> +
> +static int encoded_write_io_uring(const char *filename, long long offset,
> +				  long long len, long long unencoded_len,
> +				  long long unencoded_offset, int compression,
> +				  char *buf, size_t size)
> +{
> +#ifdef HAVE_LIBURING
> +	int ret, fd;
> +	struct iovec iov;
> +	struct btrfs_ioctl_encoded_io_args enc;
> +	struct io_uring ring;
> +	struct io_uring_sqe *sqe;
> +	struct io_uring_cqe *cqe;
> +
> +	io_uring_queue_init(QUEUE_DEPTH, &ring, 0);
> +
> +	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0644);
> +	if (fd < 0) {
> +		fprintf(stderr, "open failed for %s\n", filename);
> +		ret = 1;
> +		goto out_uring;
> +	}
> +
> +	iov.iov_base = buf;
> +	iov.iov_len = size;
> +
> +	memset(&enc, 0, sizeof(enc));
> +	enc.iov = &iov;
> +	enc.iovcnt = 1;
> +	enc.offset = offset;
> +	enc.len = len;
> +	enc.unencoded_len = unencoded_len;
> +	enc.unencoded_offset = unencoded_offset;
> +	enc.compression = compression;
> +
> +	sqe = io_uring_get_sqe(&ring);
> +	if (!sqe) {
> +		fprintf(stderr, "io_uring_get_sqe failed\n");
> +		ret = 1;
> +		goto out_close;
> +	}
> +
> +	io_uring_prep_rw(IORING_OP_URING_CMD, sqe, fd, &enc, sizeof(enc), 0);
> +
> +	/* sqe->cmd_op union'd to sqe->off from liburing 2.3 onwards */
> +#if (LIBURING_MAJOR_VERSION < 2 || (LIBURING_MAJOR_VERSION == 2 && LIBURING_MINOR_VERSION < 3))
> +	sqe->off = BTRFS_IOC_ENCODED_WRITE;
> +#else
> +	sqe->cmd_op = BTRFS_IOC_ENCODED_WRITE;
> +#endif
> +
> +	io_uring_submit(&ring);
> +
> +	ret = io_uring_wait_cqe(&ring, &cqe);
> +	if (ret < 0) {
> +		fprintf(stderr, "io_uring_wait_cqe returned %i\n", ret);
> +		ret = 1;
> +		goto out_close;
> +	}
> +
> +	io_uring_cqe_seen(&ring, cqe);
> +
> +	if (cqe->res < 0) {
> +		printf("%i\n", cqe->res);
> +		ret = 0;
> +		goto out_close;
> +	}
> +
> +	printf("%i\n", cqe->res);
> +
> +	ret = 0;
> +
> +out_close:
> +	close(fd);
> +
> +out_uring:
> +	io_uring_queue_exit(&ring);
> +
> +	return ret;
> +#else
> +	fprintf(stderr, "liburing not linked in\n");
> +	return 1;
> +#endif
> +}
> +
> +static void usage()
> +{
> +	fprintf(stderr, "Usage: btrfs_encoded_write ioctl|io_uring filename offset len unencoded_len unencoded_offset compression\n");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	const char *filename;
> +	long long offset, len, unencoded_len, unencoded_offset;
> +	int compression;
> +	char buf[BTRFS_MAX_COMPRESSED];
> +	size_t size;
> +
> +	if (argc != 8) {
> +		usage();
> +		return 1;
> +	}
> +
> +	filename = argv[2];
> +
> +	offset = atoll(argv[3]);
> +	if (offset == 0 && errno != 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	len = atoll(argv[4]);
> +	if (len == 0 && errno != 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	unencoded_len = atoll(argv[5]);
> +	if (unencoded_len == 0 && errno != 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	unencoded_offset = atoll(argv[6]);
> +	if (unencoded_offset == 0 && errno != 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	compression = atoi(argv[7]);
> +	if (compression == 0 && errno != 0) {
> +		usage();
> +		return 1;
> +	}
> +
> +	size = fread(buf, 1, BTRFS_MAX_COMPRESSED, stdin);
> +
> +	if (!strcmp(argv[1], "ioctl")) {
> +		return encoded_write_ioctl(filename, offset, len, unencoded_len,
> +					   unencoded_offset, compression, buf,
> +					   size);
> +	} else if (!strcmp(argv[1], "io_uring")) {
> +		return encoded_write_io_uring(filename, offset, len,
> +					      unencoded_len, unencoded_offset,
> +					      compression, buf, size);
> +	} else {
> +		usage();
> +		return 1;
> +	}
> +}
> diff --git a/tests/btrfs/333 b/tests/btrfs/333
> new file mode 100755
> index 00000000..d7fbb7c7
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

This should probably be moved to common/btrfs with a 

_require_btrfs_iouring_encoded_ops

or something like that.

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
> +    tail -c +$((1+$filesize-$ret)) $tmpfile > $datafile
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
> +    dd if=/dev/urandom of=$randfile bs=$size count=1 status=none
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

You don't have to do this, the common stuff will do it for you.  Thanks,

Josef

