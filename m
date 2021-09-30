Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4EF41D603
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 11:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349239AbhI3JKU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 05:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349020AbhI3JKU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 05:10:20 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82FCC06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 02:08:37 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id 72so5093678qkk.7
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 02:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DTny9//T78IJvJmqJBBWfkotpT6IKMADUZ9a+c5NWsg=;
        b=aZFAc2TGU+wm1VcrIZTffZck6dgpKH339KF82ANwY+A8AmMGVheFWure5D+NoPic0t
         zugGWMq1Nj4dgD6TG1gnTv9ZIS0et4Xsqy8D8kaEOnprgpU5eO5ndWgwzW+C0Jgx2mqH
         svHwQY1rBDhTBCPl0QbCnkMwo999aIBDy6MWDFv6TDtydCIkQmgau8TFIdu2w8sS8/+7
         5N0HfzdwWQixlhAZZn91nDcG3aPRTc5ebKUMnfuh1OJ35/F2AyDsHc50qdj2J34ctngf
         jf4b5XTO4D5V83nCXNOUCdHv3zyiTJiV6b96xoeQplNX2UCAi+iC4nr49aU/jwDdlaJ/
         BFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DTny9//T78IJvJmqJBBWfkotpT6IKMADUZ9a+c5NWsg=;
        b=hu5fXA/NEFyLVsp3/zOm605EN28vW6NkQOZTEXK2BHD7c09QM0n14wqqdrz/SzAx1v
         mx0aEUNRVTL3u4Q1O7kjBtHqbOKW8wSyhy4sY/ct+s7md/rTOay7olR6Z+1oVQkUoZAt
         6LFGt4i7XnAcvkNKRH8u2Ks4FyBvYJw1hrSLLcDdjrAKwE+m0YQ1QJw/v79sMav4kx/5
         5iG7QYg0+i9wjwzxxm3kXw6rVcon6I806C5XhfaEbekL8uPZOUUmBWqlVVySu22Df2Ip
         T3wIdyhDHe9H+FV1bmvtMfZguAYbb+oOec2FAZJ9PjODJRKTNdFY7hfKlz3PrkraoRfX
         Aejg==
X-Gm-Message-State: AOAM533Ktio+TtcCXxrCgDt2VuwkMxjVDVj1HX8ZaCnILspMVopT53oV
        L9soYB2zxvqJLBuGvZWuQEXNpGBUfx0wffoDvm8dBa30
X-Google-Smtp-Source: ABdhPJx8r1E6Pwv6WFwPTJZ9yOp+u0eCjVqW3puAb+1X02ynxLUYch098NFpNhAsrEOEESNV7qGNf/IT4uvleG8ulOY=
X-Received: by 2002:a37:651:: with SMTP id 78mr3756108qkg.516.1632992916752;
 Thu, 30 Sep 2021 02:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <a012c6719317617e9ea00f7df05f5be56029bcbb.1632928572.git.josef@toxicpanda.com>
In-Reply-To: <a012c6719317617e9ea00f7df05f5be56029bcbb.1632928572.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 30 Sep 2021 10:08:00 +0100
Message-ID: <CAL3q7H72MYxX9Eob8ykWn5YJwzV2rC6newu_0ThreiSq3A3fZw@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: index free space entries on size
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 29, 2021 at 5:58 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
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
>          0 -> 1          : 0        |                                    =
    |
>          2 -> 3          : 0        |                                    =
    |
>          4 -> 7          : 0        |                                    =
    |
>          8 -> 15         : 0        |                                    =
    |
>         16 -> 31         : 0        |                                    =
    |
>         32 -> 63         : 0        |                                    =
    |
>         64 -> 127        : 0        |                                    =
    |
>        128 -> 255        : 0        |                                    =
    |
>        256 -> 511        : 10356    |****                                =
    |
>        512 -> 1023       : 58242    |*************************           =
    |
>       1024 -> 2047       : 74418    |********************************    =
    |
>       2048 -> 4095       : 90393    |************************************=
****|
>       4096 -> 8191       : 79119    |*********************************** =
    |
