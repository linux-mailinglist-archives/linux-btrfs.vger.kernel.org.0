Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1613CA89
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jan 2020 18:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgAORM5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jan 2020 12:12:57 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40743 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbgAORM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jan 2020 12:12:57 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so6537944uam.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jan 2020 09:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Zb0pPA3F6TF5zTBK6Hy5bNDLzaI7nbWjfwxzRfFs6aA=;
        b=f8vyeSLN6axNwlwmKEH8ik6wT61csg2UXKHO1MMM1+kf+mk7GHi3AUxAi+3cPnYaVL
         yY41YnuW3MAfqPp3itIiNUEgLf+C46opnzvMhwUtYOWF53Tv+VO6Jb6qWMODreeOYR0r
         O0Hagjo2QbkYKu8gAZNgmOSzBj72ou0h3xdOyTvKgLhP2BYxQO0F4zByyQd5hfY2X3Yt
         hhdFQaxPk42LPKHmhYMDPcuYVBUehA4IpI1mpQjuT5FM+dhLrIrih/bgkvo0JEM3gvxz
         J0yNLwxpBNT8CeQsrb3oEYW8jebjEo0jG9OcsRXqiLnN/88AowZ4vPM0GBF+w2ErTr8H
         PYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Zb0pPA3F6TF5zTBK6Hy5bNDLzaI7nbWjfwxzRfFs6aA=;
        b=gNcvZsOg/QJKEEXUsZhCLKLUkRBmI5WlON53QobwQ29RttHfXaeykAallqoPwvaOVq
         6D0DafvlHf9dwkqTTorjXMmwWdxk1wpPInFrqrbiKOmR2DmVDFnP1G08Vfn+2y3lm3Fw
         uF7ql/D7aT9u5e/LLaanGiOCRhRMz7S650usgw2IB8emiy8bW44QiQO4KUTkCCF9Ddjn
         +kdUrlGUsse9wjL9HVyuwTJvGxd0fmmBfsSSZRGqrJ9OMmNsXbaXwce/YVgeZ50Z5wyE
         uLRWNiMlxdLjST9SOmm3Zu34hzD9zcryn/BWM0TV0tGo4AbSXZVFyRJ6l8rAEM1tf9Kt
         mndw==
X-Gm-Message-State: APjAAAWmysnoFE+YE3WjVOEwfr7G0DQPC+oCpde0r5NWW6028O311uDg
        rwhw0IC9UOzy7AK6QcAgN42CgLBb8icOB5V/pHBq/zcv
X-Google-Smtp-Source: APXvYqyo03OUvgtDKceKswE09p+Eqs2klQV5rB2WHkJ/mKt8WXhZv+7qve62Tb3ByUhisu955IZXIvIQra/TkijPzSI=
X-Received: by 2002:a9f:3e84:: with SMTP id x4mr14447812uai.83.1579108375737;
 Wed, 15 Jan 2020 09:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-4-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-4-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 15 Jan 2020 17:12:44 +0000
Message-ID: <CAL3q7H6eDnVxVj7qE0Naw_VNzhQR=vvNGM+57kHrmx7vZSfsYQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] btrfs: use the file extent tree infrastructure
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
> We want to use this everywhere we modify the file extent items
> permanently.  These include
>
> 1) Inserting new file extents for writes and prealloc extents.
> 2) Truncating inode items.
> 3) btrfs_cont_expand().
> 4) Insert inline extents.
> 5) Insert new extents from log replay.
> 6) Insert a new extent for clone, as it could be past isize.
>
> We do not however call the clear helper for hole punching because it
> simply swaps out an existing file extent for a hole, so there's
> effectively no change as far as the i_size is concerned.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/delayed-inode.c |  4 +++
>  fs/btrfs/file.c          |  6 ++++
>  fs/btrfs/inode.c         | 59 +++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/tree-log.c      |  5 ++++
>  4 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index d3e15e1d4a91..8b4dcf4f6b3e 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -1762,6 +1762,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev=
)
>  {
>         struct btrfs_delayed_node *delayed_node;
>         struct btrfs_inode_item *inode_item;
> +       struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_info;
>
>         delayed_node =3D btrfs_get_delayed_node(BTRFS_I(inode));
>         if (!delayed_node)
> @@ -1779,6 +1780,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev=
)
>         i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
>         i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
>         btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(inode_i=
tem));
> +       btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
> +                                         round_up(i_size_read(inode),
> +                                                  fs_info->sectorsize));

Why set it here when we have already done it at btrfs_read_locked_inode()?
This seems duplicated.

Thanks.

