Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E056A1607
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Feb 2023 05:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjBXEws (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Feb 2023 23:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBXEwq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Feb 2023 23:52:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C378A1630B
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 20:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677214317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qGzxvTubweCd7BHjMV9ffIN4mpWobon3AAtZWD4jhhc=;
        b=C8pqpCp8VkAxQXwlbT7zJ6FAeWtd8Z8pA72YCYctiIybrqExCJQYRLIz0JHUK1p/qb6fGS
        sgMJyRy74Sbq6A0ZWEGPxagEflE6ebKZiURGbpZRcafuQSvGcozoiFgUC1MXwafAU+q/Fb
        gFr6BNt6oLJHw+LHicalr+MMI8eqYlk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-536-httA7QdePWmbvlZ5UHAsvQ-1; Thu, 23 Feb 2023 23:51:48 -0500
X-MC-Unique: httA7QdePWmbvlZ5UHAsvQ-1
Received: by mail-pl1-f198.google.com with SMTP id j18-20020a170903025200b00198aa765a9dso6313332plh.6
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Feb 2023 20:51:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGzxvTubweCd7BHjMV9ffIN4mpWobon3AAtZWD4jhhc=;
        b=FRSrpoWRxhBpML/8Pc4ODyAdxhf/oH4iXRZBeqi18p8yBqWhL3C13KWa2CFdtYBJ0x
         O5uE8gjM0yBoM8EfpxktzIjfZSRaxMu5v1Ib8HqkcMqvjnCuwKnnSvFq9VyHhUpxUuJU
         wcyg5WC/jSA2tPSdnbNNaVnQn9jZHFbkYvkNV+UcSaO9FL438OKWxOrIJ/FFYWeEwDhq
         oD5HZ89cLNOCvT8xE97rYj8fLif6DkQ03SXIcDVWvMEVnw0xWcSUcXStrKmrhJrQdwfD
         9vCRuO6wRLn3+DvSEZzYjc6uRfUnb85DEb4HKWaYQjPGbQ4AYRfKRJtHdKmzOydEimRC
         upIw==
X-Gm-Message-State: AO0yUKXzY5Jff0NG0+B+xlWWqBYQw9ltAEFD8PnpMLOM8TxtZF4wG4i4
        92qe3zE0CRxvKDO0O3TQsKiTpg5M1w/1VbZY5OP4QQqZ8FsMr7G3AnvmxCNXDEkWQtveEQsu4E0
        T8LLNJVZHBqJ521OrcRiDkno=
X-Received: by 2002:aa7:96b5:0:b0:5e0:316a:1ff3 with SMTP id g21-20020aa796b5000000b005e0316a1ff3mr2523733pfk.2.1677214307678;
        Thu, 23 Feb 2023 20:51:47 -0800 (PST)
X-Google-Smtp-Source: AK7set8myxqh4hyqbG6vsKFJPtY8hcl/8GJPWFvgJy9ulEdKHNuhGdPTVwrXqo/oYc+PHKeQ/x9v8w==
X-Received: by 2002:aa7:96b5:0:b0:5e0:316a:1ff3 with SMTP id g21-20020aa796b5000000b005e0316a1ff3mr2523719pfk.2.1677214307254;
        Thu, 23 Feb 2023 20:51:47 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id u26-20020a62ed1a000000b00593baab06dcsm7807496pfh.198.2023.02.23.20.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 20:51:46 -0800 (PST)
Date:   Fri, 24 Feb 2023 12:51:42 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic: add test for direct io partial writes
Message-ID: <20230224045142.cu7chhnu4wadp7gv@zlang-mailbox>
References: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea9fe850ad355e20f668a5faff9f9181a3317c8.1677175084.git.boris@bur.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 23, 2023 at 10:01:51AM -0800, Boris Burkov wrote:
> btrfs recently had a bug where a direct io partial write resulted in a
> hole in the file. Add a new generic test which creates a 2MiB file,
> mmaps it, touches the first byte, then does an O_DIRECT write of the
> mmapped buffer into a new file. This should result in the mapped pages
> being a mix of in and out of page cache and thus a partial write, for
> filesystems using iomap and IOMAP_DIO_PARTIAL.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
> Changelog:
> v2:
> - hide fd in prep_mmap_buffer, we weren't closing it in main
> - get rid of unneeded filters/cleanup in test script
> - make pwrite pattern explicit
> - send random mmapped char to /dev/null
> - gate _fixed_by_kernel_commit by FSTYP
> - remove extra sync after writing file
> - use $seq in test filenames

Thanks, this version looks good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  .gitignore            |  1 +
>  src/Makefile          |  2 +-
>  src/dio-buf-fault.c   | 83 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/708     | 37 +++++++++++++++++++
>  tests/generic/708.out |  2 ++
>  5 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 src/dio-buf-fault.c
>  create mode 100755 tests/generic/708
>  create mode 100644 tests/generic/708.out
> 
> diff --git a/.gitignore b/.gitignore
> index cfff8f85..644290f0 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -72,6 +72,7 @@ tags
>  /src/deduperace
>  /src/detached_mounts_propagation
>  /src/devzero
> +/src/dio-buf-fault
>  /src/dio-interleaved
>  /src/dio-invalidate-cache
>  /src/dirhash_collide
> diff --git a/src/Makefile b/src/Makefile
> index a574f7bd..24cd4747 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/dio-buf-fault.c b/src/dio-buf-fault.c
> new file mode 100644
> index 00000000..911c3e1f
> --- /dev/null
> +++ b/src/dio-buf-fault.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> + */
> +
> +#ifndef _GNU_SOURCE
> +#define _GNU_SOURCE /* to get definition of O_DIRECT flag. */
> +#endif
> +
> +#include <sys/mman.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +/*
> + * mmap a source file, then do a direct write of that mmapped region to a
> + * destination file.
> + */
> +
> +int prep_mmap_buffer(char *src_filename, void **addr)
> +{
> +	struct stat st;
> +	int fd;
> +	int ret;
> +
> +	fd = open(src_filename, O_RDWR, 0666);
> +	if (fd == -1)
> +		err(1, "failed to open %s", src_filename);
> +
> +	ret = fstat(fd, &st);
> +	if (ret)
> +		err(1, "failed to stat %d", fd);
> +
> +	*addr = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
> +	if (*addr == MAP_FAILED)
> +		err(1, "failed to mmap %d", fd);
> +
> +	return st.st_size;
> +}
> +
> +int do_dio(char *dst_filename, void *buf, size_t sz)
> +{
> +	int fd;
> +	ssize_t ret;
> +
> +	fd = open(dst_filename, O_CREAT | O_TRUNC | O_WRONLY | O_DIRECT, 0666);
> +	if (fd == -1)
> +		err(1, "failed to open %s", dst_filename);
> +	while (sz) {
> +		ret = write(fd, buf, sz);
> +		if (ret < 0) {
> +			if (errno == -EINTR)
> +				continue;
> +			else
> +				err(1, "failed to write %lu bytes to %d", sz, fd);
> +		} else if (ret == 0) {
> +			break;
> +		}
> +		buf += ret;
> +		sz -= ret;
> +	}
> +	return sz;
> +}
> +
> +int main(int argc, char *argv[]) {
> +	size_t sz;
> +	void *buf = NULL;
> +	char c;
> +
> +	if (argc != 3)
> +		errx(1, "no in and out file name arguments given");
> +	sz = prep_mmap_buffer(argv[1], &buf);
> +
> +	/* touch the first page of the mapping to bring it into cache */
> +	c = ((char *)buf)[0];
> +	printf("%u\n", c);
> +
> +	do_dio(argv[2], buf, sz);
> +}
> diff --git a/tests/generic/708 b/tests/generic/708
> new file mode 100755
> index 00000000..1f0843c7
> --- /dev/null
> +++ b/tests/generic/708
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 708
> +#
> +# Test iomap direct_io partial writes.
> +#
> +# Create a reasonably large file, then run a program which mmaps it,
> +# touches the first page, then dio writes it to a second file. This
> +# can result in a page fault reading from the mmapped dio write buffer and
> +# thus the iomap direct_io partial write codepath.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto
> +[ $FSTYP == "btrfs" ] && \
> +	_fixed_by_kernel_commit XXXX 'btrfs: fix dio continue after short write due to buffer page fault'
> +
> +# real QA test starts here
> +_supported_fs generic
> +_require_test
> +_require_odirect
> +_require_test_program dio-buf-fault
> +src=$TEST_DIR/dio-buf-fault-$seq.src
> +dst=$TEST_DIR/dio-buf-fault-$seq.dst
> +
> +rm -rf "$src" "$dst"
> +
> +echo "Silence is golden"
> +
> +$XFS_IO_PROG -fc "pwrite -q -S 0xcd 0 $((2 * 1024 * 1024))" $src
> +$here/src/dio-buf-fault $src $dst > /dev/null || _fail "failed doing the dio copy"
> +diff $src $dst
> +
> +# success, all done
> +status=$?
> +exit
> diff --git a/tests/generic/708.out b/tests/generic/708.out
> new file mode 100644
> index 00000000..33c478ad
> --- /dev/null
> +++ b/tests/generic/708.out
> @@ -0,0 +1,2 @@
> +QA output created by 708
> +Silence is golden
> -- 
> 2.39.1
> 