>       8192 -> 16383      : 35614    |***************                     =
    |
>      16384 -> 32767      : 13418    |*****                               =
    |
>      32768 -> 65535      : 12811    |*****                               =
    |
>      65536 -> 131071     : 17090    |*******                             =
    |
>     131072 -> 262143     : 26465    |***********                         =
    |
>     262144 -> 524287     : 40179    |*****************                   =
    |
>     524288 -> 1048575    : 55469    |************************            =
    |
>    1048576 -> 2097151    : 48807    |*********************               =
    |
>    2097152 -> 4194303    : 26744    |***********                         =
    |
>    4194304 -> 8388607    : 35351    |***************                     =
    |
>    8388608 -> 16777215   : 13918    |******                              =
    |
>   16777216 -> 33554431   : 21       |                                    =
    |
>
> avg =3D 908079 nsecs, total: 580889071441 nsecs, count: 639690
>
> And the patch results are
>
>      nsecs               : count     distribution
>          0 -> 1          : 0        |                                    =
    |
>          2 -> 3          : 0        |                                    =
    |
>          4 -> 7          : 0        |                                    =
    |
>          8 -> 15         : 0        |                                    =
    |
>         16 -> 31         : 0        |                                    =
    |
>         32 -> 63         : 0        |                                    =
    |
>         64 -> 127        : 0        |                                    =
    |
>        128 -> 255        : 0        |                                    =
    |
>        256 -> 511        : 6883     |**                                  =
    |
>        512 -> 1023       : 54346    |*********************               =
    |
>       1024 -> 2047       : 79170    |********************************    =
    |
>       2048 -> 4095       : 98890    |************************************=
****|
>       4096 -> 8191       : 81911    |*********************************   =
    |
>       8192 -> 16383      : 27075    |**********                          =
    |
>      16384 -> 32767      : 14668    |*****                               =
    |
>      32768 -> 65535      : 13251    |*****                               =
    |
>      65536 -> 131071     : 15340    |******                              =
    |
>     131072 -> 262143     : 26715    |**********                          =
    |
>     262144 -> 524287     : 43274    |*****************                   =
    |
>     524288 -> 1048575    : 53870    |*********************               =
    |
>    1048576 -> 2097151    : 55368    |**********************              =
    |
>    2097152 -> 4194303    : 41036    |****************                    =
    |
>    4194304 -> 8388607    : 24927    |**********                          =
    |
>    8388608 -> 16777215   : 33       |                                    =
    |
>   16777216 -> 33554431   : 9        |                                    =
    |
>
> avg =3D 623599 nsecs, total: 397259314759 nsecs, count: 637042
>
> There's a little variation in the amount of calls done because of timing
> of the threads with metadata requirements, but the avg, total, and
> count's are relatively consistent between runs (usually within 2-5% of
> each other).  As you can see here we have around a 30% decrease in
> average latency with a 30% decrease in overall time spent in
> find_free_extent.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks great, thanks.

