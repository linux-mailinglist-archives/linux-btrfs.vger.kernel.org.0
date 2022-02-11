Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF44B24CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243639AbiBKLw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 06:52:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiBKLw1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 06:52:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0BAF4F;
        Fri, 11 Feb 2022 03:52:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 277DA619D7;
        Fri, 11 Feb 2022 11:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0037C340E9;
        Fri, 11 Feb 2022 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644580345;
        bh=4zwyeQJidQ3BI796AmgpN4fFK6wFuAjitDXQc6T6ZiI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JKDDQIQ9xx1N+QMdza4vDZIWZr6yqMkZmBg50skUoGp3fnijrYlMzF/eLcNX89+3j
         EG+fiUIGFCnA39uQotBRSJjvmPPkxZ382dkRgPi8uKmZibQ8sfYoddk3tx5bV51VHp
         xP+nQ4cqiiWeToQYMtRmQrvLRPMEgktWMLKs22YQct0IgJjrNHHo/KLZizeDYYja4e
         E1nXhhld+ojEcq1yzLAaeJbRaFYASeJ6MN3v35VFEQzFR38ke7LhkXPblyOh+luZWB
         UrUU/nJ1c24jwe65NBjdCCQ8pXyPnkc8q8ZDUeg1QVeHZHtGC1hn//X5+Mi33GK2Ym
         23/cEYkJtewMw==
Date:   Fri, 11 Feb 2022 11:52:22 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: add test case to make sure autodefrag works even
 the extent maps are read from disk
Message-ID: <YgZN9up8fuOt894m@debian9.Home>
References: <20220208071427.19171-1-wqu@suse.com>
 <CAL3q7H5TSOMDpgP0FNbP_TqOgY_zjgsthjAo6iDnZS+g2FJk8w@mail.gmail.com>
 <08a1e4df-27b2-23e4-ec1d-1ba1c4fe7e2a@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a1e4df-27b2-23e4-ec1d-1ba1c4fe7e2a@gmx.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 11, 2022 at 08:01:24AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/2/11 00:37, Filipe Manana wrote:
> > On Tue, Feb 8, 2022 at 12:00 PM Qu Wenruo <wqu@suse.com> wrote:
> > > 
> > > There is a long existing problem that extent_map::generation is not
> > > populated (thus always 0) if its read from disk.
> > > 
> > > This can prevent btrfs autodefrag from working as it relies on
> > > extent_map::generation.
> > > If it's always 0, then autodefrag will not consider the range as a
> > > defrag target.
> > > 
> > > The test case itself will verify the behavior by:
> > > 
> > > - Create a fragmented file
> > >    By writing backwards with OSYNC
> > >    This will also queue the file for autodefrag.
> > > 
> > > - Drop all cache
> > >    Including the extent map cache, meaning later read will
> > >    all get extent map by reading from on-disk file extent items.
> > > 
> > > - Trigger autodefrag and verify the file layout
> > >    If defrag works, the new file layout should differ from the original
> > >    one.
> > > 
> > > The kernel fix is titled:
> > > 
> > >    btrfs: populate extent_map::generation when reading from disk
> > > 
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > ---
> > >   tests/btrfs/259     | 64 +++++++++++++++++++++++++++++++++++++++++++++
> > >   tests/btrfs/259.out |  2 ++
> > >   2 files changed, 66 insertions(+)
> > >   create mode 100755 tests/btrfs/259
> > >   create mode 100644 tests/btrfs/259.out
> > > 
> > > diff --git a/tests/btrfs/259 b/tests/btrfs/259
> > > new file mode 100755
> > > index 00000000..577e4ce4
> > > --- /dev/null
> > > +++ b/tests/btrfs/259
> > > @@ -0,0 +1,64 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> > > +#
> > > +# FS QA Test 259
> > > +#
> > > +# Make sure autodefrag can still defrag the file even their extent maps are
> > > +# read from disk
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick defrag
> > > +
> > > +# Override the default cleanup function.
> > > +# _cleanup()
> > > +# {
> > > +#      cd /
> > > +#      rm -r -f $tmp.*
> > > +# }
> > > +
> > > +# Import common functions.
> > > +# . ./common/filter
> > > +
> > > +# real QA test starts here
> > > +
> > > +# Modify as appropriate.
> > > +_supported_fs btrfs
> > > +_require_scratch
> > > +
> > > +# Need 4K sectorsize, as the autodefrag threshold is only 64K,
> > > +# thus 64K sectorsize will not work.
> > > +_require_btrfs_support_sectorsize 4096
> > 
> > Missing a:
> > 
> > _require_xfs_io_command fiemap
> > 
> > > +_scratch_mkfs -s 4k >> $seqres.full
> > > +_scratch_mount -o datacow,autodefrag
> > > +
> > > +# Create fragmented write
> > > +$XFS_IO_PROG -f -s -c "pwrite 24k 8k" -c "pwrite 16k 8k" \
> > > +               -c "pwrite 8k 8k" -c "pwrite 0 8k" \
> > > +               "$SCRATCH_MNT/foobar" >> $seqres.full
> > > +sync
> > 
> > A comment on why this sync is needed would be good to have.
> > It may be confusing to the reader since we were doing synchronous writes before.
> > 
> > > +
> > > +echo "=== Before autodefrag ===" >> $seqres.full
> > > +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.before
> > > +cat $tmp.before >> $seqres.full
> > > +
> > > +# Drop the cache (including extent map cache per-inode)
> > > +echo 3 > /proc/sys/vm/drop_caches
> > > +
> > > +# Now trigger autodefrag
> > 
> > A bit more explanation would be useful.
> > 
> > Set the commit interval to 1 second, so that 1 second after the
> > remount the transaction kthread runs
> > and wakes up the cleaner kthread, which in turn will run autodefrag.
> > 
> > > +_scratch_remount commit=1
> > > +sleep 3
> > > +sync
> > 
> > This sync is useless, so it should go away.
> 
> Autodefrag doesn't write data back at all.
> It just mark the target range dirty and wait for later writeback.
> 
> Thus sync is still needed AFAIK.

