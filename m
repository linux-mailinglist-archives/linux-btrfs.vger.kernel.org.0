Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFECC44D5C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 12:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbhKKL3T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 06:29:19 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35762 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhKKL3S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 06:29:18 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D6CFD1FD4A;
        Thu, 11 Nov 2021 11:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636629988;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wauzwbc82ei4yPOq21j6UlK3t+kq7+cWhLhxcUJdqcU=;
        b=y4q7sEbhm+j8ptEIbK1zBPX1BoXN3xQyzoRdyo1MHhnWIR8wH0vLPjZKrG2hIIqpXRmCUj
        A6jba9Pq4EbN21RJmzRgPHpiqu0DiyTzUY4wYctQpCuue8HmoIXWYxHiS+lrIpZ5zUPqlt
        kZBzQ6hToAGtfVWDWE9t9mz6WWhCCTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636629988;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wauzwbc82ei4yPOq21j6UlK3t+kq7+cWhLhxcUJdqcU=;
        b=ZvvNIrUM69YMNaXrVvR/K/FeciXtDkJMrShp2tCImie85Z+y6bDT8+KUoI9W6c0EvHYrff
        E76HIeeno7GyHfAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id CF655A3B83;
        Thu, 11 Nov 2021 11:26:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4EFF0DA799; Thu, 11 Nov 2021 12:26:28 +0100 (CET)
Date:   Thu, 11 Nov 2021 12:26:28 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v3] btrfs: index free space entries on size
Message-ID: <20211111112628.GX28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
References: <d69c29c8428a923d526aa2fe068d421d14667b47.1636408067.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d69c29c8428a923d526aa2fe068d421d14667b47.1636408067.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 08, 2021 at 04:49:17PM -0500, Josef Bacik wrote:
> Currently we index free space on offset only, because usually we have a
> hint from the allocator that we want to honor for locality reasons.
> However if we fail to use this hint we have to go back to a brute force
> search through the free space entries to find a large enough extent.
> 
> With sufficiently fragmented free space this becomes quite expensive, as
> we have to linearly search all of the free space entries to find if we
> have a part that's long enough.
> 
> To fix this add a cached rb tree to index based on free space entry
> bytes.  This will allow us to quickly look up the largest chunk in the
> free space tree for this block group, and stop searching once we've
> found an entry that is too small to satisfy our allocation.  We simply
> choose to use this tree if we're searching from the beginning of the
> block group, as we know we do not care about locality at that point.
> 
> I wrote an allocator test that creates a 10TiB ram backed null block
> device and then fallocates random files until the file system is full.
> I think go through and delete all of the odd files.  Then I spawn 8
> threads that fallocate 64mib files (1/2 our extent size cap) until the
> file system is full again.  I use bcc's funclatency to measure the
> latency of find_free_extent.  The baseline results are
> 
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 10356    |****                                    |
>        512 -> 1023       : 58242    |*************************               |
>       1024 -> 2047       : 74418    |********************************        |
>       2048 -> 4095       : 90393    |****************************************|
>       4096 -> 8191       : 79119    |***********************************     |
>       8192 -> 16383      : 35614    |***************                         |
>      16384 -> 32767      : 13418    |*****                                   |
>      32768 -> 65535      : 12811    |*****                                   |
>      65536 -> 131071     : 17090    |*******                                 |
>     131072 -> 262143     : 26465    |***********                             |
>     262144 -> 524287     : 40179    |*****************                       |
>     524288 -> 1048575    : 55469    |************************                |
>    1048576 -> 2097151    : 48807    |*********************                   |
>    2097152 -> 4194303    : 26744    |***********                             |
>    4194304 -> 8388607    : 35351    |***************                         |
>    8388608 -> 16777215   : 13918    |******                                  |
>   16777216 -> 33554431   : 21       |                                        |
> 
> avg = 908079 nsecs, total: 580889071441 nsecs, count: 639690
> 
> And the patch results are
> 
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                        |
>          2 -> 3          : 0        |                                        |
>          4 -> 7          : 0        |                                        |
>          8 -> 15         : 0        |                                        |
>         16 -> 31         : 0        |                                        |
>         32 -> 63         : 0        |                                        |
>         64 -> 127        : 0        |                                        |
>        128 -> 255        : 0        |                                        |
>        256 -> 511        : 6883     |**                                      |
>        512 -> 1023       : 54346    |*********************                   |
>       1024 -> 2047       : 79170    |********************************        |
>       2048 -> 4095       : 98890    |****************************************|
>       4096 -> 8191       : 81911    |*********************************       |
>       8192 -> 16383      : 27075    |**********                              |
>      16384 -> 32767      : 14668    |*****                                   |
>      32768 -> 65535      : 13251    |*****                                   |
>      65536 -> 131071     : 15340    |******                                  |
>     131072 -> 262143     : 26715    |**********                              |
>     262144 -> 524287     : 43274    |*****************                       |
>     524288 -> 1048575    : 53870    |*********************                   |
>    1048576 -> 2097151    : 55368    |**********************                  |
>    2097152 -> 4194303    : 41036    |****************                        |
>    4194304 -> 8388607    : 24927    |**********                              |
>    8388608 -> 16777215   : 33       |                                        |
>   16777216 -> 33554431   : 9        |                                        |
> 
> avg = 623599 nsecs, total: 397259314759 nsecs, count: 637042
> 
> There's a little variation in the amount of calls done because of timing
> of the threads with metadata requirements, but the avg, total, and
> count's are relatively consistent between runs (usually within 2-5% of
> each other).  As you can see here we have around a 30% decrease in
> average latency with a 30% decrease in overall time spent in
> find_free_extent.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> ---
> v2->v3:
> - Added a comment to explain why we don't break if our size is too small after
>   the alignment check if we're using bytes index, as it's subtle.
> - Added Filipe's reviewed-by.

Added to misc-next, thanks.

> +static u64 free_space_info_bytes(struct btrfs_free_space *info)

info can be const, added

> +{
> +	if (info->bitmap && info->max_extent_size)
> +		return info->max_extent_size;
> +	return info->bytes;
> +}
> +
> +/*
> + * This is indexed in reverse of what we generally do for rb-tree's, the largest
> + * chunks are left most and the smallest are rightmost.  This is so that we can
> + * take advantage of the cached property of the cached rb-tree and simply get
> + * the largest free space chunk right away.
> + */
> +static void tree_insert_bytes(struct btrfs_free_space_ctl *ctl,
> +			      struct btrfs_free_space *info)
> +{
> +	struct rb_root_cached *root = &ctl->free_space_bytes;
> +	struct rb_node **p = &root->rb_root.rb_node;

The single letter for rb-tree traversal has been in some old code and
if there's a chance to switch it to something like 'node' I can't
resist, so s/p/node/.

> +	struct rb_node *parent_node = NULL;
> +	struct btrfs_free_space *tmp;
> +	bool leftmost = true;
> +
> +	while (*p) {
> +		parent_node = *p;
> +		tmp = rb_entry(parent_node, struct btrfs_free_space,
> +			       bytes_index);
> +		if (free_space_info_bytes(info) < free_space_info_bytes(tmp)) {
> +			p = &(*p)->rb_right;
> +			leftmost = false;
> +		} else {
> +			p = &(*p)->rb_left;
> +		}
> +	}
> +
> +	rb_link_node(&info->bytes_index, parent_node, p);
> +	rb_insert_color_cached(&info->bytes_index, root, leftmost);
> +}