> ---
> v1->v2:
> - removed the extraneous format change I made.
> - added comments to some of the more subtle parts of the patch.
>
>  fs/btrfs/free-space-cache.c | 84 +++++++++++++++++++++++++++++++++----
>  fs/btrfs/free-space-cache.h |  2 +
>  2 files changed, 79 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 0d26819b1cf6..abc050295fff 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -1576,6 +1576,44 @@ static int tree_insert_offset(struct rb_root *root=
, u64 offset,
>         return 0;
>  }
>
> +static u64 free_space_info_bytes(struct btrfs_free_space *info)
> +{
> +       if (info->bitmap && info->max_extent_size)
> +               return info->max_extent_size;
> +       return info->bytes;
> +}
> +
> +/*
> + * This is indexed in reverse of what we generally do for rb-tree's, the=
 largest
> + * chunks are left most and the smallest are rightmost.  This is so that=
 we can
> + * take advantage of the cached property of the cached rb-tree and simpl=
y get
> + * the largest free space chunk right away.
> + */
> +static void tree_insert_bytes(struct btrfs_free_space_ctl *ctl,
> +                             struct btrfs_free_space *info)
> +{
> +       struct rb_root_cached *root =3D &ctl->free_space_bytes;
> +       struct rb_node **p =3D &root->rb_root.rb_node;
> +       struct rb_node *parent_node =3D NULL;
> +       struct btrfs_free_space *tmp;
> +       bool leftmost =3D true;
> +
> +       while (*p) {
> +               parent_node =3D *p;
> +               tmp =3D rb_entry(parent_node, struct btrfs_free_space,
> +                              bytes_index);
> +               if (free_space_info_bytes(info) < free_space_info_bytes(t=
mp)) {
> +                       p =3D &(*p)->rb_right;
> +                       leftmost =3D false;
> +               } else {
> +                       p =3D &(*p)->rb_left;
> +               }
> +       }
> +
> +       rb_link_node(&info->bytes_index, parent_node, p);
> +       rb_insert_color_cached(&info->bytes_index, root, leftmost);
> +}
> +
>  /*
>   * searches the tree for the given offset.
>   *
> @@ -1704,6 +1742,7 @@ __unlink_free_space(struct btrfs_free_space_ctl *ct=
l,
>                     struct btrfs_free_space *info)
>  {
>         rb_erase(&info->offset_index, &ctl->free_space_offset);
> +       rb_erase_cached(&info->bytes_index, &ctl->free_space_bytes);
>         ctl->free_extents--;
>
>         if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
> @@ -1730,6 +1769,8 @@ static int link_free_space(struct btrfs_free_space_=
ctl *ctl,
>         if (ret)
>                 return ret;
>
> +       tree_insert_bytes(ctl, info);
> +
>         if (!info->bitmap && !btrfs_free_space_trimmed(info)) {
>                 ctl->discardable_extents[BTRFS_STAT_CURR]++;
>                 ctl->discardable_bytes[BTRFS_STAT_CURR] +=3D info->bytes;
> @@ -1876,7 +1917,7 @@ static inline u64 get_max_extent_size(struct btrfs_=
free_space *entry)
>  /* Cache the size of the max extent in bytes */
>  static struct btrfs_free_space *
>  find_free_space(struct btrfs_free_space_ctl *ctl, u64 *offset, u64 *byte=
s,
> -               unsigned long align, u64 *max_extent_size)
> +               unsigned long align, u64 *max_extent_size, bool use_bytes=
_index)
>  {
>         struct btrfs_free_space *entry;
>         struct rb_node *node;
> @@ -1887,15 +1928,37 @@ find_free_space(struct btrfs_free_space_ctl *ctl,=
 u64 *offset, u64 *bytes,
>         if (!ctl->free_space_offset.rb_node)
>                 goto out;
>
> -       entry =3D tree_search_offset(ctl, offset_to_bitmap(ctl, *offset),=
 0, 1);
> -       if (!entry)
> -               goto out;
> +       if (use_bytes_index) {
> +               node =3D rb_first_cached(&ctl->free_space_bytes);
> +       } else {
> +               entry =3D tree_search_offset(ctl, offset_to_bitmap(ctl, *=
offset),
> +                                          0, 1);
> +               if (!entry)
> +                       goto out;
> +               node =3D &entry->offset_index;
> +       }
>
> -       for (node =3D &entry->offset_index; node; node =3D rb_next(node))=
 {
> -               entry =3D rb_entry(node, struct btrfs_free_space, offset_=
index);
> +       for (; node; node =3D rb_next(node)) {
> +               if (use_bytes_index)
> +                       entry =3D rb_entry(node, struct btrfs_free_space,
> +                                        bytes_index);
> +               else
> +                       entry =3D rb_entry(node, struct btrfs_free_space,
> +                                        offset_index);
> +
> +               /*
> +                * If we are using the bytes index then all subsequent en=
tries
> +                * in this tree are going to be < bytes, so simply set th=
e max
> +                * extent size and exit the loop.
> +                *
> +                * If we're using the offset index then we need to keep g=
oing
> +                * through the rest of the tree.
> +                */
>                 if (entry->bytes < *bytes) {
>                         *max_extent_size =3D max(get_max_extent_size(entr=
y),
>                                                *max_extent_size);
> +                       if (use_bytes_index)
> +                               break;
>                         continue;
>                 }
>
> @@ -2482,6 +2545,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *fs=
_info,
>         info->bytes =3D bytes;
>         info->trim_state =3D trim_state;
>         RB_CLEAR_NODE(&info->offset_index);
> +       RB_CLEAR_NODE(&info->bytes_index);
>
>         spin_lock(&ctl->tree_lock);
>
> @@ -2795,6 +2859,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_g=
roup *block_group,
>         ctl->start =3D block_group->start;
>         ctl->private =3D block_group;
>         ctl->op =3D &free_space_op;
> +       ctl->free_space_bytes =3D RB_ROOT_CACHED;
>         INIT_LIST_HEAD(&ctl->trimming_ranges);
>         mutex_init(&ctl->cache_writeout_mutex);
>
> @@ -2860,6 +2925,7 @@ static void __btrfs_return_cluster_to_free_space(
>                 }
>                 tree_insert_offset(&ctl->free_space_offset,
>                                    entry->offset, &entry->offset_index, b=
itmap);
> +               tree_insert_bytes(ctl, entry);
>         }
>         cluster->root =3D RB_ROOT;
>         spin_unlock(&cluster->lock);
> @@ -2961,12 +3027,14 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block=
_group *block_group,
>         u64 align_gap =3D 0;
>         u64 align_gap_len =3D 0;
>         enum btrfs_trim_state align_gap_trim_state =3D BTRFS_TRIM_STATE_U=
NTRIMMED;
> +       bool use_bytes_index =3D (offset =3D=3D block_group->start);
>
>         ASSERT(!btrfs_is_zoned(block_group->fs_info));
>
>         spin_lock(&ctl->tree_lock);
>         entry =3D find_free_space(ctl, &offset, &bytes_search,
> -                               block_group->full_stripe_len, max_extent_=
size);
> +                               block_group->full_stripe_len, max_extent_=
size,
> +                               use_bytes_index);
>         if (!entry)
>                 goto out;
>
> @@ -3250,6 +3318,7 @@ static int btrfs_bitmap_cluster(struct btrfs_block_=
group *block_group,
>
>         cluster->window_start =3D start * ctl->unit + entry->offset;
>         rb_erase(&entry->offset_index, &ctl->free_space_offset);
> +       rb_erase_cached(&entry->bytes_index, &ctl->free_space_bytes);
>         ret =3D tree_insert_offset(&cluster->root, entry->offset,
>                                  &entry->offset_index, 1);
>         ASSERT(!ret); /* -EEXIST; Logic error */
> @@ -3340,6 +3409,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group *b=
lock_group,
>                         continue;
>
>                 rb_erase(&entry->offset_index, &ctl->free_space_offset);
> +               rb_erase_cached(&entry->bytes_index, &ctl->free_space_byt=
es);
>                 ret =3D tree_insert_offset(&cluster->root, entry->offset,
>                                          &entry->offset_index, 0);
>                 total_size +=3D entry->bytes;
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index 1f23088d43f9..dd982d204d2d 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -22,6 +22,7 @@ enum btrfs_trim_state {
>
>  struct btrfs_free_space {
>         struct rb_node offset_index;
> +       struct rb_node bytes_index;
>         u64 offset;
>         u64 bytes;
>         u64 max_extent_size;
> @@ -45,6 +46,7 @@ static inline bool btrfs_free_space_trimming_bitmap(
>  struct btrfs_free_space_ctl {
>         spinlock_t tree_lock;
>         struct rb_root free_space_offset;
> +       struct rb_root_cached free_space_bytes;
>         u64 free_space;
>         int extents_thresh;
>         int free_extents;
> --
> 2.29.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
