Return-Path: <linux-btrfs+bounces-18515-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CB00DC28D0E
	for <lists+linux-btrfs@lfdr.de>; Sun, 02 Nov 2025 11:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 272F7347A72
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Nov 2025 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2726A1C4;
	Sun,  2 Nov 2025 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jH726kGu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxovFs3Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AC1264628
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Nov 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762078122; cv=none; b=LFs0jy165883UlTj5oOQDlULmRM4cPzCNFzo7NCprQ5Klma5q833oQ9zF8paltdO9pDhLS1spjrrbM9Z/m/7ewSr/dbLSjXohlN+vAIZqZ6vCtHjbjLsM8K00Cpu7QT7flO39LSye6ShXPqJJ+UeEzboaNe4QUrH8dtgmlfbtKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762078122; c=relaxed/simple;
	bh=z3BJi4yKNjWGCoDq61IpSL5RmetOWbeQGhTbtQAbZNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVXuV79gL5KcWE2J9fLN9WsLS4SHjwlcrPPf4nsidNgzfnDicMQ2BGkWJoZ7Vc2Iy8gJaITveLYmsGajNzdUeLhmNmVaxKWkcVZJpOvN5ACx+e9ISF8Rt2WYGN796Sm165kgpesTYB3RDbIobYsajPeNC14iFeACIme6Z70tJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jH726kGu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxovFs3Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762078118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xAIAYKTjBL5UF56p54zbn+fLVvqNrD+20yfDzGORa7k=;
	b=jH726kGuxHbP2t5lXCirP/FpWvUNuP8A+hUMaVHw57uL/MShtBrBDVSubF5W/I4/ObzgRM
	Hri/1LHuONuMJITqNrRIHBbcNh+Xk5tETgryRww8klCl8sia0OP+QC4hjKiQT5S79o3uLO
	xp+hbYDVmWV1Ag90uW4xH+mAMFgpb8Q=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-L6rv0U-rNseumQTEifPVvw-1; Sun, 02 Nov 2025 05:08:13 -0500
X-MC-Unique: L6rv0U-rNseumQTEifPVvw-1
X-Mimecast-MFC-AGG-ID: L6rv0U-rNseumQTEifPVvw_1762078093
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cd4d3a441so3108797a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Nov 2025 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762078092; x=1762682892; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xAIAYKTjBL5UF56p54zbn+fLVvqNrD+20yfDzGORa7k=;
        b=NxovFs3Qa4RV+pMJtJNy6mBucxXkq0cGOj51l+iAXcaGtsgQUjb2RTxzBtFZ+e/bl2
         HBqqZwBv3PM0TqIzZDT2V5iJwCGmxDXQ4eUv0DsIXG8YF27RuKaSyIjhzo9l/DjaLutU
         09f3ZRAEEbcimliiD15F5lDC0IXpD5+Ye4fx5FrVlQHk4Eu7YoWVVAOPQfUNFliIn9op
         WXjcE3T9iWNNjTz3jIpDo44DffDcihg4vjb7lHA8jUG9YuYHSjAtny7funVsxWsU2BM1
         ceg71qxfOZvy+53SOqkFkLV9fiyazv2GHg9L7u8ymfNMj5CM4hqP1H+qAGgsRdZ5+pbU
         yRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762078092; x=1762682892;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAIAYKTjBL5UF56p54zbn+fLVvqNrD+20yfDzGORa7k=;
        b=M4hWbqWov3CYrtbMAx9SCSv4wvDS4aeHgYduTknowNGRbU2VxhYzk33FXBIOXiuhcW
         sLW0d5yZAXy/aaIiGKrQVrJIrGnszlwOsQsBvcWnW2VxiL9ZGaIhGQt4Qe2NJ4V4wQyY
         i06AcDfj8l7Wd4cf0kNEa7oM4XrgKRY0c1EbApkh6dGFY+9tmXfSRoHKmauYXNRAjs4v
         80evoNolygJjAF9+mu3ZQvLTtWuX7Y/Gn7vUkWp5Dwz+e9jKSJ+ZslKWlbo0G5VWP0eq
         U+f2tKXZ8yKZ9UcElYG+KrKp0hLA7kJRZNK1n0AZuG+n6TvFKXTXS+ERgCGU4FKfBlbG
         Vhjw==
