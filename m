Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4345C597FBB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 10:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243928AbiHRIEd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Aug 2022 04:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240356AbiHRIEc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Aug 2022 04:04:32 -0400
Received: from out20-39.mail.aliyun.com (out20-39.mail.aliyun.com [115.124.20.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF54A5789A
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Aug 2022 01:04:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04441344|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.018584-5.4212e-05-0.981362;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.Ow66vMI_1660809863;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.Ow66vMI_1660809863)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 16:04:23 +0800
Date:   Thu, 18 Aug 2022 16:04:25 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix the max chunk size and stripe length calculation
Cc:     linux-btrfs@vger.kernel.org
In-Reply-To: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
References: <17e7c38b0cc6fe90c90f4b383734c06eafd2f9b5.1660806386.git.wqu@suse.com>
Message-Id: <20220818160425.511E.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

> [BEHAVIOR CHANGE]
> Since commit f6fca3917b4d ("btrfs: store chunk size in space-info
> struct"), btrfs no longer can create larger data chunks than 1G:
> 
>   mkfs.btrfs -f -m raid1 -d raid0 $dev1 $dev2 $dev3 $dev4
>   mount $dev1 $mnt
> 
>   btrfs balance start --full $mnt
>   btrfs balance start --full $mnt
>   umount $mnt
> 
>   btrfs ins dump-tree -t chunk $dev1 | grep "DATA|RAID0" -C 2
> 
> Before that offending commit, what we got is a 4G data chunk:
> 
> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 itemsize 176
> 		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 
> Now what we got is only 1G data chunk:
> 
> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 6271533056) itemoff 15491 itemsize 176
> 		length 1073741824 owner 2 stripe_len 65536 type DATA|RAID0
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 
> This will increase the number of data chunks by the number of devices,
> not only increase system chunk usage, but also greatly increase mount
> time.
> 
> Without a properly reason, we should not change the max chunk size.
> 
> [CAUSE]
> Previously, we set max data chunk size to 10G, while max data stripe
> length to 1G.
> 
> Commit f6fca3917b4d ("btrfs: store chunk size in space-info struct")
> completely ignored the 10G limit, but use 1G max stripe limit instead,
> causing above shrink in max data chunk size.
> 
> [FIX]
> Fix the max data chunk size to 10G, and in decide_stripe_size_regular()
> we limit stripe_size to 1G manually.
> 
> This should only affect data chunks, as for metadata chunks we always
> set the max stripe size the same as max chunk size (256M or 1G
> depending on fs size).
> 
> Now the same script result the same old result:
> 
> 	item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 9492758528) itemoff 15491 itemsize 176
> 		length 4294967296 owner 2 stripe_len 65536 type DATA|RAID0
> 		io_align 65536 io_width 65536 sector_size 4096
> 		num_stripes 4 sub_stripes 1
> 
> Reported-by: Wang Yugui <wangyugui@e16-tech.com>
> Fixes: f6fca3917b4d ("btrfs: store chunk size in space-info struct")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/space-info.c | 2 +-
>  fs/btrfs/volumes.c    | 3 +++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 477e57ace48d..b74bc31e9a8e 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -199,7 +199,7 @@ static u64 calc_chunk_size(const struct btrfs_fs_info *fs_info, u64 flags)
>  	ASSERT(flags & BTRFS_BLOCK_GROUP_TYPE_MASK);
>  
>  	if (flags & BTRFS_BLOCK_GROUP_DATA)
> -		return SZ_1G;
> +		return BTRFS_MAX_DATA_CHUNK_SIZE;
>  	else if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
>  		return SZ_32M;
>  
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 8c64dda69404..e0fd1aecf447 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -5264,6 +5264,9 @@ static int decide_stripe_size_regular(struct alloc_chunk_ctl *ctl,
>  				       ctl->stripe_size);
>  	}
>  
> +	/* Stripe size should never go beyond 1G. */

Currently we  limit  the stripe size to SIZE_1G.

Is there some technical limit such as 'used as signed 32bit, so max
SIZE_1G or SIZE_2G?' or 'used as unsigned 32bit, so max SIZE_2G or
SIZE_4G?'

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/08/18


> +	ctl->stripe_size = min_t(u64, ctl->stripe_size, SZ_1G);
> +
>  	/* Align to BTRFS_STRIPE_LEN */
>  	ctl->stripe_size = round_down(ctl->stripe_size, BTRFS_STRIPE_LEN);
>  	ctl->chunk_size = ctl->stripe_size * data_stripes;
> -- 
> 2.37.1


