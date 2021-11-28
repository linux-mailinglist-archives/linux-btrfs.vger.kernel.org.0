Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31912460718
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 16:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358091AbhK1PZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 10:25:09 -0500
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:53193 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358020AbhK1PXJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 10:23:09 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09741437|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.678633-0.0035936-0.317774;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.M-gzwuV_1638112790;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.M-gzwuV_1638112790)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 28 Nov 2021 23:19:51 +0800
Date:   Sun, 28 Nov 2021 23:19:50 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fstests: generic/260: don't fail for certain fstrim ops
 on btrfs
Message-ID: <YaOeFrS/wX43Qw5c@desktop>
References: <175b1ef92bbd2a48e2efb80d0064ca91aab1402e.1637618880.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175b1ef92bbd2a48e2efb80d0064ca91aab1402e.1637618880.git.josef@toxicpanda.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 05:08:10PM -0500, Josef Bacik wrote:
> We have always failed generic/260, because it tests to see if the file
> system will reject a trim range that is above the reported fs size.
> However for btrfs we will happily remap logical byte offsets within the
> file system, so you can end up with bye offsets past the end of the
> reported end of the file system.  Thus we do not fail these weird
> ranges.  We also don't have the concept of allocation groups, so the
> other test that tries to catch overflow doesn't apply to us either.  Fix
> this by simply using an offset that will fail (once a related kernel
> path is applied) for btrfs.  This will allow us to test the different
> overflow cases that do apply to btrfs, and not muddy up test results by
> giving us a false negative for the cases that do not apply to btrfs.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

I'd like an ACK from btrfs folks as well.

Thanks,
Eryu

> ---
>  tests/generic/260 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/generic/260 b/tests/generic/260
> index b15b4e57..b4d72e0f 100755
> --- a/tests/generic/260
> +++ b/tests/generic/260
> @@ -31,6 +31,7 @@ fssize=$($DF_PROG -k | grep "$SCRATCH_MNT" | grep "$SCRATCH_DEV"  | awk '{print
>  
>  beyond_eofs=$(_math "$fssize*2048")
>  max_64bit=$(_math "2^64 - 1")
> +[ $FSTYP == "btrfs" ] && beyond_eofs=$max_64bit
>  
>  # All these tests should return EINVAL
>  # since the start is beyond the end of
> @@ -128,6 +129,12 @@ case $FSTYP in
>  		len=$start
>  		export MKFS_OPTIONS="-f -d agsize=$(_math "$agsize*$bsize") -b size=$bsize"
>  		;;
> +	btrfs)
> +		# Btrfs doesn't care about any of this, just test max_64bit
> +		# since it'll fail
> +		start=$max_64bit
> +		len=$(_math "$start / 2")
> +		;;
>  	*)
>  		# (2^32-1) * 4096 * 65536 == 32bit max size * block size * ag size
>  		start=$(_math "(2^32 - 1) * 4096 * 65536")
> -- 
> 2.26.3
