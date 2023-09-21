Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9AA7A9794
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 19:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjIURZy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 13:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjIURZZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 13:25:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5A76B3
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695316218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6yK4AsYaSYnCzNrN+fzYKEvyWKtvguOBUHdkbCbpCI=;
        b=bUxHlwBRmZtES2V7Lt0419/oZcrbQrxS039789hDQi4GY/Kgsyie+VcgvLMVa0Auh2fceE
        x2QOhjS6hzH0u51vpTXrefscCic5FExdJOWqfmAaBhcxZmaa+1hmyimfhh3wp/WjN5mgyw
        G6kkmQpAbNos0gmnykjZbHdlV8FkKMc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-nu2CTjvvOtWXxbb749Xglg-1; Thu, 21 Sep 2023 10:56:51 -0400
X-MC-Unique: nu2CTjvvOtWXxbb749Xglg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-690b7fff1c6so1097870b3a.2
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Sep 2023 07:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695308211; x=1695913011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6yK4AsYaSYnCzNrN+fzYKEvyWKtvguOBUHdkbCbpCI=;
        b=h2w318NkU3cJtzuFm8rXXWTzGwLOmc3wZ55mNW5k8FTbKGkQpsPhUlXvN+YJj0e3i2
         XRZdczjf3k9Cm/4CmO+wiZ/qnbdy/ZODtjuKxFvSbV9Z1ZYrV9YogdDY6fnA8m/ZypTM
         DQ2wW/c9GVegsdIPk8PhYU+Haa0QPd1yHutorhMtEQ0wj/xLnvz3nYrVkzSyYMArixve
         e0CcsXG9Kk/kF8/pdVHdMIbjjloS6Sqc8LQqZ0XXW0ES5UnEPzPGHx6HgoRbMbZi5FbU
         ckl6zAi2fymwLHOPAnnQc/bgI/PxJDBbKoeA2n6DIMKfcxHeBFjeCTjVvWBkNPQ8YQ0X
         MU+A==
X-Gm-Message-State: AOJu0YznxZzk5iQwOeadGUNffjJPiE1XGPyLjsXJ+2NxOXtQOt5Iz+7Q
        M5SV1v6Ple66KJgK6SQGn/sftoNoc8gjY8d5pZi2S79/H4hARwBYDrvU79BpnQRosu8hiuF9GXn
        Tfsq41ph36siTxCviG+G/7Tc=
X-Received: by 2002:a05:6a21:3399:b0:145:47af:57d8 with SMTP id yy25-20020a056a21339900b0014547af57d8mr6453395pzb.2.1695308210731;
        Thu, 21 Sep 2023 07:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIyB5Oz+XJ1C53+RZtsaUg8z4dXSJswX4fwGNHHsqwxS6KmhkObaNFGNRsoEFtUqngLR84Gg==
X-Received: by 2002:a05:6a21:3399:b0:145:47af:57d8 with SMTP id yy25-20020a056a21339900b0014547af57d8mr6453377pzb.2.1695308210314;
        Thu, 21 Sep 2023 07:56:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a11-20020a170902eccb00b001bb28b9a40dsm1594547plh.11.2023.09.21.07.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 07:56:49 -0700 (PDT)
Date:   Thu, 21 Sep 2023 22:56:46 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test new directory entries are returned after
 rewinding directory
