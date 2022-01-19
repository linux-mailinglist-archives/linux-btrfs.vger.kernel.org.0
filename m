Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D4B4938B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 11:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353805AbiASKjU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 05:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbiASKjT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 05:39:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22490C061574;
        Wed, 19 Jan 2022 02:39:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D75A9B81982;
        Wed, 19 Jan 2022 10:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F24C340E1;
        Wed, 19 Jan 2022 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642588756;
        bh=sUU1m66ucS+EJS/ZuOggW83BO9GEKPEHJ9OLL/hJ67M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bot20V0fxHv8Sx6EV3J7dC5IbTU8VZUX5u9u1q6AynmDcGYgHBgZwVlpYNs/BS8d+
         uRNapC7od+1qfdgRJs3yRyGpZhfbRAB3Eb3qvh07vGemb+sYrKQLm23nPrQOJX42af
         UWYWPNT3ll27Yq0glKZV7TuQxOtfNCqxO2BBlYILCQZbRT6hXFWnW2YfX8lsJPRVkm
         SR5VwxUrCdSiylm1YpL6L7Pfp4Bjr9DA8uBfC3EOZZP1fpGEO++tixJyr7Vn3ZgKNC
         5osgBZxZkKAV3FWtp9PdwlD8s0tOGn169oAOFyhpA31OI0Oy/bNk8L/6Weweh41jRJ
         PAWJMiPaLNVJg==
Date:   Wed, 19 Jan 2022 10:39:09 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3] btrfs/255: add test for quota disable in parallel
 with balance
Message-ID: <YefqTctnGSbORJpy@debian9.Home>
References: <20220119022531.990072-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119022531.990072-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 19, 2022 at 11:25:31AM +0900, Shin'ichiro Kawasaki wrote:
> Test quota disable during btrfs balance and confirm it does not cause
> kernel hang. This is a regression test for the problem reported to
> linux-btrfs list [1]. The hang was recreated using the test case and
> memory backed null_blk device with 5GB size as the scratch device.
> 
> [1] https://lore.kernel.org/linux-btrfs/20220115053012.941761-1-shinichiro.kawasaki@wdc.com/
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> Changes from v2:
> * Added wait for balance operation finish
> 
> Changes from v1:
> * Put more stress by repeating quota enable/disable and btrfs balance
> * Reflected other comments on the list
> 
>  tests/btrfs/255     | 50 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/255.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/btrfs/255
>  create mode 100644 tests/btrfs/255.out
> 
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> new file mode 100755
> index 00000000..74aa9769
> --- /dev/null
> +++ b/tests/btrfs/255
> @@ -0,0 +1,50 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Western Digital Corporation or its affiliates.
> +#
> +# FS QA Test No. btrfs/255
> +#
> +# Confirm that disabling quota during balance does not hang
> +#
> +. ./common/preamble
> +_begin_fstest auto qgroup balance
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +# Fill 40% of the device or 2GB
> +fill_percent=40
> +max_fillsize=$((2 * 1024 * 1024 * 1024))
> +
> +devsize=$(($(_get_device_size $SCRATCH_DEV) * 512))
> +fillsize=$((devsize * fill_percent / 100))
> +((fillsize > max_fillsize)) && fillsize=$max_fillsize
> +
> +fs=$((4096 * 1024))
> +for ((i = 0; i * fs < fillsize; i++)); do
> +	dd if=/dev/zero of=$SCRATCH_MNT/file.$i bs=$fs count=1 \
> +	   >> $seqres.full 2>&1
> +done
> +
> +# Run btrfs balance and quota enable/disable in parallel
> +_btrfs_stress_balance $SCRATCH_MNT >> $seqres.full &
> +balance_pid=$!
> +echo $balance_pid >> $seqres.full
> +for ((i = 0; i < 20; i++)); do
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT
> +done
> +kill $balance_pid &> /dev/null
> +wait
> +# wait for the balance operation to finish
> +while ps aux | grep "balance start" | grep -qv grep; do
> +	sleep 1
> +done
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/btrfs/255.out b/tests/btrfs/255.out
> new file mode 100644
> index 00000000..7eefb828
> --- /dev/null
> +++ b/tests/btrfs/255.out
> @@ -0,0 +1,2 @@
> +QA output created by 255
> +Silence is golden
> -- 
> 2.33.1
> 
