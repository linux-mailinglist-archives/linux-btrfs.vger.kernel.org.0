Return-Path: <linux-btrfs+bounces-21553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDcYKfYBimluFQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21553-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 16:49:10 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2B6112277
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 16:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8ED8F3082987
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 15:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018C3803C0;
	Mon,  9 Feb 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph5Is12Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADD37FF72
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651733; cv=none; b=Xb4/ZhUiK+js/fJL+KCUspyhl92ymyZzsNJLSW/SuSAh1h0I9Tkx9Xvko9r+yZVm0TaPTD47/1rLZoR9n8qkpFddukab92m10TR2d4I0O9bgE4847V3QhCE0CoOCiN7e1VZQgw6k79pQc4pSGRHfOdm0qk/ubxUcQObeF0eTYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651733; c=relaxed/simple;
	bh=rxR6Ecl1M/4Ug+jauhWPcYgCxxZXEOEAu25aJdz8vr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=vEbJ04t9Q/31TP7Z5C0HFFGtu8mLcTsphj0ZekNanl8T1WR7eX5KAdJR4w47/BZ64Gq7T5FkLxjpbnK5WplVJ+hyOL/aJm3IAbJ3CKXwi7jdEZIXU10b/Sr2SEXxRmsMZosVAVWTYnsTGIwEen6Qt8BQg7jXZJ0+FxiI52tJ0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ph5Is12Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2D7C16AAE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770651732;
	bh=rxR6Ecl1M/4Ug+jauhWPcYgCxxZXEOEAu25aJdz8vr0=;
	h=References:In-Reply-To:From:Date:Subject:To:From;
	b=ph5Is12YjE3H7B+9Fa4B91n18zc3tGNp55RELq/qBO0Jz5oGMzAESqiSgPfpsZaRn
	 FkDlClq83oL/0EmD61PnmZ1ykcIqy98GKFi1GI/dmQY3QdCkS+GbreZdnuD4JvdfWh
	 jBbtJb1sMm4JeW/cJ+FOdpa/2sPTDBpaJjZmKU4QOKmBE5nmDFphum1EJ4WpiMKsO5
	 Tc1RRQciOVuNQuyAPQ69gFb6uyJIU+kgnVl4cXSmQTz0rrK++2si+YAEvsfu93ah0L
	 zpNCzS2H983znsdbqd+it5NNVBRNhd2XYV799RppU6cFjt5jCvJaE2IRrGoKE7R7ts
	 how/l40p75UBQ==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8870ac4c4eso492948666b.2
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Feb 2026 07:42:12 -0800 (PST)
X-Gm-Message-State: AOJu0Yyw1O7D/zElqnQWB/0AN9XvcBaYCFzkI4gRb9bLCsoVW0r85Zwa
	XS99BBtH6CyQ+vBirPlz+hmyizCLRDjjFGEAHHamhm6LUaB63du3eRdx7lzIB+K5VkOf4fMc/Wt
	lFDlIv0FVAk6T/wojRhzlVSpY7EhHD7I=
X-Received: by 2002:a17:907:a43:b0:b83:e7e:3732 with SMTP id
 a640c23a62f3a-b8edf350ab9mr715285566b.30.1770651730985; Mon, 09 Feb 2026
 07:42:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770580436.git.fdmanana@suse.com> <0f57b1b3bcd514fc65690a93ec694ef732d46985.1770580436.git.fdmanana@suse.com>
