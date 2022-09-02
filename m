Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032695AAA83
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236021AbiIBIrq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 04:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbiIBIrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 04:47:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D96EDF3D
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 01:47:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF35362154
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFE4C433B5
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 08:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662108427;
        bh=IiIf5h72TPJ1Rl9CGhAgrhNfleCj458y0Q5CDmWrh9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C9wXgK140T6pG8xKOIAeVB1KTgHSp1c7KNuh/kwggnqv1EK2Rc7/klhOoXXdATICc
         +p5yclQaotROGQV+88X9UnkfrKSom97NuPbISK7dIGzfxwwa/WskE7AljKVHqf4wUX
         +cvMOiCDhCUmX/Ygu5z2XMk1eVuyash2PDoCfrxPrNJuYOM/u9r9i31O7rL4ZL3tob
         6AutolplwmnrYnc0NupxS2abUBI1NzOVyYfApDAn/YBaJkgLQs2ii5ApIPCVQa2mMk
         WXpVmcZ4Ju2L6ftoEw26o//s/0ckXHNV21v6EHjWHIpfNgt7gx0/NaKwwuw2k+38b8
         6/pTvW9ZulX+w==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-12243fcaa67so3133966fac.8
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 01:47:07 -0700 (PDT)
X-Gm-Message-State: ACgBeo01m4dOYU+8dYauDi1iqdLEBHiZGUUQgYC6hfWElaQ7gsC9l0Wl
        yTMe1xAnlN/s15C8N2trBQTvdlZFjCLRvlCOZBI=
X-Google-Smtp-Source: AA6agR5h2iEX10PHHgmFrIzH56djJQrtYPbpktKfEMt58sKolpq8ttCHsvCaW9ssYiO/KIKhb2Q8tfO58U+aoQZxjjE=
X-Received: by 2002:a05:6870:ea83:b0:fe:365f:cb9d with SMTP id
 s3-20020a056870ea8300b000fe365fcb9dmr1691751oap.98.1662108426100; Fri, 02 Sep
 2022 01:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662022922.git.fdmanana@suse.com> <5e696c29b65f6558b8012596aa513101ed04a21a.1662022922.git.fdmanana@suse.com>
 <d01aa277-353a-0a5d-503b-07cd3bc27632@gmx.com>
In-Reply-To: <d01aa277-353a-0a5d-503b-07cd3bc27632@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 2 Sep 2022 09:46:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6jRBPoYr3EvOGH4qSFGDpT1MHczdRiccNEr4ob+jhknA@mail.gmail.com>
Message-ID: <CAL3q7H6jRBPoYr3EvOGH4qSFGDpT1MHczdRiccNEr4ob+jhknA@mail.gmail.com>
Subject: Re: [PATCH 08/10] btrfs: speedup checking for extent sharedness
 during fiemap
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

On Thu, Sep 1, 2022 at 11:50 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2022/9/1 21:18, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > One of the most expensive tasks performed during fiemap is to check if
> > an extent is shared. This task has two major steps:
> >
> > 1) Check if the data extent is shared. This implies checking the extent
> >     item in the extent tree, checking delayed references, etc. If we
> >     find the data extent is directly shared, we terminate immediately;
> >
> > 2) If the data extent is not directly shared (its extent item has a
> >     refcount of 1), then it may be shared if we have snapshots that share
> >     subtrees of the inode's subvolume b+tree. So we check if the leaf
> >     containing the file extent item is shared, then its parent node, then
> >     the parent node of the parent node, etc, until we reach the root node
> >     or we find one of them is shared - in which case we stop immediately.
> >
> > During fiemap we process the extents of a file from left to right, from
> > file offset 0 to eof. This means that we iterate b+tree leaves from left
> > to right, and has the implication that we keep repeating that second step
> > above several times for the same b+tree path of the inode's subvolume
> > b+tree.
> >
> > For example, if we have two file extent items in leaf X, and the path to
> > leaf X is A -> B -> C -> X, then when we try to determine if the data
> > extent referenced by the first extent item is shared, we check if the data
> > extent is shared - if it's not, then we check if leaf X is shared, if not,
> > then we check if node C is shared, if not, then check if node B is shared,
> > if not than check if node A is shared. When we move to the next file
> > extent item, after determining the data extent is not shared, we repeat
> > the checks for X, C, B and A - doing all the expensive searches in the
> > extent tree, delayed refs, etc. If we have thousands of tile extents, then
> > we keep repeating the sharedness checks for the same paths over and over.
> >
> > On a file that has no shared extents or only a small portion, it's easy
> > to see that this scales terribly with the number of extents in the file
> > and the sizes of the extent and subvolume b+trees.
> >
> > This change eliminates the repeated sharedness check on extent buffers
> > by caching the results of the last path used. The results can be used as
> > long as no snapshots were created since they were cached (for not shared
> > extent buffers) or no roots were dropped since they were cached (for
> > shared extent buffers). This greatly reduces the time spent by fiemap for
> > files with thousands of extents and/or large extent and subvolume b+trees.
>
> This sounds pretty much like the existing btrfs_backref_cache is doing.
>
> It stores a map to speedup the backref lookup.
>
> But a quick search didn't hit things like btrfs_backref_edge() or
> btrfs_backref_cache().
>
> Would it be possible to reuse the existing facility to do the same thing?

