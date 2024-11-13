Return-Path: <linux-btrfs+bounces-9603-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDC9C791B
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 17:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538B6285A04
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44351DEFC1;
	Wed, 13 Nov 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWrkEfra"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E71632E5
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516200; cv=none; b=JgobgxLg68P7n6voDxQBewd5gE6bcBJRvC5UrX6lBaDlvvPEQ1AiPdd1ARxV4/7p448/+xAWuXHuR5ieNhnfNZd2fzwPF6zerF+jXiWQGhHxdsU3MBzZD8wrfYZxasrlQleCQsimcXhDtnDslQ8TYXKQVVtikA2fsPKck91Gn7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516200; c=relaxed/simple;
	bh=qlPT4vQugIDHW+krYG6icsaEOUB+kdIUGry0T4gbRxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t++AyNxjiB766eKfzzDGXlXbO6h1jELfBY5AOXo0gpj1Zf9xO6JAgUEK5DbIaQnT7mhFnRmfelM84PruAiZl3tX3tuYJjjs3XSNRP85YyBC+1sXj0avGltlSGYLeKsmlAdU8F8nLsn4qJrTobCWWm0aM9+gLtiiJhxJ+QNRUup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWrkEfra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A94C4CECF
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 16:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731516199;
	bh=qlPT4vQugIDHW+krYG6icsaEOUB+kdIUGry0T4gbRxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dWrkEfratZl++7B9cdS2d8uRlOVZ1zDw4evfQ3ZWnvuYtO1PoTYIxXbRZIRzhvt+m
	 DIxNMnSy7LoNdb3ldDbu3dZWQkI8ri3hwTTZ94kP1+Lr7R8XdrXSq0zQp//pIvnBU9
	 0HyBubcIrFkhapvacaT0Oz740qmJq3rVir3BWQo+VH89Vg5Lat8Y3eeDD9qOq6+glX
	 6amkGpKxFyd8Y1Q380MBbjZVdeLUafX8YukZnGhClb554wCM+n0XZwr5teCwhTr7uM
	 IbIGNo/S0/z04h7/dqCmrD3TeRyZGcdhJT6Z5oD0/gnHKGg/QOS5Usvn9T+Kc41BAf
	 Ca18NagHVwqOw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cf745608c8so230004a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 08:43:19 -0800 (PST)
X-Gm-Message-State: AOJu0YwLJ3q/l2SDqIE3qWuPzrF+aJGzAt3hnLrmJCdrFZVy6GHX7hSg
	TPgQx6yXVoOmXMbjhMx5jEOnSxCPA+MCPT+V2fDg04aDEo+NxAMmYAXurEmQZCgRrU+E0DRKWo2
	2bNz41O4BXEXrmE0GWmbMGygJd9o=
X-Google-Smtp-Source: AGHT+IGjenxDDCsX0mSUSk93lAJbWegQtAkJ5lkF02W/7dwOJMwmSzyjQd/uK+fx1stUx6g48mLUXAc2gRIuZDAyksE=
X-Received: by 2002:a17:906:6a1c:b0:a99:6791:5449 with SMTP id
 a640c23a62f3a-a9ef0019165mr2143371866b.52.1731516197847; Wed, 13 Nov 2024
 08:43:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b1b8f27cad83060a4157af8f7514681a85956549.1731515508.git.josef@toxicpanda.com>
