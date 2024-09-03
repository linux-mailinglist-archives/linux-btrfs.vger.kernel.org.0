Return-Path: <linux-btrfs+bounces-7759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0818B9692CA
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 06:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB71F22830
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 04:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507E1CEAA4;
	Tue,  3 Sep 2024 04:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7LK08KS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB651CDFDA
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Sep 2024 04:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725336558; cv=none; b=tiCSQ038BbBnx8XrT85d7nvS1iEyywqpbkJAX96OM0x4v0EXVjKFxZ8L88QVq1iCxS/9It6ZfSPbhh5+JD9xKNC57/8H4+FpMFHm7j4/3e14lftUkkboRqQDa2ztid3QhTGmXfKSlSj8PRi3VCmIhL6fXsEyBbXav3inC1CoVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725336558; c=relaxed/simple;
	bh=8Bb01NF1ZECa8pxv856wVUK9wWk3RmdGHVYcjTybC5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpWPOjZ3JHA3r7d7fslLZXYtyMJ+P/X8eRLS3ZIZ44Z0+W8a6L6L747l3HYbQ++SVLI5uB5LRjaYMwyudJeRvc4zO2TIRW3Nff9cqWxvK9t9S7Wy8RLaG5areE/Gu1zGryj4OjqbgW9dbkW6ltVITG2d/4uwNrC6Kboqff0zWKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7LK08KS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725336554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BCfrdgXs6Fn3yoPOJTpCUXmQyU6VwB26tRa092a10aY=;
	b=L7LK08KSYskDgp5/bpFcTGbijobQQ281LMaF28O/00c3Kdf0oeJwO/hzYHCnCulvqC7vub
	9YDhS4us/GPm7wMWdEIVrfqLiKA+H567VeL73AV3DczN52TEgBZyaw+mMXU8pLhiJpYtZv
	tJlHtugXTajRxe0mnIdCgPOpxk5GTyM=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-8kDpGISnMGO7j4zfnhvqTQ-1; Tue, 03 Sep 2024 00:09:12 -0400
X-MC-Unique: 8kDpGISnMGO7j4zfnhvqTQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7106fcb5543so3090789b3a.2
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 21:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725336551; x=1725941351;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BCfrdgXs6Fn3yoPOJTpCUXmQyU6VwB26tRa092a10aY=;
        b=ZEfhJz/BJTQIKiRzGc7IxGpYA2dpcNoRec6zXipNqACj+2yW61xCfP1YodbP3YAnfN
         bm1R6Vd4wVKLPd9gde25MYqdFkzGYayoETpBcAXQF12znfvgvhqSd+Pct9H1h3Mqk+Ck
         Fyz6Qsl6XbYs62Pq1ozoWsvTGE3maJao9ig7AbF87aumgY2qggC5z/r9jBK+zKTJTwAA
         2aIRzLq8uNAoaIZLR/PEDaOdPvNqZhb9uCteReW+DC2Q+cy8rCtWH9QAd7wJt1U+724N
         2GW6YojNEqSLVxEd0Evf20m5+l3apQrw/XM7HmoGiS3OL76lJWuOt6kIuBh04aHMVwNn
         RLSw==
X-Forwarded-Encrypted: i=1; AJvYcCULPzFd8eT+7M++tgxG3BzJINNqsVzscs4J30XXPkiL63jMdiKOVA3IEE4ZHhqp0lo+AO676vDICQxyAg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqMIknWOx74Op9k4GG2UFiwVGa/3Iis2GyssEVyAzWSZiepMZ
	pCwjH3C/OIXddpb4Ac59IEx4rSkWZLxHdo39yaSiD+ee/B1u663NSrXO540svYuGU8BgWR08TlY
	gKnFx8RFJPZku1dlW2xNiQbx2LiIZCr/NWzTXzWzNUKjiJYUMOSOequ1b1rz8GqXCfjw/JPc=
