Return-Path: <linux-btrfs+bounces-7005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD01D948F1B
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 14:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1ECCB24FBA
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Aug 2024 12:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630B1C4616;
	Tue,  6 Aug 2024 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQ91qGu5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009A41C460D
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Aug 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947889; cv=none; b=HgKriZuzC+rQNaCJo1rtbjVBu5lCObOpjphmZpLeo19mDJxTfmInrwXIqZ+xGAKeRPh0sLJOlTEZOYAfk0DPMfsH52rZnr/HfMeBvNkfh9Qv0IlrQbgg+8mkvwQ8vtLxqPjLFx33Xsh509aiPAPzKNKgQHtYdJHvdxv/Rn1VJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947889; c=relaxed/simple;
	bh=xDtXHoffd8KU6Ths+dJpjVpB3Kws8a0V/l23EHejNcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvqdPH/qDs1RJ6xv8CLjY9PaLhiaGy439Gyyor5xIvmLsZGcai89IFohCQ1Wy6Imj4kKADdSGmSn8FABMWaxGw70fa5vQBKLcg/9Flv4qWF7qUH997VQSr2oBCrZoe2Crf8ivwQgq4UV5kgzVSGTNxO8L7h10aOv3x4IGAHHIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bQ91qGu5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722947886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7WCxK6DVoJgYq4xjBmgr8NUBNmpAEW93/Ef4vC1iMFo=;
	b=bQ91qGu5Cb/RC02QM1SJITH33fJbCRCIkc1epiEuXLR9523isv6+rGFVZ+EhkSE8O0Yccc
	9Js6XBWpCjw/W/jIhIlqP1T2eZQmLrWQsvCKf+Rsar4RUbEwTyMa1duerhKdd80YCTfRW0
	V061VIdWMLl7tWnOI3pRe7/H2UjEmPQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-7k_v2COQOKCdEQ6NlH_bWw-1; Tue, 06 Aug 2024 08:38:04 -0400
X-MC-Unique: 7k_v2COQOKCdEQ6NlH_bWw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2cb51290896so901982a91.0
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Aug 2024 05:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947883; x=1723552683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WCxK6DVoJgYq4xjBmgr8NUBNmpAEW93/Ef4vC1iMFo=;
        b=i87A28Ydps9Ja0ko8pf/SzsUFQl1ShSdTM1bpP2+zGlmHCtGCw6jXifgOcXIFV86kY
         Cn1U1Wy/v3koHwdba/ehbwpjC/mLzdoBff0jxcyQJOc7ISl23owwd4w57Ju6zpGP29/d
         M/7m1s4NRU9CjUjcmnLDhnMGaGCmE/wzHLDXuWfWjAxFV7uQyUvB6Nmx/noEAhxvWrQ8
         yLrXO+M6B95Z3Vk4en0KQA4v4cwS0K8cpsEnvIVt7ghiA6y/O6fk43YS7l+zkvcaYPFN
         ICziJd9d5RpYJI0GMjldxs3QTuly7QwBap7jNJQ23axqAB9c5M+3Sl9+4vqVs0bDBIIl
         0svw==
X-Forwarded-Encrypted: i=1; AJvYcCXp78cRZim7KBUcbcV3/D5k9yS8Ca55XWsef8ale9RCJZUf+3/9DmXZKVwXeUf+5RkEKgl5oNi/RaqpTsr6yMfk5DR4n55rM0s2y+0=
X-Gm-Message-State: AOJu0Yy6ZxaNCaD2fppxxLdKln7T1pmAtgXl3NIf+CgdabBcLh9mha9C
	JH4o6NOvjv8Isfbv/9hpmsUjVkwqBET9vx9Ws5skuKE9os6LdfJG857jtKTGgTpynFPXyZOJHCp
	IwKAZxGVShviG3lahgVPiNrC6Jno9o6Ap2BBZj/taUgIj+cb71HCuGiS+v6B2
X-Received: by 2002:a17:90a:788a:b0:2cf:f3e9:d5c9 with SMTP id 98e67ed59e1d1-2cff94581b3mr13487037a91.21.1722947882832;
        Tue, 06 Aug 2024 05:38:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErDhw4LSbfoy3g+B06o+PtgfBKlj/n/ZeSoy3PA64y8C2PcB+EqXAatxbPaYZJRldXzHIhwg==