X-Gm-Message-State: AOJu0Yz8UJoGn5Kg3FSusr4ILAQRufDDkxRDykd8R8xAAxx/vFOoPEfP
	zZMpACCU5wLdpRxt+7YLvVoxQ+naVYzsVYmA+K8zuEaDAxnpBtnRDHuERsOlQZngYW/ta8jVir9
	GBs0z2kw9GTz1/fkFMBiHF+44MCMZP2sYgsRqgj/G0uGWje2OCYvra3kgRanmgGWK6iaOXlct
X-Gm-Gg: ASbGncuio4YlkHcKGrPmqEGPhPGPjP/WFF3HDP1BJYqd7aAA4DtZ6d03KQzMyw78LAz
	WAQADQxUt6+o+9FZZf5urRfpI+5hrHgGu6BHfr3Xrh4d1XyELUU9Pk6UwwRDXjYDSmxmuD434LE
	7uy1U69WSm9rCTsYNDs+z3IG6PzwVFLSXg1WCDiKY2Gy9rx9uuQF4f5Q1z9i+P6l/X3Mt5l8HKW
	zHtVBsrUseJ37xMGss/u7eB8dutyDf9Ko5fdj5HPCcKyeyLpf3v0mcsY4Paifc8VQcI7BwHvY+H
	sb/E1ePUMn6rtvZ08O3DBgp4H8IY/3C7m4HJAOqlzMMXvRyfrQbsChD9Qt+9rl1BQLeGSS00m/w
	fAiWtbrC0ZQL4s2fRv8Nr5ge8iFemJUbNt927y1E=
X-Received: by 2002:a05:6a20:4326:b0:33b:121f:7968 with SMTP id adf61e73a8af0-3477cfe7d91mr18310275637.28.1762078091485;
        Sun, 02 Nov 2025 02:08:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHe4/AxNKkYAUn/gpuo8H7KiAxpkxWDzbt6wLAFrJe839G4G+kxuAM8FQEgc2ahZ2H65UNxlg==
X-Received: by 2002:a05:6a20:4326:b0:33b:121f:7968 with SMTP id adf61e73a8af0-3477cfe7d91mr18310251637.28.1762078090916;
        Sun, 02 Nov 2025 02:08:10 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bd961450sm7393657a12.20.2025.11.02.02.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 02:08:10 -0800 (PST)
Date: Sun, 2 Nov 2025 18:08:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add a new generic test case to verify direct io
 read
Message-ID: <20251102100805.qfxyd6zuyobjy6j6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250926095013.136988-1-wqu@suse.com>
 <20251101155702.5e2g42ixg3qvh5b5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9acb730d-6174-4ae6-a5d8-d1bca947462b@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9acb730d-6174-4ae6-a5d8-d1bca947462b@suse.com>

