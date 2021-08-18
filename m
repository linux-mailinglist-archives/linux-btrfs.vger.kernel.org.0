Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3323EF66C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Aug 2021 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbhHRABo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 20:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232706AbhHRABn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 20:01:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11D8F60FD9;
        Wed, 18 Aug 2021 00:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629244870;
        bh=hdP33vg2sddJdAzAsXCk444DhEumjfNhJuAMPHX33Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZW3CSIWij7rLBmpf9HD9xQmvsBBvOjCoJwxRBQvomv+DU7vJuzCEEaKkoX5m8M5+
         d+b1IMgaar4CwpgwzBHZFkqPCja36aiT3oBilQXQUW3AbXcQVBqiG977yOPT3WGzR1
         fSyX3G80unQoV/QkW8peCaxXOwEW/jWgO4Xf4NDE/iJwrlU7AiYzPKGzzgBjG2D4fJ
         N4ibWP5WmkEksyUvKnaXMYkK+M6MgI/0pU5XZaJfwPBvAkHKvOevDd8iHoWtbRgQyM
         Tq0Bhd1pYTPr0dJKMSdDvn4vcCIQlayxhnbAzikT1RoSXOnLLWC6c9j3NvIpsr8m2L
         CDIHO0cDi3A3w==
Date:   Tue, 17 Aug 2021 17:01:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 3/3] fstests: generic: add checks for zoned block
 device
Message-ID: <20210818000109.GB12612@magnolia>
References: <20210816113510.911606-1-naohiro.aota@wdc.com>
 <20210816113510.911606-4-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816113510.911606-4-naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 08:35:10PM +0900, Naohiro Aota wrote:
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

I'm surprised that only three generic tests needed the annotation, but
the logic makes sense, so
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/108 | 2 ++
>  tests/generic/471 | 2 ++
>  tests/generic/570 | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/tests/generic/108 b/tests/generic/108
> index b7797e8fac2b..6e1ea5b9d20a 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -36,6 +36,8 @@ _require_scratch_nocheck
>  _require_block_device $SCRATCH_DEV
>  _require_scsi_debug
>  _require_command "$LVM_PROG" lvm
> +# We cannot ensure the Logical Volume is aligned to the zone boundary
> +_require_non_zoned_device $SCRATCH_DEV
>  
>  lvname=lv_$seq
>  vgname=vg_$seq
> diff --git a/tests/generic/471 b/tests/generic/471
> index dab06f3a315c..fbd0b12a9e3a 100755
> --- a/tests/generic/471
> +++ b/tests/generic/471
> @@ -37,6 +37,8 @@ mkdir $testdir
>  # all filesystems, use a NOCOW file on btrfs.
>  if [ $FSTYP == "btrfs" ]; then
>  	_require_chattr C
> +	# Zoned btrfs does not support NOCOW
> +	_require_non_zoned_device $TEST_DEV
>  	touch $testdir/f1
>  	$CHATTR_PROG +C $testdir/f1
>  fi
> diff --git a/tests/generic/570 b/tests/generic/570
> index 7d03acfe3c44..126b222d10d2 100755
> --- a/tests/generic/570
> +++ b/tests/generic/570
> @@ -25,6 +25,8 @@ _supported_fs generic
>  _require_test_program swapon
>  _require_scratch_nocheck
>  _require_block_device $SCRATCH_DEV
> +# We cannot create swap on a zoned device because it can cause random write IOs
> +_require_non_zoned_device "$SCRATCH_DEV"
>  test -e /dev/snapshot && _notrun "userspace hibernation to swap is enabled"
>  
>  $MKSWAP_PROG "$SCRATCH_DEV" >> $seqres.full
> -- 
> 2.32.0
> 
