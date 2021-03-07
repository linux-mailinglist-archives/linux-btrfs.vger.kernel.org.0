Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84373330275
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Mar 2021 16:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCGPH4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 10:07:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229753AbhCGPH4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Mar 2021 10:07:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE4464FC2;
        Sun,  7 Mar 2021 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615129675;
        bh=RjjYG02TtHbDejkI/BiQrQV0lcBh5zssJOg3QFCPDVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CHhF60m6VQXbBhVtEWwsti0f19Q+0DoTgLbn3YSIQmVYun1G0sqY5IdhkGL3J2s9k
         MeNbP69EO9dfLkIUF69YBzFFRbk1HruvHiRYpBNb8tDf+QbEIpL4qSroJeVlEVh2pq
         DBbI763aE7P3yjo6cr7anHpY89AT3Ln/rPIGMMyNV/89JjIiA7c/elZ2EUiUHhU+zr
         6Gz8E2HQaNcr2apNGeXoryanaMBP0N6ZpKQu9m2Zn5kVXl5AcrzqIPKXRYmd58c3TS
         /CL7PBRl5sAd517ouo2UKcCelM1PCyUjOt5d4SVfiMizkx9VDFFiKQbKNR0f7byN96
         15R8S4I05E6IQ==
Received: by mail-qk1-f177.google.com with SMTP id g185so6922161qkf.6;
        Sun, 07 Mar 2021 07:07:55 -0800 (PST)
X-Gm-Message-State: AOAM531hTjEz859tsSSZNhHPOg4X3z3LdEUSJCth45h1NGZj+/nPi+ul
        p3Xx89T7ndxvIvn/6BT8dPqEn8MjD+84uXRX6fw=
X-Google-Smtp-Source: ABdhPJx38e/L0u86Yjnp9kyeTpIJA845LgD8xUcDYc/SSjbT+LqTyDuU5Jy4Zwrz7qDxMae/PCPL+cznh2ZN5FLaI68=
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr17340616qke.383.1615129674802;
 Sun, 07 Mar 2021 07:07:54 -0800 (PST)
MIME-Version: 1.0
References: <20210211170118.12551-1-fdmanana@kernel.org> <YETkzeWJTB2C88ON@desktop>
In-Reply-To: <YETkzeWJTB2C88ON@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sun, 7 Mar 2021 15:07:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7=M-OZqF9rbHKZKSdSOjic+=4X70aVeOPpLxGV9nKWZQ@mail.gmail.com>
Message-ID: <CAL3q7H7=M-OZqF9rbHKZKSdSOjic+=4X70aVeOPpLxGV9nKWZQ@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add test for cases when a dio write has to
 fallback to a buffered write
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 7, 2021 at 2:41 PM Eryu Guan <guan@eryu.me> wrote:
>
> On Thu, Feb 11, 2021 at 05:01:18PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test cases where a direct IO write, with O_DSYNC, can not be done and has
> > to fallback to a buffered write.
> >
> > This is motivated by a regression that was introduced in kernel 5.10 by
> > commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")) and was
> > fixed in kernel 5.11 by commit ecfdc08b8cc65d ("btrfs: remove dio iomap
> > DSYNC workaround").
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> Sorry for the late review..
>
> So this is supposed to fail with v5.10 kernel, right? But I got it
> passed

Because either you are testing with a patched 5.10.x kernel, or you
don't have CONFIG_BTRFS_ASSERT=y in your config.
The fix landed in 5.10.18:

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.18&id=a6703c71153438d3ebdf58a75d53dd5e57b33095

>
>   [root@fedoravm xfstests]# ./check -s btrfs btrfs/231
>   SECTION       -- btrfs
>   RECREATING    -- btrfs on /dev/mapper/testvg-lv1
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 fedoravm 5.10.0 #6 SMP Sun Mar 7 22:25:35 CST 2021
>   MKFS_OPTIONS  -- /dev/mapper/testvg-lv2
>   MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch
>
>   btrfs/231 13s ...  8s
>   Ran: btrfs/231
>   Passed all 1 tests
>
>   SECTION       -- btrfs
>   =========================
>   Ran: btrfs/231
>   Passed all 1 tests
>
> > ---
> >  tests/btrfs/231     | 61 +++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/231.out | 21 ++++++++++++++++
> >  tests/btrfs/group   |  1 +
> >  3 files changed, 83 insertions(+)
> >  create mode 100755 tests/btrfs/231
> >  create mode 100644 tests/btrfs/231.out
> >
> > diff --git a/tests/btrfs/231 b/tests/btrfs/231
> > new file mode 100755
> > index 00000000..9a404f57
> > --- /dev/null
> > +++ b/tests/btrfs/231
> > @@ -0,0 +1,61 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test No. btrfs/231
> > +#
> > +# Test cases where a direct IO write, with O_DSYNC, can not be done and has to
> > +# fallback to a buffered write.
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +tmp=/tmp/$$
> > +status=1     # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs btrfs
> > +_require_scratch
> > +_require_odirect
> > +_require_chattr c
> > +
> > +rm -f $seqres.full
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1
> > +_scratch_mount
> > +
> > +# First lets test with an attempt to write into a file range with compressed
> > +# extents.
> > +touch $SCRATCH_MNT/foo
> > +$CHATTR_PROG +c $SCRATCH_MNT/foo
>
> It's not so clear to me why writing into a compressed file is required,
> would you please add more comments?

The test is meant to test cases where we can deterministically make a
direct IO write fallback to buffered IO.
There are 2 such cases:

1) Attempting to write to an unaligned offset - this was the bug in
5.10 that resulted in a crash when CONFIG_BTRFS_ASSERT=y (default in
many distros, such as openSUSE).