On Sun, Nov 02, 2025 at 07:42:45AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/11/2 02:27, Zorro Lang 写道:
> > On Fri, Sep 26, 2025 at 07:20:13PM +0930, Qu Wenruo wrote:
> > > [POSSIBLE PROBLEM]
> > > For filesystems with data checksum, a user space program can provide a
> > > block of aligned memory as read buffer, and modify the buffer during the
> > > read.
> > > 
> > > Btrfs used to utilize such memory directly during checksum
> > > verification, and since the content can be modified by user space, the
> > > checksum verification can fail easily when such modification happened.
> > > 
> > > This will cause a false checksum mismatch alert, and if there is no more
> > > mirror, the read will fail.
> > > And even if there is an extra mirror, checksum verification can still
> > > fail due to user space interference.
> > > 
> > > [NEW TEST CASE]
> > > The new test case is pretty much the same as the existing generic/761,
> > > utilizing a user space multi-thread program to do a direct read,
> > > meanwhile modifying the buffer at the same time.
> > > 
> > > The new program, dio-read-race, is almost the same, with some changes:
> > > 
> > > - O_RDRW flag to open the file
> > > - Populate the contents of the file
> > > - Do read and modify
> > >    Instead of write and modify
> > > 
> > > [EXPECTED RESULTS]
> > > For unpatched kernels, the new test case fails like this:
> > > 
> > >   generic/772       - output mismatch (see /home/adam/xfstests/results//generic/772.out.bad)
> > >       --- tests/generic/772.out	2025-09-26 19:07:37.319000000 +0930
> > >       +++ /home/adam/xfstests/results//generic/772.out.bad	2025-09-26 19:08:33.873401495 +0930
> > >       @@ -1,2 +1,3 @@
> > >        QA output created by 772
> > >       +io thread failed
> > >        Silence is golden
> > >       ...
> > >       (Run 'diff -u /home/adam/xfstests/tests/generic/772.out /home/adam/xfstests/results//generic/772.out.bad'  to see the entire diff)
> > > 
> > >   HINT: You _MAY_ be missing kernel fix:
> > >         xxxxxxxxxxxx btrfs: fallback to buffered read if the inode has data checksum
> > > 
> > > With dmesg recording some checksum mismatch:
> > > 
> > >   BTRFS warning (device dm-3): csum failed root 5 ino 257 off 241664 csum 0x13fec125 expected csum 0x8941f998 mirror 1
> > >   BTRFS error (device dm-3): bdev /dev/mapper/test-scratch1 errs: wr 0, rd 0, flush 0, corrupt 1, gen 0
> > >   BTRFS warning (device dm-3): direct IO failed ino 257 op 0x8800 offset 0x3b000 len 4096 err no 10
> > > 
> > > For patched kernels, the new test case passes, without any error in
> > > dmesg:
> > > 
> > >   generic/772 6s ...  6s
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > 
> > This patch has been there more than 1 month. It works on my side, and
> > didn't bring in any regressions. I'd like to merge this patch,
> > 
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> Thanks for the review, I guess the reason the patch and test case didn't get
> reviewed is the performance drop.
> 
> When we enables buffered fallback for direct writes, it indeed caused
> performance drop, and end users noticed (mostly by benchmark tools).
> 
> But thankfully it's only affecting those benchmark tools, and those tools
> are adapting to btrfs by using NOCOW flags, so no real world performance
> regression (yet).
> 
> I'll keep pushing the fix so that the test case can be merged with an
> upstream fix.

Oh, thanks for this information! I didn't get any response from btrfs list, I
thought we've missed this one :) I haven't pushed this test case offically.
If the kernel fix is awaiting approval, I don't mind delaying this patch
merge. Anyway, it's good to be merged into fstests side, if only btrfs side
would like to treat this test failure as a bug. If they don't, this case is
meaningless.

What do you think?

1) You can send this patch with my RVB later, after your kernel patch be acked.
2) Or if the btrfs list has treated this as a bug, just need to talk more about
   how to fix it, then fstests can merge it to uncover the bug at first.

Thanks,
Zorro


