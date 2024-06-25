Return-Path: <linux-btrfs+bounces-5968-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0F916F27
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF807B241A7
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B0176FA2;
	Tue, 25 Jun 2024 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgoHXXCw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F2116D4C8
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336232; cv=none; b=ihN2DuezL4EimoQeiGmEljKEj+QZyyA9agr2Wiqh3r4gHP4s4QDkK+uf8VswDKxZc/2EYvo5vA8/2O7iUYT1qcf0y0c0Y+a0ehuAJg/3AfZ8iyFbwa8BRUJt4xOYt0Zg/LlSLNKEJ8sgxrObi9Pf0V4TCxJsT9Q4LrkUTBvw9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336232; c=relaxed/simple;
	bh=oICEA4/y95bPviM9BL3JZ91/LIDz4LdY0xxtzC3w6uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1ka2v4Q4ZSO6IZhkj7udzcvHCRvdcAbQgJbE+nTr44nNw5DzZobv4/61vNR7zre13zIOo7cvRzFZ42FmskV+xQn8hJTVGslDBjol1gW8vAS7W3dwWL+0OfIswGP3tnEHnYGZYeYx6671wHjshl96ajZCW2Z6Bn/DiWmRCSy2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgoHXXCw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C9DC32782
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719336231;
	bh=oICEA4/y95bPviM9BL3JZ91/LIDz4LdY0xxtzC3w6uw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tgoHXXCw/xzoYtizAIDKPuxNaIvTK/PqYdJCBLaqYDzGqLgldoAprgqukfgafxiQh
	 /mS/Wq+yfE3u3NfNYL3Z/XIxSdcGZX+QgkQmr0//Fc4Fiwiw+YZwd6bQLG3NCpXsPr
	 jIo8XR+7khkD1qd1leqtcbD3mQ5X0o3tI3U/EGYWoq9R3i92d11uWKaLa+CSM/cdCv
	 rKg0DArW5xjgWN7OJd2IIVqJdmdH5sTO1k4RE4CCikF0JXBvfFIIXdr+dvO/yHukWz
	 xk5IjKbLobhxoglJMSdoDdXV3Wx3akXJEC6pPCBFUSb3ZrPXPgyFGe54Xif9NXn13y
	 ZGrldTo8eDcyw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52ce9ba0cedso2822569e87.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 10:23:51 -0700 (PDT)
X-Gm-Message-State: AOJu0YxGcS2Poe1b4LSMv4frlF84N7Z1VhPr/PQ2/JFoqQ7OVQThWIOC
	GwKthv8pP19aIYF/cIw/SQo6HGBbPHXrr1dRpdqIavIyNNrSEk3sl8cxgSM1Zwrw5JfpkGF8oN0
	oXkJI0P0/YAZRmqjiYoJg3tV+cCY=
X-Google-Smtp-Source: AGHT+IFtXQCTYsTqlsteJlpflw/DtV1SvuXOG370cmgpe3Bn7NbdL4SpHikt99gUSk8x71imdPKtX2phSbru9jFjtj4=
X-Received: by 2002:a05:6512:158f:b0:52c:e091:66e4 with SMTP id
 2adb3069b0e04-52ce18523ecmr7892041e87.44.1719336230257; Tue, 25 Jun 2024
 10:23:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
 <CAL3q7H72qeAGqDEFgf1NLY2j3V3izfQ4bvVHP+ptGb69Y8GvLA@mail.gmail.com>
 <CAL3q7H5w4UUp9N5_RsCfgEpTEUzjh=MzyGPM=mTQgk7HdKjhKg@mail.gmail.com> <20240625172031.GA1495971@zen.localdomain>