In-Reply-To: <0f57b1b3bcd514fc65690a93ec694ef732d46985.1770580436.git.fdmanana@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 9 Feb 2026 15:41:34 +0000
X-Gmail-Original-Message-ID: <CAL3q7H691QAAk+e36NOKfJ9DThV+GGNHmyYeMuvCCzxX1H3HiA@mail.gmail.com>
X-Gm-Features: AZwV_QhHDeBGe0tOFiWQktIxJsx9VsmvgY6mE22TzeGiEgCFLy-HWS743bbOfmI
Message-ID: <CAL3q7H691QAAk+e36NOKfJ9DThV+GGNHmyYeMuvCCzxX1H3HiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: check for NULL root after calls to btrfs_extent_root()
To: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21553-lists,linux-btrfs=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,meta.com:email]
X-Rspamd-Queue-Id: DE2B6112277
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 8:01=E2=80=AFPM <fdmanana@kernel.org> wrote:
>
> From: Filipe Manana <fdmanana@suse.com>
>
> btrfs_extent_root() can return a NULL pointer in case the root we are
> looking for is not in the rb tree that tracks roots. So add checks to
> every caller that is missing such check to log a message and return
> an error. The same applies to callers of btrfs_block_group_root(),
> since it calls btrfs_extent_root().
>
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208161657.3972997-1-clm@me=
ta.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/backref.c         | 28 ++++++++++++++
>  fs/btrfs/block-group.c     | 36 ++++++++++++++++++
>  fs/btrfs/disk-io.c         | 13 ++++++-
>  fs/btrfs/extent-tree.c     | 78 ++++++++++++++++++++++++++++++++++++--
>  fs/btrfs/free-space-tree.c |  7 ++++
>  fs/btrfs/qgroup.c          |  8 ++++
>  fs/btrfs/relocation.c      | 22 ++++++++++-
>  fs/btrfs/zoned.c           |  7 ++++
>  8 files changed, 192 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> index 9bb406f7dd30..7921a926f676 100644
> --- a/fs/btrfs/backref.c
> +++ b/fs/btrfs/backref.c
> @@ -1393,6 +1393,13 @@ static int find_parent_nodes(struct btrfs_backref_=
walk_ctx *ctx,
>                 .indirect_missing_keys =3D PREFTREE_INIT
>         };
>
> +       if (unlikely(!root)) {
> +               btrfs_err(ctx->fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         ctx->bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         /* Roots ulist is not needed when using a sharedness check contex=
t. */
>         if (sc)
>                 ASSERT(ctx->roots =3D=3D NULL);
> @@ -2204,6 +2211,13 @@ int extent_from_logical(struct btrfs_fs_info *fs_i=
nfo, u64 logical,
>         struct btrfs_extent_item *ei;
>         struct btrfs_key key;
>
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         logical);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D logical;
>         if (btrfs_fs_incompat(fs_info, SKINNY_METADATA))
>                 key.type =3D BTRFS_METADATA_ITEM_KEY;
> @@ -2851,6 +2865,13 @@ int btrfs_backref_iter_start(struct btrfs_backref_=
iter *iter, u64 bytenr)
>         struct btrfs_key key;
>         int ret;
>
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         key.type =3D BTRFS_METADATA_ITEM_KEY;
>         key.offset =3D (u64)-1;
> @@ -2987,6 +3008,13 @@ int btrfs_backref_iter_next(struct btrfs_backref_i=
ter *iter)
>
>         /* We're at keyed items, there is no inline item, go to the next =
one */
>         extent_root =3D btrfs_extent_root(iter->fs_info, iter->bytenr);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(iter->fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         iter->bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         ret =3D btrfs_next_item(extent_root, iter->path);
>         if (ret)
>                 return ret;
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 17a18f17538d..36ff6c5a8f51 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -738,6 +738,12 @@ static int load_extent_tree_free(struct btrfs_cachin=
g_control *caching_ctl)
>                 return -ENOMEM;
>
>         extent_root =3D btrfs_extent_root(fs_info, last);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for block group at offset =
%llu",
> +                         block_group->start);
> +               return -EUCLEAN;
> +       }
>
>  #ifdef CONFIG_BTRFS_DEBUG
>         /*
> @@ -1060,6 +1066,11 @@ static int remove_block_group_item(struct btrfs_tr=
ans_handle *trans,
>         int ret;
>
>         root =3D btrfs_block_group_root(fs_info);
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info, "missing block group root");
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D block_group->start;
>         key.type =3D BTRFS_BLOCK_GROUP_ITEM_KEY;
>         key.offset =3D block_group->length;
> @@ -1348,6 +1359,11 @@ struct btrfs_trans_handle *btrfs_start_trans_remov=
e_block_group(
>         struct btrfs_chunk_map *map;
>         unsigned int num_items;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info, "missing block group root");
> +               return ERR_PTR(-EUCLEAN);
> +       }
> +
>         map =3D btrfs_find_chunk_map(fs_info, chunk_offset, 1);
>         ASSERT(map !=3D NULL);
>         ASSERT(map->start =3D=3D chunk_offset);
> @@ -2139,6 +2155,11 @@ static int find_first_block_group(struct btrfs_fs_=
info *fs_info,
>         int ret;
>         struct btrfs_key found_key;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info, "missing block group root");
> +               return -EUCLEAN;
> +       }
> +
>         btrfs_for_each_slot(root, key, &found_key, path, ret) {
>                 if (found_key.objectid >=3D key->objectid &&
>                     found_key.type =3D=3D BTRFS_BLOCK_GROUP_ITEM_KEY) {
> @@ -2713,6 +2734,11 @@ static int insert_block_group_item(struct btrfs_tr=
ans_handle *trans,
>         size_t size;
>         int ret;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info, "missing block group root");
> +               return -EUCLEAN;
> +       }
> +
>         spin_lock(&block_group->lock);
>         btrfs_set_stack_block_group_v2_used(&bgi, block_group->used);
>         btrfs_set_stack_block_group_v2_chunk_objectid(&bgi, block_group->=
global_root_id);
> @@ -3048,6 +3074,11 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gr=
oup *cache,
>         int ret;
>         bool dirty_bg_running;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info, "missing block group root");
> +               return -EUCLEAN;
> +       }
> +
>         /*
>          * This can only happen when we are doing read-only scrub on read=
-only
>          * mount.
> @@ -3192,6 +3223,11 @@ static int update_block_group_item(struct btrfs_tr=
ans_handle *trans,
>         u64 used, remap_bytes;
>         u32 identity_remap_count;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info, "missing block group root");
> +               return -EUCLEAN;
> +       }
> +
>         /*
>          * Block group items update can be triggered out of commit transa=
ction
>          * critical section, thus we need a consistent view of used bytes=
.
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 67117e7516bf..1194cb182a91 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -1591,7 +1591,7 @@ static int find_newest_super_backup(struct btrfs_fs=
_info *info)
>   * this will bump the backup pointer by one when it is
>   * done
>   */
> -static void backup_super_roots(struct btrfs_fs_info *info)
> +static int backup_super_roots(struct btrfs_fs_info *info)
>  {
>         const int next_backup =3D info->backup_root_index;
>         struct btrfs_root_backup *root_backup;
> @@ -1623,6 +1623,11 @@ static void backup_super_roots(struct btrfs_fs_inf=
o *info)
>                 struct btrfs_root *extent_root =3D btrfs_extent_root(info=
, 0);
>                 struct btrfs_root *csum_root =3D btrfs_csum_root(info, 0)=
;
>
> +               if (unlikely(!extent_root)) {
> +                       btrfs_err(info, "missing extent root for extent a=
t bytenr 0");
> +                       return -EUCLEAN;
> +               }
> +
>                 btrfs_set_backup_extent_root(root_backup,
>                                              extent_root->node->start);
>                 btrfs_set_backup_extent_root_gen(root_backup,
> @@ -1670,6 +1675,8 @@ static void backup_super_roots(struct btrfs_fs_info=
 *info)
>         memcpy(&info->super_copy->super_roots,
>                &info->super_for_commit->super_roots,
>                sizeof(*root_backup) * BTRFS_NUM_BACKUP_ROOTS);
> +
> +       return 0;
>  }
>
>  /*
> @@ -4032,7 +4039,9 @@ int write_all_supers(struct btrfs_trans_handle *tra=
ns)
>         } else {
>                 /* We are called from transaction commit. */
>                 max_mirrors =3D BTRFS_SUPER_MIRROR_MAX;
> -               backup_super_roots(fs_info);
> +               ret =3D backup_super_roots(fs_info);
> +               if (ret < 0)
> +                       return ret;
>         }
>
>         sb =3D fs_info->super_for_commit;
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 01bbe3cae5c2..331263c206af 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -75,6 +75,12 @@ int btrfs_lookup_data_extent(struct btrfs_fs_info *fs_=
info, u64 start, u64 len)
>         struct btrfs_key key;
>         BTRFS_PATH_AUTO_FREE(path);
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, start);
> +               return -EUCLEAN;
> +       }
> +
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
> @@ -131,6 +137,12 @@ int btrfs_lookup_extent_info(struct btrfs_trans_hand=
le *trans,
>         key.offset =3D offset;
>
>         extent_root =3D btrfs_extent_root(fs_info, bytenr);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         ret =3D btrfs_search_slot(NULL, extent_root, &key, path, 0, 0);
>         if (ret < 0)
>                 return ret;
> @@ -436,6 +448,12 @@ static noinline int lookup_extent_data_ref(struct bt=
rfs_trans_handle *trans,
>         int recow;
>         int ret;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(trans->fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         if (parent) {
>                 key.type =3D BTRFS_SHARED_DATA_REF_KEY;
> @@ -510,6 +528,12 @@ static noinline int insert_extent_data_ref(struct bt=
rfs_trans_handle *trans,
>         u32 num_refs;
>         int ret;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(trans->fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         if (node->parent) {
>                 key.type =3D BTRFS_SHARED_DATA_REF_KEY;
> @@ -668,6 +692,12 @@ static noinline int lookup_tree_block_ref(struct btr=
fs_trans_handle *trans,
>         struct btrfs_key key;
>         int ret;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(trans->fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         if (parent) {
>                 key.type =3D BTRFS_SHARED_BLOCK_REF_KEY;
> @@ -692,6 +722,12 @@ static noinline int insert_tree_block_ref(struct btr=
fs_trans_handle *trans,
>         struct btrfs_key key;
>         int ret;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(trans->fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         if (node->parent) {
>                 key.type =3D BTRFS_SHARED_BLOCK_REF_KEY;
> @@ -782,6 +818,12 @@ int lookup_inline_extent_backref(struct btrfs_trans_=
handle *trans,
>         bool skinny_metadata =3D btrfs_fs_incompat(fs_info, SKINNY_METADA=
TA);
>         int needed;
>
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         key.type =3D BTRFS_EXTENT_ITEM_KEY;
>         key.offset =3D num_bytes;
> @@ -1680,6 +1722,12 @@ static int run_delayed_extent_op(struct btrfs_tran=
s_handle *trans,
>         }
>
>         root =3D btrfs_extent_root(fs_info, key.objectid);
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         key.objectid);
> +               return -EUCLEAN;
> +       }
>  again:
>         ret =3D btrfs_search_slot(trans, root, &key, path, 0, 1);
>         if (ret < 0) {
> @@ -2379,6 +2427,12 @@ static noinline int check_committed_ref(struct btr=
fs_inode *inode,
>         int type;
>         int ret;
>
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
> +
>         key.objectid =3D bytenr;
>         key.type =3D BTRFS_EXTENT_ITEM_KEY;
>         key.offset =3D (u64)-1;
> @@ -3222,7 +3276,11 @@ static int __btrfs_free_extent(struct btrfs_trans_=
handle *trans,
>         u64 delayed_ref_root =3D href->owning_root;
>
>         extent_root =3D btrfs_extent_root(info, bytenr);
> -       ASSERT(extent_root);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(info,
> +                         "missing extent root for extent at bytenr %llu"=
, bytenr);
> +               return -EUCLEAN;
> +       }
>
>         path =3D btrfs_alloc_path();
>         if (!path)
> @@ -4935,11 +4993,18 @@ static int alloc_reserved_file_extent(struct btrf=
s_trans_handle *trans,
>                 size +=3D btrfs_extent_inline_ref_size(BTRFS_EXTENT_OWNER=
_REF_KEY);
>         size +=3D btrfs_extent_inline_ref_size(type);
>
> +       extent_root =3D btrfs_extent_root(fs_info, ins->objectid);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         ins->objectid);
> +               return -EUCLEAN;
> +       }
> +
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
>
> -       extent_root =3D btrfs_extent_root(fs_info, ins->objectid);
>         ret =3D btrfs_insert_empty_item(trans, extent_root, path, ins, si=
ze);
>         if (ret) {
>                 btrfs_free_path(path);
> @@ -5015,11 +5080,18 @@ static int alloc_reserved_tree_block(struct btrfs=
_trans_handle *trans,
>                 size +=3D sizeof(*block_info);
>         }
>
> +       extent_root =3D btrfs_extent_root(fs_info, extent_key.objectid);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         extent_key.objectid);
> +               return -EUCLEAN;
> +       }
> +
>         path =3D btrfs_alloc_path();
>         if (!path)
>                 return -ENOMEM;
>
> -       extent_root =3D btrfs_extent_root(fs_info, extent_key.objectid);
>         ret =3D btrfs_insert_empty_item(trans, extent_root, path, &extent=
_key,
>                                       size);
>         if (ret) {
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index ecddfca92b2b..f5caa0da5214 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1087,6 +1087,13 @@ static int populate_free_space_tree(struct btrfs_t=
rans_handle *trans,
>         key.offset =3D 0;
>
>         extent_root =3D btrfs_extent_root(trans->fs_info, key.objectid);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(trans->fs_info,
> +                         "missing extent root for block group at offset =
%llu",
> +                         key.objectid);
> +               return -EUCLEAN;

Misses a:

mutex_unlock(&block_group->free_space_lock);

Will add to v2 or update before picking into for-next.

> +       }
> +
>         ret =3D btrfs_search_slot_for_read(extent_root, &key, path, 1, 0)=
;
>         if (ret < 0)
>                 goto out_locked;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index f53c313ab6e4..8eb7739a381f 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3737,6 +3737,14 @@ static int qgroup_rescan_leaf(struct btrfs_trans_h=
andle *trans,
>         mutex_lock(&fs_info->qgroup_rescan_lock);
>         extent_root =3D btrfs_extent_root(fs_info,
>                                 fs_info->qgroup_rescan_progress.objectid)=
;
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         fs_info->qgroup_rescan_progress.objectid);
> +               mutex_unlock(&fs_info->qgroup_rescan_lock);
> +               return -EUCLEAN;
> +       }
> +
>         ret =3D btrfs_search_slot_for_read(extent_root,
>                                          &fs_info->qgroup_rescan_progress=
,
>                                          path, 1, 0);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index fcd0a2ba3554..14de065e79fc 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -4949,6 +4949,12 @@ static int do_remap_reloc_trans(struct btrfs_fs_in=
fo *fs_info,
>         struct btrfs_space_info *sinfo =3D src_bg->space_info;
>
>         extent_root =3D btrfs_extent_root(fs_info, src_bg->start);
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for block group at offset =
%llu",
> +                         src_bg->start);
> +               return -EUCLEAN;
> +       }
>
>         trans =3D btrfs_start_transaction(extent_root, 0);
>         if (IS_ERR(trans))
> @@ -5301,6 +5307,13 @@ int btrfs_relocate_block_group(struct btrfs_fs_inf=
o *fs_info, u64 group_start,
>         int ret;
>         bool bg_is_ro =3D false;
>
> +       if (unlikely(!extent_root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for block group at offset =
%llu",
> +                         group_start);
> +               return -EUCLEAN;
> +       }
> +
>         /*
>          * This only gets set if we had a half-deleted snapshot on mount.=
  We
>          * cannot allow relocation to start while we're still trying to c=
lean up
> @@ -5531,12 +5544,17 @@ int btrfs_recover_relocation(struct btrfs_fs_info=
 *fs_info)
>                 goto out;
>         }
>
> +       rc->extent_root =3D btrfs_extent_root(fs_info, 0);
> +       if (unlikely(!rc->extent_root)) {
> +               btrfs_err(fs_info, "missing extent root for extent at byt=
enr 0");
> +               ret =3D -EUCLEAN;
> +               goto out;
> +       }
> +
>         ret =3D reloc_chunk_start(fs_info);
>         if (ret < 0)
>                 goto out_end;
>
> -       rc->extent_root =3D btrfs_extent_root(fs_info, 0);
> -
>         set_reloc_control(rc);
>
>         trans =3D btrfs_join_transaction(rc->extent_root);
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index ae6f61bcefca..4a1dabeea531 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1259,6 +1259,13 @@ static int calculate_alloc_pointer(struct btrfs_bl=
ock_group *cache,
>         key.offset =3D 0;
>
>         root =3D btrfs_extent_root(fs_info, key.objectid);
> +       if (unlikely(!root)) {
> +               btrfs_err(fs_info,
> +                         "missing extent root for extent at bytenr %llu"=
,
> +                         key.objectid);
> +               return -EUCLEAN;
> +       }
> +
>         ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
>         /* We should not find the exact match */
>         if (unlikely(!ret))
> --
> 2.47.2
>
>

