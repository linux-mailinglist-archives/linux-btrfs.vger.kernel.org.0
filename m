Return-Path: <linux-btrfs+bounces-698-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1995A806980
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 09:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4201F21570
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 08:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DAE1944D;
	Wed,  6 Dec 2023 08:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nn/en6ke"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85EA1BE8
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 00:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701850674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZFt9BbAWcE9WTaIZVKynCOnBa6If9SJfGNqX2Zhy/k=;
	b=Nn/en6ke9tPImbViZ4uLthnrRt6H++Q0pSphXAVSS69asDVUkYRUcep4oZxIqjqQj0MwkY
	2Y3eF3dv8EC1rR2XNWzGGX/BBq1WC9DLWGA+Rx4il99kNhpMC7RW9qb77S30KABJWq/c+R
	Urr9kKQPHKUre1uFXIGgSe0B5itnH2Q=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-sbcr-IXAOl6_VoWfPj7moA-1; Wed, 06 Dec 2023 03:17:52 -0500
X-MC-Unique: sbcr-IXAOl6_VoWfPj7moA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5c6a04d3a8bso1241514a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Dec 2023 00:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850672; x=1702455472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZFt9BbAWcE9WTaIZVKynCOnBa6If9SJfGNqX2Zhy/k=;
        b=B+sfuYD25TekqkDibgjgqnP9xLOkQV5kJUu2di46nWR7inqd4tUQZTMLceNMbGt6cD
         ZajkF58pK/zxlqAQ0G+v6GO/zmYBodiGIAV8Brn5D6OY5RD8lcQ62PtTG93hzZBS9SdN
         kmA4/BAV3BFH9BWm9HyzVvJvClZmgrtry8km/kDTXS9P8/paQRICB4Cy+mPRYKX6s5wP
         M0YFHQrSS94PThbbnktNRzg34OJ26nuyj+AjoS1XO75aNfR45hQo9oixTuv4fHdvxLhq
         m/+4bFWgMR4LsTCLPFXd3Pn43QLKnctFxsys3h63z2EliZKYEVuoJU2ayFY41Dzlr6Vn
         8ORg==
X-Gm-Message-State: AOJu0YzPaw4yulnUVK054tFE8KB0VImiAKZoVoJRRkeLWXwAsaPQ2kuL
	HygofEjgqhb/AYHrz07dzU4xMU64cPbLRh6GczR9mp1PdPycz4M9fk5Z+NEyGJ/OQwGnx0QLLTi
	qvGmhBkxat37zDX6JEF6F7CI=
X-Received: by 2002:a05:6a20:7b06:b0:18f:b870:e9b3 with SMTP id s6-20020a056a207b0600b0018fb870e9b3mr243378pzh.121.1701850671767;
        Wed, 06 Dec 2023 00:17:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHV3UGvJkII38W6h8XAyvHM4DCHS7/vtXzFOCafBx8ZXPugdqe9EfOxQNLvdAVGKQ0JPo9zLA==
X-Received: by 2002:a05:6a20:7b06:b0:18f:b870:e9b3 with SMTP id s6-20020a056a207b0600b0018fb870e9b3mr243370pzh.121.1701850671409;
        Wed, 06 Dec 2023 00:17:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jf20-20020a170903269400b001cfc1b931a9sm7395141plb.249.2023.12.06.00.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:17:50 -0800 (PST)
Date: Wed, 6 Dec 2023 16:17:47 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test reading a large directory while renaming
 its files
Message-ID: <20231206081747.5rr7zzsfivenaag5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <e54239e625f794c62b962c35d06db04571bf73d5.1701794007.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e54239e625f794c62b962c35d06db04571bf73d5.1701794007.git.fdmanana@suse.com>

On Tue, Dec 05, 2023 at 04:39:20PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that on a fairly large directory if we keep renaming files while
> holding the directory open and doing readdir(3) calls, we don't end up
> in an infinite loop.
> 
> This exercise a bug that existed in btrfs and was fixed in kernel 6.5
> by commit 9b378f6ad48c ("btrfs: fix infinite directory reads").
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

