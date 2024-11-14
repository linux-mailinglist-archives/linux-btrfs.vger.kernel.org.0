Return-Path: <linux-btrfs+bounces-9659-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 800809C9042
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 17:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6E9B2BE4E
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229318755F;
	Thu, 14 Nov 2024 15:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUddkm0B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF7717B505
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599465; cv=none; b=R1HMpXgCN3oaAe63IOgCE1ayBthqN3zMyWZ8iUzhSmffwXcGpvmoSJESYfp4n9uuyKzvP/yp3fzULkzj6AqQMjLUXVwud0f9f4vICWtdTYB1HpnZcc4E3Ln4CMVX4dy3QA+0DIzk+/LqLEIF9uh2gzxES4MCQLxokspWUc1rRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599465; c=relaxed/simple;
	bh=ERUv8htP2E1T0KFseNjR/kjzTAoijs0Lto5jfW9WvpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goDlHK7MJ/9UEZoKMP9jp0GEKk7ZdgXvmZO21ZWiafbhgNqdCXwTqMQuGwI7jFlzF/0c31Qeys7UvQ4XdWOgaErnkF9slUJSKWkRTFafMeXDOWaIU7MAfxB7iGh9uoKApLFoAVj1JEFMHPMywiN5jas4ReobWVOnTSHYAH5GnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUddkm0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EF9C4CECD
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731599465;
	bh=ERUv8htP2E1T0KFseNjR/kjzTAoijs0Lto5jfW9WvpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hUddkm0BR0dStUV7P3VKgUoi4b67TJ07VPRwkBfN+gGD0VnqnL3YcDMn/r9tx3jle
	 GA79mFvluv2ac5bgOc7mFQ5Xj+E/HWbsvlgS8bESwVtFeRcTJD93nNMEXuHTlphC0Z
	 qQLm5XH4l8wOGheD8hpgSmLjvQDK7OlDcnXXLi7e4dhEoHKdpqY8+Cal3vk9SE14Id
	 0rr9b5X+q3o1cwqoKSpdMT4OQ4QY4HhNgkZp+eD56JsBj8b5JVff7FBQelF+Ux2SoQ
	 VYsER+23Go3oqeeGZ/ejNqd60gio5Y26xImOzQEa4PphZVXw6kxPJoN0dx2B0eC+1f
	 mr4rMholmoQkQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so135270866b.0
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 07:51:05 -0800 (PST)
X-Gm-Message-State: AOJu0YwEyqNeC/Dq8VfFI9Mu8YjOoNWpr7pc2f0rlWlTlrtao32F24u7
	GqY0rnQ3Fs2dtW7U0Tb4URs60epVzA9MhIfEEM62FK1LxoSEV0Q0jXw3w0bkvqCMacH3rx3l+B5
	CXGl72Y9fcPbyXIpd1NeMMWYe3EE=
X-Google-Smtp-Source: AGHT+IG6DlPUIAOU+X5waaORVkGF/aSri0xkc5Mu8nVLDEISXxAospmRkaf5jjk36A+rYXxk5HMTpxvahbtfTIFjBKY=
X-Received: by 2002:a17:907:3e1a:b0:a9e:b08e:f766 with SMTP id
 a640c23a62f3a-a9eefe9bbf7mr2369686366b.10.1731599463684; Thu, 14 Nov 2024
 07:51:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f3f2a9cdd08162a0acf0a02a7ea23cc0977d2dad.1731597571.git.josef@toxicpanda.com>
In-Reply-To: <f3f2a9cdd08162a0acf0a02a7ea23cc0977d2dad.1731597571.git.josef@toxicpanda.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 14 Nov 2024 15:50:27 +0000
X-Gmail-Original-Message-ID: <CAL3q7H40r7oBTYGd66nYuy1CbXS1Gvn9kn4DXL3_=bk46+Suog@mail.gmail.com>
Message-ID: <CAL3q7H40r7oBTYGd66nYuy1CbXS1Gvn9kn4DXL3_=bk46+Suog@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix improper generation check in snapshot delete
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 3:48=E2=80=AFPM Josef Bacik <josef@toxicpanda.com> =
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

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

> ---
> v1->v2:
> - Took Filipe's advice and moved the helper to ctree.h with the other roo=
t
>   helpers.
>
>  fs/btrfs/ctree.h       | 20 ++++++++++++++++++++
>  fs/btrfs/extent-tree.c |  6 +++---
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 317a3712270f..1f4f5df4345d 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -370,6 +370,26 @@ static inline void btrfs_set_root_last_trans(struct =
btrfs_root *root, u64 transi
>         WRITE_ONCE(root->last_trans, transid);
>  }
>
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
> +static inline u64 btrfs_root_origin_generation(const struct btrfs_root *=
root)
> +{
> +       if (btrfs_root_id(root) =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> +               return btrfs_root_last_snapshot(&root->root_item);
> +       return root->root_key.offset;
> +}
> +
>  /*
>   * Structure that conveys information about an extent that is going to r=
eplace
>   * all the extents in a file range.
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
> --
> 2.43.0
>
>

