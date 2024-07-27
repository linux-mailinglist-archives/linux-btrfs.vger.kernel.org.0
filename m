Return-Path: <linux-btrfs+bounces-6795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6845993DDD6
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D8C1C211A8
	for <lists+linux-btrfs@lfdr.de>; Sat, 27 Jul 2024 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F5F40848;
	Sat, 27 Jul 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTA9HeA4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A751D6AA
	for <linux-btrfs@vger.kernel.org>; Sat, 27 Jul 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722068840; cv=none; b=Mw7lInw8rJ8kzvkIQ83W4ZH1Q99/elApggOl9nFD+Tshqjv/FtH0/zavHD0klhe26xbTAPsWeuMA48luynAKQLe7P23wzMuRbKreWyKugism8XjiFkgRUGxDmzIPKT4KUXGYMHEeWdUvMucUoTukEly07Z07EGZ5Bbc2mo1fRu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722068840; c=relaxed/simple;
	bh=jTq48MbiY3H+c0We6/XB8VtU8TEOTkwiwqr5rAu/7JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlU4ADVFpamDuk160F/cu0TO1+Reirm+2aid1FG+GTeA7QiK+Rb7JhGHA0cuU9sOwmgy0a9Iosccc42GKTnlITU2EHGPfu92oAgyq9ph1piHtmiSrBylwEsf1g3HkF5QPUcbs8JQQmRu9vLugb0YaEH/+j3Gc/dBe8Tl9yrAN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTA9HeA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722068836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zR6u5tU0LAcpwSBQczJi8cCwqFYZGSOAR9mydqUy340=;
	b=ZTA9HeA485gRDAXbFig63e0xYC/QI2QWZgYAi9CiHpF4HK1QZADN9F6+zvwSDo2hZIhw5j
	4ueGdN4697xp7rZEZoUHO1lcqa+NM9eHljHsAJ41PERu5ZIPeSjs71PZJsmQqoXJ7+x4He
	KnUY+owlmuhSQCd6L4ftMv1EiYQ7gSc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-Op7LhwmKNnGCcqAl74gioA-1; Sat, 27 Jul 2024 04:27:12 -0400
X-MC-Unique: Op7LhwmKNnGCcqAl74gioA-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-70941ab4a01so614322a34.1
        for <linux-btrfs@vger.kernel.org>; Sat, 27 Jul 2024 01:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722068831; x=1722673631;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zR6u5tU0LAcpwSBQczJi8cCwqFYZGSOAR9mydqUy340=;
        b=LYPpINURTGY6dKI4LvnDkl0HCnG/EetQycBkRpA1q0Ur4elfqExf/ZkkREHhAUEcjX
         hpjMOMBpM3EIdd39iDOunJEu/NLvH5eHcSg8a+jnY3wYyB7moyWagXqg3vRetkPmkSpB
         WMuEVzqCrfrsCd/6imrx+6osJHfC8Lj8dwWA7AFIPQgiNbb1L+pd8oN4Hv7iynxcc33E
         S4pdC+Uy8duVsDH4V4eTSRMMm4BkVAAKb8Uw6zrUZX8v4/A6z/Zhq9EVdr7roPysawF6
         8L3B/f2kvtWLpOfe0hu6iAC7u9UQRiQdzy5mLUZ4vXJ5Lwm3v6GlUy4Fp/7KGC1MTy3g
         TfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXikGm+Kj0lugg95mX7B3ptzgU98kHx+GU10/Bq7UY3Cm0lE0Aqozqh64AsM4G9T2neI2KrXqGkQefePEc1h3J5/LuUaliK9jwcji4=
X-Gm-Message-State: AOJu0YxZydvN3jM9Mdvu417FWznUqTOob/IA8lPOKhgzfoR5pI7AYlDr
	Kxc7DXBSw4Gu17XGOuGtw3yUMKfBPnvcRcJE/dg6fSWMO8RU10Exz3CGQEh8wJOS3F6HXqkLDRW
	RdV7k9lFNW+jEnjuOt1bBcEcuwLuTybtK2bkL4PM7qLGEMZ7eEL242/JeaUhSE9fxMzK0sPE=
X-Received: by 2002:a05:6870:638a:b0:254:997e:ea4d with SMTP id 586e51a60fabf-267d4ccb6c4mr2418268fac.10.1722068830896;
        Sat, 27 Jul 2024 01:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPEimEEINfSUh97epFSn33nYcXv+BH9ka3G7I9a+ccX7753a5JX2OnaKXGhQZ9ndGDHGhF1Q==
