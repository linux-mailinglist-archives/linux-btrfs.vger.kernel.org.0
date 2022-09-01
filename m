Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995455A9B10
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Sep 2022 17:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbiIAPAz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Sep 2022 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiIAPAy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Sep 2022 11:00:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CE52EF17
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 08:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 452A361E11
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Sep 2022 15:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD5C433C1;
        Thu,  1 Sep 2022 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662044451;
        bh=RLs4VDjSVT2l2k1LLfBlCP6eI4KlNgcGVGL36h+5Tds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PUr9SKkK0v2TMGrxuybDQvSXXp86NC/xhOJek6w+/Eu/km/xnij9VJlX0rCiQO6wt
         BXzmDlUQf3qKK5kg2UqgWgVb8M/byHWHmnNHGBvPIQaVVvRuriFVVxIGa5LoHR9dmC
         tn2iaCzd1EUk4PgDyWprLr/RNzUNGQiR48kuAmOt6oqEQW+oFi7BhaEVg1Dgr/vaCe
         CbnMnrW6ohuC6egZIEUpDWbvbh0t/cxlroVeg1x7eU5qlODvUkzu6eZZw+pZ6V7qeD
         STrjATDunlyu9SzsFrYh7GP8Knb7RHYOmL13zqvbjOvUg8pYk0q95nnhgs2Kv/t7+x
         x2RirtZ0jpPHw==
Date:   Thu, 1 Sep 2022 16:00:48 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 02/10] btrfs: make hole and data seeking a lot more
 efficient
Message-ID: <20220901150048.GA3983623@falcondesktop>
References: <cover.1662022922.git.fdmanana@suse.com>
 <246cd5358b28e3e11a96fe2abd0a4a34840cdb85.1662022922.git.fdmanana@suse.com>
 <YxC7l6cL2GtilEf3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxC7l6cL2GtilEf3@localhost.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 01, 2022 at 10:03:03AM -0400, Josef Bacik wrote:
