Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781565AABAD
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 11:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235470AbiIBJmn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 05:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiIBJmm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 05:42:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF39B6D68
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 02:42:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D889B82A1B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 09:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BCDC433B5
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 09:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662111757;
        bh=E87swkrBplVC4d/z/LsQArm8HY0PMpbz9nCi15tsRM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SYP5V/ZrzQxDouXIzk6VymDq1YS5Nq3ReeZX1dYzFmliWpZh3IscKf2WMtwHBEJWC
         w/NPmKRqwmJ+Q/QV6AsPVyxl8gxIg9DoQkXKpzPy44rFECXRbUGfhHcQb1cYeU9Oj/
         GBaA1NgRa0Z8+0Xkgo2U0o2VtCiWwnbx8MtKhKH7bYujK61lqGyDnCaTm5APM+ynZ1
         aysyO7gN9l4TzgA6vhDtQQehffKQfB4rwcHg/6+y9gBUFhoqynVMZfBUPloQvGe1v/
         5M9EYxmJuGA+B3kh4Yi6q544OUyO+gHelXEqtHqCs0RdX4NFmqJBe9tGVrWZDyh7IB
         sJz6YYZPkRAgg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1225219ee46so3472145fac.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 02:42:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo0QFFMb9fngAWefysCHvTFeSKvUMvcqQU8DEUcObca28vEoFw8A
        4uC/r+4EzqhmONg/OAlWaeYiHxkpzADR94/PDAw=
X-Google-Smtp-Source: AA6agR5UzTeWwaP1KepQdKyABr+EvVWuR7T0Vnm1PH3As52ZIWIHq1EMw679tlYLm2bnWrkCDgyA+z18EpOidDxHLY0=
X-Received: by 2002:a05:6870:538c:b0:11b:e64f:ee1b with SMTP id
 h12-20020a056870538c00b0011be64fee1bmr1653143oan.92.1662111756033; Fri, 02
 Sep 2022 02:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662022922.git.fdmanana@suse.com> <afad772c28ed5fc236785df6f3c43282d5c12534.1662022922.git.fdmanana@suse.com>
 <5ccad791-2978-d300-2f82-9cccea4f4c3a@gmx.com> <CAL3q7H5QHYgBBAQp8fiVN8j5iTwRoKgSJ7fFXS7x_Rej1x7=GQ@mail.gmail.com>
 <ff62ceaf-ce3c-5b83-7131-f6b6c1d93ea1@suse.com>
In-Reply-To: <ff62ceaf-ce3c-5b83-7131-f6b6c1d93ea1@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 2 Sep 2022 10:41:59 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7LVe-6qOrSLAcuRijp9PshM3xGo4Bjq6kSvedehNGkEQ@mail.gmail.com>
Message-ID: <CAL3q7H7LVe-6qOrSLAcuRijp9PshM3xGo4Bjq6kSvedehNGkEQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] btrfs: make fiemap more efficient and accurate
 reporting extent sharedness
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
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

On Fri, Sep 2, 2022 at 10:35 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2022/9/2 16:59, Filipe Manana wrote:
> > On Fri, Sep 2, 2022 at 12:27 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> [...]
> >>
> >> Is there any other major usage for extent map now?
> >
> > For fsync at least is very important.
>
> OK, forgot that fsync is relying on that to determine if an extent needs
> to be logged.
>
> > Also for reads it's nice to not have to go to the b+tree.
> > If someone reads several pages of an extent, being able to get it directly
> > from the extent map tree is faster than having to go to the btree for
> > every read.
> > Extent map trees are per inode, but subvolume b+trees can have a lot of
> > concurrent write and read access.
> >
> >>
> >> I can only think of read, which uses extent map to grab the logical
> >> bytenr of the real extent.
> >>
> >> In that case, the SHARED flag doesn't make much sense anyway, can we do
> >> a cleanup for those flags? Since fiemap/lseek no longer relies on extent
> >> map anymore.
> >
> > I don't get it. What SHARED flag are talking about? And which "flags", where?
> > We have nothing specific for lseek/fiemap in the extent maps, so I
> > don't understand.
>
> Nevermind, I got confused and think there would be one SHARED flag for
> extent map, but that's totally wrong...
>
> >
> >>
> [...]
> >>
> >> Although this is correct, it still looks a little tricky.
> >>
> >> We rely on btrfs_release_path() to release all tree blocks in the
> >> subvolume tree, including unlocking the tree blocks, thus path->locks[0]
> >> is also 0, meaning next time we call btrfs_release_path() we won't try
> >> to unlock the cloned eb.
> >
> > We're not taking any lock on the cloned extent buffer. It's not
> > needed, it's private
> > to the task.
>
> Yep, that's completely fine, just looks a little tricky since we're
> going to release that path twice, and that's expected.

