Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54C841554FD
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2020 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgBGJrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Feb 2020 04:47:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:34758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgBGJrB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 7 Feb 2020 04:47:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E6267ABD7;
        Fri,  7 Feb 2020 09:46:58 +0000 (UTC)
Subject: Re: [PATCH 2/3] fstests: btrfs/022: Match qgroup id more correctly
To:     Qu Wenruo <wqu@suse.com>, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
References: <20200207015942.9079-1-wqu@suse.com>
 <20200207015942.9079-3-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fa00355c-5c99-1c5c-9af5-eb0bf221b528@suse.com>
Date:   Fri, 7 Feb 2020 11:46:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200207015942.9079-3-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.02.20 г. 3:59 ч., Qu Wenruo wrote:
> [BUG]
> Btrfs/022 sometimes fails with snapshot's reference mismatch with its
> source.
> 
> [CAUSE]
> Since commit fd0830929573 ("fsstress: add the ability to create
> snapshots") adds the ability for fsstress to create/delete snapshot and
> subvolumes, fsstress will create new subvolumes under test dir.
> 
> For example, we could have the following subvolumes created by fsstress:
> subvol a id=256
> subvol b id=306
> qgroupid         rfer         excl
> --------         ----         ----
> 0/5             16384        16384
> 0/256        13914112        16384
> ...
> 0/263         3080192      2306048 		<< 2 *306* 048
> ...
> 0/306        13914112        16384 		<< 0/ *306
> 
> So when we're greping for subvolid 306, it matches qgroup 0/263 first,
> which has difference size, and caused false alert.
> 
> [FIX]
> Instead of greping "$subvolid" blindly, now grep "0/$subvolid" to catch
> qgroupid correctly, without hitting rfer/excl values.

That 0/ can it ever be a number different than 0, if so a more correct
regular expression should be:
grep "[[:digit:]]/306"  ?


> 
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/022 | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index 5348d3ed..3e729852 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -49,10 +49,10 @@ _basic_test()
>  
>  	# the shared values of both the original subvol and snapshot should
>  	# match
> -	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
> +	a_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>  	a_shared=$(echo $a_shared | awk '{ print $2 }')
>  	subvolid=$(_btrfs_get_subvolid $SCRATCH_MNT b)
> -	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
> +	b_shared=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>  	b_shared=$(echo $b_shared | awk '{ print $2 }')
>  	[ $b_shared -eq $a_shared ] || _fail "shared values don't match"
>  }
> @@ -68,12 +68,12 @@ _rescan_test()
>  	run_check $FSSTRESS_PROG -d $SCRATCH_MNT/a -w -p 1 -n 2000 \
>  		$FSSTRESS_AVOID
>  	sync
> -	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
> +	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>  	echo $output >> $seqres.full
>  	refer=$(echo $output | awk '{ print $2 }')
>  	excl=$(echo $output | awk '{ print $3 }')
>  	_run_btrfs_util_prog quota rescan -w $SCRATCH_MNT
> -	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep $subvolid)
> +	output=$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0/$subvolid")
>  	echo $output >> $seqres.full
>  	[ $refer -eq $(echo $output | awk '{ print $2 }') ] || \
>  		_fail "reference values don't match after rescan"
> 
