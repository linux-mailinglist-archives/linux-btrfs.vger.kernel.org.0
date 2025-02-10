Return-Path: <linux-btrfs+bounces-11357-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D125AA2E32A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 05:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABB283A47A4
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 04:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D315574E;
	Mon, 10 Feb 2025 04:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WwHUkcKD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xr5Lh1bM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OQjd/7eW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zxBKpPTc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5F156861;
	Mon, 10 Feb 2025 04:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739162212; cv=none; b=geGESnaF1uMfemJfp62r5EYN9cfcpU8vLd0VJP05rl3PHDHTCWRfY/9BgPXbAkBUQKAx/K3Jl5A6eHDJu/EskUHp9wGEv8rdL3i0JQxEGaNJUy6VkotshCrgI9dv6LPMEvsueP5ZfV5XVddC252NSsoCN38llu9ueSkpfxVv/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739162212; c=relaxed/simple;
	bh=eZaxg6FmK61Eo4cYfP/1J1QoK/9q4A5kA1djBOH5xDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dn6qXkQS0y+cfO6wan7cxVxikb/bsmR61tW8Ttim7fDxaguIwpYG/zUovrr549gKflAI5WaTfn6t0pTJieEomhnB0IdaghHTa8euqxZLKSUgFpI3iJkwEAGIlXwUMsUG+np9vJr6csz187qN3RzlLZ45YS/gd/AQvlNmF2kCKxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WwHUkcKD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Xr5Lh1bM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OQjd/7eW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zxBKpPTc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E029B2111F;
	Mon, 10 Feb 2025 04:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739162209; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3fXi7lTuxRppmuw3JN77LwY7ZsSMPHPoOTCJ5RQH14=;
	b=WwHUkcKDN7sNxVTCUQy+hNpjQyIjs1rvxOWoGWs/tcPcrT8DRfdbqr2EyZx3yx6HTSB4xJ
	BC7NdtoHaifd0uUuA7tdxow/0rmePhdxdwTsOw4RMAG7+dyFaG9QTpDuX5vHnLIaMK/tLl
	8CSOYWllrwN6XLbf5evecZeYi3lVG+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739162209;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3fXi7lTuxRppmuw3JN77LwY7ZsSMPHPoOTCJ5RQH14=;
	b=Xr5Lh1bMRrO05fZv0UxB8K8pKEgA6m4VQLjPO2pqin/SmGbdylEgb39kwh+s6SOnL1IPbq
	8VJxwp49kUupXaCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739162208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3fXi7lTuxRppmuw3JN77LwY7ZsSMPHPoOTCJ5RQH14=;
	b=OQjd/7eWmdhJwgR27JGyOqgZxP+5FagpWThy66tx9YsNJq+kObBhN+mdWr/VCii9H5RxZY
	PDnk0yr4A6INOuLD0r3OdZG89MzSXCSYYORtrs+VW5bgmYI0YccwhTc5DHyx1mTNKfomqx
	NU3MEzD4bLg2AZMOywzPD4mHee4JLws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739162208;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3fXi7lTuxRppmuw3JN77LwY7ZsSMPHPoOTCJ5RQH14=;
	b=zxBKpPTcSVaXCFx0lyLpAycj/uBEjX7aZnTMYHxFtYjMWp6QxlziGeYgLbh5s2CKxer+R3
	BNa9RxalrUQYibAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E37313707;
	Mon, 10 Feb 2025 04:36:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n6RhMV6CqWfZYwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 10 Feb 2025 04:36:46 +0000
Date: Mon, 10 Feb 2025 15:36:33 +1100
From: David Disseldorp <ddiss@suse.de>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, Christoph Hellwig
 <hch@infradead.org>
Subject: Re: [PATCH] fstests: add a generic test to verify direct IO writes
 with buffer contents change
Message-ID: <20250210153633.608af52e.ddiss@suse.de>
In-Reply-To: <20250208054110.226709-1-wqu@suse.com>
References: <20250208054110.226709-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.30
X-Spam-Flag: NO

Hi Qu,

Thanks for adding this test. A few comments inline...

On Sat,  8 Feb 2025 16:11:10 +1030, Qu Wenruo wrote:

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
>  .gitignore               |   1 +
>  src/Makefile             |   3 +-
>  src/dio-writeback-race.c | 143 +++++++++++++++++++++++++++++++++++++++
>  tests/generic/761        |  50 ++++++++++++++
>  tests/generic/761.out    |   2 +
>  5 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-writeback-race.c
>  create mode 100755 tests/generic/761
>  create mode 100644 tests/generic/761.out
> 
> diff --git a/.gitignore b/.gitignore
> index efd47773..7060f52c 100644
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
> index 1417c383..6ac72b36 100644
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
> index 00000000..01cce50b
> --- /dev/null
> +++ b/src/dio-writeback-race.c
> @@ -0,0 +1,143 @@
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
> + * Make sure filesystems with explicit data checksum to handle direct IO
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
> + *   If not specified, the default value will be PAGE_SIZE.

PAGE_SIZE -> 4096 bytes

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
> +	int ret;
> +
> +	ret = write(fd, buf, blocksize);
> +	pthread_exit((void *)(unsigned long long)ret);

ret should be a ssize_t. (unsigned long long) can be dropped, right?

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
> +	int ret;
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
> +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
"invalid filesize"
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

argv[2] -> argv[optind]

> +		goto error;
> +	}
> +
> +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> +		void *retval = NULL;
> +
> +		memset(buf, orig_pattern, blocksize);
> +		pthread_create(&io_thread, NULL, do_io, NULL);
> +		pthread_create(&modify_thread, NULL, do_modify, NULL);
> +		ret = pthread_join(io_thread, retval);

I think this should be &retval?

> +		if (ret < 0) {
> +			errno = -ret;

man indicates that pthread_join errors are positive errno.

> +			fprintf(stderr, "failed to join io thread: %m\n");
> +			goto error;
> +		}
> +		if (retval) {

if ((ssize_t)retval < 0), or we could confirm that it matches blocksize.

> +			fprintf(stderr, "io thread failed\n");
> +			goto error;
> +		}
> +		ret = pthread_join(modify_thread, NULL);
> +		if (ret < 0) {
> +			errno = -ret;

As before, should this be a positive check?

> +			fprintf(stderr, "failed to join modify thread: %m\n");
> +			goto error;
> +		}
> +	}
> +error:
> +	close(fd);
> +	free(buf);
> +	return EXIT_FAILURE;

Should probably EXIT_SUCCESS based on ret / retval?

> +}
> diff --git a/tests/generic/761 b/tests/generic/761
> new file mode 100755
> index 00000000..24f45cb0
> --- /dev/null
> +++ b/tests/generic/761
> @@ -0,0 +1,50 @@
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
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }

nit: drop the commented override function.

> +
> +# Import common functions.
> +# . ./common/filter
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_odirect
> +_require_test_program dio-writeback-race

_fixed_by_kernel_commit XXXXXXXX \
	"btrfs: always fallback to buffered write if the inode requires checksum"

> +
> +_scratch_mkfs > $seqres.full 2>&1
> +_scratch_mount
> +
> +blocksize=$(_get_block_size $SCRATCH_MNT)
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
> index 00000000..72ebba4c
> --- /dev/null
> +++ b/tests/generic/761.out
> @@ -0,0 +1,2 @@
> +QA output created by 761
> +Silence is golden


