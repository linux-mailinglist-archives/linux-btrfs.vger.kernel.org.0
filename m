Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75B885AAA33
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiIBIhd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 04:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235899AbiIBIhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 04:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B07B29CA5
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 01:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABC7662091
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A24C433D6
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107802;
        bh=EE27+2ic306vcMVw6j3apK64lK9Z/AFrYaVWXImNRGE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pGraC8NJZWQ4w/frMS00JTHQ2gukg4LiPthb34SNOe/0YOg5Fj2YIy2SYEa/zsrfh
         Y5KMwdjNSL4S7L32IA6CFk1O+qa5jgT7RpUIElUuJEWKWeznvlqTO1CMsOSnrq5jMe
         Mq71zDaLqa8b9FjLUS/4f/gkB4s2YuIyd0/ZuRnN6wRFbGY8pkp80ddqqUUmDULKwJ
         mc26ZrpejCEorpJ91LujKHOhP350DwLkqYRUemk1QqQ2Jre89LmsvVa804lb/xT3Hq
         pfToI6AUxNHIj/5cUU1yoBS5yK5fv9JyCNwtMYqUKxmAMEwaan3GD3dyMRbTjy3sty
         RHiUeOZfj41TQ==
Received: by mail-ot1-f50.google.com with SMTP id t8-20020a9d5908000000b0063b41908168so973521oth.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 01:36:42 -0700 (PDT)
X-Gm-Message-State: ACgBeo0ciKMB9sjXBFA/xOyd80tAPuuCkAPTj2CdgZqOzzb2NF6TV4rv
        fhT5ufmCZ+s0qWHXgPCOkHrz38e/df/5+GvjvQQ=
X-Google-Smtp-Source: AA6agR6Ftjf+F3bE3xPwHOIF65jAwkcWfnU2K+yyEauNezenE6bkRVltV9z+6TfIMct9fiaJ2YqtqHt1Smbx3M0rUz4=
X-Received: by 2002:a9d:6f08:0:b0:638:8a51:2e46 with SMTP id
 n8-20020a9d6f08000000b006388a512e46mr14391477otq.363.1662107800874; Fri, 02
 Sep 2022 01:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662022922.git.fdmanana@suse.com> <246cd5358b28e3e11a96fe2abd0a4a34840cdb85.1662022922.git.fdmanana@suse.com>
 <9015be05-9c35-f7b3-708f-d2205af353d2@gmx.com>
In-Reply-To: <9015be05-9c35-f7b3-708f-d2205af353d2@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 2 Sep 2022 09:36:04 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5iF6EdQv_UaJe1Tn5Tn1RwxVWvdWGRAJUY2DioRJyMeA@mail.gmail.com>
Message-ID: <CAL3q7H5iF6EdQv_UaJe1Tn5Tn1RwxVWvdWGRAJUY2DioRJyMeA@mail.gmail.com>
Subject: Re: [PATCH 02/10] btrfs: make hole and data seeking a lot more efficient
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 1, 2022 at 11:18 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/9/1 21:18, fdmanana@kernel.org wrote:
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
> >     calls btrfs_get_extent(). This will first lookup for an extent map in
> >     the inode's extent map tree (a red black tree). If the extent map is
> >     not loaded in memory, then it will do a lookup for the corresponding
> >     file extent item in the subvolume's b+tree, create an extent map based
> >     on the contents of the file extent item and then add the extent map to
> >     the extent map tree of the inode;
> >
> > 2) The second iteration calls btrfs_get_extent_fiemap() again, this time
> >     with a start offset matching the end offset of the previous extent.
> >     Again, btrfs_get_extent() will first search the extent map tree, and
> >     if it doesn't find an extent map there, it will again search in the
> >     b+tree of the subvolume for a matching file extent item, build an
> >     extent map based on the file extent item, and add the extent map to
> >     to the extent map tree of the inode;
> >
> > 3) This repeats over and over until we find the first hole (when seeking
> >     for holes) or until we find the first extent (when seeking for data).
> >
> >     If there no extent maps loaded in memory for each iteration, then on
> >     each iteration we do 1 extent map tree search, 1 b+tree search, plus
> >     1 more extent map tree traversal to insert an extent map - plus we
> >     allocate memory for the extent map.
>
> I'm a little intereted in if we have other workload which are heavily
> relying on extent map tree search?
>
> If so, would it make sense to load a batch of file extents items into
> extent map tree in one go?