2) Writing to a range that has compressed extents. This has nothing to
do with the 5.10 regression, I just added it since there's no existing
test that explicitly and deterministically triggers this.
    So yes, I decided to add a test case for all possible cases of
direct IO falling back to buffered instead of adding one just to test
a regression (and help detecting any possible future regressions).

Thanks.

>
> Thanks,
> Eryu
>
> > +
> > +$XFS_IO_PROG -s -c "pwrite -S 0xab -b 1M 0 1M" $SCRATCH_MNT/foo | _filter_xfs_io
> > +# Now do the direct IO write...
> > +$XFS_IO_PROG -d -s -c "pwrite -S 0xcd 512K 512K" $SCRATCH_MNT/foo | _filter_xfs_io
> > +
> > +# Now try doing a write into an unaligned offset...
> > +$XFS_IO_PROG -f -d -s -c "pwrite -S 0xef 1111 512K" $SCRATCH_MNT/bar | _filter_xfs_io
> > +
> > +# Unmount, mount again, and verify we have the expected data.
> > +_scratch_cycle_mount
> > +
> > +echo "File foo data:"
> > +od -A d -t x1 $SCRATCH_MNT/foo
> > +echo "File bar data:"
> > +od -A d -t x1 $SCRATCH_MNT/bar
> > +
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/231.out b/tests/btrfs/231.out
> > new file mode 100644
> > index 00000000..def05769
> > --- /dev/null
> > +++ b/tests/btrfs/231.out
> > @@ -0,0 +1,21 @@
> > +QA output created by 231
> > +wrote 1048576/1048576 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 524288/524288 bytes at offset 524288
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 524288/524288 bytes at offset 1111
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +File foo data:
> > +0000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab
> > +*
> > +0524288 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> > +*
> > +1048576
> > +File bar data:
> > +0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > +*
> > +0001104 00 00 00 00 00 00 00 ef ef ef ef ef ef ef ef ef
> > +0001120 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef
> > +*
> > +0525392 ef ef ef ef ef ef ef
> > +0525399
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index a7c65983..9f63db69 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -233,3 +233,4 @@
> >  228 auto quick volume
> >  229 auto quick send clone
> >  230 auto quick qgroup limit
> > +231 auto quick compress rw
> > --
> > 2.28.0
