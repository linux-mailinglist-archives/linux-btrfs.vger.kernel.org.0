Return-Path: <linux-btrfs+bounces-717-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3A88074CD
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231D5B20EBF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Dec 2023 16:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E840147760;
	Wed,  6 Dec 2023 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv3LSJHJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5554654D
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 16:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384D0C433CC
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 16:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701879616;
	bh=iRu07gZ5rqoIqAaTD2fkl/GXwlrJWKF+WrKUR1Om+Tw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qv3LSJHJym/RhYqUnj3nOFXQIqx2tLGW6b+K0NkG1ABxMhzGEeFIdYlvZpla4krOx
	 ov3ByVyAR1E/hoBH/7wPdtXiC+U7OHQpdzr7Vur75cKXcYf1N1xr8TcYAnrX6peVyI
	 kiz2g6gbDkUsHZo1GvqcTw1rUz7Ab4QYUtRXQK6pLoAjVFg+tSAj+x52reYTaq4YSL
	 309WknVa339qOYqg9RASF6rD0wfP8qvxHbQNUzm9nDecpqOLZEWI8Lcees01j/CY/T
	 ld/QZfHNSe6FFnqRRbIZ6n64vpHiR/WvSQxU0gwaqOQQdUvVl3JS4cWpcvBmLJxYgy
	 CjtwLvbNhRYdQ==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54cc60f3613so4831108a12.2
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Dec 2023 08:20:16 -0800 (PST)
X-Gm-Message-State: AOJu0Yy5am+90BqzQWHalXcQ/kW+h0PrRBBRYSMmr/I84A9ddeOYD5lC
	TYATf5te85vGfnPNfTqK6gEC+M1TAHNMOFg7wbY=
X-Google-Smtp-Source: AGHT+IEslth7tPUcpXH5XOo2TTskyskIaqVWmM6kHqnXUODNW88tJ59frnq/veuBK1+A7gBpvdDoRgMK6pMZAy/oyIw=
X-Received: by 2002:a17:907:1003:b0:a12:bde:7acc with SMTP id
 ox3-20020a170907100300b00a120bde7accmr817484ejb.67.1701879614603; Wed, 06 Dec
 2023 08:20:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701871671.git.dsterba@suse.com> <c8269e17d8295c223043c2b6bc09b04beab52a18.1701871671.git.dsterba@suse.com>
 <CAL3q7H7c2_iKtO6sRrfNtV3kZbRYUHJ777JdJkh+gSKt=jr+rA@mail.gmail.com>
