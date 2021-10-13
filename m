Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931A742B709
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Oct 2021 08:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJMG0v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Oct 2021 02:26:51 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:34188 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhJMG0v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Oct 2021 02:26:51 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id 0A2576C00769;
        Wed, 13 Oct 2021 09:24:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1634106287; bh=KOPTzT+6EVNXf4DXw5oHk/VplwwK3wittt/UGoOYI0I=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=RpBrydWBDQP/gsxsfWbA3/o10JdyhzKeOSQbEzj3hnf5jtTcu1P2jfpmg9xDsplTc
         S0bRpPrwrXXeGyv9OPy2hGMciv3eMl5AKV6lhgBGVO2ZSS7RvE8YwVoOCfxpHqQ/C1
         vM93xQm5o0BsBJ7/B3oj4G0f7dcgAeYTHVp4vHdw=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id EEAB26C00757;
        Wed, 13 Oct 2021 09:24:46 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id Oroj3j-wT19U; Wed, 13 Oct 2021 09:24:46 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id A9B736C0050D;
        Wed, 13 Oct 2021 09:24:46 +0300 (EEST)
Received: from nas (unknown [49.65.91.9])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id CF5801BE2D03;
        Wed, 13 Oct 2021 09:24:44 +0300 (EEST)
References: <5f0f20b2b0ad9c608357f5f3db27c8e5a9714f80.1634104229.git.anand.jain@oracle.com>
User-agent: mu4e 1.7.0; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: reduce btrfs_update_block_group alloc argument
 to bool
Date:   Wed, 13 Oct 2021 14:24:07 +0800
In-reply-to: <5f0f20b2b0ad9c608357f5f3db27c8e5a9714f80.1634104229.git.anand.jain@oracle.com>
Message-ID: <fst5igrd.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: +d1m5/RSaUCpygHhXxmqCAcxrytLVO7k/+Gmsm5Un2eDUSOAd1YLVQ6+nHJ/UQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Wed 13 Oct 2021 at 14:05, Anand Jain <anand.jain@oracle.com> 
wrote:

> btrfs_update_block_group() accounts for the number of bytes 
> allocated or
> freed. Argument %alloc specifies whether the call is for alloc 
> or free.
> Convert the argument %alloc type from int to bool.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>
Reviewed-by: Su Yue <l@damenly.su>

--
Su
> ---
>  fs/btrfs/block-group.c | 2 +-
>  fs/btrfs/block-group.h | 2 +-
>  fs/btrfs/extent-tree.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 46fdef7bbe20..7dba9028c80c 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3160,7 +3160,7 @@ int btrfs_write_dirty_block_groups(struct 
> btrfs_trans_handle *trans)
>  }
>
>  int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> -			     u64 bytenr, u64 num_bytes, int alloc)
> +			     u64 bytenr, u64 num_bytes, bool alloc)
>  {
>  	struct btrfs_fs_info *info = trans->fs_info;
>  	struct btrfs_block_group *cache = NULL;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index f751b802b173..07f977d3816c 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -284,7 +284,7 @@ int btrfs_start_dirty_block_groups(struct 
> btrfs_trans_handle *trans);
>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle 
>  *trans);
>  int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
>  int btrfs_update_block_group(struct btrfs_trans_handle *trans,
> -			     u64 bytenr, u64 num_bytes, int alloc);
> +			     u64 bytenr, u64 num_bytes, bool alloc);
>  int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
>  			     u64 ram_bytes, u64 num_bytes, int delalloc);
>  void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index ec5de19f0acd..6e7c03261d78 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3195,7 +3195,7 @@ static int __btrfs_free_extent(struct 
> btrfs_trans_handle *trans,
>  			goto out;
>  		}
>
> -		ret = btrfs_update_block_group(trans, bytenr, num_bytes, 
> 0);
> +		ret = btrfs_update_block_group(trans, bytenr, num_bytes, 
> false);
>  		if (ret) {
>  			btrfs_abort_transaction(trans, ret);
>  			goto out;
> @@ -4629,7 +4629,7 @@ static int 
> alloc_reserved_file_extent(struct btrfs_trans_handle *trans,
>  	if (ret)
>  		return ret;
>
> -	ret = btrfs_update_block_group(trans, ins->objectid, 
> ins->offset, 1);
> +	ret = btrfs_update_block_group(trans, ins->objectid, 
> ins->offset, true);
>  	if (ret) { /* -ENOENT, logic error */
>  		btrfs_err(fs_info, "update block group failed for %llu 
>  %llu",
>  			ins->objectid, ins->offset);
> @@ -4718,7 +4718,7 @@ static int 
> alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
>  		return ret;
>
>  	ret = btrfs_update_block_group(trans, extent_key.objectid,
> -				       fs_info->nodesize, 1);
> +				       fs_info->nodesize, true);
>  	if (ret) { /* -ENOENT, logic error */
>  		btrfs_err(fs_info, "update block group failed for %llu 
>  %llu",
>  			extent_key.objectid, extent_key.offset);
