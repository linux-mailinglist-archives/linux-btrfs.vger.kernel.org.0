Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4051F959
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 12:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbiEIKLg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 06:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233895AbiEIKLV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 06:11:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A3916EC86;
        Mon,  9 May 2022 03:07:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3F860A53;
        Mon,  9 May 2022 10:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64338C385A8;
        Mon,  9 May 2022 10:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652090600;
        bh=9zNeZ8DnyLRmGEaNSH3mxI6tUr9i1xub7dpmjtwmirM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BC0d64RH8beeS9j0X58rMkmSGcH9gJrQvt63AtQSjCxdwhm2kY7jHbSH8AEQdt6tI
         FouT0e+/xcoXo4eVgdkmxBMXHr/K/dAWTWA+FHV3b2u1DB+GVYwIOv+T74l9+WVpii
         IhMeVYVB8BSI1VoUGcThApXUrswlL08b+QbrgFyHmfvJL1DrkRoPR/Xh1JTR/RrfZY
         Vu7dYO2CwfZquOUBlB2K/wOLk9TRcqzTRr0MTPnyx2q+dsHiK1Dgy4XJK21dkdBU0e
         iKY687LjCnaSxDxkXVyq+riCsSraqXaWXNa2Km05IkAFjIAr6VfaVENCdFe9G8B/0l
         Lf2NcAB9fMTDw==
Date:   Mon, 9 May 2022 11:03:17 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, zlang@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [Resend PATCH] generic: test fsync of directory with renamed
 symlink
Message-ID: <20220509100317.GB2270453@falcondesktop>
References: <8f06924cda35f9a5e22c1c188eb46205dd50491f.1651573756.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f06924cda35f9a5e22c1c188eb46205dd50491f.1651573756.git.fdmanana@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 03, 2022 at 11:57:49AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a directory, create a symlink inside it, rename
> the symlink, fsync again the directory and then power fail, after the
> filesystem is mounted again, the symlink exists with the new name and
> it has the correct content.
> 
> This currently fails on btrfs, because the symlink ends up empty (which
> is illegal on Linux), but it is fixed by kernel commit:
> 
>     d0e64a981fd841 ("btrfs: always log symlinks in full mode")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> Resending as this was missed on the last update.
> No changes, only rebased on the current 'for-next' branch.

Zorro,

This missed against the last fstests update.
Did this patch fell through the cracks, or do you expect me to do something about it?

Should I rebase and resend again?

Thanks.

> 
>  tests/generic/690     | 89 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/690.out |  2 +
>  2 files changed, 91 insertions(+)
>  create mode 100755 tests/generic/690
>  create mode 100644 tests/generic/690.out
> 
> diff --git a/tests/generic/690 b/tests/generic/690
> new file mode 100755
> index 00000000..0bf47dd7
> --- /dev/null
> +++ b/tests/generic/690
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 690
> +#
> +# Test that if we fsync a directory, create a symlink inside it, rename the
> +# symlink, fsync again the directory and then power fail, after the filesystem
> +# is mounted again, the symlink exists with the new name and it has the correct
> +# content.
> +#
> +# On btrfs this used to result in the symlink being empty (i_size 0), and it was
> +# fixed by kernel commit:
> +#
> +#    d0e64a981fd841 ("btrfs: always log symlinks in full mode")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/rc
> +. ./common/filter
> +. ./common/dmflakey
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_require_scratch
> +_require_symlinks
> +_require_dm_target flakey
> +
> +rm -f $seqres.full
> +
> +# f2fs doesn't support fs-op level transaction functionality, so it has no way
> +# to persist all metadata updates in one transaction. We have to use its mount
> +# option "fastboot" so that it triggers a metadata checkpoint to persist all
> +# metadata updates that happen before a fsync call. Without this, after the
> +# last fsync in the test, the symlink named "baz" will not exist.
> +if [ $FSTYP = "f2fs" ]; then
> +	export MOUNT_OPTIONS="-o fastboot $MOUNT_OPTIONS"
> +fi
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +# Create our test directory.
> +mkdir $SCRATCH_MNT/testdir
> +
> +# Commit the current transaction and persist the directory.
> +sync
> +
> +# Create a file in the test directory, so that the next fsync on the directory
> +# actually does something (it logs the directory).
> +echo -n > $SCRATCH_MNT/testdir/foo
> +
> +# Fsync the directory.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir
> +
> +# Now create a symlink inside the test directory.
> +ln -s $SCRATCH_MNT/testdir/foo $SCRATCH_MNT/testdir/bar
> +
> +# Rename the symlink.
> +mv $SCRATCH_MNT/testdir/bar $SCRATCH_MNT/testdir/baz
> +
> +# Fsync again the directory.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# The symlink should exist, with the name "baz" and its content must be
> +# "$SCRATCH_MNT/testdir/foo".
> +[ -L $SCRATCH_MNT/testdir/baz ] || echo "symlink 'baz' is missing"
> +echo "symlink content: $(readlink $SCRATCH_MNT/testdir/baz | _filter_scratch)"
> +
> +_unmount_flakey
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/690.out b/tests/generic/690.out
> new file mode 100644
> index 00000000..84be1247
> --- /dev/null
> +++ b/tests/generic/690.out
> @@ -0,0 +1,2 @@
> +QA output created by 690
> +symlink content: SCRATCH_MNT/testdir/foo
> -- 
> 2.35.1
> 
