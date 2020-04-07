Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB511A0CE9
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Apr 2020 13:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDGLeD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Apr 2020 07:34:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:48018 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDGLeC (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Apr 2020 07:34:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EF113ACCA;
        Tue,  7 Apr 2020 11:33:58 +0000 (UTC)
Subject: Re: [PATCH 1/2] Btrfs: fix reclaim counter leak of space_info objects
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200407103849.28086-1-fdmanana@kernel.org>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <40fdffbf-133a-0bc5-0fdf-759b03ce90a0@suse.com>
Date:   Tue, 7 Apr 2020 14:33:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407103849.28086-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7.04.20 г. 13:38 ч., fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Whenever we add a ticket to a space_info object we increment the object's
> reclaim_size counter witht the ticket's bytes, and we decrement it with
> the corresponding amount only when we are able to grant the requested
> space to the ticket. When we are not able to grant the space to a ticket,
> or when the ticket is removed due to a signal (e.g. an application has
> received sigterm from the terminal) we never decrement the counter with
> the corresponding bytes from the ticket. This leak can result in the
> space reclaim code to later do much more work than necessary. So fix it
> by decrementing the counter when those two cases happen as well.
> 
> Fixes: db161806dc5615 ("btrfs: account ticket size at add/delete time")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Doh, you are correct. I especially like it you've actually factored
ticket removal into a function.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/block-group.c |  1 +
>  fs/btrfs/space-info.c  | 20 ++++++++++++++------
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 786849fcc319..47f66c6a7d7f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3370,6 +3370,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
>  			    space_info->bytes_reserved > 0 ||
>  			    space_info->bytes_may_use > 0))
>  			btrfs_dump_space_info(info, space_info, 0, 0);
> +		WARN_ON(space_info->reclaim_size > 0);
>  		list_del(&space_info->list);
>  		btrfs_sysfs_remove_space_info(space_info);
>  	}
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 8b0fe053a25d..ff17a4420358 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -361,6 +361,16 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
>  	return 0;
>  }
>  
> +static void remove_ticket(struct btrfs_space_info *space_info,
> +			  struct reserve_ticket *ticket)
> +{
> +	if (!list_empty(&ticket->list)) {
> +		list_del_init(&ticket->list);
> +		ASSERT(space_info->reclaim_size >= ticket->bytes);
> +		space_info->reclaim_size -= ticket->bytes;
> +	}
> +}
> +
>  /*
>   * This is for space we already have accounted in space_info->bytes_may_use, so
>   * basically when we're returning space from block_rsv's.
> @@ -388,9 +398,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
>  			btrfs_space_info_update_bytes_may_use(fs_info,
>  							      space_info,
>  							      ticket->bytes);
> -			list_del_init(&ticket->list);
> -			ASSERT(space_info->reclaim_size >= ticket->bytes);
> -			space_info->reclaim_size -= ticket->bytes;
> +			remove_ticket(space_info, ticket);
>  			ticket->bytes = 0;
>  			space_info->tickets_id++;
>  			wake_up(&ticket->wait);
> @@ -899,7 +907,7 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
>  			btrfs_info(fs_info, "failing ticket with %llu bytes",
>  				   ticket->bytes);
>  
> -		list_del_init(&ticket->list);
> +		remove_ticket(space_info, ticket);
>  		ticket->error = -ENOSPC;
>  		wake_up(&ticket->wait);
>  
> @@ -1063,7 +1071,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
>  			 * despite getting an error, resulting in a space leak
>  			 * (bytes_may_use counter of our space_info).
>  			 */
> -			list_del_init(&ticket->list);
> +			remove_ticket(space_info, ticket);
>  			ticket->error = -EINTR;
>  			break;
>  		}
> @@ -1121,7 +1129,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
>  		 * either the async reclaim job deletes the ticket from the list
>  		 * or we delete it ourselves at wait_reserve_ticket().
>  		 */
> -		list_del_init(&ticket->list);
> +		remove_ticket(space_info, ticket);
>  		if (!ret)
>  			ret = -ENOSPC;
>  	}
> 
