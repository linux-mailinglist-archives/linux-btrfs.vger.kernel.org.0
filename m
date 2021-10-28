Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4992043D873
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 03:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhJ1BRR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Oct 2021 21:17:17 -0400
Received: from out20-111.mail.aliyun.com ([115.124.20.111]:42010 "EHLO
        out20-111.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhJ1BRR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Oct 2021 21:17:17 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2384282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00531875-6.77561e-06-0.994675;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.Lj3vUld_1635383689;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Lj3vUld_1635383689)
          by smtp.aliyun-inc.com(10.147.40.26);
          Thu, 28 Oct 2021 09:14:49 +0800
Date:   Thu, 28 Oct 2021 09:14:53 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH v2 4/4] btrfs: increase metadata alloc size to 5GB for volumes > 50GB
Cc:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
In-Reply-To: <20211027201441.3813178-5-shr@fb.com>
References: <20211027201441.3813178-1-shr@fb.com> <20211027201441.3813178-5-shr@fb.com>
Message-Id: <20211028091453.E622.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> This increases the metadata default allocation size from 1GB to 5GB for
> volumes with a size greater than 50GB.

If we change the metadata allocation size from 1GB to 5GB, then we have
less frequency that the unused metadata space is under 32M.

Could we begin to alloc metadata space with the size 1G after unused
metadata space is under 32M?  Is this a better way?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/28


> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 570acfebeae4..1314b0924512 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -195,7 +195,7 @@ static u64 compute_stripe_size_regular(struct btrfs_fs_info *info, u64 flags)
>  
>  	/* Handle BTRFS_BLOCK_GROUP_METADATA */
>  	if (info->fs_devices->total_rw_bytes > 50ULL * SZ_1G)
> -		return SZ_1G;
> +		return 5ULL * SZ_1G;
>  
>  	return SZ_256M;
>  }
> -- 
> 2.30.2


