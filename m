Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD482A694F
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 17:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgKDQUy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Nov 2020 11:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgKDQUy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Nov 2020 11:20:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB87C0613D3
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Nov 2020 08:20:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id i7so12568191qti.6
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Nov 2020 08:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lls/7ghDCvrXPUM+dqUjDXvvno+yLd66BRQxh8cqXno=;
        b=SZ7o9y1u3UsSpIc0bgRlSII5i0N0XuJM+kpCVpMP7mygWHCyFtRO1lDMxm3ux4x8WN
         PX0inStvCv8O8wgT5B9QZqRjCTMVXPd1fIRy68+07o5xi255SBEpl11sjhSz7NzMnrvv
         FQgLJ0eyK0gd03IWJ9DwGvhTZO9PvSV6Jy4fsEh0+e0Ck76DoNcI7XXxDylq3V/Czqfg
         592SwHMwJXWbL1RVs3Fj+A29F7vckTQBVwNkWr6tA1h1MKtpJYMGWxHrDgG0ZJpRyD0i
         JWf4FTvR43OundjC/qWklzFFKF1NdfVVhjPD7FVAm6B8CGvu/M/Qznt2zG+ap9AZCExY
         hdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lls/7ghDCvrXPUM+dqUjDXvvno+yLd66BRQxh8cqXno=;
        b=oopBAcJKQysfGzmnZbz2u8ylbe6wys2uJFb/fSw+xVqfAf9gYRxh6VzTk16qB/Dyx1
         2UHLArDJBJ7QwQ3WkvQz1DLSfma4Vy58SKk0l84wN94SHcS4R7CsDk55R1TpXv1JpIFX
         fude1AvxoxAsTVtdOXs9Jf/u7IJgcf8kFLe7OE6QC8br/l7XWVZYgizcW5Fz/xhqsVVd
         HLGOxcHvF7+0peIgVVXF/BfffKzh1t2wQOrK1wzDFJojQTuYU6jabd43Y8JYb4SiYQFm
         L4t9E/t8DPVg0/eDYyMHqZYGvp7DrPiDdkSpoyKiU1Fbqp5ezeLgooGo2ODpzpKQdLIu
         1YLw==
X-Gm-Message-State: AOAM530rWmA3OENVArwdleprHB2NtOCgraDYye8/7IjvWzzaMFyWHEzs
        cXsMQD9cMqm/2Sn9+GiZahO75GWPvJDQIMLQvMU=
X-Google-Smtp-Source: ABdhPJwHA0HLRsCIK744tKGdBN3/HtvozjZoMK4qahs74PU+9VWIEJmO5Ur8xVzMI/OKCDJp9VEFZuXAdpIL0qzqj9k=
X-Received: by 2002:ac8:67d9:: with SMTP id r25mr20733728qtp.21.1604506853166;
 Wed, 04 Nov 2020 08:20:53 -0800 (PST)
