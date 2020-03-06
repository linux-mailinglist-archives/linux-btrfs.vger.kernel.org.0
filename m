Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FC17BC24
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 12:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgCFLv1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 06:51:27 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:40161 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFLv1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 06:51:27 -0500
Received: by mail-ua1-f67.google.com with SMTP id t20so572251uao.7
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2020 03:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=dq57bQCJ93vspQWYyue38vSSB1WUNrWsq9m+UlXBUZM=;
        b=fT62nM70hKUXPF0CqRI189Yao2ghHTLF1TjYqKfqDfpObafD8fjniB9TsJud6RBC1c
         +rcR5qMTLlwPZGlao53C0B3UhwIaghJuUEvIPLeLJBmr3qD8U5rX+WAtRm/v9DMTSnhw
         nyBtxhU3aDgCb713r7aDzKSDiDZBVJ8M2dcgwY2Bglpcsx0E/NelJn/P+m9DWQxrRVNW
         BZos22TYjCtpcmm862kMjtbwqTOYmPfUIdNP6Bk/Mhg8fmvdkyPHNyDx6ZwoVNyifa+Y
         X2R7wcgJPpFP4YqeXU5DXXC3FhFjC1OmmadTKXhs+L7KRW0oNqjacE8TVJuwqDCVhx+D
         8zNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=dq57bQCJ93vspQWYyue38vSSB1WUNrWsq9m+UlXBUZM=;
        b=Vj13PyEZ2GRxN5ObAapm1Qzt5IA98xQ9RwFUeD8q6PVc3S4sOmOqYm+H3a2R4nSmBF
         Jnb5HuQqIOkUYda1NNd1gb9HhelZGEvzKlnAdQ+AKSPq4WCf24ytYvzR9IKDKZb1jntA
         VTtMOUpE1tvZLZ5SBzlIssEbaM5X/1JXoojHsS8j12pxQ7p+VATqrPbImARXnFUQIPiY
         Y19b1Jn8O9by9yrI8BMjot2hX926D+jhUUEtvdNGNKdetkVrS20cgvcpp3dxVEywhcLk
         eJqZHdwjDwqUulr8G4KyerOrCZo7inQQTpZaJn9BJ3vpAUa+Kn13Ty9KdvCw9l9i1OP0
         F5yg==
X-Gm-Message-State: ANhLgQ385douM3u9wFYyrEDT1Wuf2g2tKPskfMLVlVdz9fOK1eD4utCZ
        4k7KqiJl7E58elILHpWrKZNP8Y0IWR3ZgkpjsFE=
X-Google-Smtp-Source: ADFU+vumEbVkb8JKTPqbhA8pVRYp3GbUblniVDBEcDgqnBYziYYGEAKobO3bE3gv/fvcXHs/+TuVux2c2NRQ1TYjTEg=
X-Received: by 2002:ab0:2789:: with SMTP id t9mr1394348uap.83.1583495483801;
 Fri, 06 Mar 2020 03:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20200117140224.42495-1-josef@toxicpanda.com> <20200117140224.42495-5-josef@toxicpanda.com>
