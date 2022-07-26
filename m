Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05498581C45
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 01:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbiGZXJS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jul 2022 19:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiGZXJR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jul 2022 19:09:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E328654E;
        Tue, 26 Jul 2022 16:09:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FDD15C0193;
        Tue, 26 Jul 2022 19:09:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 26 Jul 2022 19:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1658876952; x=1658963352; bh=Pk7fPDyN1m
        hcn9AmZJJSQrWGf3bFrll2wfVC739XpTk=; b=CJcUReuQSOK29U2tGnyliGHuQ9
        DZps2SYGb6xrKvYqWW+bGrqAfNvpr8qiOwuUK6a4XTj5K6L06lt2bZfczsPpuYEK
        aMT3wJjefPZxstkWMVcscS8OO1oFQ1PkMjmG09u55O0tpPOvgpm0UKiWm7YmNwOV
        BRkquO8e0gIewEoVybE1tutvc3tyXtYGpbgULrvLfF3j8tnSKfBJVTKjnWo6CqUr
        8NZvFbACxDaSg1oWhXUSfVuMEpUAHJc8vmiYCRdoNBDYUphnnBI8p3pXgoewJPWp
        txZa0xBhKUUbH8T0bSSvL812F58YqwFpJKQGmmNnLzNNMqOh/78Mwhlrl1uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1658876952; x=1658963352; bh=Pk7fPDyN1mhcn9AmZJJSQrWGf3bF
        rll2wfVC739XpTk=; b=RPz69GhfFADmiQZhaq6pZwZEXboNZCq64r1xg70r0Hbh
        th2GJhWO+nLpRt9MZj3s3TROKrmVi0weqlksYSZt7Dnig52lvcfq9HpLfCRECFCO
        I/2H2Dp5HFMes51XE7VVGRmjGycJlfUO+cw88lu84Qer6I7V8kR4qVDI4GniSwgp
        QmmvFCytQ9FAYXt1eZMDOlozBDBtYdf4pdIGvS29EOK7gSW5PK2PMEGRZWH/HFc3
        goDvv9e2jxf+iAqpt0nAXC7pl7FsugnQPdx72y34VaQ0Ny0ZxlqFluSCARpB8ibO
        fcnCf7GD/RRCBI75Z5N8y8VnXVCT2swthYSvDET4TQ==
X-ME-Sender: <xms:GHTgYmoLx2HBUyrUhX7dyAYwaxhUDQfw5_Hi1c2J_uZLfMDoQGtdBA>
    <xme:GHTgYko0ry--1nnuL3fmk_MkyYk5rasSUtAhf42kzwCz-Y9Em4O3l5ShBc7S5YQFI
    sGcYEQVcW0aRgm2yIw>
X-ME-Received: <xmr:GHTgYrMXLA6iyIU3Ooo62k_Nj5ufWJMzg67Dcmi43zfwiwhk3HnINw8IMndpkqVaOzSr7o-aG0Gnams6ugQGE-QLsS-bYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduuddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:GHTgYl5V-P2Dr9HsiRh_jebylnK-T9oH5TYgNaNa_jbslMgnonV0Hg>
    <xmx:GHTgYl6RWrIWhBLrVVFEJDnc2QugLLPb46_7UwZxthMyAbzhKe_OOg>
    <xmx:GHTgYlj1uFa231JHrB8x9cADIPi0AIKEGulRrj96pIS0sedyihq0cg>
    <xmx:GHTgYnRu9c1O-lbscpgEQV4I4OuhgJP1SdqbKJK89JLFzwadUmAtzQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Jul 2022 19:09:11 -0400 (EDT)
Date:   Tue, 26 Jul 2022 16:09:56 -0700
From:   Boris Burkov <boris@bur.io>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: add test case to make sure btrfs can handle one
 corrupted device
Message-ID: <YuB0RD9fx5nBnv2m@zen>
References: <20220726062948.56315-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726062948.56315-1-wqu@suse.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 26, 2022 at 02:29:48PM +0800, Qu Wenruo wrote:
> The new test case will verify that btrfs can handle one corrupted device
> without affecting the consistency of the filesystem.
> 
> Unlike a missing device, one corrupted device can return garbage to the fs,
> thus btrfs has to utilize its data/metadata checksum to verify which
> data is correct.

