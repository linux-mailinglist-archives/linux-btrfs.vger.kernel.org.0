Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C22FF17C11C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Mar 2020 16:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgCFPCN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Mar 2020 10:02:13 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35886 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCFPCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Mar 2020 10:02:12 -0500
Received: by mail-vs1-f66.google.com with SMTP id n6so1709180vsc.3
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Mar 2020 07:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=QXugJFwJcp9KIyBPvvTwjVve8FQQKx7ElzQR9JdJ50s=;
        b=M1gUelYbCscxqSkJ3BleOqVzsr7R5yaSUGG6zusBNrLDY61wuJezudl+wctNMfTMOt
         JwsibnoTZLDiXX9PS7orR3sed39KQG+wquuaXQlMDCsZZlHxOEP8Ii5/OYCzYoZyp34n
         4N3sKpCR0M+O4ZLz4xae2yMLV1y13oezvygUnkNKNhUcvvdbt+QoDNxvWzTVeO8bC2s2
         X6KJwjEr6IIrVrckPbyWybG3r4YKKW6Y3on+jbfTc0XyBQbBq0b291lIRIorBKF31YF3
         hcdKe9cqnKtaUnlvgm3z3i3r69r/3Vf8U3Kd6vESG/T2xOlMZ9mjtHA7r0FI6vvT+mV1
         ka2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=QXugJFwJcp9KIyBPvvTwjVve8FQQKx7ElzQR9JdJ50s=;
        b=iILXUlzrOmTXJvhDYzj8VcaIJ6LzX7/0MQQr7NkvFWUcwLHaVGpuI+q0BMECBl6tGR
         BUa/IdGKxxNbrYAh1B76mtuZujAmlhu2UAEjah/CdbJkSh3QkX2wWUL/8z3cKyKN8k4A
         nCZgZh8kpA54S19CUBXLaUwYN90FDS19i2SV1tBPYfyu6J0QTkBC5rzKeS7jTSBN3RY4
         koxQ4fESBtwwo7uayrQYzGKWVeolLCwg2unaMIEm87U3VncH9+bYfa7bpEsFUJ06ZdDY
         iwumejCpydpTwmeI4HQ4mUE4XKSnYRBOA1AzZcVx3JMldsdWk5jCfQ1NV2knL/rUNyB3
         hCqw==
X-Gm-Message-State: ANhLgQ06jfL6pj+PpGjMdcoRMB6ondkGERqZDTRe4AzpxyBtL6u3NGR8
        voxAcB4tsyYSBCtUteV9IcvevAW0R9jD4HY08Hk=
X-Google-Smtp-Source: ADFU+vsyglf1dHctco38eBjEFaDFhrNSVlBxjD6cSVt2yi05lWvOp7NZHvt0fdr/qegeZ0bhKdyAcubc8KVNuRiecKg=
X-Received: by 2002:a67:2e88:: with SMTP id u130mr2337410vsu.14.1583506930030;
 Fri, 06 Mar 2020 07:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20200117140224.42495-1-josef@toxicpanda.com> <20200117140224.42495-5-josef@toxicpanda.com>
 <CAL3q7H69_tEsV2WGu9Y6ZgB_1gy9WKPB5iR9XiWaUGiU6C871A@mail.gmail.com> <dfa3dbad-81f0-2c3a-00ae-a991a7254118@toxicpanda.com>
