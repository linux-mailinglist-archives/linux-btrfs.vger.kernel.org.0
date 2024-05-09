Return-Path: <linux-btrfs+bounces-4858-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 758A58C0CAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 10:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2705C285CA7
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 08:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2FA13C9A1;
	Thu,  9 May 2024 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJVLDxUt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D2ADDD9
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243957; cv=none; b=bm6U7UuoJKs916kMoKdxbSu35iYtIyYa/cs62AyyHmOi7PdzSoX33o2E95OTASdANnLFZhsyt6DX1oltZ0lMGo+9cxdQBN4zeLxA1yvMLhwBq511s8rYOA5ZGK26Oow7LsEAvn9XHXN8enhT9HF/w80VZKMHTAWmgkOzG0Bj2xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243957; c=relaxed/simple;
	bh=DQJO/W4Zv3LsRvcLx2RHrxT8XpCPFYkNzYoLGN8LObc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwEhMoCBcN5ouO+2Y3BmmZxbla6eEPaTq82Te1cKPfek+IDT4SdQHaiAJ+inpjbxd1VBu7GQ4P07GGz6UhxMRuwStx12Wh0lSWaaH2VfOi9e8U5f53u0tUpgVybMMWZSmNOT5nXkjtEqMAAoh7fIztYhL62xECKdjzoq6gaQE1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJVLDxUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404F2C2BBFC
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715243957;
	bh=DQJO/W4Zv3LsRvcLx2RHrxT8XpCPFYkNzYoLGN8LObc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YJVLDxUtCJeD+gn0KEfTH19VxuFBh+Ss0dzrMa+iDC4/56H00p+yLOhp05+Qv6we1
	 5X1A8hvuOr8VWYD2C9dxgT9FdSXILsSiC4N/+XIWFjDzuJWkHddr/hTRna9oXNGVu1
	 gsbiio9ou82AzF8PLSCVQzTzz9NFKaXo8y7Gq/mMDheP8WSVMpkuMqNtvKvmELHmbU
	 JZek+jMMQ+fXPlIeiCPaAai5UBFmAj8JAwNTdpy89VMATz2aiv0fcP3hP0XGVG51bm
	 73Nziu/+kHSp6ngZEE1bPPYVbTzMTYTTG6jFuN0xP5ehqMd5k3jf8nmcbxN/MFnr5B
	 BHQk95FMgKk5g==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59cc765c29so131729966b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 09 May 2024 01:39:17 -0700 (PDT)
X-Gm-Message-State: AOJu0YyAqtRKyM97kGZNJqYX89Yxc25R13QKROe1WmVhjOesfe6ByVzY
	oZNB4zICxlxpS5LOjLPRgHjZjAZH2xl0u1Tnb17WtP/XM3W59sDNP9/7if8OSHWIstAccfL703+
	WYIdVc6BzsjXPHj/6yVK0MfvcVKQ=
X-Google-Smtp-Source: AGHT+IGzcSsDRFNxTm3VtOrW1dVF3qkcIO+nHoX5nUvZ54CxVcOnkO7fCMAJR/nwviPbd8gDBjs//4V+yjJUtB/GPRQ=
X-Received: by 2002:a17:906:e0d1:b0:a59:b8e2:a0cd with SMTP id
 a640c23a62f3a-a59fb9dc769mr272283766b.59.1715243955700; Thu, 09 May 2024
 01:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1715169723.git.fdmanana@suse.com> <51066985ea4e9ea16388854a1d48ee197f07219f.1715169723.git.fdmanana@suse.com>
 <23310a98-c2dc-4a99-ac83-593da5e7d42f@gmx.com>