X-Received: by 2002:a05:6870:638a:b0:254:997e:ea4d with SMTP id 586e51a60fabf-267d4ccb6c4mr2418251fac.10.1722068830417;
        Sat, 27 Jul 2024 01:27:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8225dbsm3784965b3a.123.2024.07.27.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 01:27:10 -0700 (PDT)
Date: Sat, 27 Jul 2024 16:27:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic: test page fault during direct IO write with
 O_APPEND
Message-ID: <20240727082706.gmi2bkdt5piy4bgp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <20240726175837.jtq4df4u7rol3qac@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6RMX=1EPCESDc5-OXB=dF4W56u6PY72Dv2wN78TdGw3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6RMX=1EPCESDc5-OXB=dF4W56u6PY72Dv2wN78TdGw3w@mail.gmail.com>

On Fri, Jul 26, 2024 at 07:12:34PM +0100, Filipe Manana wrote:
> On Fri, Jul 26, 2024 at 6:58 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Jul 26, 2024 at 04:55:46PM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that doing a direct IO append write to a file when the input buffer
> > > was not yet faulted in, does not result in an incorrect file size.
> > >
> > > This exercises a bug on btrfs reported by users and which is fixed by
> > > the following kernel patch:
> > >
> > >    "btrfs: fix corruption after buffer fault in during direct IO append write"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  .gitignore                 |   1 +
> > >  src/Makefile               |   2 +-
> > >  src/dio-append-buf-fault.c | 131 +++++++++++++++++++++++++++++++++++++
> > >  tests/generic/362          |  28 ++++++++
> > >  tests/generic/362.out      |   2 +
> > >  5 files changed, 163 insertions(+), 1 deletion(-)
> > >  create mode 100644 src/dio-append-buf-fault.c
> > >  create mode 100755 tests/generic/362
> > >  create mode 100644 tests/generic/362.out
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index b5f15162..97c7e001 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -72,6 +72,7 @@ tags
> > >  /src/deduperace
> > >  /src/detached_mounts_propagation
> > >  /src/devzero
> > > +/src/dio-append-buf-fault
> > >  /src/dio-buf-fault
> > >  /src/dio-interleaved
> > >  /src/dio-invalidate-cache
> > > diff --git a/src/Makefile b/src/Makefile
> > > index 99796137..559209be 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > -     readdir-while-renames
> > > +     readdir-while-renames dio-append-buf-fault
> > >
> > >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > > diff --git a/src/dio-append-buf-fault.c b/src/dio-append-buf-fault.c
> > > new file mode 100644
> > > index 00000000..f4be4845
> > > --- /dev/null
> > > +++ b/src/dio-append-buf-fault.c
> > > @@ -0,0 +1,131 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> > > + */
> > > +
> > > +/*
> > > + * Test a direct IO write in append mode with a buffer that was not faulted in
> > > + * (or just partially) before the write.
> > > + */
> > > +
> > > +/* Get the O_DIRECT definition. */
> > > +#ifndef _GNU_SOURCE
> > > +#define _GNU_SOURCE
> > > +#endif
> > > +
> > > +#include <stdio.h>
> > > +#include <stdlib.h>
> > > +#include <unistd.h>
> > > +#include <stdint.h>
> > > +#include <fcntl.h>
> > > +#include <errno.h>
> > > +#include <string.h>
> > > +#include <sys/mman.h>
> > > +#include <sys/stat.h>
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +     struct stat stbuf;
> > > +     int fd;
> > > +     long pagesize;
> > > +     void *buf;
> > > +     ssize_t ret;
> > > +
> > > +     if (argc != 2) {
> > > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > > +             return 1;
> > > +     }
> > > +
> > > +     /*
> > > +      * First try an append write against an empty file of a buffer with a
> > > +      * size matching the page size. The buffer is not faulted in before
> > > +      * attempting the write.
> > > +      */
> > > +
> > > +     fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
> > > +     if (fd == -1) {
> > > +             perror("Failed to open/create file");
> > > +             return 2;
> > > +     }
> > > +
> > > +     pagesize = sysconf(_SC_PAGE_SIZE);
> > > +     if (pagesize == -1) {
> > > +             perror("Failed to get page size");
> > > +             return 3;
> > > +     }
> > > +
> > > +     buf = mmap(NULL, pagesize, PROT_READ | PROT_WRITE,
> > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > +     if (buf == MAP_FAILED) {
> > > +             perror("Failed to allocate first buffer");
> > > +             return 4;
> > > +     }
> > > +
> > > +     ret = write(fd, buf, pagesize);
> > > +     if (ret < 0) {
> > > +             perror("First write failed");
> > > +             return 5;
> > > +     }
> > > +
> > > +     ret = fstat(fd, &stbuf);
> > > +     if (ret < 0) {
> > > +             perror("First stat failed");
> > > +             return 6;
> > > +     }
> > > +
> > > +     if (stbuf.st_size != pagesize) {
> > > +             fprintf(stderr,
> > > +                     "Wrong file size after first write, got %jd expected %ld\n",
> > > +                     (intmax_t)stbuf.st_size, pagesize);
> > > +             return 7;
> > > +     }
> > > +
> > > +     munmap(buf, pagesize);
> > > +     close(fd);
> > > +
> > > +     /*
> > > +      * Now try an append write against an empty file of a buffer with a
> > > +      * size matching twice the page size. Only the first page of the buffer
> > > +      * is faulted in before attempting the write, so that the second page
> > > +      * should be faulted in during the write.
> > > +      */
> > > +     fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT | O_APPEND, 0666);
> > > +     if (fd == -1) {
> > > +             perror("Failed to open/create file");
> > > +             return 8;
> > > +     }
> > > +
> > > +     buf = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > +     if (buf == MAP_FAILED) {
> > > +             perror("Failed to allocate second buffer");
> > > +             return 9;
> > > +     }
> > > +
> > > +     /* Fault in first page of the buffer before the write. */
> > > +     memset(buf, 0, 1);
> > > +
> > > +     ret = write(fd, buf, pagesize * 2);
> > > +     if (ret < 0) {
> > > +             perror("Second write failed");
> >
> > Hi Filipe,
> >
> > This patch looks good to me, just a question about this part. Is it possible
> > to get (0 < ret < pagesize * 2) at here? Is so, should we report fail too?
> 
> It is possible, if a short write happens.
> If that's the case, we detect the failure below when checking the file
> size with the stat call.
> 
> >
> > > +             return 10;
> > > +     }
> > > +
> > > +     ret = fstat(fd, &stbuf);
> > > +     if (ret < 0) {
> > > +             perror("Second stat failed");
> > > +             return 11;
> > > +     }
> > > +
> > > +     if (stbuf.st_size != pagesize * 2) {
> > > +             fprintf(stderr,
> > > +                     "Wrong file size after second write, got %jd expected %ld\n",
> > > +                     (intmax_t)stbuf.st_size, pagesize * 2);
> >
> > Does this try to check the stbuf.st_size isn't equal to the write(2) return
> > value? Or checks stbuf.st_size != pagesize * 2, when the return value is
> > good (equal to pagesize * 2) ?
> 
> It checks if it is equals to pagesize * 2, which is supposed to be the
> final file size, meaning the write succeeded and wrote all the
> expected data (pagesize * 2).

Thanks for your explanation.

I noticed that the "Wrong file size after second write, got %jd expected %ld\n"
line means the bug is triggered:

  # ./check -s default generic/362
  SECTION       -- default
  FSTYP         -- btrfs
  PLATFORM      -- Linux/x86_64 dell-xxxxx-xxx 6.10.0-0.rc7.20240712git43db1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC 2024
  MKFS_OPTIONS  -- /dev/sda6
  MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch

  generic/362 1s ... - output mismatch (see /root/git/xfstests/results//default/generic/362.out.bad)
      --- tests/generic/362.out   2024-07-27 01:38:47.810847933 +0800
      +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-07-27 01:41:50.126428012 +0800
      @@ -1,2 +1,3 @@
       QA output created by 362
      +Wrong file size after first write, got 8192 expected 4096
       Silence is golden
      ...
      (Run 'diff -u /root/git/xfstests/tests/generic/362.out /root/git/xfstests/results//default/generic/362.out.bad'  to see the entire diff)

  HINT: You _MAY_ be missing kernel fix:
        xxxxxxxxxxxx btrfs: fix corruption after buffer fault in during direct IO append write

  Ran: generic/362
  Failures: generic/362
  Failed 1 of 1 tests

I thought a "short write" isn't a bug, just a rare test failure (or we use a loop
write to avoid that?). So we might can make sure the write() returns "pagesize * 2"
at first, then check (stbuf.st_size != pagesize * 2) for the bug itself.

What do you think?

Thanks,
Zorro

> 
> Thanks.
> 
> 
> >
> > Thanks,
> > Zorro
> >
> > > +             return 12;
> > > +     }
> > > +
> > > +     munmap(buf, pagesize * 2);
> > > +     close(fd);
> > > +
> > > +     return 0;
> > > +}
> >
> > [snip]
> >
> 


