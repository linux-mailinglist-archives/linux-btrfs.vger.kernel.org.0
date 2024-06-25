Return-Path: <linux-btrfs+bounces-5966-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB826916EE9
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2901F222CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E37176AC7;
	Tue, 25 Jun 2024 17:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC8NQnqs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB0117625A
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719335554; cv=none; b=bfpCVvQPpsrPI/m/gX9T2VJ90JTyI9nlonf9U9wYYdTVm3tQl5NVk6JWIlskjjh9Hqn3ZDF9Hfrf+lE+jVgBH0m2CnldHx9RIC/4AXc8krn6k4+msYaGQRZ3XEhOP9ha4n8kb/Gd7UpdydgH5rvsQhzKf+O5ajS8CcF4v/MCVB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719335554; c=relaxed/simple;
	bh=f60qDsp0+yY4gt3FNFjZdCUdTksMnXQk81IJykqlzzw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b0kudwaVdfddglkn3MswWLpbHerjgyeIv31W1aPyi08Ze1Dh8ltCaHds77Fd8WwRFlhVT3Z60jfbLn5cLK+EUTc20uZTEjoNBS7KrTG3s+aroLL3tvNiisg8Thm8eltK76ZUsEyrqvxq7B0XwF1thLjs7kQxgCfvmJxH93BtJlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC8NQnqs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE29C32782
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719335553;
	bh=f60qDsp0+yY4gt3FNFjZdCUdTksMnXQk81IJykqlzzw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kC8NQnqs/eWc9v4k0/JUZNN8ULfyTfnQn2ts2fhwluuoBoIzb7stQr89J4jLQUiXI
	 +M5thBC4qW2FIyjTbwBPbxLBDWuOHiw8/vxMPI700o8kxlF0EH1q1tPtbVdCBo1GZ+
	 +FGu6WVxI8EBp6TwEsZOPushDHitl5Sw8jSM9fIgzQOjvkOHWwmQ/8R7hE3ovld0dX
	 ZFrcBADqRqFz0yw7GLbhOKxyUVdt8/BhAM3xBBt0A4p5ZNZpQEBZxbtpxqlhkP2HfA
	 fsLYxwr7HscsWADKrRjZjC8hL+KFdnvFsf2g6R8BcKdbBCo+rWLBITr2+uF7fcEWEj
	 RvnFIug9pIIXw==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a72604c8c5bso259628366b.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:12:33 -0700 (PDT)
X-Gm-Message-State: AOJu0YxVd2LYejJQVpaK950BLp5srrG9ybDrWZ0J3GYlGSt8iHSyxVE6
	FywxIiQwxm1aaKD4dijnO3CnuqzbKoEHXOHmsGxI4mXZqm1vPlUHtZ+W+7A5cJx0yIj2k3BYZKy
	ApGFG+DLyZeBuxdf1FIi/rSzvR+c=
X-Google-Smtp-Source: AGHT+IFi8vlUrjZXqYlmBCLIpBjdazdKzDRAcHL+Fy9axSyIxuFxlWIwOyqaGWq2SjzaWJChWkSiSkF/BrLk96Ltt5k=
X-Received: by 2002:a17:907:1887:b0:a6f:69fc:76bf with SMTP id
 a640c23a62f3a-a7245c2cdc4mr540709166b.55.1719335552222; Tue, 25 Jun 2024
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
 <CAL3q7H72qeAGqDEFgf1NLY2j3V3izfQ4bvVHP+ptGb69Y8GvLA@mail.gmail.com>
