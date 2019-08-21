Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC6397257
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2019 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbfHUGjH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Aug 2019 02:39:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:48486 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726741AbfHUGjH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Aug 2019 02:39:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 67D92ADBB;
        Wed, 21 Aug 2019 06:39:05 +0000 (UTC)
Subject: Re: [PATCH 5/5] btrfs: add enospc debug messages for ticket failure
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <20190816152019.1962-1-josef@toxicpanda.com>
 <20190816152019.1962-6-josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <09dbb66d-9b23-5b3b-7f91-fdfad6a0202d@suse.com>
Date:   Wed, 21 Aug 2019 09:39:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816152019.1962-6-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 16.08.19 г. 18:20 ч., Josef Bacik wrote:
> When debugging weird enospc problems it's handy to be able to dump the
> space info when we wake up all tickets, and see what the ticket values
> are.  This helped me figure out cases where we were enospc'ing when we
> shouldn't have been.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

With the suggestion below implemented you can add:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/space-info.c | 32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 3d3f301bae26..2819fa91c4f0 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -256,14 +256,9 @@ do {									\
>  	spin_unlock(&__rsv->lock);					\
>  } while (0)
>  
> -void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
> -			   struct btrfs_space_info *info, u64 bytes,
> -			   int dump_block_groups)
> +static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
> +				    struct btrfs_space_info *info)
>  {
> -	struct btrfs_block_group_cache *cache;
> -	int index = 0;
> -
> -	spin_lock(&info->lock);

lockdep_assert_held please

>  	btrfs_info(fs_info, "space_info %llu has %llu free, is %sfull",
>  		   info->flags,
>  		   info->total_bytes - btrfs_space_info_used(info, true),
> @@ -273,7 +268,6 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>  		info->total_bytes, info->bytes_used, info->bytes_pinned,
>  		info->bytes_reserved, info->bytes_may_use,
>  		info->bytes_readonly);
> -	spin_unlock(&info->lock);
>  
>  	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);
> @@ -281,6 +275,19 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>  	DUMP_BLOCK_RSV(fs_info, delayed_block_rsv);
>  	DUMP_BLOCK_RSV(fs_info, delayed_refs_rsv);
>  
> +}
> +
> +void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
> +			   struct btrfs_space_info *info, u64 bytes,
> +			   int dump_block_groups)
> +{
> +	struct btrfs_block_group_cache *cache;
> +	int index = 0;
> +
> +	spin_lock(&info->lock);
> +	__btrfs_dump_space_info(fs_info, info);
> +	spin_unlock(&info->lock);
> +
>  	if (!dump_block_groups)
>  		return;
>  
> @@ -685,6 +692,11 @@ static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
>  	u64 tickets_id = space_info->tickets_id;
>  	u64 first_ticket_bytes = 0;
>  
> +	if (btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
> +		btrfs_info(fs_info, "cannot satisfy tickets, dumping space info");
> +		__btrfs_dump_space_info(fs_info, space_info);
> +	}
> +
>  	while (!list_empty(&space_info->tickets) &&
>  	       tickets_id == space_info->tickets_id) {
>  		ticket = list_first_entry(&space_info->tickets,
> @@ -705,6 +717,10 @@ static bool wake_all_tickets(struct btrfs_fs_info *fs_info,
>  		else if (first_ticket_bytes > ticket->bytes)
>  			return true;
>  
> +		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> +			btrfs_info(fs_info, "failing ticket with %llu bytes",
> +				   ticket->bytes);
> +
>  		list_del_init(&ticket->list);
>  		ticket->error = -ENOSPC;
>  		wake_up(&ticket->wait);
> 
