Return-Path: <linux-btrfs+bounces-3487-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F4D881C0C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 05:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33801F21D7B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 04:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769332DF9C;
	Thu, 21 Mar 2024 04:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo0EkkDM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E022AF19;
	Thu, 21 Mar 2024 04:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710997013; cv=none; b=exxru6sC8y0MImvYodWD3ry5pYn+tufz23wcso0silNvygT2hGgyQozb2jgJaGE59DFoxSmGlPjff5O1FZgFlgfAeqzR5QwFq3/o29M2SVne+O76vCBaneIOPPVon+68ZWfFFJTaov7cS1GsLDQF4AZeb5060jPxoRb7BW/GzKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710997013; c=relaxed/simple;
	bh=a/QNw93w75jeAgmgN7+6Sd+DrZkYkm605IYrlw6NpEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta511R2z263PnCWTUBZufdsUdVYpTpQ62jG0QWeWbItxACd2aeY+wv4N/u/Qtd9MdaXzeUljLCSfQ1QsTee9kSeUPx8ZWKAYZMFsdR4LmtmRtfbfjgC/Lw5f3X6YaQNbzdZoEBlE59adruAI300DNfMWA1ObIeYfPWHCkky0JAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo0EkkDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0A5C433C7;
	Thu, 21 Mar 2024 04:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710997013;
	bh=a/QNw93w75jeAgmgN7+6Sd+DrZkYkm605IYrlw6NpEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xo0EkkDMpA0TQCxccFtmpPeBQBu7hIP0/d1dv51x8Y5cgwXuMD+vhsFEAaeMCj0dY
	 KOk8qrN+KBpzAO+KxZzubnZc9TTPKi53sBGdGbutbScLsE9TEXfp8kjAKSeJqime1n
	 iOReqf5EtTzbvyZ+g3oEhu/QnnwPgHr3Cc6jEVqaz2SNEM55x+ZUsLfffCQbFDywi/
	 mPrhYuODq1/19Qi3VzQ4tAeWcw9dHNhTyFPIOHdcupxwGrHx03m04Dn6OQXqhZAoHU
	 Yg0nyJXk3QvjADTlz0INPcIOkULZwDpPK9U6+ahKJJcGz4K1ppzPh4ULWf+vNOnHbi
	 jwaojTX0AYTnQ==
Date: Wed, 20 Mar 2024 21:56:52 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v4] generic/808: add a regression test for fiemap into an
 mmap range
Message-ID: <20240321045652.GP6188@frogsfrogsfrogs>
References: <dc1a90179b8de25340bd45f4e54cda8c3ab66398.1710949564.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1a90179b8de25340bd45f4e54cda8c3ab66398.1710949564.git.josef@toxicpanda.com>

On Wed, Mar 20, 2024 at 11:46:50AM -0400, Josef Bacik wrote:
> Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> using that as the buffer for fiemap.  This test adds a c program to do
> this, and the fstest creates a large enough file and then runs the
> reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> we pass fine.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good to me now,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
> v3->v4:
> - Rework this to use punch-alternating to generate a fragmented file.
> - Rework the _require's to reflect the new mode of fragmenting a file.
> 
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/fiemap-fault.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/808     | 51 +++++++++++++++++++++++++++++
>  tests/generic/808.out |  2 ++
>  5 files changed, 129 insertions(+), 1 deletion(-)
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
> index 00000000..a3570076
> --- /dev/null
> +++ b/tests/generic/808
> @@ -0,0 +1,51 @@
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
> +_require_test_program "fiemap-fault"
> +_require_test_program "punch-alternating"
> +_require_xfs_io_command "fpunch"
> +
> +dst=$TEST_DIR/$seq/fiemap-fault
> +
> +mkdir -p $TEST_DIR/$seq
> +
> +echo "Silence is golden"
> +
> +# Generate a file with lots of extents
> +blksz=$(_get_file_block_size $TEST_DIR)
> +$XFS_IO_PROG -f -c "pwrite -q 0 $((blksz * 10000))" $dst
> +$here/src/punch-alternating $dst
> +
> +# Now run the reproducer
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