Well, something weird is going on then.

Removing the sync, makes the test still fail on an unpatched kernel,
and on a patched kernel, it still succeeds.

Looking at the .full file, the results are correct:

=== Before autodefrag ===
/home/fdmanana/btrfs-tests/scratch_1/foobar:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..15]:         26672..26687        16   0x0
   1: [16..31]:        26656..26671        16   0x0
   2: [32..47]:        26640..26655        16   0x0
   3: [48..63]:        26624..26639        16   0x1
=== After autodefrag ===
/home/fdmanana/btrfs-tests/scratch_1/foobar:
 EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
   0: [0..63]:         26688..26751        64   0x1

So why this worked seems to be because:

- After doing the writes to the file, a delayed iput on the inode
  did a wakeup on the cleaner kthread;

- The cleaner kthread ran defrag;

- btrfs_remount() calls sync_filesystem(), flushing all delalloc.

So, yes, it's better to leave the 'sync', as there's no way to
guarantee the cleaner ran defrag before remount.

Perhaps a comment about that sync would be useful as well.

Thanks.

> 
> Thanks,
> Qu
> 
> > 
> > Otherwise, it looks good and the test works as expected.
> > 
> > Thanks for doing it.
> > 
> > > +
> > > +echo "=== After autodefrag ===" >> $seqres.full
> > > +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $tmp.after
> > > +cat $tmp.after >> $seqres.full
> > > +
> > > +# The layout should differ if autodefrag is working
> > > +diff $tmp.before $tmp.after > /dev/null && echo "autodefrag didn't defrag the file"
> > > +
> > > +echo "Silence is golden"
> > > +
> > > +# success, all done
> > > +status=0
> > > +exit
> > > diff --git a/tests/btrfs/259.out b/tests/btrfs/259.out
> > > new file mode 100644
> > > index 00000000..bfbd2dea
> > > --- /dev/null
> > > +++ b/tests/btrfs/259.out
> > > @@ -0,0 +1,2 @@
> > > +QA output created by 259
> > > +Silence is golden
> > > --
> > > 2.34.1
> > > 
