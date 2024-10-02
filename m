Return-Path: <linux-btrfs+bounces-8437-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B173298DE6C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 17:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7488F28261F
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5711D096A;
	Wed,  2 Oct 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2uCU4g6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F621D042F
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881641; cv=none; b=jq6b/rUr3EW9C4yna92GRdvEDo7PNHFplRotfo1/Os3F5AQG2yOEWAeGU0fGURgHCwoVIkEgAVKhzcA+Ii4aIsdMG7bC0BiOH5zUu7fh3qSkuejYZsAMpkMYiY4kqjHR+uergu9jjffGp48cMBxcJN2ELhj1Owvxv7m8q+uYAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881641; c=relaxed/simple;
	bh=+2Boy7pihy2UuLz3VXoU8tDZ3Nx45Mg/43HwKZwCmHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGxAmjnzoWbmQ1h+EOEBa4R1o4QDXNLtscASJkz/yi1Td9+FlqV/5zvI2MqfNAbZ5JXh20S2jY22RIsBPre6PpMoq67vnRNxpGpraYd+pbtGKigHnoaqKxHina0r6AN8o/+h4dAjxXtiqsiKuwFPdYRc9QVB3II7Wb0vaO7oP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2uCU4g6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EABFC4CECE
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881641;
	bh=+2Boy7pihy2UuLz3VXoU8tDZ3Nx45Mg/43HwKZwCmHM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z2uCU4g6yHEAbo/8h+FydUnEDRPCs2EyXMqMYPOPBWFXu6MYZHTb7sW4BoWur5Evo
	 sauxUbumqRqvGBF6mnfwwgu5WBet5WPsOCywdqvtd2YLrkTTLwYOQDbV1fvaBvL9dQ
	 X2MpPom5D/shnv0fP5qFOMu/UJXjyA4FwYDfr0nXV3yqJ4ZT2vjM8ErG6YrHqaMtUw
	 4uRh814R6kqJy0F1FV7JW7+KTQ8/ysfK28tXSB+anHoSINvTeWGdXZKoWA7VtQMXWa
	 AMPDHJi9AwQ8EINW28iRSrEU+2eCFiy8ke7AjoTM6KYN2jZZd7koki6KXtdyG/YFbz
	 C6Y6Xd5VsuUxw==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cd26c6dd1so5305355f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Oct 2024 08:07:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YzjjgdsYwIKCc/IW8H89XJI1+keqE3XBQ7KPNr3BKq3M3Nw+DEW
	ZJMflzdiSnG9QRZeHXhKacZkRpG6VA8ir2mxDpSb6suz/9zJFsTk6rhvff46ZEUUV7cPKkJix7h
	E1/2umCyNMEcIijR2jcIiWcEHBqQ=
X-Google-Smtp-Source: AGHT+IGnLe347G6AbtrAXVNpZR4Ho5PTfLgLnQxZMlOZGYWr74qoqQE2hNQ3U05VCGSrph3gncOWMA91H+VzCDpYTGo=
X-Received: by 2002:a5d:5d81:0:b0:37c:fbf8:fc4 with SMTP id
 ffacd0b85a97d-37cfbf8110amr2445624f8f.59.1727881639653; Wed, 02 Oct 2024
 08:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143830.2067478-1-maharmstone@fb.com>
In-Reply-To: <20240715143830.2067478-1-maharmstone@fb.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 2 Oct 2024 16:06:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6xfZMa7htN3ebD7RZBYh2uJmcH4JvYcmjXRd6RaKTyug@mail.gmail.com>
Message-ID: <CAL3q7H6xfZMa7htN3ebD7RZBYh2uJmcH4JvYcmjXRd6RaKTyug@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs-progs: add rudimentary log checking
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 3:38=E2=80=AFPM Mark Harmstone <maharmstone@fb.com>=
 wrote:
