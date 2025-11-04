Return-Path: <linux-btrfs+bounces-18640-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C1C2F728
	for <lists+linux-btrfs@lfdr.de>; Tue, 04 Nov 2025 07:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7134E11CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Nov 2025 06:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8790D3BB48;
	Tue,  4 Nov 2025 06:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhUE+t5+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="twpjx7Ws"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC571B7F4
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Nov 2025 06:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762237828; cv=none; b=LePfczw9zcArbOKViz9s6+zurcTcgwDde1ZhyGaYXel/7cro4idGsGqaFxs58IzHXC0MU9C/fLnVDFw91nndeVom7yYm75wWX644r3qzoQKGRiOEkuLW4nGcXTOxSti4IVG49vLgObHDG50dtPBV1txn6Jkx6iocteM21bnI/wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762237828; c=relaxed/simple;
	bh=TyXIPVR2yWGQbWzB55tMi+H9xRlJWsHh2Q5Bw5DuYqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6KzyFIlA83ZKE5HwPgQXw036twXbDzh/cMvvedQ7/6gARpm7E4UGN4C6/s+qR2+N5I86HdLmnCPMQy+AhbWuEKqwfFZGLhsZefFoASaa2f7On2KwZ4UhUmWwI0o0Bb/vwp/c+xxSRT5CiSDce1XJ3Xp6HkyfhM2Z3bfJRZ7BcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhUE+t5+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=twpjx7Ws; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762237825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3jFJMkSf6diY9FldhqoYNQMdhp//5+GG9tdctJ1noww=;
	b=XhUE+t5+UWCglEYpRol2UilMnFhXhW8B/nCQcoxPIeWFiIbkBvcxKEUlcCBRWBVfK0lhO8
	N9hF2OtxTQK8PKScL1W9TqAJDGm+767olgXnIPkovRSvpCuWMD+toKahbVVseVInXj63Ex
	MX+BWlO97vKFPD7OtcaYwqYBwyPDpGA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-dFBXDp4QPH24ehcHpvtHCw-1; Tue, 04 Nov 2025 01:30:23 -0500
X-MC-Unique: dFBXDp4QPH24ehcHpvtHCw-1
X-Mimecast-MFC-AGG-ID: dFBXDp4QPH24ehcHpvtHCw_1762237822
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2958c80fcabso54803455ad.0
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Nov 2025 22:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762237822; x=1762842622; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3jFJMkSf6diY9FldhqoYNQMdhp//5+GG9tdctJ1noww=;
        b=twpjx7WstZvfWxJw35QclP5XEQrhkp/ILvxWGQS9P6vD+Z6CvSCBJnk+29guP/ctMt
         HYqaeBdhcdacaDuA4G98mvhaMRlxjzHeTKS75BPn5VTV7p06dgVnO5y4i3zE4Bzq9UEf
         ZKzOY/VoJI71hlAcvBJjLgTyhjlPZlou6RpsLXfxt9nklAPt0C21WbYyAgOgtVgyDdkl
         zZf52mTwGn4vZh9M8za9gCJeZbNaFHgVmaGAii9o1zcMb0zN/bP+8EdCMVQgpUlIaTJC
         dJHQboFjz4d7ZN8Zrjpw0dfQdGRjnnMcPmERTTJbySzqT2RZHdWi74mvNt/Zx/QwcKXK
         UgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762237822; x=1762842622;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jFJMkSf6diY9FldhqoYNQMdhp//5+GG9tdctJ1noww=;
        b=T3ex0sX42ggq4V99ds3ICdnz+11QMVGu/Gan2XR2KoVJhH6ySiGnIBQHGG7GZ00fj0
         QKvbBurcIrrHwt/KItIkhDVvVuAigjbQOgFwiE6E+FsCgeG96YXkLoq+Qsqurwe0kZxj
         GidwZnN2+zPNYtQjoXg9QQuE3qmr9OgPds19UiOa+pplakjPawuVyRv4F9mvivMbczjz
         ckz2gDAvp4XTQ5owez3b8I1gBi0nyY9c2EVuCIIwzFDOzT1u+DoNEkRbv8Atr/sH5aiU
         7Mbr1K0ramzArBHpX/GiS4syTSkjTkh2wuclIp3GJ0R7OBb5cNYbYGeOetggutU01YOM
         wtdA==
