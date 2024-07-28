Return-Path: <linux-btrfs+bounces-6811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9A393E5AB
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 16:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82FD81F2148C
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DCE50A80;
	Sun, 28 Jul 2024 14:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ds4KqNS8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6EF43AAB
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2024 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722176934; cv=none; b=ogBb42pxsGWV3FurmNRc+5gRcJ4F1TBUFvX/ZcVezlclWi/Jvg9XC9DDuSMNv68hiCczBXM345KZZu3/pdSnqlrCHx/snPOnJgI6bzsxVf5wZhEr8mqeENk5THk3JGiykPqa7EpSMZRZJjCNLcu11AlDvEKJHr7jZG/5p/2B5LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722176934; c=relaxed/simple;
	bh=UVty/W+vSAdmkhwPhPhLfu00pq8gxHbNZLyiFLdR/lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItlIRPpexTG1fOBGh9e+Fk4qy0zjuEj3Wmu8M+x643IzhnXVNvV1t7BUU926croRta/KJsdw1eEgtLJ0+NABUcjWgm4qxCdQ89QowuMkhmUcCMeHoesfqJACdg9PioLaHN4VvmkLBo9vZ7F6VTLc2B3qGtsOlsBuTBRoNmHR3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ds4KqNS8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722176930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YKzXpEYuoQfObgDiGuzMBCd02PlMjHg97Ql9ULYT6mE=;
	b=ds4KqNS8/KaC7wqs7RVzqiwo9mmHJ6IN7Flw4Foh/UMy+muLRsVDNALFDqD9p6sr5hIub2
	n7bCzBGaN4RGFx60Ymndu8vJ9h6MLIlqMTjH5fo/eIIDvi1HWuPuREdmaSaa8mbtISRKwB
	PIcPrrOx4DbO/ML7Sc2zssvxu+5XqV4=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-skAUfVrKOmuaNTHZNLDrmg-1; Sun, 28 Jul 2024 10:28:48 -0400
X-MC-Unique: skAUfVrKOmuaNTHZNLDrmg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1fc4fcaa2e8so21903495ad.1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2024 07:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722176927; x=1722781727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKzXpEYuoQfObgDiGuzMBCd02PlMjHg97Ql9ULYT6mE=;
        b=TU0MfOz/336HH7FO2dp1h06z3njhk20GQKhXKqgBLrpe90D+SFN6K1ZZCy8bpc2Zol
         yAlZTCA1dOAoLSp8EObyc8rKY6mOTCxB87kW3bEVHomqnae2yuShmdQ06PWnU2xIhXsF
         3X7+A7QBqVtOsItemE+J3v3SfgfeHPccv8MaMLZ9zrDOH1K1CSBAAYSabq3Z/H826+HM
         knyuRpJ4+AfZKb9sGgUR/AI7ns5Nys8qEbv+beLROUX0YHJJjwPhD90PK3e/CDaDht8f
         oWgo5ngItLv+zcNK7SvZsHO9QmKn3X8GJGcS9KWIvApiykofwl76xnoxPUxhxaL4T9bc
         rKBg==
X-Forwarded-Encrypted: i=1; AJvYcCXz29bcpn4tl/QPXxS0o2JCh+1mB9euF7PkeWWNMrTiYwSs439LY5grSo8832SkB4xc0h3rbHj22FX5SGSgsSwhyRX1y80uw/nwZcI=
X-Gm-Message-State: AOJu0YyxkSVYGbMu6qDfl01vQkXOSB/FT9ywhhLr1oipZeswboN505zL
	IXyuxyQxzAitxfvzRPfwHgCGoExoM4Ly/WAHGuC0BGiE3Qnct6Qxs83aUQUoz3rTVppWeYgBobn
	Sks26JlTA+q2OBYwzNxZUHfTwyiWdAw0ODCzKfWvsTFgLqGNqc9zDmEh3sxUa1Y7IedyYd/Y=
X-Received: by 2002:a17:903:8d0:b0:1fb:8785:d1fa with SMTP id d9443c01a7336-1ff0483a342mr67431975ad.30.1722176927212;
        Sun, 28 Jul 2024 07:28:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHss9qNIlxHi/uque438Mk+t0iKbs6qOsgA+KT5UmEOfgYFMhyqsQroqTi8X/3cuiQnsOi19w==
X-Received: by 2002:a17:903:8d0:b0:1fb:8785:d1fa with SMTP id d9443c01a7336-1ff0483a342mr67431665ad.30.1722176926680;
        Sun, 28 Jul 2024 07:28:46 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7cf83f5sm66086375ad.96.2024.07.28.07.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 07:28:46 -0700 (PDT)
Date: Sun, 28 Jul 2024 22:28:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test page fault during direct IO write with
 O_APPEND
Message-ID: <20240728142842.iquah6ckxj7rfmvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com>

On Sat, Jul 27, 2024 at 12:28:16PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that doing a direct IO append write to a file when the input buffer
> was not yet faulted in, does not result in an incorrect file size.
> 
> This exercises a bug on btrfs reported by users and which is fixed by
> the following kernel patch:
> 
>    "btrfs: fix corruption after buffer fault in during direct IO append write"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> V2: Deal with partial writes by looping and writing any remaining data.
>     Don't exit when the first test fails, instead let the second test
>     run as well.

With this change I got two error lines this time [1]. Last time (V1) I
only got "Wrong file size after first write, got 8192 expected 4096".
Does this mean this v2 change help this case to be better?

Thanks,
Zorro

[1]
[root@dell-per750-41 xfstests]# ./check -s default generic/362
SECTION       -- default
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 dell-xx-xxxxxx 6.10.0-0.rc7.20240712git43db1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC 2024
MKFS_OPTIONS  -- /dev/sda6
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch

