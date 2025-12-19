Return-Path: <linux-btrfs+bounces-19891-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1096CCF61B
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 11:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1482C309799A
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Dec 2025 10:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99D3074AE;
	Fri, 19 Dec 2025 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtxGn1B0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFA5306B21
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766139907; cv=none; b=nyUXngIKqq7yXmYJINkb6bVaAa07IBO5wn8B/dJTyB+0jYBp5fAOO3HeI5FFivuqbBuq8GRB1MF/lnIHQ4o9rLdjpxV/WSoy1Ke/v3HEr46+2UXY1BrmnTKHzhUbLJMn0cwA5DOrqCVZB6Iw69z7tk2n4mGs5GrmyYt8UgdE1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766139907; c=relaxed/simple;
	bh=twtAZLwd2ZDThHZmkKv0pQDksttKsy9sPIj/Gw8qeu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cc20prN4bslX3uAf8DXN4CmhT28F1Dn4Mo9ODdgGKujKVjD0eaIk1v1CmZhtdsRqMGk+xg57mJJuamBrXXzWmPSggTk5Eo8C3g3b1mqG6vezf0y8bJhqwJelfOn6Nm9FyukiwTyEkazOCB1KIbeDqB/J3P2c3/T7IPETySkHnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtxGn1B0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AC8C4CEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766139907;
	bh=twtAZLwd2ZDThHZmkKv0pQDksttKsy9sPIj/Gw8qeu8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JtxGn1B0J73LuSYz8BE6FUF53bO1cOu5eiROADsVFsIKftZfTLsAX7YvoquTK5sbA
	 /rUjS2CpjLViJj2dP1eWOqRvSn5MQ9luTf1UyfY+l1324Es7U9IF3i4uEQImYVWAxl
	 gee3f6myg0bUm8LHRAbvxjsAU+jpBh31BRnEOnjC6QTLJ5oPBG1oD7nBJvU+gvUz9r
	 7caDWh5rn/8FX8/VouBV8P1T+q1CXhOFTXgJIeLzhql71up9KOUo6zH11uqdWfyKvo
	 gvRMNyYcHZKZ+9gCdPb2py8zYaZcHOPGEDRI6EJR+v8OBLWfLTlTLZQIS5VmNuCmxF
	 THkY/L4EjMWqQ==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b804646c718so1521866b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Dec 2025 02:25:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwSKV7VP5lI2IDbtromSKEwptylpV7G13ewx2y0SqG/zM2a4x+Z
	R2Ab1531Mhi/Z8cIJTw5uSx9sAhexhEIqRKZyuvDztK2/aaSpAq8CRMI3IlXxWM/EohYBqSklBu
	kYZypmMoTbvlmJ7e+oW9r7aTzjhMP/Qw=
X-Google-Smtp-Source: AGHT+IGbufOhLY8250D9lSEEgeg9ynsaJbDlYY9Hn9aFpa79EkijX74LINgPQaNwLbn5Ee/sK1Ude7y+9pRn9ZkVKIM=
X-Received: by 2002:a17:907:1c17:b0:b76:4c16:6afa with SMTP id
 a640c23a62f3a-b8036f637d8mr236194966b.28.1766139905546; Fri, 19 Dec 2025
 02:25:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5dae1d847245b578d71498adbd38bc1b588d3753.1766103074.git.wqu@suse.com>