X-Forwarded-Encrypted: i=1; AJvYcCVvhZposDmiqtfU2h8qeNhwOsDU7BvaUw1Nkub1U9SuuNaEPFC8G1N8nY4NXVPt474HCgedfQS8ZjtcEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrCsZHi8irWK/UCdqqG2txObkGhr/hUNEDkjQbnhkzUJDV68hI
	e3rN7zx2IuMva+2C1W/y5f0N5YnDprYzpT3+5WTYGQS/B5gFS+LETV+fr5ze4B+7/rP1IVMNns3
	W0Y0enWstPPsDr8c5OvBAkWa3cBFsIA0SeryyEYmEKB1SWJVc3iH9rHJxqh2Mh4Cn
X-Gm-Gg: ASbGncu8GIHqOrQS+p0G7g7fohELF+36Uu5YwKkKc/zKutQvpt++6Gh3D1V+nnRLkar
	yR+4XByi6ioJrLVfb7IilH0D2WJUl4U+DhsnwE8xtkIUlWQ7dJ3MTxQwnlDad0qYRoAAzV/eG2G
	D2fW0LuWtrJ0St9jKcUIkEEnyjl9ekzBVRLMOsKPgrhb28ZHGbBn8ECOqh3mCBAtmUjqeeFQGIw
	FSLdxhuv4590OBSqij7VeKkmk6PJkOhGGLOirbYhSagKca7Hd5tH25MGSM/bJprpPSVbkRu1tvx
	236lUZ9papuI+Q4jn4rrASws2V/ZdHTBI4ayQ3iadGNfj9pJxENyvquza6lCwAMKFvC2dopV+Fy
	YyuUK8YlDD46AGjpyEhXvDZcVVlR1sinvwcg77WI=
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr148300605ad.32.1762237822233;
        Mon, 03 Nov 2025 22:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFSxY5Iu9lfIb9OeQ/xMFfYmczKuwF1H2zizizPeSbsXG/KkRw1X+Nh6etskaEWhL4x79SUw==
X-Received: by 2002:a17:903:2302:b0:295:557e:746f with SMTP id d9443c01a7336-295557e7a25mr148300255ad.32.1762237821647;
        Mon, 03 Nov 2025 22:30:21 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a7476bsm13107635ad.103.2025.11.03.22.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 22:30:20 -0800 (PST)
Date: Tue, 4 Nov 2025 14:30:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add a new generic test case to verify direct io
 read
Message-ID: <20251104063016.b3w2zwuz7mx5st5t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250926095013.136988-1-wqu@suse.com>
 <20251101155702.5e2g42ixg3qvh5b5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <9acb730d-6174-4ae6-a5d8-d1bca947462b@suse.com>
 <20251102100805.qfxyd6zuyobjy6j6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <8068a2bf-293a-4821-8748-6eefac702935@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8068a2bf-293a-4821-8748-6eefac702935@gmx.com>

On Mon, Nov 03, 2025 at 07:30:48AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/11/2 20:38, Zorro Lang 写道:
> > On Sun, Nov 02, 2025 at 07:42:45AM +1030, Qu Wenruo wrote:
> [...]
> > > I'll keep pushing the fix so that the test case can be merged with an
> > > upstream fix.
> > 
> > Oh, thanks for this information! I didn't get any response from btrfs list, I
> > thought we've missed this one :) I haven't pushed this test case offically.
> > If the kernel fix is awaiting approval, I don't mind delaying this patch
> > merge. Anyway, it's good to be merged into fstests side, if only btrfs side
> > would like to treat this test failure as a bug. If they don't, this case is
> > meaningless.
> > 
> > What do you think?
> > 
> > 1) You can send this patch with my RVB later, after your kernel patch be acked.
> 
> I'd prefer this path. It's not a good experience if we merge some test case
> that we don't have fix, and have to revert the test case later.

