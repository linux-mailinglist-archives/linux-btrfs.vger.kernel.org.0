Return-Path: <linux-btrfs+bounces-3477-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 801A08814B7
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 16:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979371F23915
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6429852F7D;
	Wed, 20 Mar 2024 15:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="RmnWbUSm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8761E502
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 15:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949079; cv=none; b=kPy5JhZ+vFEPwYs0/WllfozS9a170Wbt5MAZ8eAHN4RqtW7gKKJFPQoWhRzImGvSC7+u+WES1SUrw/SMII0KqoWFo/QgSeuXx84Mspl8G1u4PRnbr54vYvKhDFeKH9HtwYmyUPRdfNIY+Vm2C3yIjkPVecm7DO8nKeEOVzw5AeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949079; c=relaxed/simple;
	bh=0fQW1hFsR5d/EL+UAsyG//WejcbamhFcoXDsRxnNQjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIbCv3ImymJqolJWrB6ODxW9egz2EAt/t5WJ+PW0LBsktG6NkvUHypk2Zy9cXDqJQ6/xUNziFfq8dfgvsIjkW/8S4UWbESYygAa9ihkAK2qOkMDSt9WF8ynUw1fwFXjM6+gIAOYG3583z1MwfKkp6tTcipcNip4knrLZESf4v+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=RmnWbUSm; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e6969855c8so1948703a34.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Mar 2024 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710949076; x=1711553876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kpAYNhYsQiCJK4G3sMFc+12YE2oSOi1flnZkQrVDKtY=;
        b=RmnWbUSmIvLHPVkAc4GsHL6T8ZUnico9yQhjOq28IWt88anBxBNxnlMsDEmqz6xgEV
         kngIfId8w1TN440IDsGhx8mUVL5bBWyy9RkzsILCO1Whs0XndnXrcgL8vCNFgGWt1nUa
         sIeN9GZm1eDjJXVLMPHwZd37Z7fkfYmNS45rUr86a2DG240APoGsxEsTFH4qYyaIOY++
         BcmVUQqcKsAKoKD+NJlJY8D0m70pafcBCPx33CBlXyb9J9D7ycO/lvD3SW7ceYdhW0Ib
         x1eAJltoI7uAN5ESLicAfKL87evacz7lgjuIHTYd2wHH55vJeR7rlfW0K2koZlzHibhp
         QrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949076; x=1711553876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpAYNhYsQiCJK4G3sMFc+12YE2oSOi1flnZkQrVDKtY=;
        b=hCFcorkt1d4XjwI8mx3wO7IqxgTIUlExF/ok1kekSGblKCeDw2C9aedITBRrSM7wjy
         KEbX+FyjIyWGuLJoJdlTzL4XCDwJNXIQV6TfA5XauNDrKiphP3gsp5j15xzycICCbOPo
         S5YlqU8RQMSRoZJ+RKIxzXPoFOubMrQzeIOWiJU5TV/Y5QNy/Ozp+zmKJc+9jxYRwvKq
         x16Qo4PL9JhtR6FjUH27T4Q2ZCOigPPXRFSlq9WOBjE4zTS7ixiHDeJoPkixDayKwWNU
         D5cscmm7W7xkGoBt/4GL3WO8HoUqHh35wUF/+cjEtktB0exf9EPKRkN44y4knZHCoteT
         GZmw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ8/04PNjpUNzdwNN9xzfnnsq/JL/S1u+WOWBvx7mcRwge+Cz1lxpUc+Lo4VfC20QrymITic672dLAqOPB0NhKmbqsF17bR9LDCr4=
X-Gm-Message-State: AOJu0YzJnExAad3Ca1fHeh5iZjFGcEL0UR6FQl9v7Wzihpd+wDhSa+vw
	WwdIDR2GVzs9sMfkzhNGaUo754fBED5ZnrjqjJ69Ck1qnf7477XhaY1RgRUovvg=