In-Reply-To: <b1b8f27cad83060a4157af8f7514681a85956549.1731515508.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 13 Nov 2024 16:42:40 +0000
X-Gmail-Original-Message-ID: <CAL3q7H71cVf-aetLvCOBQqxE=iRpB=Vsg_LyyPeNqXe2abthgg@mail.gmail.com>
Message-ID: <CAL3q7H71cVf-aetLvCOBQqxE=iRpB=Vsg_LyyPeNqXe2abthgg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix improper generation check in snapshot delete
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 4:32=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
wrote:
>
> We have been using the following check
>
> if (generation <=3D root->root_key.offset)
>
> to make decisions about whether or not to visit a node during snapshot
> delete.  This is because for normal subvolumes this is set to 0, and for
> snapshots it's set to the creation generation.  The idea being that if
> the generation of the node is less than or equal to our creation
> generation then we don't need to visit that node, because it doesn't
> belong to us, we can simply drop our reference and move on.
>
> However reloc roots don't have their generation stored in
> root->root_key.offset, instead that is the objectid of their
> corresponding fs root.  This means we can incorrectly not walk into
> nodes that need to be dropped when deleting a reloc root.
>
> There are a variety of consequences to making the wrong choice in two
> distinct areas.
>
> visit_node_for_delete()
>
> 1. False positive.  We think we are newer than the block when we really
>    aren't.  We don't visit the node and drop our reference to the node
>    and carry on.  This would result in leaked space.
> 2. False negative.  We do decide to walk down into a block that we
>    should have just dropped our reference to.  However this means that
>    the child node will have refs > 1, so we will switch to
>    UPDATE_BACKREF, and then the subsequent walk_down_proc will notice
>    that btrfs_header_owner(node) !=3D root->root_key.objectid and it'll
>    break out of the loop, and then walk_up_proc will drop our reference,
>    so this appears to be ok.
>
> do_walk_down()
>
> 1. False positive.  We are in UPDATE_BACKREF and incorrectly decide that
>    we are done and don't need to update the backref for our lower nodes.
>    This is another case that simply won't happen with relocation, as we
>    only have to do UPDATE_BACKREF if the node below us was shared and
>    didn't have FULL_BACKREF set, and since we don't own that node
>    because we're a reloc root we actually won't end up in this case.
> 2. False negative.  Again this is tricky because as described above, we
>    simply wouldn't be here from relocation, because we don't own any of
>    the nodes because we never set btrfs_header_owner() to the reloc root
>    objectid, and we always use FULL_BACKREF, we never actually need to
>    set FULL_BACKREF on any children.
>
> Having spent a lot of time stressing relocation/snapshot delete recently
> I've not seen this pop in practice.  But this is objectively incorrect,
> so fix this to get the correct starting generation based on the root
> we're dropping to keep me from thinking there's a problem here.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/extent-tree.c |  6 +++---
>  fs/btrfs/root-tree.c   | 20 ++++++++++++++++++++
>  fs/btrfs/root-tree.h   |  1 +
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 412e318e4a22..43a771f7bd7a 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5285,7 +5285,7 @@ static bool visit_node_for_delete(struct btrfs_root=
 *root, struct walk_control *
>          * reference to it.
>          */
>         generation =3D btrfs_node_ptr_generation(eb, slot);
> -       if (!wc->update_ref || generation <=3D root->root_key.offset)
> +       if (!wc->update_ref || generation <=3D btrfs_root_origin_generati=
on(root))
>                 return false;
>
>         /*
> @@ -5340,7 +5340,7 @@ static noinline void reada_walk_down(struct btrfs_t=
rans_handle *trans,
>                         goto reada;
>
>                 if (wc->stage =3D=3D UPDATE_BACKREF &&
> -                   generation <=3D root->root_key.offset)
> +                   generation <=3D btrfs_root_origin_generation(root))
>                         continue;
>
>                 /* We don't lock the tree block, it's OK to be racy here =
*/
> @@ -5683,7 +5683,7 @@ static noinline int do_walk_down(struct btrfs_trans=
_handle *trans,
>          * for the subtree
>          */
>         if (wc->stage =3D=3D UPDATE_BACKREF &&
> -           generation <=3D root->root_key.offset) {
> +           generation <=3D btrfs_root_origin_generation(root)) {
>                 wc->lookup_info =3D 1;
>                 return 1;
>         }
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 33962671a96c..017a155ffd5e 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -547,3 +547,23 @@ int btrfs_subvolume_reserve_metadata(struct btrfs_ro=
ot *root,
>         }
>         return ret;
>  }
> +
> +/*
> + * btrfs_root_start_generation - return the generation this root started=
 with.
> + * @root - the root we're chcking
> + *
> + * Every normal root that is created with root->root_key.offset set to i=
t's
> + * originating generation.  If it is a snapshot it is the generation whe=
n the
> + * snapshot was created.
> + *
> + * However for TREE_RELOC roots root_key.offset is the objectid of the o=
wning
> + * tree root.  Thankfully we copy the root item of the owning tree root,=
 which
> + * has it's last_snapshot set to what we would have root_key.offset set =
to, so
> + * return that if we are a TREE_RELOC root.
> + */
> +u64 btrfs_root_origin_generation(struct btrfs_root *root)

The root argument can be made const.

> +{
> +       if (btrfs_root_id(root) =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> +               return btrfs_root_last_snapshot(&root->root_item);
> +       return root->root_key.offset;

This is so small and trivial that it could be instead a static inline
function at fs.h.

Also having this in root-tree.c/h is a bit odd since this is generic
and actually never used against the root tree but subvolume/snapshot
and relocation roots.
So one more reason to make it static inline and place it at fs.h,
where we have btrfs_root_id() and other generic root related
functions.

Otherwise it looks fine, thanks.

> +}
> diff --git a/fs/btrfs/root-tree.h b/fs/btrfs/root-tree.h
> index 8f5739e732b9..030b74e821e4 100644
> --- a/fs/btrfs/root-tree.h
> +++ b/fs/btrfs/root-tree.h
> @@ -38,5 +38,6 @@ void btrfs_set_root_node(struct btrfs_root_item *item,
>                          struct extent_buffer *node);
>  void btrfs_check_and_init_root_item(struct btrfs_root_item *item);
>  void btrfs_update_root_times(struct btrfs_trans_handle *trans, struct bt=
rfs_root *root);
> +u64 btrfs_root_origin_generation(struct btrfs_root *root);
>
>  #endif
> --
> 2.43.0
>
>

