Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236ED2D052F
	for <lists+linux-btrfs@lfdr.de>; Sun,  6 Dec 2020 14:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgLFNbS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Dec 2020 08:31:18 -0500
Received: from out20-25.mail.aliyun.com ([115.124.20.25]:36864 "EHLO
        out20-25.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgLFNbR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Dec 2020 08:31:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09829937|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0668307-0.0145915-0.918578;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.J3e4GpS_1607261431;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.J3e4GpS_1607261431)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sun, 06 Dec 2020 21:30:32 +0800
Date:   Sun, 6 Dec 2020 21:30:31 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Update btrfs/215
Message-ID: <20201206133031.GU3853@desktop>
References: <20201203121139.754305-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203121139.754305-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 03, 2020 at 02:11:39PM +0200, Nikolay Borisov wrote:
> This patch updates btrfs/215 to work with latest upstream kernel. That's
> required since commit 324bcf54c449 ("mm: use limited read-ahead to satisfy read")
> changed readahead logic to always issue a read even if the RA pages are
> set to 0. This results in 1 extra io being issued so the counts in the
> test should be incremented by 1. Also use the opportunity to update the
> commit reference since it's been merged in the upstream kernel.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  tests/btrfs/215 | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index 4acc288a9f60..2647fa41ef86 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -6,7 +6,7 @@
>  #
>  # Test that reading corrupted files would correctly increment device status
>  # counters. This is fixed by the following linux kernel commit:
> -# btrfs: Increment device corruption error in case of checksum error
> +# 814723e0a55a ("btrfs: increment device corruption error in case of checksum error")
>  #
>  seq=`basename $0`
>  seqres=$RESULT_DIR/$seq
> @@ -74,15 +74,15 @@ echo 0 > /sys/fs/btrfs/$uuid/bdi/read_ahead_kb
>  # page by page

The comments above this line should be updated as well.

# buffered reads whould result in a single error since the read is done

And I think it's better to describe the 1 extra io in comments as well.

Thanks,
Eryu

>  $XFS_IO_PROG -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
>  errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
> -if [ $errs -ne 1 ]; then
> -	_fail "Errors: $errs expected: 1"
> +if [ $errs -ne 2 ]; then
> +	_fail "Errors: $errs expected: 2"
>  fi
>  
>  # DIO does check every sector
>  $XFS_IO_PROG -d -c "pread -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null 2>&1
>  errs=$($BTRFS_UTIL_PROG device stats $SCRATCH_DEV | awk '/corruption_errs/ { print $2 }')
> -if [ $errs -ne 5 ]; then
> -	_fail "Errors: $errs expected: 1"
> +if [ $errs -ne 6 ]; then
> +	_fail "Errors: $errs expected: 6"
>  fi
>  
>  # success, all done
> -- 
> 2.17.1