In-Reply-To: <dfa3dbad-81f0-2c3a-00ae-a991a7254118@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 6 Mar 2020 15:01:57 +0000
Message-ID: <CAL3q7H6qrna-J5D2q0EFewihpQRouhf_GCYzG2E-cMRXNGC17A@mail.gmail.com>
Subject: Re: [PATCH 4/6] btrfs: use the file extent tree infrastructure
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Mar 6, 2020 at 2:52 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 3/6/20 6:51 AM, Filipe Manana wrote:
> > On Fri, Jan 17, 2020 at 2:03 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> We want to use this everywhere we modify the file extent items
> >> permanently.  These include
> >>
> >> 1) Inserting new file extents for writes and prealloc extents.
> >> 2) Truncating inode items.
> >> 3) btrfs_cont_expand().
> >> 4) Insert inline extents.
> >> 5) Insert new extents from log replay.
> >> 6) Insert a new extent for clone, as it could be past isize.
> >>
> >> We do not however call the clear helper for hole punching because it
> >> simply swaps out an existing file extent for a hole, so there's
> >> effectively no change as far as the i_size is concerned.
> >>
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >> ---
> >>   fs/btrfs/delayed-inode.c |  4 +++
> >>   fs/btrfs/file.c          |  6 ++++
> >>   fs/btrfs/inode.c         | 59 ++++++++++++++++++++++++++++++++++++++=
+-
> >>   fs/btrfs/tree-log.c      |  5 ++++
> >>   4 files changed, 73 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> >> index d3e15e1d4a91..8b4dcf4f6b3e 100644
> >> --- a/fs/btrfs/delayed-inode.c
> >> +++ b/fs/btrfs/delayed-inode.c
> >> @@ -1762,6 +1762,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *r=
dev)
> >>   {
> >>          struct btrfs_delayed_node *delayed_node;
> >>          struct btrfs_inode_item *inode_item;
> >> +       struct btrfs_fs_info *fs_info =3D BTRFS_I(inode)->root->fs_inf=
o;
> >>
> >>          delayed_node =3D btrfs_get_delayed_node(BTRFS_I(inode));
> >>          if (!delayed_node)
> >> @@ -1779,6 +1780,9 @@ int btrfs_fill_inode(struct inode *inode, u32 *r=
dev)
> >>          i_uid_write(inode, btrfs_stack_inode_uid(inode_item));
> >>          i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
> >>          btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(ino=
de_item));
> >> +       btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
> >> +                                         round_up(i_size_read(inode),
> >> +                                                  fs_info->sectorsize=
));
> >>          inode->i_mode =3D btrfs_stack_inode_mode(inode_item);
> >>          set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
> >>          inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
> >> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> >> index c6f9029e3d49..f72fb38e9aaa 100644
> >> --- a/fs/btrfs/file.c
> >> +++ b/fs/btrfs/file.c
> >> @@ -2482,6 +2482,12 @@ static int btrfs_insert_clone_extent(struct btr=
fs_trans_handle *trans,
> >>          btrfs_mark_buffer_dirty(leaf);
> >>          btrfs_release_path(path);
> >>
> >> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode),
> >> +                                               clone_info->file_offse=
t,
> >> +                                               clone_len);
> >> +       if (ret)
> >> +               return ret;
> >> +
> >>          /* If it's a hole, nothing more needs to be done. */
> >>          if (clone_info->disk_offset =3D=3D 0)
> >>                  return 0;
> >> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >> index fd8f821a3919..21fb80292256 100644
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -241,6 +241,15 @@ static int insert_inline_extent(struct btrfs_tran=
s_handle *trans,
> >>          btrfs_mark_buffer_dirty(leaf);
> >>          btrfs_release_path(path);
> >>
> >> +       /*
> >> +        * We align size to sectorsize for inline extents just for sim=
plicity
> >> +        * sake.
> >> +        */
> >> +       size =3D ALIGN(size, root->fs_info->sectorsize);
> >> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), star=
t, size);
> >> +       if (ret)
> >> +               goto fail;
> >> +
> >>          /*
> >>           * we're an inline extent, so nobody can
> >>           * extend the file past i_size without locking
> >> @@ -2375,6 +2384,11 @@ static int insert_reserved_file_extent(struct b=
trfs_trans_handle *trans,
> >>          ins.offset =3D disk_num_bytes;
> >>          ins.type =3D BTRFS_EXTENT_ITEM_KEY;
> >>
> >> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), file=
_pos,
> >> +                                               ram_bytes);
> >> +       if (ret)
> >> +               goto out;
> >> +
> >>          /*
> >>           * Release the reserved range from inode dirty range map, as =
it is
> >>           * already moved into delayed_ref_head
> >> @@ -4084,6 +4098,8 @@ int btrfs_truncate_inode_items(struct btrfs_tran=
s_handle *trans,
> >>          }
> >>
> >>          while (1) {
> >> +               u64 clear_start =3D 0, clear_len =3D 0;
> >> +
> >>                  fi =3D NULL;
> >>                  leaf =3D path->nodes[0];
> >>                  btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0=
]);
> >> @@ -4134,6 +4150,8 @@ int btrfs_truncate_inode_items(struct btrfs_tran=
s_handle *trans,
> >>
> >>                  if (extent_type !=3D BTRFS_FILE_EXTENT_INLINE) {
> >>                          u64 num_dec;
> >> +
> >> +                       clear_start =3D found_key.offset;
> >>                          extent_start =3D btrfs_file_extent_disk_byten=
r(leaf, fi);
> >>                          if (!del_item) {
> >>                                  u64 orig_num_bytes =3D
> >> @@ -4141,6 +4159,8 @@ int btrfs_truncate_inode_items(struct btrfs_tran=
s_handle *trans,
> >>                                  extent_num_bytes =3D ALIGN(new_size -
> >>                                                  found_key.offset,
> >>                                                  fs_info->sectorsize);
> >> +                               clear_start =3D ALIGN(new_size,
> >> +                                                   fs_info->sectorsiz=
e);
> >>                                  btrfs_set_file_extent_num_bytes(leaf,=
 fi,
> >>                                                           extent_num_b=
ytes);
> >>                                  num_dec =3D (orig_num_bytes -
> >> @@ -4166,6 +4186,7 @@ int btrfs_truncate_inode_items(struct btrfs_tran=
s_handle *trans,
> >>                                                  inode_sub_bytes(inode=
, num_dec);
> >>                                  }
> >>                          }
> >> +                       clear_len =3D num_dec;
> >>                  } else if (extent_type =3D=3D BTRFS_FILE_EXTENT_INLIN=
E) {
> >>                          /*
> >>                           * we can't truncate inline items that have h=
ad
> >> @@ -4187,12 +4208,34 @@ int btrfs_truncate_inode_items(struct btrfs_tr=
ans_handle *trans,
> >>                                   */
> >>                                  ret =3D NEED_TRUNCATE_BLOCK;
> >>                                  break;
> >> +                       } else {
> >> +                               /*
> >> +                                * Inline extents are special, we just=
 treat
> >> +                                * them as a full sector worth in the =
file
> >> +                                * extent tree just for simplicity sak=
e.
> >> +                                */
> >> +                               clear_len =3D fs_info->sectorsize;
> >>                          }
> >>
> >>                          if (test_bit(BTRFS_ROOT_REF_COWS, &root->stat=
e))
> >>                                  inode_sub_bytes(inode, item_end + 1 -=
 new_size);
