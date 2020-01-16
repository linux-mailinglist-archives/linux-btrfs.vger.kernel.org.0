Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5C13DA57
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jan 2020 13:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAPMq1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jan 2020 07:46:27 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37429 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgAPMq1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jan 2020 07:46:27 -0500
Received: by mail-vs1-f67.google.com with SMTP id x18so12584064vsq.4
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jan 2020 04:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=XL1z4Ph++fQWzUQaM+gJMsDkaCjiq/XaYSWjpncRalU=;
        b=PF+ABHoqJIjv6pBmVJUvHVCphfQiwE4zd56oPwM2Ty2o9eoOjPuHbCdSI7cuVx0iI4
         YapphV/aSy4GNVa/JZlbRvozciqaZZQ4+9Rki6VrYtRcBtnLBDWeSzjbtwLD6ecSEWXN
         pfoEE9ayPu7Z0J00EwqOC9wWTRsVl4eykiFm56DbUt5GylUl+Gj7USJ2OmYfW+gm2zpy
         O+ZXmP/PRft/kQnmf2vrPg4GMhW2K7PyO3lPmzbUYh4U/U4wSv453ZCjP0FQDT+ivR6B
         PtNz6bIxWGGW1gWXcJyjhXyfXGFi2m2H4l7ixTw6m41hXoH4Hng/oc6js25DhnknQLvm
         T3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=XL1z4Ph++fQWzUQaM+gJMsDkaCjiq/XaYSWjpncRalU=;
        b=SSaVQfJFy+fRUxHqZzLYGC5rOvDAxslSdy7tQLH+1F0SBmAy3XBFXAgRVvFm7dH13k
         VzoTnqCnUGSHSV7kYbzJlt0FzVVs9uOGSjCb2ejvUo4UJ209o3Ft5c4tr5Hok6k7M4mR
         k/JTO3X4tRoiB2VjdgA9fz01MLlahfsFngFb+OhZZN8H/Ilnu29BIdNvLwDCszJs0MIF
         FqiJNt9GwGUjU0pzZuxAcWrKLF5npyv0LqYbH0EuZKKILVZxiUQIHReXE+YRExmsQkSh
         AQU3wyxqUv4ogSDWo71VwarfLR5445PE9aBPmi/r4KaE0Bok4Rcz5w68qoq9uJH6AjUl
         PiDQ==
X-Gm-Message-State: APjAAAVKQBw73cew23LAOB4Qv1SkYzYeRKP+9AjG8e6Ja043XkQrvVkX
        pwhGEzlEEJow5et+XOycOubdAMayR1BW6kEEIYI=
X-Google-Smtp-Source: APXvYqzptPMNSM4Oe5DjVujl+jZZ6Te2CxXVGb3Ls5+Iy16DpWCsLRHM0Dq9Nd1O3KEK6+MrKQW+RoEkVilCEb4CDGg=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr1239734vsq.206.1579178785313;
 Thu, 16 Jan 2020 04:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20200107194237.145694-1-josef@toxicpanda.com> <20200107194237.145694-4-josef@toxicpanda.com>
In-Reply-To: <20200107194237.145694-4-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 16 Jan 2020 12:46:14 +0000
Message-ID: <CAL3q7H46D2A5nkyVaDApsPW0FV1nw0QZzyGBio7K853U64DskQ@mail.gmail.com>
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

Trying this out today:

[ 3567.156540] BUG: sleeping function called from invalid context at
mm/slab.h:565
[ 3567.156595] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
2344, name: fsstress
[ 3567.156636] 4 locks held by fsstress/2344:
[ 3567.156638]  #0: ffff9b5f82a7c410 (sb_writers#12){.+.+}, at:
mnt_want_write+0x20/0x50
[ 3567.156646]  #1: ffff9b5f6a4df698
(&sb->s_type->i_mutex_key#14){+.+.}, at: do_truncate+0x66/0xc0
[ 3567.156651]  #2: ffff9b5f82a7c610 (sb_internal#2){.+.+}, at:
start_transaction+0x3c7/0x5c0 [btrfs]
[ 3567.156673]  #3: ffff9b5f7a746ae8 (btrfs-fs-00){++++}, at:
btrfs_try_tree_write_lock+0x2f/0x1c0 [btrfs]
[ 3567.156692] Preemption disabled at:
[ 3567.156693] [<0000000000000000>] 0x0
[ 3567.156709] CPU: 1 PID: 2344 Comm: fsstress Tainted: G        W
    5.5.0-rc6-btrfs-next-52 #1
[ 3567.156710] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.12.0-0-ga698c8995f-prebuilt.qemu.org 04/01/2014
[ 3567.156711] Call Trace:
[ 3567.156715]  dump_stack+0x87/0xcb
[ 3567.156718]  ___might_sleep+0x287/0x2f0
[ 3567.156735]  ? alloc_extent_state+0x23/0x1f0 [btrfs]
[ 3567.156737]  slab_pre_alloc_hook+0x64/0x80
[ 3567.156739]  kmem_cache_alloc+0x33/0x300
[ 3567.156755]  alloc_extent_state+0x23/0x1f0 [btrfs]
[ 3567.156770]  __clear_extent_bit+0x2d6/0x6b0 [btrfs]
[ 3567.156788]  clear_extent_bit+0x15/0x20 [btrfs]
[ 3567.156799]  btrfs_inode_clear_file_extent_range+0x61/0x80 [btrfs]
[ 3567.156812]  btrfs_truncate_inode_items+0x944/0x10a0 [btrfs]
[ 3567.156822]  ? do_raw_spin_unlock+0x49/0xc0
[ 3567.156836]  btrfs_setattr+0x30b/0x5b0 [btrfs]
[ 3567.156840]  notify_change+0x306/0x460
[ 3567.156843]  do_truncate+0x75/0xc0
[ 3567.156846]  ? generic_permission+0x1d/0x1e0
[ 3567.156850]  vfs_truncate+0x1b0/0x250
[ 3567.156853]  do_sys_truncate+0x79/0xc0
[ 3567.156855]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[ 3567.156857]  do_syscall_64+0x5c/0x280
[ 3567.156860]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[ 3567.156861] RIP: 0033:0x7fe6436a1c57

We are holding the path with spin locks... We must set it to blocking
locks before clearing the io tree.

Thanks.


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