>         inode->i_mode =3D btrfs_stack_inode_mode(inode_item);
>         set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
>         inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 4fadb892af24..f1c880c06ca2 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2486,6 +2486,12 @@ static int btrfs_insert_clone_extent(struct btrfs_=
trans_handle *trans,
>         btrfs_mark_buffer_dirty(leaf);
>         btrfs_release_path(path);
>
> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode),
> +                                               clone_info->file_offset,
> +                                               clone_len);
> +       if (ret)
> +               return ret;
> +
>         /* If it's a hole, nothing more needs to be done. */
>         if (clone_info->disk_offset =3D=3D 0)
>                 return 0;
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index ab8b972863b1..5d34007aa7ec 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -243,6 +243,15 @@ static int insert_inline_extent(struct btrfs_trans_h=
andle *trans,
>         btrfs_mark_buffer_dirty(leaf);
>         btrfs_release_path(path);
>
> +       /*
> +        * We align size to sectorsize for inline extents just for simpli=
city
> +        * sake.
> +        */
> +       size =3D ALIGN(size, root->fs_info->sectorsize);
> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), start, =
size);
> +       if (ret)
> +               goto fail;
> +
>         /*
>          * we're an inline extent, so nobody can
>          * extend the file past i_size without locking
> @@ -2377,6 +2386,11 @@ static int insert_reserved_file_extent(struct btrf=
s_trans_handle *trans,
>         ins.offset =3D disk_num_bytes;
>         ins.type =3D BTRFS_EXTENT_ITEM_KEY;
>
> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), file_po=
s,
> +                                               ram_bytes);
> +       if (ret)
> +               goto out;
> +
>         /*
>          * Release the reserved range from inode dirty range map, as it i=
s
>          * already moved into delayed_ref_head
> @@ -4753,6 +4767,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>         }
>
>         while (1) {
> +               u64 clear_start =3D 0, clear_len =3D 0;
> +
>                 fi =3D NULL;
>                 leaf =3D path->nodes[0];
>                 btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> @@ -4803,6 +4819,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>
>                 if (extent_type !=3D BTRFS_FILE_EXTENT_INLINE) {
>                         u64 num_dec;
> +
> +                       clear_start =3D found_key.offset;
>                         extent_start =3D btrfs_file_extent_disk_bytenr(le=
af, fi);
>                         if (!del_item) {
>                                 u64 orig_num_bytes =3D
> @@ -4810,6 +4828,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                                 extent_num_bytes =3D ALIGN(new_size -
>                                                 found_key.offset,
>                                                 fs_info->sectorsize);
> +                               clear_start =3D ALIGN(new_size,
> +                                                   fs_info->sectorsize);
>                                 btrfs_set_file_extent_num_bytes(leaf, fi,
>                                                          extent_num_bytes=
);
>                                 num_dec =3D (orig_num_bytes -
> @@ -4835,6 +4855,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                                                 inode_sub_bytes(inode, nu=
m_dec);
>                                 }
>                         }
> +                       clear_len =3D num_dec;
>                 } else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>                         /*
>                          * we can't truncate inline items that have had
> @@ -4856,12 +4877,34 @@ int btrfs_truncate_inode_items(struct btrfs_trans=
_handle *trans,
>                                  */
>                                 ret =3D NEED_TRUNCATE_BLOCK;
>                                 break;
> +                       } else {
> +                               /*
> +                                * Inline extents are special, we just tr=
eat
> +                                * them as a full sector worth in the fil=
e
> +                                * extent tree just for simplicity sake.
> +                                */
> +                               clear_len =3D fs_info->sectorsize;
>                         }
>
>                         if (test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>                                 inode_sub_bytes(inode, item_end + 1 - new=
_size);
>                 }
>  delete:
> +               /*
> +                * We use btrfs_truncate_inode_items() to clean up log tr=
ees for
> +                * multiple fsyncs, and in this case we don't want to cle=
ar the
> +                * file extent range because it's just the log.
> +                */
> +               if (root =3D=3D BTRFS_I(inode)->root) {
> +                       ret =3D btrfs_inode_clear_file_extent_range(BTRFS=
_I(inode),
> +                                                                 clear_s=
tart,
> +                                                                 clear_l=
en);
> +                       if (ret) {
> +                               btrfs_abort_transaction(trans, ret);
> +                               break;
> +                       }
> +               }
> +
>                 if (del_item)
>                         last_size =3D found_key.offset;
>                 else
> @@ -5183,14 +5226,22 @@ int btrfs_cont_expand(struct inode *inode, loff_t=
 oldsize, loff_t size)
>                 }
>                 last_byte =3D min(extent_map_end(em), block_end);
>                 last_byte =3D ALIGN(last_byte, fs_info->sectorsize);
> +               hole_size =3D last_byte - cur_offset;
> +
>                 if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
>                         struct extent_map *hole_em;
> -                       hole_size =3D last_byte - cur_offset;
>
>                         err =3D maybe_insert_hole(root, inode, cur_offset=
,
>                                                 hole_size);
>                         if (err)
>                                 break;
> +
> +                       err =3D btrfs_inode_set_file_extent_range(BTRFS_I=
(inode),
> +                                                               cur_offse=
t,
> +                                                               hole_size=
);
> +                       if (err)
> +                               break;
> +
>                         btrfs_drop_extent_cache(BTRFS_I(inode), cur_offse=
t,
>                                                 cur_offset + hole_size - =
1, 0);
>                         hole_em =3D alloc_extent_map();
> @@ -5223,6 +5274,12 @@ int btrfs_cont_expand(struct inode *inode, loff_t =
oldsize, loff_t size)
>                                                         hole_size - 1, 0)=
;
>                         }
>                         free_extent_map(hole_em);
> +               } else {
> +                       err =3D btrfs_inode_set_file_extent_range(BTRFS_I=
(inode),
> +                                                               cur_offse=
t,
> +                                                               hole_size=
);
> +                       if (err)
> +                               break;
>                 }
>  next:
>                 free_extent_map(em);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 19364940f9a1..ad25974ff936 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -829,6 +829,11 @@ static noinline int replay_one_extent(struct btrfs_t=
rans_handle *trans,
>                         goto out;
>         }
>
> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), start,
> +                                               extent_end - start);
> +       if (ret)
> +               goto out;
> +
>         inode_add_bytes(inode, nbytes);
>  update_inode:
>         ret =3D btrfs_update_inode(trans, root, inode);
> --
> 2.23.0
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
