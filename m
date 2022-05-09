Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6787152012B
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238427AbiEIPgN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 11:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbiEIPf7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 11:35:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DAB1D866D;
        Mon,  9 May 2022 08:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 981BA610E7;
        Mon,  9 May 2022 15:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B26C385AF;
        Mon,  9 May 2022 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652110324;
        bh=3kZQSLtH674ne7U7eblvJrhyMaG0Tg5RaFrSrDIunl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QklF0ZLBRE6dwed4H7m+EpsIhkVDFJ7e07gVs3cSNfSPDS3rKP3Pm0cQRP3BbzhCN
         10YfK/l3zqstsYKwyr6Sx+/WyjCLIFp0iO0GX9WgIC3V7sqz1KxyeVrfnADHfCK08c
         zFhSQtrtpoMq9xjl/hHo1RUC+pcsm5ywa87ooKwbu4gMOmJ6SypNj+YdIZUxGXPgsb
         2cSjoeZsVM90zWm8RKxR6w81rrpqtv7vwSzhWu3F7voRx6ruVZQQs7rx76a/PJoa0k
         FLkhQ3Uvc40ovq2/Zf+d+pN/lM0QBR38N9hD3jwoVOgyIpcPIZlVlr6llYU+CKnwfF
         fYV+W2hS1HeVQ==
Date:   Mon, 9 May 2022 23:31:58 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     fdmanana@kernel.org
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        ddiss@suse.de, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] generic: test fsync of directory with renamed symlink
Message-ID: <20220509153158.4vo3qwh7jqx2a4gb@zlang-mailbox>
Mail-Followup-To: fdmanana@kernel.org, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ddiss@suse.de,
        Filipe Manana <fdmanana@suse.com>
References: <3f3d20ef0abcc05ebfb6bc4aaa97261598611e49.1652106518.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f3d20ef0abcc05ebfb6bc4aaa97261598611e49.1652106518.git.fdmanana@suse.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 09, 2022 at 03:31:02PM +0100, fdmanana@kernel.org wrote:
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
> Reviewed-by: David Disseldorp <ddiss@suse.de>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
> 
> v2: Rebased on latest for-next, quoted $SCRATCH_MNT references (David Disseldorp)
>     and added David's review tag.

This case is nearly copied from generic/066, so there's not debatable things
from code format. It's in my local testing branch now, and will be pushed in
next release, after regression test done. Thanks for this new test.

Zorro

> 
>  tests/generic/690     | 90 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/690.out |  2 +
>  2 files changed, 92 insertions(+)
>  create mode 100755 tests/generic/690
>  create mode 100644 tests/generic/690.out
> 
> diff --git a/tests/generic/690 b/tests/generic/690
> new file mode 100755
> index 00000000..f03295a5
> --- /dev/null
> +++ b/tests/generic/690
> @@ -0,0 +1,90 @@
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
> +mkdir "$SCRATCH_MNT"/testdir
> +
> +# Commit the current transaction and persist the directory.
> +sync
> +
> +# Create a file in the test directory, so that the next fsync on the directory
> +# actually does something (it logs the directory).
> +echo -n > "$SCRATCH_MNT"/testdir/foo
> +
> +# Fsync the directory.
> +$XFS_IO_PROG -c "fsync" "$SCRATCH_MNT"/testdir
> +
> +# Now create a symlink inside the test directory.
> +ln -s "$SCRATCH_MNT"/testdir/foo "$SCRATCH_MNT"/testdir/bar
> +
> +# Rename the symlink.
> +mv "$SCRATCH_MNT"/testdir/bar "$SCRATCH_MNT"/testdir/baz
> +
> +# Fsync again the directory.
> +$XFS_IO_PROG -c "fsync" "$SCRATCH_MNT"/testdir
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# The symlink should exist, with the name "baz" and its content must be
> +# "$SCRATCH_MNT/testdir/foo".
> +[ -L "$SCRATCH_MNT"/testdir/baz ] || echo "symlink 'baz' is missing"
> +symlink_content=$(readlink "$SCRATCH_MNT"/testdir/baz | _filter_scratch)
> +echo "symlink content: ${symlink_content}"
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
