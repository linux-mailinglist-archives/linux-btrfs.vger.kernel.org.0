Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A96B7AB554
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjIVP6N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 11:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjIVP6M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 11:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7267100
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695398239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEkezAYXYDTyI/GxL2dgtCxkd3NN4uo+MVAq8KNxYnc=;
        b=gWqy5vyMTEBlDSymFBBkGhu6GN9TAarK4gOhKHs8yVm0X+DB5KXM6dvKAQoiznxyfv9Q0T
        HfTazNf+2eyWQywA5c2f4slTOYhY0dOdoLhUSEsyMssWt52ZoybfSXdjjqLhBmpjxAWtgl
        e+XZk/uA2rs8jBls4cZJVFQEv39uUps=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-KVOtUdv-MVOvtVBkytcejw-1; Fri, 22 Sep 2023 11:57:17 -0400
X-MC-Unique: KVOtUdv-MVOvtVBkytcejw-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-690bcc80694so2355844b3a.3
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 08:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695398236; x=1696003036;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEkezAYXYDTyI/GxL2dgtCxkd3NN4uo+MVAq8KNxYnc=;
        b=MkFugiLYDS0YNEXOu1vtIlrTDV3hOI6NsznDjKebSXMgjuMxzKuK/hgyDDJBLbIELg
         /riarFtk+uxrHIGhqE4hBb2Cpcou88JFTLUKQ+d3BokSLcBZZTVGijLLczlSi7+Ux2n2
         uK0pCEguDgOWNL7fv3jqDCrYQ0BX334mhs/UFR/p66ojz5X+OrPFGBZj5mGeNJD2WKsF
         mYNaQjaCY/FgBkM16Zx0oWAN131VjPQ/1gkFdpUkUFmizcqI3JjR3IRjb2cArzMcfJkW
         MbKObpBQKrCO4+X47lLObmFOz14YCDmmx6ECQ+A2TPy802eGjMs1DFl1LJgZRuyuwiOP
         087w==
X-Gm-Message-State: AOJu0YxiX4+l3X7QWsTxNIYT0SKEhgq4ds97Os8V5he5V26CZLeOE73i
        Ojqxdu4/8yNUVhlLLX6d13C7FEG4f/K1qAf0xlcQsLHdhPumXzcQWk2D9swkMMcwNLJCJ87jrEq
        UXnG7GEt7jQy8dzyNSqh8BGwY4sG1K7RRHg==
X-Received: by 2002:a05:6a20:974d:b0:14d:f087:c0c7 with SMTP id hs13-20020a056a20974d00b0014df087c0c7mr7980277pzc.58.1695398236337;
        Fri, 22 Sep 2023 08:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqC+ZjCEd3Mpwx2hlAv86bhUPsn4csvCmRYofWqt9Q0E0XlO+LqljC+dZb+mZeDx5P6O1NBw==
X-Received: by 2002:a05:6a20:974d:b0:14d:f087:c0c7 with SMTP id hs13-20020a056a20974d00b0014df087c0c7mr7980260pzc.58.1695398235918;
        Fri, 22 Sep 2023 08:57:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id a10-20020a62d40a000000b006926506de1csm3232838pfh.28.2023.09.22.08.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 08:57:15 -0700 (PDT)
Date:   Fri, 22 Sep 2023 23:57:12 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test new directory entries are returned
 after rewinding directory
Message-ID: <20230922155712.ijzf6e7l7u5hhtwv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <1888d81c5fad8204dd4948d36291d24f00354b22.1694705838.git.fdmanana@suse.com>
 <603deada0f5b9ddff2446dae87a96cb05d566c2c.1695309198.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <603deada0f5b9ddff2446dae87a96cb05d566c2c.1695309198.git.fdmanana@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 21, 2023 at 04:16:34PM +0100, fdmanana@kernel.org wrote:
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
> 
> V2: Add test to dir group.
>     Add commit id now that the fix is in Linus' tree (as of yesterday).

This version looks good to me, thanks!
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
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
> index 00000000..6d40d0e2
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
> +_begin_fstest auto quick dir
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $tmp.*
> +	rm -fr $target_dir
> +}
> +
> +_supported_fs generic
> +_require_test
> +_require_test_program rewinddir-test
> +
> +[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit e60aa5da14d0 \
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