In-Reply-To: <CAL3q7H7c2_iKtO6sRrfNtV3kZbRYUHJ777JdJkh+gSKt=jr+rA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 6 Dec 2023 16:19:37 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7VKyC8wF5mV4jqz5djFp74g5z+J3ZpKZtaY4Xhx8W9sA@mail.gmail.com>
Message-ID: <CAL3q7H7VKyC8wF5mV4jqz5djFp74g5z+J3ZpKZtaY4Xhx8W9sA@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] btrfs: switch btrfs_root::delayed_nodes_tree to
 xarray from radix-tree
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 3:52=E2=80=AFPM Filipe Manana <fdmanana@kernel.org> =
wrote:
>
> On Wed, Dec 6, 2023 at 2:23=E2=80=AFPM David Sterba <dsterba@suse.com> wr=
ote:
> >
> > The radix-tree has been superseded by the xarray
> > (https://lwn.net/Articles/745073), this patch converts the
> > btrfs_root::delayed_nodes, the APIs are used in a simple way.
> >
> > First idea is to do xa_insert() but this would require GFP_ATOMIC
> > allocation which we want to avoid if possible. The preload mechanism of
> > radix-tree can be emulated within the xarray API.
> >
> > - xa_reserve() with GFP_NOFS outside of the lock, the reserved entry
> >   is inserted atomically at most once
> >
> > - xa_store() under a lock, in case something races in we can detect tha=
t
> >   and xa_load() returns a valid pointer
> >
> > All uses of xa_load() must check for a valid pointer in case they manag=
e
> > to get between the xa_reserve() and xa_store(), this is handled in
> > btrfs_get_delayed_node().
> >
> > Otherwise the functionality is equivalent, xarray implements the
> > radix-tree and there should be no performance difference.
> >
> > The patch continues the efforts started in 253bf57555e451 ("btrfs: turn
> > delayed_nodes_tree into an XArray") and fixes the problems with locking
> > and GFP flags 088aea3b97e0ae ("Revert "btrfs: turn delayed_nodes_tree
> > into an XArray"").
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >  fs/btrfs/ctree.h         |  6 ++--
> >  fs/btrfs/delayed-inode.c | 64 ++++++++++++++++++++++------------------
> >  fs/btrfs/disk-io.c       |  3 +-
> >  fs/btrfs/inode.c         |  2 +-
> >  4 files changed, 41 insertions(+), 34 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 54fd4eb92745..70e828d33177 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -227,10 +227,10 @@ struct btrfs_root {
> >         struct rb_root inode_tree;
> >
> >         /*
> > -        * radix tree that keeps track of delayed nodes of every inode,
> > -        * protected by inode_lock
> > +        * Xarray that keeps track of delayed nodes of every inode, pro=
tected
> > +        * by @inode_lock.
> >          */
> > -       struct radix_tree_root delayed_nodes_tree;
> > +       struct xarray delayed_nodes;
> >         /*
> >          * right now this just gets used so that a root has its own dev=
id
> >          * for stat.  It may be used for more later
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 91159dd7355b..0247faf5bb01 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -71,7 +71,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_n=
ode(
> >         }
> >
> >         spin_lock(&root->inode_lock);
> > -       node =3D radix_tree_lookup(&root->delayed_nodes_tree, ino);
> > +       node =3D xa_load(&root->delayed_nodes, ino);
> >
> >         if (node) {
> >                 if (btrfs_inode->delayed_node) {
> > @@ -83,9 +83,9 @@ static struct btrfs_delayed_node *btrfs_get_delayed_n=
ode(
> >
> >                 /*
> >                  * It's possible that we're racing into the middle of r=
emoving
> > -                * this node from the radix tree.  In this case, the re=
fcount
> > +                * this node from the xarray.  In this case, the refcou=
nt
> >                  * was zero and it should never go back to one.  Just r=
eturn
> > -                * NULL like it was never in the radix at all; our rele=
ase
> > +                * NULL like it was never in the xarray at all; our rel=
ease
> >                  * function is in the process of removing it.
> >                  *
> >                  * Some implementations of refcount_inc refuse to bump =
the
> > @@ -93,7 +93,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_n=
ode(
> >                  * here, refcount_inc() may decide to just WARN_ONCE() =
instead
> >                  * of actually bumping the refcount.
> >                  *
> > -                * If this node is properly in the radix, we want to bu=
mp the
> > +                * If this node is properly in the xarray, we want to b=
ump the
> >                  * refcount twice, once for the inode and once for this=
 get
> >                  * operation.
> >                  */
> > @@ -120,6 +120,7 @@ static struct btrfs_delayed_node *btrfs_get_or_crea=
te_delayed_node(
> >         struct btrfs_root *root =3D btrfs_inode->root;
> >         u64 ino =3D btrfs_ino(btrfs_inode);
> >         int ret;
> > +       void *ptr;
> >
> >  again:
> >         node =3D btrfs_get_delayed_node(btrfs_inode);
> > @@ -131,26 +132,30 @@ static struct btrfs_delayed_node *btrfs_get_or_cr=
eate_delayed_node(
> >                 return ERR_PTR(-ENOMEM);
> >         btrfs_init_delayed_node(node, root, ino);
> >
> > -       /* cached in the btrfs inode and can be accessed */
> > +       /* Cached in the inode and can be accessed. */
> >         refcount_set(&node->refs, 2);
> >
> > -       ret =3D radix_tree_preload(GFP_NOFS);
> > -       if (ret) {
> > +       /* Allocate and reserve the slot, from now it can return a NULL=
 on xa_load(). */
> > +       ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > +       if (ret =3D=3D -ENOMEM) {
> >                 kmem_cache_free(delayed_node_cache, node);
> > -               return ERR_PTR(ret);
> > +               return ERR_PTR(-ENOMEM);
> >         }
> > -
> >         spin_lock(&root->inode_lock);
> > -       ret =3D radix_tree_insert(&root->delayed_nodes_tree, ino, node)=
;
> > -       if (ret =3D=3D -EEXIST) {
> > +       ptr =3D xa_load(&root->delayed_nodes, ino);
> > +       if (ptr) {
> > +               /* Somebody inserted it, go back and read it. */
> >                 spin_unlock(&root->inode_lock);
> >                 kmem_cache_free(delayed_node_cache, node);
> > -               radix_tree_preload_end();
> > +               node =3D NULL;
> >                 goto again;
> >         }
> > +       ptr =3D xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> > +       ASSERT(xa_err(ptr) !=3D -EINVAL);
> > +       ASSERT(xa_err(ptr) !=3D -ENOMEM);
> > +       ASSERT(ptr =3D=3D NULL);
> >         btrfs_inode->delayed_node =3D node;
> >         spin_unlock(&root->inode_lock);
> > -       radix_tree_preload_end();
> >
> >         return node;
> >  }
> > @@ -269,8 +274,7 @@ static void __btrfs_release_delayed_node(
> >                  * back up.  We can delete it now.
> >                  */
> >                 ASSERT(refcount_read(&delayed_node->refs) =3D=3D 0);
> > -               radix_tree_delete(&root->delayed_nodes_tree,
> > -                                 delayed_node->inode_id);
> > +               xa_erase(&root->delayed_nodes, delayed_node->inode_id);
> >                 spin_unlock(&root->inode_lock);
> >                 kmem_cache_free(delayed_node_cache, delayed_node);
> >         }
> > @@ -2038,34 +2042,36 @@ void btrfs_kill_delayed_inode_items(struct btrf=
s_inode *inode)
> >
> >  void btrfs_kill_all_delayed_nodes(struct btrfs_root *root)
> >  {
> > -       u64 inode_id =3D 0;
> > +       unsigned long index =3D 0;
> >         struct btrfs_delayed_node *delayed_nodes[8];
> > -       int i, n;
> >
> >         while (1) {
> > +               struct btrfs_delayed_node *node;
> > +               int count;
> > +
> >                 spin_lock(&root->inode_lock);
> > -               n =3D radix_tree_gang_lookup(&root->delayed_nodes_tree,
> > -                                          (void **)delayed_nodes, inod=
e_id,
> > -                                          ARRAY_SIZE(delayed_nodes));
> > -               if (!n) {
> > +               if (xa_empty(&root->delayed_nodes)) {
> >                         spin_unlock(&root->inode_lock);
> > -                       break;
> > +                       return;
> >                 }
> >
> > -               inode_id =3D delayed_nodes[n - 1]->inode_id + 1;
> > -               for (i =3D 0; i < n; i++) {
> > +               count =3D 0;
> > +               xa_for_each_start(&root->delayed_nodes, index, node, in=
dex) {
> >                         /*
> >                          * Don't increase refs in case the node is dead=
 and
> >                          * about to be removed from the tree in the loo=
p below
> >                          */
> > -                       if (!refcount_inc_not_zero(&delayed_nodes[i]->r=
efs))
> > -                               delayed_nodes[i] =3D NULL;
> > +                       if (refcount_inc_not_zero(&node->refs)) {
> > +                               delayed_nodes[count] =3D node;
> > +                               count++;
> > +                       }
>
> So before each xa_for_each_start() call, the delayed_nodes array
> should be zeroed (make all entries point to NULL).
> As it is we're leaving stale pointers in it in case we find any with a
> zero refcount.
> This was not a problem before, because the radix_tree_gang_lookup()
> took the array as an argument and did that.

Nevermind, got confused at the diff due to different array indexes
before and after the patch.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good, thanks.

>
> Otherwise the changes look good.
>
> Thanks.
>
>
> > +                       if (count >=3D ARRAY_SIZE(delayed_nodes))
> > +                               break;
> >                 }
> >                 spin_unlock(&root->inode_lock);
> > +               index++;
> >
> > -               for (i =3D 0; i < n; i++) {
> > -                       if (!delayed_nodes[i])
> > -                               continue;
> > +               for (int i =3D 0; i < count; i++) {
> >                         __btrfs_kill_delayed_node(delayed_nodes[i]);
> >                         btrfs_release_delayed_node(delayed_nodes[i]);
> >                 }
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index a1f440cd6d45..5e64316f8026 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -655,7 +655,8 @@ static void __setup_root(struct btrfs_root *root, s=
truct btrfs_fs_info *fs_info,
> >         root->nr_delalloc_inodes =3D 0;
> >         root->nr_ordered_extents =3D 0;
> >         root->inode_tree =3D RB_ROOT;
> > -       INIT_RADIX_TREE(&root->delayed_nodes_tree, GFP_ATOMIC);
> > +       /* GFP flags are compatible with XA_FLAGS_*. */
> > +       xa_init_flags(&root->delayed_nodes, GFP_ATOMIC);
> >
> >         btrfs_init_root_block_rsv(root);
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 4fa7fabca2c5..4e8c82e5d7a6 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3805,7 +3805,7 @@ static int btrfs_read_locked_inode(struct inode *=
inode,
> >          * cache.
> >          *
> >          * This is required for both inode re-read from disk and delaye=
d inode
> > -        * in delayed_nodes_tree.
> > +        * in the delayed_nodes xarray.
> >          */
> >         if (BTRFS_I(inode)->last_trans =3D=3D btrfs_get_fs_generation(f=
s_info))
> >                 set_bit(BTRFS_INODE_NEEDS_FULL_SYNC,
> > --
> > 2.42.1
> >
> >

