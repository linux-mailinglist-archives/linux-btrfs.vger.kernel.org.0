Return-Path: <linux-btrfs+bounces-19468-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DBBC9CBE5
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 20:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1B5EB34A613
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 19:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431982D595F;
	Tue,  2 Dec 2025 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc5d7MUv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FA81F09B3
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764703184; cv=none; b=cMu1CsabFXPKoF7XeaDnIp83loBGPR6OR/bpR3zI9CyXRo82l6nuafw/znAV82aA6IQYPlubzKbL0qs8udTV4e3GplVbPL8xKqkIZuGC3sBEdo0Mb9SLu0hyfYrDuH3WpZAQdwqzQwgekQvQp8IQDEa4nHsJ0iJzQs2olQKvVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764703184; c=relaxed/simple;
	bh=NL7snJKzJwsgH7BhSOd0U4LCa0CKAQe2eDKCy2VN+lY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjO8IBu45yIxa0DljYD+VrvLJ0u3I07lBcsPWeHZQSM70XK80mk9oTeFp/yq2MKQL81G4GT4joPZfVDSTRou2huKp26ErktORuGoSDZ3Wz93gJrYJJyrPF0kdTXy3EWrsff4NRMUv5XcflW2B5jbYIFcYimp6QeT9S4wluRumOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc5d7MUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED60C4AF0B
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 19:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764703184;
	bh=NL7snJKzJwsgH7BhSOd0U4LCa0CKAQe2eDKCy2VN+lY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kc5d7MUv2fb/fp/viWF8Y5+/4D0PJljLUduyY2aPHnIItYEONiN/l1XAMXqsv4lQy
	 OXqBzRHZd/zqImCQNEyppy8CGbwUtAi9dcxQ+kEMHbHleVg2eOxKWaUhqsI7Uu9c35
	 9oxHlCljc3+k0J+J9cTe8emxHQ5PqqO5OQJQ2/PHrfA4bcjeyk+bFjeIrzEoPbeMXm
	 wOqvUbQCvpPWpoZ6VYMvXisu9ZHhksGaUolGya4EIuGZXgQ/EYsMnv0rVAyZuMMfRM
	 wf6JY6clNLqH/+ODx5/AcTz/HPuK4efIk5+95+FpB9YhdSga6GcCewYRUrXtn1JM7J
	 1R6x6N77T4TQg==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b739ef3f739so356768566b.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 11:19:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLEmR/tZFfRrkuJLvJs1x7PVfKLuiJH0AopXxP5/8JKzjGW43QS9JsDKbP6kTK2l0MIcOLCY2kPMaXfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrzEFHpG8LXdIqjB2+Oal4g86Go705cZShfkmoGVz/qVLuiPDa
	QctMZOMCQQwqzNEuWhJSVCJ/z0XWUFD49YXAMs/QebFzs4VkNdBE79Z3HWbJTdf+m0kEJKTyu5c
	yGpkQtoiacwh9vfcal62jyYByYPCgc9A=
X-Google-Smtp-Source: AGHT+IF154pLtEgoYAtKAbOomhqP6C/9+/HGLK0hgpVGVF896EzIS1MZPR2M4bSOXhvr/phh8N2EbLFUfMTTP08ECuE=
X-Received: by 2002:a17:907:744:b0:b73:b0eb:16f5 with SMTP id
 a640c23a62f3a-b76c55f4037mr4002153866b.31.1764703182849; Tue, 02 Dec 2025
 11:19:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL3q7H5L2Yc3aNCfffuimET6LLup9iB2T4_1caJkgV+c8avRMg@mail.gmail.com>
 <20251202171745.798946-1-loemra.dev@gmail.com>
