Return-Path: <linux-btrfs+bounces-20107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 032BACF4C70
	for <lists+linux-btrfs@lfdr.de>; Mon, 05 Jan 2026 17:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DBAD3073788
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Jan 2026 16:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA022EDD7E;
	Mon,  5 Jan 2026 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSoTu4WT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579E2F1FE7
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631099; cv=none; b=sNHfvgpm5aNRcvaRYCBggn1r8B7o2ZAFilBUxF5lFhjmN32G+p1SynNYHIPVLd2OcPYX44LwYfuzR0wOvx1RGlETAGzYtLlSdnRKxHUHwpXFZd6vgx+A9K8ZdNFeBO3gwmizZ5rJRaYJD3DWbrZeGLkMtV9/J53FoABnBV00cdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631099; c=relaxed/simple;
	bh=NY2hppIPCFADLZ4yrXkUTn31A5dfVwVMUMSbFY5iYlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJvwVQVpBhRLwnuR8lTZHfyXzssMxuTKbrttgMmiEvFZsIULSMhXd5F0FAtlrCg/nR2ppinUsSUfhL9uRiE/PndSiv+N5tNncC/W/NvEolVcsga01TKKz5sG5KuQpCOkf3HvpsrZ7ScMpm6Fn71YrpRllsckPTAHwlBKrNpVlaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSoTu4WT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE21C19421
	for <linux-btrfs@vger.kernel.org>; Mon,  5 Jan 2026 16:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767631099;
	bh=NY2hppIPCFADLZ4yrXkUTn31A5dfVwVMUMSbFY5iYlM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HSoTu4WTWr1zA6qg7IRruWyFDNSntAN0t+DSvGh7mi+5ZHJ3D7imtAmthFArMK2ZW
	 YvaOTklfDlrjLK+fqIFZlZQEtMfCdPJ9wDnHgbqWr43nUYayqhzLjXBPh5MCdGAlnC
	 6N/PIOKvyMaWK5nIpylNJugxWDVcFohbyiJbRH+kiL5wqptPlkxMjj+/j5NqmjgrSF
	 aXCGSRFyYgZa2yaPvwrPFzE+699qNVHK/DkkFOnXe759D9mQFEd+5sMKIv91vLSs4c
	 LuhagqQGBldEBZC4KNZ4wEpOe9zrmIHf+c5779aQblLXZKEZXl+8arM6TApcCxa8HJ
	 lL/26lhjuAMcA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b728a43e410so22505466b.1
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Jan 2026 08:38:19 -0800 (PST)
X-Gm-Message-State: AOJu0YxtMCv8mlJBMgCet07KDsbB1iTwl5SHgG+t9E0oMxrkFT3V3cNX
	MaY0vlEx4G/WhS/B/xPllVRpdMatrnxH/rHpCCeTp8Ed3bLEWhG4uUrOvkgNaxjTZV/yLON9s4x
	HFIGkXo304k1/FJNfrt/rCJcpuSG4Dzw=
X-Google-Smtp-Source: AGHT+IGOk4F3Fy17GO1DADCuppDoZa9nvjowkJG9xz+bNWH1lisjUHaaZ+ZAarbm3C8odxp3lrFWBRAJqsCwMVuQ4ME=
X-Received: by 2002:a17:906:f593:b0:b80:413:16d6 with SMTP id
 a640c23a62f3a-b8426c09d0cmr31923166b.44.1767631098046; Mon, 05 Jan 2026
 08:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com>
In-Reply-To: <f58857f1ac741bd1fb4fa2e7ec56ed87815bb1f5.1766198159.git.wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 5 Jan 2026 16:37:39 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5U5=yPYMR0eMOCL_+M5=WwQcFhWOtgKQicOd2ehpwa0A@mail.gmail.com>
X-Gm-Features: AQt7F2rQDLel8aQjtXWnATqYG2Jw4t_htIgpHm6ZSH_gxZfzlyo9W6U59jpvRp0
Message-ID: <CAL3q7H5U5=yPYMR0eMOCL_+M5=WwQcFhWOtgKQicOd2ehpwa0A@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: add mount time auto fix for orphan fst entries
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 2:38=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> Changelog:
> v3:
> - Rename the exported function to btrfs_delete_orphan_free_space_entries(=
)
>   And minor rewords.
> - Use btrfs_err() if we failed to delete the orphan fst entries
> - Various grammar and code style fixes
>
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
>  fs/btrfs/free-space-tree.c | 104 +++++++++++++++++++++++++++++++++++++
>  fs/btrfs/free-space-tree.h |   1 +
>  3 files changed, 115 insertions(+)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index e5535bdc5b0c..1015185c80ae 100644
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
> +        * Delete them if they exist.
> +        */
> +       ret =3D btrfs_delete_orphan_free_space_entries(fs_info);
> +       if (ret < 0) {
> +               btrfs_err(fs_info, "failed to delete orphan free space tr=
ee entries: %d", ret);
> +               goto out;
> +       }
>         /*
>          * btrfs_find_orphan_roots() is responsible for finding all the d=
ead
>          * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and l=
oad
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index a66ce9ef3aff..e949dc3e5cd0 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1710,3 +1710,107 @@ int btrfs_load_free_space_tree(struct btrfs_cachi=
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
> +                       if (key.objectid >=3D first_bg_bytenr) {
> +                               /*
> +                                * Only break the for() loop and continue=
 to
> +                                * delete items.
> +                                */
> +                               break;
> +                       }
> +               }
> +               /* No items to delete, finished. */
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
> +
> +/* Remove any free space entry before the first block group. */
> +int btrfs_delete_orphan_free_space_entries(struct btrfs_fs_info *fs_info=
)
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
> +        * Extent tree v2 has multiple global roots based on the block gr=
oup.
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
> index 3d9a5d4477fc..ca04fc7cf29e 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_han=
dle *trans,
>                                  u64 start, u64 size);
>  int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>                                       u64 start, u64 size);
> +int btrfs_delete_orphan_free_space_entries(struct btrfs_fs_info *fs_info=
);
>
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
> --
> 2.52.0
>
>

