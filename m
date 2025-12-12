Return-Path: <linux-btrfs+bounces-19695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02417CB87DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 10:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F89630A302C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509B313540;
	Fri, 12 Dec 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFUfejLv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09834313533
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531966; cv=none; b=WfnFcLs1vCv+4ZfZUJkxRDGqk3oFrhrBl9qH/0afAWmgw9eLHA4Qe9JdHcRQP8OpUUjJWIhFRzkci6gk2gxWHDbbCSO9phZdeIIc9nJ1demZtdYoWj6z9U9KymMCrMQg88MiJFOs5JMEWwGD6bINKlAp3WN/zFYC3NCllMuDo+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531966; c=relaxed/simple;
	bh=Mt2AZEqhvbfGCgmaJFUPox0eF8xH1cyygv597V6VpNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WV3dKF/IT2jeO9A6CiChj3Nn7GsdpyCEjyMpcPRNCH9pG2Qx+b8zWyd5zRNH33aR14oTMZi5qhfYqyNbvVebxoWN+qlneZNX+kwFy1NGB2TNPQmBDHUm4LMi3JwwDXJFFaRSEULxeqyB5lxqMsDgN/qio1zsn4sqnwdW9GVe0tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFUfejLv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC71C4CEF5
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 09:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765531965;
	bh=Mt2AZEqhvbfGCgmaJFUPox0eF8xH1cyygv597V6VpNA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eFUfejLvSdxsYs/w/pNfmaASVUj8/PZnaJ5jV8EhNnyRX5PEpth6ofkFxyiQbhwea
	 lnrE5xAEMSkTSr0e6e2MXvFa6UJKBCOTI4K26NgLuJzOQ0p895YuXg4hVWjxCRW/ZC
	 zH+c8AZKwr5DluKaSCuSdEG1VacwKG07hetbwPfrovEirZd1Ii6u4SmrKQoPuss9oF
	 EzuxVbC5tNk9HevdbhuOa3FnfeXQtx38i7PqrYIQg25kn7u1twpdoc+XLLlou4+Ukl
	 COVE5oi1F0fwJaZMupVJ3jeTw9gmdZFTISliepDpWYZZm+8N/agLFiL8wcJTWfCoCP
	 60dRK1gRgdIUA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7cf4a975d2so178157266b.2
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 01:32:45 -0800 (PST)
X-Gm-Message-State: AOJu0YwIolj6TtNa7VfVObaCnNKwJNJOReCKQgpPYBZ/G10/ZOkm57CU
	uLoWO0koNDt3ItNhpMgdB8G7OgDMfc6rMfsfcZIJrQUtv08bD5XfiTL0mx5W6T/8YQc28QsdoTf
	GEK4y0QyZwTbj5Qv0+Zpkj6tIT1UTr8E=
X-Google-Smtp-Source: AGHT+IG7QLRnf1/0lAu+5ydSdkBpR0m8zvw3sI+B6A5yVbw88wG7r8E0HqpccbIwBs6Tfvt/1ekHNcSVzt6x1boXHDg=
X-Received: by 2002:a17:907:9712:b0:b6d:8385:2164 with SMTP id
 a640c23a62f3a-b7d23a94048mr112443366b.54.1765531964430; Fri, 12 Dec 2025
 01:32:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H6_9wZeTOti72jpM=6iCCpQa-U5pNyekToEq0AfCfWmqQ@mail.gmail.com>
 <20251212010145.4002230-1-loemra.dev@gmail.com>