In-Reply-To: <20200117140224.42495-5-josef@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Mar 2020 11:51:12 +0000
Message-ID: <CAL3q7H69_tEsV2WGu9Y6ZgB_1gy9WKPB5iR9XiWaUGiU6C871A@mail.gmail.com>
Subject: Re: [PATCH 4/6] btrfs: use the file extent tree infrastructure
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 17, 2020 at 2:03 PM Josef Bacik <josef@toxicpanda.com> wrote:
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
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
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
> index c6f9029e3d49..f72fb38e9aaa 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -2482,6 +2482,12 @@ static int btrfs_insert_clone_extent(struct btrfs_=
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
> index fd8f821a3919..21fb80292256 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -241,6 +241,15 @@ static int insert_inline_extent(struct btrfs_trans_h=
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
> @@ -2375,6 +2384,11 @@ static int insert_reserved_file_extent(struct btrf=
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
> @@ -4084,6 +4098,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>         }
>
>         while (1) {
> +               u64 clear_start =3D 0, clear_len =3D 0;
> +
>                 fi =3D NULL;
>                 leaf =3D path->nodes[0];
>                 btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> @@ -4134,6 +4150,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
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
> @@ -4141,6 +4159,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
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
> @@ -4166,6 +4186,7 @@ int btrfs_truncate_inode_items(struct btrfs_trans_h=
andle *trans,
>                                                 inode_sub_bytes(inode, nu=
m_dec);
>                                 }
>                         }
> +                       clear_len =3D num_dec;
>                 } else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLINE) {
>                         /*
>                          * we can't truncate inline items that have had
> @@ -4187,12 +4208,34 @@ int btrfs_truncate_inode_items(struct btrfs_trans=
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
> @@ -4513,14 +4556,22 @@ int btrfs_cont_expand(struct inode *inode, loff_t=
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
> @@ -4552,6 +4603,12 @@ int btrfs_cont_expand(struct inode *inode, loff_t =
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
> index 80978ebfdcbb..56278a5b69e4 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -830,6 +830,11 @@ static noinline int replay_one_extent(struct btrfs_t=
rans_handle *trans,
>                         goto out;
>         }
>
> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), start,
> +                                               extent_end - start);
> +       if (ret)
> +               goto out;

So while working on making ranged fsyncs for the slow patch (inode has
the 'need full sync' flag set), I uncovered more cases where we end up
with missing file extent items.

When doing a fast fsync, we log only the extents in the given range,
but we log an inode item with the current i_size of the inode.
So after a log replay we can get missing file extent items.

For example this test case I made earlier today (also at
https://pastebin.com/ezFFGEf8 for better readability):

#! /bin/bash
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2020 SUSE Linux Products GmbH. All Rights Reserved.
#
# FSQA Test No. XXX
#
# TODO description
#
seq=3D`basename $0`
seqres=3D$RESULT_DIR/$seq
echo "QA output created by $seq"
tmp=3D/tmp/$$
status=3D1 # failure is the default!
trap "_cleanup; exit \$status" 0 1 2 3 15

_cleanup()
{
_cleanup_flakey
cd /
rm -f $tmp.*
}

# get standard environment, filters and checks
. ./common/rc
. ./common/attr
. ./common/filter
. ./common/dmflakey

# real QA test starts here
_supported_fs btrfs
_supported_os Linux
_require_scratch
_require_dm_target flakey
_require_btrfs_fs_feature "no_holes"
_require_btrfs_mkfs_feature "no-holes"
_require_xfs_io_command "sync_range"

rm -f $seqres.full

_scratch_mkfs -O ^no-holes >>$seqres.full 2>&1
_require_metadata_journaling $SCRATCH_DEV
_init_flakey
_mount_flakey

touch $SCRATCH_MNT/foo
# Clear the full sync bit, so that the msync below triggers the fast fsync =
path.
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo

# get rid of the log tree
sync

# Dirty some pages and flush only some of them at the beginning without upd=
ating
# the log tree.
$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" \
     -c "sync_range -abw 0 256K" \
     $SCRATCH_MNT/foo >>$seqres.full

$XFS_IO_PROG \
        -c "mmap -w 512K 512K"        \
        -c "mwrite -S 0xcd 512K 512K" \
        -c "msync -s 512K 512K"       \
        -c "munmap"                   \
        $SCRATCH_MNT/foo >>$seqres.full

_flakey_drop_and_remount
_unmount_flakey

# On exit fsck is run and reports missing file extent for range from 0 to 5=
12Kb.

status=3D0
exit

We end up an unmarked hole at 0-512K.
After thinking a bit, I don't see an easy/simple way to fix this.
The only reliable way I can think of so sar is:  after replaying the
extents of an inode, inserting file extent items to represent holes
(only when not using NO_HOLES of course). That would imply scanning
all extents items in the fs/subvolume tree to check for gaps.

Any better idea?

Thanks.




> +
>         inode_add_bytes(inode, nbytes);
>  update_inode:
>         ret =3D btrfs_update_inode(trans, root, inode);
> --
> 2.24.1
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
