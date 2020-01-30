Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE1914DC4D
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jan 2020 14:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgA3Nvt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jan 2020 08:51:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:43294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA3Nvs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jan 2020 08:51:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 252D7B07B;
        Thu, 30 Jan 2020 13:51:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1920DDA84C; Thu, 30 Jan 2020 14:51:27 +0100 (CET)
Date:   Thu, 30 Jan 2020 14:51:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 01/11] btrfs: Perform pinned cleanup directly in
 btrfs_destroy_delayed_refs
Message-ID: <20200130135127.GQ3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-2-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120140918.15647-2-nborisov@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 20, 2020 at 04:09:08PM +0200, Nikolay Borisov wrote:
> Having btrfs_destroy_delayed_refs call btrfs_pin_extent is problematic
> for making pinned extents tracking per-transaction since
> btrfs_trans_handle cannot be passed to btrfs_pin_extent in this context.
> Additionally delayed refs heads pinned in btrfs_destroy_delayed_refs
> are going to be handled very closely, in btrfs_destroy_pinned_extent.
> 
> To enable btrfs_pin_extent to take btrfs_trans_handle simply open code
> it in btrfs_destroy_delayed_refs and call btrfs_error_unpin_extent_range
> on the range. This enables us to do less work in
> btrfs_destroy_pinned_extent and leaves btrfs_pin_extent being called in
> contexts which have a valid btrfs_trans_handle.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  fs/btrfs/disk-io.c | 26 +++++++++++++++++++++++---
>  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 5ce2801f8388..9209c7b0997c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -42,6 +42,7 @@
>  #include "ref-verify.h"
>  #include "block-group.h"
>  #include "discard.h"
> +#include "space-info.h"
>  
>  #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
>  				 BTRFS_HEADER_FLAG_RELOC |\
> @@ -4261,9 +4262,28 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
>  		spin_unlock(&delayed_refs->lock);
>  		mutex_unlock(&head->mutex);
>  
> -		if (pin_bytes)
> -			btrfs_pin_extent(fs_info, head->bytenr,
> -					 head->num_bytes, 1);
> +		if (pin_bytes) {
> +			struct btrfs_block_group *cache;
> +			cache = btrfs_lookup_block_group(fs_info, head->bytenr);
> +			BUG_ON(!cache);

So this BUG_ON is propagated from btrfs_pin_extent but not turned into
proper error handling in any of the followup patches.

> +
> +			spin_lock(&cache->space_info->lock);
> +			spin_lock(&cache->lock);
> +			cache->pinned += head->num_bytes;
> +			btrfs_space_info_update_bytes_pinned(fs_info,
> +					cache->space_info, head->num_bytes);
> +			cache->reserved -= head->num_bytes;
> +			cache->space_info->bytes_reserved -= head->num_bytes;
> +			spin_unlock(&cache->lock);
> +			spin_unlock(&cache->space_info->lock);
> +			percpu_counter_add_batch(&cache->space_info->total_bytes_pinned,
> +				    head->num_bytes, BTRFS_TOTAL_BYTES_PINNED_BATCH);
> +
> +			btrfs_put_block_group(cache);
> +
> +			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
> +						       head->bytenr + head->num_bytes - 1);

This should also handle errors

> +		}
>  		btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
>  		btrfs_put_delayed_ref_head(head);
>  		cond_resched();
> -- 
> 2.17.1
