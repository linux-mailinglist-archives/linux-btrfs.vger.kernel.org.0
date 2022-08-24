Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF859F84C
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 13:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236767AbiHXLCH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Aug 2022 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235946AbiHXLCF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Aug 2022 07:02:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9166FA21;
        Wed, 24 Aug 2022 04:02:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9006B823A6;
        Wed, 24 Aug 2022 11:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9D8C433C1;
        Wed, 24 Aug 2022 11:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661338921;
        bh=NQlJkjYZYrIP6X9hgZGqlhPyTGn9HvDRQTCfbGJtwzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ShBZswHHYl21Frn4HYo3zWcQ9VKUCXFionb5cLcYR9Oz4us5e9U9xZaIYmeVCw0qo
         Sp0qnRWvOAQHFjc7IBt/ZBZXvInNxBJzb+VQUzCnxFAyV9qPH89r2we3fUMKQogws1
         7sQ2bc/7rXI3bbLGzZxvQfw7fjvuw9wZCyYXbn6A6mtG81qjEdvgRlq3Je0wfYgbm0
         OHg6UDyVrocxLwaFxBsM6Ga8dfjmw0UYzGspYyakN4zJTcIbH+OjEuLskh5SrHBsgY
         JdpuInTf7JPUurPq3JcKTDy3CcjuI9uahUAEYdbKEXGEksU2pVodOsXReWW5HDMH7d
         7aw/xVvmjLw5w==
Date:   Wed, 24 Aug 2022 12:01:57 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     bingjingc <bingjingc@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        zlang@redhat.com, bxxxjxxg@gmail.com
Subject: Re: [PATCH v3] fstests: btrfs: test incremental send for changed
 reference paths
Message-ID: <20220824110157.GA3240326@falcondesktop>
References: <20220824104202.2505-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824104202.2505-1-bingjingc@synology.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 24, 2022 at 06:42:02PM +0800, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> Normally btrfs stores file paths in an array of ref items. However, items
> for the same parent directory can not exceed the size of a leaf. So btrfs
> also store the rest of them in extended ref items alternatively.
> 
> In this test, it creates a large number of links under a directory causing
> the file paths stored in these two ways to be the parent snapshot. And it
> deletes and recreates just an amount of them that can be stored within an
> array of ref items to be the send snapshot. Test that an incremental send
> operation correctly issues link/unlink operations only against new/deleted
> paths, or the receive operation will fail due to a link on an existed path.
> 
> This currently fails on btrfs but is fixed by a kernel patch with the
> commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> existing file paths")
> 
> Signed-off-by: BingJing Chang <bingjingc@synology.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks a lot for doing this BingJing!

> ---
>  tests/btrfs/272     | 91 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/272.out |  3 ++
>  2 files changed, 94 insertions(+)
>  create mode 100755 tests/btrfs/272
>  create mode 100644 tests/btrfs/272.out
> 
> diff --git a/tests/btrfs/272 b/tests/btrfs/272
> new file mode 100755
> index 00000000..57dd065c
> --- /dev/null
> +++ b/tests/btrfs/272
> @@ -0,0 +1,91 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 BingJing Chang.
> +#
> +# FS QA Test No. btrfs/272
> +#
> +# Regression test for btrfs incremental send issue where a link instruction
> +# is sent against an existing path, causing btrfs receive to fail.
> +#
> +# This issue is fixed by the following linux kernel btrfs patch:
> +#
> +#   commit 3aa5bd367fa5a3 ("btrfs: send: fix sending link commands for
> +#   existing file paths")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick send
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_fixed_by_kernel_commit 3aa5bd367fa5a3 \
> +	"btrfs: send: fix sending link commands for existing file paths"
> +_require_test
> +_require_scratch
> +_require_fssum
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Create a file and 2000 hard links to the same inode
> +_run_btrfs_util_prog subvolume create $SCRATCH_MNT/vol
> +touch $SCRATCH_MNT/vol/foo
> +for i in {1..2000}; do
> +	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> +done
> +
> +# Create a snapshot for a full send operation
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap1
> +_run_btrfs_util_prog send -f $send_files_dir/1.snap $SCRATCH_MNT/snap1
> +
> +# Remove 2000 hard links and re-create the last 1000 links
> +for i in {1..2000}; do
> +	rm $SCRATCH_MNT/vol/$i
> +done
> +for i in {1001..2000}; do
> +	link $SCRATCH_MNT/vol/foo $SCRATCH_MNT/vol/$i
> +done
> +
> +# Create another snapshot for an incremental send operation
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT/vol $SCRATCH_MNT/snap2
> +_run_btrfs_util_prog send -p $SCRATCH_MNT/snap1 -f $send_files_dir/2.snap \
> +		     $SCRATCH_MNT/snap2
> +
> +$FSSUM_PROG -A -f -w $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -A -f -w $send_files_dir/2.fssum \
> +	-x $SCRATCH_MNT/snap2/snap1 $SCRATCH_MNT/snap2
> +
> +# Recreate the filesystem by receiving both send streams and verify we get
> +# the same content that the original filesystem had.
> +_scratch_unmount
> +_scratch_mkfs >>$seqres.full 2>&1
> +_scratch_mount
> +
> +# Add the first snapshot to the new filesystem by applying the first send
> +# stream.
> +_run_btrfs_util_prog receive -f $send_files_dir/1.snap $SCRATCH_MNT
> +
> +# The incremental receive operation below used to fail with the following
> +# error:
> +#
> +#    ERROR: link 1238 -> foo failed: File exists
> +#
> +# This is because the path "1238" was stored as an extended ref item in the
> +# original snapshot but as a normal ref item in the next snapshot. The send
> +# operation cannot handle the duplicated paths, which are stored in
> +# different ways, well, so it decides to issue a link operation for the
> +# existing path. This results in the receiver to fail with the above error.
> +_run_btrfs_util_prog receive -f $send_files_dir/2.snap $SCRATCH_MNT
> +
> +$FSSUM_PROG -r $send_files_dir/1.fssum $SCRATCH_MNT/snap1
> +$FSSUM_PROG -r $send_files_dir/2.fssum $SCRATCH_MNT/snap2
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/272.out b/tests/btrfs/272.out
> new file mode 100644
> index 00000000..b009b87a
> --- /dev/null
> +++ b/tests/btrfs/272.out
> @@ -0,0 +1,3 @@
> +QA output created by 272
> +OK
> +OK
> -- 
> 2.37.1
> 