> >>                  }
> >>   delete:
> >> +               /*
> >> +                * We use btrfs_truncate_inode_items() to clean up log=
 trees for
> >> +                * multiple fsyncs, and in this case we don't want to =
clear the
> >> +                * file extent range because it's just the log.
> >> +                */
> >> +               if (root =3D=3D BTRFS_I(inode)->root) {
> >> +                       ret =3D btrfs_inode_clear_file_extent_range(BT=
RFS_I(inode),
> >> +                                                                 clea=
r_start,
> >> +                                                                 clea=
r_len);
> >> +                       if (ret) {
> >> +                               btrfs_abort_transaction(trans, ret);
> >> +                               break;
> >> +                       }
> >> +               }
> >> +
> >>                  if (del_item)
> >>                          last_size =3D found_key.offset;
> >>                  else
> >> @@ -4513,14 +4556,22 @@ int btrfs_cont_expand(struct inode *inode, lof=
f_t oldsize, loff_t size)
> >>                  }
> >>                  last_byte =3D min(extent_map_end(em), block_end);
> >>                  last_byte =3D ALIGN(last_byte, fs_info->sectorsize);
> >> +               hole_size =3D last_byte - cur_offset;
> >> +
> >>                  if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
> >>                          struct extent_map *hole_em;
> >> -                       hole_size =3D last_byte - cur_offset;
> >>
> >>                          err =3D maybe_insert_hole(root, inode, cur_of=
fset,
> >>                                                  hole_size);
> >>                          if (err)
> >>                                  break;
> >> +
> >> +                       err =3D btrfs_inode_set_file_extent_range(BTRF=
S_I(inode),
> >> +                                                               cur_of=
fset,
> >> +                                                               hole_s=
ize);
> >> +                       if (err)
> >> +                               break;
> >> +
> >>                          btrfs_drop_extent_cache(BTRFS_I(inode), cur_o=
ffset,
> >>                                                  cur_offset + hole_siz=
e - 1, 0);
> >>                          hole_em =3D alloc_extent_map();
> >> @@ -4552,6 +4603,12 @@ int btrfs_cont_expand(struct inode *inode, loff=
_t oldsize, loff_t size)
> >>                                                          hole_size - 1=
, 0);
> >>                          }
> >>                          free_extent_map(hole_em);
> >> +               } else {
> >> +                       err =3D btrfs_inode_set_file_extent_range(BTRF=
S_I(inode),
> >> +                                                               cur_of=
fset,
> >> +                                                               hole_s=
ize);
> >> +                       if (err)
> >> +                               break;
> >>                  }
> >>   next:
> >>                  free_extent_map(em);
> >> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> >> index 80978ebfdcbb..56278a5b69e4 100644
> >> --- a/fs/btrfs/tree-log.c
> >> +++ b/fs/btrfs/tree-log.c
> >> @@ -830,6 +830,11 @@ static noinline int replay_one_extent(struct btrf=
s_trans_handle *trans,
> >>                          goto out;
> >>          }
> >>
> >> +       ret =3D btrfs_inode_set_file_extent_range(BTRFS_I(inode), star=
t,
> >> +                                               extent_end - start);
> >> +       if (ret)
> >> +               goto out;
> >
> > So while working on making ranged fsyncs for the slow patch (inode has
> > the 'need full sync' flag set), I uncovered more cases where we end up
> > with missing file extent items.
> >
> > When doing a fast fsync, we log only the extents in the given range,
> > but we log an inode item with the current i_size of the inode.
> > So after a log replay we can get missing file extent items.
> >
>
> For this case I think we need to not just log that current range, we need=
 to log
> anything that was changed leading up to that offset.  Range fsync is just=
 an
> optimization, in the !NO_HOLES case we need to make sure we're still leav=
ing the
> fs in a consistent state, so if we have any modified extents that lead up=
 to our
> range those need to be logged as well.  Thanks,

Sounds reasonable, I don't any efficient way in mind to do it either.
So for any type of fsync (full or fast) always reset the start offset
to 0 when not using NO_HOLES, and leave the end offset alone.
I'll introduce a patch in my patchset for that and send the test case.

Thanks.

>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
