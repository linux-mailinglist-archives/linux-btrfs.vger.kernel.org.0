Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3B913CA77
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgAORKj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:10:39 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:43202 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728904AbgAORKi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:10:38 -0500
Received: by mail-vk1-f195.google.com with SMTP id h13so4913632vkn.10
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=R8jd0s/JL9dVkhXScJr8vow1pLPa1X0Lj6m7jf5V5U4=;
        b=W1TASsUT6iQQlyUVXfq/4wpoKZBzipyoZzXsAx1NKxCpJu9rOXlJSsXvH3ccMquKb7
         YUlnBmP/z9ZYD1gm/m4yGN/TnU863cG5C+VlOLHfwmC0wosbC+dx32CVbIe1+pn0jAix
         ZLxGqd2Hwbji/aZruJqpTQcchnjKSmvF8BNsIjOU/Uk/K4+hvXy0s5nlICkmLHYdzLlB
         QeXVJaVYJYdBSMRxxTaLvyAtz0svtJbPCRfBIquOqHcr+e3O6uhFxYp/tdSqu3hmjqTl
         k7E22AIPF4E0LwSN+Ce26f873/AccniWEodr8hO2H8+FFA6n0H1hA668tGX0ZDnnDjZD
         LSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=R8jd0s/JL9dVkhXScJr8vow1pLPa1X0Lj6m7jf5V5U4=;
        b=bVSE7r28mAGIfObq++mQqlD5oeitU8Kzj6IYlfY8dls4r6V1nMrTYinaEQyB8GrSlK
         j89fSiWmv5eqkQ7KBa6Y1gxGVzMeaNZsQ9FYblwabGP3RuETY6HUmVJ9mAMADORMN89m
         lHRfqklzDFu1FeJM0qqPlbNGxWXzqC6xageNrYsgQNfm5AHZRE/1IS6msEAUlWzJ0fEY
         w61bBipXAR42k3x9WItc143E6/L+2CU9w/iu3FithF6+9HsTDjO5lWqmpzpSK79GNC8R
         92ql4im4cIvoK2v9i1DpT68OfoDZejU9jLAgkDQzaXZsX24VswEl0ppl5Ien4Umk4MdC
         yhMw==
X-Gm-Message-State: APjAAAUxs4fWNOWJIMGkxDp1KYZ2S6aOly3wEyZWSV92D6cGug1NPXrg
        c/uwlSfUsI3sjQuGLOavLykzTAx3FwYmv4bSvWQ=
X-Google-Smtp-Source: APXvYqxEFWiQuYgRKIUvy8ZY4/ffiiyrROr2r97mcLMRzhvnjQo0swhWu/4wbnnNFCYlsGZjjcQ+uJkI2tTM1SaOiLI=
X-Received: by 2002:a1f:f283:: with SMTP id q125mr14706248vkh.69.1579108236425;
 Wed, 15 Jan 2020 09:10:36 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-3-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-3-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:10:24 +0000
Message-ID: <CAL3q7H7fSLWdkB1MBedgVyLT9x9nVd+jKuH=4jkafNwG5ZYohQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] btrfs: introduce the inode->file_extent_tree
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 7, 2020 at 7:43 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> In order to keep track of where we have file extents on disk, and thus
> where it is safe to adjust the i_size to, we need to have a tree in
> place to keep track of the contiguous areas we have file extents for.
> Add helpers to use this tree, as it's not required for NO_HOLES file
> systems.  We will use this by setting DIRTY for areas we know we have
> file extent item's set, and clearing it when we remove file extent items
> for truncation.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Just one comment, it's not a blocker for me, and I doubt it will be
for someone else.

So this effectively changes the semantics of i_size update and it now
behaves differently depending on whether no-holes is enabled or not.
So on power failure cases, under the same conditions, we see different
i_size values - I don't think anyone relies on this or should, as the
fs should be allowed to change the implementation any time.

Thanks, looks good.