In-Reply-To: <5dae1d847245b578d71498adbd38bc1b588d3753.1766103074.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 19 Dec 2025 10:24:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H48XH2GXFDMvs6BS6yW+S53qpja50kwZCbAMR4fRRHMMg@mail.gmail.com>
X-Gm-Features: AQt7F2r02_CKfvncANQKuwq_5pzeJcyqT-Y3Q5K99Nc1GOaWzp-PvkoC6nxlej0
Message-ID: <CAL3q7H48XH2GXFDMvs6BS6yW+S53qpja50kwZCbAMR4fRRHMMg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: add mount time auto fix for orphan fst entries
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Mark Harmstone <mark@harmstone.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:13=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> [BUG]
> Before btrfs-progs v6.16.1 release, mkfs.btrfs can leave free space tree
> entries for deleted chunks:
>
>  # mkfs.btrfs -f -O fst $dev
>  # btrfs ins dump-tree -t chunk $dev
>  btrfs-progs v6.16
>  chunk tree
>  leaf 22036480 items 4 free space 15781 generation 8 owner CHUNK_TREE
>  leaf 22036480 flags 0x1(WRITTEN) backref revision 1
>         item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
>         item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 i=
temsize 80
>         ^^^ The first chunk is at 13631488
>         item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 i=
temsize 112
>         item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 i=
temsize 112
>
>  # btrfs ins dump-tree -t free-space-tree $dev
>  btrfs-progs v6.16
>  free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
>  leaf 30556160 items 13 free space 15918 generation 8 owner FREE_SPACE_TR=
EE
>  leaf 30556160 flags 0x1(WRITTEN) backref revision 1
>         item 0 key (1048576 FREE_SPACE_INFO 4194304) itemoff 16275 itemsi=
ze 8
>                 free space info extent count 1 flags 0
>         item 1 key (1048576 FREE_SPACE_EXTENT 4194304) itemoff 16275 item=
size 0
>                 free space extent
>         item 2 key (5242880 FREE_SPACE_INFO 8388608) itemoff 16267 itemsi=
ze 8
>                 free space info extent count 1 flags 0
>         item 3 key (5242880 FREE_SPACE_EXTENT 8388608) itemoff 16267 item=
size 0
>                 free space extent
>         ^^^ Above 4 items are all before the first chunk.
>         item 4 key (13631488 FREE_SPACE_INFO 8388608) itemoff 16259 items=
ize 8
>                 free space info extent count 1 flags 0
>         item 5 key (13631488 FREE_SPACE_EXTENT 8388608) itemoff 16259 ite=
msize 0
>                 free space extent
>         ...
>
> This can trigger btrfs check errors.
>
> [CAUSE]
> It's a bug in free space tree implementation of btrfs-progs, which
> doesn't delete involved fst entries for the to-be-deleted chunk/block
> group.
>
> [ENHANCEMENT]
> The mostly common fix is to clear the space cache and rebuild it, but
> that requires a ro->rw remount which may not be possible for rootfs,
> and also relies on users to use "clear_cache" mount option manually.
>
> Here introduce a kernel fix for it, which will delete any entries that
> is before the first block group automatically at the first RW mount.
>
> For fses without such problem, the overhead is just a single tree
> search and no modification to the free space tree, thus the overhead
> should be minimal.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>

We had a patch to fix this from Mark after my report in the list:

https://lore.kernel.org/linux-btrfs/20250923155523.31617-2-mark@harmstone.c=
om/

But he never replied since then....

> ---
> Changelog:
> v2:
> - Do not output the "deleted orphan free space tree entries" for error
> - Do not return >0 for delete_orphan_free_space_entries()
>   If we deleted a full leaf and the next item matches the first bg, we
>   will return 1. This should not happen in the real world though.
> - Add a comment for the inner for() loop break
>   For double loop, we need to take care of which loop we're breaking
>   out.
> ---
>  fs/btrfs/disk-io.c         |  10 ++++
>  fs/btrfs/free-space-tree.c | 102 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-tree.h |   1 +
>  3 files changed, 113 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e5535bdc5b0c..ebef65f6ea12 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3034,6 +3034,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info =
*fs_info)
>                 }
>         }
>
> +       /*
> +        * Before btrfs-progs v6.16.1 mkfs.btrfs can leave free space ent=
ries
> +        * for deleted temporary chunks.
> +        * Delete them if needed.

"Delete them if they exist." sounds better, as there's really no need,
just an annoyance due to btrfs check reporting them as errors.

> +        */
> +       ret =3D btrfs_fix_orphan_free_space_entries(fs_info);

I would name the function with remove/delete instead of "fix", since
it's what we actually do.

