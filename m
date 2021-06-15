Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFF43A8322
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Jun 2021 16:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhFOOqY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Jun 2021 10:46:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44824 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhFOOqY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Jun 2021 10:46:24 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D28E321A65;
        Tue, 15 Jun 2021 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623768258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Th0416q2+KdoF86StzHPGX+ZjnCKgouwXmF86B7JW+4=;
        b=dbY6F9pNXJn2rrhIpX8k7qU9XgyNqHEAjaayuDfRJgErREl9vTrheu4OesfBX2AiKIRxfR
        m/59OJjzQd5Nc9stiqnZi99BmoLFR0EECegTwKAUokkL4uQrYb/SIY0tQEpvjDKA8oaaBZ
        zU9v60jNQUX2M5xdwnCVIvRiws/eUHM=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id A2B3E118DD;
        Tue, 15 Jun 2021 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623768258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Th0416q2+KdoF86StzHPGX+ZjnCKgouwXmF86B7JW+4=;
        b=dbY6F9pNXJn2rrhIpX8k7qU9XgyNqHEAjaayuDfRJgErREl9vTrheu4OesfBX2AiKIRxfR
        m/59OJjzQd5Nc9stiqnZi99BmoLFR0EECegTwKAUokkL4uQrYb/SIY0tQEpvjDKA8oaaBZ
        zU9v60jNQUX2M5xdwnCVIvRiws/eUHM=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 7wtuJcK8yGAXQgAALh3uQQ
        (envelope-from <nborisov@suse.com>); Tue, 15 Jun 2021 14:44:18 +0000
Subject: Re: [RFC PATCH 04/31] iomap: Introduce iomap_readpage_ops
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <ae9727cdb9e1a576e3e9e7e1410a0afe75422621.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <06fd3b39-8d0a-9c98-5938-80fe41f165b1@suse.com>
Date:   Tue, 15 Jun 2021 17:44:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <ae9727cdb9e1a576e3e9e7e1410a0afe75422621.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> iomap_readpage_ops provide additional functions to allocate or submit
> the bio.
> 
> alloc_bio() is used to allocate bio from the filesystem, in case of
> btrfs: to allocate btrfs_io_bio.
> 
> submit_io() similar to the one introduced with direct I/O, submits the
> bio.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/gfs2/aops.c         |  4 +--
>  fs/iomap/buffered-io.c | 56 +++++++++++++++++++++++++++++++-----------
>  fs/xfs/xfs_aops.c      |  4 +--
>  fs/zonefs/super.c      |  4 +--
>  include/linux/iomap.h  | 19 ++++++++++++--
>  5 files changed, 64 insertions(+), 23 deletions(-)
> 

<snip>

> @@ -282,19 +283,31 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		gfp_t orig_gfp = gfp;
>  		unsigned int nr_vecs = DIV_ROUND_UP(length, PAGE_SIZE);
>  
> -		if (ctx->bio)
> -			submit_bio(ctx->bio);
> +		if (ctx->bio) {
> +			if (ctx->ops && ctx->ops->submit_io)

here you check for the presence of ctx->ops && ctx->ops->some_op

> +				ctx->ops->submit_io(inode, ctx->bio);
> +			else
> +				submit_bio(ctx->bio);
> +		}
>  
>  		if (ctx->rac) /* same as readahead_gfp_mask */
>  			gfp |= __GFP_NORETRY | __GFP_NOWARN;
> -		ctx->bio = bio_alloc(gfp, bio_max_segs(nr_vecs));
> +		if (ctx->ops->alloc_bio)

but here you directly check for the presence of ctx->ops->some_op. The
correct should be to also check for ctx->ops since other filesystems
don't necessarily implement specific readops.

> +			ctx->bio = ctx->ops->alloc_bio(gfp,
> +					bio_max_segs(nr_vecs));
> +		else
> +			ctx->bio = bio_alloc(gfp, bio_max_segs(nr_vecs));
>  		/*
>  		 * If the bio_alloc fails, try it again for a single page to
>  		 * avoid having to deal with partial page reads.  This emulates
>  		 * what do_mpage_readpage does.
>  		 */
> -		if (!ctx->bio)
> -			ctx->bio = bio_alloc(orig_gfp, 1);
> +		if (!ctx->bio) {
> +			if (ctx->ops->alloc_bio)

ditto about checking for presence of ops.

> +				ctx->bio = ctx->ops->alloc_bio(orig_gfp, 1);
> +			else
> +				ctx->bio = bio_alloc(orig_gfp, 1);
> +		}
>  		ctx->bio->bi_opf = REQ_OP_READ;
>  		if (ctx->rac)
>  			ctx->bio->bi_opf |= REQ_RAHEAD;

<snip>

> @@ -336,7 +353,10 @@ iomap_readpage(struct page *page, const struct iomap_ops *ops)
>  	}
>  
>  	if (ctx.bio) {
> -		submit_bio(ctx.bio);
> +		if (ctx.ops->submit_io)

readpage_ops can be NULL so you should check for it as well.

> +			ctx.ops->submit_io(inode, ctx.bio);
> +		else
> +			submit_bio(ctx.bio);
>  		WARN_ON_ONCE(!ctx.cur_page_in_bio);
>  	} else {
>  		WARN_ON_ONCE(ctx.cur_page_in_bio);

<snip>