In-Reply-To: <23310a98-c2dc-4a99-ac83-593da5e7d42f@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 9 May 2024 09:38:38 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7xFxOYZ_rQnb9_qOXuGXGMHOCso2m1p23xe4dGFfd74Q@mail.gmail.com>
Message-ID: <CAL3q7H7xFxOYZ_rQnb9_qOXuGXGMHOCso2m1p23xe4dGFfd74Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] btrfs: remove inode_lock from struct btrfs_root and
 use xarray locks
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 1:25=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>
>
>
> =E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently we use the spinlock inode_lock from struct btrfs_root to
> > serialize access to two different data structures:
> >
> > 1) The delayed inodes xarray (struct btrfs_root::delayed_nodes);
> > 2) The inodes xarray (struct btrfs_root::inodes).
> >
> > Instead of using our own lock, we can use the spinlock that is part of =
the
> > xarray implementation, by using the xa_lock() and xa_unlock() APIs and
> > using the xarray APIs with the double underscore prefix that don't take
> > the xarray locks and assume the caller is using xa_lock() and xa_unlock=
().
> >
> > So remove the spinlock inode_lock from struct btrfs_root and use the
> > corresponding xarray locks. This brings 2 benefits:
> >
> > 1) We reduce the size of struct btrfs_root, from 1336 bytes down to
> >     1328 bytes on a 64 bits release kernel config;
> >
> > 2) We reduce lock contention by not using anymore  the same lock for
> >     changing two different and unrelated xarrays.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/ctree.h         |  1 -
> >   fs/btrfs/delayed-inode.c | 24 +++++++++++-------------
> >   fs/btrfs/disk-io.c       |  1 -
> >   fs/btrfs/inode.c         | 18 ++++++++----------
> >   4 files changed, 19 insertions(+), 25 deletions(-)
> >
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index aa2568f86dc9..1004cb934b4a 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -221,7 +221,6 @@ struct btrfs_root {
> >
> >       struct list_head root_list;
> >
> > -     spinlock_t inode_lock;
> >       /*
> >        * Xarray that keeps track of in-memory inodes, protected by the =
lock
> >        * @inode_lock.
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 95a0497fa866..1373f474c9b6 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -77,14 +77,14 @@ static struct btrfs_delayed_node *btrfs_get_delayed=
_node(
> >               return node;
> >       }
> >
> > -     spin_lock(&root->inode_lock);
> > +     xa_lock(&root->delayed_nodes);
> >       node =3D xa_load(&root->delayed_nodes, ino);
>
> Do we need xa_lock() here?
>
> The doc shows xa_load() use RCU read lock already.
> Only xa_store()/xa_find() would take xa_lock internally, thus they need
> to be converted.
>
> Or did I miss something else?

The RCU is only for protection against concurrent xarray operations
that modify the xarray.
After xa_load() returns, the "node" might have been removed from the
xarray and freed by another task.

That's why this change is a straightforward switch from one lock to another=
.

It may be that our code is structured in a way that we can get away
with the lock.
But that needs to be properly analysed and given that it's a
non-trivial behavioural change, should have its own separate patch and
change log with the analysis.

Thanks.


>
> Thanks,
> Qu
> >
> >       if (node) {
> >               if (btrfs_inode->delayed_node) {
> >                       refcount_inc(&node->refs);      /* can be accesse=
d */
> >                       BUG_ON(btrfs_inode->delayed_node !=3D node);
> > -                     spin_unlock(&root->inode_lock);
> > +                     xa_unlock(&root->delayed_nodes);
> >                       return node;
> >               }
> >
> > @@ -111,10 +111,10 @@ static struct btrfs_delayed_node *btrfs_get_delay=
ed_node(
> >                       node =3D NULL;
> >               }
> >
> > -             spin_unlock(&root->inode_lock);
> > +             xa_unlock(&root->delayed_nodes);
> >               return node;
> >       }
> > -     spin_unlock(&root->inode_lock);
> > +     xa_unlock(&root->delayed_nodes);
> >
> >       return NULL;
> >   }
> > @@ -148,21 +148,21 @@ static struct btrfs_delayed_node *btrfs_get_or_cr=
eate_delayed_node(
> >               kmem_cache_free(delayed_node_cache, node);
> >               return ERR_PTR(-ENOMEM);
> >       }
> > -     spin_lock(&root->inode_lock);
> > +     xa_lock(&root->delayed_nodes);
> >       ptr =3D xa_load(&root->delayed_nodes, ino);
> >       if (ptr) {
> >               /* Somebody inserted it, go back and read it. */
> > -             spin_unlock(&root->inode_lock);
> > +             xa_unlock(&root->delayed_nodes);
> >               kmem_cache_free(delayed_node_cache, node);
> >               node =3D NULL;
> >               goto again;
> >       }
> > -     ptr =3D xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> > +     ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> >       ASSERT(xa_err(ptr) !=3D -EINVAL);
> >       ASSERT(xa_err(ptr) !=3D -ENOMEM);
> >       ASSERT(ptr =3D=3D NULL);
> >       btrfs_inode->delayed_node =3D node;
> > -     spin_unlock(&root->inode_lock);
> > +     xa_unlock(&root->delayed_nodes);
> >
> >       return node;
> >   }
> > @@ -275,14 +275,12 @@ static void __btrfs_release_delayed_node(
> >       if (refcount_dec_and_test(&delayed_node->refs)) {
> >               struct btrfs_root *root =3D delayed_node->root;
> >
> > -             spin_lock(&root->inode_lock);
> >               /*
> >                * Once our refcount goes to zero, nobody is allowed to b=
ump it
> >                * back up.  We can delete it now.
> >                */
> >               ASSERT(refcount_read(&delayed_node->refs) =3D=3D 0);
> >               xa_erase(&root->delayed_nodes, delayed_node->inode_id);
> > -             spin_unlock(&root->inode_lock);
> >               kmem_cache_free(delayed_node_cache, delayed_node);
> >       }
> >   }
> > @@ -2057,9 +2055,9 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_ro=
ot *root)
> >               struct btrfs_delayed_node *node;
> >               int count;
> >
> > -             spin_lock(&root->inode_lock);
> > +             xa_lock(&root->delayed_nodes);
> >               if (xa_empty(&root->delayed_nodes)) {
> > -                     spin_unlock(&root->inode_lock);
> > +                     xa_unlock(&root->delayed_nodes);
> >                       return;
> >               }
> >
> > @@ -2076,7 +2074,7 @@ void btrfs_kill_all_delayed_nodes(struct btrfs_ro=
ot *root)
> >                       if (count >=3D ARRAY_SIZE(delayed_nodes))
> >                               break;
> >               }
> > -             spin_unlock(&root->inode_lock);
> > +             xa_unlock(&root->delayed_nodes);
> >               index++;
> >
> >               for (int i =3D 0; i < count; i++) {
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index ed40fe1db53e..d20e400a9ce3 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -674,7 +674,6 @@ static void __setup_root(struct btrfs_root *root, s=
truct btrfs_fs_info *fs_info,
> >       INIT_LIST_HEAD(&root->ordered_extents);
> >       INIT_LIST_HEAD(&root->ordered_root);
> >       INIT_LIST_HEAD(&root->reloc_dirty_list);
> > -     spin_lock_init(&root->inode_lock);
> >       spin_lock_init(&root->delalloc_lock);
> >       spin_lock_init(&root->ordered_extent_lock);
> >       spin_lock_init(&root->accounting_lock);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 8ea9fd4c2b66..4fd41d6b377f 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -5509,9 +5509,7 @@ static int btrfs_add_inode_to_root(struct btrfs_i=
node *inode, bool prealloc)
> >                       return ret;
> >       }
> >
> > -     spin_lock(&root->inode_lock);
> >       existing =3D xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
> > -     spin_unlock(&root->inode_lock);
> >
> >       if (xa_is_err(existing)) {
> >               ret =3D xa_err(existing);
> > @@ -5531,16 +5529,16 @@ static void btrfs_del_inode_from_root(struct bt=
rfs_inode *inode)
> >       struct btrfs_inode *entry;
> >       bool empty =3D false;
> >
> > -     spin_lock(&root->inode_lock);
> > -     entry =3D xa_erase(&root->inodes, btrfs_ino(inode));
> > +     xa_lock(&root->inodes);
> > +     entry =3D __xa_erase(&root->inodes, btrfs_ino(inode));
> >       if (entry =3D=3D inode)
> >               empty =3D xa_empty(&root->inodes);
> > -     spin_unlock(&root->inode_lock);
> > +     xa_unlock(&root->inodes);
> >
> >       if (empty && btrfs_root_refs(&root->root_item) =3D=3D 0) {
> > -             spin_lock(&root->inode_lock);
> > +             xa_lock(&root->inodes);
> >               empty =3D xa_empty(&root->inodes);
> > -             spin_unlock(&root->inode_lock);
> > +             xa_unlock(&root->inodes);
> >               if (empty)
> >                       btrfs_add_dead_root(root);
> >       }
> > @@ -10871,7 +10869,7 @@ struct btrfs_inode *btrfs_find_first_inode(stru=
ct btrfs_root *root, u64 min_ino)
> >       struct btrfs_inode *inode;
> >       unsigned long from =3D min_ino;
> >
> > -     spin_lock(&root->inode_lock);
> > +     xa_lock(&root->inodes);
> >       while (true) {
> >               inode =3D xa_find(&root->inodes, &from, ULONG_MAX, XA_PRE=
SENT);
> >               if (!inode)
> > @@ -10880,9 +10878,9 @@ struct btrfs_inode *btrfs_find_first_inode(stru=
ct btrfs_root *root, u64 min_ino)
> >                       break;
> >
> >               from =3D btrfs_ino(inode) + 1;
> > -             cond_resched_lock(&root->inode_lock);
> > +             cond_resched_lock(&root->inodes.xa_lock);
> >       }
> > -     spin_unlock(&root->inode_lock);
> > +     xa_unlock(&root->inodes);
> >
> >       return inode;
> >   }

