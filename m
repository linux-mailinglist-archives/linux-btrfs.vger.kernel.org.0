Return-Path: <linux-btrfs+bounces-19479-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD0C9EC29
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 11:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F081F3A872D
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 10:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035DA2F0C7B;
	Wed,  3 Dec 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo0TgJ3A"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F9C2989B4
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 10:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758756; cv=none; b=KcFww6cxZjXYwJdG9KCLDjS9NlJZTOp6CCMSvQY2Vf86cWt8S4DTDDVZjqOLNe2l763FVqOeEk9rwYJ+TB21zkE45ntZ7KfyRrV/ONOh9isy5mV8WQdE6C358bwlc1eMyTrq72XleVbE+SfZ8ggeoceGqg5+YviHlxb2vepGNwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758756; c=relaxed/simple;
	bh=10t4BJX+q1wqD8KyLAGeZLJKdJKQTkkfESmLGD3t7xk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9mXUW9fzSsHwDMaC00stWnv4bDxHWjRnBVfNCPDi2X2Q8BRV41IMDVurgBUJOKaJLm40ozdkKjA4oLqoOmOxbSBB1jYG91O56TWKxunibSaPy0oGoYJl8wZQW8Ui+s//v9g5ChATgZYRndRF9gbxXQeFA1Zt+CeUOOIRXSsqFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo0TgJ3A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2140C116B1
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764758756;
	bh=10t4BJX+q1wqD8KyLAGeZLJKdJKQTkkfESmLGD3t7xk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xo0TgJ3AuWtMZt/2j53zvGU4BdYqV2Nfw/8sqIp/DOuaxzaxg3Cj9YkiWQFhFTErs
	 8vWWxrE5OKuYq1LDE0KYTgxgp6wpDfPbc2fihojfm4ByMGsXQSOX7k3057z59tXJmj
	 CkqJQX0UwJcGzILcFpQV7xI0My7rlojkoOsFoz1hKxdMoDCCPbkH+vKMRL9xwzPerf
	 doCQwBwrEbHIXun/dAu4hqQLx72SpgL2h7EXMYGaja0ZKR0C+VbBY372yd/zbWpuL/
	 NLOWH4FYxHg0jjhZMF/BugpsLXjSo5jvqJM7j2MBj8hrfca+7j1Lo4a4cMurCWxnIT
	 V+7dgpVL115dg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735487129fso949302966b.0
        for <linux-btrfs@vger.kernel.org>; Wed, 03 Dec 2025 02:45:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSq8OV4ipZBBoaCexl4qUwPvyPl2qlvKl3epPcHXytbRmSWNRSBpjXz0Uz/nkGaGFuvUz3mpT8ZZ5IJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw27X3AF6jhycX3Ff/5gqOI/ZFjCv3tGvoUSjl2p4OhNJuCSIzd
	44+M6IR1jufd+BUfJdBYbKll9RDPzCRkVh9xqaP3Ge6VQjuT82VUiEwn1dt4nnzlo5Pq3uKhIhM
	Pu+L1i0N5UvILK+VkFgH77Wg36dScW48=
X-Google-Smtp-Source: AGHT+IEoOZjm4Dn/Ql73PBVO04tjThrP3m8G2aylGlBGtw+zYMw1zl1BUEovUUr8x3tzYA0w/sxgoJ908Xy+sMnFjW0=
X-Received: by 2002:a17:907:3d87:b0:b76:45bf:ce38 with SMTP id
 a640c23a62f3a-b79dbea4522mr148989566b.19.1764758754400; Wed, 03 Dec 2025
 02:45:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H6q-j8Xo_SHGyY0+pHj=BQHezTwxbP9VKQxgLruqxQdow@mail.gmail.com>
 <20251202210330.2705156-1-loemra.dev@gmail.com>
