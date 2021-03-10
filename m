Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59158333AA9
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Mar 2021 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbhCJKtT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Mar 2021 05:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhCJKss (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Mar 2021 05:48:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4FE064FE1;
        Wed, 10 Mar 2021 10:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615373327;
        bh=CXAea+wlNt15fXbg9tOUyElNV1gulmF3Y9SdyBxwJB4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZXRmSzgUAIY7+8HojJPQg6iNugAuxEHk8TShJRCYtyPKItF7vKRC34MqY3xCJ6KMR
         3VpjqzsQtEafy+pCHZiCrarYyEztuegEtp4QGP/N/LJDSiz4Gzcg93bVi1yENh6EgF
         1tgmZ4MIVh1XRJX2YR6N7OekfxVhriJUleIdWmHSfJj46PPj21fu05PQHgRJnuqBWG
         TnP69sLKVTmQi9LwYHN6vuWerekJ8YU/xS1bR8V4wmMgFAflVX+IFXIAAgSXyOesns
         a5Q7lxa0c99xrjEifK+BhUsP9hJ+HAzHcjh7+vfI/7szs47ZUH3e4eQhpFDdTS1psW
         Jn9a2Aa0Hvl3w==
Received: by mail-qk1-f171.google.com with SMTP id n79so16288966qke.3;
        Wed, 10 Mar 2021 02:48:47 -0800 (PST)
X-Gm-Message-State: AOAM530Q/ffb9RuYBqn3J33oGxtH8D4w3g2uf5fppf6WS1WF87n7TfnG
        ly+6psEjSY/Fl75wn8uvVLQxQ2RbvsmIlg6b2kI=
X-Google-Smtp-Source: ABdhPJyWq/jPMJsFuwfqR4jpredmA+0I2l0U4a6B8rWFukmkI09dmn3FP6QuNVb251mZNG/NJA8fLJn0aBiVqTNw1TY=
X-Received: by 2002:a05:620a:119a:: with SMTP id b26mr1974046qkk.438.1615373326595;
 Wed, 10 Mar 2021 02:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20210211170118.12551-1-fdmanana@kernel.org> <YETkzeWJTB2C88ON@desktop>
 <CAL3q7H7=M-OZqF9rbHKZKSdSOjic+=4X70aVeOPpLxGV9nKWZQ@mail.gmail.com> <YETvBOahTAtKvr7U@desktop>
In-Reply-To: <YETvBOahTAtKvr7U@desktop>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 10 Mar 2021 10:48:35 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5WrDkHwQBYGP-1XYY=9r1Vk0MD8HDsGsQJ9tZOxOY5aw@mail.gmail.com>
Message-ID: <CAL3q7H5WrDkHwQBYGP-1XYY=9r1Vk0MD8HDsGsQJ9tZOxOY5aw@mail.gmail.com>
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

On Sun, Mar 7, 2021 at 3:24 PM Eryu Guan <guan@eryu.me> wrote:
>
> On Sun, Mar 07, 2021 at 03:07:43PM +0000, Filipe Manana wrote:
> > On Sun, Mar 7, 2021 at 2:41 PM Eryu Guan <guan@eryu.me> wrote:
> > >
> > > On Thu, Feb 11, 2021 at 05:01:18PM +0000, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test cases where a direct IO write, with O_DSYNC, can not be done and has
> > > > to fallback to a buffered write.
> > > >
> > > > This is motivated by a regression that was introduced in kernel 5.10 by
> > > > commit 0eb79294dbe328 ("btrfs: dio iomap DSYNC workaround")) and was
> > > > fixed in kernel 5.11 by commit ecfdc08b8cc65d ("btrfs: remove dio iomap
> > > > DSYNC workaround").
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > >
> > > Sorry for the late review..
> > >
> > > So this is supposed to fail with v5.10 kernel, right? But I got it
> > > passed
> >
> > Because either you are testing with a patched 5.10.x kernel, or you
> > don't have CONFIG_BTRFS_ASSERT=y in your config.
> > The fix landed in 5.10.18:
>
> You're right, I don't have CONFIG_BTRFS_ASSERT=y. As the test dumps the
> od output of the file content, so I thought the failure would be a data
> corruption, and expected a od output diff failure.

I see the test was not merged yet, do you expect me to update anything
in the patch?

Thanks.

>
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v5.10.18&id=a6703c71153438d3ebdf58a75d53dd5e57b33095
> >
> > >
> > >   [root@fedoravm xfstests]# ./check -s btrfs btrfs/231
> > >   SECTION       -- btrfs
> > >   RECREATING    -- btrfs on /dev/mapper/testvg-lv1
> > >   FSTYP         -- btrfs
> > >   PLATFORM      -- Linux/x86_64 fedoravm 5.10.0 #6 SMP Sun Mar 7 22:25:35 CST 2021
> > >   MKFS_OPTIONS  -- /dev/mapper/testvg-lv2
> > >   MOUNT_OPTIONS -- /dev/mapper/testvg-lv2 /mnt/scratch
> > >
> > >   btrfs/231 13s ...  8s
> > >   Ran: btrfs/231
> > >   Passed all 1 tests
> > >
> > >   SECTION       -- btrfs
> > >   =========================
> > >   Ran: btrfs/231
> > >   Passed all 1 tests
> > >
> > > > ---
> > > >  tests/btrfs/231     | 61 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/btrfs/231.out | 21 ++++++++++++++++
> > > >  tests/btrfs/group   |  1 +
> > > >  3 files changed, 83 insertions(+)
> > > >  create mode 100755 tests/btrfs/231
> > > >  create mode 100644 tests/btrfs/231.out
> > > >
> > > > diff --git a/tests/btrfs/231 b/tests/btrfs/231
> > > > new file mode 100755
> > > > index 00000000..9a404f57
> > > > --- /dev/null
> > > > +++ b/tests/btrfs/231
> > > > @@ -0,0 +1,61 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> > > > +#
> > > > +# FS QA Test No. btrfs/231
> > > > +#
> > > > +# Test cases where a direct IO write, with O_DSYNC, can not be done and has to
> > > > +# fallback to a buffered write.
> > > > +#
> > > > +seq=`basename $0`
> > > > +seqres=$RESULT_DIR/$seq
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +tmp=/tmp/$$
> > > > +status=1     # failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +     cd /
> > > > +     rm -f $tmp.*
> > > > +}
> > > > +
> > > > +# get standard environment, filters and checks
> > > > +. ./common/rc
> > > > +. ./common/filter
> > > > +. ./common/attr
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_fs btrfs
> > > > +_require_scratch
> > > > +_require_odirect
> > > > +_require_chattr c
> > > > +
> > > > +rm -f $seqres.full
> > > > +
> > > > +_scratch_mkfs >>$seqres.full 2>&1
> > > > +_scratch_mount
> > > > +
> > > > +# First lets test with an attempt to write into a file range with compressed
> > > > +# extents.
> > > > +touch $SCRATCH_MNT/foo
> > > > +$CHATTR_PROG +c $SCRATCH_MNT/foo
> > >
> > > It's not so clear to me why writing into a compressed file is required,
> > > would you please add more comments?
> >
> > The test is meant to test cases where we can deterministically make a
> > direct IO write fallback to buffered IO.
> > There are 2 such cases:
> >
> > 1) Attempting to write to an unaligned offset - this was the bug in
> > 5.10 that resulted in a crash when CONFIG_BTRFS_ASSERT=y (default in
> > many distros, such as openSUSE).
> >
> > 2) Writing to a range that has compressed extents. This has nothing to
> > do with the 5.10 regression, I just added it since there's no existing
> > test that explicitly and deterministically triggers this.
> >     So yes, I decided to add a test case for all possible cases of
> > direct IO falling back to buffered instead of adding one just to test
> > a regression (and help detecting any possible future regressions).
>
> Sounds good, thanks!
>
> Eryu
