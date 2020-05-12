Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FA1D01C5
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 May 2020 00:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgELWTN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 18:19:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728314AbgELWTN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 18:19:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3FA7AAB99;
        Tue, 12 May 2020 22:19:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5CB98DA70B; Wed, 13 May 2020 00:18:20 +0200 (CEST)
Date:   Wed, 13 May 2020 00:18:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] fs: btrfs: fix a data race in
 btrfs_block_rsv_release()
Message-ID: <20200512221820.GF18421@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Jia-Ju Bai <baijiaju1990@gmail.com>,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200509053431.3860-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509053431.3860-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 09, 2020 at 01:34:31PM +0800, Jia-Ju Bai wrote:
> The functions btrfs_block_rsv_release() and
> btrfs_update_delayed_refs_rsv() are concurrently executed at runtime in
> the following call contexts:
> 
> Thread 1:
>   btrfs_file_write_iter()
>     btrfs_buffered_write()
>       btrfs_delalloc_release_extents()
>         btrfs_inode_rsv_release()
>           __btrfs_block_rsv_release()
> 
> Thread 2:
>   finish_ordered_fn()
>     btrfs_finish_ordered_io()
>       insert_reserved_file_extent()
>         __btrfs_drop_extents()
>           btrfs_free_extent()
>             btrfs_add_delayed_data_ref()
>               btrfs_update_delayed_refs_rsv()
> 
> In __btrfs_block_rsv_release():
>   else if (... && !delayed_rsv->full)
> 
> In btrfs_update_delayed_refs_rsv():
>   spin_lock(&delayed_rsv->lock);
>   delayed_rsv->size += num_bytes;
>   delayed_rsv->full = 0;
>   spin_unlock(&delayed_rsv->lock);
> 
> Thus a data race for delayed_rsv->full can occur.
> This race was found and actually reproduced by our conccurency fuzzer.
> 
> To fix this race, the spinlock delayed_rsv->lock is used to
> protect the access to delayed_rsv->full in btrfs_block_rsv_release().
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  fs/btrfs/block-rsv.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
> index 27efec8f7c5b..89c53a7137b4 100644
> --- a/fs/btrfs/block-rsv.c
> +++ b/fs/btrfs/block-rsv.c
> @@ -277,6 +277,11 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
>  	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
>  	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_refs_rsv;
>  	struct btrfs_block_rsv *target = NULL;
> +	unsigned short full = 0;
> +
> +	spin_lock(&delayed_rsv->lock);
> +	full = delayed_rsv->full;
> +	spin_unlock(&delayed_rsv->lock);
>  
>  	/*
>  	 * If we are the delayed_rsv then push to the global rsv, otherwise dump
> @@ -284,7 +289,7 @@ u64 btrfs_block_rsv_release(struct btrfs_fs_info *fs_info,
>  	 */
>  	if (block_rsv == delayed_rsv)
>  		target = global_rsv;
> -	else if (block_rsv != global_rsv && !delayed_rsv->full)
> +	else if (block_rsv != global_rsv && !full)

This has been reported as suspicous
https://lore.kernel.org/linux-btrfs/CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com/

and there's an answer that this is racy but does not cause any
unexpected behaviour.
