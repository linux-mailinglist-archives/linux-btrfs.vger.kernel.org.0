Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248185FB2D3
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 15:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJKNDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJKNDn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 09:03:43 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9138925A2
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Oct 2022 06:03:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C95C336AB;
        Tue, 11 Oct 2022 13:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665493421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrIjtlHAqDPmIHDATux4vpGFO2ThQ8LV8PEQ2esHhnA=;
        b=aKpJt/+47pi7P7jBrwcfEeTPwKtGYrTG/fOiCJ/kQRQb9vdt7gISUGPcyaBge7Bj5vdDu0
        IxS2xA/E5jpPg8gFltRbCovzBwSSWwLl7/ViTP+d7fIjTmclWvpDRJ2+i93gu+BKNAhuBl
        8CmjqQt+yUGsuoawgq7yZK4xGLD8CZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665493421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wrIjtlHAqDPmIHDATux4vpGFO2ThQ8LV8PEQ2esHhnA=;
        b=4Gs8mXGs1K8Za4Y6isdQ+6ZUxb85I4aJ/o3wXPa4lJoxe0lHLA+mYgHnBMXLjObDUst/jS
        pjkUc1+SNKyR80CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28C4B13AAC;
        Tue, 11 Oct 2022 13:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aygJCa1pRWMfYQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Tue, 11 Oct 2022 13:03:41 +0000
Date:   Tue, 11 Oct 2022 15:03:35 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/5] btrfs: use ffe_ctl in btrfs allocator tracepoints
Message-ID: <20221011130335.GS13389@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1664999303.git.boris@bur.io>
 <22c0c12d9fb7750d21fe2e7ad566bcc49856bf5a.1664999303.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c0c12d9fb7750d21fe2e7ad566bcc49856bf5a.1664999303.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 05, 2022 at 12:49:19PM -0700, Boris Burkov wrote:
