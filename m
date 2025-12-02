Return-Path: <linux-btrfs+bounces-19460-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BE2C9BE46
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 16:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD8E3A655F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 15:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C84325485A;
	Tue,  2 Dec 2025 15:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbonkNwT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9F723909C
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764687931; cv=none; b=Ke/H6QyQe0ZTs1mPqYwTLdhvradyU4pr7T/nPttoWGfWKcddSjgqjoLedVTy3DdsWSed7cy6G54NnCa1kZVZSkKXdBBZrzB0PjXYCxGASBj63dwd8bjWAcZoXwyJP0b5RV8X6oN9IC/rTj9ZV0mMlncmOSJxuxhwEmbMulXzOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764687931; c=relaxed/simple;
	bh=Bk33QOd9VseHEK9mrk+2mRwwZLTcNsv/SfXt2yDKQ7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpZYZlVbU5RF7y4CNwqrtL4c7WFL5+aGidRf1yv+yKI1msrJeqfbJ7QeFHOCRdD+ZC+z2ep2xkLaiH3h5gJrtm12BVKJ0A25GfCiRYtoob5b9slXVpwuykjYWpnAWBa6tRNYf10V1bAIwcCLsKLC1hXAsTnNG4J1/QLSyxLScSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbonkNwT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3227AC16AAE
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764687931;
	bh=Bk33QOd9VseHEK9mrk+2mRwwZLTcNsv/SfXt2yDKQ7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GbonkNwTrxc7JKSxfZduI5Jo1++/GgXgjT3MkQQt5uciOqUcxWDn9n0fSPAMTEDdH
	 +p+XtDuuh3RDwZq2celX0NF0GKOANrUBswls8evqWhb9ngWYV/dQ5Xo5R8i9A5j5hv
	 jjM2JMExQI+6E3c6keVlYWd8jtDsfFbgk3d38U9cSWJrrDu/LMOcw0YR1WVem2+75X
	 yK8yLA3wNnONC3EYchRc2haJTcieHr7w5Yt2JHn6wmvZhYKSctG3H+n8uzrVxjCv8O
	 o6IUVRrfxmsP42LRE0NqUoGMQNxNAvCIveRzE6im52Z1ZrnpQyALFAmhqQNzBBHxfd
	 4K1bVS+6z+lOA==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so9166625a12.1
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Dec 2025 07:05:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZYUIK/dSlgpzupSb+Q5wGN6kz1zMH/xPn01g8Qh5wprdaewC9cAIR0aIOlnGbzdJ4Pmb6N1SgDx0P4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKOSRZUUPKvLm+JuJqPLdqnJQp0QTjdzYCabFG1rFrlca7i6e
	31rekYJDorOvwccbvtIcuff5sYwxgxTj2gYudKuobXYSQzP6TK7z4UZgjJZmL9uemAQdurcx9bj
	xkjYIEYHPh5KY+lkUMlpzHXKn81zFM+U=
X-Google-Smtp-Source: AGHT+IEbSDAaYiYWwBMJXqSWexOsKdKt55C8QPguCIGaXotM32TPtdzJUNuj36lfMorqFJtzay/krvZba3h4pUd2rl8=
X-Received: by 2002:a17:907:97d6:b0:b4a:ed12:ce51 with SMTP id
 a640c23a62f3a-b767156522dmr4679057166b.23.1764687929663; Tue, 02 Dec 2025
 07:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202511262228.6dda231e-lkp@intel.com> <20251202005146.3723457-1-loemra.dev@gmail.com>
 <aS6l5hildWAimd2f@xsang-OptiPlex-9020>
In-Reply-To: <aS6l5hildWAimd2f@xsang-OptiPlex-9020>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 2 Dec 2025 15:04:51 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5L2Yc3aNCfffuimET6LLup9iB2T4_1caJkgV+c8avRMg@mail.gmail.com>
X-Gm-Features: AWmQ_bn0eFXK67zVjkQ_yMCesPI6jAz23baXAmCN0lYmveAfHcKB1BXH-VDAyyI
Message-ID: <CAL3q7H5L2Yc3aNCfffuimET6LLup9iB2T4_1caJkgV+c8avRMg@mail.gmail.com>
Subject: Re: [linus:master] [btrfs] e8513c012d: addition_on#;use-after-free
To: Oliver Sang <oliver.sang@intel.com>
Cc: Leo Martins <loemra.dev@gmail.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>, 
	linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 8:40=E2=80=AFAM Oliver Sang <oliver.sang@intel.com> =
