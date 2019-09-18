Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D55BDB5F6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2019 10:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbfIRIrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Sep 2019 04:47:37 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50244 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728057AbfIRIrg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Sep 2019 04:47:36 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TcgcL5v_1568796454;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TcgcL5v_1568796454)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Sep 2019 16:47:34 +0800
Date:   Wed, 18 Sep 2019 16:47:34 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] fstests: btrfs/011: Handle finished scrub/replace
 operation gracefully
Message-ID: <20190918084734.GA52397@e18g06458.et15sqa>
References: <20190918065626.34902-1-wqu@suse.com>
 <20190918065626.34902-2-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918065626.34902-2-wqu@suse.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 18, 2019 at 02:56:26PM +0800, Qu Wenruo wrote:
> [BUG]
> When btrfs/011 is executed on a fast enough system (fully memory backed
> VM, with test device has unsafe cache mode), the test can fail like
> this:
> 
>   btrfs/011 43s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests-dev/results//btrfs/011.out.bad)
>     --- tests/btrfs/011.out     2019-07-22 14:13:44.643333326 +0800
>     +++ /home/adam/xfstests-dev/results//btrfs/011.out.bad      2019-09-18 14:49:28.308798022 +0800
>     @@ -1,3 +1,4 @@
>      QA output created by 011
>      *** test btrfs replace
>     -*** done
>     +failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
>     +(see /home/adam/xfstests-dev/results//btrfs/011.full for details)
>     ...
> 
> [CAUSE]
> Looking into the full output, it shows:
>   ...
>   Replace from /dev/mapper/test-scratch1 to /dev/mapper/test-scratch2
> 
>   # /usr/bin/btrfs replace start -f /dev/mapper/test-scratch1 /dev/mapper/test-scratch2 /mnt/scratch
>   # /usr/bin/btrfs replace cancel /mnt/scratch
>   INFO: ioctl(DEV_REPLACE_CANCEL)"/mnt/scratch": not started
>   failed: '/usr/bin/btrfs replace cancel /mnt/scratch'
> 
> So this means the replace is already finished before we cancel it.
> For fast system, it's very common.

Does generate heavier load & more data make replace operation last
longer? e.g. make more 'noise' by running fsstress instead of dumping
/dev/urandom before starting replace.

And does sleep shorter time (0.5s?) before cancel work?

Thanks,
Eryu

> 
> [FIX]
> Instead of using _run_btrfs_util_prog which requires 0 as return value,
> we just call "$BTRFS_UTIL_PROG replace cancel" and ignore all its
> stderr/stdout, and completely rely on "$BTRFS_UTIL_PROG replace status"
> output to verify the work.
> 
> Furthermore if we finished replac before cancelling it, we should
> replace again to switch the device back, or after the test case, btrfs
> check will fail as there is no valid btrfs on that replaced device.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/011 | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index 89bb4d11..858b00e8 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -148,13 +148,25 @@ btrfs_replace_test()
>  		# background the replace operation (no '-B' option given)
>  		_run_btrfs_util_prog replace start -f $replace_options $source_dev $target_dev $SCRATCH_MNT
>  		sleep 1
> -		_run_btrfs_util_prog replace cancel $SCRATCH_MNT
> +		# 1s is enough for fast system to finish replace, so here we
> +		# ignore all the output, completely rely on later status
> +		# output to determine
> +		$BTRFS_UTIL_PROG replace cancel $SCRATCH_MNT &> /dev/null
>  
>  		# 'replace status' waits for the replace operation to finish
>  		# before the status is printed
>  		$BTRFS_UTIL_PROG replace status $SCRATCH_MNT > $tmp.tmp 2>&1
>  		cat $tmp.tmp >> $seqres.full
> -		grep -q canceled $tmp.tmp || _fail "btrfs replace status (canceled) failed"
> +		grep -q -e canceled -e finished $tmp.tmp ||\
> +			_fail "btrfs replace status (canceled) failed"
> +
> +		# If replace finished before cancel, replace them back or
> +		# the final fsck after test case will fail as there is no btrfs
> +		# on the $source_dev anymore
> +		if grep -q -e finished $tmp.tmp ; then
> +			$BTRFS_UTIL_PROG replace start -Bf $replace_options \
> +				$target_dev $source_dev $SCRATCH_MNT
> +		fi
>  	else
>  		if [ "${quick}Q" = "thoroughQ" ]; then
>  			# On current hardware, the thorough test runs
> -- 
> 2.22.0
