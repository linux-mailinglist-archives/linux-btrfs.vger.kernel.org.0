Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812F636A5B6
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhDYI1H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 25 Apr 2021 04:27:07 -0400
Received: from out20-87.mail.aliyun.com ([115.124.20.87]:37554 "EHLO
        out20-87.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhDYI1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 25 Apr 2021 04:27:07 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08735207|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0703829-0.0022306-0.927387;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.K3lg1VY_1619339184;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K3lg1VY_1619339184)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 25 Apr 2021 16:26:25 +0800
Date:   Sun, 25 Apr 2021 16:26:19 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH 2/4] btrfs: require discard functionality from scratch
 device
Message-ID: <YIUnqyk12txC6uDU@desktop>
References: <20210423112634.6067-1-johannes.thumshirn@wdc.com>
 <20210423112634.6067-3-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423112634.6067-3-johannes.thumshirn@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 23, 2021 at 08:26:32PM +0900, Johannes Thumshirn wrote:
> Some test cases for btrfs require the scratch device to support discard.
> Check if the scratch device does support discard before trying to execute
> the test.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  common/rc       | 8 ++++++++
>  tests/btrfs/116 | 1 +
>  tests/btrfs/156 | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 11ff7635700b..76a7265e23ba 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3587,6 +3587,14 @@ _require_batched_discard()
>  	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
>  }
>  
> +_require_scratch_discard()
> +{
> +	local sdev="$(_short_dev $SCRATCH_DEV)"
> +	local discard=$(cat /sys/block/$sdev/queue/discard_granularity)
> +
> +	[ $discard -gt 0 ] || _notrun "discard not supported"
> +}
> +
>  _require_dumpe2fs()
>  {
>  	if [ -z "$DUMPE2FS_PROG" ]; then
> diff --git a/tests/btrfs/116 b/tests/btrfs/116
> index 3ed097eccf03..f4db439caef8 100755
> --- a/tests/btrfs/116
> +++ b/tests/btrfs/116
> @@ -29,6 +29,7 @@ _cleanup()
>  # real QA test starts here
>  _supported_fs btrfs
>  _require_scratch
> +_require_scratch_discard
>  
>  rm -f $seqres.full
>  
> diff --git a/tests/btrfs/156 b/tests/btrfs/156
> index 89c80e7161e2..56206d99c801 100755
> --- a/tests/btrfs/156
> +++ b/tests/btrfs/156
> @@ -42,6 +42,7 @@ rm -f $seqres.full
>  _supported_fs btrfs
>  _require_scratch
>  _require_fstrim
> +_require_scratch_discard

These two tests already have _require_batched_discard, which will make
sure discard is supported by the device, by actually doing fstrim on
$SCRATCH_MNT. I think that should do the work?

Thanks,
Eryu

>  
>  # 1024fs size
>  fs_size=$((1024 * 1024 * 1024))
> -- 
> 2.30.0
