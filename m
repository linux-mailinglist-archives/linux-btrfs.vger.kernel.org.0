Return-Path: <linux-btrfs+bounces-6737-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6287B93D7E0
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A181F22542
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D1417BB2D;
	Fri, 26 Jul 2024 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2Uly8Pg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8FB3987B
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 17:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016727; cv=none; b=PhLCeIdh8y0+HPs1rLsY3RacLfRWCb4rt/nxWc6L5JtRsIpTF/T5qoPQAuuhFVOUMCvswXUvZKQUkIohX8scv1DixN7cBPAX9aohP9XQXxfLOI4YCwjDesTzDVpnU2DWARpB1r38WzUKHxLPXCuyHl1VCVpAIIllax+fdHDrNmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016727; c=relaxed/simple;
	bh=YJVQUrpE17HtAxtCeUh6iRvTM71l5erc23Fs2u4Y4ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BW3c4SZyCYGtGe/yeSHuD1aOiKNqOUOWJfAMkKn0wv9PtqoWneKBMMt/bytqnBdTXMus3A+kKvTWmIL/mjoXDTAUqNQKEmvsdBrQH7g+aGZ+9wacoFVFDt7wo98F33KTfT0YA7z2zRLYofUEDVwSU5U3IMc9Xc4tLhs8fJyt2ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2Uly8Pg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722016724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZK8dmHDmQTQOQzfhtKeNpCh5hlW331TlAOjBRWzVr/Q=;
	b=U2Uly8PgP0yStal4QljoaoJuUQoUZbBTV/OoAWZXZRsw8tPomD4xkohZN0sPWivf7AvHWY
	mQ/NAG6uCJ7I9CDtpwzwhw0ralB4/39ZYcbBOBNxw10VAA6M8DpUV1PgqKp9bs8T9L1627
	0Vx6gRLdXDcsiiKNRlylT/qumRFPeG8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-dk0adhJaMWSzwdroT5DdKQ-1; Fri, 26 Jul 2024 13:58:43 -0400
X-MC-Unique: dk0adhJaMWSzwdroT5DdKQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fd5fe96cfeso8515925ad.0
        for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 10:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016722; x=1722621522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZK8dmHDmQTQOQzfhtKeNpCh5hlW331TlAOjBRWzVr/Q=;
        b=Dv/bcRMixHlhTehcuvE/JciXgmJmUbYb3YDv2JJOnaavMn+BE+Ht22SiDK3CQ/ZRSO
         vcPgpvH4AXfTyeSPtAweBE3ssv8W4hvoNg/9z08FP3SKWb/KSbnQ7I8DTn4QQOETp2OP
         OSMQ8jvO6wsufAEddhLdVpWAp3LRQ1AGR8tqUBf1LgraBaha96Zh1FZDhviRLUpF5pHh
         GPZ8yBNv5pIqf0b4P1rC9QBMZFUwTVKI5Trg75hOMvVVXAsmLUKNAtjxaQeEB1VQnDXV
         x/UoBuWhU2+WSYOuPAfMwdkMF0u+KPgIVQDVOmsosvE+bY+wcOELa5f3GXVvb1gaOV78
         iHjA==
X-Forwarded-Encrypted: i=1; AJvYcCUkyA5szw5XONwBWvrhioP06xrlLKV3dVxS4rW5fpHNFUKYNtZxhhDLnDNmNSzEuCZtCbSausZj7AwRl+4724GHxZtXEo5U/TPiMNk=
X-Gm-Message-State: AOJu0YxZk5CXGCtqJaaeR/gNTTZL0iPISZvH/7li1ClvseCcb/2QYMTB
	GrL+62KZv4zE2OOQqvwn0qL3TSjCIxDRdojMLN4mHeKh7iB0tZ+01sbN7uXQeg7ItAgbufhfZXx
	gLwO3lQMDcGU11I29IQTRHRVrUOkDfiZJNxkokrEeyc4T86H5C3OiHyz/wiEX
X-Received: by 2002:a17:902:e810:b0:1fd:6ca9:4c0 with SMTP id d9443c01a7336-1ff04811278mr4676105ad.18.1722016721895;
        Fri, 26 Jul 2024 10:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLDV7hr7wbBEG8HihXsAFw93P3HrDQrJcyqfGbtLhHH4L4n/8TMTXI10rLF3UsOqdClp/XzQ==
X-Received: by 2002:a17:902:e810:b0:1fd:6ca9:4c0 with SMTP id d9443c01a7336-1ff04811278mr4675845ad.18.1722016721464;
        Fri, 26 Jul 2024 10:58:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fbd6sm35813315ad.62.2024.07.26.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:58:41 -0700 (PDT)
Date: Sat, 27 Jul 2024 01:58:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test page fault during direct IO write with
 O_APPEND
Message-ID: <20240726175837.jtq4df4u7rol3qac@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>

On Fri, Jul 26, 2024 at 04:55:46PM +0100, fdmanana@kernel.org wrote:
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
>  .gitignore                 |   1 +
>  src/Makefile               |   2 +-
>  src/dio-append-buf-fault.c | 131 +++++++++++++++++++++++++++++++++++++
>  tests/generic/362          |  28 ++++++++
>  tests/generic/362.out      |   2 +
>  5 files changed, 163 insertions(+), 1 deletion(-)
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
> index 00000000..f4be4845
> --- /dev/null
> +++ b/src/dio-append-buf-fault.c
> @@ -0,0 +1,131 @@
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
> +	ret = write(fd, buf, pagesize);
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
> +	if (stbuf.st_size != pagesize) {
> +		fprintf(stderr,
> +			"Wrong file size after first write, got %jd expected %ld\n",
> +			(intmax_t)stbuf.st_size, pagesize);
> +		return 7;
> +	}
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
> +		return 8;
> +	}
> +
> +	buf = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> +		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (buf == MAP_FAILED) {
> +		perror("Failed to allocate second buffer");
> +		return 9;
> +	}
> +
> +	/* Fault in first page of the buffer before the write. */
> +	memset(buf, 0, 1);
> +
> +	ret = write(fd, buf, pagesize * 2);
> +	if (ret < 0) {
> +		perror("Second write failed");

Hi Filipe,

This patch looks good to me, just a question about this part. Is it possible
to get (0 < ret < pagesize * 2) at here? Is so, should we report fail too?

> +		return 10;
> +	}
> +
> +	ret = fstat(fd, &stbuf);
> +	if (ret < 0) {
> +		perror("Second stat failed");
> +		return 11;
> +	}
> +
> +	if (stbuf.st_size != pagesize * 2) {
> +		fprintf(stderr,
> +			"Wrong file size after second write, got %jd expected %ld\n",
> +			(intmax_t)stbuf.st_size, pagesize * 2);

Does this try to check the stbuf.st_size isn't equal to the write(2) return
value? Or checks stbuf.st_size != pagesize * 2, when the return value is
good (equal to pagesize * 2) ?

Thanks,
Zorro

> +		return 12;
> +	}
> +
> +	munmap(buf, pagesize * 2);
> +	close(fd);
> +
> +	return 0;
> +}

[snip]