X-Received: by 2002:a17:90a:788a:b0:2cf:f3e9:d5c9 with SMTP id 98e67ed59e1d1-2cff94581b3mr13487009a91.21.1722947882256;
        Tue, 06 Aug 2024 05:38:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb0cc9f5sm9084847a91.27.2024.08.06.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:38:01 -0700 (PDT)
Date: Tue, 6 Aug 2024 20:37:58 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test page fault during direct IO write with
 O_APPEND
Message-ID: <20240806123758.o5gwppqmcsdjuiuk@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com>
 <20240728142842.iquah6ckxj7rfmvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4bo=1ZMQohRrAH+9B-M_gpdzXc7wYqXESpYWgwb77v6g@mail.gmail.com>
 <20240728165905.f2jofq7o55uo6ywa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4avzHN03WDiQ=hB0nwUOMoTPwru+dCtqLiXnc4hc6j9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4avzHN03WDiQ=hB0nwUOMoTPwru+dCtqLiXnc4hc6j9A@mail.gmail.com>

On Mon, Aug 05, 2024 at 04:09:06PM +0100, Filipe Manana wrote:
> On Sun, Jul 28, 2024 at 5:59 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sun, Jul 28, 2024 at 04:14:42PM +0100, Filipe Manana wrote:
> > > On Sun, Jul 28, 2024 at 3:28 PM Zorro Lang <zlang@redhat.com> wrote:
> > > >
> > > > On Sat, Jul 27, 2024 at 12:28:16PM +0100, fdmanana@kernel.org wrote:
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > >
> > > > > Test that doing a direct IO append write to a file when the input buffer
> > > > > was not yet faulted in, does not result in an incorrect file size.
> > > > >
> > > > > This exercises a bug on btrfs reported by users and which is fixed by
> > > > > the following kernel patch:
> > > > >
> > > > >    "btrfs: fix corruption after buffer fault in during direct IO append write"
> > > > >
> > > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > > ---
> > > > >
> > > > > V2: Deal with partial writes by looping and writing any remaining data.
> > > > >     Don't exit when the first test fails, instead let the second test
> > > > >     run as well.
> > > >
> > > > With this change I got two error lines this time [1]. Last time (V1) I
> > > > only got "Wrong file size after first write, got 8192 expected 4096".
> > >
> > > Yes, it's expected.
> > > As the changelog for v2 says, now the second test is run even if the
> > > first one failed.
> >
> > Thanks, I'd like to merge this patch:
> >
> > Reviewed-by: Zorro Lang <zlang@redhat.com>
> 
> The kernel patch landed in Linus' tree, with a commit ID of 939b656bc8ab20.
> Do you want me to send a new version replacing the xxxxxxxxxxx with
> 939b656bc8ab20, or can you do that when you pick the patch?