Sure, that makes sense to me too. Please feel free to re-send this patch later :)

Thanks,
Zorro

> 
> Thanks,
> Qu
> 
> > 2) Or if the btrfs list has treated this as a bug, just need to talk more about
> >     how to fix it, then fstests can merge it to uncover the bug at first.
> > 
> > Thanks,
> > Zorro
> > 
> > 
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > > 
> > > > >    .gitignore            |   1 +
> > > > >    src/Makefile          |   2 +-
> > > > >    src/dio-read-race.c   | 167 ++++++++++++++++++++++++++++++++++++++++++
> > > > >    tests/generic/772     |  41 +++++++++++
> > > > >    tests/generic/772.out |   2 +
> > > > >    5 files changed, 212 insertions(+), 1 deletion(-)
> > > > >    create mode 100644 src/dio-read-race.c
> > > > >    create mode 100755 tests/generic/772
> > > > >    create mode 100644 tests/generic/772.out
> > > > > 
> > > > > diff --git a/.gitignore b/.gitignore
> > > > > index 82c57f41..3e950079 100644
> > > > > --- a/.gitignore
> > > > > +++ b/.gitignore
> > > > > @@ -210,6 +210,7 @@ tags
> > > > >    /src/fiemap-fault
> > > > >    /src/min_dio_alignment
> > > > >    /src/dio-writeback-race
> > > > > +/src/dio-read-race
> > > > >    /src/unlink-fsync
> > > > >    /src/file_attr
> > > > > diff --git a/src/Makefile b/src/Makefile
> > > > > index 711dbb91..e7dd4db5 100644
> > > > > --- a/src/Makefile
> > > > > +++ b/src/Makefile
> > > > > @@ -21,7 +21,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > > > >    	t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > > > >    	t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > > >    	readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd \
> > > > > -	dio-writeback-race unlink-fsync
> > > > > +	dio-writeback-race dio-read-race unlink-fsync
> > > > >    LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > > > >    	preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > > > > diff --git a/src/dio-read-race.c b/src/dio-read-race.c
> > > > > new file mode 100644
> > > > > index 00000000..7c6389e0
> > > > > --- /dev/null
> > > > > +++ b/src/dio-read-race.c
> > > > > @@ -0,0 +1,167 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0+
> > > > > +/*
> > > > > + * dio-read-race -- test direct IO read with the contents of
> > > > > + * the buffer changed during the read, which should not cause any read error.
> > > > > + *
> > > > > + * Copyright (C) 2025 SUSE Linux Products GmbH.
> > > > > + */
> > > > > +
> > > > > +/*
> > > > > + * dio-read-race
> > > > > + *
> > > > > + * Compile:
> > > > > + *
> > > > > + *   gcc -Wall -pthread -o dio-read-race dio-read-race.c
> > > > > + *
> > > > > + * Make sure filesystems with explicit data checksum can handle direct IO
> > > > > + * reads correctly, so that even the contents of the direct IO buffer changes
> > > > > + * during read, the fs should still work fine without data checksum mismatch.
> > > > > + * (Normally by falling back to buffer IO to keep the checksum and contents
> > > > > + *  consistent)
> > > > > + *
> > > > > + * Usage:
> > > > > + *
> > > > > + *   dio-read-race [-b <buffersize>] [-s <filesize>] <filename>
> > > > > + *
> > > > > + * Where:
> > > > > + *
> > > > > + *   <filename> is the name of the test file to create, if the file exists
> > > > > + *   it will be overwritten.
> > > > > + *
> > > > > + *   <buffersize> is the buffer size for direct IO. Users are responsible to
> > > > > + *   probe the correct direct IO size and alignment requirement.
> > > > > + *   If not specified, the default value will be 4096.
> > > > > + *
> > > > > + *   <filesize> is the total size of the test file. If not aligned to <blocksize>
> > > > > + *   the result file size will be rounded up to <blocksize>.
> > > > > + *   If not specified, the default value will be 64MiB.
> > > > > + */
> > > > > +
> > > > > +#include <fcntl.h>
> > > > > +#include <stdlib.h>
> > > > > +#include <stdio.h>
> > > > > +#include <pthread.h>
> > > > > +#include <unistd.h>
> > > > > +#include <getopt.h>
> > > > > +#include <string.h>
> > > > > +#include <errno.h>
> > > > > +#include <sys/stat.h>
> > > > > +
> > > > > +static int fd = -1;
> > > > > +static void *buf = NULL;
> > > > > +static unsigned long long filesize = 64 * 1024 * 1024;
> > > > > +static int blocksize = 4096;
> > > > > +
> > > > > +const int orig_pattern = 0x00;
> > > > > +const int modify_pattern = 0xff;
> > > > > +
> > > > > +static void *do_io(void *arg)
> > > > > +{
> > > > > +	ssize_t ret;
> > > > > +
> > > > > +	ret = read(fd, buf, blocksize);
> > > > > +	pthread_exit((void *)ret);
> > > > > +}
> > > > > +
> > > > > +static void *do_modify(void *arg)
> > > > > +{
> > > > > +	memset(buf, modify_pattern, blocksize);
> > > > > +	pthread_exit(NULL);
> > > > > +}
> > > > > +
> > > > > +int main (int argc, char *argv[])
> > > > > +{
> > > > > +	pthread_t io_thread;
> > > > > +	pthread_t modify_thread;
> > > > > +	unsigned long long filepos;
> > > > > +	int opt;
> > > > > +	int ret = -EINVAL;
> > > > > +
> > > > > +	while ((opt = getopt(argc, argv, "b:s:")) > 0) {
> > > > > +		switch (opt) {
> > > > > +		case 'b':
> > > > > +			blocksize = atoi(optarg);
> > > > > +			if (blocksize == 0) {
> > > > > +				fprintf(stderr, "invalid blocksize '%s'\n", optarg);
> > > > > +				goto error;
> > > > > +			}
> > > > > +			break;
> > > > > +		case 's':
> > > > > +			filesize = atoll(optarg);
> > > > > +			if (filesize == 0) {
> > > > > +				fprintf(stderr, "invalid filesize '%s'\n", optarg);
> > > > > +				goto error;
> > > > > +			}
> > > > > +			break;
> > > > > +		default:
> > > > > +			fprintf(stderr, "unknown option '%c'\n", opt);
> > > > > +			goto error;
> > > > > +		}
> > > > > +	}
> > > > > +	if (optind >= argc) {
> > > > > +		fprintf(stderr, "missing argument\n");
> > > > > +		goto error;
> > > > > +	}
> > > > > +	ret = posix_memalign(&buf, sysconf(_SC_PAGESIZE), blocksize);
> > > > > +	if (!buf) {
> > > > > +		fprintf(stderr, "failed to allocate aligned memory\n");
> > > > > +		exit(EXIT_FAILURE);
> > > > > +	}
> > > > > +	fd = open(argv[optind], O_DIRECT | O_RDWR | O_CREAT, 0600);
> > > > > +	if (fd < 0) {
> > > > > +		fprintf(stderr, "failed to open file '%s': %m\n", argv[optind]);
> > > > > +		goto error;
> > > > > +	}
> > > > > +
> > > > > +	memset(buf, orig_pattern, blocksize);
> > > > > +	/* Create the original file. */
> > > > > +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> > > > > +
> > > > > +		ret = write(fd, buf, blocksize);
> > > > > +		if (ret < 0) {
> > > > > +			ret = -errno;
> > > > > +			fprintf(stderr, "failed to write the initial content: %m");
> > > > > +			goto error;
> > > > > +		}
> > > > > +	}
> > > > > +	ret = lseek(fd, 0, SEEK_SET);
> > > > > +	if (ret < 0) {
> > > > > +		ret = -errno;
> > > > > +		fprintf(stderr, "failed to set file offset to 0: %m");
> > > > > +		goto error;
> > > > > +	}
> > > > > +
> > > > > +	/* Do the read race. */
> > > > > +	for (filepos = 0; filepos < filesize; filepos += blocksize) {
> > > > > +		void *retval = NULL;
> > > > > +
> > > > > +		memset(buf, orig_pattern, blocksize);
> > > > > +		pthread_create(&io_thread, NULL, do_io, NULL);
> > > > > +		pthread_create(&modify_thread, NULL, do_modify, NULL);
> > > > > +		ret = pthread_join(io_thread, &retval);
> > > > > +		if (ret) {
> > > > > +			errno = ret;
> > > > > +			ret = -ret;
> > > > > +			fprintf(stderr, "failed to join io thread: %m\n");
> > > > > +			goto error;
> > > > > +		}
> > > > > +		if ((ssize_t )retval < blocksize) {
> > > > > +			ret = -EIO;
> > > > > +			fprintf(stderr, "io thread failed\n");
> > > > > +			goto error;
> > > > > +		}
> > > > > +		ret = pthread_join(modify_thread, NULL);
> > > > > +		if (ret) {
> > > > > +			errno = ret;
> > > > > +			ret = -ret;
> > > > > +			fprintf(stderr, "failed to join modify thread: %m\n");
> > > > > +			goto error;
> > > > > +		}
> > > > > +	}
> > > > > +error:
> > > > > +	close(fd);
> > > > > +	free(buf);
> > > > > +	if (ret < 0)
> > > > > +		return EXIT_FAILURE;
> > > > > +	return EXIT_SUCCESS;
> > > > > +}
> > > > > diff --git a/tests/generic/772 b/tests/generic/772
> > > > > new file mode 100755
> > > > > index 00000000..46593536
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/772
> > > > > @@ -0,0 +1,41 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (c) 2025 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test 772
> > > > > +#
> > > > > +# Making sure direct IO (O_DIRECT) reads won't cause any data checksum mismatch,
> > > > > +# even if the contents of the buffer changes during read.
> > > > > +#
> > > > > +# This is mostly for filesystems with data checksum support, as the content can
> > > > > +# be modified by user space during checksum verification.
> > > > > +#
> > > > > +# To avoid such false alerts, such filesystems should fallback to buffer IO to
> > > > > +# avoid inconsistency, and never trust user space memory when checksum is involved.
> > > > > +# For filesystems without data checksum support, nothing needs to be bothered.
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto quick
> > > > > +
> > > > > +_require_scratch
> > > > > +_require_odirect
> > > > > +_require_test_program dio-read-race
> > > > > +
> > > > > +
> > > > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > > > +	"btrfs: fallback to buffered read if the inode has data checksum"
> > > > > +
> > > > > +_scratch_mkfs > $seqres.full 2>&1
> > > > > +_scratch_mount
> > > > > +
> > > > > +blocksize=$(_get_file_block_size $SCRATCH_MNT)
> > > > > +filesize=$(( 64 * 1024 * 1024))
> > > > > +
> > > > > +echo "blocksize=$blocksize filesize=$filesize" >> $seqres.full
> > > > > +
> > > > > +$here/src/dio-read-race -b $blocksize -s $filesize $SCRATCH_MNT/foobar
> > > > > +
> > > > > +echo "Silence is golden"
> > > > > +
> > > > > +# success, all done
> > > > > +_exit 0
> > > > > diff --git a/tests/generic/772.out b/tests/generic/772.out
> > > > > new file mode 100644
> > > > > index 00000000..98c13968
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/772.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 772
> > > > > +Silence is golden
> > > > > -- 
> > > > > 2.51.0
> > > > > 
> > > > > 
> > > > 
> > > 
> > 
> > 
> 
> 


