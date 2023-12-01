Return-Path: <linux-btrfs+bounces-470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D53E9800946
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 12:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7885BB212E0
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0E8210E3;
	Fri,  1 Dec 2023 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fe6WFeUB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A441BDD9
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 11:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D6C433C7
	for <linux-btrfs@vger.kernel.org>; Fri,  1 Dec 2023 11:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701428644;
	bh=TKsACSnv2x1PwIX/iHIsA4HY/HSWyWQ8udI4o+ltB8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fe6WFeUB9LvVu1LtsOuTDCmvmxXnFddQvBOw0yWHXtRzBWPyPlkwDuoBb/075aYF+
	 CmNmEbU//YgXgH+MJRzoExfha2plD8b4FgfY1i7Czm8rHgOlmhBb9kKbVgjwg5FFYn
	 UyxAT58U442fzcN8DYDWsv52ecPxTRPW/ok7FzakzT4MPiXZ84ixBjkv28dQXSNJmq
	 p122cKOoHMyP/1rcV1PjsCemTQ54wREV9jQ9WvwJtxckmZGig2U96zmxji34QYssUJ
	 t5OX/Evvbg20/XPsjqjYeMmVv0CnSivY48oBhmehsHSLPLrSz28mz/Edlk/pAdZ9Pb
	 lYO017vtVbxHw==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a18ebac19efso269205566b.0
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Dec 2023 03:04:04 -0800 (PST)
X-Gm-Message-State: AOJu0YwNuOVC1hbvQmK5iz9O7eS8kT4PkNpuwxV9CN1/alkzuxKZDgY+
	QN0LBlDxhSMWQjQtA4BONtWXmCSAoBZNgQZWe9Q=
X-Google-Smtp-Source: AGHT+IEKrzSHtxnaRS2ZV6zZmoSOuYYFvyslKg4GYA0g4OWa9lix+RHBu4aQBF3lfS45VOVHs0hPUdGR5aqfTFRrpm8=
X-Received: by 2002:a17:906:2b4d:b0:a18:ef56:8879 with SMTP id
 b13-20020a1709062b4d00b00a18ef568879mr1523179ejg.26.1701428642517; Fri, 01
 Dec 2023 03:04:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701384168.git.dsterba@suse.com> <e283f8d460c7b3288e8eb1d8974d6b5842210167.1701384168.git.dsterba@suse.com>