In-Reply-To: <20251212010145.4002230-1-loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 12 Dec 2025 09:32:06 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7h0=3ombZ9L0L++RHhTfymEKroTVFvW33eRb9ZjWAWKA@mail.gmail.com>
X-Gm-Features: AQt7F2qXGed5eemeSMpDI8o2AOlxTUqWrZ1r9SqFqndhGCtttrc_EVGpXaXz9sU
Message-ID: <CAL3q7H7h0=3ombZ9L0L++RHhTfymEKroTVFvW33eRb9ZjWAWKA@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: fix use-after-free warning in btrfs_get_or_create_delayed_node
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 1:01=E2=80=AFAM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> On Wed, 3 Dec 2025 10:50:17 +0000 Filipe Manana <fdmanana@kernel.org> wro=
te:
>
> > On Tue, Dec 2, 2025 at 9:21=E2=80=AFPM Leo Martins <loemra.dev@gmail.co=
m> wrote:
> > >
> > > Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> > > refcount before acquiring the root->delayed_nodes lock.
> > > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes"=
)
> > > moves refcount_set inside the critical section which means
> > > there is no longer a memory barrier between setting the refcount and
> > > setting btrfs_inode->delayed_node =3D node.
> > >
> > > This allows btrfs_get_or_create_delayed_node to set
> > > btrfs_inode->delayed_node before setting the refcount.
> > > A different thread is then able to read and increase the refcount
> > > of btrfs_inode->delayed_node leading to a refcounting bug and
> > > a use-after-free warning.
> > >
> > > The fix is to move refcount_set back to where it was to take
> > > advantage of the implicit memory barrier provided by lock
> > > acquisition.
> > >
> > > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes"=
)
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@inte=
l.com
> > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > ---
> > >  fs/btrfs/delayed-inode.c | 32 +++++++++++++++++---------------
> > >  1 file changed, 17 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > > index 364814642a91..81922556379d 100644
> > > --- a/fs/btrfs/delayed-inode.c
> > > +++ b/fs/btrfs/delayed-inode.c
> > > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_=
create_delayed_node(
> > >                 return ERR_PTR(-ENOMEM);
> > >         btrfs_init_delayed_node(node, root, ino);
> > >
> > > +       /* Cached in the inode and can be accessed. */
> > > +       refcount_set(&node->refs, 2);
> > > +       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMI=
C);
> > > +       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache=
_tracker, GFP_ATOMIC);
> >
> > Now that we do these allocations outside the spinlock (xarray's lock),
> > we can stop using GFP_ATOMIC and use GFP_NOFS.
> >
> > Otherwise it looks good, thanks.
>
> Did you want me to send out a v3 for this change?

You can make it either in a v3 or as a separate patch, I don't have a
strong preference for this.

Either way:

Reviewed-by: Filipe Manana <fdmanana@suse.com>

(Applies both to this, a possible v3 and a standalone patch for
replacing GFP_ATOMIC with GFP_NOFS).

If you can't push to for-next, let me know and I can do it.

Thanks.

>
> >
> > > +
> > >         /* Allocate and reserve the slot, from now it can return a NU=
LL from xa_load(). */
> > >         ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > > -       if (ret =3D=3D -ENOMEM) {
> > > -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > -               kmem_cache_free(delayed_node_cache, node);
> > > -               return ERR_PTR(-ENOMEM);
> > > -       }
> > > +       if (ret =3D=3D -ENOMEM)
> > > +               goto cleanup;
> > > +
> > >         xa_lock(&root->delayed_nodes);
> > >         ptr =3D xa_load(&root->delayed_nodes, ino);
> > >         if (ptr) {
> > >                 /* Somebody inserted it, go back and read it. */
> > >                 xa_unlock(&root->delayed_nodes);
> > > -               btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > -               kmem_cache_free(delayed_node_cache, node);
> > > -               node =3D NULL;
> > > -               goto again;
> > > +               goto cleanup;
> > >         }
> > >         ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMI=
C);
> > >         ASSERT(xa_err(ptr) !=3D -EINVAL);
> > >         ASSERT(xa_err(ptr) !=3D -ENOMEM);
> > >         ASSERT(ptr =3D=3D NULL);
> > > -
> > > -       /* Cached in the inode and can be accessed. */
> > > -       refcount_set(&node->refs, 2);
> > > -       btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMI=
C);
> > > -       btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache=
_tracker, GFP_ATOMIC);
> > > -
> > >         btrfs_inode->delayed_node =3D node;
> > >         xa_unlock(&root->delayed_nodes);
> > >
> > >         return node;
> > > +cleanup:
> > > +       btrfs_delayed_node_ref_tracker_free(node, tracker);
> > > +       btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_=
tracker);
> > > +       btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > +       kmem_cache_free(delayed_node_cache, node);
> > > +       if (ret)
> > > +               return ERR_PTR(ret);
> > > +       goto again;
> > >  }
> > >
> > >  /*
> > > --
> > > 2.47.3
> > >
> > >

