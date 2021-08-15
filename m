Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B83EC9E2
	for <lists+linux-btrfs@lfdr.de>; Sun, 15 Aug 2021 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234332AbhHOPUl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 15 Aug 2021 11:20:41 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:33392 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhHOPUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 15 Aug 2021 11:20:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5672719|-1;CH=green;DM=|CONTINUE|false|;DS=||;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.L.lErU._1629040807;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.L.lErU._1629040807)
          by smtp.aliyun-inc.com(10.147.42.241);
          Sun, 15 Aug 2021 23:20:08 +0800
Date:   Sun, 15 Aug 2021 23:20:07 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 8/8] fstests: generic: add checks for zoned block
 device
Message-ID: <YRkwp1l/qVjg7x9m@desktop>
References: <20210811151232.3713733-1-naohiro.aota@wdc.com>
 <20210811151232.3713733-9-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151232.3713733-9-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Aug 12, 2021 at 12:12:32AM +0900, Naohiro Aota wrote:
> Modify generic tests to require non-zoned block device
> 
> generic/108 is disabled on zoned block device because the LVM device not
> always aligned to the zone boundary.
> 
> generic/471 is disabled because we cannot enable NoCoW on zoned btrfs.
> 
> generic/570 is disabled because swap file which require nocow is not usable
> on zoned btrfs.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  tests/generic/108 | 1 +
>  tests/generic/471 | 1 +
>  tests/generic/570 | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index 7dd426c19030..b51bce9f9bce 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -35,6 +35,7 @@ _require_scratch_nocheck
>  _require_block_device $SCRATCH_DEV
>  _require_scsi_debug
>  _require_command "$LVM_PROG" lvm
> +_require_non_zoned_device $SCRATCH_DEV

I think in generic/108 and generic/570 we should only check zoned device
if FSTYP is btrfs in in generic/471. And also need comments to explain
the reason to do so.

Thanks,
Eryu

>  
>  lvname=lv_$seq
>  vgname=vg_$seq
> diff --git a/tests/generic/471 b/tests/generic/471
> index dab06f3a315c..66b7d6946a9f 100755
> --- a/tests/generic/471
> +++ b/tests/generic/471
> @@ -37,6 +37,7 @@ mkdir $testdir
>  # all filesystems, use a NOCOW file on btrfs.
>  if [ $FSTYP == "btrfs" ]; then
>  	_require_chattr C
> +	_require_non_zoned_device $TEST_DEV
>  	touch $testdir/f1
>  	$CHATTR_PROG +C $testdir/f1
>  fi
> diff --git a/tests/generic/570 b/tests/generic/570
> index 7d03acfe3c44..71928f0ac980 100755
> --- a/tests/generic/570
> +++ b/tests/generic/570
> @@ -25,6 +25,7 @@ _supported_fs generic
>  _require_test_program swapon
>  _require_scratch_nocheck
>  _require_block_device $SCRATCH_DEV
> +_require_non_zoned_device "$SCRATCH_DEV"
>  test -e /dev/snapshot && _notrun "userspace hibernation to swap is enabled"
>  
>  $MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
> -- 
> 2.32.0
