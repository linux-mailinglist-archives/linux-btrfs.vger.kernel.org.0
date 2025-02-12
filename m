Return-Path: <linux-btrfs+bounces-11391-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC8EA31C62
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 03:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595071664F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 02:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B1E1D6DDD;
	Wed, 12 Feb 2025 02:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="itVdXAV3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F23B1D47AD
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 02:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328914; cv=none; b=X2ZhR+3wnKAcfBD4/Hl23x61TPLafy3iLd/kmW61cg/i6++HDCKo8U8cM0FY7E84Yd5hAaeFGAl4+5OgPBUmx35aMGv+TPr3qBVahtcmJSwxpF+I2F8i7AwDJDwPzFPa+pevlQVlRUmNtdT7KQyeK5/8R8YLbAjjeyND9S0sP6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328914; c=relaxed/simple;
	bh=enIXLBp4cCRgVbtO3hJBQcKzs/tR3EhrJZUtKK2GCCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYalJng5UmTP24LHd9YCxSBzGNBSZEYQO2fB3+/kF0MW/Xp9FoN1LcuUmvtX5KIGFIGOgzXkQR+udjSHsTEWaTHm+NZ7ok8sCyFWucT2w1lBe4CcMaFBjV6aAepBvUPZdWz37Tq4iLnX9gshSrZJiGXBNlcQRjS79OaaQge4Q7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=itVdXAV3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739328910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXwbsMtaizItuMstGuWew4slA9DtSNq2HN/1otMrPIo=;
	b=itVdXAV3Xeh1/IRKK4OgJHM3nAlID5jHP7Vel1PqG0rfp8z52APSYHjaDf7/bmO1+hUg0L
	313bm2zhF+h+PVb5cixRDRnzEfOFkAACOyIW3ewgxC9zKKCoPVDVMaTECkx709ivtGfFCr
	joPtQKMTwfY5dIMgFsDmWnsorf48Zxg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-GrmR3lMwPeiCHMw7ON8NTQ-1; Tue, 11 Feb 2025 21:55:09 -0500
X-MC-Unique: GrmR3lMwPeiCHMw7ON8NTQ-1
X-Mimecast-MFC-AGG-ID: GrmR3lMwPeiCHMw7ON8NTQ
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f6cd48c56so65796355ad.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Feb 2025 18:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739328908; x=1739933708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXwbsMtaizItuMstGuWew4slA9DtSNq2HN/1otMrPIo=;
        b=rgdc9iuYoeyFJjNR762bMJjEngLnEUT2N8HN73aQ3EodQU5EQKdEiR8igu9tRZVehp
         PJHDpSgbz1gh2To5ZsMJj9tg5yf8KXH2Qkz6CNH/FGBOG5oxK7GHpcBfwPhd6RCPanfH
         i4mErq9vz3TxeJ668FcICsuCmKmRwwRhNKAPVMEFV1zLWkVU832UOO9+kxxG+BoOj+aw
         nyNvlf+iu/AxUQteClNXbftAxLi8jJ2gRhDEZBjUslq4JWClplrLLbrGOM/smojuYCxA
         I4p1mgvYG6gmPcQrSKDRIIaU1XXVbcdsbNw1/Gf86rB0IMod+M5/x/pluFdWEbBY0JRl
         4o8Q==
X-Gm-Message-State: AOJu0YzmFTttgg6oyNVSrE3zTF3zEYIiydKJSgSOdnTgHACgxMtVTq6h
	+V+a1Ch0xpSzBfZIf103zr3csYCFU8K/5xEuQb3UaSwq+ktKJTYT8jVO+Wry2BbOVIk+nTqjzk5
	iUJTNTxbKoaGruJg7NMmbLm3putvkAcFjB2QYb8UH2uSvTXEHa9r5rQHT1bfw
X-Gm-Gg: ASbGncsjMuXmxaKY7EI4/9K826MZ3u4EaEJ7ny/kMeZKwaionOMuWGPl8gGwc5Z7w03
	5ncccdfKX10IWgOMg7PcADOB6NbAMEz5wneLb/EHLPtbqXz4oqr09NCbB9taEeChXIOjXoSnxZL
	ZRgdX/aFlqBTfE39A4pjqRB2V7n2esp5/FXD/M61jibqT9ax+tPrDcx7qVjxd9F13vnpcaB2dbM
	oaogdRaQg9K/9DEoog7EVv3Xj8tsRCkGL1n88z8RIMhR2jozUQqVv+h5sRhB/fQsBMDHfJ1W1gN
	CNh6KSI/s6Rcw9gGYn1ZzBCD0heUHxGXNBRVfgkFiEqzeQ==
X-Received: by 2002:a17:902:d481:b0:21f:1549:a563 with SMTP id d9443c01a7336-220bbab334emr29100485ad.2.1739328908213;
        Tue, 11 Feb 2025 18:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlbzlqsCBAvxByESEN2EA97Iy7wyzGHQcchMJ1gI79FvN7mUwictlTIeBpoymftWw90+a8qw==