X-Google-Smtp-Source: AGHT+IGwid02o98Akjo+0yXjeeoTDE5DkvdziSL4K41kJ3t4q45vAehj0cuHgmoF2sMXeKWa+sWh8A==
X-Received: by 2002:a05:6358:65a3:b0:17b:ee6f:b6ae with SMTP id x35-20020a05635865a300b0017bee6fb6aemr6789463rwh.9.1710949075864;
        Wed, 20 Mar 2024 08:37:55 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ev15-20020a05622a510f00b00430ea220b32sm2073376qtb.71.2024.03.20.08.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:37:55 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:37:54 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH v3] generic/808: add a regression test for fiemap into an
 mmap range
Message-ID: <20240320153754.GB3092095@perftesting>
References: <076b7d22d653a046bf3710c4fa04cc155b6cf07b.1710945314.git.josef@toxicpanda.com>
 <20240320152531.GO6188@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320152531.GO6188@frogsfrogsfrogs>

On Wed, Mar 20, 2024 at 08:25:31AM -0700, Darrick J. Wong wrote:
> On Wed, Mar 20, 2024 at 10:36:42AM -0400, Josef Bacik wrote:
> > Btrfs had a deadlock that you could trigger by mmap'ing a large file and
> > using that as the buffer for fiemap.  This test adds a c program to do
> > this, and the fstest creates a large enough file and then runs the
> > reproducer on the file.  Without the fix btrfs deadlocks, with the fix
> > we pass fine.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> > v2->v3:
> > - Add fiemap-fault to .gitignore
> > - Added a _cleanup() helper
> > - Just let the output of fiemap-fault go instead of using || _fail
> > - Added the munmap
> > - Moved $dst to $TEST_DIR/$seq
> > 
> >  .gitignore            |  1 +
> >  src/Makefile          |  2 +-
> >  src/fiemap-fault.c    | 74 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/808     | 48 ++++++++++++++++++++++++++++
> >  tests/generic/808.out |  2 ++
> >  5 files changed, 126 insertions(+), 1 deletion(-)
> >  create mode 100644 src/fiemap-fault.c
> >  create mode 100755 tests/generic/808
> >  create mode 100644 tests/generic/808.out
> > 
> > diff --git a/.gitignore b/.gitignore
> > index 3b160209..f0fb72bd 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -205,6 +205,7 @@ tags
> >  /src/vfs/mount-idmapped
> >  /src/log-writes/replay-log
> >  /src/perf/*.pyc
> > +/src/filemap-fault
> >  
> >  # Symlinked files
> >  /tests/generic/035.out
> > diff --git a/src/Makefile b/src/Makefile
> > index e7442487..ab98a06f 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -34,7 +34,7 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> >  	attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles \
> >  	fscrypt-crypt-util bulkstat_null_ocount splice-test chprojid_fail \
> >  	detached_mounts_propagation ext4_resize t_readdir_3 splice2pipe \
> > -	uuid_ioctl t_snapshot_deleted_subvolume
> > +	uuid_ioctl t_snapshot_deleted_subvolume fiemap-fault
> >  
> >  EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
> >  	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
> > diff --git a/src/fiemap-fault.c b/src/fiemap-fault.c
> > new file mode 100644
> > index 00000000..73260068
> > --- /dev/null
> > +++ b/src/fiemap-fault.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > + */
> > +
> > +#include <sys/ioctl.h>
> > +#include <sys/mman.h>
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <linux/fs.h>
> > +#include <linux/types.h>
> > +#include <linux/fiemap.h>
> > +#include <err.h>
> > +#include <errno.h>
> > +#include <fcntl.h>
> > +#include <stdio.h>
> > +#include <string.h>
> > +#include <unistd.h>
> > +
> > +int prep_mmap_buffer(int fd, void **addr)
> > +{
> > +	struct stat st;
> > +	int ret;
> > +
> > +	ret = fstat(fd, &st);
> > +	if (ret)
> > +		err(1, "failed to stat %d", fd);
> > +
> > +	*addr = mmap(NULL, st.st_size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> > +	if (*addr == MAP_FAILED)
> > +		err(1, "failed to mmap %d", fd);
> > +
> > +	return st.st_size;
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	struct fiemap *fiemap;
> > +	size_t sz, last = 0;
> > +	void *buf = NULL;
> > +	int ret, fd;
> > +
> > +	if (argc != 2)
> > +		errx(1, "no in and out file name arguments given");
> > +
> > +	fd = open(argv[1], O_RDWR, 0666);
> > +	if (fd == -1)
> > +		err(1, "failed to open %s", argv[1]);
> > +
> > +	sz = prep_mmap_buffer(fd, &buf);
> > +
> > +	fiemap = (struct fiemap *)buf;
> > +	fiemap->fm_flags = 0;
> > +	fiemap->fm_extent_count = (sz - sizeof(struct fiemap)) /
> > +				  sizeof(struct fiemap_extent);
> > +
> > +	while (last < sz) {
> > +		int i;
> > +
> > +		fiemap->fm_start = last;
> > +		fiemap->fm_length = sz - last;
> > +
> > +		ret = ioctl(fd, FS_IOC_FIEMAP, (unsigned long)fiemap);
> > +		if (ret < 0)
> > +			err(1, "fiemap failed %d", errno);
> > +		for (i = 0; i < fiemap->fm_mapped_extents; i++)
> > +		       last = fiemap->fm_extents[i].fe_logical +
> > +			       fiemap->fm_extents[i].fe_length;
> > +	}
> > +
> > +	munmap(buf, sz);
> > +	close(fd);
> > +	return 0;
> > +}
> > diff --git a/tests/generic/808 b/tests/generic/808
> > new file mode 100755
> > index 00000000..36015f35
> > --- /dev/null
> > +++ b/tests/generic/808
> > @@ -0,0 +1,48 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> > +#
> > +# FS QA Test 808
> > +#
> > +# Test fiemap into an mmaped buffer of the same file
> > +#
> > +# Create a reasonably large file, then run a program which mmaps it and uses
> > +# that as a buffer for an fiemap call.  This is a regression test for btrfs
> > +# where we used to hold a lock for the duration of the fiemap call which would
> > +# result in a deadlock if we page faulted.
> > +#
> > +. ./common/preamble
> > +_begin_fstest quick auto fiemap
> > +[ $FSTYP == "btrfs" ] && \
> > +	_fixed_by_kernel_commit b0ad381fa769 \
> > +		"btrfs: fix deadlock with fiemap and extent locking"
> > +
> > +_cleanup()
> > +{
> > +	rm -f $dst
> > +	cd /
> > +	rm -r -f $tmp.*
> > +}
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_require_test
> > +_require_odirect
> > +_require_test_program fiemap-fault
> > +dst=$TEST_DIR/$seq/fiemap-fault
> > +
> > +mkdir -p $TEST_DIR/$seq
> > +
> > +echo "Silence is golden"
> > +
> > +for i in $(seq 0 2 1000)
> > +do
> > +	$XFS_IO_PROG -d -f -c "pwrite -q $((i * 4096)) 4096" $dst
> > +done
> 
> I don't know if there's a specific reason that this does directio writes
> at alternating offsets other than forcing allocations, but usually we do:
> 
> $XFS_IO_PROG -f -c "pwrite -q 0 409600" $dst
> $src/punch-alternating $dst
> 
> to generate a file with a bunch of extent records.  Also, since this is
> a generic test that wants to create a file with sparse holes, it really
> ought to be querying the file's allocation unit size:
> 
> blksz=$(_get_file_block_size $TEST_DIR)
> $XFS_IO_PROG -f -c "pwrite -q 0 $((blksz * 100))" $dst

Ok I can do that instead, you're correct, all I want is a bunch of extents, and
for btrfs at least doing alternating directio writes to get that.  Thanks,

Josef

