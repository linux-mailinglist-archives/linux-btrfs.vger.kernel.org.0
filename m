Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4862FAD6
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Nov 2022 17:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbiKRQvz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Nov 2022 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242441AbiKRQvp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Nov 2022 11:51:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA63976E1
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Nov 2022 08:51:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A25722D67;
        Fri, 18 Nov 2022 16:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668790300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALiDKPFZCwY0WWOg7Fysm3tfRETg8mtrqCnO/vKmjNM=;
        b=kSbH8frCf8fpJo+Ay9ykoRVIHA0F2z7TSsVui+a32WVSEtiXPa9QookBxSdfdx2Wnhw4Vh
        pD7jByEkSDZNAMigmpbULUhqVeOlc7wzKkXB1am703LFaqeGhCY8vvopGJvpK6TuQne/3I
        wIgoZF18kZSdkMoSkIEwJ9ZtFugoBrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668790300;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ALiDKPFZCwY0WWOg7Fysm3tfRETg8mtrqCnO/vKmjNM=;
        b=yezt18FJNAyY/sFYpk+ZAhj7CSa6glQSeXik/L6iG+LA/NygOnH76UUiarMT51pFElelGS
        F/rg+ujyNTlhVxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3B8041345B;
        Fri, 18 Nov 2022 16:51:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id h9WhDRy4d2NVEwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Fri, 18 Nov 2022 16:51:40 +0000
Date:   Fri, 18 Nov 2022 17:51:12 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/4] btrfs: use ffe_ctl in btrfs allocator tracepoints
Message-ID: <20221118165112.GU5824@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1668626092.git.boris@bur.io>
 <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef44014bc0c5599a0cc7034d9912a4151e3c8e3b.1668626092.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 16, 2022 at 11:22:02AM -0800, Boris Burkov wrote:
> The allocator tracepoints currently have a pile of values from ffe_ctl.
> In modifying the allocator and adding more tracepoints, I found myself
> adding to the already long argument list of the tracepoints. It makes it
> a lot simpler to just send in the ffe_ctl itself.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/extent-tree.c       | 91 ++----------------------------------
>  fs/btrfs/extent-tree.h       | 75 +++++++++++++++++++++++++++++
>  fs/btrfs/super.c             |  1 +
>  include/trace/events/btrfs.h | 41 ++++++++--------
>  4 files changed, 102 insertions(+), 106 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 17f599027c3d..defef7caddbb 100644
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
> @@ -3449,81 +3448,6 @@ btrfs_release_block_group(struct btrfs_block_group *cache,
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
> @@ -3555,8 +3479,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
>  	if (offset) {
>  		/* We have a block, we're done */
>  		spin_unlock(&last_ptr->refill_lock);
> -		trace_btrfs_reserve_extent_cluster(cluster_bg,
> -				ffe_ctl->search_start, ffe_ctl->num_bytes);
> +		trace_btrfs_reserve_extent_cluster(cluster_bg, ffe_ctl);
>  		*cluster_bg_ret = cluster_bg;
>  		ffe_ctl->found_offset = offset;
>  		return 0;
> @@ -3606,10 +3529,8 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
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
> @@ -4292,8 +4213,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>  	ins->objectid = 0;
>  	ins->offset = 0;
>  
> -	trace_find_free_extent(root, ffe_ctl->num_bytes, ffe_ctl->empty_size,
> -			       ffe_ctl->flags);
> +	trace_find_free_extent(root, ffe_ctl);
>  
>  	space_info = btrfs_find_space_info(fs_info, ffe_ctl->flags);
>  	if (!space_info) {
> @@ -4464,8 +4384,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
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
> index ae5425253603..f1085226d785 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -3,6 +3,81 @@
>  #ifndef BTRFS_EXTENT_TREE_H
>  #define BTRFS_EXTENT_TREE_H
>  
> +#include "ctree.h"

The ctree.h should not be included but either all types forward declared
or with some more preparatory work.

https://lore.kernel.org/linux-btrfs/20221014122232.GG13389@twin.jikos.cz/
