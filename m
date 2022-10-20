Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638536063B7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Oct 2022 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiJTPA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Oct 2022 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiJTPA0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Oct 2022 11:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25FB156267;
        Thu, 20 Oct 2022 08:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E05561BB3;
        Thu, 20 Oct 2022 15:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744A5C433C1;
        Thu, 20 Oct 2022 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666278025;
        bh=FWuRBOv4CEW/SgOmhsI6/Vwus8qotrUPHbt4tJDazg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tz6tNFwiShnrSbBBs8lPDXvZ3u90IpIija6FoiY7KSBFJtChVt+vucoQTWbG4Lzcn
         vgHqmAsP0WeJrMezTZD0+YfpkY5ygI+wo30RK/bXfLiRwr32wqlIza7Zc+2MkwnVnj
         fNuXB6H/pbcpDhuiPSsbmjEJfpqD7GkBUoQXxSCHt1zjzcWtJ48cCBMEQ2h2SldQ4h
         zpg3B3RANJVQhseHQIluzzrlnAGKpVEFBert4Fx53l1+35zssisvxhqHveHuFoHJgf
         LwW5L2jABqh4uk65mksu1H6Oo5s9WnRN1CZyOXmD42Cgb3iXwF2K1hhWewXQjyY2NT
         qn68oP9Z7FflQ==
Date:   Thu, 20 Oct 2022 23:00:19 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] generic: check if one fs can detect damage at/after fs
 thaw
Message-ID: <20221020150019.jp65m3kejbhds6mf@zlang-mailbox>
References: <20221019052955.30484-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019052955.30484-1-wqu@suse.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 19, 2022 at 01:29:55PM +0800, Qu Wenruo wrote:
> [BACKGROUND]
> There is bug report from btrfs mailing list that, hiberation can allow
> one to modify the frozen filesystem unexpectedly (using another OS).
> (https://lore.kernel.org/linux-btrfs/83bf3b4b-7f4c-387a-b286-9251e3991e34@bluemole.com/)
> 
> Later btrfs adds the check to make sure the fs is not changed
> unexpectedly, to prevent corruption from happening.
> 
> [TESTCASE]
> Here the new test case will create a basic filesystem, fill it with
> something by using fsstress, then sync the fs, and finally freeze the fs.
> 
> Then corrupt the whole fs by overwriting the block device with 0xcd
> (default seed from xfs_io pwrite command).
> 
> Finally we thaw the fs, and try if we can create a new file.
> 
> for EXT4, it will detect the corruption at touch time, causing -EUCLEAN.
> 
> For Btrfs, it will detect the corruption at thaw time, marking the
> fs RO immediately, and later touch will return -EROFS.
> 
> For XFS, it will detect the corruption at touch time, return -EUCLEAN.
> (Without the cache drop, XFS seems to be very happy using the cache info
> to do the work without any error though.)
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/generic/702     | 61 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/702.out |  2 ++
>  2 files changed, 63 insertions(+)
>  create mode 100755 tests/generic/702
>  create mode 100644 tests/generic/702.out
> 
> diff --git a/tests/generic/702 b/tests/generic/702
> new file mode 100755
> index 00000000..fc3624e1
> --- /dev/null
> +++ b/tests/generic/702
> @@ -0,0 +1,61 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 702
> +#
> +# Test if the filesystem can detect the underlying disk has changed at
> +# thaw time.
> +#
> +. ./common/preamble
> +. ./common/filter
> +_begin_fstest freeze quick
> +
> +# real QA test starts here
> +
> +_supported_fs generic
> +_fixed_by_kernel_commit a05d3c915314 \
> +	"btrfs: check superblock to ensure the fs was not modified at thaw time"
> +
> +# We will corrupt the device completely, thus should not check it after the test.
> +_require_scratch_nocheck
> +_require_freeze
> +
> +# Limit the fs to 512M so we won't waste too much time screwing it up later.
> +_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Populate the fs with something.
> +$FSSTRESS_PROG -n 500 -d $SCRATCH_MNT >> $seqres.full
> +
> +# Sync to make sure no dirty journal
> +sync
> +
> +# Drop all cache, so later write will need to read from disk, increasing
> +# the chance of detecting the corruption.
> +echo 3 > /proc/sys/vm/drop_caches
> +
> +$XFS_IO_PROG -x -c "freeze" $SCRATCH_MNT
> +
> +# Now screw up the block device
> +$XFS_IO_PROG -f -c "pwrite 0 512M" -c sync $SCRATCH_DEV >> $seqres.full
> +
> +# Thaw the fs, it may or may not report error, we will check it manually later.
> +$XFS_IO_PROG -x -c "thaw" $SCRATCH_MNT
> +
> +# If the fs detects something wrong, it should trigger error now.
> +# We don't use the error message as golden output, as btrfs and ext4 use
> +# different error number for different reasons.
> +# (btrfs detects the change immediately at thaw time and mark the fs RO, thus
> +#  touch returns -EROFS, while ext4 detects the change at journal write time,
> +#  returning -EUCLEAN).
> +touch $SCRATCH_MNT/foobar >>$seqres.full 2>&1
> +if [ $? -eq 0 ]; then
> +	echo "Failed to detect corrupted fs"
> +else
> +	echo "Detected corrupted fs (expected)"
> +fi

Thanks for all help to review!

That `_require_freeze` will skip exfat and others which not support freeze.

And `_require_block_device $SCRATCH_DEV` helps you to avoid this test run/fail on
overlayfs, nfs, tmpfs, etc. Due to you try to write the $SCRATCH_DEV directly.

And you can use `_supported_fs ^f2fs` to skip this test from some specified fs
if they're not suit for this test.

But I'm wondering if the last test step will fail on every fs soon? Except
you're trying to test how fast a fs can find itself is corrupted. Or how
about give some fs more chance/time to detect errors? Likes do more operations
which enough to trigger errors on most fs?

Thanks,
Zorro

> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/702.out b/tests/generic/702.out
> new file mode 100644
> index 00000000..c29311ff
> --- /dev/null
> +++ b/tests/generic/702.out
> @@ -0,0 +1,2 @@
> +QA output created by 702
> +Detected corrupted fs (expected)
> -- 
> 2.38.0
> 
