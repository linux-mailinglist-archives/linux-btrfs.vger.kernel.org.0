Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B222E51FD93
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 15:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiEINMJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 09:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235080AbiEINMI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 09:12:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A723F38C;
        Mon,  9 May 2022 06:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89323B81250;
        Mon,  9 May 2022 13:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1695CC385A8;
        Mon,  9 May 2022 13:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652101690;
        bh=5EMWGR+vkIJb0BbCbiWls4GAYiin1LxnxLtBLtmPXhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fTrjTRmfqtJNZkNY7MYrKYE2OOp6DKBmNAPlkYe+BedNjNuwx70hAtBhZXNI5Q6W0
         8LRgUAnvwFxSfO0cm0cOmZH1o+6Ud7WsoXR1BipDyJN9TLKDMoVgY2Ta0VJ3M7xcFh
         /m07V5hhJ9ED/PeiFCQqh5G4wmBkfCl5EG/18x8j58wAB6sUtJt9mNtcrX1ASu/qN2
         qoUdW91irirFsawu9Qq7KYuAcRn33kH5SIEG5bSyls5/AfUhS5gsNd7Rh83xcFtt4s
         X8os0WrciwIdCr2JZtAfNJBD1W6vyUPx90pVvRDuh8F1KYW/2DJ5tXS08SSj3G1Wt+
         kgWyhGY/Czy6A==
Date:   Mon, 9 May 2022 21:08:04 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [Resend PATCH] generic: test fsync of directory with renamed
 symlink
Message-ID: <20220509130804.7dnkmgnlrxtulfmy@zlang-mailbox>
Mail-Followup-To: Filipe Manana <fdmanana@kernel.org>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>
References: <8f06924cda35f9a5e22c1c188eb46205dd50491f.1651573756.git.fdmanana@suse.com>
 <20220509100317.GB2270453@falcondesktop>
 <20220509111355.nzbg3e2gp3vykvxa@zlang-mailbox>
 <20220509113243.GA2279159@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509113243.GA2279159@falcondesktop>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 09, 2022 at 12:32:43PM +0100, Filipe Manana wrote:
> On Mon, May 09, 2022 at 07:13:55PM +0800, Zorro Lang wrote:
> > On Mon, May 09, 2022 at 11:03:17AM +0100, Filipe Manana wrote:
> > > On Tue, May 03, 2022 at 11:57:49AM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > > 
> > > > Test that if we fsync a directory, create a symlink inside it, rename
> > > > the symlink, fsync again the directory and then power fail, after the
> > > > filesystem is mounted again, the symlink exists with the new name and
> > > > it has the correct content.
> > > > 
> > > > This currently fails on btrfs, because the symlink ends up empty (which
> > > > is illegal on Linux), but it is fixed by kernel commit:
> > > > 
> > > >     d0e64a981fd841 ("btrfs: always log symlinks in full mode")
> > > > 
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > > 
> > > > Resending as this was missed on the last update.
> > > > No changes, only rebased on the current 'for-next' branch.
> > > 
> > > Zorro,
> > > 
> > > This missed against the last fstests update.
> > > Did this patch fell through the cracks, or do you expect me to do something about it?
> > > 
> > > Should I rebase and resend again?
> > 
> > Oh, this patch is in my "still reviewing" list, I remembered I didn't see any
> > RVB/ACK for it, did I miss some emails? If so I missed something please feel
> > free to tell me :)
> 
> There weren't any reviews, which is not uncommon.
> In the past, the maintainers (Eryu, Dave) usually reviewed the patches themselves.

Hi Filipe,

Actually I've checked it from fstests common side, but generally I hope to give a
specific fs case several days to see if related experts would like to give it some
review points at first. If no response, I'll ask and think about merging it after
basic reviewing and testing. You resent it on May 03, if you're hurry to merge a
btrfs patch when you sent it, better to CC some related folks to help that out,
that'll help to facilitate the process effectively, thanks for your understanding :)

Thanks,
Zorro

