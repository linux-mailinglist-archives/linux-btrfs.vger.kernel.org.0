Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0E7E48A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 12:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392704AbfJYKht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 06:37:49 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:47660 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730471AbfJYKht (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 06:37:49 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Tg9T3he_1571999863;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0Tg9T3he_1571999863)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 18:37:43 +0800
Date:   Fri, 25 Oct 2019 18:37:43 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] fstests: btrfs: Test if btrfs can trim adjacent extents
 across adjacent block groups boundary
Message-ID: <20191025103743.GH67926@e18g06458.et15sqa>
References: <20191024101629.33807-1-wqu@suse.com>
 <CAL3q7H4HkuhY-pKcJzCXLRK08gJec=ZT_NqFFRTXagbZ5xmdYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4HkuhY-pKcJzCXLRK08gJec=ZT_NqFFRTXagbZ5xmdYA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 11:11:37AM +0100, Filipe Manana wrote:
> On Fri, Oct 25, 2019 at 7:59 AM Qu Wenruo <wqu@suse.com> wrote:
> >
> > The test case checks if btrfs can trim adjacent extents across adjacent
> > block groups boundary correctly.
> >
> > The test case craft the following extents layout:
> >
> >          |  BG1 |      BG2        |       BG3            |
> >  Bytenr: X-8M   X      X+512M     X+1G  X+1G+128M
> >          |//////|//////|          |     |//|
> >
> > There is a long existing bug that, when btrfs is trying to trim the
> > range at [X+512M, X+1G+128M), it will only trim [X+512M, X+1G).
> >
> > This test case is the regression test for this long existing bug.
> >
> > It will verify the trimmed bytes by using loopback device backed up by a
> > file, and checking the bytes used by the file to determine how many
> > bytes are trimmed.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >  tests/btrfs/198     | 154 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/btrfs/198.out |   2 +
> >  tests/btrfs/group   |   1 +
> >  3 files changed, 157 insertions(+)
> >  create mode 100755 tests/btrfs/198
> >  create mode 100644 tests/btrfs/198.out
> >
> > diff --git a/tests/btrfs/198 b/tests/btrfs/198
> > new file mode 100755
> > index 00000000..851e44c1
> > --- /dev/null
> > +++ b/tests/btrfs/198
> > @@ -0,0 +1,154 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2019 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 198
> > +#
> > +# Test if btrfs discard mount option is trimming adjacent extents across
> > +# block groups boundary.
> > +# The test case uses loopback device and file used space to detect trimmed
> > +# bytes.
> > +#
> > +# There is a long existing bug that btrfs doesn't discard all space for
> > +# above mentioned case.
> > +#
> > +# The fix is: "btrfs: extent-tree: Ensure we trim ranges across block group
> > +# boundary"
> > +#
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1       # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +       cd /
> > +       umount $loop_mnt &> /dev/null
> > +       _destroy_loop_device $loop_dev &> /dev/null
> > +       rm -rf $tmp.*
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/filter
> > +
> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs btrfs
> > +_supported_os Linux
> > +_require_fstrim
> 
> This is not needed, as it only tests if the fstrim program is available.
> And this doesn't use it, only requires the fs to supported "-o
> discard" option, which btrfs does for a very long time.
> 
> > +_require_loop
> > +_require_xfs_io_command "fiemap"
> > +
> > +# We need less than 2G data write, consider it 2G and double it just in case
> > +_require_scratch_size  $((4 * 1024 * 1024))
> > +
> > +loop_file="$SCRATCH_MNT/image"
> > +
> > +# The margin when checking trimmed size.
> > +#
> > +# The margin is for tree blocks, calculated by
> > +# 3 * max_tree_block_size
> > +# |   |- 64K
> > +# |- 3 trees get modified (root tree, extent tree, fs tree)
> > +#
> > +# In reality, there should be no margin at all due to the mount options.
> > +# But who knows what will happen in later kernels.
> > +margin_kb=$(( 3 * 64 ))
> > +trimmed_kb=$(( 768 * 1024 )) # 768M
> > +
> > +_scratch_mkfs >> $seqres.full
> > +_scratch_mount
> > +
> > +# Create a sparse file as the loopback target.
> > +# 10G size makes sure we have 1G chunk size.
> > +truncate -s 10G "$loop_file"
> > +
> > +_mkfs_dev -d SINGLE "$loop_file"
> > +
> > +loop_dev=$(_create_loop_device "$loop_file")
> > +loop_mnt=$tmp/loop_mnt
> > +
> > +mkdir -p $loop_mnt
> > +# - nospace_cache
> > +#   Since v1 cache using DATA space, it can break data extent bytenr
> > +#   continuousness.
> > +# - nodatasum
> > +#   As there will be 1.5G data write, generating 1.5M csum.
> > +#   Disabling datasum could reduce the margin caused by metadata to minimal
> > +# - discard
> > +#   What we're testing
> > +_mount -o nospace_cache,nodatasum,discard $loop_dev $loop_mnt
> > +
> > +# Craft the following extent layout:
> > +#         |  BG1 |      BG2        |       BG3            |
> > +# Bytenr: X-8M   X      X+512M     X+1G  X+1G+128M
> > +#         |//////|//////|                |//|
> > +#            V      V           V          V
> > +#            |      |           |          |- file 'tail_padding'
> > +#            |      |           |- file 'cross_boundary'
> > +#            |      |- file 'lead_padding2'
> > +#            |- file 'lead_padding1'
> > +# So that all extents of file 'cross_boundary' are all adjacent and crosses the
> > +# boundary of BG1 and BG2
> > +# File 'lead_padding1' and 'lead_padding2' are all paddings to fill the
> > +# leading gap.
> > +# File 'tail_padding' is to ensure after deleting file 'cross_boundary' we still
> > +# have used extent in BG3, to prevent trimming the whole BG3.
> > +# And since BG1 needs exactly 8M to fill, we need to sync write to ensure
> > +# the write sequence.
> > +_pwrite_byte 0xcd 0 8M $loop_mnt/lead_padding1 > /dev/null
> > +sync
> > +
> > +_pwrite_byte 0xcd 0 512M $loop_mnt/lead_padding2 > /dev/null
> > +sync
> > +_pwrite_byte 0xcd 0 $(($trimmed_kb * 1024)) $loop_mnt/cross_boundary \
> > +       > /dev/null
> > +sync
> > +
> > +_pwrite_byte 0xcd 0 1M $loop_mnt/tail_padding > /dev/null
> > +sync
> > +
> > +
> > +$XFS_IO_PROG -c "fiemap" $loop_mnt/cross_boundary >> $seqres.full
> > +# Ensure all extent are continuous
> > +# Btrfs fiemap will merge continuous results, so the output should be only
> > +# 2 lines, 1 line for filename, 1 line for a large merged fiemap result.
> > +if [ $($XFS_IO_PROG -c "fiemap" $loop_mnt/cross_boundary | wc -l) -ne 2 ]; then
> > +       _notrun "Non-continuous extent bytenr detected"
> > +fi
> > +
> > +size1_kb=$(du $loop_file| cut -f1)
> > +
> > +# Delete the file 'cross_boundary'.
> > +# This will delete $trimmed_kb data extents across the chunk boundary.
> > +rm -f $loop_mnt/cross_boundary
> > +
> > +# sync so btrfs will commit transaction and trim the freed extents
> > +sync
> > +
> > +size2_kb=$(du $loop_file | cut -f1)
> > +
> > +echo "loopback file size before discard: $size1_kb KiB" >> $seqres.full
> > +echo "loopback file size after discard:  $size2_kb KiB" >> $seqres.full
> > +echo "Expect trimmed size:               $trimmed_kb KiB" >> $seqres.full
> > +echo "Have trimmed size:                 $(($size1_kb - $size2_kb)) KiB" >> $seqres.full
> > +
> > +if [ $(($size2_kb+ $trimmed_kb)) -gt $(($size1_kb + $margin_kb)) -o \
> > +     $(($size2_kb+ $trimmed_kb)) -lt $(($size1_kb - $margin_kb)) ]; then
> > +       _fail "Btrfs doesn't trim the range correctly"
> 
> Use of _fail is discouraged and only for very special cases.
> A simple 'echo ...' is enough here to make the test fail.
> 
> Perhaps these are things that Eryu can fixup when he picks the patch,
> as they are trivial.

Sure, I can do that :)

> 
> With that,
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks a lot for the review!

Eryu

> 
> Thanks.
> 
> > +fi
> > +
> > +echo "Silence is golden"
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/198.out b/tests/btrfs/198.out
> > new file mode 100644
> > index 00000000..cb4c7854
> > --- /dev/null
> > +++ b/tests/btrfs/198.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 198
> > +Silence is golden
> > diff --git a/tests/btrfs/group b/tests/btrfs/group
> > index ee35fa59..1b1cbbde 100644
> > --- a/tests/btrfs/group
> > +++ b/tests/btrfs/group
> > @@ -200,3 +200,4 @@
> >  195 auto volume
> >  196 auto metadata log volume
> >  197 auto replay trim
> > +198 auto trim quick
> > --
> > 2.23.0
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