In-Reply-To: <20251202171745.798946-1-loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Dec 2025 19:19:05 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6q-j8Xo_SHGyY0+pHj=BQHezTwxbP9VKQxgLruqxQdow@mail.gmail.com>
X-Gm-Features: AWmQ_bm6zC7vIXR7_po8EZTp8AwAt_bZ4zg_0obvLC7T-l83B9iXzNCcXfoSIng
Message-ID: <CAL3q7H6q-j8Xo_SHGyY0+pHj=BQHezTwxbP9VKQxgLruqxQdow@mail.gmail.com>
Subject: Re: [linus:master] [btrfs] e8513c012d: addition_on#;use-after-free
To: Leo Martins <loemra.dev@gmail.com>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 5:17=E2=80=AFPM Leo Martins <loemra.dev@gmail.com> w=
rote:
>
> On Tue, 2 Dec 2025 15:04:51 +0000 Filipe Manana <fdmanana@kernel.org> wro=
te:
>
> > On Tue, Dec 2, 2025 at 8:40=E2=80=AFAM Oliver Sang <oliver.sang@intel.c=
om> wrote:
> > >
> > > hi, Leo Martins,
> > >
> > > On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:
> > >
> > > [...]
> > >
> > > >
> > > > Hello,
> > > >
> > > > I believe I have identified the root cause of the warning.
> > > > However, I'm having some troubles running the reproducer as I
> > > > haven't setup lkp-tests yet. Could you test the patch below
> > > > against your reproducer to see if it fixes the issue?
> > >
> > > we confirmed your patch fixed the issues we reported in origial repor=
t. thanks!
> > >
> > > Tested-by: kernel test robot <oliver.sang@intel.com>
> > >
> > > >
> > > > ---8<---
> > > >
> > > > [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_no=
de
> > > >
> > > > Previously, btrfs_get_or_create_delayed_node sets the delayed_node'=
s
> > > > refcount before acquiring the root->delayed_nodes lock.
> > > > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_node=
s")
> > > > moves refcount_set inside the critical section which means
> > > > there is no longer a memory barrier between setting the refcount an=
d
> > > > setting btrfs_inode->delayed_node =3D node.
> > > >
> > > > This allows btrfs_get_or_create_delayed_node to set
> > > > btrfs_inode->delayed_node before setting the refcount.
> > > > A different thread is then able to read and increase the refcount
> > > > of btrfs_inode->delayed_node leading to a refcounting bug and
> > > > a use-after-free warning.
> > > >
> > > > The fix is to move refcount_set back to where it was to take
> > > > advantage of the implicit memory barrier provided by lock
> > > > acquisition.
> > > >
> > > > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_node=
s")
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@in=
tel.com
> > > > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > > > ---
> > > >  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
> > > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > > > index 364814642a91..f61f10000e33 100644
> > > > --- a/fs/btrfs/delayed-inode.c
> > > > +++ b/fs/btrfs/delayed-inode.c
> > > > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_o=
r_create_delayed_node(
> > > >               return ERR_PTR(-ENOMEM);
> > > >       btrfs_init_delayed_node(node, root, ino);
> > > >
> > > > +     /* Cached in the inode and can be accessed. */
> > > > +     refcount_set(&node->refs, 2);
> > > > +     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMI=
C);
> > > > +     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache=
_tracker, GFP_ATOMIC);
> > > > +
> > > >       /* Allocate and reserve the slot, from now it can return a NU=
LL from xa_load(). */
> > > >       ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > > > -     if (ret =3D=3D -ENOMEM) {
> > > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > -             kmem_cache_free(delayed_node_cache, node);
> > > > -             return ERR_PTR(-ENOMEM);
> > > > -     }
> > > > +     if (ret =3D=3D -ENOMEM)
> > > > +             goto cleanup;
> > > > +
> > > >       xa_lock(&root->delayed_nodes);
> > > >       ptr =3D xa_load(&root->delayed_nodes, ino);
> > > >       if (ptr) {
> > > >               /* Somebody inserted it, go back and read it. */
> > > >               xa_unlock(&root->delayed_nodes);
> > > > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > -             kmem_cache_free(delayed_node_cache, node);
> > > > -             node =3D NULL;
> > > > -             goto again;
> > > > +             goto cleanup;
> > > >       }
> > > >       ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMI=
C);
> > > >       ASSERT(xa_err(ptr) !=3D -EINVAL);
> > > >       ASSERT(xa_err(ptr) !=3D -ENOMEM);
> > > >       ASSERT(ptr =3D=3D NULL);
> > > > -
> > > > -     /* Cached in the inode and can be accessed. */
> > > > -     refcount_set(&node->refs, 2);
> > > > -     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMI=
C);
> > > > -     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache=
_tracker, GFP_ATOMIC);
> > > > -
> > > > -     btrfs_inode->delayed_node =3D node;
> > > > +     WRITE_ONCE(btrfs_inode->delayed_node, node);
> >
> > Why the WRITE_ONCE() change?
>
> Since there are lockless readers of btrfs_inode->delayed_node all writers
> should be marked with WRITE_ONCE to force the compiler to store atomicall=
y.

If by atomically you mean to avoid store/load tearing, then using the
_ONCE() macros won't do anything because we are dealing with pointers.
This has been discussed in the past, see:

https://lore.kernel.org/linux-btrfs/cover.1715951291.git.fdmanana@suse.com/

>
> >
> > Can you explain in the changelog why it's being introduced?
> > This seems unrelated and it was not there before the commit mentioned
> > in the Fixes tag.
>
> I'll send out a v2 without the WRITE_ONCE since it is not directly relate=
d
> to this bug and send out a separate patch updating writes to use WRITE_ON=
CE.
>
> Thanks.
>
> >
> > Thanks.
> >
> > > >       xa_unlock(&root->delayed_nodes);
> > > >
> > > >       return node;
> > > > +cleanup:
> > > > +     btrfs_delayed_node_ref_tracker_free(node, tracker);
> > > > +     btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_=
tracker);
> > > > +     btrfs_delayed_node_ref_tracker_dir_exit(node);
> > > > +     kmem_cache_free(delayed_node_cache, node);
> > > > +     if (ret)
> > > > +             return ERR_PTR(ret);
> > > > +     goto again;
> > > >  }
> > > >
> > > >  /*
> > > > --
> > > > 2.47.3
> > >
>