X-Received: by 2002:a17:902:d481:b0:21f:1549:a563 with SMTP id d9443c01a7336-220bbab334emr29100145ad.2.1739328907767;
        Tue, 11 Feb 2025 18:55:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650cddcsm103635315ad.20.2025.02.11.18.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:55:07 -0800 (PST)
Date: Wed, 12 Feb 2025 10:55:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2] fstests: add a generic test to verify direct IO
 writes with buffer contents change
Message-ID: <20250212025503.cg5452r6swki6m3a@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9c50aa0df6cde2cb39cb7c9f978dbc27dadb770.1739241217.git.wqu@suse.com>

On Tue, Feb 11, 2025 at 04:22:57PM +1030, Qu Wenruo wrote:
> There is a long existing btrfs problem that if some one is modifying the
> buffer of an on-going direct IO write, it has a very high chance causing
> permanent data checksum mismatch.
> 
> This is caused by the following factors:
> 
> - Direct IO buffer is out of the control of filesystem
>   Thus user space can modify the contents during writeback.
> 
> - Btrfs generate its data checksum just before submitting the bio
>   This means if the contents happens after the checksum is generated,
>   the data written to disk will no longer match the checksum.
> 
> Btrfs later fixes the problem by forcing the direct IO to fallback to
> buffered IO (if the inode requires data checksum), so that btrfs can
> have a consistent view of the buffer.
> 
> This test case will verify the behavior by:
> 
> - Create a helper program 'dio-writeback-race'
>   Which does direct IO writes block-by-block, and the buffer is always
>   initialized to all 0xff before write,
>   Then starting two threads:
>   - One to submit the direct IO
>   - One to modify the buffer to 0x00
> 
>   The program uses 4K as default block size, and 64MiB as the default
>   file size.
>   Which is more than enough to trigger tons of btrfs checksum errors
>   on unpatched kernels.
> 
> - New test case generic/761
>   Which will:
> 
>   * Use above program to create a 64MiB file
> 
>   * Do buffered read on that file
>     Since above program is doing direct IO, there is no page cache
>     populated.
>     And the buffered read will need to read out all data from the disk,
>     and if the filesystem supports data checksum, then the data checksum
>     will also be verified against the data.
> 
> The test case passes on the following fses:
> - ext4
> - xfs
> - btrfs with "nodatasum" mount option
>   No data checksum to bother.
> 
> - btrfs with default "datasum" mount option and the fix "btrfs: always
>   fallback to buffered write if the inode requires checksum"
>   This makes btrfs to fallback on buffered IO so the contents won't
>   change during writeback of page cache.
> 
> And fails on the following fses:
> 
> - btrfs with default "datasum" mount option and without the fix
>   Expected.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Fix the comment on the default block size of dio-writeback-race
> - Use proper type for pthread_exit() of do_io() function
> - Fix the error message when filesize is invalid
> - Fix the error message when unknown option is parsed
> - Catch the thread return value correctly for pthread_join() on IO thread
> - Always update @ret
> - Return EXIT_SUCCESS/FAILURE based on @ret at error: tag
> - Check the return value of pthread_join() correctly
> - Remove unused cleanup override/include comments from the test case
> - Add the missing fixed-by tag
> ---
>  .gitignore               |   1 +
>  src/Makefile             |   3 +-
>  src/dio-writeback-race.c | 148 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/761        |  41 +++++++++++
>  tests/generic/761.out    |   2 +
>  5 files changed, 194 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-writeback-race.c
>  create mode 100755 tests/generic/761
>  create mode 100644 tests/generic/761.out
> 
> diff --git a/.gitignore b/.gitignore
> index efd477738e1e..7060f52cf6b8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -210,6 +210,7 @@ tags
>  /src/perf/*.pyc
>  /src/fiemap-fault
>  /src/min_dio_alignment
> +/src/dio-writeback-race
>  
>  # Symlinked files
>  /tests/generic/035.out
> diff --git a/src/Makefile b/src/Makefile
> index 1417c383863e..6ac72b366257 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -20,7 +20,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> -	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
> +	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> +	dio-writeback-race
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-writeback-race.c b/src/dio-writeback-race.c
> new file mode 100644
> index 000000000000..f0a2f6de531b
> --- /dev/null
> +++ b/src/dio-writeback-race.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dio_writeback_race -- test direct IO writes with the contents of
> + * the buffer changed during writeback.
> + *
> + * Copyright (C) 2025 SUSE Linux Products GmbH.
> + */
> +
> +/*
> + * dio_writeback_race
> + *
> + * Compile:
> + *
> + *   gcc -Wall -pthread -o dio_writeback_race dio_writeback_race.c
> + *
> + * Make sure filesystems with explicit data checksum can handle direct IO
> + * writes correctly, so that even the contents of the direct IO buffer changes
> + * during writeback, the fs should still work fine without data checksum mismatch.
> + * (Normally by falling back to buffer IO to keep the checksum and contents
> + *  consistent)
> + *
> + * Usage:
> + *
> + *   dio_writeback_race [-b <buffersize>] [-s <filesize>] <filename>
> + *
> + * Where:
> + *
> + *   <filename> is the name of the test file to create, if the file exists
> + *   it will be overwritten.
> + *
> + *   <buffersize> is the buffer size for direct IO. Users are responsible to
> + *   probe the correct direct IO size and alignment requirement.
> + *   If not specified, the default value will be 4096.
> + *
> + *   <filesize> is the total size of the test file. If not aligned to <blocksize>
> + *   the result file size will be rounded up to <blocksize>.
> + *   If not specified, the default value will be 64MiB.
> + */
> +
> +#include <fcntl.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <pthread.h>
> +#include <unistd.h>
> +#include <getopt.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +
> +static int fd = -1;
> +static void *buf = NULL;
> +static unsigned long long filesize = 64 * 1024 * 1024;
> +static int blocksize = 4096;
> +
> +const int orig_pattern = 0xff;
> +const int modify_pattern = 0x00;
> +
> +static void *do_io(void *arg)
> +{
> +	ssize_t ret;
> +
> +	ret = write(fd, buf, blocksize);
> +	pthread_exit((void *)ret);
> +}
> +
> +static void *do_modify(void *arg)
> +{
> +	memset(buf, modify_pattern, blocksize);
> +	pthread_exit(NULL);
> +}
> +
> +int main (int argc, char *argv[])
> +{
> +	pthread_t io_thread;
> +	pthread_t modify_thread;
> +	unsigned long long filepos;
> +	int opt;
> +	int ret = -EINVAL;
> +
> +	while ((opt = getopt(argc, argv, "b:s:")) > 0) {
> +		switch (opt) {
> +		case 'b':
> +			blocksize = atoi(optarg);
> +			if (blocksize == 0) {
> +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
> +				goto error;
> +			}
> +			break;
> +		case 's':
> +			filesize = atoll(optarg);
> +			if (filesize == 0) {
> +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
> +				goto error;
> +			}
> +			break;
> +		default:
> +			fprintf(stderr, "unknown option '%c'\n", opt);
> +			goto error;
> +		}
> +	}
> +	if (optind >= argc) {
> +		fprintf(stderr, "missing argument\n");
> +		goto error;
> +	}
> +	ret = posix_memalign(&buf, blocksize, blocksize);
> +	if (!buf) {
> +		fprintf(stderr, "failed to allocate aligned memory\n");
> +		exit(EXIT_FAILURE);
> +	}
> +	fd = open(argv[optind], O_DIRECT | O_WRONLY | O_CREAT);
> +	if (fd < 0) {
> +		fprintf(stderr, "failed to open file '%s': %m\n", argv[2]);
> +		goto error;
> +	}
> +
> +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> +		void *retval = NULL;
> +
> +		memset(buf, orig_pattern, blocksize);
> +		pthread_create(&io_thread, NULL, do_io, NULL);
> +		pthread_create(&modify_thread, NULL, do_modify, NULL);
> +		ret = pthread_join(io_thread, &retval);
> +		if (ret) {
> +			errno = ret;
> +			ret = -ret;
> +			fprintf(stderr, "failed to join io thread: %m\n");
> +			goto error;
> +		}
> +		if ((ssize_t )retval < blocksize) {
> +			ret = -EIO;
> +			fprintf(stderr, "io thread failed\n");
> +			goto error;
> +		}
> +		ret = pthread_join(modify_thread, NULL);
> +		if (ret) {
> +			errno = ret;
> +			ret = -ret;
> +			fprintf(stderr, "failed to join modify thread: %m\n");
> +			goto error;
> +		}
> +	}
> +error:
> +	close(fd);
> +	free(buf);
> +	if (ret < 0)
> +		return EXIT_FAILURE;
> +	return EXIT_SUCCESS;
> +}
> diff --git a/tests/generic/761 b/tests/generic/761
> new file mode 100755
> index 000000000000..422b716d31b6
> --- /dev/null
> +++ b/tests/generic/761
> @@ -0,0 +1,41 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 761
> +#
> +# Making sure direct IO (O_DIRECT) writes won't cause any data checksum mismatch,
> +# even if the contents of the buffer changes during writeback.
> +#
> +# This is mostly for filesystems with data checksum support, which should fallback
> +# to buffer IO to avoid inconsistency.
> +# For filesystems without data checksum support, nothing needs to be bothered.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_scratch
> +_require_odirect
> +_require_test_program dio-writeback-race
> +_fixed_by_kernel_commit XXXXXXXX \
> +	"btrfs: always fallback to buffered write if the inode requires checksum"
> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +blocksize=$(_get_block_size $SCRATCH_MNT)

_get_file_block_size ? Others looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

I'll help to do these changes from all review points when I merge it, if you
don't want to change it more.

Thanks,
Zorro

> +filesize=$(( 64 * 1024 * 1024))
> +
> +echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
> +
> +$here/src/dio-writeback-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
> +
> +# Read out the file, which should trigger checksum verification
> +cat $SCRATCH_MNT/foobar > /dev/null
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/761.out b/tests/generic/761.out
> new file mode 100644
> index 000000000000..72ebba4cb426
> --- /dev/null
> +++ b/tests/generic/761.out
> @@ -0,0 +1,2 @@
> +QA output created by 761
> +Silence is golden
> -- 
> 2.48.1
> 
> 


