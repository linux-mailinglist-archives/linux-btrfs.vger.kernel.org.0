Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B1059A306
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Aug 2022 20:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350785AbiHSRYE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Aug 2022 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350654AbiHSRXa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Aug 2022 13:23:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C6115078E
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 09:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B65B827FA
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Aug 2022 16:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF15C433C1;
        Fri, 19 Aug 2022 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660927335;
        bh=i6IpbQgcnxWdZo0Q1+M1VJ6oaZ2cChhdVBcYVkD4UbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVLBEOEEwE/ItxIY4hCZLWuaNKLWue4QU7JR3hUJV9ujiQCCp9ytKbEj+iZ5MhZk5
         jHLSKl2xwPP59LV+hffq38H9azJIeOMSMJp63Q8uMYmXPE6un0+SNwXOJLX0L/vpBq
         Stk98A3XIVIhN49IU1TZBWvdAh50oAxyq9gW5UZsJuXcX07UUAZPNaleHBxDFMcNvY
         2h/TjzAM6RZcPwpccKdbqfDCLvvXo62eGldRE/qDKki5E8ZNrz2z7Cf5Q8ICWMntWk
         fUURERvReAJyGxgStYYv/wPmKa5NNhR+pwRd4qWdShuobR6cpYyKm1s63ZovHnCv3r
         4CId1gZ4Roc8w==
Date:   Fri, 19 Aug 2022 17:42:12 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     ethanlien <ethanlien@synology.com>
Cc:     linux-btrfs@vger.kernel.org, cunankimo@gmail.com
Subject: Re: [PATCH v2] btrfs: remove unnecessary EXTENT_UPTODATE state in
 buffered I/O path
Message-ID: <20220819164212.GA3012163@falcondesktop>
References: <20220819024408.9714-1-ethanlien@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819024408.9714-1-ethanlien@synology.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 19, 2022 at 10:44:08AM +0800, ethanlien wrote:
> From: Ethan Lien <ethanlien@synology.com>
> 
> After we copied data to page cache in buffered I/O, we
> 1. Insert a EXTENT_UPTODATE state into inode's io_tree, by
>    endio_readpage_release_extent(), set_extent_delalloc() or
>    set_extent_defrag().
> 2. Set page uptodate before we unlock the page.
> 
> But the only place we check io_tree's EXTENT_UPTODATE state is in
> btrfs_do_readpage(). We know we enter btrfs_do_readpage() only when we
> have a non-uptodate page, so it is unnecessary to set EXTENT_UPTODATE.
> 
> For example, when performing a buffered random read:
> 
> 	fio --rw=randread --ioengine=libaio --direct=0 --numjobs=4 \
> 		--filesize=32G --size=4G --bs=4k --name=job \
> 		--filename=/mnt/file --name=job
> 
> Then check how many extent_state in io_tree:
> 
> 	cat /proc/slabinfo | grep btrfs_extent_state | awk '{print $2}'
> 
> w/o this patch, we got 640567 btrfs_extent_state.
> w/  this patch, we got    204 btrfs_extent_state.
> 
> Maintaining such a big tree brings overhead since every I/O needs to insert
> EXTENT_LOCKED, insert EXTENT_UPTODATE, then remove EXTENT_LOCKED. And in
> every insert or remove, we need to lock io_tree, do tree search, alloc or
> dealloc extent states. By removing unnecessary EXTENT_UPTODATE, we keep
> io_tree in a minimal size and reduce overhead when performing buffered I/O.
> 
> Signed-off-by: Ethan Lien <ethanlien@synology.com>
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> ---
> 
> V2: Remove set_extent_uptodate() from btrfs_get_extent(), and when we found
>     a inline extent, set page uptodate in btrfs_do_readpage().

Yep, that was what I had in mind.
Thanks for trying it out. I've given it some testing, including a full run of
fstests just to confirm I hadn't missed something.

Looks good, so:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.


> 
>  fs/btrfs/extent-io-tree.h |  4 ++--
>  fs/btrfs/extent_io.c      | 16 +---------------
>  fs/btrfs/inode.c          |  2 --
>  3 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index c3eb52dbe61c..53ae849d0248 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -211,7 +211,7 @@ static inline int set_extent_delalloc(struct extent_io_tree *tree, u64 start,
>  				      struct extent_state **cached_state)
>  {
>  	return set_extent_bit(tree, start, end,
> -			      EXTENT_DELALLOC | EXTENT_UPTODATE | extra_bits,
> +			      EXTENT_DELALLOC | extra_bits,
>  			      0, NULL, cached_state, GFP_NOFS, NULL);
>  }
>  
> @@ -219,7 +219,7 @@ static inline int set_extent_defrag(struct extent_io_tree *tree, u64 start,
>  		u64 end, struct extent_state **cached_state)
>  {
>  	return set_extent_bit(tree, start, end,
> -			      EXTENT_DELALLOC | EXTENT_UPTODATE | EXTENT_DEFRAG,
> +			      EXTENT_DELALLOC | EXTENT_DEFRAG,
>  			      0, NULL, cached_state, GFP_NOFS, NULL);
>  }
>  
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index bfae67c593c5..7e082770a088 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -2924,9 +2924,6 @@ static void endio_readpage_release_extent(struct processed_extent *processed,
>  	 * Now we don't have range contiguous to the processed range, release
>  	 * the processed range now.
>  	 */
> -	if (processed->uptodate && tree->track_uptodate)
> -		set_extent_uptodate(tree, processed->start, processed->end,
> -				    &cached, GFP_ATOMIC);
>  	unlock_extent_cached_atomic(tree, processed->start, processed->end,
>  				    &cached);
>  
> @@ -3718,20 +3715,9 @@ static int btrfs_do_readpage(struct page *page, struct extent_map **em_cached,
>  			continue;
>  		}
>  		/* the get_extent function already copied into the page */
> -		if (test_range_bit(tree, cur, cur_end,
> -				   EXTENT_UPTODATE, 1, NULL)) {
> -			unlock_extent(tree, cur, cur + iosize - 1);
> -			end_page_read(page, true, cur, iosize);
> -			cur = cur + iosize;
> -			pg_offset += iosize;
> -			continue;
> -		}
> -		/* we have an inline extent but it didn't get marked up
> -		 * to date.  Error out
> -		 */
>  		if (block_start == EXTENT_MAP_INLINE) {
>  			unlock_extent(tree, cur, cur + iosize - 1);
> -			end_page_read(page, false, cur, iosize);
> +			end_page_read(page, true, cur, iosize);
>  			cur = cur + iosize;
>  			pg_offset += iosize;
>  			continue;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f0c97d25b4a0..639edbcce9fe 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7031,8 +7031,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
>  			}
>  			flush_dcache_page(page);
>  		}
> -		set_extent_uptodate(io_tree, em->start,
> -				    extent_map_end(em) - 1, NULL, GFP_NOFS);
>  		goto insert;
>  	}
>  not_found:
> -- 
> 2.17.1
> 