MIME-Version: 1.0
References: <cover.1603460665.git.josef@toxicpanda.com> <a21f2834a44901bc2b685bc3d19db831eca7b8f1.1603460665.git.josef@toxicpanda.com>
In-Reply-To: <a21f2834a44901bc2b685bc3d19db831eca7b8f1.1603460665.git.josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 4 Nov 2020 16:20:42 +0000
Message-ID: <CAL3q7H6+QW=9JRGPu_VAgP7mFm=vHjAprhNNZCEJGhFSa0d3xA@mail.gmail.com>
Subject: Re: [PATCH 5/8] btrfs: load free space cache into a temporary ctl
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 23, 2020 at 5:12 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> The free space cache has been special in that we would load it right
> away instead of farming the work off to a worker thread.  This resulted
> in some weirdness that had to be taken into account for this fact,
> namely that if we every found a block group being cached the fast way we
> had to wait for it to finish, because we could get the cache before it
> had been validated and we may throw the cache away.
>
> To handle this particular case instead create a temporary
> btrfs_free_space_ctl to load the free space cache into.  Then once we've
> validated that it makes sense, copy it's contents into the actual
> block_group->free_space_ctl.  This allows us to avoid the problems of
> needing to wait for the caching to complete, we can clean up the discard
> extent handling stuff in __load_free_space_cache, and we no longer need
> to do the merge_space_tree() because the space is added one by one into
> the real free_space_ctl.  This will allow further reworks of how we
> handle loading the free space cache.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
>  fs/btrfs/block-group.c       |  29 +------
>  fs/btrfs/free-space-cache.c  | 155 +++++++++++++++--------------------
>  fs/btrfs/free-space-cache.h  |   3 +-
>  fs/btrfs/tests/btrfs-tests.c |   2 +-
>  4 files changed, 70 insertions(+), 119 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index bb6685711824..adbd18dc08a1 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -695,33 +695,6 @@ int btrfs_cache_block_group(struct btrfs_block_group=
 *cache, int load_cache_only
>         btrfs_init_work(&caching_ctl->work, caching_thread, NULL, NULL);
>
>         spin_lock(&cache->lock);
> -       /*
> -        * This should be a rare occasion, but this could happen I think =
in the
> -        * case where one thread starts to load the space cache info, and=
 then
> -        * some other thread starts a transaction commit which tries to d=
o an
> -        * allocation while the other thread is still loading the space c=
ache
> -        * info.  The previous loop should have kept us from choosing thi=
s block
> -        * group, but if we've moved to the state where we will wait on c=
aching
> -        * block groups we need to first check if we're doing a fast load=
 here,
> -        * so we can wait for it to finish, otherwise we could end up all=
ocating
> -        * from a block group who's cache gets evicted for one reason or
> -        * another.
> -        */
> -       while (cache->cached =3D=3D BTRFS_CACHE_FAST) {
> -               struct btrfs_caching_control *ctl;
> -
> -               ctl =3D cache->caching_ctl;
> -               refcount_inc(&ctl->count);
> -               prepare_to_wait(&ctl->wait, &wait, TASK_UNINTERRUPTIBLE);
> -               spin_unlock(&cache->lock);
> -
> -               schedule();
> -
> -               finish_wait(&ctl->wait, &wait);
> -               btrfs_put_caching_control(ctl);
> -               spin_lock(&cache->lock);
> -       }
> -
>         if (cache->cached !=3D BTRFS_CACHE_NO) {
>                 spin_unlock(&cache->lock);
>                 kfree(caching_ctl);
> @@ -1805,7 +1778,7 @@ static struct btrfs_block_group *btrfs_create_block=
_group_cache(
>         INIT_LIST_HEAD(&cache->discard_list);
>         INIT_LIST_HEAD(&cache->dirty_list);
>         INIT_LIST_HEAD(&cache->io_list);
> -       btrfs_init_free_space_ctl(cache);
> +       btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
>         atomic_set(&cache->frozen, 0);
>         mutex_init(&cache->free_space_lock);
>         btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root)=
;
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 0787339c7b93..58bd2d3e54db 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -33,8 +33,6 @@ struct btrfs_trim_range {
>         struct list_head list;
>  };
>
> -static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
> -                               struct btrfs_free_space *bitmap_info);
>  static int link_free_space(struct btrfs_free_space_ctl *ctl,
>                            struct btrfs_free_space *info);
>  static void unlink_free_space(struct btrfs_free_space_ctl *ctl,
> @@ -43,6 +41,14 @@ static int btrfs_wait_cache_io_root(struct btrfs_root =
*root,
>                              struct btrfs_trans_handle *trans,
>                              struct btrfs_io_ctl *io_ctl,
>                              struct btrfs_path *path);
> +static int search_bitmap(struct btrfs_free_space_ctl *ctl,
> +                        struct btrfs_free_space *bitmap_info, u64 *offse=
t,
> +                        u64 *bytes, bool for_alloc);
> +static void free_bitmap(struct btrfs_free_space_ctl *ctl,
> +                       struct btrfs_free_space *bitmap_info);
> +static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
> +                             struct btrfs_free_space *info, u64 offset,
> +                             u64 bytes);
>
>  static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
>                                                struct btrfs_path *path,
> @@ -625,44 +631,6 @@ static int io_ctl_read_bitmap(struct btrfs_io_ctl *i=
o_ctl,
>         return 0;
>  }
>
> -/*
> - * Since we attach pinned extents after the fact we can have contiguous =
sections
> - * of free space that are split up in entries.  This poses a problem wit=
h the
> - * tree logging stuff since it could have allocated across what appears =
to be 2
> - * entries since we would have merged the entries when adding the pinned=
 extents
> - * back to the free space cache.  So run through the space cache that we=
 just
> - * loaded and merge contiguous entries.  This will make the log replay s=
tuff not
> - * blow up and it will make for nicer allocator behavior.
> - */
> -static void merge_space_tree(struct btrfs_free_space_ctl *ctl)
> -{
> -       struct btrfs_free_space *e, *prev =3D NULL;
> -       struct rb_node *n;
> -
> -again:
> -       spin_lock(&ctl->tree_lock);
> -       for (n =3D rb_first(&ctl->free_space_offset); n; n =3D rb_next(n)=
) {
> -               e =3D rb_entry(n, struct btrfs_free_space, offset_index);
> -               if (!prev)
> -                       goto next;
> -               if (e->bitmap || prev->bitmap)
> -                       goto next;
> -               if (prev->offset + prev->bytes =3D=3D e->offset) {
> -                       unlink_free_space(ctl, prev);
> -                       unlink_free_space(ctl, e);
> -                       prev->bytes +=3D e->bytes;
> -                       kmem_cache_free(btrfs_free_space_cachep, e);
> -                       link_free_space(ctl, prev);
> -                       prev =3D NULL;
> -                       spin_unlock(&ctl->tree_lock);
> -                       goto again;
> -               }
> -next:
> -               prev =3D e;
> -       }
> -       spin_unlock(&ctl->tree_lock);
> -}
> -
>  static int __load_free_space_cache(struct btrfs_root *root, struct inode=
 *inode,
>                                    struct btrfs_free_space_ctl *ctl,
>                                    struct btrfs_path *path, u64 offset)
> @@ -753,16 +721,6 @@ static int __load_free_space_cache(struct btrfs_root=
 *root, struct inode *inode,
>                         goto free_cache;
>                 }
>
> -               /*
> -                * Sync discard ensures that the free space cache is alwa=
ys
> -                * trimmed.  So when reading this in, the state should re=
flect
> -                * that.  We also do this for async as a stop gap for lac=
k of
> -                * persistence.
> -                */
> -               if (btrfs_test_opt(fs_info, DISCARD_SYNC) ||
> -                   btrfs_test_opt(fs_info, DISCARD_ASYNC))
> -                       e->trim_state =3D BTRFS_TRIM_STATE_TRIMMED;
> -
>                 if (!e->bytes) {
>                         kmem_cache_free(btrfs_free_space_cachep, e);
>                         goto free_cache;
> @@ -816,16 +774,9 @@ static int __load_free_space_cache(struct btrfs_root=
 *root, struct inode *inode,
>                 ret =3D io_ctl_read_bitmap(&io_ctl, e);
>                 if (ret)
>                         goto free_cache;
> -               e->bitmap_extents =3D count_bitmap_extents(ctl, e);
> -               if (!btrfs_free_space_trimmed(e)) {
> -                       ctl->discardable_extents[BTRFS_STAT_CURR] +=3D
> -                               e->bitmap_extents;
> -                       ctl->discardable_bytes[BTRFS_STAT_CURR] +=3D e->b=
ytes;
> -               }
>         }
>
>         io_ctl_drop_pages(&io_ctl);
> -       merge_space_tree(ctl);
>         ret =3D 1;
>  out:
>         io_ctl_free(&io_ctl);
> @@ -836,16 +787,59 @@ static int __load_free_space_cache(struct btrfs_roo=
t *root, struct inode *inode,
>         goto out;
>  }
>
> +static int copy_free_space_cache(struct btrfs_block_group *block_group,
> +                                struct btrfs_free_space_ctl *ctl)
> +{
> +       struct btrfs_free_space *info;
> +       struct rb_node *n;
> +       int ret =3D 0;
> +
> +       while (!ret && (n =3D rb_first(&ctl->free_space_offset)) !=3D NUL=
L) {
> +               info =3D rb_entry(n, struct btrfs_free_space, offset_inde=
x);
> +               if (!info->bitmap) {
> +                       unlink_free_space(ctl, info);
> +                       ret =3D btrfs_add_free_space(block_group, info->o=
ffset,
> +                                                  info->bytes);
> +                       kmem_cache_free(btrfs_free_space_cachep, info);
> +               } else {
> +                       u64 offset =3D info->offset;
> +                       u64 bytes =3D ctl->unit;
> +
> +                       while (search_bitmap(ctl, info, &offset, &bytes,
> +                                            false) =3D=3D 0) {
> +                               ret =3D btrfs_add_free_space(block_group,=
 offset,
> +                                                          bytes);
> +                               if (ret)
> +                                       break;
> +                               bitmap_clear_bits(ctl, info, offset, byte=
s);
> +                               offset =3D info->offset;
> +                               bytes =3D ctl->unit;
> +                       }
> +                       free_bitmap(ctl, info);
> +               }
> +               cond_resched();
> +       }
> +       return ret;
> +}
> +
>  int load_free_space_cache(struct btrfs_block_group *block_group)
>  {
>         struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>         struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> +       struct btrfs_free_space_ctl tmp_ctl =3D {};
>         struct inode *inode;
>         struct btrfs_path *path;
>         int ret =3D 0;
>         bool matched;
>         u64 used =3D block_group->used;
>
> +       /*
> +        * Because we could potentially discard our loaded free space, we=
 want
> +        * to load everything into a temporary structure first, and then =
if it's
> +        * valid copy it all into the actual free space ctl.
> +        */
> +       btrfs_init_free_space_ctl(block_group, &tmp_ctl);
> +
>         /*
>          * If this block group has been marked to be cleared for one reas=
on or
>          * another then we can't trust the on disk cache, so just return.
> @@ -897,19 +891,25 @@ int load_free_space_cache(struct btrfs_block_group =
*block_group)
>         }
>         spin_unlock(&block_group->lock);
>
> -       ret =3D __load_free_space_cache(fs_info->tree_root, inode, ctl,
> +       ret =3D __load_free_space_cache(fs_info->tree_root, inode, &tmp_c=
tl,
>                                       path, block_group->start);
>         btrfs_free_path(path);
>         if (ret <=3D 0)
>                 goto out;
>
> -       spin_lock(&ctl->tree_lock);
> -       matched =3D (ctl->free_space =3D=3D (block_group->length - used -
> -                                      block_group->bytes_super));
> -       spin_unlock(&ctl->tree_lock);
> +       matched =3D (tmp_ctl.free_space =3D=3D (block_group->length - use=
d -
> +                                         block_group->bytes_super));
>
> -       if (!matched) {
> -               __btrfs_remove_free_space_cache(ctl);
> +       if (matched) {
> +               ret =3D copy_free_space_cache(block_group, &tmp_ctl);
> +               /*
> +                * ret =3D=3D 1 means we successfully loaded the free spa=
ce cache,
> +                * so we need to re-set it here.
> +                */
> +               if (ret =3D=3D 0)
> +                       ret =3D 1;
> +       } else {
> +               __btrfs_remove_free_space_cache(&tmp_ctl);
>                 btrfs_warn(fs_info,
>                            "block group %llu has wrong amount of free spa=
ce",
>                            block_group->start);
> @@ -1914,29 +1914,6 @@ find_free_space(struct btrfs_free_space_ctl *ctl, =
u64 *offset, u64 *bytes,
>         return NULL;
>  }
>
> -static int count_bitmap_extents(struct btrfs_free_space_ctl *ctl,
> -                               struct btrfs_free_space *bitmap_info)
> -{
> -       struct btrfs_block_group *block_group =3D ctl->private;
> -       u64 bytes =3D bitmap_info->bytes;
> -       unsigned int rs, re;
> -       int count =3D 0;
> -
> -       if (!block_group || !bytes)
> -               return count;
> -
> -       bitmap_for_each_set_region(bitmap_info->bitmap, rs, re, 0,
> -                                  BITS_PER_BITMAP) {
> -               bytes -=3D (rs - re) * ctl->unit;
> -               count++;
> -
> -               if (!bytes)
> -                       break;
> -       }
> -
> -       return count;
> -}
> -
>  static void add_new_bitmap(struct btrfs_free_space_ctl *ctl,
>                            struct btrfs_free_space *info, u64 offset)
>  {
> @@ -2676,10 +2653,10 @@ void btrfs_dump_free_space(struct btrfs_block_gro=
up *block_group,
>                    "%d blocks of free space at or bigger than bytes is", =
count);
>  }
>
> -void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group)
> +void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
> +                              struct btrfs_free_space_ctl *ctl)
>  {
>         struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> -       struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
>
>         spin_lock_init(&ctl->tree_lock);
>         ctl->unit =3D fs_info->sectorsize;
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index e3d5e0ad8f8e..bf8d127d2407 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -109,7 +109,8 @@ int btrfs_write_out_ino_cache(struct btrfs_root *root=
,
>                               struct btrfs_path *path,
>                               struct inode *inode);
>
> -void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group);
> +void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
> +                              struct btrfs_free_space_ctl *ctl);
>  int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>                            struct btrfs_free_space_ctl *ctl,
>                            u64 bytenr, u64 size,
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index 999c14e5d0bd..8519f7746b2e 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -224,7 +224,7 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *f=
s_info,
>         INIT_LIST_HEAD(&cache->list);
>         INIT_LIST_HEAD(&cache->cluster_list);
>         INIT_LIST_HEAD(&cache->bg_list);
> -       btrfs_init_free_space_ctl(cache);
> +       btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
>         mutex_init(&cache->free_space_lock);
>
>         return cache;
> --
> 2.26.2
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