> ---
>  fs/btrfs/btrfs_inode.h    |  5 +++
>  fs/btrfs/ctree.h          |  5 +++
>  fs/btrfs/extent-io-tree.h |  1 +
>  fs/btrfs/extent_io.c      | 11 +++++
>  fs/btrfs/file-item.c      | 91 +++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/inode.c          |  6 +++
>  6 files changed, 119 insertions(+)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 4e12a477d32e..d9dcbac513ed 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -60,6 +60,11 @@ struct btrfs_inode {
>          */
>         struct extent_io_tree io_failure_tree;
>
> +       /* keeps track of where we have extent items mapped in order to m=
ake
> +        * sure our i_size adjustments are accurate.
> +        */
> +       struct extent_io_tree file_extent_tree;
> +
>         /* held while logging the inode in tree-log.c */
>         struct mutex log_mutex;
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index a01ff3e0ead4..7142124d03c5 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -2807,6 +2807,11 @@ void btrfs_extent_item_to_extent_map(struct btrfs_=
inode *inode,
>                                      struct btrfs_file_extent_item *fi,
>                                      const bool new_inline,
>                                      struct extent_map *em);
> +int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 s=
tart,
> +                                       u64 len);
> +int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 sta=
rt,
> +                                     u64 len);
> +void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_isi=
ze);
>
>  /* inode.c */
>  struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> index a3febe746c79..c8bcd2e3184c 100644
> --- a/fs/btrfs/extent-io-tree.h
> +++ b/fs/btrfs/extent-io-tree.h
> @@ -44,6 +44,7 @@ enum {
>         IO_TREE_TRANS_DIRTY_PAGES,
>         IO_TREE_ROOT_DIRTY_LOG_PAGES,
>         IO_TREE_SELFTEST,
> +       IO_TREE_INODE_FILE_EXTENT,
>  };
>
>  struct extent_io_tree {
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index e374411ed08c..410f5a64d3a6 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -265,6 +265,15 @@ void __cold extent_io_exit(void)
>         bioset_exit(&btrfs_bioset);
>  }
>
> +/*
> + * For the file_extent_tree, we want to hold the inode lock when we look=
up and
> + * update the disk_i_size, but lockdep will complain because our io_tree=
 we hold
> + * the tree lock and get the inode lock when setting delalloc.  These tw=
o things
> + * are unrelated, so make a class for the file_extent_tree so we don't g=
et the
> + * two locking patterns mixed up.
> + */
> +static struct lock_class_key file_extent_tree_class;
> +
>  void extent_io_tree_init(struct btrfs_fs_info *fs_info,
>                          struct extent_io_tree *tree, unsigned int owner,
>                          void *private_data)
> @@ -276,6 +285,8 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_inf=
o,
>         spin_lock_init(&tree->lock);
>         tree->private_data =3D private_data;
>         tree->owner =3D owner;
> +       if (owner =3D=3D IO_TREE_INODE_FILE_EXTENT)
> +               lockdep_set_class(&tree->lock, &file_extent_tree_class);
>  }
>
>  void extent_io_tree_release(struct extent_io_tree *tree)
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 1a599f50837b..b733d85510ed 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -23,6 +23,97 @@
>  #define MAX_CSUM_ITEMS(r, size) (min_t(u32, __MAX_CSUM_ITEMS(r, size), \
>                                        PAGE_SIZE))
>
> +/**
> + * @inode - the inode we want to update the disk_i_size for
> + * @new_isize - the isize we want to set to, 0 if we use i_size
> + *
> + * With NO_HOLES set this simply sets the disk_is_size to whatever i_siz=
e_read()
> + * returns as it is perfectly fine with a file that has holes without ho=
le file
> + * extent items.
> + *
> + * However for !NO_HOLES we need to only return the area that is contigu=
ous from
> + * the 0 offset of the file.  Otherwise we could end up adjust i_size up=
 to an
> + * extent that has a gap in between.
> + *
> + * Finally new_isize should only be set in the case of truncate where we=
're not
> + * ready to use i_size_read() as the limiter yet.
> + */
> +void btrfs_inode_safe_disk_i_size_write(struct inode *inode, u64 new_isi=
ze)
> +{
> +       struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
> +       u64 start, end, isize;
> +       int ret;
> +
> +       isize =3D new_isize ? new_isize : i_size_read(inode);
> +       if (btrfs_fs_incompat(fs_info, NO_HOLES)) {
> +               BTRFS_I(inode)->disk_i_size =3D isize;
> +               return;
> +       }
> +
> +       spin_lock(&BTRFS_I(inode)->lock);
> +       ret =3D find_first_extent_bit(&BTRFS_I(inode)->file_extent_tree, =
0,
> +                                   &start, &end, EXTENT_DIRTY, NULL);
> +       if (!ret && start =3D=3D 0)
> +               isize =3D min(isize, end + 1);
> +       else
> +               isize =3D 0;
> +       BTRFS_I(inode)->disk_i_size =3D isize;
> +       spin_unlock(&BTRFS_I(inode)->lock);
> +}
> +
> +/**
> + * @inode - the inode we're modifying
> + * @start - the start file offset of the file extent we've inserted
> + * @len - the logical length of the file extent item
> + *
> + * Call when we are insering a new file extent where there was none befo=
re.
> + * Does not need to call this in the case where we're replacing an exist=
ing file
> + * extent, however if you're unsure it's fine to call this multiple time=
s.
> + *
> + * The start and len must match the file extent item, so thus must be se=
ctorsize
> + * aligned.
> + */
> +int btrfs_inode_set_file_extent_range(struct btrfs_inode *inode, u64 sta=
rt,
> +                                     u64 len)
> +{
> +       if (len =3D=3D 0)
> +               return 0;
> +
> +       ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize))=
;
> +
> +       if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> +               return 0;
> +       return set_extent_bits(&inode->file_extent_tree, start, start + l=
en - 1,
> +                              EXTENT_DIRTY);
> +}
> +
> +/**
> + * @inode - the inode we're modifying
> + * @start - the start file offset of the file extent we've inserted
> + * @len - the logical length of the file extent item
> + *
> + * Called when we drop a file extent, for example when we truncate.  Doe=
sn't
> + * need to be called for cases where we're replacing a file extent, like=
 when
> + * we've cow'ed a file extent.
> + *
> + * The start and len must match the file extent item, so thus must be se=
ctorsize
> + * aligned.
> + */
> +int btrfs_inode_clear_file_extent_range(struct btrfs_inode *inode, u64 s=
tart,
> +                                       u64 len)
> +{
> +       if (len =3D=3D 0)
> +               return 0;
> +
> +       ASSERT(IS_ALIGNED(start + len, inode->root->fs_info->sectorsize) =
||
> +              len =3D=3D (u64)-1);
> +
> +       if (btrfs_fs_incompat(inode->root->fs_info, NO_HOLES))
> +               return 0;
> +       return clear_extent_bit(&inode->file_extent_tree, start,
> +                               start + len - 1, EXTENT_DIRTY, 0, 0, NULL=
);
> +}
> +
>  static inline u32 max_ordered_sum_bytes(struct btrfs_fs_info *fs_info,
>                                         u16 csum_size)
>  {
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index db67e1984c91..ab8b972863b1 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3784,6 +3784,9 @@ static int btrfs_read_locked_inode(struct inode *in=
ode,
>         i_uid_write(inode, btrfs_inode_uid(leaf, inode_item));
>         i_gid_write(inode, btrfs_inode_gid(leaf, inode_item));
>         btrfs_i_size_write(BTRFS_I(inode), btrfs_inode_size(leaf, inode_i=
tem));
> +       btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
> +                                         round_up(i_size_read(inode),
> +                                                  fs_info->sectorsize));
>
>         inode->i_atime.tv_sec =3D btrfs_timespec_sec(leaf, &inode_item->a=
time);
>         inode->i_atime.tv_nsec =3D btrfs_timespec_nsec(leaf, &inode_item-=
>atime);
> @@ -9363,6 +9366,8 @@ struct inode *btrfs_alloc_inode(struct super_block =
*sb)
>         extent_io_tree_init(fs_info, &ei->io_tree, IO_TREE_INODE_IO, inod=
e);
>         extent_io_tree_init(fs_info, &ei->io_failure_tree,
>                             IO_TREE_INODE_IO_FAILURE, inode);
> +       extent_io_tree_init(fs_info, &ei->file_extent_tree,
> +                           IO_TREE_INODE_FILE_EXTENT, inode);
>         ei->io_tree.track_uptodate =3D true;
>         ei->io_failure_tree.track_uptodate =3D true;
>         atomic_set(&ei->sync_writers, 0);
> @@ -9429,6 +9434,7 @@ void btrfs_destroy_inode(struct inode *inode)
>         btrfs_qgroup_check_reserved_leak(inode);
>         inode_tree_del(inode);
>         btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
> +       btrfs_inode_clear_file_extent_range(BTRFS_I(inode), 0, (u64)-1);
>         btrfs_put_root(BTRFS_I(inode)->root);
>  }
>
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