X-Received: by 2002:a05:6a21:9207:b0:1ca:cdba:2121 with SMTP id adf61e73a8af0-1cce100b45dmr15095919637.14.1725336551461;
        Mon, 02 Sep 2024 21:09:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwdk5N3i0nkohaCQch2C3AfOPhSEZ87ZTFpcsb8Xgq1cd4clUa+V8vuQaby8Au2gm+cXf25A==
X-Received: by 2002:a05:6a21:9207:b0:1ca:cdba:2121 with SMTP id adf61e73a8af0-1cce100b45dmr15095885637.14.1725336550590;
        Mon, 02 Sep 2024 21:09:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2da64b07d5esm321284a91.47.2024.09.02.21.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 21:09:10 -0700 (PDT)
Date: Tue, 3 Sep 2024 12:09:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic: test concurrent direct IO writes and fsync
 using same fd
Message-ID: <20240903040907.gqfprq4ul6x7s2kt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <fa20c58b1a711d9da9899b895a5237f8737163af.1724972803.git.fdmanana@suse.com>
 <20240902202856.e5mqgsbwmiwxs4qe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H7vDpoG=k55yh9rJQWw=sit5fMkjPZMpVfwf7629b_hsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7vDpoG=k55yh9rJQWw=sit5fMkjPZMpVfwf7629b_hsA@mail.gmail.com>

