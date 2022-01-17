Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464AC490F21
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 18:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242264AbiAQRQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 12:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiAQRN0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 12:13:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A5C08EAC7;
        Mon, 17 Jan 2022 09:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05FE9B81145;
        Mon, 17 Jan 2022 17:08:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A048C36AED;
        Mon, 17 Jan 2022 17:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642439293;
        bh=COzUYc5wJLvsEu/y3i0UR2TngCDt1U/NbVEU6lJk3DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cLCRRNrHeCB7kJMdD21rHzFsS5yn2Zkh8b33WRxbkELzdFzfqXlE3VV4ajQUOGle3
         MfKrJns+KRfHYkBkcJr0Lw2l3tXeKJt+0xpYvx4VT/Dbxn7Ifr+cIOtq/i7pflEQ8P
         lRfLBuUhke7CGFB3mTyERahhnN1gIHshbFmASxVo1v9PlHukeEnE9N6JjHIYIIIkou
         9+txNpcZBvJ4QYuxqV3EL6qttVUolZaExyhSw6NhdJdVjlzQSuWlmLV20CxSMgXW6w
         z95HD+moutHheEpSswsZGy3rQGVc+/4gjbM535nBgU/nB8ZuSnWlpwQbu0rBm0WFIG
         zuqNwaTwO1GkQ==
Date:   Mon, 17 Jan 2022 17:08:11 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] btrfs/255: add test for quota disable in parallel with
 balance
Message-ID: <YeWie0i4ltdLPkdf@debian9.Home>
References: <20220117005705.956931-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117005705.956931-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 09:57:05AM +0900, Shin'ichiro Kawasaki wrote:
> Test quota disable during btrfs balance and confirm it does not cause
> kernel hang. This is a regression test for the problem reported to
> linux-btrfs list [1]. The hang was recreated using the test case and
> memory backed null_blk device with 5GB size as the scratch device.
> 
> [1] https://lore.kernel.org/linux-btrfs/20220115053012.941761-1-shinichiro.kawasaki@wdc.com/
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  tests/btrfs/255     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/255.out |  2 ++
>  2 files changed, 44 insertions(+)
>  create mode 100755 tests/btrfs/255
>  create mode 100644 tests/btrfs/255.out
> 
> diff --git a/tests/btrfs/255 b/tests/btrfs/255
> new file mode 100755
> index 00000000..16b682ca
> --- /dev/null
> +++ b/tests/btrfs/255
> @@ -0,0 +1,42 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022 Western Digital Corporation or its affiliates.
> +#
> +# FS QA Test No. btrfs/255
> +#
> +# Confirm that disabling quota during balance does not hang
> +#
> +. ./common/preamble
> +_begin_fstest auto qgroup

Should have "balance" as well.

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
> +max_fillsize=$((2*1024*1024*1024))

If the test requires some minimum size, than it should call

   _require_scratch_size <size in KB>

Also please make it a bit more readable by adding a single space before
and after each *, i.e. 2 * 1024 * 1024 ... instead of 2*1024*1024.

> +
> +devsize=$(($(_get_device_size $SCRATCH_DEV) * 512))
> +fillsize=$((devsize * fill_percent / 100))
> +((fillsize > max_fillsize)) && fillsize=$max_fillsize
> +
> +fs=$((4096*1024))

Same here.

> +for ((i=0; i * fs < fillsize; i++)); do

And here (i = 0 vs i=0).

> +	dd if=/dev/zero of=$SCRATCH_MNT/file.$i bs=$fs count=1 \
> +	   >> $seqres.full 2>&1
> +done
> +echo 3 > /proc/sys/vm/drop_caches

Why the drop_caches? Please add a comment explaining why it is needed.

> +
> +# Run btrfs balance and quota enable/disable in parallel
> +_run_btrfs_balance_start $SCRATCH_MNT >> $seqres.full &
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +$BTRFS_UTIL_PROG quota disable $SCRATCH_MNT

This seems very timing sensitive.
It would be a better stress test if we do the enable/disable in a loop,
say 10 or 20 iterations, while another process keeps running balance in
parallel and then is killed after the main process finishes the loop of
enable/disable quotas.

Thanks.

> +wait
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