> +       if (ret < 0) {
> +               btrfs_warn(fs_info, "failed to fix orphan free space tree=
 entries: %d", ret);

Rather than fix, I would say delete/remove.

And btrfs_err() rather than warning since a failure there makes the mount f=
ail.

> +               goto out;
> +       }
>         /*
>          * btrfs_find_orphan_roots() is responsible for finding all the d=
ead
>          * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and l=
oad
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index a66ce9ef3aff..e14e508cb125 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1710,3 +1710,105 @@ int btrfs_load_free_space_tree(struct btrfs_cachi=
ng_control *caching_ctl)
>         else
>                 return load_free_space_extents(caching_ctl, path, extent_=
count);
>  }
> +
> +static int delete_orphan_free_space_entries(struct btrfs_root *fst_root,
> +                                           struct btrfs_path *path,
> +                                           u64 first_bg_bytenr)
> +{
> +       struct btrfs_trans_handle *trans;
> +       int ret;
> +
> +       trans =3D btrfs_start_transaction(fst_root, 1);
> +       if (IS_ERR(trans))
> +               return PTR_ERR(trans);
> +
> +       while (true) {
> +               struct btrfs_key key =3D { 0 };
> +               int i;
> +
> +               ret =3D btrfs_search_slot(trans, fst_root, &key, path, -1=
, 1);
> +               if (ret < 0)
> +                       break;
> +               ASSERT(ret > 0);
> +               ret =3D 0;
> +               for (i =3D 0; i < btrfs_header_nritems(path->nodes[0]); i=
++) {
> +                       btrfs_item_key_to_cpu(path->nodes[0], &key, i);
> +                       if (key.objectid >=3D first_bg_bytenr)
> +                               /*
> +                                * Only break the for() loop and continue=
 to
> +                                * delete items.
> +                                */
> +                               break;

We normally use { } here, it's a single statement but there's the comment.

> +               }
> +               /* No item to delete, finished. */

item -> items

> +               if (i =3D=3D 0)
> +                       break;
> +
> +               ret =3D btrfs_del_items(trans, fst_root, path, 0, i);
> +               if (ret < 0)
> +                       break;
> +               btrfs_release_path(path);
> +       }
> +       btrfs_release_path(path);
> +       btrfs_end_transaction(trans);
> +       if (ret =3D=3D 0)
> +               btrfs_info(fst_root->fs_info, "deleted orphan free space =
tree entries");
> +       return ret;
> +}

Missing newline to separate the functions.

> +/* Remove any free space entry before the first block group. */
> +int btrfs_fix_orphan_free_space_entries(struct btrfs_fs_info *fs_info)
> +{
> +       BTRFS_PATH_AUTO_RELEASE(path);
> +       struct btrfs_key key =3D {
> +               .objectid =3D BTRFS_FREE_SPACE_TREE_OBJECTID,
> +               .type =3D BTRFS_ROOT_ITEM_KEY,
> +               .offset =3D 0,
> +       };
> +       struct btrfs_root *root;
> +       struct btrfs_block_group *bg;
> +       u64 first_bg_bytenr;
> +       int ret;
> +
> +       /*
> +        * Extent tree v2 have multiple global roots based on the block g=
roup.

have -> has

Otherwise it looks good, thanks.

> +        * This means we can not easily grab the global free space tree a=
nd locate
> +        * orphan items.
> +        * Furthermore this is still experimental, all users should use t=
he latest
> +        * btrfs-progs anyway.
> +        */
> +       if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
> +               return 0;
> +       if (!btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
> +               return 0;
> +       root =3D btrfs_global_root(fs_info, &key);
> +       if (!root)
> +               return 0;
> +
> +       key.objectid =3D 0;
> +       key.type =3D 0;
> +       key.offset =3D 0;
> +
> +       bg =3D btrfs_lookup_first_block_group(fs_info, 0);
> +       if (unlikely(!bg)) {
> +               btrfs_err(fs_info, "no block group found");
> +               return -EUCLEAN;
> +       }
> +       first_bg_bytenr =3D bg->start;
> +       btrfs_put_block_group(bg);
> +
> +       ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +       if (ret < 0)
> +               return ret;
> +       /* There should not be an all-zero key in fst. */
> +       ASSERT(ret > 0);
> +
> +       /* Empty free space tree. */
> +       if (path.slots[0] >=3D btrfs_header_nritems(path.nodes[0]))
> +               return 0;
> +
> +       btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
> +       if (key.objectid >=3D first_bg_bytenr)
> +               return 0;
> +       btrfs_release_path(&path);
> +       return delete_orphan_free_space_entries(root, &path, first_bg_byt=
enr);
> +}
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index 3d9a5d4477fc..c6958976e9c9 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_han=
dle *trans,
>                                  u64 start, u64 size);
>  int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>                                       u64 start, u64 size);
> +int btrfs_fix_orphan_free_space_entries(struct btrfs_fs_info *fs_info);
>
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
> --
> 2.52.0
>
>