It depends on the workload...
I don't recall any other case, plus in the case of lseek and fiemap we
don't need
to load the extent maps at all.

>
>
> Another thing not that related to the patchset is, since extent map
> doesn't really get freed up unless that inode is invicted/truncated, I'm

It also gets freed on page/folio release.

> wondering would it be a problem for heavily fragmented files to take up
> too much memory just for extent map tree?
>
> Would we need a way to drop extent map in the future?

Extent maps are necessary for an efficient fsync for example.

There's a problem with extent maps I want to address, but that's
unrelated to lseek and fiemap,
it's quite a separate issue.

>
> >
> >     On each iteration we are growing the size of the extent map tree,
> >     making each future search slower, and also visiting the same b+tree
> >     leaves over and over again - taking into account with the default leaf
> >     size of 16K we can fit more than 200 file extent items in a leaf - so
> >     we can visit the same b+tree leaf 200+ times, on each visit walking
> >     down a path from the root to the leaf.
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
> >     file extent items once and only once;
> >
> > 2) For any file extent items found, that don't represent holes or prealloc
> >     extents, it will not search the extent map tree - there's no need at
> >     all for that - an extent map is just an in-memory representation of a
> >     file extent item;
> >
> > 3) When a hole is found, or a prealloc extent, it will check if there's
> >     delalloc for its range. For this it will search for EXTENT_DELALLOC
> >     bits in the inode's io tree and check the extent map tree - this is
> >     for accounting for unflushed delalloc and for flushed delalloc (the
> >     period between running delalloc and ordered extent completion),
> >     respectively. This is similar to what the current implementation does
> >     when it finds a hole or prealloc extent, but without creating extent
> >     maps and adding them to the extent map tree in case they are not
> >     loaded in memory;
>
> Would it be possible that, before we starting the subvolume tree search,
> just run all delalloc of that target inode and prevent new writes, so we
> can forget about the delalloc situation completely?

That would be a significant behavioural change.
ext4 and xfs don't seem to do it, and given that lseek is widely used
(cp for example),
making such change would possibly result in people reporting extra latency.
I understand your pov to reduce/simplify code, but from a user's
perspective I don't see
a justification to flush delalloc and wait for IO (and ordered
extents) to complete.

