Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B0C44BAEC
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 06:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhKJFFZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 00:05:25 -0500
Received: from out20-26.mail.aliyun.com ([115.124.20.26]:53957 "EHLO
        out20-26.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhKJFFY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 00:05:24 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1037303|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0102081-3.7008e-05-0.989755;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.LqQJW62_1636520555;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LqQJW62_1636520555)
          by smtp.aliyun-inc.com(10.147.41.143);
          Wed, 10 Nov 2021 13:02:35 +0800
Date:   Wed, 10 Nov 2021 13:02:39 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH v5 4/4] btrfs: increase metadata alloc size to 5GB for volumes > 50GB
Cc:     <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
In-Reply-To: <20211109220218.602995-5-shr@fb.com>
References: <20211109220218.602995-1-shr@fb.com> <20211109220218.602995-5-shr@fb.com>
Message-Id: <20211110130238.79C3.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

We chose  5ULL * SZ_1G because it is a half of
BTRFS_MAX_DATA_CHUNK_SIZE(10G)?

A same chunk size of data/metadata maybe better for long-term alloc/free?
so the following mabye better.

 	/* Handle BTRFS_BLOCK_GROUP_METADATA */
 	if (info->fs_devices->total_rw_bytes > 2048ULL * SZ_1G)
-		return SZ_1G;
+		return BTRFS_MAX_DATA_CHUNK_SIZE;

by the way, we need to update btrfs-progs to apply this new policy from
mkfs.btrfs.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/11/10

> This increases the metadata default allocation size from 1GB to 5GB for
> volumes with a size greater than 50GB.
> 
> Signed-off-by: Stefan Roesch <shr@fb.com>
> ---
>  fs/btrfs/space-info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 3a31aea701a8..0d0accbe3bfb 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -195,7 +195,7 @@ static u64 compute_chunk_size_regular(struct btrfs_fs_info *info, u64 flags)
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