> 
> Thanks,
> Qu
> 
> > 
> > >   .gitignore            |   1 +
> > >   src/Makefile          |   2 +-
> > >   src/dio-read-race.c   | 167 ++++++++++++++++++++++++++++++++++++++++++
> > >   tests/generic/772     |  41 +++++++++++
> > >   tests/generic/772.out |   2 +
> > >   5 files changed, 212 insertions(+), 1 deletion(-)
> > >   create mode 100644 src/dio-read-race.c
> > >   create mode 100755 tests/generic/772
> > >   create mode 100644 tests/generic/772.out
> > > 
> > > diff --git a/.gitignore b/.gitignore
> > > index 82c57f41..3e950079 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -210,6 +210,7 @@ tags
> > >   /src/fiemap-fault
> > >   /src/min_dio_alignment
> > >   /src/dio-writeback-race
> > > +/src/dio-read-race
> > >   /src/unlink-fsync
> > >   /src/file_attr
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 711dbb91..e7dd4db5 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > >   	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > >   	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > >   	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> > > -	dio-writeback-race unlink-fsync
> > > +	dio-writeback-race dio-read-race unlink-fsync
> > >   LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > >   	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > > diff --git a/src/dio-read-race.c b/src/dio-read-race.c
> > > new file mode 100644
> > > index 00000000..7c6389e0
> > > --- /dev/null
> > > +++ b/src/dio-read-race.c
> > > @@ -0,0 +1,167 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + * dio-read-race -- test direct IO read with the contents of
> > > + * the buffer changed during the read, which should not cause any read error.
> > > + *
> > > + * Copyright (C) 2025 SUSE Linux Products GmbH.
> > > + */
> > > +
> > > +/*
> > > + * dio-read-race
> > > + *
> > > + * Compile:
> > > + *
> > > + *   gcc -Wall -pthread -o dio-read-race dio-read-race.c
> > > + *
> > > + * Make sure filesystems with explicit data checksum can handle direct IO
> > > + * reads correctly, so that even the contents of the direct IO buffer changes
> > > + * during read, the fs should still work fine without data checksum mismatch.
> > > + * (Normally by falling back to buffer IO to keep the checksum and contents
> > > + *  consistent)
> > > + *
> > > + * Usage:
> > > + *
> > > + *   dio-read-race [-b <buffersize>] [-s <filesize>] <filename>
> > > + *
> > > + * Where:
> > > + *
> > > + *   <filename> is the name of the test file to create, if the file exists
> > > + *   it will be overwritten.
> > > + *
> > > + *   <buffersize> is the buffer size for direct IO. Users are responsible to
> > > + *   probe the correct direct IO size and alignment requirement.
> > > + *   If not specified, the default value will be 4096.
> > > + *
> > > + *   <filesize> is the total size of the test file. If not aligned to <blocksize>
> > > + *   the result file size will be rounded up to <blocksize>.
> > > + *   If not specified, the default value will be 64MiB.
> > > + */
> > > +
> > > +#include <fcntl.h>
> > > +#include <stdlib.h>
> > > +#include <stdio.h>
> > > +#include <pthread.h>
> > > +#include <unistd.h>
> > > +#include <getopt.h>
> > > +#include <string.h>
> > > +#include <errno.h>
> > > +#include <sys/stat.h>
> > > +
> > > +static int fd = -1;
> > > +static void *buf = NULL;
> > > +static unsigned long long filesize = 64 * 1024 * 1024;
> > > +static int blocksize = 4096;
> > > +
> > > +const int orig_pattern = 0x00;
> > > +const int modify_pattern = 0xff;
> > > +
> > > +static void *do_io(void *arg)
> > > +{
> > > +	ssize_t ret;
> > > +
> > > +	ret = read(fd, buf, blocksize);
> > > +	pthread_exit((void *)ret);
> > > +}
> > > +
> > > +static void *do_modify(void *arg)
> > > +{
> > > +	memset(buf, modify_pattern, blocksize);
> > > +	pthread_exit(NULL);
> > > +}
> > > +
> > > +int main (int argc, char *argv[])
> > > +{
> > > +	pthread_t io_thread;
> > > +	pthread_t modify_thread;
> > > +	unsigned long long filepos;
> > > +	int opt;
> > > +	int ret = -EINVAL;
> > > +
> > > +	while ((opt = getopt(argc, argv, "b:s:")) > 0) {
> > > +		switch (opt) {
> > > +		case 'b':
> > > +			blocksize = atoi(optarg);
> > > +			if (blocksize == 0) {
> > > +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
> > > +				goto error;
> > > +			}
> > > +			break;
> > > +		case 's':
> > > +			filesize = atoll(optarg);
> > > +			if (filesize == 0) {
> > > +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
> > > +				goto error;
> > > +			}
> > > +			break;
> > > +		default:
> > > +			fprintf(stderr, "unknown option '%c'\n", opt);
> > > +			goto error;
> > > +		}
> > > +	}
> > > +	if (optind >= argc) {
> > > +		fprintf(stderr, "missing argument\n");
> > > +		goto error;
> > > +	}
> > > +	ret = posix_memalign(&buf, sysconf(_SC_PAGESIZE), blocksize);
> > > +	if (!buf) {
> > > +		fprintf(stderr, "failed to allocate aligned memory\n");
> > > +		exit(EXIT_FAILURE);
> > > +	}
> > > +	fd = open(argv[optind], O_DIRECT | O_RDWR | O_CREAT, 0600);
> > > +	if (fd < 0) {
> > > +		fprintf(stderr, "failed to open file '%s': %m\n", argv[optind]);
> > > +		goto error;
> > > +	}
> > > +
> > > +	memset(buf, orig_pattern, blocksize);
> > > +	/* Create the original file. */
> > > +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> > > +
> > > +		ret = write(fd, buf, blocksize);
> > > +		if (ret < 0) {
> > > +			ret = -errno;
> > > +			fprintf(stderr, "failed to write the initial content: %m");
> > > +			goto error;
> > > +		}
> > > +	}
> > > +	ret = lseek(fd, 0, SEEK_SET);
> > > +	if (ret < 0) {
> > > +		ret = -errno;
> > > +		fprintf(stderr, "failed to set file offset to 0: %m");
> > > +		goto error;
> > > +	}
> > > +
> > > +	/* Do the read race. */
> > > +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> > > +		void *retval = NULL;
> > > +
> > > +		memset(buf, orig_pattern, blocksize);
> > > +		pthread_create(&io_thread, NULL, do_io, NULL);
> > > +		pthread_create(&modify_thread, NULL, do_modify, NULL);
> > > +		ret = pthread_join(io_thread, &retval);
> > > +		if (ret) {
> > > +			errno = ret;
> > > +			ret = -ret;
> > > +			fprintf(stderr, "failed to join io thread: %m\n");
> > > +			goto error;
> > > +		}
> > > +		if ((ssize_t )retval < blocksize) {
> > > +			ret = -EIO;
> > > +			fprintf(stderr, "io thread failed\n");
> > > +			goto error;
> > > +		}
> > > +		ret = pthread_join(modify_thread, NULL);
> > > +		if (ret) {
> > > +			errno = ret;
> > > +			ret = -ret;
> > > +			fprintf(stderr, "failed to join modify thread: %m\n");
> > > +			goto error;
> > > +		}
> > > +	}
> > > +error:
> > > +	close(fd);
> > > +	free(buf);
> > > +	if (ret < 0)
> > > +		return EXIT_FAILURE;
> > > +	return EXIT_SUCCESS;
> > > +}
> > > diff --git a/tests/generic/772 b/tests/generic/772
> > > new file mode 100755
> > > index 00000000..46593536
> > > --- /dev/null
> > > +++ b/tests/generic/772
> > > @@ -0,0 +1,41 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 772
> > > +#
> > > +# Making sure direct IO (O_DIRECT) reads won't cause any data checksum mismatch,
> > > +# even if the contents of the buffer changes during read.
> > > +#
> > > +# This is mostly for filesystems with data checksum support, as the content can
> > > +# be modified by user space during checksum verification.
> > > +#
> > > +# To avoid such false alerts, such filesystems should fallback to buffer IO to
> > > +# avoid inconsistency, and never trust user space memory when checksum is involved.
> > > +# For filesystems without data checksum support, nothing needs to be bothered.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_require_scratch
> > > +_require_odirect
> > > +_require_test_program dio-read-race
> > > +
> > > +
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +	"btrfs: fallback to buffered read if the inode has data checksum"
> > > +
> > > +_scratch_mkfs > $seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > > +filesize=$(( 64 * 1024 * 1024))
> > > +
> > > +echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
> > > +
> > > +$here/src/dio-read-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/generic/772.out b/tests/generic/772.out
> > > new file mode 100644
> > > index 00000000..98c13968
> > > --- /dev/null
> > > +++ b/tests/generic/772.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 772
> > > +Silence is golden
> > > -- 
> > > 2.51.0
> > > 
> > > 
> > 
> 