Hum?
It's twice but for different extent buffers.

>
> >
> >>
> >> But I'd say it's still pretty tricky, and unfortunately I don't have any
> >> better alternative.
> >>
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +/*
> >>> + * Process a range which is a hole or a prealloc extent in the inode's subvolume
> >>> + * btree. If @disk_bytenr is 0, we are dealing with a hole, otherwise a prealloc
> >>> + * extent. The end offset (@end) is inclusive.
> >>> + */
> >>> +static int fiemap_process_hole(struct btrfs_inode *inode,
> >>
> >> Does the name still make sense as we're handling both hole and prealloc
> >> range?
> >
> > I chose that name because hole and prealloc are treated the same way.
> > Sure, I could name it fiemap_process_hole_or_prealloc() or something
> > like that, but
> > I decided to keep the name shorter, make them explicit in the comments and code.
> >
> > The old code did the same, get_extent_skip_holes() skipped holes and
> > prealloc extents without delalloc.
> >
> >>
> >>
> >> And I always find the delalloc search a big pain during lseek/fiemap.
> >>
> >> I guess except using certain flags, there is some hard requirement for
> >> delalloc range reporting?
> >
> > Yes. Delalloc is not meant to be flushed for fiemap unless
> > FIEMAP_FLAG_SYNC is given by the user.
>
> Would it be possible to let btrfs always flush the delalloc range, no
> matter if FIEMAP_FLAG_SYNC is specified or not?
>
> I really want to avoid the whole delalloc search thing if possible.
>
> Although I'd guess such behavior would be against the fiemap
> requirement, and the extra writeback may greatly slow down the fiemap
> itself for large files with tons of delalloc, so not really expect this
> to happen.

No, doing such a change is a bad idea.
It changes the semantics and expected behaviour.

My goal here is to preserve all semantics and behaviour, but make it
more efficient.

Even if we were all to decide to do that, that should be done
separately - but I don't think that is correct anyway,
fiemap can be used to detect delalloc, and probably there are users
using it for that.


>
> > For lseek it's just not needed, but that was already mentioned /
> > discussed in patch 2/10.
> >
> [...]
> >>> +     /*
> >>> +      * Lookup the last file extent. We're not using i_size here because
> >>> +      * there might be preallocation past i_size.
> >>> +      */
> >>
> >> I'm wondering how could this happen?
> >
> > You can fallocate an extent at or after i_size.
> >
> >>
> >> Normally if we're truncating an inode, the extents starting after
> >> round_up(i_size, sectorsize) should be dropped.
> >
> > It has nothing to do with truncate, just fallocate.
> >
> >>
> >> Or if we later enlarge the inode, we may hit old extents and read out
> >> some stale data other than expected zeros.
> >>
> >> Thus searching using round_up(i_size, sectorsize) should still let us to
> >> reach the slot after the last file extent.
> >>
> >> Or did I miss something?
> >
> > Yes, it's about prealloc extents at or after i_size.
>
> Did you mean falloc using keep_size flag?

Yes. Otherwise the extent wouldn't end up beyond i_size.

>
> Then that explains the whole reason.

Great!
Thanks.

>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >>
> >> Thanks,
> >> Qu
> >>
> >>> +     ret = btrfs_lookup_file_extent(NULL, root, path, ino, (u64)-1, 0);
> >>> +     /* There can't be a file extent item at offset (u64)-1 */
> >>> +     ASSERT(ret != 0);
> >>> +     if (ret < 0)
> >>> +             return ret;
> >>> +
> >>> +     /*
> >>> +      * For a non-existing key, btrfs_search_slot() always leaves us at a
> >>> +      * slot > 0, except if the btree is empty, which is impossible because
> >>> +      * at least it has the inode item for this inode and all the items for
> >>> +      * the root inode 256.
> >>> +      */
> >>> +     ASSERT(path->slots[0] > 0);
> >>> +     path->slots[0]--;
> >>> +     leaf = path->nodes[0];
> >>> +     btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> >>> +     if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY) {
> >>> +             /* No file extent items in the subvolume tree. */
> >>> +             *last_extent_end_ret = 0;
> >>> +             return 0;
> >>>        }
> >>> -     btrfs_release_path(path);
> >>>
> >>>        /*
> >>> -      * we might have some extents allocated but more delalloc past those
> >>> -      * extents.  so, we trust isize unless the start of the last extent is
> >>> -      * beyond isize
> >>> +      * For an inline extent, the disk_bytenr is where inline data starts at,
> >>> +      * so first check if we have an inline extent item before checking if we
> >>> +      * have an implicit hole (disk_bytenr == 0).
> >>>         */
> >>> -     if (last < isize) {
> >>> -             last = (u64)-1;
> >>> -             last_for_get_extent = isize;
> >>> +     ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
> >>> +     if (btrfs_file_extent_type(leaf, ei) == BTRFS_FILE_EXTENT_INLINE) {
> >>> +             *last_extent_end_ret = btrfs_file_extent_end(path);
> >>> +             return 0;
> >>>        }
> >>>
> >>> -     lock_extent_bits(&inode->io_tree, start, start + len - 1,
> >>> -                      &cached_state);
> >>> +     /*
> >>> +      * Find the last file extent item that is not a hole (when NO_HOLES is
> >>> +      * not enabled). This should take at most 2 iterations in the worst
> >>> +      * case: we have one hole file extent item at slot 0 of a leaf and
> >>> +      * another hole file extent item as the last item in the previous leaf.
> >>> +      * This is because we merge file extent items that represent holes.
> >>> +      */
> >>> +     disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> >>> +     while (disk_bytenr == 0) {
> >>> +             ret = btrfs_previous_item(root, path, ino, BTRFS_EXTENT_DATA_KEY);
> >>> +             if (ret < 0) {
> >>> +                     return ret;
> >>> +             } else if (ret > 0) {
> >>> +                     /* No file extent items that are not holes. */
> >>> +                     *last_extent_end_ret = 0;
> >>> +                     return 0;
> >>> +             }
> >>> +             leaf = path->nodes[0];
> >>> +             ei = btrfs_item_ptr(leaf, path->slots[0],
> >>> +                                 struct btrfs_file_extent_item);
> >>> +             disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> >>> +     }
> >>>
> >>> -     em = get_extent_skip_holes(inode, start, last_for_get_extent);
> >>> -     if (!em)
> >>> -             goto out;
> >>> -     if (IS_ERR(em)) {
> >>> -             ret = PTR_ERR(em);
> >>> +     *last_extent_end_ret = btrfs_file_extent_end(path);
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> >>> +               u64 start, u64 len)
> >>> +{
> >>> +     const u64 ino = btrfs_ino(inode);
> >>> +     struct extent_state *cached_state = NULL;
> >>> +     struct btrfs_path *path;
> >>> +     struct btrfs_root *root = inode->root;
> >>> +     struct fiemap_cache cache = { 0 };
> >>> +     struct btrfs_backref_shared_cache *backref_cache;
> >>> +     struct ulist *roots;
> >>> +     struct ulist *tmp_ulist;
> >>> +     u64 last_extent_end;
> >>> +     u64 prev_extent_end;
> >>> +     u64 lockstart;
> >>> +     u64 lockend;
> >>> +     bool stopped = false;
> >>> +     int ret;
> >>> +
> >>> +     backref_cache = kzalloc(sizeof(*backref_cache), GFP_KERNEL);
> >>> +     path = btrfs_alloc_path();
> >>> +     roots = ulist_alloc(GFP_KERNEL);
> >>> +     tmp_ulist = ulist_alloc(GFP_KERNEL);
> >>> +     if (!backref_cache || !path || !roots || !tmp_ulist) {
> >>> +             ret = -ENOMEM;
> >>>                goto out;
> >>>        }
> >>>
> >>> -     while (!end) {
> >>> -             u64 offset_in_extent = 0;
> >>> +     lockstart = round_down(start, btrfs_inode_sectorsize(inode));
> >>> +     lockend = round_up(start + len, btrfs_inode_sectorsize(inode));
> >>> +     prev_extent_end = lockstart;
> >>>
> >>> -             /* break if the extent we found is outside the range */
> >>> -             if (em->start >= max || extent_map_end(em) < off)
> >>> -                     break;
> >>> +     lock_extent_bits(&inode->io_tree, lockstart, lockend, &cached_state);
> >>>
> >>> -             /*
> >>> -              * get_extent may return an extent that starts before our
> >>> -              * requested range.  We have to make sure the ranges
> >>> -              * we return to fiemap always move forward and don't
> >>> -              * overlap, so adjust the offsets here
> >>> -              */
> >>> -             em_start = max(em->start, off);
> >>> +     ret = fiemap_find_last_extent_offset(inode, path, &last_extent_end);
> >>> +     if (ret < 0)
> >>> +             goto out_unlock;
> >>> +     btrfs_release_path(path);
> >>>
> >>> +     path->reada = READA_FORWARD;
> >>> +     ret = fiemap_search_slot(inode, path, lockstart);
> >>> +     if (ret < 0) {
> >>> +             goto out_unlock;
> >>> +     } else if (ret > 0) {
> >>>                /*
> >>> -              * record the offset from the start of the extent
> >>> -              * for adjusting the disk offset below.  Only do this if the
> >>> -              * extent isn't compressed since our in ram offset may be past
> >>> -              * what we have actually allocated on disk.
> >>> +              * No file extent item found, but we may have delalloc between
> >>> +              * the current offset and i_size. So check for that.
> >>>                 */
> >>> -             if (!test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
> >>> -                     offset_in_extent = em_start - em->start;
> >>> -             em_end = extent_map_end(em);
> >>> -             em_len = em_end - em_start;
> >>> -             flags = 0;
> >>> -             if (em->block_start < EXTENT_MAP_LAST_BYTE)
> >>> -                     disko = em->block_start + offset_in_extent;
> >>> -             else
> >>> -                     disko = 0;
> >>> +             ret = 0;
> >>> +             goto check_eof_delalloc;
> >>> +     }
> >>> +
> >>> +     while (prev_extent_end < lockend) {
> >>> +             struct extent_buffer *leaf = path->nodes[0];
> >>> +             struct btrfs_file_extent_item *ei;
> >>> +             struct btrfs_key key;
> >>> +             u64 extent_end;
> >>> +             u64 extent_len;
> >>> +             u64 extent_offset = 0;
> >>> +             u64 extent_gen;
> >>> +             u64 disk_bytenr = 0;
> >>> +             u64 flags = 0;
> >>> +             int extent_type;
> >>> +             u8 compression;
> >>> +
> >>> +             btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> >>> +             if (key.objectid != ino || key.type != BTRFS_EXTENT_DATA_KEY)
> >>> +                     break;
> >>> +
> >>> +             extent_end = btrfs_file_extent_end(path);
> >>>
> >>>                /*
> >>> -              * bump off for our next call to get_extent
> >>> +              * The first iteration can leave us at an extent item that ends
> >>> +              * before our range's start. Move to the next item.
> >>>                 */
> >>> -             off = extent_map_end(em);
> >>> -             if (off >= max)
> >>> -                     end = 1;
> >>> -
> >>> -             if (em->block_start == EXTENT_MAP_INLINE) {
> >>> -                     flags |= (FIEMAP_EXTENT_DATA_INLINE |
> >>> -                               FIEMAP_EXTENT_NOT_ALIGNED);
> >>> -             } else if (em->block_start == EXTENT_MAP_DELALLOC) {
> >>> -                     flags |= (FIEMAP_EXTENT_DELALLOC |
> >>> -                               FIEMAP_EXTENT_UNKNOWN);
> >>> -             } else if (fieinfo->fi_extents_max) {
> >>> -                     u64 extent_gen;
> >>> -                     u64 bytenr = em->block_start -
> >>> -                             (em->start - em->orig_start);
> >>> +             if (extent_end <= lockstart)
> >>> +                     goto next_item;
> >>>
> >>> -                     /*
> >>> -                      * If two extent maps are merged, then their generation
> >>> -                      * is set to the maximum between their generations.
> >>> -                      * Otherwise its generation matches the one we have in
> >>> -                      * corresponding file extent item. If we have a merged
> >>> -                      * extent map, don't use its generation to speedup the
> >>> -                      * sharedness check below.
> >>> -                      */
> >>> -                     if (test_bit(EXTENT_FLAG_MERGED, &em->flags))
> >>> -                             extent_gen = 0;
> >>> -                     else
> >>> -                             extent_gen = em->generation;
> >>> +             /* We have in implicit hole (NO_HOLES feature enabled). */
> >>> +             if (prev_extent_end < key.offset) {
> >>> +                     const u64 range_end = min(key.offset, lockend) - 1;
> >>>
> >>> -                     /*
> >>> -                      * As btrfs supports shared space, this information
> >>> -                      * can be exported to userspace tools via
> >>> -                      * flag FIEMAP_EXTENT_SHARED.  If fi_extents_max == 0
> >>> -                      * then we're just getting a count and we can skip the
> >>> -                      * lookup stuff.
> >>> -                      */
> >>> -                     ret = btrfs_is_data_extent_shared(root, btrfs_ino(inode),
> >>> -                                                       bytenr, extent_gen,
> >>> -                                                       roots, tmp_ulist,
> >>> -                                                       backref_cache);
> >>> -                     if (ret < 0)
> >>> -                             goto out_free;
> >>> -                     if (ret)
> >>> -                             flags |= FIEMAP_EXTENT_SHARED;
> >>> -                     ret = 0;
> >>> -             }
> >>> -             if (test_bit(EXTENT_FLAG_COMPRESSED, &em->flags))
> >>> -                     flags |= FIEMAP_EXTENT_ENCODED;
> >>> -             if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> >>> -                     flags |= FIEMAP_EXTENT_UNWRITTEN;
> >>> +                     ret = fiemap_process_hole(inode, fieinfo, &cache,
> >>> +                                               backref_cache, 0, 0, 0,
> >>> +                                               roots, tmp_ulist,
> >>> +                                               prev_extent_end, range_end);
> >>> +                     if (ret < 0) {
> >>> +                             goto out_unlock;
> >>> +                     } else if (ret > 0) {
> >>> +                             /* fiemap_fill_next_extent() told us to stop. */
> >>> +                             stopped = true;
> >>> +                             break;
> >>> +                     }
> >>>
> >>> -             free_extent_map(em);
> >>> -             em = NULL;
> >>> -             if ((em_start >= last) || em_len == (u64)-1 ||
> >>> -                (last == (u64)-1 && isize <= em_end)) {
> >>> -                     flags |= FIEMAP_EXTENT_LAST;
> >>> -                     end = 1;
> >>> +                     /* We've reached the end of the fiemap range, stop. */
> >>> +                     if (key.offset >= lockend) {
> >>> +                             stopped = true;
> >>> +                             break;
> >>> +                     }
> >>>                }
> >>>
> >>> -             /* now scan forward to see if this is really the last extent. */
> >>> -             em = get_extent_skip_holes(inode, off, last_for_get_extent);
> >>> -             if (IS_ERR(em)) {
> >>> -                     ret = PTR_ERR(em);
> >>> -                     goto out;
> >>> +             extent_len = extent_end - key.offset;
> >>> +             ei = btrfs_item_ptr(leaf, path->slots[0],
> >>> +                                 struct btrfs_file_extent_item);
> >>> +             compression = btrfs_file_extent_compression(leaf, ei);
> >>> +             extent_type = btrfs_file_extent_type(leaf, ei);
> >>> +             extent_gen = btrfs_file_extent_generation(leaf, ei);
> >>> +
> >>> +             if (extent_type != BTRFS_FILE_EXTENT_INLINE) {
> >>> +                     disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
> >>> +                     if (compression == BTRFS_COMPRESS_NONE)
> >>> +                             extent_offset = btrfs_file_extent_offset(leaf, ei);
> >>>                }
> >>> -             if (!em) {
> >>> -                     flags |= FIEMAP_EXTENT_LAST;
> >>> -                     end = 1;
> >>> +
> >>> +             if (compression != BTRFS_COMPRESS_NONE)
> >>> +                     flags |= FIEMAP_EXTENT_ENCODED;
> >>> +
> >>> +             if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
> >>> +                     flags |= FIEMAP_EXTENT_DATA_INLINE;
> >>> +                     flags |= FIEMAP_EXTENT_NOT_ALIGNED;
> >>> +                     ret = emit_fiemap_extent(fieinfo, &cache, key.offset, 0,
> >>> +                                              extent_len, flags);
> >>> +             } else if (extent_type == BTRFS_FILE_EXTENT_PREALLOC) {
> >>> +                     ret = fiemap_process_hole(inode, fieinfo, &cache,
> >>> +                                               backref_cache,
> >>> +                                               disk_bytenr, extent_offset,
> >>> +                                               extent_gen, roots, tmp_ulist,
> >>> +                                               key.offset, extent_end - 1);
> >>> +             } else if (disk_bytenr == 0) {
> >>> +                     /* We have an explicit hole. */
> >>> +                     ret = fiemap_process_hole(inode, fieinfo, &cache,
> >>> +                                               backref_cache, 0, 0, 0,
> >>> +                                               roots, tmp_ulist,
> >>> +                                               key.offset, extent_end - 1);
> >>> +             } else {
> >>> +                     /* We have a regular extent. */
> >>> +                     if (fieinfo->fi_extents_max) {
> >>> +                             ret = btrfs_is_data_extent_shared(root, ino,
> >>> +                                                               disk_bytenr,
> >>> +                                                               extent_gen,
> >>> +                                                               roots,
> >>> +                                                               tmp_ulist,
> >>> +                                                               backref_cache);
> >>> +                             if (ret < 0)
> >>> +                                     goto out_unlock;
> >>> +                             else if (ret > 0)
> >>> +                                     flags |= FIEMAP_EXTENT_SHARED;
> >>> +                     }
> >>> +
> >>> +                     ret = emit_fiemap_extent(fieinfo, &cache, key.offset,
> >>> +                                              disk_bytenr + extent_offset,
> >>> +                                              extent_len, flags);
> >>>                }
> >>> -             ret = emit_fiemap_extent(fieinfo, &cache, em_start, disko,
> >>> -                                        em_len, flags);
> >>> -             if (ret) {
> >>> -                     if (ret == 1)
> >>> -                             ret = 0;
> >>> -                     goto out_free;
> >>> +
> >>> +             if (ret < 0) {
> >>> +                     goto out_unlock;
> >>> +             } else if (ret > 0) {
> >>> +                     /* fiemap_fill_next_extent() told us to stop. */
> >>> +                     stopped = true;
> >>> +                     break;
> >>>                }
> >>>
> >>> +             prev_extent_end = extent_end;
> >>> +next_item:
> >>>                if (fatal_signal_pending(current)) {
> >>>                        ret = -EINTR;
> >>> -                     goto out_free;
> >>> +                     goto out_unlock;
> >>>                }
> >>> +
> >>> +             ret = fiemap_next_leaf_item(inode, path);
> >>> +             if (ret < 0) {
> >>> +                     goto out_unlock;
> >>> +             } else if (ret > 0) {
> >>> +                     /* No more file extent items for this inode. */
> >>> +                     break;
> >>> +             }
> >>> +             cond_resched();
> >>>        }
> >>> -out_free:
> >>> -     if (!ret)
> >>> -             ret = emit_last_fiemap_cache(fieinfo, &cache);
> >>> -     free_extent_map(em);
> >>> -out:
> >>> -     unlock_extent_cached(&inode->io_tree, start, start + len - 1,
> >>> -                          &cached_state);
> >>>
> >>> -out_free_ulist:
> >>> +check_eof_delalloc:
> >>> +     /*
> >>> +      * Release (and free) the path before emitting any final entries to
> >>> +      * fiemap_fill_next_extent() to keep lockdep happy. This is because
> >>> +      * once we find no more file extent items exist, we may have a
> >>> +      * non-cloned leaf, and fiemap_fill_next_extent() can trigger page
> >>> +      * faults when copying data to the user space buffer.
> >>> +      */
> >>> +     btrfs_free_path(path);
> >>> +     path = NULL;
> >>> +
> >>> +     if (!stopped && prev_extent_end < lockend) {
> >>> +             ret = fiemap_process_hole(inode, fieinfo, &cache, backref_cache,
> >>> +                                       0, 0, 0, roots, tmp_ulist,
> >>> +                                       prev_extent_end, lockend - 1);
> >>> +             if (ret < 0)
> >>> +                     goto out_unlock;
> >>> +             prev_extent_end = lockend;
> >>> +     }
> >>> +
> >>> +     if (cache.cached && cache.offset + cache.len >= last_extent_end) {
> >>> +             const u64 i_size = i_size_read(&inode->vfs_inode);
> >>> +
> >>> +             if (prev_extent_end < i_size) {
> >>> +                     u64 delalloc_start;
> >>> +                     u64 delalloc_end;
> >>> +                     bool delalloc;
> >>> +
> >>> +                     delalloc = btrfs_find_delalloc_in_range(inode,
> >>> +                                                             prev_extent_end,
> >>> +                                                             i_size - 1,
> >>> +                                                             &delalloc_start,
> >>> +                                                             &delalloc_end);
> >>> +                     if (!delalloc)
> >>> +                             cache.flags |= FIEMAP_EXTENT_LAST;
> >>> +             } else {
> >>> +                     cache.flags |= FIEMAP_EXTENT_LAST;
> >>> +             }
> >>> +     }
> >>> +
> >>> +     ret = emit_last_fiemap_cache(fieinfo, &cache);
> >>> +
> >>> +out_unlock:
> >>> +     unlock_extent_cached(&inode->io_tree, lockstart, lockend, &cached_state);
> >>> +out:
> >>>        kfree(backref_cache);
> >>>        btrfs_free_path(path);
> >>>        ulist_free(roots);
> >>> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> >>> index b292a8ada3a4..636b3ec46184 100644
> >>> --- a/fs/btrfs/file.c
> >>> +++ b/fs/btrfs/file.c
> >>> @@ -3602,10 +3602,10 @@ static long btrfs_fallocate(struct file *file, int mode,
> >>>    }
> >>>
> >>>    /*
> >>> - * Helper for have_delalloc_in_range(). Find a subrange in a given range that
> >>> - * has unflushed and/or flushing delalloc. There might be other adjacent
> >>> - * subranges after the one it found, so have_delalloc_in_range() keeps looping
> >>> - * while it gets adjacent subranges, and merging them together.
> >>> + * Helper for btrfs_find_delalloc_in_range(). Find a subrange in a given range
> >>> + * that has unflushed and/or flushing delalloc. There might be other adjacent
> >>> + * subranges after the one it found, so btrfs_find_delalloc_in_range() keeps
> >>> + * looping while it gets adjacent subranges, and merging them together.
> >>>     */
> >>>    static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end,
> >>>                                   u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> >>> @@ -3740,8 +3740,8 @@ static bool find_delalloc_subrange(struct btrfs_inode *inode, u64 start, u64 end
> >>>     * if so it sets @delalloc_start_ret and @delalloc_end_ret with the start and
> >>>     * end offsets of the subrange.
> >>>     */
> >>> -static bool have_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
> >>> -                                u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> >>> +bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
> >>> +                               u64 *delalloc_start_ret, u64 *delalloc_end_ret)
> >>>    {
> >>>        u64 cur_offset = round_down(start, inode->root->fs_info->sectorsize);
> >>>        u64 prev_delalloc_end = 0;
> >>> @@ -3804,8 +3804,8 @@ static bool find_desired_extent_in_hole(struct btrfs_inode *inode, int whence,
> >>>        u64 delalloc_end;
> >>>        bool delalloc;
> >>>
> >>> -     delalloc = have_delalloc_in_range(inode, start, end, &delalloc_start,
> >>> -                                       &delalloc_end);
> >>> +     delalloc = btrfs_find_delalloc_in_range(inode, start, end,
> >>> +                                             &delalloc_start, &delalloc_end);
> >>>        if (delalloc && whence == SEEK_DATA) {
> >>>                *start_ret = delalloc_start;
> >>>                return true;
> >>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >>> index 2c7d31990777..8be1e021513a 100644
> >>> --- a/fs/btrfs/inode.c
> >>> +++ b/fs/btrfs/inode.c
> >>> @@ -7064,133 +7064,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
> >>>        return em;
> >>>    }
> >>>
> >>> -struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> >>> -                                        u64 start, u64 len)
> >>> -{
> >>> -     struct extent_map *em;
> >>> -     struct extent_map *hole_em = NULL;
> >>> -     u64 delalloc_start = start;
> >>> -     u64 end;
> >>> -     u64 delalloc_len;
> >>> -     u64 delalloc_end;
> >>> -     int err = 0;
> >>> -
> >>> -     em = btrfs_get_extent(inode, NULL, 0, start, len);
> >>> -     if (IS_ERR(em))
> >>> -             return em;
> >>> -     /*
> >>> -      * If our em maps to:
> >>> -      * - a hole or
> >>> -      * - a pre-alloc extent,
> >>> -      * there might actually be delalloc bytes behind it.
> >>> -      */
> >>> -     if (em->block_start != EXTENT_MAP_HOLE &&
> >>> -         !test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> >>> -             return em;
> >>> -     else
> >>> -             hole_em = em;
> >>> -
> >>> -     /* check to see if we've wrapped (len == -1 or similar) */
> >>> -     end = start + len;
> >>> -     if (end < start)
> >>> -             end = (u64)-1;
> >>> -     else
> >>> -             end -= 1;
> >>> -
> >>> -     em = NULL;
> >>> -
> >>> -     /* ok, we didn't find anything, lets look for delalloc */
> >>> -     delalloc_len = count_range_bits(&inode->io_tree, &delalloc_start,
> >>> -                              end, len, EXTENT_DELALLOC, 1);
> >>> -     delalloc_end = delalloc_start + delalloc_len;
> >>> -     if (delalloc_end < delalloc_start)
> >>> -             delalloc_end = (u64)-1;
> >>> -
> >>> -     /*
> >>> -      * We didn't find anything useful, return the original results from
> >>> -      * get_extent()
> >>> -      */
> >>> -     if (delalloc_start > end || delalloc_end <= start) {
> >>> -             em = hole_em;
> >>> -             hole_em = NULL;
> >>> -             goto out;
> >>> -     }
> >>> -
> >>> -     /*
> >>> -      * Adjust the delalloc_start to make sure it doesn't go backwards from
> >>> -      * the start they passed in
> >>> -      */
> >>> -     delalloc_start = max(start, delalloc_start);
> >>> -     delalloc_len = delalloc_end - delalloc_start;
> >>> -
> >>> -     if (delalloc_len > 0) {
> >>> -             u64 hole_start;
> >>> -             u64 hole_len;
> >>> -             const u64 hole_end = extent_map_end(hole_em);
> >>> -
> >>> -             em = alloc_extent_map();
> >>> -             if (!em) {
> >>> -                     err = -ENOMEM;
> >>> -                     goto out;
> >>> -             }
> >>> -
> >>> -             ASSERT(hole_em);
> >>> -             /*
> >>> -              * When btrfs_get_extent can't find anything it returns one
> >>> -              * huge hole
> >>> -              *
> >>> -              * Make sure what it found really fits our range, and adjust to
> >>> -              * make sure it is based on the start from the caller
> >>> -              */
> >>> -             if (hole_end <= start || hole_em->start > end) {
> >>> -                    free_extent_map(hole_em);
> >>> -                    hole_em = NULL;
> >>> -             } else {
> >>> -                    hole_start = max(hole_em->start, start);
> >>> -                    hole_len = hole_end - hole_start;
> >>> -             }
> >>> -
> >>> -             if (hole_em && delalloc_start > hole_start) {
> >>> -                     /*
> >>> -                      * Our hole starts before our delalloc, so we have to
> >>> -                      * return just the parts of the hole that go until the
> >>> -                      * delalloc starts
> >>> -                      */
> >>> -                     em->len = min(hole_len, delalloc_start - hole_start);
> >>> -                     em->start = hole_start;
> >>> -                     em->orig_start = hole_start;
> >>> -                     /*
> >>> -                      * Don't adjust block start at all, it is fixed at
> >>> -                      * EXTENT_MAP_HOLE
> >>> -                      */
> >>> -                     em->block_start = hole_em->block_start;
> >>> -                     em->block_len = hole_len;
> >>> -                     if (test_bit(EXTENT_FLAG_PREALLOC, &hole_em->flags))
> >>> -                             set_bit(EXTENT_FLAG_PREALLOC, &em->flags);
> >>> -             } else {
> >>> -                     /*
> >>> -                      * Hole is out of passed range or it starts after
> >>> -                      * delalloc range
> >>> -                      */
> >>> -                     em->start = delalloc_start;
> >>> -                     em->len = delalloc_len;
> >>> -                     em->orig_start = delalloc_start;
> >>> -                     em->block_start = EXTENT_MAP_DELALLOC;
> >>> -                     em->block_len = delalloc_len;
> >>> -             }
> >>> -     } else {
> >>> -             return hole_em;
> >>> -     }
> >>> -out:
> >>> -
> >>> -     free_extent_map(hole_em);
> >>> -     if (err) {
> >>> -             free_extent_map(em);
> >>> -             return ERR_PTR(err);
> >>> -     }
> >>> -     return em;
> >>> -}
> >>> -
> >>>    static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
> >>>                                                  const u64 start,
> >>>                                                  const u64 len,
> >>> @@ -8265,15 +8138,14 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >>>         * in the compression of data (in an async thread) and will return
> >>>         * before the compression is done and writeback is started. A second
> >>>         * filemap_fdatawrite_range() is needed to wait for the compression to
> >>> -      * complete and writeback to start. Without this, our user is very
> >>> -      * likely to get stale results, because the extents and extent maps for
> >>> -      * delalloc regions are only allocated when writeback starts.
> >>> +      * complete and writeback to start. We also need to wait for ordered
> >>> +      * extents to complete, because our fiemap implementation uses mainly
> >>> +      * file extent items to list the extents, searching for extent maps
> >>> +      * only for file ranges with holes or prealloc extents to figure out
> >>> +      * if we have delalloc in those ranges.
> >>>         */
> >>>        if (fieinfo->fi_flags & FIEMAP_FLAG_SYNC) {
> >>> -             ret = btrfs_fdatawrite_range(inode, 0, LLONG_MAX);
> >>> -             if (ret)
> >>> -                     return ret;
> >>> -             ret = filemap_fdatawait_range(inode->i_mapping, 0, LLONG_MAX);
> >>> +             ret = btrfs_wait_ordered_range(inode, 0, LLONG_MAX);
> >>>                if (ret)
> >>>                        return ret;
> >>>        }
