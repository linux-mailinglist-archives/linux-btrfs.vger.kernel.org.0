Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE34928AE
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jan 2022 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343974AbiAROqW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jan 2022 09:46:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46662 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiAROqW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jan 2022 09:46:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0721DB816B0;
        Tue, 18 Jan 2022 14:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F44C00446;
        Tue, 18 Jan 2022 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642517179;
        bh=CzfS5yIhCOpsyZ2vax/jwv8XPvQT2Aba1ORadrwxTg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gLhQ5JVcgUidvZWUAw3lsDbSn2tT2Wd2l6WvLRznQZQQycnKIEySS+nLHdYiPIylQ
         K0HmcRuZsgwuC6dYpSJElyfj4Iu5WWqENZMi1VbzTHuZ8N0CQjR6fXlZno/oLLX7ch
         7diq/rYBckuqehPDrD+Gcjhxgh6VLuweJ9ZeRAsZAfZyTyHozLU9tnP1eKqnNvFYwa
         IOHA62wL86CHDjLS61F3ieyD47ueYeqXJHIBZCX4HBUqRyJf/BN3hZ13uhGw7dEIFN
         3tX7D9ZHM/pViunIaL2e9FtzlfgPhUcDYqF9FYWeCPgDxRoVeCE4PBjDNJpRDTxBKD
         R3FZVcuJ/WQcA==
Date:   Tue, 18 Jan 2022 14:46:16 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v2] btrfs/255: add test for quota disable in parallel
 with balance
Message-ID: <YebSuDGqX4RoxpXq@debian9.Home>
References: <20220118055721.982596-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118055721.982596-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 18, 2022 at 02:57:21PM +0900, Shin'ichiro Kawasaki wrote:
> Test quota disable during btrfs balance and confirm it does not cause
> kernel hang. This is a regression test for the problem reported to
> linux-btrfs list [1]. The hang was recreated using the test case and
> memory backed null_blk device with 5GB size as the scratch device.
> 
> [1] https://lore.kernel.org/linux-btrfs/20220115053012.941761-1-shinichiro.kawasaki@wdc.com/
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Put more stress by repeating quota enable/disable and btrfs balance
> * Reflected other comments on the list
> 
>  tests/btrfs/255     | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/255.out |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/btrfs/255
>  create mode 100644 tests/btrfs/255.out
> 
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> new file mode 100755
> index 00000000..32f00f42
> --- /dev/null
> +++ b/tests/btrfs/255
> @@ -0,0 +1,45 @@
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

You need to wait for the balance pid to exit before terminating the test,
otherwise the test will fail often when the fstests framework is trying
to unmount the scratch device (with an -EBUSY returned from umount).

And please do like in other tests that use _btrfs_stress_balance():

	kill $balance_pid
	wait
	# wait for the balance operation to finish
	while ps aux | grep "balance start" | grep -qv grep; do
		sleep 1
	done

Like in btrfs/060 for example.

Other than that, it looks fine, thanks.

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
