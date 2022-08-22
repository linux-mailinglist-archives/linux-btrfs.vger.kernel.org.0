Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384A659BE63
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 13:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiHVLY2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 07:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiHVLY1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 07:24:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F2618E28;
        Mon, 22 Aug 2022 04:24:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0134B810B5;
        Mon, 22 Aug 2022 11:24:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7E5C433C1;
        Mon, 22 Aug 2022 11:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661167463;
        bh=JwNSY5plLAag9VcO9i7Jir7Xc9dHuDUrSU1EV6N8OsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RzmZ7Nn6t6ENKo8USffh1G03FNpCXnTBC+2h8cO7tKmUPRt4/Uh6ozPcZLT2mJ2f1
         wR/iG9RBCs12MfFB6a3U8rBovP4kVZqIQrnQICcx6IRs9WAMVexM2/xy7fmrmGOk+9
         OU/ov/fkNIUnWoyPw4QJlAkDZVu1sjXNb4oxzo9eV+DzTLhqaM4+903YCB37N+sgKT
         BHq00CugZlj8Q3j7SvGY807FXLjjRYztUBbRrQ6aJ5rNtYyZw2N1bDsEJaZ6FbRKme
         UOoUnpCoEphkManNySBC7KbjFPTuwkQ2XJX+IbKSnxSv1eFl3N2Ctgnq8AXej+dgaD
         ualEbMXxuW1Ng==
Date:   Mon, 22 Aug 2022 12:24:20 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     bingjingc <bingjingc@synology.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        bxxxjxxg@gmail.com
Subject: Re: [PATCH v2] fstests: btrfs: test incremental send for changed
 reference paths
Message-ID: <20220822112420.GA3115262@falcondesktop>
References: <20220822004932.1280053-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822004932.1280053-1-bingjingc@synology.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 22, 2022 at 08:49:32AM +0800, bingjingc wrote:
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
> ---
>  tests/btrfs/272     | 97 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/272.out |  3 ++
>  2 files changed, 100 insertions(+)
>  create mode 100755 tests/btrfs/272
>  create mode 100644 tests/btrfs/272.out
> 
> diff --git a/tests/btrfs/272 b/tests/btrfs/272
> new file mode 100755
> index 00000000..e1986de9
> --- /dev/null
> +++ b/tests/btrfs/272
> @@ -0,0 +1,97 @@
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
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	cd /
> +	rm -fr $send_files_dir
> +	rm -f $tmp.*
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs btrfs

I didn't tell you before, but I wasn't aware back then, that we now have
an annotation to specify kernel commits, se here we should add:

_fixed_by_kernel_commit 3aa5bd367fa5a3 \
	"btrfs: send: fix sending link commands for existing file paths"


> +_require_test
> +_require_scratch
> +_require_fssum
> +
> +send_files_dir=$TEST_DIR/btrfs-test-$seq
> +
> +rm -fr $send_files_dir
> +mkdir $send_files_dir
> +
> +_scratch_mkfs > /dev/null 2>&1
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
> +_run_btrfs_util_prog subvolume snapshot -r $SCRATCH_MNT $SCRATCH_MNT/snap2

So I ran the test on an unpatched kernel and it didn't fail!

The reason is that that command is taking a snapshot of $SCRATCH_MNT, when it
should be $SCRATCH_MNT/vol. So it wasn't testing what we were supposed to test.

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

Thanks for following the style of btrfs/241 and putting here an explanation
of why it failed!

Btw, this patch didn't reach the btrfs mailing list, you typed the address as
"linux-btrfs@vger.kernel.orgto", an extra "to" at the end.

So I'm adding the list to cc.

Anyway, with those two small changes, the patch will look good to me, then
you can add:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks for doing this!

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
