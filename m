Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5694E256F45
	for <lists+linux-btrfs@lfdr.de>; Sun, 30 Aug 2020 18:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgH3QIn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 30 Aug 2020 12:08:43 -0400
Received: from out20-51.mail.aliyun.com ([115.124.20.51]:42063 "EHLO
        out20-51.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgH3QIm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 30 Aug 2020 12:08:42 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07779765|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00608257-0.000490063-0.993427;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.IQD97HR_1598803705;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.IQD97HR_1598803705)
          by smtp.aliyun-inc.com(10.147.41.137);
          Mon, 31 Aug 2020 00:08:26 +0800
Date:   Mon, 31 Aug 2020 00:08:25 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs/024: Remove no longer valid test
Message-ID: <20200830160825.GB3853@desktop>
References: <20200817103718.10239-1-nborisov@suse.com>
 <20200817134026.15453-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817134026.15453-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Nikolay,

On Mon, Aug 17, 2020 at 04:40:26PM +0300, Nikolay Borisov wrote:
> Kernel commit "btrfs: add missing check for nocow and compression inode
> flags" invalidates the "file compressed, fs mounted with nodatacow"
> mode due to doing more rigorous flags validation, just remove the test.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

I applied this patch, but left patch 2 and 3, as Anand suggested minor
updates, and I assume you'll send new version of patch 2 and 3 :)

Thanks,
Eryu

> ---
> V2:
>  * Also remove the output
> 
>  tests/btrfs/024     | 7 -------
>  tests/btrfs/024.out | 3 ---
>  2 files changed, 10 deletions(-)
> 
> diff --git a/tests/btrfs/024 b/tests/btrfs/024
> index 0c2ffd7389ab..bcb9048da636 100755
> --- a/tests/btrfs/024
> +++ b/tests/btrfs/024
> @@ -42,13 +42,6 @@ __workout()
>  	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" $work_file | _filter_xfs_io
>  }
> 
> -echo "*** test nodatacow"
> -_scratch_mkfs > /dev/null 2>&1
> -_scratch_mount "-o nodatacow"
> -__workout
> -_scratch_unmount
> -_check_scratch_fs
> -
>  echo "*** test compress=no"
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount "-o compress=no"
> diff --git a/tests/btrfs/024.out b/tests/btrfs/024.out
> index 7eacb0aca674..33c4f49366fd 100644
> --- a/tests/btrfs/024.out
> +++ b/tests/btrfs/024.out
> @@ -1,7 +1,4 @@
>  QA output created by 024
> -*** test nodatacow
> -wrote 1048576/1048576 bytes at offset 0
> -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  *** test compress=no
>  wrote 1048576/1048576 bytes at offset 0
>  XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> --
> 2.17.1