Nop, the existing facility is heavy and is meant to collect all
backreferences for an extent.
It stores the backreferences in a rb tree, has to allocate memory for them, etc.

btrfs_check_shared() (now renamed to btrfs_is_data_extent_shared()),
is a much simpler
thing than collecting backreferences - it just stops once it finds an
extent is shared.

The cache I introduced is equally simple and the best fit for it, it
has a fixed size, no need
to collect backreferences, allocate memory for them, add them to a red
black tree, etc.
All it needs is a single path that doesn't change very often, and when
it does it's just one
extent buffer at a time. Also, it allows  to short circuit on 'not
shared' results right at level 0,
which is very common and makes a huge difference.

Thanks.

>
> Thanks,
> Qu
> >
> > Example performance test:
> >
> >      $ cat fiemap-perf-test.sh
> >      #!/bin/bash
> >
> >      DEV=/dev/sdi
> >      MNT=/mnt/sdi
> >
> >      mkfs.btrfs -f $DEV
> >      mount -o compress=lzo $DEV $MNT
> >
> >      # 40G gives 327680 128K file extents (due to compression).
> >      xfs_io -f -c "pwrite -S 0xab -b 1M 0 40G" $MNT/foobar
> >
> >      umount $MNT
> >      mount -o compress=lzo $DEV $MNT
> >
> >      start=$(date +%s%N)
> >      filefrag $MNT/foobar
> >      end=$(date +%s%N)
> >      dur=$(( (end - start) / 1000000 ))
> >      echo "fiemap took $dur milliseconds (metadata not cached)"
> >
> >      start=$(date +%s%N)
> >      filefrag $MNT/foobar
> >      end=$(date +%s%N)
> >      dur=$(( (end - start) / 1000000 ))
> >      echo "fiemap took $dur milliseconds (metadata cached)"
> >
> >      umount $MNT
> >
> > Before this patch:
> >
> >      $ ./fiemap-perf-test.sh
> >      (...)
> >      /mnt/sdi/foobar: 327680 extents found
> >      fiemap took 3597 milliseconds (metadata not cached)
> >      /mnt/sdi/foobar: 327680 extents found
> >      fiemap took 2107 milliseconds (metadata cached)
> >
> > After this patch:
> >
> >      $ ./fiemap-perf-test.sh
> >      (...)
> >      /mnt/sdi/foobar: 327680 extents found
> >      fiemap took 1646 milliseconds (metadata not cached)
> >      /mnt/sdi/foobar: 327680 extents found
> >      fiemap took 698 milliseconds (metadata cached)
> >
> > That's about 2.2x faster when no metadata is cached, and about 3x faster
> > when all metadata is cached. On a real filesystem with many other files,
> > data, directories, etc, the b+trees will be 2 or 3 levels higher,
> > therefore this optimization will have a higher impact.
> >
> > Several reports of a slow fiemap show up often, the two Link tags below
> > refer to two recent reports of such slowness. This patch, together with
> > the next ones in the series, is meant to address that.
> >
> > Link: https://lore.kernel.org/linux-btrfs/21dd32c6-f1f9-f44a-466a-e18fdc6788a7@virtuozzo.com/
> > Link: https://lore.kernel.org/linux-btrfs/Ysace25wh5BbLd5f@atmark-techno.com/
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/backref.c     | 122 ++++++++++++++++++++++++++++++++++++++++-
> >   fs/btrfs/backref.h     |  17 +++++-
> >   fs/btrfs/ctree.h       |  18 ++++++
> >   fs/btrfs/extent-tree.c |  10 +++-
> >   fs/btrfs/extent_io.c   |  11 ++--
> >   5 files changed, 170 insertions(+), 8 deletions(-)
> >
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index e2ac10a695b6..40b48abb6978 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -1511,6 +1511,105 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
> >       return ret;
> >   }
> >
> > +/*
> > + * The caller has joined a transaction or is holding a read lock on the
> > + * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
> > + * snapshot field changing while updating or checking the cache.
> > + */
> > +static bool lookup_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
> > +                                     struct btrfs_root *root,
> > +                                     u64 bytenr, int level, bool *is_shared)
> > +{
> > +     struct btrfs_backref_shared_cache_entry *entry;
> > +
> > +     if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
> > +             return false;
> > +
> > +     /*
> > +      * Level -1 is used for the data extent, which is not reliable to cache
> > +      * because its reference count can increase or decrease without us
> > +      * realizing. We cache results only for extent buffers that lead from
> > +      * the root node down to the leaf with the file extent item.
> > +      */
> > +     ASSERT(level >= 0);
> > +
> > +     entry = &cache->entries[level];
> > +
> > +     /* Unused cache entry or being used for some other extent buffer. */
> > +     if (entry->bytenr != bytenr)
> > +             return false;
> > +
> > +     /*
> > +      * We cached a false result, but the last snapshot generation of the
> > +      * root changed, so we now have a snapshot. Don't trust the result.
> > +      */
> > +     if (!entry->is_shared &&
> > +         entry->gen != btrfs_root_last_snapshot(&root->root_item))
> > +             return false;
> > +
> > +     /*
> > +      * If we cached a true result and the last generation used for dropping
> > +      * a root changed, we can not trust the result, because the dropped root
> > +      * could be a snapshot sharing this extent buffer.
> > +      */
> > +     if (entry->is_shared &&
> > +         entry->gen != btrfs_get_last_root_drop_gen(root->fs_info))
> > +             return false;
> > +
> > +     *is_shared = entry->is_shared;
> > +
> > +     return true;
> > +}
> > +
> > +/*
> > + * The caller has joined a transaction or is holding a read lock on the
> > + * fs_info->commit_root_sem semaphore, so no need to worry about the root's last
> > + * snapshot field changing while updating or checking the cache.
> > + */
> > +static void store_backref_shared_cache(struct btrfs_backref_shared_cache *cache,
> > +                                    struct btrfs_root *root,
> > +                                    u64 bytenr, int level, bool is_shared)
> > +{
> > +     struct btrfs_backref_shared_cache_entry *entry;
> > +     u64 gen;
> > +
> > +     if (WARN_ON_ONCE(level >= BTRFS_MAX_LEVEL))
> > +             return;
> > +
> > +     /*
> > +      * Level -1 is used for the data extent, which is not reliable to cache
> > +      * because its reference count can increase or decrease without us
> > +      * realizing. We cache results only for extent buffers that lead from
> > +      * the root node down to the leaf with the file extent item.
> > +      */
> > +     ASSERT(level >= 0);
> > +
> > +     if (is_shared)
> > +             gen = btrfs_get_last_root_drop_gen(root->fs_info);
> > +     else
> > +             gen = btrfs_root_last_snapshot(&root->root_item);
> > +
> > +     entry = &cache->entries[level];
> > +     entry->bytenr = bytenr;
> > +     entry->is_shared = is_shared;
> > +     entry->gen = gen;
> > +
> > +     /*
> > +      * If we found an extent buffer is shared, set the cache result for all
> > +      * extent buffers below it to true. As nodes in the path are COWed,
> > +      * their sharedness is moved to their children, and if a leaf is COWed,
> > +      * then the sharedness of a data extent becomes direct, the refcount of
> > +      * data extent is increased in the extent item at the extent tree.
> > +      */
> > +     if (is_shared) {
> > +             for (int i = 0; i < level; i++) {
> > +                     entry = &cache->entries[i];
> > +                     entry->is_shared = is_shared;
> > +                     entry->gen = gen;
> > +             }
> > +     }
> > +}
> > +
> >   /**
> >    * Check if a data extent is shared or not.
> >    *
> > @@ -1519,6 +1618,7 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
> >    * @bytenr: logical bytenr of the extent we are checking
> >    * @roots:  list of roots this extent is shared among
> >    * @tmp:    temporary list used for iteration
> > + * @cache:  a backref lookup result cache
> >    *
> >    * btrfs_is_data_extent_shared uses the backref walking code but will short
> >    * circuit as soon as it finds a root or inode that doesn't match the
> > @@ -1532,7 +1632,8 @@ int btrfs_find_all_roots(struct btrfs_trans_handle *trans,
> >    * Return: 0 if extent is not shared, 1 if it is shared, < 0 on error.
> >    */
> >   int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> > -                             struct ulist *roots, struct ulist *tmp)
> > +                             struct ulist *roots, struct ulist *tmp,
> > +                             struct btrfs_backref_shared_cache *cache)
> >   {
> >       struct btrfs_fs_info *fs_info = root->fs_info;
> >       struct btrfs_trans_handle *trans;
> > @@ -1545,6 +1646,7 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> >               .inum = inum,
> >               .share_count = 0,
> >       };
> > +     int level;
> >
> >       ulist_init(roots);
> >       ulist_init(tmp);
> > @@ -1561,22 +1663,40 @@ int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> >               btrfs_get_tree_mod_seq(fs_info, &elem);
> >       }
> >
> > +     /* -1 means we are in the bytenr of the data extent. */
> > +     level = -1;
> >       ULIST_ITER_INIT(&uiter);
> >       while (1) {
> > +             bool is_shared;
> > +             bool cached;
> > +
> >               ret = find_parent_nodes(trans, fs_info, bytenr, elem.seq, tmp,
> >                                       roots, NULL, &shared, false);
> >               if (ret == BACKREF_FOUND_SHARED) {
> >                       /* this is the only condition under which we return 1 */
> >                       ret = 1;
> > +                     if (level >= 0)
> > +                             store_backref_shared_cache(cache, root, bytenr,
> > +                                                        level, true);
> >                       break;
> >               }
> >               if (ret < 0 && ret != -ENOENT)
> >                       break;
> >               ret = 0;
> > +             if (level >= 0)
> > +                     store_backref_shared_cache(cache, root, bytenr,
> > +                                                level, false);
> >               node = ulist_next(tmp, &uiter);
> >               if (!node)
> >                       break;
> >               bytenr = node->val;
> > +             level++;
> > +             cached = lookup_backref_shared_cache(cache, root, bytenr, level,
> > +                                                  &is_shared);
> > +             if (cached) {
> > +                     ret = is_shared ? 1 : 0;
> > +                     break;
> > +             }
> >               shared.share_count = 0;
> >               cond_resched();
> >       }
> > diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> > index 08354394b1bb..797ba5371d55 100644
> > --- a/fs/btrfs/backref.h
> > +++ b/fs/btrfs/backref.h
> > @@ -17,6 +17,20 @@ struct inode_fs_paths {
> >       struct btrfs_data_container     *fspath;
> >   };
> >
> > +struct btrfs_backref_shared_cache_entry {
> > +     u64 bytenr;
> > +     u64 gen;
> > +     bool is_shared;
> > +};
> > +
> > +struct btrfs_backref_shared_cache {
> > +     /*
> > +      * A path from a root to a leaf that has a file extent item pointing to
> > +      * a given data extent should never exceed the maximum b+tree heigth.
> > +      */
> > +     struct btrfs_backref_shared_cache_entry entries[BTRFS_MAX_LEVEL];
> > +};
> > +
> >   typedef int (iterate_extent_inodes_t)(u64 inum, u64 offset, u64 root,
> >               void *ctx);
> >
> > @@ -63,7 +77,8 @@ int btrfs_find_one_extref(struct btrfs_root *root, u64 inode_objectid,
> >                         struct btrfs_inode_extref **ret_extref,
> >                         u64 *found_off);
> >   int btrfs_is_data_extent_shared(struct btrfs_root *root, u64 inum, u64 bytenr,
> > -                             struct ulist *roots, struct ulist *tmp);
> > +                             struct ulist *roots, struct ulist *tmp,
> > +                             struct btrfs_backref_shared_cache *cache);
> >
> >   int __init btrfs_prelim_ref_init(void);
> >   void __cold btrfs_prelim_ref_exit(void);
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 3dc30f5e6fd0..f7fe7f633eb5 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1095,6 +1095,13 @@ struct btrfs_fs_info {
> >       /* Updates are not protected by any lock */
> >       struct btrfs_commit_stats commit_stats;
> >
> > +     /*
> > +      * Last generation where we dropped a non-relocation root.
> > +      * Use btrfs_set_last_root_drop_gen() and btrfs_get_last_root_drop_gen()
> > +      * to change it and to read it, respectively.
> > +      */
> > +     u64 last_root_drop_gen;
> > +
> >       /*
> >        * Annotations for transaction events (structures are empty when
> >        * compiled without lockdep).
> > @@ -1119,6 +1126,17 @@ struct btrfs_fs_info {
> >   #endif
> >   };
> >
> > +static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
> > +                                             u64 gen)
> > +{
> > +     WRITE_ONCE(fs_info->last_root_drop_gen, gen);
> > +}
> > +
> > +static inline u64 btrfs_get_last_root_drop_gen(const struct btrfs_fs_info *fs_info)
> > +{
> > +     return READ_ONCE(fs_info->last_root_drop_gen);
> > +}
> > +
> >   static inline struct btrfs_fs_info *btrfs_sb(struct super_block *sb)
> >   {
> >       return sb->s_fs_info;
> > diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> > index bcd0e72cded3..9818285dface 100644
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -5635,6 +5635,8 @@ static noinline int walk_up_tree(struct btrfs_trans_handle *trans,
> >    */
> >   int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
> >   {
> > +     const bool is_reloc_root = (root->root_key.objectid ==
> > +                                 BTRFS_TREE_RELOC_OBJECTID);
> >       struct btrfs_fs_info *fs_info = root->fs_info;
> >       struct btrfs_path *path;
> >       struct btrfs_trans_handle *trans;
> > @@ -5794,6 +5796,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
> >                               goto out_end_trans;
> >                       }
> >
> > +                     if (!is_reloc_root)
> > +                             btrfs_set_last_root_drop_gen(fs_info, trans->transid);
> > +
> >                       btrfs_end_transaction_throttle(trans);
> >                       if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
> >                               btrfs_debug(fs_info,
> > @@ -5828,7 +5833,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
> >               goto out_end_trans;
> >       }
> >
> > -     if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
> > +     if (!is_reloc_root) {
> >               ret = btrfs_find_root(tree_root, &root->root_key, path,
> >                                     NULL, NULL);
> >               if (ret < 0) {
> > @@ -5860,6 +5865,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
> >               btrfs_put_root(root);
> >       root_dropped = true;
> >   out_end_trans:
> > +     if (!is_reloc_root)
> > +             btrfs_set_last_root_drop_gen(fs_info, trans->transid);
> > +
> >       btrfs_end_transaction_throttle(trans);
> >   out_free:
> >       kfree(wc);
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index a47710516ecf..781436cc373c 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -5519,6 +5519,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> >       struct btrfs_path *path;
> >       struct btrfs_root *root = inode->root;
> >       struct fiemap_cache cache = { 0 };
> > +     struct btrfs_backref_shared_cache *backref_cache;
> >       struct ulist *roots;
> >       struct ulist *tmp_ulist;
> >       int end = 0;
> > @@ -5526,13 +5527,11 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> >       u64 em_len = 0;
> >       u64 em_end = 0;
> >
> > +     backref_cache = kzalloc(sizeof(*backref_cache), GFP_KERNEL);
> >       path = btrfs_alloc_path();
> > -     if (!path)
> > -             return -ENOMEM;
> > -
> >       roots = ulist_alloc(GFP_KERNEL);
> >       tmp_ulist = ulist_alloc(GFP_KERNEL);
> > -     if (!roots || !tmp_ulist) {
> > +     if (!backref_cache || !path || !roots || !tmp_ulist) {
> >               ret = -ENOMEM;
> >               goto out_free_ulist;
> >       }
> > @@ -5658,7 +5657,8 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> >                        */
> >                       ret = btrfs_is_data_extent_shared(root, btrfs_ino(inode),
> >                                                         bytenr, roots,
> > -                                                       tmp_ulist);
> > +                                                       tmp_ulist,
> > +                                                       backref_cache);
> >                       if (ret < 0)
> >                               goto out_free;
> >                       if (ret)
> > @@ -5710,6 +5710,7 @@ int extent_fiemap(struct btrfs_inode *inode, struct fiemap_extent_info *fieinfo,
> >                            &cached_state);
> >
> >   out_free_ulist:
> > +     kfree(backref_cache);
> >       btrfs_free_path(path);
> >       ulist_free(roots);
> >       ulist_free(tmp_ulist);
