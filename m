Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C5504CF4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 09:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiDRHGY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 03:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbiDRHGW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 03:06:22 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6978C38BE
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650265423; x=1681801423;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G1bt5Hk1w0SPXZbil96YK+rlTvbg5HeM9sSjnrlau9g=;
  b=GIbuC9c5GNuKtEPCj3HoFAObwYaliyG7uXr3GcPmSJYKY8FTU+4trTOA
   1XA9g7ZBEXtLcsH05ZLhFpmuR5d4xxaQ4ia3BiX3CUCExkfXa20fBJDVp
   kfKJx+/3ofoiZuAhUCexhPEVszA+Z2r/bzmGwjqY/bEiUtQ9ybkyqNZbL
   pChl1NDNiosiLeNTANNsCNejpeNStu70jQ3/tJblJQhCf6O1+oNBpmapx
   UPPo/H3Jmlz6T2Ga/Hl+CHBxvi43G79fjKWviHaoJXaBziNqo+SbO8mgT
   nrCv2XmhK5sX7udTPxjDH1D8ZvCk3Bfm4+L5J3PUA/TT6ZbUoCJ/sSiQZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; 
   d="scan'208";a="203010245"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 15:03:42 +0800
IronPort-SDR: NeIdfma5nJhFsTCFkXq54A9OEUyFJ5RTYgpQSLLAVPgT7JvXrODNDVB+olQJ5esQZw2Hag3h3J
 WnCrwZPAr1bdFcbyD60UPR98yrrpYiujZwHSMz4G7gshxWB4o4A1V4DQgp83b1+FYEDfXhbtSc
 iFQS+6ihCayQ/exjNTOhvY7H/kWvOrwAJK6ybwsBo601i9drOFm3+lJSzB+rhvH0mgBxtAFSKE
 hs3LG/p54LnrjzyXO8rBxJ2234MQuge0q939fUplauo8doAx6MlCEkR/N1x0saxC8qPsMa052q
 0JpIkIekRANooThqlVw0C0qA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Apr 2022 23:34:50 -0700
IronPort-SDR: OPA81LG5/YFTRRQiWFTRrf5J1t7WlpM7VNV+/z9/VJNP1RlQWXag+yvZSVYpJdQSOoMoPG1oRD
 TRPGoaHBJDGXrza7SUDhO0FP57/cEPBWRWfiRdw9w3YtgqCaCAPCWXjAMnA2NvObCWoXRKBWOc
 jRYpHC2Umv5rH00duCUAgs6BQ1ZsoXyDAXChBkWDhx5MqkeukjRTVC0O5vAOU48OXxddn3j2EU
 +XKaLqAngpSlDg9qwdqb4xP7anLBbnQPAGrAbJAJnPHVLUSURs6pRFph2sHhBR2z4BmbBISIjU
 83s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Apr 2022 00:03:44 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhdFW2cYJz1Rwrw
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 00:03:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650265423; x=1652857424; bh=G1bt5Hk1w0SPXZbil96YK+rlTvbg5HeM9sS
        jnrlau9g=; b=Vt+IGvLXumTeyOLBVRETUuiERHWzxdjaDzFn1TGeDN46k/MtNQS
        BIlZ+KOqvlnC8axbuJLCiMDl3rVIAZDshZqU+BeF4qR448R2LQOfouJpW5xOIUvi
        nlg4ThTHT3dm46YmyLv4YKfBaTYUzuFJYKtnzBrvcVJ8DKHutGyXPahjZfUv7aoo
        /oRKAeaGdxsmACPxfE87EyBo7CZvRnXJiTHpc6mUy89bR63n2AtSH+AexgRYEGzZ
        BVDSI+D4NTsy3kP99KLC9Cy6DEFXWMcHC5tek9jzr4dNIDV3KvhyEmymqOSgHb5J
        CLZFeUhEk5f1G2Ki/rzJKCIWY/CMIky6PHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y8mkLxWSROUG for <linux-btrfs@vger.kernel.org>;
        Mon, 18 Apr 2022 00:03:43 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhdFV3SWMz1Rvlx;
        Mon, 18 Apr 2022 00:03:42 -0700 (PDT)