> On Thu, Sep 01, 2022 at 02:18:22PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > The current implementation of hole and data seeking for llseek does not
> > scale well in regards to the number of extents and the distance between
> > the start offset and the next hole or extent. This is due to a very high
> > algorithmic complexity. Often we also get reports of btrfs' hole and data
> > seeking (llseek) being too slow, such as at 2017's LSFMM (see the Link
> > tag at the bottom).
> > 
> > In order to better understand it, lets consider the case where the start
> > offset is 0, we are seeking for a hole and the file size is 16G. Between
> > file offset 0 and the first hole in the file there are 100K extents - this
> > is common for large files, specially if we have compression enabled, since
> > the maximum extent size is limited to 128K. The steps take by the main
> > loop of the current algorithm are the following:
> > 
> > 1) We start by calling btrfs_get_extent_fiemap(), for file offset 0, which
> >    calls btrfs_get_extent(). This will first lookup for an extent map in
> >    the inode's extent map tree (a red black tree). If the extent map is
> >    not loaded in memory, then it will do a lookup for the corresponding
> >    file extent item in the subvolume's b+tree, create an extent map based
> >    on the contents of the file extent item and then add the extent map to
> >    the extent map tree of the inode;
> > 
> > 2) The second iteration calls btrfs_get_extent_fiemap() again, this time
> >    with a start offset matching the end offset of the previous extent.
> >    Again, btrfs_get_extent() will first search the extent map tree, and
> >    if it doesn't find an extent map there, it will again search in the
> >    b+tree of the subvolume for a matching file extent item, build an
> >    extent map based on the file extent item, and add the extent map to
> >    to the extent map tree of the inode;
> > 
> > 3) This repeats over and over until we find the first hole (when seeking
> >    for holes) or until we find the first extent (when seeking for data).
> > 
> >    If there no extent maps loaded in memory for each iteration, then on
> >    each iteration we do 1 extent map tree search, 1 b+tree search, plus
> >    1 more extent map tree traversal to insert an extent map - plus we
> >    allocate memory for the extent map.
> > 
> >    On each iteration we are growing the size of the extent map tree,
> >    making each future search slower, and also visiting the same b+tree
> >    leaves over and over again - taking into account with the default leaf
> >    size of 16K we can fit more than 200 file extent items in a leaf - so
> >    we can visit the same b+tree leaf 200+ times, on each visit walking
> >    down a path from the root to the leaf.
> > 
> > So it's easy to see that what we have now doesn't scale well. Also, it
> > loads an extent map for every file extent item into memory, which is not
> > efficient - we should add extents maps only when doing IO (writing or
> > reading file data).
> > 
> > This change implements a new algorithm which scales much better, and
> > works like this:
> > 
> > 1) We iterate over the subvolume's b+tree, visiting each leaf that has
> >    file extent items once and only once;
> > 
> > 2) For any file extent items found, that don't represent holes or prealloc
> >    extents, it will not search the extent map tree - there's no need at
> >    all for that - an extent map is just an in-memory representation of a
> >    file extent item;
> > 
> > 3) When a hole is found, or a prealloc extent, it will check if there's
> >    delalloc for its range. For this it will search for EXTENT_DELALLOC
> >    bits in the inode's io tree and check the extent map tree - this is
> >    for accounting for unflushed delalloc and for flushed delalloc (the
> >    period between running delalloc and ordered extent completion),
> >    respectively. This is similar to what the current implementation does
> >    when it finds a hole or prealloc extent, but without creating extent
> >    maps and adding them to the extent map tree in case they are not
> >    loaded in memory;
> > 
> > 4) It never allocates extent maps, or adds extent maps to the inode's
> >    extent map tree. This not only saves memory and time (from the tree
> >    insertions and allocations), but also eliminates the possibility of
> >    -ENOMEM due to allocating too many extent maps.
> > 
> > Part of this new code will also be used later for fiemap (which also
> > suffers similar scalability problems).
> > 
> > The following test example can be used to quickly measure the efficiency
> > before and after this patch:
> > 
> >     $ cat test-seek-hole.sh
> >     #!/bin/bash
> > 
> >     DEV=/dev/sdi
> >     MNT=/mnt/sdi
> > 
> >     mkfs.btrfs -f $DEV
> > 
> >     mount -o compress=lzo $DEV $MNT
> > 
> >     # 16G file -> 131073 compressed extents.
> >     xfs_io -f -c "pwrite -S 0xab -b 1M 0 16G" $MNT/foobar
> > 
> >     # Leave a 1M hole at file offset 15G.
> >     xfs_io -c "fpunch 15G 1M" $MNT/foobar
> > 
> >     # Unmount and mount again, so that we can test when there's no
> >     # metadata cached in memory.
> >     umount $MNT
> >     mount -o compress=lzo $DEV $MNT
> > 
> >     # Test seeking for hole from offset 0 (hole is at offset 15G).
> > 
> >     start=$(date +%s%N)
> >     xfs_io -c "seek -h 0" $MNT/foobar
> >     end=$(date +%s%N)
> >     dur=$(( (end - start) / 1000000 ))
> >     echo "Took $dur milliseconds to seek first hole (metadata not cached)"
> >     echo
> > 
> >     start=$(date +%s%N)
> >     xfs_io -c "seek -h 0" $MNT/foobar
> >     end=$(date +%s%N)
> >     dur=$(( (end - start) / 1000000 ))
> >     echo "Took $dur milliseconds to seek first hole (metadata cached)"
> >     echo
> > 
> >     umount $MNT
> > 
> > Before this change:
> > 
> >     $ ./test-seek-hole.sh
> >     (...)
> >     Whence	Result
> >     HOLE	16106127360
> >     Took 176 milliseconds to seek first hole (metadata not cached)
> > 
> >     Whence	Result
> >     HOLE	16106127360
> >     Took 17 milliseconds to seek first hole (metadata cached)
> > 
> > After this change:
> > 
> >     $ ./test-seek-hole.sh
> >     (...)
> >     Whence	Result
> >     HOLE	16106127360
> >     Took 43 milliseconds to seek first hole (metadata not cached)
> > 
> >     Whence	Result
> >     HOLE	16106127360
> >     Took 13 milliseconds to seek first hole (metadata cached)
> > 
> > That's about 4X faster when no metadata is cached and about 30% faster
> > when all metadata is cached.
> > 
> > In practice the differences may often be significantly higher, either due
> > to a higher number of extents in a file or because the subvolume's b+tree
> > is much bigger than in this example, where we only have one file.
> > 
> > Link: https://lwn.net/Articles/718805/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/file.c | 437 ++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 406 insertions(+), 31 deletions(-)
> > 
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 96f444ad0951..b292a8ada3a4 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -3601,22 +3601,281 @@ static long btrfs_fallocate(struct file *file, int mode,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Helper for have_delalloc_in_range(). Find a subrange in a given range that
> > + * has unflushed and/or flushing delalloc. There might be other adjacent
> > + * subranges after the one it found, so have_delalloc_in_range() keeps looping
> > + * while it gets adjacent subranges, and merging them together.
> > + */
> > +static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
> > +				   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> > +{
> > +	const u64 len = end + 1 - start;
> > +	struct extent_map_tree *em_tree = &inode->extent_tree;
> > +	struct extent_map *em;
> > +	u64 em_end;
> > +	u64 delalloc_len;
> > +
> > +	/*
> > +	 * Search the io tree first for EXTENT_DELALLOC. If we find any, it
> > +	 * means we have delalloc (dirty pages) for which writeback has not
> > +	 * started yet.
> > +	 */
> > +	*delalloc_start_ret = start;
> > +	delalloc_len = count_range_bits(&inode->io_tree, delalloc_start_ret, end,
> > +					len, EXTENT_DELALLOC, 1);
> > +	/*
> > +	 * If delalloc was found then *delalloc_start_ret has a sector size
> > +	 * aligned value (rounded down).
> > +	 */
> > +	if (delalloc_len > 0)
> > +		*delalloc_end_ret = *delalloc_start_ret + delalloc_len - 1;
> > +
> > +	/*
> > +	 * Now also check if there's any extent map in the range that does not
> > +	 * map to a hole or prealloc extent. We do this because:
> > +	 *
> > +	 * 1) When delalloc is flushed, the file range is locked, we clear the
> > +	 *    EXTENT_DELALLOC bit from the io tree and create an extent map for
> > +	 *    an allocated extent. So we might just have been called after
> > +	 *    delalloc is flushed and before the ordered extent completes and
> > +	 *    inserts the new file extent item in the subvolume's btree;
> > +	 *
> > +	 * 2) We may have an extent map created by flushing delalloc for a
> > +	 *    subrange that starts before the subrange we found marked with
> > +	 *    EXTENT_DELALLOC in the io tree.
> > +	 */
> > +	read_lock(&em_tree->lock);
> > +	em = lookup_extent_mapping(em_tree, start, len);
> > +	read_unlock(&em_tree->lock);
> > +
> > +	/* extent_map_end() returns a non-inclusive end offset. */
> > +	em_end = em ? extent_map_end(em) : 0;
> > +
> > +	/*
> > +	 * If we have a hole/prealloc extent map, check the next one if this one
> > +	 * ends before our range's end.
> > +	 */
> > +	if (em && (em->block_start == EXTENT_MAP_HOLE ||
> > +		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
> > +		struct extent_map *next_em;
> > +
> > +		read_lock(&em_tree->lock);
> > +		next_em = lookup_extent_mapping(em_tree, em_end, len - em_end);
> > +		read_unlock(&em_tree->lock);
> > +
> > +		free_extent_map(em);
> > +		em_end = next_em ? extent_map_end(next_em) : 0;
> > +		em = next_em;
> > +	}
> > +
> > +	if (em && (em->block_start == EXTENT_MAP_HOLE ||
> > +		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
> > +		free_extent_map(em);
> > +		em = NULL;
> > +	}
> > +
> > +	/*
> > +	 * No extent map or one for a hole or prealloc extent. Use the delalloc
> > +	 * range we found in the io tree if we have one.
> > +	 */
> > +	if (!em)
> > +		return (delalloc_len > 0);
> > +
> 
> You can move this after the lookup, and then remove the if (em && parts above.
> Then all you need to do is in the second if statement return (delalloc_len > 0);

Nop, it won't work by doing just that.

To move that if statement, it would require all the following changes,
which to me it doesn't seem to provide any benefit, aesthetically or
otherwise:

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 636b3ec46184..05037b8950d5 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3649,39 +3649,39 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
 	em = lookup_extent_mapping(em_tree, start, len);
 	read_unlock(&em_tree->lock);
 
+	if (!em)
+		return (delalloc_len > 0);
+
 	/* extent_map_end() returns a non-inclusive end offset. */
-	em_end = em ? extent_map_end(em) : 0;
+	em_end = extent_map_end(em);
 
 	/*
 	 * If we have a hole/prealloc extent map, check the next one if this one
 	 * ends before our range's end.
 	 */
-	if (em && (em->block_start == EXTENT_MAP_HOLE ||
-		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
+	if (em->block_start == EXTENT_MAP_HOLE ||
+	    test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
 		struct extent_map *next_em;
 
+		free_extent_map(em);
+
+		if (em_end >= end)
+			return (delalloc_len > 0);
+
 		read_lock(&em_tree->lock);
 		next_em = lookup_extent_mapping(em_tree, em_end, len - em_end);
 		read_unlock(&em_tree->lock);
 
-		free_extent_map(em);
-		em_end = next_em ? extent_map_end(next_em) : 0;
-		em = next_em;
-	}
+		if (!next_em || next_em->block_start == EXTENT_MAP_HOLE ||
+		    test_bit(EXTENT_FLAG_PREALLOC, &next_em->flags)) {
+			free_extent_map(next_em);
+			return (delalloc_len > 0);
+		}
 
-	if (em && (em->block_start == EXTENT_MAP_HOLE ||
-		   test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
-		free_extent_map(em);
-		em = NULL;
+		em = next_em;
+		em_end = extent_map_end(em);
 	}
 
-	/*
-	 * No extent map or one for a hole or prealloc extent. Use the delalloc
-	 * range we found in the io tree if we have one.
-	 */
-	if (!em)
-		return (delalloc_len > 0);
-
 	/*
 	 * We don't have any range as EXTENT_DELALLOC in the io tree, so the
 	 * extent map is the only subrange representing delalloc.


> Thanks,
> 
> Josef