>
> Currently the transaction log is more or less ignored by btrfs check,
> meaning that it's possible for a FS with a corrupt log to pass btrfs
> check, but be immediately corrupted by the kernel when it's mounted.
>
> This patch adds a check that if there's an inode in the log, any pending
> non-compressed writes also have corresponding csum entries.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
> Changes:
> v2:
> helper to load log root
> handle compressed extents
> loop logic improvements
> fix bug in check_log_csum
>
> v3:
> added test
> added explanatory comment to check_log_csum
> changed length operation to -=3D
>
>  check/main.c                                  | 304 +++++++++++++++++-
>  .../063-log-missing-csum/default.img.xz       | Bin 0 -> 1288 bytes
>  tests/fsck-tests/063-log-missing-csum/test.sh |  14 +
>  3 files changed, 306 insertions(+), 12 deletions(-)
>  create mode 100644 tests/fsck-tests/063-log-missing-csum/default.img.xz
>  create mode 100755 tests/fsck-tests/063-log-missing-csum/test.sh
>
> diff --git a/check/main.c b/check/main.c
> index 83c721d3..eaae3042 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -9787,6 +9787,274 @@ static int zero_log_tree(struct btrfs_root *root)
>         return ret;
>  }
>
> +/* Searches the given root for checksums in the range [addr, addr+length=
].
> + * Returns 1 if found, 0 if not found, and < 0 for an error. */
> +static int check_log_csum(struct btrfs_root *root, u64 addr, u64 length)
> +{
> +       struct btrfs_path path =3D { 0 };
> +       struct btrfs_key key;
> +       struct extent_buffer *leaf;
> +       u16 csum_size =3D gfs_info->csum_size;
> +       u16 num_entries;
> +       u64 data_len;
> +       int ret;
> +
> +       key.objectid =3D BTRFS_EXTENT_CSUM_OBJECTID;
> +       key.type =3D BTRFS_EXTENT_CSUM_KEY;
> +       key.offset =3D addr;
> +
> +       ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (ret > 0 && path.slots[0])
> +               path.slots[0]--;
> +
> +       ret =3D 0;
> +
> +       while (1) {
> +               leaf =3D path.nodes[0];
> +               if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
> +                       ret =3D btrfs_next_leaf(root, &path);
> +                       if (ret) {
> +                               if (ret > 0)
> +                                       ret =3D 0;
> +
> +                               break;
> +                       }
> +                       leaf =3D path.nodes[0];
> +               }
> +
> +               btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +               if (key.objectid > BTRFS_EXTENT_CSUM_OBJECTID)
> +                       break;
> +
> +               if (key.objectid !=3D BTRFS_EXTENT_CSUM_OBJECTID ||
> +                   key.type !=3D BTRFS_EXTENT_CSUM_KEY)
> +                       goto next;
> +
> +               if (key.offset >=3D addr + length)
> +                       break;
> +
> +               num_entries =3D btrfs_item_size(leaf, path.slots[0]) / cs=
um_size;
> +               data_len =3D num_entries * gfs_info->sectorsize;
> +
> +               if (addr >=3D key.offset && addr <=3D key.offset + data_l=
en) {
> +                       u64 end =3D min(addr + length, key.offset + data_=
len);
> +
> +                       length -=3D (end - addr);
> +                       addr =3D end;
> +
> +                       if (length =3D=3D 0)
> +                               break;
> +               }
> +
> +next:
> +               path.slots[0]++;
> +       }
> +
> +       btrfs_release_path(&path);
> +
> +       if (ret >=3D 0)
> +               ret =3D length =3D=3D 0 ? 1 : 0;
> +
> +       return ret;
> +}
> +
> +static int check_log_root(struct btrfs_root *root, struct cache_tree *ro=
ot_cache,
> +                         struct walk_control *wc)
> +{
> +       struct btrfs_path path =3D { 0 };
> +       struct btrfs_key key;
> +       struct extent_buffer *leaf;
> +       int ret, err =3D 0;
> +       u64 last_csum_inode =3D 0;
> +
> +       key.objectid =3D BTRFS_FIRST_FREE_OBJECTID;
> +       key.type =3D BTRFS_INODE_ITEM_KEY;
> +       key.offset =3D 0;
> +       ret =3D btrfs_search_slot(NULL, root, &key, &path, 0, 0);
> +       if (ret < 0)
> +               return 1;
> +
> +       while (1) {
> +               leaf =3D path.nodes[0];
> +               if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
> +                       ret =3D btrfs_next_leaf(root, &path);
> +                       if (ret) {
> +                               if (ret < 0)
> +                                       err =3D 1;
> +
> +                               break;
> +                       }
> +                       leaf =3D path.nodes[0];
> +               }
> +               btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +               if (key.objectid =3D=3D BTRFS_EXTENT_CSUM_OBJECTID)
> +                       break;
> +
> +               if (key.type =3D=3D BTRFS_INODE_ITEM_KEY) {
> +                       struct btrfs_inode_item *item;
> +
> +                       item =3D btrfs_item_ptr(leaf, path.slots[0],
> +                                             struct btrfs_inode_item);
> +
> +                       if (!(btrfs_inode_flags(leaf, item) & BTRFS_INODE=
_NODATASUM))
> +                               last_csum_inode =3D key.objectid;
> +               } else if (key.type =3D=3D BTRFS_EXTENT_DATA_KEY &&
> +                          key.objectid =3D=3D last_csum_inode) {
> +                       struct btrfs_file_extent_item *fi;
> +                       u64 addr, length;
> +
> +                       fi =3D btrfs_item_ptr(leaf, path.slots[0],
> +                                           struct btrfs_file_extent_item=
);
> +
> +                       if (btrfs_file_extent_type(leaf, fi) !=3D BTRFS_F=
ILE_EXTENT_REG)
> +                               goto next;
> +
> +                       addr =3D btrfs_file_extent_disk_bytenr(leaf, fi) =
+
> +                               btrfs_file_extent_offset(leaf, fi);
> +                       length =3D btrfs_file_extent_num_bytes(leaf, fi);
> +
> +                       ret =3D check_log_csum(root, addr, length);
> +                       if (ret < 0) {
> +                               err =3D 1;
> +                               break;
> +                       }
> +
> +                       if (!ret) {
> +                               error("csum missing in log (root %llu, in=
ode %llu, "
> +                                     "offset %llu, address 0x%llx, lengt=
h %llu)",
> +                                     root->objectid, last_csum_inode, ke=
y.offset,
> +                                     addr, length);

This is causing some false failures when running fstests, like test
btrfs/056 for example.
There it's attempting to lookup csums for file extents representing
holes (disk_bytenr =3D=3D 0), which don't exist.

Also this change assumes that for every file extent item we must have
a csum item logged, which is not always the case.
For example, before the following kernel commit:

commit 7f30c07288bb9e20463182d0db56416025f85e08
Author: Filipe Manana <fdmanana@suse.com>
Date:   Thu Feb 17 12:12:03 2022 +0000

    btrfs: stop copying old file extents when doing a full fsync

We could log old file extent items, from past transactions, but
because they were from past transactions, we didn't log the csums
because they aren't needed.

So on older kernels that triggers a false alarm too.

Thanks.

> +                               err =3D 1;
> +                       }
> +               }
> +
> +next:
> +               path.slots[0]++;
> +       }
> +
> +       btrfs_release_path(&path);
> +
> +       return err;
> +}
> +
> +static int load_log_root(u64 root_id, struct btrfs_path *path,
> +                        struct btrfs_root *tmp_root)
> +{
> +       struct extent_buffer *l;
> +       struct btrfs_tree_parent_check check =3D { 0 };
> +
> +       btrfs_setup_root(tmp_root, gfs_info, root_id);
> +
> +       l =3D path->nodes[0];
> +       read_extent_buffer(l, &tmp_root->root_item,
> +                       btrfs_item_ptr_offset(l, path->slots[0]),
> +                       sizeof(tmp_root->root_item));
> +
> +       tmp_root->root_key.objectid =3D root_id;
> +       tmp_root->root_key.type =3D BTRFS_ROOT_ITEM_KEY;
> +       tmp_root->root_key.offset =3D 0;
> +
> +       check.owner_root =3D btrfs_root_id(tmp_root);
> +       check.transid =3D btrfs_root_generation(&tmp_root->root_item);
> +       check.level =3D btrfs_root_level(&tmp_root->root_item);
> +
> +       tmp_root->node =3D read_tree_block(gfs_info,
> +                                        btrfs_root_bytenr(&tmp_root->roo=
t_item),
> +                                        &check);
> +       if (IS_ERR(tmp_root->node)) {
> +               tmp_root->node =3D NULL;
> +               return 1;
> +       }
> +
> +       if (btrfs_header_level(tmp_root->node) !=3D btrfs_root_level(&tmp=
_root->root_item)) {
> +               error("root [%llu %llu] level %d does not match %d",
> +                       tmp_root->root_key.objectid,
> +                       tmp_root->root_key.offset,
> +                       btrfs_header_level(tmp_root->node),
> +                       btrfs_root_level(&tmp_root->root_item));
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int check_log(struct cache_tree *root_cache)
> +{
> +       struct btrfs_path path =3D { 0 };
> +       struct walk_control wc =3D { 0 };
> +       struct btrfs_key key;
> +       struct extent_buffer *leaf;
> +       struct btrfs_root *log_root =3D gfs_info->log_root_tree;
> +       int ret;
> +       int err =3D 0;
> +
> +       cache_tree_init(&wc.shared);
> +
> +       key.objectid =3D BTRFS_TREE_LOG_OBJECTID;
> +       key.type =3D BTRFS_ROOT_ITEM_KEY;
> +       key.offset =3D 0;
> +       ret =3D btrfs_search_slot(NULL, log_root, &key, &path, 0, 0);
> +       if (ret < 0) {
> +               err =3D 1;
> +               goto out;
> +       }
> +
> +       while (1) {
> +               leaf =3D path.nodes[0];
> +               if (path.slots[0] >=3D btrfs_header_nritems(leaf)) {
> +                       ret =3D btrfs_next_leaf(log_root, &path);
> +                       if (ret) {
> +                               if (ret < 0)
> +                                       err =3D 1;
> +                               break;
> +                       }
> +                       leaf =3D path.nodes[0];
> +               }
> +               btrfs_item_key_to_cpu(leaf, &key, path.slots[0]);
> +
> +               if (key.objectid > BTRFS_TREE_LOG_OBJECTID ||
> +                   key.type > BTRFS_ROOT_ITEM_KEY)
> +                       break;
> +
> +               if (key.objectid =3D=3D BTRFS_TREE_LOG_OBJECTID &&
> +                   key.type =3D=3D BTRFS_ROOT_ITEM_KEY &&
> +                   fs_root_objectid(key.offset)) {
> +                       struct btrfs_root tmp_root;
> +
> +                       memset(&tmp_root, 0, sizeof(tmp_root));
> +
> +                       ret =3D load_log_root(key.offset, &path, &tmp_roo=
t);
> +                       if (ret) {
> +                               err =3D 1;
> +                               goto next;
> +                       }
> +
> +                       ret =3D check_log_root(&tmp_root, root_cache, &wc=
);
> +                       if (ret)
> +                               err =3D 1;
> +
> +next:
> +                       if (tmp_root.node)
> +                               free_extent_buffer(tmp_root.node);
> +               }
> +
> +               path.slots[0]++;
> +       }
> +out:
> +       btrfs_release_path(&path);
> +       if (err)
> +               free_extent_cache_tree(&wc.shared);
> +       if (!cache_tree_empty(&wc.shared))
> +               fprintf(stderr, "warning line %d\n", __LINE__);
> +
> +       return err;
> +}
> +
>  static void free_roots_info_cache(void)
>  {
>         if (!roots_info_cache)
> @@ -10585,9 +10853,21 @@ static int cmd_check(const struct cmd_struct *cm=
d, int argc, char **argv)
>                 goto close_out;
>         }
>
> +       if (gfs_info->log_root_tree) {
> +               fprintf(stderr, "[1/8] checking log\n");
> +               ret =3D check_log(&root_cache);
> +
> +               if (ret)
> +                       error("errors found in log");
> +               err |=3D !!ret;
> +       } else {
> +               fprintf(stderr,
> +               "[1/8] checking log skipped (none written)\n");
> +       }
> +
>         if (!init_extent_tree) {
>                 if (!g_task_ctx.progress_enabled) {
> -                       fprintf(stderr, "[1/7] checking root items\n");
> +                       fprintf(stderr, "[2/8] checking root items\n");
>                 } else {
>                         g_task_ctx.tp =3D TASK_ROOT_ITEMS;
>                         task_start(g_task_ctx.info, &g_task_ctx.start_tim=
e,
> @@ -10622,11 +10902,11 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
>                         }
>                 }
>         } else {
> -               fprintf(stderr, "[1/7] checking root items... skipped\n")=
;
> +               fprintf(stderr, "[2/8] checking root items... skipped\n")=
;
>         }
>
>         if (!g_task_ctx.progress_enabled) {
> -               fprintf(stderr, "[2/7] checking extents\n");
> +               fprintf(stderr, "[3/8] checking extents\n");
>         } else {
>                 g_task_ctx.tp =3D TASK_EXTENTS;
>                 task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_ta=
sk_ctx.item_count);
> @@ -10644,9 +10924,9 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>
>         if (!g_task_ctx.progress_enabled) {
>                 if (is_free_space_tree)
> -                       fprintf(stderr, "[3/7] checking free space tree\n=
");
> +                       fprintf(stderr, "[4/8] checking free space tree\n=
");
>                 else
> -                       fprintf(stderr, "[3/7] checking free space cache\=
n");
> +                       fprintf(stderr, "[4/8] checking free space cache\=
n");
>         } else {
>                 g_task_ctx.tp =3D TASK_FREE_SPACE;
>                 task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_ta=
sk_ctx.item_count);
> @@ -10664,7 +10944,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>          */
>         no_holes =3D btrfs_fs_incompat(gfs_info, NO_HOLES);
>         if (!g_task_ctx.progress_enabled) {
> -               fprintf(stderr, "[4/7] checking fs roots\n");
> +               fprintf(stderr, "[5/8] checking fs roots\n");
>         } else {
>                 g_task_ctx.tp =3D TASK_FS_ROOTS;
>                 task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_ta=
sk_ctx.item_count);
> @@ -10680,10 +10960,10 @@ static int cmd_check(const struct cmd_struct *c=
md, int argc, char **argv)
>
>         if (!g_task_ctx.progress_enabled) {
>                 if (check_data_csum)
> -                       fprintf(stderr, "[5/7] checking csums against dat=
a\n");
> +                       fprintf(stderr, "[6/8] checking csums against dat=
a\n");
>                 else
>                         fprintf(stderr,
> -               "[5/7] checking only csums items (without verifying data)=
\n");
> +               "[6/8] checking only csums items (without verifying data)=
\n");
>         } else {
>                 g_task_ctx.tp =3D TASK_CSUMS;
>                 task_start(g_task_ctx.info, &g_task_ctx.start_time, &g_ta=
sk_ctx.item_count);
> @@ -10702,7 +10982,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>         /* For low memory mode, check_fs_roots_v2 handles root refs */
>          if (check_mode !=3D CHECK_MODE_LOWMEM) {
>                 if (!g_task_ctx.progress_enabled) {
> -                       fprintf(stderr, "[6/7] checking root refs\n");
> +                       fprintf(stderr, "[7/8] checking root refs\n");
>                 } else {
>                         g_task_ctx.tp =3D TASK_ROOT_REFS;
>                         task_start(g_task_ctx.info, &g_task_ctx.start_tim=
e, &g_task_ctx.item_count);
> @@ -10717,7 +10997,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>                 }
>         } else {
>                 fprintf(stderr,
> -       "[6/7] checking root refs done with fs roots in lowmem mode, skip=
ping\n");
> +       "[7/8] checking root refs done with fs roots in lowmem mode, skip=
ping\n");
>         }
>
>         while (opt_check_repair && !list_empty(&gfs_info->recow_ebs)) {
> @@ -10749,7 +11029,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>
>         if (gfs_info->quota_enabled) {
>                 if (!g_task_ctx.progress_enabled) {
> -                       fprintf(stderr, "[7/7] checking quota groups\n");
> +                       fprintf(stderr, "[8/8] checking quota groups\n");
>                 } else {
>                         g_task_ctx.tp =3D TASK_QGROUPS;
>                         task_start(g_task_ctx.info, &g_task_ctx.start_tim=
e, &g_task_ctx.item_count);
> @@ -10772,7 +11052,7 @@ static int cmd_check(const struct cmd_struct *cmd=
, int argc, char **argv)
>                 ret =3D 0;
>         } else {
>                 fprintf(stderr,
> -               "[7/7] checking quota groups skipped (not enabled on this=
 FS)\n");
> +               "[8/8] checking quota groups skipped (not enabled on this=
 FS)\n");
>         }
>
>         if (!list_empty(&gfs_info->recow_ebs)) {
> diff --git a/tests/fsck-tests/063-log-missing-csum/default.img.xz b/tests=
/fsck-tests/063-log-missing-csum/default.img.xz
> new file mode 100644
> index 0000000000000000000000000000000000000000..c9b4f420ac23866cd142428da=
f21739efda0762d
> GIT binary patch
> literal 1288
> zcmV+j1^4>>H+ooF000E$*0e?f03iVu0001VFXf}+)Bgm;T>wRyj;C3^v%$$4d1wo3
> zjjaF1$8Jv*pMMm%#Ch6IM%}7&=3D@^TvKIIdYjZ@t7T($M|Hz%Cr>ZwJ6sj_bRsY^a*
> zIr#q#U>$p<Go1bOhu5#Q<?@08{(UO6n<sqYIY$<RXz3}#&sBuS|AUrsgQ{%?z1>tr
> zW^k~hR~HJs$P?zuw_V+%>i2AU4x-C~^RmH%0#2o7VY;D>d@D<+CC=3DJ4l?Bs2d@5yC
> z&pKh_V}nG$A*f{hGHlfKeT*E3NA1Q(Nt;TxvV6m2A_RVpD=3D`*t<8b6_KTom1S=3D|eG
> z>OMhPCcl7*3tYx)YhtFm-3)~e_SPBasmqw|$jnE_-QZfatuNh^bkJ5yW{ZX7NmD)i
> zLKCQYs5y!To5G>tIYzSNigXu|<l&x%JzxMA5aW-t+nod|B!efqr+_#STUo@Xu>wY=3D
> z*;zh8-nLPC+GYq6HU^A<Qjkh41{(MMB=3Dp?8i7|;p<cL9o>Q7;56uclyq=3DuCMb1GmZ
> zuq5@iwv1^<TQdlj9#Xdq$Vj!1d~GO$P#HmKmPt*t2iPme{8~y6{{T++2nv+X7)Fnf
> z`$pgevh)w!LR&hx2a|{sW@ac43(Sl>??<SGJB`t-nDXvSDSY*87<ziAenKb9p4UlP
> z*(x(s)OBgD_f*R-*yBUaiD3U<uhy+{P{T&x@o^!9gXa@=3DKts_p@u`Tb)rQcu{)tzQ
> zhCXcu`CGkyKuQRy(M0c#fPDWJwyhC`w2mizWqVSf=3D=3DSk-nywG!nJzNT5aM0tVb}Va
> zK?^BQbY*CPLeJtG``VF4F@BVWBpSVWDFk`J!cOhagXH=3DGB1GApQ?zsg8%y=3DJ$Fgl1
> z)+=3DjFc)g}pALW^HG}wkoY7fOfbZ274b~+dEoA?l%Xzz`P-F)vb1^UziIz|no!02bS
> zWPfo?`TiKe8aIuiPilXte381GZ4tQc6=3DY*KS0rehLE^7!W+MOr0AEFmQgw<KSH}Ix
> ze4qlov3aIg5e(Oh1%CwTZN^`UI!7g(U;iDFt(>e4XDB-M)l0stJd3pf<XujqB2}MW
> z6EY1#$l>s;T1IYy#{A9ljl@Ba_*dh)Qfq@8Y1A#q%p|d;USrIAZ*n1`%ho*!-RYOY
> z4j%X?D?CoiaW8A*7aue82GA9jmMGg6Bv&mO#v6uKVw1V~Uu01wXbz(RJN_|xw{`8K
> zSfdyQCJOdIwdN%h+Jr{$9!6otgQ8^`lkU4u;5wJlsy#P<D{Nc39m@=3D*OHZ533tvD<
> zfb=3Dc>-IWOj%>%mQ@Ja!#!QIOVuluA}ecSFg;*v@<bR@g*YX>1-?kl9WGes{ulrRWq
> zTCW@Om{iybhK+m8SiS%n^)Kgk21T`IEW#){Czvz;Fix;5bdkB$BFXimx9iBaRZ9r=3D
> zV(H0OD8mK94(j^6gF8)|^i-78H`hR#ebBvFq}>vK6-ni7j1S>*viG^nA7<~Bn2KW0
> zw%D36qxTcpO;c2bYwf)K?p#^LFL4Ifq8?kP?#;(Jo8*(twFPRBj*u~h%Ej$X6JI2E
> z<L5)YZY#@aM-2sxodox#)=3DG1ycE6A6j?am&HLbKPv@FI{(HAJ#D*V@xG^U`bnRtH<
> y%w+Y9$G2sBKv@6)0000tuOhH&%TnS10pSUNs0#q29h=3DIr#Ao{g000001X)@}7Iu~Z
>
> literal 0
> HcmV?d00001
>
> diff --git a/tests/fsck-tests/063-log-missing-csum/test.sh b/tests/fsck-t=
ests/063-log-missing-csum/test.sh
> new file mode 100755
> index 00000000..40a48508
> --- /dev/null
> +++ b/tests/fsck-tests/063-log-missing-csum/test.sh
> @@ -0,0 +1,14 @@
> +#!/bin/bash
> +#
> +# Verify that check can detect missing log csum items.
> +
> +source "$TEST_TOP/common" || exit
> +
> +check_prereq btrfs
> +
> +check_image() {
> +       run_mustfail "missing log csum items not detected" \
> +               "$TOP/btrfs" check "$1"
> +}
> +
> +check_all_images
> --
> 2.45.2
>
>