In-Reply-To: <20251202210330.2705156-1-loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 3 Dec 2025 10:45:17 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5EA=NUOPwtgUNUMhOhGd85pSgsgy17KwBOWgWV9594+Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmICo-kdHDQZfqufIjTmQwNMF-BAeAM85sRxAu_ffdgThHcwLx69yp-12A
Message-ID: <CAL3q7H5EA=NUOPwtgUNUMhOhGd85pSgsgy17KwBOWgWV9594+Q@mail.gmail.com>
Subject: Re: [linus:master] [btrfs] e8513c012d: addition_on#;use-after-free
To: Leo Martins <loemra.dev@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 9:03=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> w=
rote:
>
> On Tue, 2 Dec 2025 19:19:05 +0000 Filipe Manana <fdmanana@kernel.org> wro=
te:
>
> > On Tue, Dec 2, 2025 at 5:17=E2=80=AFPM Leo Martins <loemra.dev@gmail.co=
m> wrote:
> > >
> > > On Tue, 2 Dec 2025 15:04:51 +0000 Filipe Manana <fdmanana@kernel.org>=
 wrote:
> > >
> > > > On Tue, Dec 2, 2025 at 8:40=E2=80=AFAM Oliver Sang <oliver.sang@int=
el.com> wrote:
> > > > >
> > > > > hi, Leo Martins,
> > > > >
> > > > > On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:
> > > > >
> > > > > [...]
> > > > >
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > I believe I have identified the root cause of the warning.
> > > > > > However, I'm having some troubles running the reproducer as I
> > > > > > haven't setup lkp-tests yet. Could you test the patch below
> > > > > > against your reproducer to see if it fixes the issue?
> > > > >
> > > > > we confirmed your patch fixed the issues we reported in origial r=
eport. thanks!
> > > > >
> > > > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > > >
> > > > > >
> > > > > > ---8<---
> > > > > >
> > > > > > [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delaye=
d_node
> > > > > >
> > > > > > Previously, btrfs_get_or_create_delayed_node sets the delayed_n=
ode's
> > > > > > refcount before acquiring the root->delayed_nodes lock.
> > > > > > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_=
nodes")
> > > > > > moves refcount_set inside the critical section which means
> > > > > > there is no longer a memory barrier between setting the refcoun=
t and
> > > > > > setting btrfs_inode->delayed_node =3D node.
> > > > > >
> > > > > > This allows btrfs_get_or_create_delayed_node to set
> > > > > > btrfs_inode->delayed_node before setting the refcount.
> > > > > > A different thread is then able to read and increase the refcou=
nt
> > > > > > of btrfs_inode->delayed_node leading to a refcounting bug and
> > > > > > a use-after-free warning.
> > > > > >
> > > > > > The fix is to move refcount_set back to where it was to take
> > > > > > advantage of the implicit memory barrier provided by lock
> > > > > > acquisition.
> > > > > >
> > > > > > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_=
nodes")
> > > > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > > > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lk=
p@intel.com
> > > > > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > > > > ---
> > > > > >  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++--------------=
--
> > > > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.=
c
> > > > > > index 364814642a91..f61f10000e33 100644
> > > > > > --- a/fs/btrfs/delayed-inode.c
> > > > > > +++ b/fs/btrfs/delayed-inode.c
> > > > > > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_g=
et_or_create_delayed_node(
> > > > > >               return ERR_PTR(-ENOMEM);
> > > > > >       btrfs_init_delayed_node(node, root, ino);
> > > > > >
> > > > > > +     /* Cached in the inode and can be accessed. */
> > > > > > +     refcount_set(&node->refs, 2);
> > > > > > +     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_A=
TOMIC);
> > > > > > +     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_c=
ache_tracker, GFP_ATOMIC);
> > > > > > +
> > > > > >       /* Allocate and reserve the slot, from now it can return =
a NULL from xa_load(). */
> > > > > >       ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > > > > > -     if (ret =3D=3D -ENOMEM) {
> > > > > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > > > -             kmem_cache_free(delayed_node_cache, node);
> > > > > > -             return ERR_PTR(-ENOMEM);
> > > > > > -     }
> > > > > > +     if (ret =3D=3D -ENOMEM)
> > > > > > +             goto cleanup;
> > > > > > +
> > > > > >       xa_lock(&root->delayed_nodes);
> > > > > >       ptr =3D xa_load(&root->delayed_nodes, ino);
> > > > > >       if (ptr) {
> > > > > >               /* Somebody inserted it, go back and read it. */
> > > > > >               xa_unlock(&root->delayed_nodes);
> > > > > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > > > -             kmem_cache_free(delayed_node_cache, node);
> > > > > > -             node =3D NULL;
> > > > > > -             goto again;
> > > > > > +             goto cleanup;
> > > > > >       }
> > > > > >       ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_A=
TOMIC);
> > > > > >       ASSERT(xa_err(ptr) !=3D -EINVAL);
> > > > > >       ASSERT(xa_err(ptr) !=3D -ENOMEM);
> > > > > >       ASSERT(ptr =3D=3D NULL);
> > > > > > -
> > > > > > -     /* Cached in the inode and can be accessed. */
> > > > > > -     refcount_set(&node->refs, 2);
> > > > > > -     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_A=
TOMIC);
> > > > > > -     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_c=
ache_tracker, GFP_ATOMIC);
> > > > > > -
> > > > > > -     btrfs_inode->delayed_node =3D node;
> > > > > > +     WRITE_ONCE(btrfs_inode->delayed_node, node);
> > > >
> > > > Why the WRITE_ONCE() change?
> > >
> > > Since there are lockless readers of btrfs_inode->delayed_node all wri=
ters
> > > should be marked with WRITE_ONCE to force the compiler to store atomi=
cally.
> >
> > If by atomically you mean to avoid store/load tearing, then using the
> > _ONCE() macros won't do anything because we are dealing with pointers.
> > This has been discussed in the past, see:
> >
> > https://lore.kernel.org/linux-btrfs/cover.1715951291.git.fdmanana@suse.=
com/
>
> That is what I meant. Missed that discussion, thanks for the link.
> I do still see some value in using WRITE_ONCE which is for the human
> reader to realize that there are lockless readers, but that's pretty
> minor.

