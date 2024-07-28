Return-Path: <linux-btrfs+bounces-6814-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4C93E8B3
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 18:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389331F212E4
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Jul 2024 16:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055765E091;
	Sun, 28 Jul 2024 16:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcC/lT8u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904B2A35
	for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722185957; cv=none; b=JGqHp8hU1//CbeSXNVyGjg7TInGR7kdhaSpGP9sM+rOwqkQsclpOGK+na8bi/LIQAIfAC2TzVd8J9oo7ZAXzMOU4AJ4CL5OV+Wn0BxDLeosMjSpw2EgO7clv321bhNGUII230WzrDwXYsnQZHPO4ItUPu04WHlFB1bgAGNEKQhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722185957; c=relaxed/simple;
	bh=qXKZe3lQsys/+qi3gaxfEe0t4jKYt4q8GdU3CNpKVlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aF2rWvpWsZl2rQkmnGFtiU7iMsQNANJENXlrs0ySBOvuj41XLdtqrU/N66cAFyTPCmHIGXD5qDJhXf6beAwz45DPardj27GA6QWtJqQ8EPcLwkchVhV4cw4uTG+vAK79lgqUrGaJzR9JLYjslEK17T/zXj617UugHVN8VNziSyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcC/lT8u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722185953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lafCHz868fe6t2GFpP05jKEYOyAXgezCDQAPdUXjp+0=;
	b=ZcC/lT8ubbuuUwMvOjj3jwnMM2eobG/nb/GCzi6lt/R8vb+j3SLylr7g0ZexgPt5zATH6v
	UMNZxV/a0VkqH6kmukzraVoIUh1H6InhgvFGE8KKo1i82j4AdxZDGGt1vttJRBhAQKgxf8
	PqT3/X6oT2okBH1w48np2I5mV5QJQVk=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-qAiCKijfMRKiIoLZByvjJw-1; Sun, 28 Jul 2024 12:59:11 -0400
X-MC-Unique: qAiCKijfMRKiIoLZByvjJw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70d34fa1726so2992555b3a.1
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Jul 2024 09:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722185950; x=1722790750;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lafCHz868fe6t2GFpP05jKEYOyAXgezCDQAPdUXjp+0=;
        b=Ldp9pWZpForYH+s+TfD9FpH5cAje345HMml0uw8aNxs39YYZ+OAlNouk/3b+cvfrBR
         FhLpgIm+QbFOlF+VRvxb/bHzLEwMdUh+E7guVJASJirYXxQMe0BcCfeaFdT5e0gapu1h
         AE75AbtlT/pAQ5u9BrXZe70AtUDJprTep247zmC7rYNkjRnMFQ2VBGi2EisoxqDmA4oF
         GgMkYfFPsKL5cWYIL3aVT+Gx/t9z9XwNKsy7jfJhaIifzJ5xPDkW74S/y5OOqpJo8Jx0
         QsKseDp5uV6vCQDzqkchLCTvmLuv0oAGEYkwSezw6gab2VcvBjvty5nYd+cUZGM8Fzim
         UL9g==
X-Forwarded-Encrypted: i=1; AJvYcCW7p+t0HebZSQqYqO6i1uq8U+A48lpybZoGuW49sJp6ZOF7NGYQE2PQm/rYFhwc2Oph3XXJHoxU1MfVUSw6PoH1iotObXAuhdyLTZI=
X-Gm-Message-State: AOJu0YzTwx1g42Ki0OkKV47ehZ+aUBZyGoznv9MkWouUxpq3PyqS6mpU
	nYzte0VX/iwE2+qa5DN7lMGGM0E2t/HyNZHa+Mx/S807DrBbFGv7NgvYsHQM1Hio0iDvJ2FpIZD
	DusrO+n5tHYBhJnw5M+8chqcjqYZX4ZLFQ3w7OjKjwHY5kbUQpt0qZfV+AK8n
X-Received: by 2002:a05:6a21:1583:b0:1c1:e75a:5504 with SMTP id adf61e73a8af0-1c4a129fe7dmr8192864637.15.1722185950059;
        Sun, 28 Jul 2024 09:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEakVDS1R/JFzyx/FCoewhj+fR869AdsNMMf/ajPf40U5aHEi+qkNh+vFihldURytFp+cVJUQ==
X-Received: by 2002:a05:6a21:1583:b0:1c1:e75a:5504 with SMTP id adf61e73a8af0-1c4a129fe7dmr8192843637.15.1722185949615;
        Sun, 28 Jul 2024 09:59:09 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9fa5a0e2dsm4983416a12.85.2024.07.28.09.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 09:59:09 -0700 (PDT)
Date: Mon, 29 Jul 2024 00:59:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test page fault during direct IO write with
 O_APPEND
Message-ID: <20240728165905.f2jofq7o55uo6ywa@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <652ec55049e94a59f66f4112fb8707629db3001d.1722008942.git.fdmanana@suse.com>
 <6c52fe9ce75354a931afdc6d2f7fb638c7f06b00.1722079321.git.fdmanana@suse.com>
 <20240728142842.iquah6ckxj7rfmvy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H4bo=1ZMQohRrAH+9B-M_gpdzXc7wYqXESpYWgwb77v6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4bo=1ZMQohRrAH+9B-M_gpdzXc7wYqXESpYWgwb77v6g@mail.gmail.com>