Message-ID: <10c8e04b-57fd-a656-5242-17a3c57345f2@opensource.wdc.com>
Date:   Mon, 18 Apr 2022 16:03:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs: zoned: use dedicated lock for data relocation
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     johannes.thumshirn@wdc.com
References: <1ad4d3f6ed32ab2d3352adb6da7ba4ff049e79a0.1650257630.git.naohiro.aota@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1ad4d3f6ed32ab2d3352adb6da7ba4ff049e79a0.1650257630.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/18/22 14:50, Naohiro Aota wrote:
> Currently, we use btrfs_inode_{lock,unlock}() to grant an exclusive
> writeback of the relocation data inode in
> btrfs_zoned_data_reloc_{lock,unlock}(). However, that can cause a deadlock
> in the following path.
> 
> Thread A takes btrfs_inode_lock() and waits for metadata reservation by
> e.g, waiting for writeback:
> 
> prealloc_file_extent_cluster()
>   - btrfs_inode_lock(&inode->vfs_inode, 0);
>   - btrfs_prealloc_file_range()
>   ...
>     - btrfs_replace_file_extents()
>       - btrfs_start_transaction
>       ...
>         - btrfs_reserve_metadata_bytes()
> 
> Thread B (e.g, doing a writeback work) needs to wait for the inode lock to
> continue writeback process:
> 
> do_writepages
>   - btrfs_writepages
>     - extent_writpages
>       - btrfs_zoned_data_reloc_lock(BTRFS_I(inode));
>         - btrfs_inode_lock()
> 
> The deadlock is caused by relying on the vfs_inode's lock. By using it, we
> introduced unnecessary exclusion of writeback and
> btrfs_prealloc_file_range(). Also, the lock at this point is useless as we
> don't have any dirty pages in the inode yet.
> 
> Introduce fs_info->zoned_data_reloc_io_lock and use it for the exclusive
> writeback.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Fixes tag ?
Cc stable ?

Since this is fixing a deadlock, these tags are necessary, no ?

> ---
>  fs/btrfs/ctree.h   | 1 +
>  fs/btrfs/disk-io.c | 1 +
>  fs/btrfs/zoned.h   | 4 ++--
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 55dee124ee44..580a392d7c37 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -1056,6 +1056,7 @@ struct btrfs_fs_info {
>  	 */
>  	spinlock_t relocation_bg_lock;
>  	u64 data_reloc_bg;
> +	struct mutex zoned_data_reloc_io_lock;
>  
>  	u64 nr_global_roots;
>  
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 2689e8589627..2a0284c2430e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3179,6 +3179,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>  	mutex_init(&fs_info->reloc_mutex);
>  	mutex_init(&fs_info->delalloc_root_mutex);
>  	mutex_init(&fs_info->zoned_meta_io_lock);
> +	mutex_init(&fs_info->zoned_data_reloc_io_lock);
>  	seqlock_init(&fs_info->profiles_lock);
>  
>  	INIT_LIST_HEAD(&fs_info->dirty_cowonly_roots);
> diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
> index fc2034e66ce3..de923fc8449d 100644
> --- a/fs/btrfs/zoned.h
> +++ b/fs/btrfs/zoned.h
> @@ -361,7 +361,7 @@ static inline void btrfs_zoned_data_reloc_lock(struct btrfs_inode *inode)
>  	struct btrfs_root *root = inode->root;
>  
>  	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
> -		btrfs_inode_lock(&inode->vfs_inode, 0);
> +		mutex_lock(&root->fs_info->zoned_data_reloc_io_lock);
>  }
>  
>  static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
> @@ -369,7 +369,7 @@ static inline void btrfs_zoned_data_reloc_unlock(struct btrfs_inode *inode)
>  	struct btrfs_root *root = inode->root;
>  
>  	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
> -		btrfs_inode_unlock(&inode->vfs_inode, 0);
> +		mutex_unlock(&root->fs_info->zoned_data_reloc_io_lock);
>  }
>  
>  #endif


-- 
Damien Le Moal
Western Digital Research