wrote:
>
> hi, Leo Martins,
>
> On Mon, Dec 01, 2025 at 04:51:41PM -0800, Leo Martins wrote:
>
> [...]
>
> >
> > Hello,
> >
> > I believe I have identified the root cause of the warning.
> > However, I'm having some troubles running the reproducer as I
> > haven't setup lkp-tests yet. Could you test the patch below
> > against your reproducer to see if it fixes the issue?
>
> we confirmed your patch fixed the issues we reported in origial report. t=
hanks!
>
> Tested-by: kernel test robot <oliver.sang@intel.com>
>
> >
> > ---8<---
> >
> > [PATCH] btrfs: fix use-after-free in btrfs_get_or_create_delayed_node
> >
> > Previously, btrfs_get_or_create_delayed_node sets the delayed_node's
> > refcount before acquiring the root->delayed_nodes lock.
> > Commit e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > moves refcount_set inside the critical section which means
> > there is no longer a memory barrier between setting the refcount and
> > setting btrfs_inode->delayed_node =3D node.
> >
> > This allows btrfs_get_or_create_delayed_node to set
> > btrfs_inode->delayed_node before setting the refcount.
> > A different thread is then able to read and increase the refcount
> > of btrfs_inode->delayed_node leading to a refcounting bug and
> > a use-after-free warning.
> >
> > The fix is to move refcount_set back to where it was to take
> > advantage of the implicit memory barrier provided by lock
> > acquisition.
> >
> > Fixes: e8513c012de7 ("btrfs: implement ref_tracker for delayed_nodes")
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Closes: https://lore.kernel.org/oe-lkp/202511262228.6dda231e-lkp@intel.=
com
> > Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> > ---
> >  fs/btrfs/delayed-inode.c | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> > index 364814642a91..f61f10000e33 100644
> > --- a/fs/btrfs/delayed-inode.c
> > +++ b/fs/btrfs/delayed-inode.c
> > @@ -152,37 +152,39 @@ static struct btrfs_delayed_node *btrfs_get_or_cr=
eate_delayed_node(
> >               return ERR_PTR(-ENOMEM);
> >       btrfs_init_delayed_node(node, root, ino);
> >
> > +     /* Cached in the inode and can be accessed. */
> > +     refcount_set(&node->refs, 2);
> > +     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > +     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tra=
cker, GFP_ATOMIC);
> > +
> >       /* Allocate and reserve the slot, from now it can return a NULL f=
rom xa_load(). */
> >       ret =3D xa_reserve(&root->delayed_nodes, ino, GFP_NOFS);
> > -     if (ret =3D=3D -ENOMEM) {
> > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > -             kmem_cache_free(delayed_node_cache, node);
> > -             return ERR_PTR(-ENOMEM);
> > -     }
> > +     if (ret =3D=3D -ENOMEM)
> > +             goto cleanup;
> > +
> >       xa_lock(&root->delayed_nodes);
> >       ptr =3D xa_load(&root->delayed_nodes, ino);
> >       if (ptr) {
> >               /* Somebody inserted it, go back and read it. */
> >               xa_unlock(&root->delayed_nodes);
> > -             btrfs_delayed_node_ref_tracker_dir_exit(node);
> > -             kmem_cache_free(delayed_node_cache, node);
> > -             node =3D NULL;
> > -             goto again;
> > +             goto cleanup;
> >       }
> >       ptr =3D __xa_store(&root->delayed_nodes, ino, node, GFP_ATOMIC);
> >       ASSERT(xa_err(ptr) !=3D -EINVAL);
> >       ASSERT(xa_err(ptr) !=3D -ENOMEM);
> >       ASSERT(ptr =3D=3D NULL);
> > -
> > -     /* Cached in the inode and can be accessed. */
> > -     refcount_set(&node->refs, 2);
> > -     btrfs_delayed_node_ref_tracker_alloc(node, tracker, GFP_ATOMIC);
> > -     btrfs_delayed_node_ref_tracker_alloc(node, &node->inode_cache_tra=
cker, GFP_ATOMIC);
> > -
> > -     btrfs_inode->delayed_node =3D node;
> > +     WRITE_ONCE(btrfs_inode->delayed_node, node);

Why the WRITE_ONCE() change?

Can you explain in the changelog why it's being introduced?
This seems unrelated and it was not there before the commit mentioned
in the Fixes tag.

Thanks.

> >       xa_unlock(&root->delayed_nodes);
> >
> >       return node;
> > +cleanup:
> > +     btrfs_delayed_node_ref_tracker_free(node, tracker);
> > +     btrfs_delayed_node_ref_tracker_free(node, &node->inode_cache_trac=
ker);
> > +     btrfs_delayed_node_ref_tracker_dir_exit(node);
> > +     kmem_cache_free(delayed_node_cache, node);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +     goto again;
> >  }
> >
> >  /*
> > --
> > 2.47.3
>