In-Reply-To: <CAL3q7H72qeAGqDEFgf1NLY2j3V3izfQ4bvVHP+ptGb69Y8GvLA@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 18:11:55 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5w4UUp9N5_RsCfgEpTEUzjh=MzyGPM=mTQgk7HdKjhKg@mail.gmail.com>
Message-ID: <CAL3q7H5w4UUp9N5_RsCfgEpTEUzjh=MzyGPM=mTQgk7HdKjhKg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: preallocate ulist memory for qgroup rsv
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 1:15=E2=80=AFPM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Fri, Jun 21, 2024 at 11:41=E2=80=AFPM Boris Burkov <boris@bur.io> wrot=
e:
> >
> > When qgroups are enabled, during data reservation, we allocate the
> > ulist_nodes that track the exact reserved extents with GFP_ATOMIC
> > unconditionally. This is unnecessary, and we can follow the model
> > already employed by the struct extent_state we preallocate in the non
> > qgroups case, which should reduce the risk of allocation failures with
> > GFP_ATOMIC.
> >
> > Add a prealloc node to struct ulist which ulist_add will grab when it i=
s
> > present, and try to allocate it before taking the tree lock while we ca=
n
> > still take advantage of a less strict gfp mask. The lifetime of that
> > node belongs to the new prealloc field, until it is used, at which poin=
t
> > it belongs to the ulist linked list.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/extent-io-tree.c |  4 ++++
> >  fs/btrfs/extent_io.h      |  5 +++++
> >  fs/btrfs/ulist.c          | 21 ++++++++++++++++++---
> >  fs/btrfs/ulist.h          |  2 ++
> >  4 files changed, 29 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> > index ed2cfc3d5d8a..c54c5d7a5cd5 100644
> > --- a/fs/btrfs/extent-io-tree.c
> > +++ b/fs/btrfs/extent-io-tree.c
> > @@ -4,6 +4,7 @@
> >  #include <trace/events/btrfs.h>
> >  #include "messages.h"
> >  #include "ctree.h"
> > +#include "extent_io.h"
> >  #include "extent-io-tree.h"
> >  #include "btrfs_inode.h"
> >
> > @@ -1084,6 +1085,9 @@ static int __set_extent_bit(struct extent_io_tree=
 *tree, u64 start, u64 end,
> >                  */
> >                 prealloc =3D alloc_extent_state(mask);
> >         }
> > +       /* Optimistically preallocate the extent changeset ulist node. =
*/
> > +       if (changeset)
> > +               extent_changeset_prealloc(changeset, mask);
> >
> >         spin_lock(&tree->lock);
> >         if (cached_state && *cached_state) {
> > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > index 96c6bbdcd5d6..8b33cfea6b75 100644
> > --- a/fs/btrfs/extent_io.h
> > +++ b/fs/btrfs/extent_io.h
> > @@ -215,6 +215,11 @@ static inline struct extent_changeset *extent_chan=
geset_alloc(void)
> >         return ret;
> >  }
> >
> > +static inline void extent_changeset_prealloc(struct extent_changeset *=
changeset, gfp_t gfp_mask)
> > +{
> > +       ulist_prealloc(&changeset->range_changed, gfp_mask);
> > +}
> > +
> >  static inline void extent_changeset_release(struct extent_changeset *c=
hangeset)
> >  {
> >         if (!changeset)
> > diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> > index 183863f4bfa4..f35d3e93996b 100644
> > --- a/fs/btrfs/ulist.c
> > +++ b/fs/btrfs/ulist.c
> > @@ -50,6 +50,7 @@ void ulist_init(struct ulist *ulist)
> >         INIT_LIST_HEAD(&ulist->nodes);
> >         ulist->root =3D RB_ROOT;
> >         ulist->nnodes =3D 0;
> > +       ulist->prealloc =3D NULL;
> >  }
> >
> >  /*
> > @@ -68,6 +69,8 @@ void ulist_release(struct ulist *ulist)
> >         list_for_each_entry_safe(node, next, &ulist->nodes, list) {
> >                 kfree(node);
> >         }
> > +       kfree(ulist->prealloc);
> > +       ulist->prealloc =3D NULL;
> >         ulist->root =3D RB_ROOT;
> >         INIT_LIST_HEAD(&ulist->nodes);
> >  }
> > @@ -105,6 +108,12 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
> >         return ulist;
> >  }
> >
> > +void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> > +{
> > +       if (ulist && !ulist->prealloc)
>
> Btw, why the non-NULL ulist check?
> There are no callers that pass a NULL ulist, and that pattern/check is
> only used for free functions.

Boris?

>
> Otherwise it looks fine. Thanks.
>
>
> > +               ulist->prealloc =3D kzalloc(sizeof(*ulist->prealloc), g=
fp_mask);
> > +}
> > +
> >  /*
> >   * Free dynamically allocated ulist.
> >   *
> > @@ -206,9 +215,15 @@ int ulist_add_merge(struct ulist *ulist, u64 val, =
u64 aux,
> >                         *old_aux =3D node->aux;
> >                 return 0;
> >         }
> > -       node =3D kmalloc(sizeof(*node), gfp_mask);
> > -       if (!node)
> > -               return -ENOMEM;
> > +
> > +       if (ulist->prealloc) {
> > +               node =3D ulist->prealloc;
> > +               ulist->prealloc =3D NULL;
> > +       } else {
> > +               node =3D kmalloc(sizeof(*node), gfp_mask);
> > +               if (!node)
> > +                       return -ENOMEM;
> > +       }
> >
> >         node->val =3D val;
> >         node->aux =3D aux;
> > diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
> > index 8e200fe1a2dd..c62a372f1462 100644
> > --- a/fs/btrfs/ulist.h
> > +++ b/fs/btrfs/ulist.h
> > @@ -41,12 +41,14 @@ struct ulist {
> >
> >         struct list_head nodes;
> >         struct rb_root root;
> > +       struct ulist_node *prealloc;
> >  };
> >
> >  void ulist_init(struct ulist *ulist);
> >  void ulist_release(struct ulist *ulist);
> >  void ulist_reinit(struct ulist *ulist);
> >  struct ulist *ulist_alloc(gfp_t gfp_mask);
> > +void ulist_prealloc(struct ulist *ulist, gfp_t mask);
> >  void ulist_free(struct ulist *ulist);
> >  int ulist_add(struct ulist *ulist, u64 val, u64 aux, gfp_t gfp_mask);
> >  int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
> > --
> > 2.45.2
> >
> >

