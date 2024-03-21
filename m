Return-Path: <linux-btrfs+bounces-3488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F3881C2F
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 06:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646642831E7
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Mar 2024 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC653381AA;
	Thu, 21 Mar 2024 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoIVQPI2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D33C478
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Mar 2024 05:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999833; cv=none; b=lCuKZLjafRhdJMIwVafT9VQvuYZFC75cuiw2nbY09o3BSZ8aiSBP5oDdnjwiaJaKPxXXFbFo9AZO41WfnSIjtdjceOZ3TOBJSK2ztn+pCAwvbAHpm6Y+O/T18yKmjCAQvu0h1kKTJiCyDNxVJmW9rgC4ADAKoqFuzajx8Pi1B1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999833; c=relaxed/simple;
	bh=T7PS2uS7KSX8QHhM9SRbT9qlZ4ou78o00mRjDOG/VG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFrhFOhWw5rRo9CuGxLFQxTLs/t7I70zYCxi/olM6JGRi/U702g3msM1UI9utf8LGYXNOP6YUxNQzGKUBWxZnvSgwYdAHOliSjSkvTu/SZ9BO35tlab6E2mOXFgXkhh4qW1E9SLEAFqVwZj1B6so90CyPiBvbo+RjwG5jKFMv2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoIVQPI2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710999828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jLKMqI52IRGGsbRL7wIanLVluWbMyRNHHcoF/Od0N4U=;
	b=aoIVQPI2Z01pFdGZxbn/oe+6lh1zEW4DTXZ5cXbAK3hzB9B2hIQXKJJCKrfbi39QcsEmLv
	AewCX2Ikpk3yJI6giLSZJpOI9dltcF46T9EwzKV5yI/mn8ihtpbGlbKikQr1ZX8dEYdIIa
	wGFMVJ7fTQbnTGJWOYpwB4PrrXJwGdA=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-ZRixmYYoOUe0dbSNTC0Gpg-1; Thu, 21 Mar 2024 01:43:46 -0400
X-MC-Unique: ZRixmYYoOUe0dbSNTC0Gpg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8df7c5500so365526a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 22:43:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710999825; x=1711604625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLKMqI52IRGGsbRL7wIanLVluWbMyRNHHcoF/Od0N4U=;
        b=OYLNR/6/iz9ZwTGV6AGlQic8fKcZgZng5mwO733zeYPhwkoMPJVZISmkLoVlQYHh5K
         WLS2oRMNg6DXb5UM1YtlYi48WR3HM0j3Sw/hJzWVx3WJGLKAavJfOIAnST2/tt/f4Wo3
         N0Tjpj9I5xDmPcQVS/b2MwuhFhFdJS79rbBODqp/FImZbnkY0nZhW19SuGbNU5uXrxOK
         AIC/Uefuj3pzWCJzFsnQZfmrS0VvxX3F1rUgYjg70014jBArbPZLNle6zttSckcX4+zD
         8yNzAJ9gcZjjcQBp9JlTHMI5sqoMkIPKFXF81AvYrBR2mYNGGABVX/aOqHjPYSRyQIEJ
         h41w==
X-Gm-Message-State: AOJu0Yx9vRyUyE1GAbkXWxe3s4F3WzWYkOLhG0TAlouZxLz3Zb0B1F3o
	FwRq1tSdz3SIASWlqM9Z8kaDKf2KkLEeNiNp3eapgAfyk1nQS+xhtP+LaIRfvu6Co5PmVbF6F+9
	w9WDRQ96vkwLcUXYLdK2lBSBx0GlL7pacp6xih9wKWmhg/Ss6gAN0IedsNWjU
X-Received: by 2002:a17:902:934c:b0:1dd:50f0:3e72 with SMTP id g12-20020a170902934c00b001dd50f03e72mr6992535plp.26.1710999825478;
        Wed, 20 Mar 2024 22:43:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCF6OD5nEe50Hej/iiC9pcKpPfHF7/NPRcShhwDzrdhzBN7CA7z3fG0KCAmfCYHFx1CM+iPA==
X-Received: by 2002:a17:902:934c:b0:1dd:50f0:3e72 with SMTP id g12-20020a170902934c00b001dd50f03e72mr6992521plp.26.1710999824923;
        Wed, 20 Mar 2024 22:43:44 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902780d00b001ddda2a276asm15009038pll.283.2024.03.20.22.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 22:43:44 -0700 (PDT)
Date: Thu, 21 Mar 2024 13:43:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v4] generic/808: add a regression test for fiemap into an
 mmap range
Message-ID: <20240321054341.uig5xqjjgl56h3e7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
> ---
> v3->v4:
> - Rework this to use punch-alternating to generate a fragmented file.
> - Rework the _require's to reflect the new mode of fragmenting a file.

Thanks, this version is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

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