On Sun, Jul 28, 2024 at 04:14:42PM +0100, Filipe Manana wrote:
> On Sun, Jul 28, 2024 at 3:28 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sat, Jul 27, 2024 at 12:28:16PM +0100, fdmanana@kernel.org wrote:
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
> > >
> > > V2: Deal with partial writes by looping and writing any remaining data.
> > >     Don't exit when the first test fails, instead let the second test
> > >     run as well.
> >
> > With this change I got two error lines this time [1]. Last time (V1) I
> > only got "Wrong file size after first write, got 8192 expected 4096".
> 
> Yes, it's expected.
> As the changelog for v2 says, now the second test is run even if the
> first one failed.

Thanks, I'd like to merge this patch:

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> > Does this mean this v2 change help this case to be better?
> 
> I prefer it like that.
> It's common in fstests to let all steps of a test run if possible
> (i.e. we don't exit, call _fail, or anything equivalent, everywhere
> unless the test can't proceed anymore).
> 
> >
> > Thanks,
> > Zorro
> >
> > [1]
> > [root@dell-per750-41 xfstests]# ./check -s default generic/362
> > SECTION       -- default
> > FSTYP         -- btrfs
> > PLATFORM      -- Linux/x86_64 dell-xx-xxxxxx 6.10.0-0.rc7.20240712git43db1e03c086.62.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Fri Jul 12 22:31:14 UTC 2024
> > MKFS_OPTIONS  -- /dev/sda6
> > MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch
> >
> > generic/362 0s ... - output mismatch (see /root/git/xfstests/results//default/generic/362.out.bad)
> >     --- tests/generic/362.out   2024-07-28 22:22:06.098982182 +0800
> >     +++ /root/git/xfstests/results//default/generic/362.out.bad 2024-07-28 22:23:16.622577397 +0800
> >     @@ -1,2 +1,4 @@
> >      QA output created by 362
> >     +Wrong file size after first write, got 8192 expected 4096
> >     +Wrong file size after second write, got 12288 expected 8192
> >      Silence is golden
> >
> >
> > >
> > >  .gitignore                 |   1 +
> > >  src/Makefile               |   2 +-
> > >  src/dio-append-buf-fault.c | 145 +++++++++++++++++++++++++++++++++++++
> > >  tests/generic/362          |  28 +++++++
> > >  tests/generic/362.out      |   2 +
> > >  5 files changed, 177 insertions(+), 1 deletion(-)
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
> > > index 00000000..72c23265
> > > --- /dev/null
> > > +++ b/src/dio-append-buf-fault.c
> > > @@ -0,0 +1,145 @@
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
> > > +static ssize_t do_write(int fd, const void *buf, size_t count)
> > > +{
> > > +        while (count > 0) {
> > > +             ssize_t ret;
> > > +
> > > +             ret = write(fd, buf, count);
> > > +             if (ret < 0) {
> > > +                     if (errno == EINTR)
> > > +                             continue;
> > > +                     return ret;
> > > +             }
> > > +             count -= ret;
> > > +             buf += ret;
> > > +     }
> > > +     return 0;
> > > +}
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
> > > +     ret = do_write(fd, buf, pagesize);
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
> > > +     /* Don't exit on failure so that we run the second test below too. */
> > > +     if (stbuf.st_size != pagesize)
> > > +             fprintf(stderr,
> > > +                     "Wrong file size after first write, got %jd expected %ld\n",
> > > +                     (intmax_t)stbuf.st_size, pagesize);
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
> > > +             return 7;
> > > +     }
> > > +
> > > +     buf = mmap(NULL, pagesize * 2, PROT_READ | PROT_WRITE,
> > > +                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> > > +     if (buf == MAP_FAILED) {
> > > +             perror("Failed to allocate second buffer");
> > > +             return 8;
> > > +     }
> > > +
> > > +     /* Fault in first page of the buffer before the write. */
> > > +     memset(buf, 0, 1);
> > > +
> > > +     ret = do_write(fd, buf, pagesize * 2);
> > > +     if (ret < 0) {
> > > +             perror("Second write failed");
> > > +             return 9;
> > > +     }
> > > +
> > > +     ret = fstat(fd, &stbuf);
> > > +     if (ret < 0) {
> > > +             perror("Second stat failed");
> > > +             return 10;
> > > +     }
> > > +
> > > +     if (stbuf.st_size != pagesize * 2)
> > > +             fprintf(stderr,
> > > +                     "Wrong file size after second write, got %jd expected %ld\n",
> > > +                     (intmax_t)stbuf.st_size, pagesize * 2);
> > > +
> > > +     munmap(buf, pagesize * 2);
> > > +     close(fd);
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/tests/generic/362 b/tests/generic/362
> > > new file mode 100755
> > > index 00000000..2c127347
> > > --- /dev/null
> > > +++ b/tests/generic/362
> > > @@ -0,0 +1,28 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 362
> > > +#
> > > +# Test that doing a direct IO append write to a file when the input buffer was
> > > +# not yet faulted in, does not result in an incorrect file size.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_require_test
> > > +_require_odirect
> > > +_require_test_program dio-append-buf-fault
> > > +
> > > +[ $FSTYP == "btrfs" ] && \
> > > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +     "btrfs: fix corruption after buffer fault in during direct IO append write"
> > > +
> > > +# On error the test program writes messages to stderr, causing a golden output
> > > +# mismatch and making the test fail.
> > > +$here/src/dio-append-buf-fault $TEST_DIR/dio-append-buf-fault
> > > +
> > > +# success, all done
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/362.out b/tests/generic/362.out
> > > new file mode 100644
> > > index 00000000..0ff40905
> > > --- /dev/null
> > > +++ b/tests/generic/362.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 362
> > > +Silence is golden
> > > --
> > > 2.43.0
> > >
> > >
> >
> 


