Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11265180D60
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Mar 2020 02:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgCKBPX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 21:15:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:59078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbgCKBPW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 21:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D7212AD08;
        Wed, 11 Mar 2020 01:15:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E189DDA7A7; Wed, 11 Mar 2020 02:14:52 +0100 (CET)
Date:   Wed, 11 Mar 2020 02:14:52 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: Optimise space flushing machinery
Message-ID: <20200311011452.GF12659@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200310090035.16676-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310090035.16676-1-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Mar 10, 2020 at 11:00:35AM +0200, Nikolay Borisov wrote:
> Instead of iterating all pending tickets on the normal/priority list to
> sum their total size the cost can be amortized across ticket addition/
> removal. This turns O(n) + O(m) (where n is the size of the normal list
> and m of the priority list) into O(1). This will mostly have effect in workloads
> that experience heavy flushing.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Added to misc-next, thanks.

> ---
>  fs/btrfs/space-info.c | 13 ++++++++-----
>  fs/btrfs/space-info.h |  4 ++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 9cb511d8cd9d..316a724dc990 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -389,6 +389,8 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
>  							      space_info,
>  							      ticket->bytes);
>  			list_del_init(&ticket->list);
> +			ASSERT(space_info->reclaim_size >= ticket->bytes);
> +			space_info->reclaim_size -= ticket->bytes;
>  			ticket->bytes = 0;
>  			space_info->tickets_id++;
>  			wake_up(&ticket->wait);
> @@ -784,16 +786,15 @@ static inline u64
>  btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
>  				 struct btrfs_space_info *space_info)
>  {
> -	struct reserve_ticket *ticket;
>  	u64 used;
>  	u64 avail;
>  	u64 expected;
>  	u64 to_reclaim = 0;
> 
> -	list_for_each_entry(ticket, &space_info->tickets, list)
> -		to_reclaim += ticket->bytes;
> -	list_for_each_entry(ticket, &space_info->priority_tickets, list)
> -		to_reclaim += ticket->bytes;
> +	lockdep_assert_held(&space_info->lock);

This can potentially save cachelines when the list traversal is avoided
as we're interested in just the sum of some data and the tickets are not
touched anywhere in this function callgraph.

> +
> +	if (space_info->reclaim_size)
> +		return space_info->reclaim_size;
> 
>  	avail = calc_available_free_space(fs_info, space_info,
>  					  BTRFS_RESERVE_FLUSH_ALL);
> @@ -1192,8 +1193,10 @@ static int __reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
>  	 * the list and we will do our own flushing further down.
>  	 */
>  	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
> +		ASSERT(space_info->reclaim_size >= 0);
>  		ticket.bytes = orig_bytes;
>  		ticket.error = 0;
> +		space_info->reclaim_size += ticket.bytes;
>  		init_waitqueue_head(&ticket.wait);
>  		if (flush == BTRFS_RESERVE_FLUSH_ALL) {
>  			list_add_tail(&ticket.list, &space_info->tickets);
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 24514cd2c6c1..0e68a6dd2a79 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -54,6 +54,10 @@ struct btrfs_space_info {
>  	struct list_head ro_bgs;
>  	struct list_head priority_tickets;
>  	struct list_head tickets;
> +
> +	u64 reclaim_size; /* Size of space that needs to be reclaimed in order
> +			     to satisfy pending tickets */

Please use comment-before-member format.