> 
> The test case will:
> 
> - Create a small fs
>   Mostly to speedup the test
> 
> - Fill the fs with a regular file
> 
> - Use fsstress to create some contents
> 
> - Save the fssum for later verification
> 
> - Corrupt one device with garbage but keep the primary superblock
>   untouched
> 
> - Run fssum verification
> 
> - Run scrub to fix the fs
> 
> - Run scrub again to make sure the fs is fine
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Works for me, and looks like a nice test to complement btrfs/027.
Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  tests/btrfs/261     | 94 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/261.out |  2 +
>  2 files changed, 96 insertions(+)
>  create mode 100755 tests/btrfs/261
>  create mode 100644 tests/btrfs/261.out
> 
> diff --git a/tests/btrfs/261 b/tests/btrfs/261
> new file mode 100755
> index 00000000..15218e28
> --- /dev/null
> +++ b/tests/btrfs/261
> @@ -0,0 +1,94 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 261
> +#
> +# Make sure btrfs raid profiles can handling one corrupted device
> +# without affecting the consistency of the fs.
> +#
> +. ./common/preamble
> +_begin_fstest raid
> +
> +. ./common/filter
> +. ./common/populate
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +_require_fssum
> +
> +prepare_fs()
> +{
> +	local profile=$1
> +
> +	# We don't want too large fs which can take too long to populate
> +	# And the extra redirection of stderr is to avoid the RAID56 warning
> +	# message to polluate the golden output
> +	_scratch_pool_mkfs -m $profile -d $profile -b 1G >> $seqres.full 2>&1
> +	if [ $? -ne 0 ]; then
> +		echo "mkfs $mkfs_opts failed"
> +		return
> +	fi
> +
> +	# Disable compression, as compressed read repair is known to have problems
> +	_scratch_mount -o compress=no
> +
> +	# Fill some part of the fs first
> +	$XFS_IO_PROG -f -c "pwrite -S 0xfe 0 400M" $SCRATCH_MNT/garbage > /dev/null 2>&1
> +
> +	# Then use fsstress to generate some extra contents.
> +	# Disable setattr related operations, as it may set NODATACOW which will
> +	# not allow us to use btrfs checksum to verify the content.
> +	$FSSTRESS_PROG -f setattr=0 -d $SCRATCH_MNT -w -n 3000 > /dev/null 2>&1
> +	sync
> +
> +	# Save the fssum of this fs
> +	$FSSUM_PROG -A -f -w $tmp.saved_fssum $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG fi show $SCRATCH_MNT >> $seqres.full
> +	_scratch_unmount
> +}
> +
> +workload()
> +{
> +	local target=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
> +	local profile=$1
> +	local num_devs=$2
> +
> +	_scratch_dev_pool_get $num_devs
> +	echo "=== Testing profile $profile ===" >> $seqres.full
> +	rm -f -- $tmp.saved_fssum
> +	prepare_fs $profile
> +
> +	# Corrupt the target device, only keep the superblock.
> +	$XFS_IO_PROG -c "pwrite 1M 1023M" $target > /dev/null 2>&1
> +
> +	_scratch_mount
> +
> +	# All content should be fine
> +	$FSSUM_PROG -r $tmp.saved_fssum $SCRATCH_MNT > /dev/null
> +
> +	# Scrub to fix the fs, this is known to report various correctable
> +	# errors
> +	$BTRFS_UTIL_PROG scrub start -B $SCRATCH_MNT >> $seqres.full 2>&1
> +
> +	# Make sure above scrub fixed the fs
> +	$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full
> +	if [ $? -ne 0 ]; then
> +		echo "scrub failed to fix the fs for profile $profile"
> +	fi
> +	_scratch_unmount
> +	_scratch_dev_pool_put
> +}
> +
> +workload raid1 2
> +workload raid1c3 3
> +workload raid1c4 4
> +workload raid10 4
> +workload raid5 3
> +workload raid6 4

Speaking of 027, 

Can you implement this with _btrfs_profile_configs?

Further, you could imagine writing a more generic test that does:
for raid in raids:
        create-fs raid
        screw-up disk(s)
        check-condition

and make 027 and this new one (and others?) special cases of that.
I think this might fall under YAGNI.. Food for thought :)

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/261.out b/tests/btrfs/261.out
> new file mode 100644
> index 00000000..679ddc0f
> --- /dev/null
> +++ b/tests/btrfs/261.out
> @@ -0,0 +1,2 @@
> +QA output created by 261
> +Silence is golden
> -- 
> 2.36.1
> 