Sorry for this late reply, don't worry, I'll merge it with that ID.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > >
> > > > Does this mean this v2 change help this case to be better?
> > >
> > > I prefer it like that.
> > > It's common in fstests to let all steps of a test run if possible
> > > (i.e. we don't exit, call _fail, or anything equivalent, everywhere
> > > unless the test can't proceed anymore).
> > >
> > > >
> > > > Thanks,
> > > > Zorro
> > > >
> > > > [1]
> > > > [root@dell-per750-41 xfstests]# ./check -s default generic/362
> > > > SECTION       -- default
> > > > FSTYP         -- btrfs
> > > > PLATFORM      -- Linux/x86_64 dell-xx-xxxxxx 6.10.0-0.rc7.20240712git43db1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC 2024
> > > > MKFS_OPTIONS  -- /dev/sda6
> > > > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch
> > > >
> > > > generic/362 0s ... - output mismatch (see /root/git/xfstests/results//default/generic/362.out.bad)
> > > >     --- tests/generic/362.out   2024-07-28 22:22:06.098982182 +0800
> > > >     +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-07-28 22:23:16.622577397 +0800
> > > >     @@ -1,2 +1,4 @@
> > > >      QA output created by 362
> > > >     +Wrong file size after first write, got 8192 expected 4096
> > > >     +Wrong file size after second write, got 12288 expected 8192
> > > >      Silence is golden
> > > >
> > > >
> > > > >
> > > > >  .gitignore                 |   1 +
> > > > >  src/Makefile               |   2 +-
> > > > >  src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++++++
> > > > >  tests/generic/362          |  28 +++++++
> > > > >  tests/generic/362.out      |   2 +
> > > > >  5 files changed, 177 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 src/dio-append-buf-fault.c
> > > > >  create mode 100755 tests/generic/362
> > > > >  create mode 100644 tests/generic/362.out
> > > > >
> > > > > diff --git a/.gitignore b/.gitignore
> > > > > index b5f15162..97c7e001 100644
> > > > > --- a/.gitignore
> > > > > +++ b/.gitignore
> > > > > @@ -72,6 +72,7 @@ tags
> > > > >  /src/deduperace
> > > > >  /src/detached_mounts_propagation
> > > > >  /src/devzero
> > > > > +/src/dio-append-buf-fault
> > > > >  /src/dio-buf-fault
> > > > >  /src/dio-interleaved
> > > > >  /src/dio-invalidate-cache
> > > > > diff --git a/src/Makefile b/src/Makefile
> > > > > index 99796137..559209be 100644
> > > > > --- a/src/Makefile
> > > > > +++ b/src/Makefile
> > > > > @@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > > > >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > > > >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > > > >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > > > -     readdir-while-renames
> > > > > +     readdir-while-renames dio-append-buf-fault
> > > > >
> > > > >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > > > >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > > > > diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.c
> > > > > new file mode 100644
> > > > > index 00000000..72c23265
> > > > > --- /dev/null
> > > > > +++ b/src/dio-append-buf-fault.c
> > > > > @@ -0,0 +1,145 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > +/*
> > > > > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> > > > > + */
> > > > > +
> > > > > +/*
> > > > > + * Test a direct IO write in append mode with a buffer that was not faulted in
> > > > > + * (or just partially) before the write.
> > > > > + */
> > > > > +
> > > > > +/* Get the O_DIRECT definition. */
> > > > > +#ifndef _GNU_SOURCE
> > > > > +#define _GNU_SOURCE
> > > > > +#endif
> > > > > +
> > > > > +#include <stdio.h>
> > > > > +#include <stdlib.h>
> > > > > +#include <unistd.h>
> > > > > +#include <stdint.h>
> > > > > +#include <fcntl.h>
> > > > > +#include <errno.h>
> > > > > +#include <string.h>
> > > > > +#include <sys/mman.h>
> > > > > +#include <sys/stat.h>
> > > > > +
> > > > > +static ssize_t do_write(int fd, const void *buf, size_t count)
> > > > > +{
> > > > > +        while (count > 0) {
> > > > > +             ssize_t ret;
> > > > > +
> > > > > +             ret = write(fd, buf, count);
> > > > > +             if (ret < 0) {
> > > > > +                     if (errno == EINTR)
> > > > > +                             continue;
> > > > > +                     return ret;
> > > > > +             }
> > > > > +             count -= ret;
> > > > > +             buf += ret;
> > > > > +     }
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +int main(int argc, char *argv[])
> > > > > +{
> > > > > +     struct stat stbuf;
> > > > > +     int fd;
> > > > > +     long pagesize;
> > > > > +     void *buf;
> > > > > +     ssize_t ret;
> > > > > +
> > > > > +     if (argc != 2) {
> > > > > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > > > > +             return 1;
> > > > > +     }
> > > > > +
> > > > > +     /*
> > > > > +      * First try an append write against an empty file of a buffer with a
> > > > > +      * size matching the page size. The buffer is not faulted in before
> > > > > +      * attempting the write.
> > > > > +      */
> > > > > +
> > > > > +     fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
> > > > > +     if (fd == -1) {
> > > > > +             perror("Failed to open/create file");
> > > > > +             return 2;
> > > > > +     }
> > > > > +
> > > > > +     pagesize = sysconf(_SC_PAGE_SIZE);
> > > > > +     if (pagesize == -1) {
> > > > > +             perror("Failed to get page size");
> > > > > +             return 3;
> > > > > +     }
> > > > > +
> > > > > +     buf = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> > > > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > > > +     if (buf == MAP_FAILED) {
> > > > > +             perror("Failed to allocate first buffer");
> > > > > +             return 4;
> > > > > +     }
> > > > > +
> > > > > +     ret = do_write(fd, buf, pagesize);
> > > > > +     if (ret < 0) {
> > > > > +             perror("First write failed");
> > > > > +             return 5;
> > > > > +     }
> > > > > +
> > > > > +     ret = fstat(fd, &stbuf);
> > > > > +     if (ret < 0) {
> > > > > +             perror("First stat failed");
> > > > > +             return 6;
> > > > > +     }
> > > > > +
> > > > > +     /* Don't exit on failure so that we run the second test below too. */
> > > > > +     if (stbuf.st_size != pagesize)
> > > > > +             fprintf(stderr,
> > > > > +                     "Wrong file size after first write, got %jd expected %ld\n",
> > > > > +                     (intmax_t)stbuf.st_size, pagesize);
> > > > > +
> > > > > +     munmap(buf, pagesize);
> > > > > +     close(fd);
> > > > > +
> > > > > +     /*
> > > > > +      * Now try an append write against an empty file of a buffer with a
> > > > > +      * size matching twice the page size. Only the first page of the buffer
> > > > > +      * is faulted in before attempting the write, so that the second page
> > > > > +      * should be faulted in during the write.
> > > > > +      */
> > > > > +     fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
> > > > > +     if (fd == -1) {
> > > > > +             perror("Failed to open/create file");
> > > > > +             return 7;
> > > > > +     }
> > > > > +
> > > > > +     buf = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > > > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > > > +     if (buf == MAP_FAILED) {
> > > > > +             perror("Failed to allocate second buffer");
> > > > > +             return 8;
> > > > > +     }
> > > > > +
> > > > > +     /* Fault in first page of the buffer before the write. */
> > > > > +     memset(buf, 0, 1);
> > > > > +
> > > > > +     ret = do_write(fd, buf, pagesize * 2);
> > > > > +     if (ret < 0) {
> > > > > +             perror("Second write failed");
> > > > > +             return 9;
> > > > > +     }
> > > > > +
> > > > > +     ret = fstat(fd, &stbuf);
> > > > > +     if (ret < 0) {
> > > > > +             perror("Second stat failed");
> > > > > +             return 10;
> > > > > +     }
> > > > > +
> > > > > +     if (stbuf.st_size != pagesize * 2)
> > > > > +             fprintf(stderr,
> > > > > +                     "Wrong file size after second write, got %jd expected %ld\n",
> > > > > +                     (intmax_t)stbuf.st_size, pagesize * 2);
> > > > > +
> > > > > +     munmap(buf, pagesize * 2);
> > > > > +     close(fd);
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > diff --git a/tests/generic/362 b/tests/generic/362
> > > > > new file mode 100755
> > > > > index 00000000..2c127347
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/362
> > > > > @@ -0,0 +1,28 @@
> > > > > +#! /bin/bash
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > > > > +#
> > > > > +# FS QA Test 362
> > > > > +#
> > > > > +# Test that doing a direct IO append write to a file when the input buffer was
> > > > > +# not yet faulted in, does not result in an incorrect file size.
> > > > > +#
> > > > > +. ./common/preamble
> > > > > +_begin_fstest auto quick
> > > > > +
> > > > > +_require_test
> > > > > +_require_odirect
> > > > > +_require_test_program dio-append-buf-fault
> > > > > +
> > > > > +[ $FSTYP == "btrfs" ] && \
> > > > > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > > > +     "btrfs: fix corruption after buffer fault in during direct IO append write"
> > > > > +
> > > > > +# On error the test program writes messages to stderr, causing a golden output
> > > > > +# mismatch and making the test fail.
> > > > > +$here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
> > > > > +
> > > > > +# success, all done
> > > > > +echo "Silence is golden"
> > > > > +status=0
> > > > > +exit
> > > > > diff --git a/tests/generic/362.out b/tests/generic/362.out
> > > > > new file mode 100644
> > > > > index 00000000..0ff40905
> > > > > --- /dev/null
> > > > > +++ b/tests/generic/362.out
> > > > > @@ -0,0 +1,2 @@
> > > > > +QA output created by 362
> > > > > +Silence is golden
> > > > > --
> > > > > 2.43.0
> > > > >
> > > > >
> > > >
> > >
> >
> 