>
> >
> > 4) It never allocates extent maps, or adds extent maps to the inode's
> >     extent map tree. This not only saves memory and time (from the tree
> >     insertions and allocations), but also eliminates the possibility of
> >     -ENOMEM due to allocating too many extent maps.
> >
> > Part of this new code will also be used later for fiemap (which also
> > suffers similar scalability problems).
> >
> > The following test example can be used to quickly measure the efficiency
> > before and after this patch:
> >
> >      $ cat test-seek-hole.sh
> >      #!/bin/bash
> >
> >      DEV=/dev/sdi
> >      MNT=/mnt/sdi
> >
> >      mkfs.btrfs -f $DEV
> >
> >      mount -o compress=lzo $DEV $MNT
> >
> >      # 16G file -> 131073 compressed extents.
> >      xfs_io -f -c "pwrite -S 0xab -b 1M 0 16G" $MNT/foobar
> >
> >      # Leave a 1M hole at file offset 15G.
> >      xfs_io -c "fpunch 15G 1M" $MNT/foobar
> >
> >      # Unmount and mount again, so that we can test when there's no
> >      # metadata cached in memory.
> >      umount $MNT
> >      mount -o compress=lzo $DEV $MNT
> >
> >      # Test seeking for hole from offset 0 (hole is at offset 15G).
> >
> >      start=$(date +%s%N)
> >      xfs_io -c "seek -h 0" $MNT/foobar
> >      end=$(date +%s%N)
> >      dur=$(( (end - start) / 1000000 ))
> >      echo "Took $dur milliseconds to seek first hole (metadata not cached)"
> >      echo
> >
> >      start=$(date +%s%N)
> >      xfs_io -c "seek -h 0" $MNT/foobar
> >      end=$(date +%s%N)
> >      dur=$(( (end - start) / 1000000 ))
> >      echo "Took $dur milliseconds to seek first hole (metadata cached)"
> >      echo
> >
> >      umount $MNT
> >
> > Before this change:
> >
> >      $ ./test-seek-hole.sh
> >      (...)
> >      Whence   Result
> >      HOLE     16106127360
> >      Took 176 milliseconds to seek first hole (metadata not cached)
> >
> >      Whence   Result
> >      HOLE     16106127360
> >      Took 17 milliseconds to seek first hole (metadata cached)
> >
> > After this change:
> >
> >      $ ./test-seek-hole.sh
> >      (...)
> >      Whence   Result
> >      HOLE     16106127360
> >      Took 43 milliseconds to seek first hole (metadata not cached)
> >
> >      Whence   Result
> >      HOLE     16106127360
> >      Took 13 milliseconds to seek first hole (metadata cached)
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
> >   fs/btrfs/file.c | 437 ++++++++++++++++++++++++++++++++++++++++++++----
> >   1 file changed, 406 insertions(+), 31 deletions(-)
> >
> > diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> > index 96f444ad0951..b292a8ada3a4 100644
> > --- a/fs/btrfs/file.c
> > +++ b/fs/btrfs/file.c
> > @@ -3601,22 +3601,281 @@ static long btrfs_fallocate(struct file *file, int mode,
> >       return ret;
> >   }
> >
> > +/*
> > + * Helper for have_delalloc_in_range(). Find a subrange in a given range that
> > + * has unflushed and/or flushing delalloc. There might be other adjacent
> > + * subranges after the one it found, so have_delalloc_in_range() keeps looping
> > + * while it gets adjacent subranges, and merging them together.
> > + */
> > +static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
> > +                                u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> > +{
> > +     const u64 len = end + 1 - start;
> > +     struct extent_map_tree *em_tree = &inode->extent_tree;
> > +     struct extent_map *em;
> > +     u64 em_end;
> > +     u64 delalloc_len;
> > +
> > +     /*
> > +      * Search the io tree first for EXTENT_DELALLOC. If we find any, it
> > +      * means we have delalloc (dirty pages) for which writeback has not
> > +      * started yet.
> > +      */
> > +     *delalloc_start_ret = start;
> > +     delalloc_len = count_range_bits(&inode->io_tree, delalloc_start_ret, end,
> > +                                     len, EXTENT_DELALLOC, 1);
> > +     /*
> > +      * If delalloc was found then *delalloc_start_ret has a sector size
> > +      * aligned value (rounded down).
> > +      */
> > +     if (delalloc_len > 0)
> > +             *delalloc_end_ret = *delalloc_start_ret + delalloc_len - 1;
> > +
> > +     /*
> > +      * Now also check if there's any extent map in the range that does not
> > +      * map to a hole or prealloc extent. We do this because:
> > +      *
> > +      * 1) When delalloc is flushed, the file range is locked, we clear the
> > +      *    EXTENT_DELALLOC bit from the io tree and create an extent map for
> > +      *    an allocated extent. So we might just have been called after
> > +      *    delalloc is flushed and before the ordered extent completes and
> > +      *    inserts the new file extent item in the subvolume's btree;
> > +      *
> > +      * 2) We may have an extent map created by flushing delalloc for a
> > +      *    subrange that starts before the subrange we found marked with
> > +      *    EXTENT_DELALLOC in the io tree.
> > +      */
> > +     read_lock(&em_tree->lock);
> > +     em = lookup_extent_mapping(em_tree, start, len);
> > +     read_unlock(&em_tree->lock);
> > +
> > +     /* extent_map_end() returns a non-inclusive end offset. */
> > +     em_end = em ? extent_map_end(em) : 0;
> > +
> > +     /*
> > +      * If we have a hole/prealloc extent map, check the next one if this one
> > +      * ends before our range's end.
> > +      */
> > +     if (em && (em->block_start == EXTENT_MAP_HOLE ||
> > +                test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) && em_end < end) {
> > +             struct extent_map *next_em;
> > +
> > +             read_lock(&em_tree->lock);
> > +             next_em = lookup_extent_mapping(em_tree, em_end, len - em_end);
> > +             read_unlock(&em_tree->lock);
> > +
> > +             free_extent_map(em);
> > +             em_end = next_em ? extent_map_end(next_em) : 0;
> > +             em = next_em;
> > +     }
> > +
> > +     if (em && (em->block_start == EXTENT_MAP_HOLE ||
> > +                test_bit(EXTENT_FLAG_PREALLOC, &em->flags))) {
> > +             free_extent_map(em);
> > +             em = NULL;
> > +     }
> > +
> > +     /*
> > +      * No extent map or one for a hole or prealloc extent. Use the delalloc
> > +      * range we found in the io tree if we have one.
> > +      */
> > +     if (!em)
> > +             return (delalloc_len > 0);
> > +
> > +     /*
> > +      * We don't have any range as EXTENT_DELALLOC in the io tree, so the
> > +      * extent map is the only subrange representing delalloc.
> > +      */
> > +     if (delalloc_len == 0) {
> > +             *delalloc_start_ret = em->start;
> > +             *delalloc_end_ret = min(end, em_end - 1);
> > +             free_extent_map(em);
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * The extent map represents a delalloc range that starts before the
> > +      * delalloc range we found in the io tree.
> > +      */
> > +     if (em->start < *delalloc_start_ret) {
> > +             *delalloc_start_ret = em->start;
> > +             /*
> > +              * If the ranges are adjacent, return a combined range.
> > +              * Otherwise return the extent map's range.
> > +              */
> > +             if (em_end < *delalloc_start_ret)
> > +                     *delalloc_end_ret = min(end, em_end - 1);
> > +
> > +             free_extent_map(em);
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * The extent map starts after the delalloc range we found in the io
> > +      * tree. If it's adjacent, return a combined range, otherwise return
> > +      * the range found in the io tree.
> > +      */
> > +     if (*delalloc_end_ret + 1 == em->start)
> > +             *delalloc_end_ret = min(end, em_end - 1);
> > +
> > +     free_extent_map(em);
> > +     return true;
> > +}
> > +
> > +/*
> > + * Check if there's delalloc in a given range.
> > + *
> > + * @inode:               The inode.
> > + * @start:               The start offset of the range. It does not need to be
> > + *                       sector size aligned.
> > + * @end:                 The end offset (inclusive value) of the search range.
> > + *                       It does not need to be sector size aligned.
> > + * @delalloc_start_ret:  Output argument, set to the start offset of the
> > + *                       subrange found with delalloc (may not be sector size
> > + *                       aligned).
> > + * @delalloc_end_ret:    Output argument, set to he end offset (inclusive value)
> > + *                       of the subrange found with delalloc.
> > + *
> > + * Returns true if a subrange with delalloc is found within the given range, and
> > + * if so it sets @delalloc_start_ret and @delalloc_end_ret with the start and
> > + * end offsets of the subrange.
> > + */
> > +static bool have_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
> > +                                u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> > +{
> > +     u64 cur_offset = round_down(start, inode->root->fs_info->sectorsize);
> > +     u64 prev_delalloc_end = 0;
> > +     bool ret = false;
> > +
> > +     while (cur_offset < end) {
> > +             u64 delalloc_start;
> > +             u64 delalloc_end;
> > +             bool delalloc;
> > +
> > +             delalloc = find_delalloc_subrange(inode, cur_offset, end,
> > +                                               &delalloc_start,
> > +                                               &delalloc_end);
> > +             if (!delalloc)
> > +                     break;
> > +
> > +             if (prev_delalloc_end == 0) {
> > +                     /* First subrange found. */
> > +                     *delalloc_start_ret = max(delalloc_start, start);
> > +                     *delalloc_end_ret = delalloc_end;
> > +                     ret = true;
> > +             } else if (delalloc_start == prev_delalloc_end + 1) {
> > +                     /* Subrange adjacent to the previous one, merge them. */
> > +                     *delalloc_end_ret = delalloc_end;
> > +             } else {
> > +                     /* Subrange not adjacent to the previous one, exit. */
> > +                     break;
> > +             }
> > +
> > +             prev_delalloc_end = delalloc_end;
> > +             cur_offset = delalloc_end + 1;
> > +             cond_resched();
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +/*
> > + * Check if there's a hole or delalloc range in a range representing a hole (or
> > + * prealloc extent) found in the inode's subvolume btree.
> > + *
> > + * @inode:      The inode.
> > + * @whence:     Seek mode (SEEK_DATA or SEEK_HOLE).
> > + * @start:      Start offset of the hole region. It does not need to be sector
> > + *              size aligned.
> > + * @end:        End offset (inclusive value) of the hole region. It does not
> > + *              need to be sector size aligned.
> > + * @start_ret:  Return parameter, used to set the start of the subrange in the
> > + *              hole that matches the search criteria (seek mode), if such
> > + *              subrange is found (return value of the function is true).
> > + *              The value returned here may not be sector size aligned.
> > + *
> > + * Returns true if a subrange matching the given seek mode is found, and if one
> > + * is found, it updates @start_ret with the start of the subrange.
> > + */
> > +static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
> > +                                     u64 start, u64 end, u64 *start_ret)
> > +{
> > +     u64 delalloc_start;
> > +     u64 delalloc_end;
> > +     bool delalloc;
> > +
> > +     delalloc = have_delalloc_in_range(inode, start, end, &delalloc_start,
> > +                                       &delalloc_end);
> > +     if (delalloc && whence == SEEK_DATA) {
> > +             *start_ret = delalloc_start;
> > +             return true;
> > +     }
> > +
> > +     if (delalloc && whence == SEEK_HOLE) {
> > +             /*
> > +              * We found delalloc but it starts after out start offset. So we
> > +              * have a hole between our start offset and the delalloc start.
> > +              */
> > +             if (start < delalloc_start) {
> > +                     *start_ret = start;
> > +                     return true;
> > +             }
> > +             /*
> > +              * Delalloc range starts at our start offset.
> > +              * If the delalloc range's length is smaller than our range,
> > +              * then it means we have a hole that starts where the delalloc
> > +              * subrange ends.
> > +              */
> > +             if (delalloc_end < end) {
> > +                     *start_ret = delalloc_end + 1;
> > +                     return true;
> > +             }
> > +
> > +             /* There's delalloc for the whole range. */
> > +             return false;
> > +     }
> > +
> > +     if (!delalloc && whence == SEEK_HOLE) {
> > +             *start_ret = start;
> > +             return true;
> > +     }
> > +
> > +     /*
> > +      * No delalloc in the range and we are seeking for data. The caller has
> > +      * to iterate to the next extent item in the subvolume btree.
> > +      */
> > +     return false;
> > +}
> > +
> >   static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
> >                                 int whence)
> >   {
> >       struct btrfs_fs_info *fs_info = inode->root->fs_info;
> > -     struct extent_map *em = NULL;
> >       struct extent_state *cached_state = NULL;
> > -     loff_t i_size = inode->vfs_inode.i_size;
> > +     const loff_t i_size = i_size_read(&inode->vfs_inode);
> > +     const u64 ino = btrfs_ino(inode);
> > +     struct btrfs_root *root = inode->root;
> > +     struct btrfs_path *path;
> > +     struct btrfs_key key;
> > +     u64 last_extent_end;
> >       u64 lockstart;
> >       u64 lockend;
> >       u64 start;
> > -     u64 len;
> > -     int ret = 0;
> > +     int ret;
> > +     bool found = false;
> >
> >       if (i_size == 0 || offset >= i_size)
> >               return -ENXIO;
> >
> > +     /*
> > +      * Quick path. If the inode has no prealloc extents and its number of
> > +      * bytes used matches its i_size, then it can not have holes.
> > +      */
> > +     if (whence == SEEK_HOLE &&
> > +         !(inode->flags & BTRFS_INODE_PREALLOC) &&
> > +         inode_get_bytes(&inode->vfs_inode) == i_size)
> > +             return i_size;
> > +
>
> Would we need a counter part for all holes quick path?'

I suppose you mean a file with an i_size > 0 and no extents at all.
That is already fast... the first btrfs_search_slot() will not find
any extent item and we finish very quickly.

Thanks.

>
> Thanks,
> Qu
>
> >       /*
> >        * offset can be negative, in this case we start finding DATA/HOLE from
> >        * the very start of the file.
> > @@ -3628,49 +3887,165 @@ static loff_t find_desired_extent(struct btrfs_inode *inode, loff_t offset,
> >       if (lockend <= lockstart)
> >               lockend = lockstart + fs_info->sectorsize;
> >       lockend--;
> > -     len = lockend - lockstart + 1;
> > +
> > +     path = btrfs_alloc_path();
> > +     if (!path)
> > +             return -ENOMEM;
> > +     path->reada = READA_FORWARD;
> > +
> > +     key.objectid = ino;
> > +     key.type = BTRFS_EXTENT_DATA_KEY;
> > +     key.offset = start;
> > +
> > +     last_extent_end = lockstart;
> >
> >       lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
> >
> > +     ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
> > +     if (ret < 0) {
> > +             goto out;
> > +     } else if (ret > 0 && path->slots[0] > 0) {
> > +             btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0] - 1);
> > +             if (key.objectid == ino && key.type == BTRFS_EXTENT_DATA_KEY)
> > +                     path->slots[0]--;
> > +     }
> > +
> >       while (start < i_size) {
> > -             em = btrfs_get_extent_fiemap(inode, start, len);
> > -             if (IS_ERR(em)) {
> > -                     ret = PTR_ERR(em);
> > -                     em = NULL;
> > -                     break;
> > +             struct extent_buffer *leaf = path->nodes[0];
> > +             struct btrfs_file_extent_item *extent;
> > +             u64 extent_end;
> > +
> > +             if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> > +                     ret = btrfs_next_leaf(root, path);
> > +                     if (ret < 0)
> > +                             goto out;
> > +                     else if (ret > 0)
> > +                             break;
> > +
> > +                     leaf = path->nodes[0];
> >               }
> >
> > -             if (whence == SEEK_HOLE &&
> > -                 (em->block_start == EXTENT_MAP_HOLE ||
> > -                  test_bit(EXTENT_FLAG_PREALLOC, &em->flags)))
> > -                     break;
> > -             else if (whence == SEEK_DATA &&
> > -                        (em->block_start != EXTENT_MAP_HOLE &&
> > -                         !test_bit(EXTENT_FLAG_PREALLOC, &em->flags)))
> > +             btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> > +             if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
> >                       break;
> >
> > -             start = em->start + em->len;
> > -             free_extent_map(em);
> > -             em = NULL;
> > +             extent_end = btrfs_file_extent_end(path);
> > +
> > +             /*
> > +              * In the first iteration we may have a slot that points to an
> > +              * extent that ends before our start offset, so skip it.
> > +              */
> > +             if (extent_end <= start) {
> > +                     path->slots[0]++;
> > +                     continue;
> > +             }
> > +
> > +             /* We have an implicit hole, NO_HOLES feature is likely set. */
> > +             if (last_extent_end < key.offset) {
> > +                     u64 search_start = last_extent_end;
> > +                     u64 found_start;
> > +
> > +                     /*
> > +                      * First iteration, @start matches @offset and it's
> > +                      * within the hole.
> > +                      */
> > +                     if (start == offset)
> > +                             search_start = offset;
> > +
> > +                     found = find_desired_extent_in_hole(inode, whence,
> > +                                                         search_start,
> > +                                                         key.offset - 1,
> > +                                                         &found_start);
> > +                     if (found) {
> > +                             start = found_start;
> > +                             break;
> > +                     }
> > +                     /*
> > +                      * Didn't find data or a hole (due to delalloc) in the
> > +                      * implicit hole range, so need to analyze the extent.
> > +                      */
> > +             }
> > +
> > +             extent = btrfs_item_ptr(leaf, path->slots[0],
> > +                                     struct btrfs_file_extent_item);
> > +
> > +             if (btrfs_file_extent_disk_bytenr(leaf, extent) == 0 ||
> > +                 btrfs_file_extent_type(leaf, extent) ==
> > +                 BTRFS_FILE_EXTENT_PREALLOC) {
> > +                     /*
> > +                      * Explicit hole or prealloc extent, search for delalloc.
> > +                      * A prealloc extent is treated like a hole.
> > +                      */
> > +                     u64 search_start = key.offset;
> > +                     u64 found_start;
> > +
> > +                     /*
> > +                      * First iteration, @start matches @offset and it's
> > +                      * within the hole.
> > +                      */
> > +                     if (start == offset)
> > +                             search_start = offset;
> > +
> > +                     found = find_desired_extent_in_hole(inode, whence,
> > +                                                         search_start,
> > +                                                         extent_end - 1,
> > +                                                         &found_start);
> > +                     if (found) {
> > +                             start = found_start;
> > +                             break;
> > +                     }
> > +                     /*
> > +                      * Didn't find data or a hole (due to delalloc) in the
> > +                      * implicit hole range, so need to analyze the next
> > +                      * extent item.
> > +                      */
> > +             } else {
> > +                     /*
> > +                      * Found a regular or inline extent.
> > +                      * If we are seeking for data, adjust the start offset
> > +                      * and stop, we're done.
> > +                      */
> > +                     if (whence == SEEK_DATA) {
> > +                             start = max_t(u64, key.offset, offset);
> > +                             found = true;
> > +                             break;
> > +                     }
> > +                     /*
> > +                      * Else, we are seeking for a hole, check the next file
> > +                      * extent item.
> > +                      */
> > +             }
> > +
> > +             start = extent_end;
> > +             last_extent_end = extent_end;
> > +             path->slots[0]++;
> >               if (fatal_signal_pending(current)) {
> >                       ret = -EINTR;
> > -                     break;
> > +                     goto out;
> >               }
> >               cond_resched();
> >       }
> > -     free_extent_map(em);
> > +
> > +     /* We have an implicit hole from the last extent found up to i_size. */
> > +     if (!found && start < i_size) {
> > +             found = find_desired_extent_in_hole(inode, whence, start,
> > +                                                 i_size - 1, &start);
> > +             if (!found)
> > +                     start = i_size;
> > +     }
> > +
> > +out:
> >       unlock_extent_cached(&inode->io_tree, lockstart, lockend,
> >                            &cached_state);
> > -     if (ret) {
> > -             offset = ret;
> > -     } else {
> > -             if (whence == SEEK_DATA && start >= i_size)
> > -                     offset = -ENXIO;
> > -             else
> > -                     offset = min_t(loff_t, start, i_size);
> > -     }
> > +     btrfs_free_path(path);
> > +
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     if (whence == SEEK_DATA && start >= i_size)
> > +             return -ENXIO;
> >
> > -     return offset;
> > +     return min_t(loff_t, start, i_size);
> >   }
> >
> >   static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