generic/362 0s ... - output mismatch (see /root/git/xfstests/results//default/generic/362.out.bad)
    --- tests/generic/362.out   2024-07-28 22:22:06.098982182 +0800
    +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-07-28 22:23:16.622577397 +0800
    @@ -1,2 +1,4 @@
     QA output created by 362
    +Wrong file size after first write, got 8192 expected 4096
    +Wrong file size after second write, got 12288 expected 8192
     Silence is golden


> 
>  .gitignore                 |   1 +
>  src/Makefile               |   2 +-
>  src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++++++
>  tests/generic/362          |  28 +++++++
>  tests/generic/362.out      |   2 +
>  5 files changed, 177 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-append-buf-fault.c
>  create mode 100755 tests/generic/362
>  create mode 100644 tests/generic/362.out
> 
> diff --git a/.gitignore b/.gitignore
> index b5f15162..97c7e001 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -72,6 +72,7 @@ tags
>  /src/deduperace
>  /src/detached_mounts_propagation
>  /src/devzero
> +/src/dio-append-buf-fault
>  /src/dio-buf-fault
>  /src/dio-interleaved
>  /src/dio-invalidate-cache
> diff --git a/src/Makefile b/src/Makefile
> index 99796137..559209be 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
>  	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> -	readdir-while-renames
> +	readdir-while-renames dio-append-buf-fault
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.c
> new file mode 100644
> index 00000000..72c23265
> --- /dev/null
> +++ b/src/dio-append-buf-fault.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> + */
> +
> +/*
> + * Test a direct IO write in append mode with a buffer that was not faulted in
> + * (or just partially) before the write.
> + */
> +
> +/* Get the O_DIRECT definition. */
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE
> +#endif
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <stdint.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +
> +static ssize_t do_write(int fd, const void *buf, size_t count)
> +{
> +        while (count > 0) {
> +		ssize_t ret;
> +
> +		ret = write(fd, buf, count);
> +		if (ret < 0) {
> +			if (errno == EINTR)
> +				continue;
> +			return ret;
> +		}
> +		count -= ret;
> +		buf += ret;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	struct stat stbuf;
> +	int fd;
> +	long pagesize;
> +	void *buf;
> +	ssize_t ret;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> +		return 1;
> +	}
> +
> +	/*
> +	 * First try an append write against an empty file of a buffer with a
> +	 * size matching the page size. The buffer is not faulted in before
> +	 * attempting the write.
> +	 */
> +
> +	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
> +	if (fd == -1) {
> +		perror("Failed to open/create file");
> +		return 2;
> +	}
> +
> +	pagesize = sysconf(_SC_PAGE_SIZE);
> +	if (pagesize == -1) {
> +		perror("Failed to get page size");
> +		return 3;
> +	}
> +
> +	buf = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("Failed to allocate first buffer");
> +		return 4;
> +	}
> +
> +	ret = do_write(fd, buf, pagesize);
> +	if (ret < 0) {
> +		perror("First write failed");
> +		return 5;
> +	}
> +
> +	ret = fstat(fd, &stbuf);
> +	if (ret < 0) {
> +		perror("First stat failed");
> +		return 6;
> +	}
> +
> +	/* Don't exit on failure so that we run the second test below too. */
> +	if (stbuf.st_size != pagesize)
> +		fprintf(stderr,
> +			"Wrong file size after first write, got %jd expected %ld\n",
> +			(intmax_t)stbuf.st_size, pagesize);
> +
> +	munmap(buf, pagesize);
> +	close(fd);
> +
> +	/*
> +	 * Now try an append write against an empty file of a buffer with a
> +	 * size matching twice the page size. Only the first page of the buffer
> +	 * is faulted in before attempting the write, so that the second page
> +	 * should be faulted in during the write.
> +	 */
> +	fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
> +	if (fd == -1) {
> +		perror("Failed to open/create file");
> +		return 7;
> +	}
> +
> +	buf = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("Failed to allocate second buffer");
> +		return 8;
> +	}
> +
> +	/* Fault in first page of the buffer before the write. */
> +	memset(buf, 0, 1);
> +
> +	ret = do_write(fd, buf, pagesize * 2);
> +	if (ret < 0) {
> +		perror("Second write failed");
> +		return 9;
> +	}
> +
> +	ret = fstat(fd, &stbuf);
> +	if (ret < 0) {
> +		perror("Second stat failed");
> +		return 10;
> +	}
> +
> +	if (stbuf.st_size != pagesize * 2)
> +		fprintf(stderr,
> +			"Wrong file size after second write, got %jd expected %ld\n",
> +			(intmax_t)stbuf.st_size, pagesize * 2);
> +
> +	munmap(buf, pagesize * 2);
> +	close(fd);
> +
> +	return 0;
> +}
> diff --git a/tests/generic/362 b/tests/generic/362
> new file mode 100755
> index 00000000..2c127347
> --- /dev/null
> +++ b/tests/generic/362
> @@ -0,0 +1,28 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 362
> +#
> +# Test that doing a direct IO append write to a file when the input buffer was
> +# not yet faulted in, does not result in an incorrect file size.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +_require_test
> +_require_odirect
> +_require_test_program dio-append-buf-fault
> +
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix corruption after buffer fault in during direct IO append write"
> +
> +# On error the test program writes messages to stderr, causing a golden output
> +# mismatch and making the test fail.
> +$here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/362.out b/tests/generic/362.out
> new file mode 100644
> index 00000000..0ff40905
> --- /dev/null
> +++ b/tests/generic/362.out
> @@ -0,0 +1,2 @@
> +QA output created by 362
> +Silence is golden
> -- 
> 2.43.0
> 
> 