> The allocator tracepoints currently have a pile of values from ffe_ctl.
> In modifying the allocator and adding more tracepoints, I found myself
> adding to the already long argument list of the tracepoints. It makes it
> a lot simpler to just send in the ffe_ctl itself.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent-tree.c       | 91 ++----------------------------------
>  fs/btrfs/extent-tree.h       | 80 +++++++++++++++++++++++++++++++
>  fs/btrfs/super.c             |  1 +
>  include/trace/events/btrfs.h | 41 ++++++++--------
>  4 files changed, 107 insertions(+), 106 deletions(-)
>  create mode 100644 fs/btrfs/extent-tree.h
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index cd2d36580f1a..0fe1e8eb10cf 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -16,7 +16,7 @@
>  #include <linux/percpu_counter.h>
>  #include <linux/lockdep.h>
>  #include <linux/crc32c.h>
> -#include "misc.h"
> +#include "extent-tree.h"
>  #include "tree-log.h"
>  #include "disk-io.h"
>  #include "print-tree.h"
> @@ -31,7 +31,6 @@
>  #include "space-info.h"
>  #include "block-rsv.h"
>  #include "delalloc-space.h"
> -#include "block-group.h"
>  #include "discard.h"
>  #include "rcu-string.h"
>  #include "zoned.h"
> @@ -3442,81 +3441,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
>  	btrfs_put_block_group(cache);
>  }
>  
> -enum btrfs_extent_allocation_policy {
> -	BTRFS_EXTENT_ALLOC_CLUSTERED,
> -	BTRFS_EXTENT_ALLOC_ZONED,
> -};
> -
> -/*
> - * Structure used internally for find_free_extent() function.  Wraps needed
> - * parameters.
> - */
> -struct find_free_extent_ctl {
> -	/* Basic allocation info */
> -	u64 ram_bytes;
> -	u64 num_bytes;
> -	u64 min_alloc_size;
> -	u64 empty_size;
> -	u64 flags;
> -	int delalloc;
> -
> -	/* Where to start the search inside the bg */
> -	u64 search_start;
> -
> -	/* For clustered allocation */
> -	u64 empty_cluster;
> -	struct btrfs_free_cluster *last_ptr;
> -	bool use_cluster;
> -
> -	bool have_caching_bg;
> -	bool orig_have_caching_bg;
> -
> -	/* Allocation is called for tree-log */
> -	bool for_treelog;
> -
> -	/* Allocation is called for data relocation */
> -	bool for_data_reloc;
> -
> -	/* RAID index, converted from flags */
> -	int index;
> -
> -	/*
> -	 * Current loop number, check find_free_extent_update_loop() for details
> -	 */
> -	int loop;
> -
> -	/*
> -	 * Whether we're refilling a cluster, if true we need to re-search
> -	 * current block group but don't try to refill the cluster again.
> -	 */
> -	bool retry_clustered;
> -
> -	/*
> -	 * Whether we're updating free space cache, if true we need to re-search
> -	 * current block group but don't try updating free space cache again.
> -	 */
> -	bool retry_unclustered;
> -
> -	/* If current block group is cached */
> -	int cached;
> -
> -	/* Max contiguous hole found */
> -	u64 max_extent_size;
> -
> -	/* Total free space from free space cache, not always contiguous */
> -	u64 total_free_space;
> -
> -	/* Found result */
> -	u64 found_offset;
> -
> -	/* Hint where to start looking for an empty space */
> -	u64 hint_byte;
> -
> -	/* Allocation policy */
> -	enum btrfs_extent_allocation_policy policy;
> -};
> -
> -
>  /*
>   * Helper function for find_free_extent().
>   *
> @@ -3548,8 +3472,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
>  	if (offset) {
>  		/* We have a block, we're done */
>  		spin_unlock(&last_ptr->refill_lock);
> -		trace_btrfs_reserve_extent_cluster(cluster_bg,
> -				ffe_ctl->search_start, ffe_ctl->num_bytes);
> +		trace_btrfs_reserve_extent_cluster(cluster_bg, ffe_ctl);
>  		*cluster_bg_ret = cluster_bg;
>  		ffe_ctl->found_offset = offset;
>  		return 0;
> @@ -3599,10 +3522,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
>  		if (offset) {
>  			/* We found one, proceed */
>  			spin_unlock(&last_ptr->refill_lock);
> -			trace_btrfs_reserve_extent_cluster(bg,
> -					ffe_ctl->search_start,
> -					ffe_ctl->num_bytes);
>  			ffe_ctl->found_offset = offset;
> +			trace_btrfs_reserve_extent_cluster(bg, ffe_ctl);
>  			return 0;
>  		}
>  	} else if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
> @@ -4285,8 +4206,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  	ins->objectid = 0;
>  	ins->offset = 0;
>  
> -	trace_find_free_extent(root, ffe_ctl->num_bytes, ffe_ctl->empty_size,
> -			       ffe_ctl->flags);
> +	trace_find_free_extent(root, ffe_ctl);
>  
>  	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
>  	if (!space_info) {
> @@ -4457,8 +4377,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  		ins->objectid = ffe_ctl->search_start;
>  		ins->offset = ffe_ctl->num_bytes;
>  
> -		trace_btrfs_reserve_extent(block_group, ffe_ctl->search_start,
> -					   ffe_ctl->num_bytes);
> +		trace_btrfs_reserve_extent(block_group, ffe_ctl);
>  		btrfs_release_block_group(block_group, ffe_ctl->delalloc);
>  		break;
>  loop:
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> new file mode 100644
> index 000000000000..7d3bb9c60fbe
> --- /dev/null
> +++ b/fs/btrfs/extent-tree.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BTRFS_EXTENT_TREE_H
> +#define BTRFS_EXTENT_TREE_H
> +
> +#include "ctree.h"

Pulling ctree.h into this header is going the opposite way, we're trying
to logically separate the APIs.

> +#include "misc.h"
> +#include "block-group.h"
> +
> +enum btrfs_extent_allocation_policy {
> +	BTRFS_EXTENT_ALLOC_CLUSTERED,
> +	BTRFS_EXTENT_ALLOC_ZONED,
> +};
> +
> +struct find_free_extent_ctl {
> +	/* Basic allocation info */
> +	u64 ram_bytes;
> +	u64 num_bytes;
> +	u64 min_alloc_size;
> +	u64 empty_size;
> +	u64 flags;
> +	int delalloc;
> +
> +	/* Where to start the search inside the bg */
> +	u64 search_start;
> +
> +	/* For clustered allocation */
> +	u64 empty_cluster;
> +	struct btrfs_free_cluster *last_ptr;

This is defined in ctree.h but for the pointer a forward declaration is
sufficient. The .c file will have to include ctree.h anyway.

> +	bool use_cluster;
> +
> +	bool have_caching_bg;
> +	bool orig_have_caching_bg;
> +
> +	/* Allocation is called for tree-log */
> +	bool for_treelog;
> +
> +	/* Allocation is called for data relocation */
> +	bool for_data_reloc;
> +
> +	/* RAID index, converted from flags */
> +	int index;
> +
> +	/*
> +	 * Current loop number, check find_free_extent_update_loop() for details
> +	 */
> +	int loop;
> +
> +	/*
> +	 * Whether we're refilling a cluster, if true we need to re-search
> +	 * current block group but don't try to refill the cluster again.
> +	 */
> +	bool retry_clustered;
> +
> +	/*
> +	 * Whether we're updating free space cache, if true we need to re-search
> +	 * current block group but don't try updating free space cache again.
> +	 */
> +	bool retry_unclustered;
> +
> +	/* If current block group is cached */
> +	int cached;
> +
> +	/* Max contiguous hole found */
> +	u64 max_extent_size;
> +
> +	/* Total free space from free space cache, not always contiguous */
> +	u64 total_free_space;
> +
> +	/* Found result */
> +	u64 found_offset;
> +
> +	/* Hint where to start looking for an empty space */
> +	u64 hint_byte;
> +
> +	/* Allocation policy */
> +	enum btrfs_extent_allocation_policy policy;
> +};