On Mon, Sep 02, 2024 at 10:45:33PM +0100, Filipe Manana wrote:
> On Mon, Sep 2, 2024 at 9:29 PM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Fri, Aug 30, 2024 at 12:10:21AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that a program that has 2 threads using the same file descriptor and
> > > concurrently doing direct IO writes and fsync doesn't trigger any crash
> > > or deadlock.
> > >
> > > This is motivated by a bug found in btrfs fixed by the following patch:
> > >
> > >   "btrfs: fix race between direct IO write and fsync when using same fd"
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  .gitignore                    |   1 +
> > >  src/Makefile                  |   2 +-
> > >  src/dio-write-fsync-same-fd.c | 106 ++++++++++++++++++++++++++++++++++
> > >  tests/generic/363             |  30 ++++++++++
> > >  tests/generic/363.out         |   2 +
> > >  5 files changed, 140 insertions(+), 1 deletion(-)
> > >  create mode 100644 src/dio-write-fsync-same-fd.c
> > >  create mode 100755 tests/generic/363
> > >  create mode 100644 tests/generic/363.out
> > >
> > > diff --git a/.gitignore b/.gitignore
> > > index 36083e9d..57519263 100644
> > > --- a/.gitignore
> > > +++ b/.gitignore
> > > @@ -76,6 +76,7 @@ tags
> > >  /src/dio-buf-fault
> > >  /src/dio-interleaved
> > >  /src/dio-invalidate-cache
> > > +/src/dio-write-fsync-same-fd
> > >  /src/dirhash_collide
> > >  /src/dirperf
> > >  /src/dirstress
> > > diff --git a/src/Makefile b/src/Makefile
> > > index b3da59a0..b9ad6b5f 100644
> > > --- a/src/Makefile
> > > +++ b/src/Makefile
> > > @@ -20,7 +20,7 @@ TARGETS = dirstress fill fill2 getpagesize holes lstat64 \
> > >       t_get_file_time t_create_short_dirs t_create_long_dirs t_enospc \
> > >       t_mmap_writev_overlap checkpoint_journal mmap-rw-fault allocstale \
> > >       t_mmap_cow_memory_failure fake-dump-rootino dio-buf-fault rewinddir-test \
> > > -     readdir-while-renames dio-append-buf-fault
> > > +     readdir-while-renames dio-append-buf-fault dio-write-fsync-same-fd
> > >
> > >  LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
> > >       preallo_rw_pattern_writer ftrunc trunc fs_perms testx looptest \
> > > diff --git a/src/dio-write-fsync-same-fd.c b/src/dio-write-fsync-same-fd.c
> > > new file mode 100644
> > > index 00000000..79472a9e
> > > --- /dev/null
> > > +++ b/src/dio-write-fsync-same-fd.c
> > > @@ -0,0 +1,106 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2024 SUSE Linux Products GmbH.  All Rights Reserved.
> > > + */
> > > +
> > > +/*
> > > + * Test two threads working with the same file descriptor, one doing direct IO
> > > + * writes into the file and the other just doing fsync calls. We want to verify
> > > + * that there are no crashes or deadlocks.
> > > + *
> > > + * This program never finishes, it starts two infinite loops to write and fsync
> > > + * the file. It's meant to be called with the 'timeout' program from coreutils.
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
> > > +#include <pthread.h>
> > > +
> > > +static int fd;
> > > +
> > > +static ssize_t do_write(int fd, const void *buf, size_t count, off_t offset)
> > > +{
> > > +        while (count > 0) {
> > > +             ssize_t ret;
> > > +
> > > +             ret = pwrite(fd, buf, count, offset);
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
> > > +static void *fsync_loop(void *arg)
> > > +{
> > > +     while (1) {
> > > +             int ret;
> > > +
> > > +             ret = fsync(fd);
> > > +             if (ret != 0) {
> > > +                     perror("Fsync failed");
> > > +                     exit(6);
> > > +             }
> > > +     }
> > > +}
> > > +
> > > +int main(int argc, char *argv[])
> > > +{
> > > +     long pagesize;
> > > +     void *write_buf;
> > > +     pthread_t fsyncer;
> > > +     int ret;
> > > +
> > > +     if (argc != 2) {
> > > +             fprintf(stderr, "Use: %s <file path>\n", argv[0]);
> > > +             return 1;
> > > +     }
> > > +
> > > +     fd = open(argv[1], O_WRONLY | O_CREAT | O_TRUNC | O_DIRECT, 0666);
> > > +     if (fd == -1) {
> > > +             perror("Failed to open/create file");
> > > +             return 1;
> > > +     }
> > > +
> > > +     pagesize = sysconf(_SC_PAGE_SIZE);
> > > +     if (pagesize == -1) {
> > > +             perror("Failed to get page size");
> > > +             return 2;
> > > +     }
> > > +
> > > +     ret = posix_memalign(&write_buf, pagesize, pagesize);
> > > +     if (ret) {
> > > +             perror("Failed to allocate buffer");
> > > +             return 3;
> > > +     }
> > > +
> > > +     ret = pthread_create(&fsyncer, NULL, fsync_loop, NULL);
> > > +     if (ret != 0) {
> > > +             fprintf(stderr, "Failed to create writer thread: %d\n", ret);
> > > +             return 4;
> > > +     }
> > > +
> > > +     while (1) {
> > > +             ret = do_write(fd, write_buf, pagesize, 0);
> > > +             if (ret != 0) {
> > > +                     perror("Write failed");
> > > +                     exit(5);
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > diff --git a/tests/generic/363 b/tests/generic/363
> > > new file mode 100755
> > > index 00000000..21159e24
> > > --- /dev/null
> > > +++ b/tests/generic/363
> > > @@ -0,0 +1,30 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 363
> > > +#
> > > +# Test that a program that has 2 threads using the same file descriptor and
> > > +# concurrently doing direct IO writes and fsync doesn't trigger any crash or
> > > +# deadlock.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick
> > > +
> > > +_require_test
> > > +_require_odirect
> > > +_require_test_program dio-write-fsync-same-fd
> > > +_require_command "$TIMEOUT_PROG" timeout
> > > +
> > > +[ $FSTYP == "btrfs" ] && \
> > > +     _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +     "btrfs: fix race between direct IO write and fsync when using same fd"
> > > +
> > > +# On error the test program writes messages to stderr, causing a golden output
> > > +# mismatch and making the test fail.
> > > +$TIMEOUT_PROG 10s $here/src/dio-write-fsync-same-fd $TEST_DIR/dio-write-fsync-same-fd
> >
> > Hi Filipe,
> >
> > Thanks for this new test case. How reproducible is this test? I tried to run it on
> > a linux v6.11-rc3+ without above kernel fix, but test passed. Does this reproducer
> > need some specical test conditions?
> 
> It's a race condition so it may not trigger so easily in every machine.
> 
> In my box it takes less than 1 second, so I left the timeout in the
> test at 10s. You can try to increase that, say, 30 seconds, 60 seconds
> and see if it triggers.
> Don't know what distro you are using, but make sure that the kernel
> config has CONFIG_BTRFS_ASSERT=y, which is a default in some distros
> like SUSE ones.
> 
> When the test fails it should have a trace like this in dmesg:

Oh, so this test depends on CONFIG_BTRFS_ASSERT=y, or it always test passed? I tested
on general kernel of fedora 42, which doesn't enable this config.

There's a _require_xfs_debug helper in common/xfs (and _require_no_xfs_debug
too), does btrfs have similar method to check that?

Thanks,
Zorro

> 
> [362164.748435] run fstests generic/363 at 2024-09-02 22:40:19
> [362165.667172] assertion failed: inode_is_locked(&inode->vfs_inode),
> in fs/btrfs/ordered-data.c:1018
> [362165.668629] ------------[ cut here ]------------
> [362165.669542] kernel BUG at fs/btrfs/ordered-data.c:1018!
> [362165.670902] Oops: invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [362165.682061] CPU: 3 UID: 0 PID: 3687221 Comm: dio-write-fsync Not
> tainted 6.11.0-rc5-btrfs-next-172+ #1
> [362165.684672] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
> [362165.687682] RIP:
> 0010:btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> [362165.689592] Code: 00 e8 22 3a ac e3 e9 1b ff ff ff b9 fa 03 00 00
> 48 c7 c2 61 39 e3 c0 48 c7 c6 20 d1 e3 c0 48 c7 c7 30 cf e3 c0 e8 de
> 10 64 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
> 90 90
> [362165.693968] RSP: 0018:ffffb9f1c264fe20 EFLAGS: 00010246
> [362165.694959] RAX: 0000000000000055 RBX: ffff962c3d01bd88 RCX:
> 0000000000000000
> [362165.696778] RDX: 0000000000000000 RSI: ffffffffa544b924 RDI:
> 00000000ffffffff
> [362165.698751] RBP: ffff962b5da07f00 R08: 0000000000000000 R09:
> ffffb9f1c264fc68
> [362165.700707] R10: 0000000000000001 R11: 0000000000000001 R12:
> ffff962c3d01bc00
> [362165.702273] R13: ffff962b215af800 R14: 0000000000000001 R15:
> 0000000000000000
> [362165.704168] FS:  00007fe3630006c0(0000) GS:ffff962e2fac0000(0000)
> knlGS:0000000000000000
> [362165.706002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [362165.707258] CR2: 00007fe362ffff78 CR3: 00000002a3f5e005 CR4:
> 0000000000370ef0
> [362165.708844] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [362165.710344] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [362165.711926] Call Trace:
> [362165.712563]  <TASK>
> [362165.713122]  ? __die_body+0x1b/0x60
> [362165.713933]  ? die+0x39/0x60
> [362165.714648]  ? do_trap+0xe4/0x110
> [362165.715466]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> [362165.717253]  ? do_error_trap+0x6a/0x90
> [362165.718257]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> [362165.720057]  ? exc_invalid_op+0x4e/0x70
> [362165.721062]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> [362165.722822]  ? asm_exc_invalid_op+0x16/0x20
> [362165.723934]  ? btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> [362165.725751]  btrfs_sync_file+0x227/0x510 [btrfs]
> [362165.726923]  do_fsync+0x38/0x70
> [362165.727732]  __x64_sys_fsync+0x10/0x20
> [362165.728679]  do_syscall_64+0x4a/0x110
> [362165.729642]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [362165.730741] RIP: 0033:0x7fe36315397a
> [362165.731598] Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00
> 48 83 ec 18 89 7c 24 0c e8 b3 49 f8 ff 8b 7c 24 0c 89 c2 b8 4a 00 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 13 4a f8 ff 8b
> 44 24
> [362165.735846] RSP: 002b:00007fe362fffeb0 EFLAGS: 00000293 ORIG_RAX:
> 000000000000004a
> [362165.737208] RAX: ffffffffffffffda RBX: 00007fe363000cdc RCX:
> 00007fe36315397a
> [362165.738763] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000003
> [362165.740062] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 00007fe3630006c0
> [362165.741463] R10: 00007fe363067400 R11: 0000000000000293 R12:
> ffffffffffffff88
> [362165.743280] R13: 0000000000000000 R14: 00007fffaa292c10 R15:
> 00007fe362800000
> [362165.744494]  </TASK>
> [362165.744954] Modules linked in: btrfs xfs dm_zero dm_snapshot
> dm_thin_pool dm_persistent_data dm_bio_prison dm_bufio dm_log_writes
> dm_dust dm_flakey dm_mod loop blake2b_generic xor raid6_pq libcrc32c
> overlay intel_rapl_msr intel_rapl_common crct10dif_pclmul
> ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 aesni_intel
> gf128mul crypto_simd cryptd bochs rapl drm_vram_helper drm_ttm_helper
> ttm input_leds led_class drm_kms_helper pcspkr sg button evdev
> serio_raw qemu_fw_cfg binfmt_misc drm ip_tables x_tables autofs4 ext4
> crc32c_generic crc16 mbcache jbd2 sd_mod virtio_net net_failover
> virtio_scsi failover ata_generic ata_piix libata crc32_pclmul scsi_mod
> crc32c_intel virtio_pci virtio psmouse virtio_pci_legacy_dev i2c_piix4
> virtio_pci_modern_dev virtio_ring i2c_smbus scsi_common [last
> unloaded: btrfs]
> [362165.756697] ---[ end trace 0000000000000000 ]---
> [362165.757582] RIP:
> 0010:btrfs_get_ordered_extents_for_logging+0x1a2/0x1b0 [btrfs]
> [362165.758955] Code: 00 e8 22 3a ac e3 e9 1b ff ff ff b9 fa 03 00 00
> 48 c7 c2 61 39 e3 c0 48 c7 c6 20 d1 e3 c0 48 c7 c7 30 cf e3 c0 e8 de
> 10 64 e3 <0f> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
> 90 90
> [362165.762283] RSP: 0018:ffffb9f1c264fe20 EFLAGS: 00010246
> [362165.763164] RAX: 0000000000000055 RBX: ffff962c3d01bd88 RCX:
> 0000000000000000
> [362165.764414] RDX: 0000000000000000 RSI: ffffffffa544b924 RDI:
> 00000000ffffffff
> [362165.765774] RBP: ffff962b5da07f00 R08: 0000000000000000 R09:
> ffffb9f1c264fc68
> [362165.767001] R10: 0000000000000001 R11: 0000000000000001 R12:
> ffff962c3d01bc00
> [362165.768223] R13: ffff962b215af800 R14: 0000000000000001 R15:
> 0000000000000000
> [362165.769369] FS:  00007fe3630006c0(0000) GS:ffff962e2fac0000(0000)
> knlGS:0000000000000000
> [362165.771117] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [362165.772435] CR2: 00007fe362ffff78 CR3: 00000002a3f5e005 CR4:
> 0000000000370ef0
> [362165.773934] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [362165.775357] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> 
> 
> >
> >   # ./check -s default generic/363
> >   SECTION       -- default
> >   FSTYP         -- btrfs
> >   PLATFORM      -- Linux/x86_64 dell-xxxxx-xx 6.11.0-0.rc3.20240814git6b0f8db921ab.32.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Aug 14 16:46:57 UTC 2024
> >   MKFS_OPTIONS  -- /dev/sda6
> >   MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/sda6 /mnt/scratch
> >
> >   generic/363 10s ...  10s
> >   Ran: generic/363
> >   Passed all 1 test
> >
> > Thanks,
> > Zorro
> >
> > > +
> > > +# success, all done
> > > +echo "Silence is golden"
> > > +status=0
> > > +exit
> > > diff --git a/tests/generic/363.out b/tests/generic/363.out
> > > new file mode 100644
> > > index 00000000..d03d2dc2
> > > --- /dev/null
> > > +++ b/tests/generic/363.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 363
> > > +Silence is golden
> > > --
> > > 2.43.0
> > >
> > >
> >
> 