Message-ID: <20230921145646.7s4trxw2mqd4v33h@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 14, 2023 at 04:40:22PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if names are added to a directory after an opendir(3) call and
> before a rewinddir(3) call, future readdir(3) calls will return the names.
> This is mandated by POSIX:
> 
>   https://pubs.opengroup.org/onlinepubs/007904875/functions/rewinddir.html
> 
> This exercises a regression in btrfs which is fixed by a kernel patch that
> has the following subject:
> 
>   ""btrfs: refresh dir last index during a rewinddir(3) call""
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  .gitignore            |   1 +
>  src/Makefile          |   2 +-
>  src/rewinddir-test.c  | 159 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/471     |  39 +++++++++++
>  tests/generic/471.out |   2 +
>  5 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 src/rewinddir-test.c
>  create mode 100755 tests/generic/471
>  create mode 100644 tests/generic/471.out
> 
> diff --git a/.gitignore b/.gitignore
> index 644290f0..4c32ac42 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -124,6 +124,7 @@ tags
>  /src/rename
>  /src/renameat2
>  /src/resvtest
> +/src/rewinddir-test
>  /src/runas
>  /src/seek_copy_test
>  /src/seek_sanity_test
> diff --git a/src/Makefile b/src/Makefile
> index aff871d0..2815f919 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/rewinddir-test.c b/src/rewinddir-test.c
> new file mode 100644
> index 00000000..9f7505a2
> --- /dev/null
> +++ b/src/rewinddir-test.c
> @@ -0,0 +1,159 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 SUSE Linux Products GmbH.  All Rights Reserved.
> + */
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +
> +/*
> + * Number of files we add to the test directory after calling opendir(3) and
> + * before calling rewinddir(3).
> + */
> +#define NUM_FILES 10000
> +
> +int main(int argc, char *argv[])
> +{
> +	int file_counters[NUM_FILES] = { 0 };
> +	int dot_count = 0;
> +	int dot_dot_count = 0;
> +	struct dirent *entry;
> +	DIR *dir = NULL;
> +	char *dir_path = NULL;
> +	char *file_path = NULL;
> +	int ret = 0;
> +	int i;
> +
> +	if (argc != 2) {
> +		fprintf(stderr, "Usage:  %s <directory>\n", argv[0]);
> +		ret = 1;
> +		goto out;
> +	}
> +
> +	dir_path = malloc(strlen(argv[1]) + strlen("/testdir") + 1);
> +	if (!dir_path) {
> +		fprintf(stderr, "malloc failure\n");
> +		ret = ENOMEM;
> +		goto out;
> +	}
> +	i = strlen(argv[1]);
> +	memcpy(dir_path, argv[1], i);
> +	memcpy(dir_path + i, "/testdir", strlen("/testdir"));
> +	dir_path[i + strlen("/testdir")] = '\0';
> +
> +	/* More than enough to contain any full file path. */
> +	file_path = malloc(strlen(dir_path) + 12);
> +	if (!file_path) {
> +		fprintf(stderr, "malloc failure\n");
> +		ret = ENOMEM;
> +		goto out;
> +	}
> +
> +	ret = mkdir(dir_path, 0700);
> +	if (ret == -1) {
> +		fprintf(stderr, "Failed to create test directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	/* Open the directory first. */
> +	dir = opendir(dir_path);
> +	if (dir == NULL) {
> +		fprintf(stderr, "Failed to open directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Now create all files inside the directory.
> +	 * File names go from 1 to NUM_FILES, 0 is unused as it's the return
> +	 * value for atoi(3) when an error happens.
> +	 */
> +	for (i = 1; i <= NUM_FILES; i++) {
> +		FILE *f;
> +
> +		sprintf(file_path, "%s/%d", dir_path, i);
> +		f = fopen(file_path, "w");
> +		if (f == NULL) {
> +			fprintf(stderr, "Failed to create file number %d: %d\n",
> +				i, errno);
> +			ret = errno;
> +			goto out;
> +		}
> +		fclose(f);
> +	}
> +
> +	/*
> +	 * Rewind the directory and read it.
> +	 * POSIX requires that after a rewind, any new names added to the
> +	 * directory after the openddir(3) call and before the rewinddir(3)
> +	 * call, must be returned by readdir(3) calls
> +	 */
> +	rewinddir(dir);
> +
> +	/*
> +	 * readdir(3) returns NULL when it reaches the end of the directory or
> +	 * when an error happens, so reset errno to 0 to distinguish between
> +	 * both cases later.
> +	 */
> +	errno = 0;
> +	while ((entry = readdir(dir)) != NULL) {
> +		if (strcmp(entry->d_name, ".") == 0) {
> +			dot_count++;
> +			continue;
> +		}
> +		if (strcmp(entry->d_name, "..") == 0) {
> +			dot_dot_count++;
> +			continue;
> +		}
> +		i = atoi(entry->d_name);
> +		if (i == 0) {
> +			fprintf(stderr,
> +				"Failed to parse name '%s' to integer: %d\n",
> +				entry->d_name, errno);
> +			ret = errno;
> +			goto out;
> +		}
> +		/* File names go from 1 to NUM_FILES, so subtract 1. */
> +		file_counters[i - 1]++;
> +	}
> +
> +	if (errno) {
> +		fprintf(stderr, "Failed to read directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Now check that the readdir() calls return every single file name
> +	 * and without repeating any of them. If any name is missing or
> +	 * repeated, don't exit immediatelly, so that we print a message for
> +	 * all missing or repeated names.
> +	 */
> +	for (i = 0; i < NUM_FILES; i++) {
> +		if (file_counters[i] != 1) {
> +			fprintf(stderr, "File name %d appeared %d times\n",
> +				i + 1,  file_counters[i]);
> +			ret = EINVAL;
> +		}
> +	}
> +	if (dot_count != 1) {
> +		fprintf(stderr, "File name . appeared %d times\n", dot_count);
> +		ret = EINVAL;
> +	}
> +	if (dot_dot_count != 1) {
> +		fprintf(stderr, "File name .. appeared %d times\n", dot_dot_count);
> +		ret = EINVAL;
> +	}
> +out:
> +	free(dir_path);
> +	free(file_path);
> +	if (dir != NULL)
> +		closedir(dir);
> +
> +	return ret;
> +}
> diff --git a/tests/generic/471 b/tests/generic/471
> new file mode 100755
> index 00000000..15dc89f3
> --- /dev/null
> +++ b/tests/generic/471
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 471
> +#
> +# Test that if names are added to a directory after an opendir(3) call and
> +# before a rewinddir(3) call, future readdir(3) calls will return the names.
> +# This is mandated by POSIX:
> +#
> +# https://pubs.opengroup.org/onlinepubs/007904875/functions/rewinddir.html
> +#
> +. ./common/preamble
> +_begin_fstest auto quick

This's a test about directory function, so better to add into "dir" group.

> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	[ -n "$target_dir" ] && rm -fr $target_dir

I think the "rm -fr" doesn't care about if "$target_dir" is null or existed.

> +}
> +
> +_supported_fs generic
> +_require_test
> +_require_test_program rewinddir-test
> +
> +[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \

One week passed, this fix has been merged as commit e60aa5da14d0 .

Others looks good to me, thanks for this new test coverage.

Thanks,
Zorro

> +	"btrfs: refresh dir last index during a rewinddir(3) call"
> +
> +target_dir="$TEST_DIR/test-$seq"
> +rm -fr $target_dir
> +mkdir $target_dir
> +
> +$here/src/rewinddir-test $target_dir
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/471.out b/tests/generic/471.out
> new file mode 100644
> index 00000000..260f629e
> --- /dev/null
> +++ b/tests/generic/471.out
> @@ -0,0 +1,2 @@
> +QA output created by 471
> +Silence is golden
> -- 
> 2.40.1
> 