In-Reply-To: <e283f8d460c7b3288e8eb1d8974d6b5842210167.1701384168.git.dsterba@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 1 Dec 2023 11:03:25 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7a0nu8xa6dNZeBzzez1D3e8dr2tUkOcaUNNnPbFJ_YLA@mail.gmail.com>
Message-ID: <CAL3q7H7a0nu8xa6dNZeBzzez1D3e8dr2tUkOcaUNNnPbFJ_YLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] btrfs: use xarray for btrfs_root::delayed_nodes_tree
 instead of radix-tree
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:56=E2=80=AFPM David Sterba <dsterba@suse.com> wr=
ote:
>
> Port btrfs_root::delayed_nodes_tree to the xarray API. The functionality
> is equivalent, the flags are still GFP_ATOMIC as the changes are done
> under a spin lock. Using a sleeping allocation would need changing the
> lock to mutex.
>
> The conversion is almost direct, btrfs_kill_all_delayed_nodes() uses an
> iterator to collect the items to delete.
>
> The patch is almost the same as 253bf57555e451 ("btrfs: turn
> delayed_nodes_tree into an XArray"), there are renames, comments and
> change of the GFP flags for xa_insert.

Can we include in the changelog why we are converting from radix tree to xa=
rray?
What do we gain with it? Why not the more recent maple tree for example?

Codewise this is about the same amount of LOCs, and I don't find it
either particularly simpler or more complex either.
Performance wise, there's no indication of anything.

It also removed the preallocation using GFP_NOFS and now depends on
atomic allocations on insertions.
This is odd because we've been making efforts over time to eliminate
atomic allocations in order to reduce the chances of allocation
failures,
yet we are now allowing for more atomic allocations without mentioning
what we gain in return.

Thanks.

>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/ctree.h         |  6 +--
>  fs/btrfs/delayed-inode.c | 80 ++++++++++++++++++++--------------------
>  fs/btrfs/disk-io.c       |  3 +-
>  fs/btrfs/inode.c         |  2 +-
>  4 files changed, 47 insertions(+), 44 deletions(-)
>
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 54fd4eb92745..70e828d33177 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -227,10 +227,10 @@ struct btrfs_root {
>         struct rb_root inode_tree;
>
>         /*
> -        * radix tree that keeps track of delayed nodes of every inode,
> -        * protected by inode_lock
> +        * Xarray that keeps track of delayed nodes of every inode, prote=
cted
> +        * by @inode_lock.
>          */
> -       struct radix_tree_root delayed_nodes_tree;
> +       struct xarray delayed_nodes;
>         /*
>          * right now this just gets used so that a root has its own devid
>          * for stat.  It may be used for more later
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index c9c4a53048a1..0437f52ca42c 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -71,7 +71,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_nod=
e(
>         }
>
>         spin_lock(&root->inode_lock);
> -       node =3D radix_tree_lookup(&root->delayed_nodes_tree, ino);
> +       node =3D xa_load(&root->delayed_nodes, ino);
>
>         if (node) {
>                 if (btrfs_inode->delayed_node) {
> @@ -83,9 +83,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_nod=
e(
>
>                 /*
>                  * It's possible that we're racing into the middle of rem=
oving
> -                * this node from the radix tree.  In this case, the refc=
ount
> +                * this node from the xarray.  In this case, the refcount
>                  * was zero and it should never go back to one.  Just ret=
urn
> -                * NULL like it was never in the radix at all; our releas=
e
> +                * NULL like it was never in the xarray at all; our relea=
se
>                  * function is in the process of removing it.
>                  *
>                  * Some implementations of refcount_inc refuse to bump th=
e
> @@ -93,7 +93,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_nod=
e(
>                  * here, refcount_inc() may decide to just WARN_ONCE() in=
stead
>                  * of actually bumping the refcount.
>                  *
> -                * If this node is properly in the radix, we want to bump=
 the
> +                * If this node is properly in the xarray, we want to bum=
p the
>                  * refcount twice, once for the inode and once for this g=
et
>                  * operation.
>                  */
> @@ -121,28 +121,29 @@ static struct btrfs_delayed_node *btrfs_get_or_crea=
te_delayed_node(
>         u64 ino =3D btrfs_ino(btrfs_inode);
>         int ret;
>
> -again:
> -       node =3D btrfs_get_delayed_node(btrfs_inode);
> -       if (node)
> -               return node;
> +       do {
> +               node =3D btrfs_get_delayed_node(btrfs_inode);
> +               if (node)
> +                       return node;
>
> -       node =3D kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
> -       if (!node)
> -               return ERR_PTR(-ENOMEM);
> -       btrfs_init_delayed_node(node, root, ino);
> +               node =3D kmem_cache_zalloc(delayed_node_cache, GFP_NOFS);
> +               if (!node)
> +                       return ERR_PTR(-ENOMEM);
> +               btrfs_init_delayed_node(node, root, ino);
>
> -       /* cached in the btrfs inode and can be accessed */
> -       refcount_set(&node->refs, 2);
> +               /* Cached in the inode and can be accessed. */
> +               refcount_set(&node->refs, 2);
>
> -       spin_lock(&root->inode_lock);
> -       ret =3D radix_tree_insert(&root->delayed_nodes_tree, ino, node);
> -       if (ret < 0) {
> -               spin_unlock(&root->inode_lock);
> -               kmem_cache_free(delayed_node_cache, node);
> -               if (ret =3D=3D -EEXIST)
> -                       goto again;
> -               return ERR_PTR(ret);
> -       }
> +               spin_lock(&root->inode_lock);
> +               ret =3D xa_insert(&root->delayed_nodes, ino, node, GFP_AT=
OMIC);
> +               if (ret < 0) {
> +                       spin_unlock(&root->inode_lock);
> +                       kmem_cache_free(delayed_node_cache, node);
> +                       if (ret !=3D -EBUSY)
> +                               return ERR_PTR(ret);
> +                       /* Otherwise it's ENOMEM. */
> +               }
> +       } while (ret < 0);
>         btrfs_inode->delayed_node =3D node;
>         spin_unlock(&root->inode_lock);
>
> @@ -263,8 +264,7 @@ static void __btrfs_release_delayed_node(
>                  * back up.  We can delete it now.
>                  */
>                 ASSERT(refcount_read(&delayed_node->refs) =3D=3D 0);
> -               radix_tree_delete(&root->delayed_nodes_tree,
> -                                 delayed_node->inode_id);
> +               xa_erase(&root->delayed_nodes, delayed_node->inode_id);
>                 spin_unlock(&root->inode_lock);
>                 kmem_cache_free(delayed_node_cache, delayed_node);
>         }
> @@ -2032,34 +2032,36 @@ void btrfs_kill_delayed_inode_items(struct btrfs_=
inode *inode)
>
>  void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
>  {
> -       u64 inode_id =3D 0;
> +       unsigned long index =3D 0;
>         struct btrfs_delayed_node *delayed_nodes[8];
> -       int i, n;
>
>         while (1) {
> +               struct btrfs_delayed_node *node;
> +               int count;
> +
>                 spin_lock(&root->inode_lock);
> -               n =3D radix_tree_gang_lookup(&root->delayed_nodes_tree,
> -                                          (void **)delayed_nodes, inode_=
id,
> -                                          ARRAY_SIZE(delayed_nodes));
> -               if (!n) {
> +               if (xa_empty(&root->delayed_nodes)) {
>                         spin_unlock(&root->inode_lock);
> -                       break;
> +                       return;
>                 }
>
> -               inode_id =3D delayed_nodes[n - 1]->inode_id + 1;
> -               for (i =3D 0; i < n; i++) {
> +               count =3D 0;
> +               xa_for_each_start(&root->delayed_nodes, index, node, inde=
x) {
>                         /*
>                          * Don't increase refs in case the node is dead a=
nd
>                          * about to be removed from the tree in the loop =
below
>                          */
> -                       if (!refcount_inc_not_zero(&delayed_nodes[i]->ref=
s))
> -                               delayed_nodes[i] =3D NULL;
> +                       if (refcount_inc_not_zero(&node->refs)) {
> +                               delayed_nodes[count] =3D node;
> +                               count++;
> +                       }
> +                       if (count >=3D ARRAY_SIZE(delayed_nodes))
> +                               break;
>                 }
>                 spin_unlock(&root->inode_lock);
> +               index++;
>
> -               for (i =3D 0; i < n; i++) {
> -                       if (!delayed_nodes[i])
> -                               continue;
> +               for (int i =3D 0; i < count; i++) {
>                         __btrfs_kill_delayed_node(delayed_nodes[i]);
>                         btrfs_release_delayed_node(delayed_nodes[i]);
>                 }
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 9317606017e2..39810120e9f9 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -655,7 +655,8 @@ static void __setup_root(struct btrfs_root *root, str=
uct btrfs_fs_info *fs_info,
>         root->nr_delalloc_inodes =3D 0;
>         root->nr_ordered_extents =3D 0;
>         root->inode_tree =3D RB_ROOT;
> -       INIT_RADIX_TREE(&root->delayed_nodes_tree, GFP_ATOMIC);
> +       /* GFP flags are compatible with XA_FLAGS_*. */
> +       xa_init_flags(&root->delayed_nodes, GFP_ATOMIC);
>
>         btrfs_init_root_block_rsv(root);
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index f8647d8271b7..41c904530eaa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3805,7 +3805,7 @@ static int btrfs_read_locked_inode(struct inode *in=
ode,
>          * cache.
>          *
>          * This is required for both inode re-read from disk and delayed =
inode
> -        * in delayed_nodes_tree.
> +        * in the delayed_nodes xarray.
>          */
>         if (BTRFS_I(inode)->last_trans =3D=3D btrfs_get_fs_generation(fs_=
info))
>                 set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> --
> 2.42.1
>
>

