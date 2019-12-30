Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6296112D316
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 19:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfL3SIM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 13:08:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:42572 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726602AbfL3SIM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 13:08:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2C0CDAB91;
        Mon, 30 Dec 2019 18:08:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5094DDA790; Mon, 30 Dec 2019 19:08:03 +0100 (CET)
Date:   Mon, 30 Dec 2019 19:08:03 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 15/22] btrfs: limit max discard size for async discard
Message-ID: <20191230180803.GB3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <396e2d043068b620574892ebfc4b9f5c77b41618.1576195673.git.dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396e2d043068b620574892ebfc4b9f5c77b41618.1576195673.git.dennis@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 13, 2019 at 04:22:24PM -0800, Dennis Zhou wrote:
> Throttle the maximum size of a discard so that we can provide an upper
> bound for the rate of async discard. While the block layer is able to
> split discards into the appropriate sized discards, we want to be able
> to account more accurately the rate at which we are consuming ncq slots
> as well as limit the upper bound of work for a discard.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/discard.h          |  5 ++++
>  fs/btrfs/free-space-cache.c | 48 +++++++++++++++++++++++++++----------
>  2 files changed, 41 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
> index 3ed6855e24da..cb6ef0ab879d 100644
> --- a/fs/btrfs/discard.h
> +++ b/fs/btrfs/discard.h
> @@ -3,10 +3,15 @@
>  #ifndef BTRFS_DISCARD_H
>  #define BTRFS_DISCARD_H
>  
> +#include <linux/sizes.h>
> +
>  struct btrfs_fs_info;
>  struct btrfs_discard_ctl;
>  struct btrfs_block_group;
>  
> +/* Discard size limits. */
> +#define BTRFS_ASYNC_DISCARD_MAX_SIZE	(SZ_64M)
> +
>  /* Work operations. */
>  void btrfs_discard_cancel_work(struct btrfs_discard_ctl *discard_ctl,
>  			       struct btrfs_block_group *block_group);
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 57df34480b93..0dbcea6c59f9 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -3466,19 +3466,40 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
>  		if (entry->offset >= end)
>  			goto out_unlock;
>  
> -		extent_start = entry->offset;
> -		extent_bytes = entry->bytes;
> -		extent_trim_state = entry->trim_state;
> -		start = max(start, extent_start);
> -		bytes = min(extent_start + extent_bytes, end) - start;
> -		if (bytes < minlen) {
> -			spin_unlock(&ctl->tree_lock);
> -			mutex_unlock(&ctl->cache_writeout_mutex);
> -			goto next;
> -		}
> +		if (async) {
> +			start = extent_start = entry->offset;
> +			bytes = extent_bytes = entry->bytes;
> +			extent_trim_state = entry->trim_state;
> +			if (bytes < minlen) {
> +				spin_unlock(&ctl->tree_lock);
> +				mutex_unlock(&ctl->cache_writeout_mutex);
> +				goto next;
> +			}
> +			unlink_free_space(ctl, entry);
> +			if (bytes > BTRFS_ASYNC_DISCARD_MAX_SIZE) {
> +				bytes = extent_bytes =
> +					BTRFS_ASYNC_DISCARD_MAX_SIZE;
> +				entry->offset += BTRFS_ASYNC_DISCARD_MAX_SIZE;
> +				entry->bytes -= BTRFS_ASYNC_DISCARD_MAX_SIZE;
> +				link_free_space(ctl, entry);
> +			} else {
> +				kmem_cache_free(btrfs_free_space_cachep, entry);
> +			}
> +		} else {

> +			extent_start = entry->offset;
> +			extent_bytes = entry->bytes;
> +			extent_trim_state = entry->trim_state;

This is common initialization for both async and sync cases so it could
be merged to a common block.

> +			start = max(start, extent_start);
> +			bytes = min(extent_start + extent_bytes, end) - start;
> +			if (bytes < minlen) {
> +				spin_unlock(&ctl->tree_lock);
> +				mutex_unlock(&ctl->cache_writeout_mutex);
> +				goto next;
> +			}
