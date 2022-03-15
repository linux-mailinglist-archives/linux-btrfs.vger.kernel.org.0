Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B684D9A6B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 12:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347936AbiCOLdp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Mar 2022 07:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiCOLdo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Mar 2022 07:33:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06044F9F3;
        Tue, 15 Mar 2022 04:32:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A455B810F7;
        Tue, 15 Mar 2022 11:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0235AC340E8;
        Tue, 15 Mar 2022 11:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647343950;
        bh=lOO16vhbtD+DkFrBRKpr1z1bwmqVd1BZi36WKV5p+Nw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=urIYGSlZmANS+2BVaEC/QDkIhK4Tsk02ODSwf+ZzSvhMHWbGdV8U0lj9bWQNCBCkH
         pX+pl/+II9MxStjSVREy77DdIvTjnTHah9Q+k7w/KuV06GQv2Hjcnq2GFRNVLqz06v
         SwDIcC5BQNIF+w2rZKpWGb67OWrC5SXstid021lVdepgj0rYJveKGLqlycW7ScCvBR
         mwc13onBzBxAj/EXry9atlXIgl1PbY87H1Gbmql5e280Jhjksd5vmWyGR6XtGwbmnL
         LxFnRinWayx8TlymDMH3ZWCJyY0pq93VxGHJJzBKiUt4AZci/lt4ReLRdtQimUfIeI
         a7bcYZHMssQRg==
Date:   Tue, 15 Mar 2022 11:32:24 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make sure autodefrag won't defrag ranges which
 don't contribute to fragmentations
Message-ID: <YjB5SCOBnOApLB0J@debian9.Home>
References: <20220315023417.25129-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315023417.25129-1-wqu@suse.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 15, 2022 at 10:34:17AM +0800, Qu Wenruo wrote:
> There is a report that btrfs autodefrag is defragging extents which only
> has one single sector.
> 
> Such defragging will not reduce the number of extents, but only waste
> IO.
> 
> The fix for it is titled:
> 
>   btrfs: avoid defragging extents whose next extents are not targets
> 
> Here we add a test case, which will create an inode with the following
> layout:
> 
>   0                16K   20K                  64K
>   |<-- Extent A -->|<-B->|<----- Extent C --->|
>   |Gen: 7          |Gen 9|Gen 7               |
> 
> And we trigger autodefrag with newer_than = 8, which means it will only
> defrag extents newer than or equal to geneartion 8.
> 
> Currently only Extent B meets the condition, but it can not be merged
> with Extent A nor Extent C, as they don't meet the geneartion
> requirement.
> 
> Unpatched kernel will defrag only Extent B, resulting no change in
> fragmentation, while cost extra IO.
> 
> Patched kernel will not defrag anything.
> 
> Although this is still not the ideal case, as we can defrag the whole
> 64K range, but that's not what autodefrag can do with its geneartion
> limitation.
> 
> And such "perfect" defrag can cause way more IO than some users can
> stand.
> 
> At least we should not only defrag extent B.

Looking at the subject:

  btrfs: make sure autodefrag won't defrag ranges which don't contribute to fragmentations

It's a bit long, it gives the idea it's a fix and not a test, plus
"fragmentations" should be "defragmentation".

Maybe something like the following would be more clear and shorter:

  btrfs: test that autdodefrag does not rewrite single extents

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/262     | 99 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/262.out |  2 +
>  2 files changed, 101 insertions(+)
>  create mode 100755 tests/btrfs/262
>  create mode 100644 tests/btrfs/262.out
> 
> diff --git a/tests/btrfs/262 b/tests/btrfs/262
> new file mode 100755
> index 00000000..0f91c4a4
> --- /dev/null
> +++ b/tests/btrfs/262
> @@ -0,0 +1,99 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 262
> +#
> +# Make sure btrfs autodefrag will not defrag ranges which won't reduce
> +# defragmentation.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick defrag
> +
> +# Override the default cleanup function.
> +# _cleanup()
> +# {
> +# 	cd /
> +# 	rm -r -f $tmp.*
> +# }

Could go away.

> +
> +# Import common functions.
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs btrfs
> +_require_scratch
> +_require_xfs_io_command "fiemap" "ranged"
> +
> +# Needs fixed 4K sector size, or the file layout will not match the expected
> +# result
> +_require_btrfs_support_sectorsize 4096
> +
> +_scratch_mkfs >> $seqres.full
> +
> +_scratch_mount -o noautodefrag
> +
> +# Create the initial layout, with a large 64K extent for later fragments
> +$XFS_IO_PROG -f -c "pwrite 0 64K" -c sync "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +# Need to bump the generation by one, as autodefrag uses the last modified
> +# generation of a subvolume. With this generation bump, autodefrag will
> +# defrag the whole file, not only the new write.

Some of the sentences in comments end with punctuation, others do not.
If not for the sake of formal correctness and to make it clear you ended the
sentences as you intended, than at least finish them all with punctation for
the sake of consistency and aesthetics.

> +touch "$SCRATCH_MNT/trash"
> +sync
> +
> +# Remount to autodefrag
> +_scratch_remount autodefrag
> +
> +# Write a new sector, which should trigger autodefrag
> +$XFS_IO_PROG -f -c "pwrite 16K 4K" -c sync "$SCRATCH_MNT/foobar" >> $seqres.full

We could leave the -f out, as it makes it clear we want to write to an
existing file.

Anyway, the test fails without the kernel patch, and it passes with it.
Minor cosmetics apart:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +
> +echo "=== File extent layout before autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +old_csum=$(_md5_checksum "$SCRATCH_MNT/foobar")
> +old_ext_0=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> +old_ext_16k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 16384)
> +old_ext_20k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 20480)
> +
> +# Trigger autodefrag
> +_scratch_remount commit=1
> +sleep 3
> +# Make sure the defragged range reach disk
> +sync
> +
> +echo "=== File extent layout after autodefrag ===" >> $seqres.full
> +$XFS_IO_PROG -c "fiemap -v" "$SCRATCH_MNT/foobar" >> $seqres.full
> +
> +new_csum=$(_md5_checksum "$SCRATCH_MNT/foobar")
> +new_ext_0=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 0)
> +new_ext_16k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 16384)
> +new_ext_20k=$(_get_file_extent_sector "$SCRATCH_MNT/foobar" 20480)
> +
> +# For extent at offset 0 and 20K, they are older than the target generation,
> +# thus they should not be defragged
> +if [ "$new_ext_0" != "$old_ext_0" ]; then
> +	echo "extent at offset 0 got defragged"
> +fi
> +if [ "$new_ext_20k" != "$old_ext_20k" ]; then
> +	echo "extent at offset 20K got defragged"
> +fi
> +
> +# For extent at offset 4K, it's a single sector, and its adjacent extents
> +# are not targets, thus it should not be defragged.
> +if [ "$new_ext_16k" != "$old_ext_16k" ]; then
> +	echo "extent at offset 16K got defragged"
> +fi
> +
> +# Defrag should not change file content
> +if [ "$new_csum" != "$old_csum" ]; then
> +	echo "file content changed"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/262.out b/tests/btrfs/262.out
> new file mode 100644
> index 00000000..404badc3
> --- /dev/null
> +++ b/tests/btrfs/262.out
> @@ -0,0 +1,2 @@
> +QA output created by 262
> +Silence is golden
> -- 
> 2.34.1
> 