In-Reply-To: <20240625172031.GA1495971@zen.localdomain>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 25 Jun 2024 18:23:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5=xaHhhDNUJDkXay-=64HtnT1HN7QJKwFUaMA3=W_T9Q@mail.gmail.com>
Message-ID: <CAL3q7H5=xaHhhDNUJDkXay-=64HtnT1HN7QJKwFUaMA3=W_T9Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs: preallocate ulist memory for qgroup rsv
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 6:21=E2=80=AFPM Boris Burkov <boris@bur.io> wrote:
>
> On Tue, Jun 25, 2024 at 06:11:55PM +0100, Filipe Manana wrote:
> > On Sun, Jun 23, 2024 at 1:15=E2=80=AFPM Filipe Manana <fdmanana@kernel.=
org> wrote:
> > >
> > > On Fri, Jun 21, 2024 at 11:41=E2=80=AFPM Boris Burkov <boris@bur.io> =
wrote:
> > > >
> > > > When qgroups are enabled, during data reservation, we allocate the
> > > > ulist_nodes that track the exact reserved extents with GFP_ATOMIC
> > > > unconditionally. This is unnecessary, and we can follow the model
> > > > already employed by the struct extent_state we preallocate in the n=
on
> > > > qgroups case, which should reduce the risk of allocation failures w=
ith
> > > > GFP_ATOMIC.
> > > >
> > > > Add a prealloc node to struct ulist which ulist_add will grab when =
it is
> > > > present, and try to allocate it before taking the tree lock while w=
e can
> > > > still take advantage of a less strict gfp mask. The lifetime of tha=
t
> > > > node belongs to the new prealloc field, until it is used, at which =
point
> > > > it belongs to the ulist linked list.
> > > >
> > > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  fs/btrfs/extent-io-tree.c |  4 ++++
> > > >  fs/btrfs/extent_io.h      |  5 +++++
> > > >  fs/btrfs/ulist.c          | 21 ++++++++++++++++++---
> > > >  fs/btrfs/ulist.h          |  2 ++
> > > >  4 files changed, 29 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> > > > index ed2cfc3d5d8a..c54c5d7a5cd5 100644
> > > > --- a/fs/btrfs/extent-io-tree.c
> > > > +++ b/fs/btrfs/extent-io-tree.c
> > > > @@ -4,6 +4,7 @@
> > > >  #include <trace/events/btrfs.h>
> > > >  #include "messages.h"
> > > >  #include "ctree.h"
> > > > +#include "extent_io.h"
> > > >  #include "extent-io-tree.h"
> > > >  #include "btrfs_inode.h"
> > > >
> > > > @@ -1084,6 +1085,9 @@ static int __set_extent_bit(struct extent_io_=
tree *tree, u64 start, u64 end,
> > > >                  */
> > > >                 prealloc =3D alloc_extent_state(mask);
> > > >         }
> > > > +       /* Optimistically preallocate the extent changeset ulist no=
de. */
> > > > +       if (changeset)
> > > > +               extent_changeset_prealloc(changeset, mask);
> > > >
> > > >         spin_lock(&tree->lock);
> > > >         if (cached_state && *cached_state) {
> > > > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > > > index 96c6bbdcd5d6..8b33cfea6b75 100644
> > > > --- a/fs/btrfs/extent_io.h
> > > > +++ b/fs/btrfs/extent_io.h
> > > > @@ -215,6 +215,11 @@ static inline struct extent_changeset *extent_=
changeset_alloc(void)
> > > >         return ret;
> > > >  }
> > > >
> > > > +static inline void extent_changeset_prealloc(struct extent_changes=
et *changeset, gfp_t gfp_mask)
> > > > +{
> > > > +       ulist_prealloc(&changeset->range_changed, gfp_mask);
> > > > +}
> > > > +
> > > >  static inline void extent_changeset_release(struct extent_changese=
t *changeset)
> > > >  {
> > > >         if (!changeset)
> > > > diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> > > > index 183863f4bfa4..f35d3e93996b 100644
> > > > --- a/fs/btrfs/ulist.c
> > > > +++ b/fs/btrfs/ulist.c
> > > > @@ -50,6 +50,7 @@ void ulist_init(struct ulist *ulist)
> > > >         INIT_LIST_HEAD(&ulist->nodes);
> > > >         ulist->root =3D RB_ROOT;
> > > >         ulist->nnodes =3D 0;
> > > > +       ulist->prealloc =3D NULL;
> > > >  }
> > > >
> > > >  /*
> > > > @@ -68,6 +69,8 @@ void ulist_release(struct ulist *ulist)
> > > >         list_for_each_entry_safe(node, next, &ulist->nodes, list) {
> > > >                 kfree(node);
> > > >         }
> > > > +       kfree(ulist->prealloc);
> > > > +       ulist->prealloc =3D NULL;
> > > >         ulist->root =3D RB_ROOT;
> > > >         INIT_LIST_HEAD(&ulist->nodes);
> > > >  }
> > > > @@ -105,6 +108,12 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
> > > >         return ulist;
> > > >  }
> > > >
> > > > +void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> > > > +{
> > > > +       if (ulist && !ulist->prealloc)
> > >
> > > Btw, why the non-NULL ulist check?
> > > There are no callers that pass a NULL ulist, and that pattern/check i=
s
> > > only used for free functions.
> >
> > Boris?
>
> Sorry, I thought about this but forgot to reply! Thanks for the reminder =
:)
>
> I wanted to check ulist->prealloc to avoid leaking the prealloc if some
> user prealloced in a loop without knowing that it actually got sinked
> into the linked list.
> At that point, I also didn't want to make assumptions on whether that
> was a safe access to make.
>
> Would you prefer changing it to just: `if (!ulist->prealloc)` ?

Yes, just that.

> I could throw in an ASSERT(ulist) before as well.

I don't think it's useful. The stack trace one gets from a NULL
pointer deref is explicit enough and the ASSERT doesn't add any value.

Thanks.

>
> Thanks for the review,
> Boris
>
> >
> > >
> > > Otherwise it looks fine. Thanks.
> > >
> > >
> > > > +               ulist->prealloc =3D kzalloc(sizeof(*ulist->prealloc=
), gfp_mask);
> > > > +}
> > > > +
> > > >  /*
> > > >   * Free dynamically allocated ulist.
> > > >   *
> > > > @@ -206,9 +215,15 @@ int ulist_add_merge(struct ulist *ulist, u64 v=
al, u64 aux,
> > > >                         *old_aux =3D node->aux;
> > > >                 return 0;
> > > >         }
> > > > -       node =3D kmalloc(sizeof(*node), gfp_mask);
> > > > -       if (!node)
> > > > -               return -ENOMEM;
> > > > +
> > > > +       if (ulist->prealloc) {
> > > > +               node =3D ulist->prealloc;
> > > > +               ulist->prealloc =3D NULL;
> > > > +       } else {
> > > > +               node =3D kmalloc(sizeof(*node), gfp_mask);
> > > > +               if (!node)
> > > > +                       return -ENOMEM;
> > > > +       }
> > > >
> > > >         node->val =3D val;
> > > >         node->aux =3D aux;
> > > > diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
> > > > index 8e200fe1a2dd..c62a372f1462 100644
> > > > --- a/fs/btrfs/ulist.h
> > > > +++ b/fs/btrfs/ulist.h
> > > > @@ -41,12 +41,14 @@ struct ulist {
> > > >
> > > >         struct list_head nodes;
> > > >         struct rb_root root;
> > > > +       struct ulist_node *prealloc;
> > > >  };
> > > >
> > > >  void ulist_init(struct ulist *ulist);
> > > >  void ulist_release(struct ulist *ulist);
> > > >  void ulist_reinit(struct ulist *ulist);
> > > >  struct ulist *ulist_alloc(gfp_t gfp_mask);
> > > > +void ulist_prealloc(struct ulist *ulist, gfp_t mask);
> > > >  void ulist_free(struct ulist *ulist);
> > > >  int ulist_add(struct ulist *ulist, u64 val, u64 aux, gfp_t gfp_mas=
k);
> > > >  int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
> > > > --
> > > > 2.45.2
> > > >
> > > >