> 
> > 
> > Thanks,
> > Zorro
> > 
> > > 
> > > Thanks.
> > > 
> > > > 
> > > >  tests/generic/690     | 89 +++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/690.out |  2 +
> > > >  2 files changed, 91 insertions(+)
> > > >  create mode 100755 tests/generic/690
> > > >  create mode 100644 tests/generic/690.out
> > > > 
> > > > diff --git a/tests/generic/690 b/tests/generic/690
> > > > new file mode 100755
> > > > index 00000000..0bf47dd7
> > > > --- /dev/null
> > > > +++ b/tests/generic/690
> > > > @@ -0,0 +1,89 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
> > > > +#
> > > > +# FS QA Test 690
> > > > +#
> > > > +# Test that if we fsync a directory, create a symlink inside it, rename the
> > > > +# symlink, fsync again the directory and then power fail, after the filesystem
> > > > +# is mounted again, the symlink exists with the new name and it has the correct
> > > > +# content.
> > > > +#
> > > > +# On btrfs this used to result in the symlink being empty (i_size 0), and it was
> > > > +# fixed by kernel commit:
> > > > +#
> > > > +#    d0e64a981fd841 ("btrfs: always log symlinks in full mode")
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick log
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +	_cleanup_flakey
> > > > +	cd /
> > > > +	rm -r -f $tmp.*
> > > > +}
> > > > +
> > > > +. ./common/rc
> > > > +. ./common/filter
> > > > +. ./common/dmflakey
> > > > +
> > > > +# real QA test starts here
> > > > +
> > > > +_supported_fs generic
> > > > +_require_scratch
> > > > +_require_symlinks
> > > > +_require_dm_target flakey
> > > > +
> > > > +rm -f $seqres.full
> > > > +
> > > > +# f2fs doesn't support fs-op level transaction functionality, so it has no way
> > > > +# to persist all metadata updates in one transaction. We have to use its mount
> > > > +# option "fastboot" so that it triggers a metadata checkpoint to persist all
> > > > +# metadata updates that happen before a fsync call. Without this, after the
> > > > +# last fsync in the test, the symlink named "baz" will not exist.
> > > > +if [ $FSTYP = "f2fs" ]; then
> > > > +	export MOUNT_OPTIONS="-o fastboot $MOUNT_OPTIONS"
> > > > +fi
> > > > +
> > > > +_scratch_mkfs >>$seqres.full 2>&1
> > > > +_require_metadata_journaling $SCRATCH_DEV
> > > > +_init_flakey
> > > > +_mount_flakey
> > > > +
> > > > +# Create our test directory.
> > > > +mkdir $SCRATCH_MNT/testdir
> > > > +
> > > > +# Commit the current transaction and persist the directory.
> > > > +sync
> > > > +
> > > > +# Create a file in the test directory, so that the next fsync on the directory
> > > > +# actually does something (it logs the directory).
> > > > +echo -n > $SCRATCH_MNT/testdir/foo
> > > > +
> > > > +# Fsync the directory.
> > > > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir
> > > > +
> > > > +# Now create a symlink inside the test directory.
> > > > +ln -s $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
> > > > +
> > > > +# Rename the symlink.
> > > > +mv $SCRATCH_MNT/testdir/bar $SCRATCH_MNT/testdir/baz
> > > > +
> > > > +# Fsync again the directory.
> > > > +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir
> > > > +
> > > > +# Simulate a power failure and then mount again the filesystem to replay the
> > > > +# journal/log.
> > > > +_flakey_drop_and_remount
> > > > +
> > > > +# The symlink should exist, with the name "baz" and its content must be
> > > > +# "$SCRATCH_MNT/testdir/foo".
> > > > +[ -L $SCRATCH_MNT/testdir/baz ] || echo "symlink 'baz' is missing"
> > > > +echo "symlink content: $(readlink $SCRATCH_MNT/testdir/baz | _filter_scratch)"
> > > > +
> > > > +_unmount_flakey
> > > > +
> > > > +# success, all done
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/690.out b/tests/generic/690.out
> > > > new file mode 100644
> > > > index 00000000..84be1247
> > > > --- /dev/null
> > > > +++ b/tests/generic/690.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 690
> > > > +symlink content: SCRATCH_MNT/testdir/foo
> > > > -- 
> > > > 2.35.1
> > > > 
> > > 
> 