No and that's mentioned in the thread: using _ONCE() when it doesn't
offer any protection but to signal someone reading the source code
that it can be accessed in a lockless way is only confusing people and
influencing people to repeat this pattern.

To make it clear that it's accessed in a lockless way, just make the
reader side use data_race() if it's a safe race or smp_load_acquire()
otherwise, with proper comments right above the read access. These
also make KCSAN and other tools not report possible races.

> >
> > >
> > > >
> > > > Can you explain in the changelog why it's being introduced?
> > > > This seems unrelated and it was not there before the commit mention=
ed
> > > > in the Fixes tag.
> > >
> > > I'll send out a v2 without the WRITE_ONCE since it is not directly re=
lated
> > > to this bug and send out a separate patch updating writes to use WRIT=
E_ONCE.
> > >
> > > Thanks.
> > >
> > > >
> > > > Thanks.
> > > >
> > > > > >       xa_unlock(&root->delayed_nodes);
> > > > > >
> > > > > >       return node;
> > > > > > +cleanup:
> > > > > > +     btrfs_delayed_node_ref_tracker_free(node, tracker);
> > > > > > +     btrfs_delayed_node_ref_tracker_free(node, &node->inode_ca=
che_tracker);
> > > > > > +     btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > > > +     kmem_cache_free(delayed_node_cache, node);
> > > > > > +     if (ret)
> > > > > > +             return ERR_PTR(ret);
> > > > > > +     goto again;
> > > > > >  }
> > > > > >
> > > > > >  /*
> > > > > > --
> > > > > > 2.47.3
> > > > >
> > >