This patch looks good to me, I'll add this case into "rename" group too
when I merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  .gitignore                  |   1 +
>  src/Makefile                |   3 +-
>  src/readdir-while-renames.c | 146 ++++++++++++++++++++++++++++++++++++
>  tests/generic/734           |  37 +++++++++
>  tests/generic/734.out       |   2 +
>  5 files changed, 188 insertions(+), 1 deletion(-)
>  create mode 100644 src/readdir-while-renames.c
>  create mode 100755 tests/generic/734
>  create mode 100644 tests/generic/734.out
> 
> diff --git a/.gitignore b/.gitignore
> index 4c32ac42..7508b6e8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -121,6 +121,7 @@ tags
>  /src/punch-alternating
>  /src/pwrite_mmap_blocked
>  /src/randholes
> +/src/readdir-while-renames
>  /src/rename
>  /src/renameat2
>  /src/resvtest
> diff --git a/src/Makefile b/src/Makefile
> index 8160a0e8..d79015ce 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -19,7 +19,8 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
>  	t_ofd_locks t_mmap_collision mmap-write-concurrent \
>  	t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
>  	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> -	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test
> +	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> +	readdir-while-renames
>  
>  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
>  	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> diff --git a/src/readdir-while-renames.c b/src/readdir-while-renames.c
> new file mode 100644
> index 00000000..afeefb04
> --- /dev/null
> +++ b/src/readdir-while-renames.c
> @@ -0,0 +1,146 @@
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
> +/* Number of files we add to the test directory. */
> +#define NUM_FILES 5000
> +
> +int main(int argc, char *argv[])
> +{
> +	struct dirent *entry;
> +	DIR *dir = NULL;
> +	char *dir_path = NULL;
> +	int dentry_count = 0;
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
> +	ret = mkdir(dir_path, 0700);
> +	if (ret == -1) {
> +		fprintf(stderr, "Failed to create test directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	ret = chdir(dir_path);
> +	if (ret == -1) {
> +		fprintf(stderr, "Failed to chdir to the test directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	/* Now create all files inside the directory. */
> +	for (i = 1; i <= NUM_FILES; i++) {
> +		char file_name[32];
> +		FILE *f;
> +
> +		sprintf(file_name, "%s/%d", dir_path, i);
> +		f = fopen(file_name, "w");
> +		if (f == NULL) {
> +			fprintf(stderr, "Failed to create file number %d: %d\n",
> +				i, errno);
> +			ret = errno;
> +			goto out;
> +		}
> +		fclose(f);
> +	}
> +
> +	dir = opendir(dir_path);
> +	if (dir == NULL) {
> +		fprintf(stderr, "Failed to open directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	/*
> +	 * readdir(3) returns NULL when it reaches the end of the directory or
> +	 * when an error happens, so reset errno to 0 to distinguish between
> +	 * both cases later.
> +	 */
> +	errno = 0;
> +	while ((entry = readdir(dir)) != NULL) {
> +		dentry_count++;
> +		/*
> +		 * The actual number of dentries returned varies per filesystem
> +		 * implementation. On a 6.7-rc4 kernel, on x86_64 with default
> +		 * mkfs options, xfs returns 5031 dentries while ext4, f2fs and
> +		 * btrfs return 5002 (the 5000 files plus "." and ".."). These
> +		 * variations are fine and valid according to POSIX, as some of
> +		 * the renames may be visible or not while calling readdir(3).
> +		 * We only want to check we don't enter into an infinite loop,
> +		 * so let the maximum number of dentries be 3 * NUM_FILES, which
> +		 * is very reasonable.
> +		 */
> +		if (dentry_count > 3 * NUM_FILES) {
> +			fprintf(stderr,
> +				"Found too many directory entries (%d)\n",
> +				dentry_count);
> +			ret = 1;
> +			goto out;
> +		}
> +		/* Can't rename "." and "..", skip them. */
> +		if (strcmp(entry->d_name, ".") == 0 ||
> +		    strcmp(entry->d_name, "..") == 0)
> +			continue;
> +		ret = rename(entry->d_name, "TEMPFILE");
> +		if (ret == -1) {
> +			fprintf(stderr,
> +				"Failed to rename '%s' to TEMPFILE: %d\n",
> +				entry->d_name, errno);
> +			ret = errno;
> +			goto out;
> +		}
> +		ret = rename("TEMPFILE", entry->d_name);
> +		if (ret == -1) {
> +			fprintf(stderr,
> +				"Failed to rename TEMPFILE to '%s': %d\n",
> +				entry->d_name, errno);
> +			ret = errno;
> +			goto out;
> +		}
> +	}
> +
> +	if (errno) {
> +		fprintf(stderr, "Failed to read directory: %d\n", errno);
> +		ret = errno;
> +		goto out;
> +	}
> +
> +	/* It should return at least NUM_FILES entries +2 (for "." and ".."). */
> +	if (dentry_count < NUM_FILES + 2) {
> +		fprintf(stderr,
> +			"Found less directory entries than expected (%d but expected %d)\n",
> +			dentry_count, NUM_FILES + 2);
> +		ret = 2;
> +	}
> +out:
> +	free(dir_path);
> +	if (dir != NULL)
> +		closedir(dir);
> +
> +	return ret;
> +}
> diff --git a/tests/generic/734 b/tests/generic/734
> new file mode 100755
> index 00000000..ea3dfb2d
> --- /dev/null
> +++ b/tests/generic/734
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 734
> +#
> +# Test that on a fairly large directory if we keep renaming files while holding
> +# the directory open and doing readdir(3) calls, we don't end up in an infinite
> +# loop.
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
> +_require_test_program readdir-while-renames
> +
> +[ $FSTYP == "btrfs" ] && _fixed_by_kernel_commit 9b378f6ad48c \
> +	"btrfs: fix infinite directory reads"
> +
> +target_dir="$TEST_DIR/test-$seq"
> +rm -fr $target_dir
> +mkdir $target_dir
> +
> +$here/src/readdir-while-renames $target_dir
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/734.out b/tests/generic/734.out
> new file mode 100644
> index 00000000..4299839b
> --- /dev/null
> +++ b/tests/generic/734.out
> @@ -0,0 +1,2 @@
> +QA output created by 734
> +Silence is golden
> -- 
> 2.40.1
> 
> 


