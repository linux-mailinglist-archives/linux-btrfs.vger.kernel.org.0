Return-Path: <linux-btrfs+bounces-3476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE0C88147C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 16:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD2021F21D14
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE17524C0;
	Wed, 20 Mar 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMtYbh77"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765D4C61F;
	Wed, 20 Mar 2024 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948332; cv=none; b=PVJjBNcokq7ByCCDyO31VnatB34FKc5avniiV33Jml9DGGuQKPP+AYCg5giaRf4Rr9fPpG6IzUOYI78rcsVwxYOFhBCVLM8xzI7k21Rza/VnemnxlatruQczsQ1afH8a4ELHI6M4yglqp/8wbOl0ip5vvY1eDkgr8UwI5wP4H6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948332; c=relaxed/simple;
	bh=fje9Pt57w/QvV+f4K4XLJvNpnlGz2oq9ma/LqhlgLVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFT9N86uuzyTaP0v0heRSa8iWhw7wReWR/hFRw5YEh71dBvqJEEnpETihHJNII/kXlGyWeza6zxGhHIPTnW/j+8iOEhUtcpSNGHsIw2rIFJW2Fbjr0VCmyUKNAZsVZgugkGJ7fXTeT1EgfbRpE39Sjc7RckvX6uVHXtH5t8BT3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMtYbh77; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376DC433F1;
	Wed, 20 Mar 2024 15:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948332;
	bh=fje9Pt57w/QvV+f4K4XLJvNpnlGz2oq9ma/LqhlgLVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMtYbh77+9yJhqcHkVIIBEe4xl1w7UgiPAg4KaBP+z1gT7hkMCv57ENpIneBfrq4f
	 C8dnWsBUIbvYe4pjF/+VyJw9BD7EYqTovtfgmzK82TEMD5hXST94nyPH/Qo4GqsVjn
	 JD4Dpaq+Cc4TxszdG9sOhzSM00p1NcsqYD2Jhtk73WytsZvPAMUP3CbdNqyh5nvOcE
	 OIAOYG41OPaTZLpG85VaDnSN/VPiHO3SIdq1mPXLFaMGn9i8RYon2UZ/4Aff6cidP6
	 d2g3ivWit2g+lbUCsWOrZfUp83lAn8lzMlA7382TEOJM1fO5HmvdXVteAd3Fw/8VBC
	 HCdClK0dKaJSw==
Date: Wed, 20 Mar 2024 08:25:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3] generic/808: add a regression test for fiemap into an
 mmap range
Message-ID: <20240320152531.GO6188@frogsfrogsfrogs>
References: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>

On Wed, Mar 20, 2024 at 10:36:42AM -0400, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
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
> @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
>  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
>  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> -	uuid_ioctl t_snapshot_deleted_subvolume
> +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
>  
>  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
>  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
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
> +	struct stat st;
> +	int ret;
> +
> +	ret = fstat(fd, &st);
> +	if (ret)
> +		err(1, "failed to stat %d", fd);
> +
> +	*addr = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> +	if (*addr == MAP_FAILED)
> +		err(1, "failed to mmap %d", fd);
> +
> +	return st.st_size;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct fiemap *fiemap;
> +	size_t sz, last = 0;
> +	void *buf = NULL;
> +	int ret, fd;
> +
> +	if (argc != 2)
> +		errx(1, "no in and out file name arguments given");
> +
> +	fd = open(argv[1], O_RDWR, 0666);
> +	if (fd == -1)
> +		err(1, "failed to open %s", argv[1]);
> +
> +	sz = prep_mmap_buffer(fd, &buf);
> +
> +	fiemap = (struct fiemap *)buf;
> +	fiemap->fm_flags = 0;
> +	fiemap->fm_extent_count = (sz - sizeof(struct fiemap)) /
> +				  sizeof(struct fiemap_extent);
> +
> +	while (last < sz) {
> +		int i;
> +
> +		fiemap->fm_start = last;
> +		fiemap->fm_length = sz - last;
> +
> +		ret = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
> +		if (ret < 0)
> +			err(1, "fiemap failed %d", errno);
> +		for (i = 0; i < fiemap->fm_mapped_extents; i++)
> +		       last = fiemap->fm_extents[i].fe_logical +
> +			       fiemap->fm_extents[i].fe_length;
> +	}
> +
> +	munmap(buf, sz);
> +	close(fd);
> +	return 0;
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
> +# Create a reasonably large file, then run a program which mmaps it and uses
> +# that as a buffer for an fiemap call.  This is a regression test for btrfs
> +# where we used to hold a lock for the duration of the fiemap call which would
> +# result in a deadlock if we page faulted.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto fiemap
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit b0ad381fa769 \
> +		"btrfs: fix deadlock with fiemap and extent locking"
> +
> +_cleanup()
> +{
> +	rm -f $dst
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program fiemap-fault
> +dst=$TEST_DIR/$seq/fiemap-fault
> +
> +mkdir -p $TEST_DIR/$seq
> +
> +echo "Silence is golden"
> +
> +for i in $(seq 0 2 1000)
> +do
> +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> +done

I don't know if there's a specific reason that this does directio writes
at alternating offsets other than forcing allocations, but usually we do:

$XFS_IO_PROG -f -c "pwrite -q 0 409600" $dst
$src/punch-alternating $dst

to generate a file with a bunch of extent records.  Also, since this is
a generic test that wants to create a file with sparse holes, it really
ought to be querying the file's allocation unit size:

blksz=$(_get_file_block_size $TEST_DIR)
$XFS_IO_PROG -f -c "pwrite -q 0 $((blksz * 100))" $dst

--D

> +
> +$here/src/fiemap-fault $dst
> +
> +# success, all done
> +status=$?
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

