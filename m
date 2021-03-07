Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE21533029C
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Mar 2021 16:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbhCGPUF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Mar 2021 10:20:05 -0500
Received: from out20-27.mail.aliyun.com ([115.124.20.27]:52472 "EHLO
        out20-27.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbhCGPTh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 7 Mar 2021 10:19:37 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07446809|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.293283-0.00204427-0.704673;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.JhcltBe_1615130372;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JhcltBe_1615130372)
          by smtp.aliyun-inc.com(10.147.41.199);
          Sun, 07 Mar 2021 23:19:32 +0800
Date:   Sun, 7 Mar 2021 23:19:32 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: add test for cases when a dio write has to
 fallback to a buffered write
Message-ID: <YETvBOahTAtKvr7U@desktop>
References: <20210211170118.12551-1-fdmanana@kernel.org>
 <YETkzeWJTB2C88ON@desktop>
 <CAL3q7H7=M-OZqF9rbHKZKSdSOjic+=4X70aVeOPpLxGV9nKWZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H7=M-OZqF9rbHKZKSdSOjic+=4X70aVeOPpLxGV9nKWZQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 07, 2021 at 03:07:43PM +0000, Filipe Manana wrote:
> On Sun, Mar 7, 2021 at 2:41 PM Eryu Guan <guan@eryu.me> wrote:
> >
> > On Thu, Feb 11, 2021 at 05:01:18PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test cases where a direct IO write, with O_DSYNC, can not be done and has
> > > to fallback to a buffered write.
> > >
> > > This is motivated by a regression that was introduced in kernel 5.10 by
> > > commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")) and was
> > > fixed in kernel 5.11 by commit ecfdc08b8cc65d ("btrfs: remove dio iomap
> > > DSYNC workaround").
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> >
> > Sorry for the late review..
> >
> > So this is supposed to fail with v5.10 kernel, right? But I got it
> > passed
> 
> Because either you are testing with a patched 5.10.x kernel, or you
> don't have CONFIG_BTRFS_ASSERT=y in your config.
> The fix landed in 5.10.18:

You're right, I don't have CONFIG_BTRFS_ASSERT=y. As the test dumps the
od output of the file content, so I thought the failure would be a data
corruption, and expected a od output diff failure.

> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.18&id=a6703c71153438d3ebdf58a75d53dd5e57b33095
> 
> >
> >   [root@fedoravm xfstests]# ./check -s btrfs btrfs/231
> >   SECTION       -- btrfs
> >   RECREATING    -- btrfs on /dev/mapper/testvg-lv1
> >   FSTYP         -- btrfs
> >   PLATFORM      -- Linux/x86_64 fedoravm 5.10.0 #6 SMP Sun Mar 7 22:25:35 CST 2021
> >   MKFS_OPTIONS  -- /dev/mapper/testvg-lv2
> >   MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch
> >
> >   btrfs/231 13s ...  8s
> >   Ran: btrfs/231
> >   Passed all 1 tests
> >
> >   SECTION       -- btrfs
> >   =========================
> >   Ran: btrfs/231
> >   Passed all 1 tests
> >
> > > ---
> > >  tests/btrfs/231     | 61 +++++++++++++++++++++++++++++++++++++++++++++
> > >  tests/btrfs/231.out | 21 ++++++++++++++++
> > >  tests/btrfs/group   |  1 +
> > >  3 files changed, 83 insertions(+)
> > >  create mode 100755 tests/btrfs/231
> > >  create mode 100644 tests/btrfs/231.out
> > >
> > > diff --git a/tests/btrfs/231 b/tests/btrfs/231
> > > new file mode 100755
> > > index 00000000..9a404f57
> > > --- /dev/null
> > > +++ b/tests/btrfs/231
> > > @@ -0,0 +1,61 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test No. btrfs/231
> > > +#
> > > +# Test cases where a direct IO write, with O_DSYNC, can not be done and has to
> > > +# fallback to a buffered write.
> > > +#
> > > +seq=`basename $0`
> > > +seqres=$RESULT_DIR/$seq
> > > +echo "QA output created by $seq"
> > > +
> > > +tmp=/tmp/$$
> > > +status=1     # failure is the default!
> > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > +
> > > +_cleanup()
> > > +{
> > > +     cd /
> > > +     rm -f $tmp.*
> > > +}
> > > +
> > > +# get standard environment, filters and checks
> > > +. ./common/rc
> > > +. ./common/filter
> > > +. ./common/attr
> > > +
> > > +# real QA test starts here
> > > +_supported_fs btrfs
> > > +_require_scratch
> > > +_require_odirect
> > > +_require_chattr c
> > > +
> > > +rm -f $seqres.full
> > > +
> > > +_scratch_mkfs >>$seqres.full 2>&1
> > > +_scratch_mount
> > > +
> > > +# First lets test with an attempt to write into a file range with compressed
> > > +# extents.
> > > +touch $SCRATCH_MNT/foo
> > > +$CHATTR_PROG +c $SCRATCH_MNT/foo
> >
> > It's not so clear to me why writing into a compressed file is required,
> > would you please add more comments?
> 
> The test is meant to test cases where we can deterministically make a
> direct IO write fallback to buffered IO.
> There are 2 such cases:
> 
> 1) Attempting to write to an unaligned offset - this was the bug in
> 5.10 that resulted in a crash when CONFIG_BTRFS_ASSERT=y (default in
> many distros, such as openSUSE).
> 
> 2) Writing to a range that has compressed extents. This has nothing to
> do with the 5.10 regression, I just added it since there's no existing
> test that explicitly and deterministically triggers this.
>     So yes, I decided to add a test case for all possible cases of
> direct IO falling back to buffered instead of adding one just to test
> a regression (and help detecting any possible future regressions).

Sounds good, thanks!

Eryu
