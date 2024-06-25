Return-Path: <linux-btrfs+bounces-5967-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F60916F04
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B5751F22AEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D56F176FDB;
	Tue, 25 Jun 2024 17:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Rl7ojyGS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UpWPgTRQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD58C1487E9
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336066; cv=none; b=rvoiUBOSFQGHex+QLgbrqP+NKlHGPNHdEBnKVFyvV6rjtBlGdkX+Cc2pQZ6sL3/H22AVCJfZRSxy3cOfGhgJW5nkbt7dtfXH2VnOte62LMwdNkT5BLE/oC9PpqFS3g8FGnpoNySNmzClJachk4OI8Ia9HATYimzKVlXQXvoJ/R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336066; c=relaxed/simple;
	bh=v+gR6ZrOz52zIFVEs5wwBK0eF36f1qAasB0rkgCjXT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2Go2imfklkGc1TPZucOLmaOw6w4zwINAR2XOo6g873VOoPihSqQr+eXoI6+79arQmZCV3V+KB9JJgQHttbmf1aeUM87JMhi5weYbsQKsC6gHy3OH1n4GPItcZcgwojL+ld8Puq3Rbgg+QJGCviYJs4UERYzeMop7KjrC+pFufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Rl7ojyGS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UpWPgTRQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E02DA1140186;
	Tue, 25 Jun 2024 13:21:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 25 Jun 2024 13:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1719336061;
	 x=1719422461; bh=9pEz3Bfj2BhIze2fKdIw56znEnmuwGFHcROuwmp5a0s=; b=
	Rl7ojyGS85GAHUg7lIIvLQ+8m9iuHuNgIyJLC7Ep6hiMKUkLnOXMu96Zeg3pmZmj
	aqH0I/bb9g4pIe1sAaWExJNGi1E/hQZLsmxX1BzEqbsT5qD8nObc50quJ5q6OQEJ
	+O4jC9B65MA6evhk4hUC0jebcbxJnAqQGOKLqnHwV9AmiqxIQCuETO0sviTUW/6O
	KQrPyMeQF4iqTAOFHEQphk0V/rAqo1dNr3zJPvxKdmpLRLSBhU2Xcq5c5DMYDIZ4
	LESOJwtefRGHuqBiaa8LtzU9lht5KgxZPKV5lt06QqpIRRjgG3a7CH/gS9PJeu9m
	2z6glTKIlVW7Lbr1jlkFsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719336061; x=
	1719422461; bh=9pEz3Bfj2BhIze2fKdIw56znEnmuwGFHcROuwmp5a0s=; b=U
	pWPgTRQEUK0+/ocxlPpjOjovYafa3KLgeD8PaJOAE0xoDuEqtYCt5dPHDZCgH4KN
	pVUpu1WrlDBrW0nI4XMrkQ1laXIXeF1WmGSXFC78CX/RUJ3vJy6/8EqxRYcyxbVc
	CcBoZ5kKKi4BGUjNxE8eH51prs0Bilogi3yjcrDZ7+QGTEscQQ401WnEw4AC7eQe
	SY/IHnW+fNeEor7/yggmh9Et36j8Pp0NQB6iB0MpWb8h2hFyMMN3Njzjbp2awgOh
	A/2B8rL3dXn+KueJ5KRZFxzZEVzIJ+kmbsbyJLISx2hHF9YwoXkuA0XdhX4c4drp
	8ZoCgmhTpHYW+59Ut+LqA==
X-ME-Sender: <xms:ffx6Zrd7Clnev1moXyb5rv-j0In4-vfmndkS14O-57GByBFT7kPtUg>
    <xme:ffx6ZhMzR1vPrn_TVpXMeyQQZBeoarQvepUrmf1n392djsVFgwVnbmHtLsN0UsF8f
    K9yfnuK8Z8VV9eslZU>
X-ME-Received: <xmr:ffx6ZkgpGFyoip-q7XMVAwW-sw-dJnJAxNQA1zVJWJxAAcBdARtKq0e3BMbG5nYP_5Xt_nw14QG0sGY_7DjEKpUj5kk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:ffx6Zs-vo64ILG9XapElTTdMMU2idDm8052twmvGGM0iLYY_W-tbAw>
    <xmx:ffx6ZnuZvTwfljZRdyjNsIxq-gxCgvbeBp82lR4j0jginCXj4CR0ig>
    <xmx:ffx6ZrF36dwV3Zlypt3PAFS0VQwx8Kg0iqUVviVQoTRxUamy_TD__A>
    <xmx:ffx6ZuONuhhvv0epugvwL7xXIsI0sie5ii3CBj3wQ48Dgi4UUUQFBg>
    <xmx:ffx6ZnLCrJyE5Uw4w2hPWO-9SZqFasjfM4qqhaR3o_l_01dM6dpqUuE7>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 13:21:01 -0400 (EDT)
Date: Tue, 25 Jun 2024 10:20:31 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: preallocate ulist memory for qgroup rsv
Message-ID: <20240625172031.GA1495971@zen.localdomain>
References: <353894f3538d150605f0f28636249c332c1bd84a.1719009048.git.boris@bur.io>
 <CAL3q7H72qeAGqDEFgf1NLY2j3V3izfQ4bvVHP+ptGb69Y8GvLA@mail.gmail.com>
 <CAL3q7H5w4UUp9N5_RsCfgEpTEUzjh=MzyGPM=mTQgk7HdKjhKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5w4UUp9N5_RsCfgEpTEUzjh=MzyGPM=mTQgk7HdKjhKg@mail.gmail.com>

On Tue, Jun 25, 2024 at 06:11:55PM +0100, Filipe Manana wrote:
> On Sun, Jun 23, 2024 at 1:15 PM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Fri, Jun 21, 2024 at 11:41 PM Boris Burkov <boris@bur.io> wrote:
> > >
> > > When qgroups are enabled, during data reservation, we allocate the
> > > ulist_nodes that track the exact reserved extents with GFP_ATOMIC
> > > unconditionally. This is unnecessary, and we can follow the model
> > > already employed by the struct extent_state we preallocate in the non
> > > qgroups case, which should reduce the risk of allocation failures with
> > > GFP_ATOMIC.
> > >
> > > Add a prealloc node to struct ulist which ulist_add will grab when it is
> > > present, and try to allocate it before taking the tree lock while we can
> > > still take advantage of a less strict gfp mask. The lifetime of that
> > > node belongs to the new prealloc field, until it is used, at which point
> > > it belongs to the ulist linked list.
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/extent-io-tree.c |  4 ++++
> > >  fs/btrfs/extent_io.h      |  5 +++++
> > >  fs/btrfs/ulist.c          | 21 ++++++++++++++++++---
> > >  fs/btrfs/ulist.h          |  2 ++
> > >  4 files changed, 29 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
> > > index ed2cfc3d5d8a..c54c5d7a5cd5 100644
> > > --- a/fs/btrfs/extent-io-tree.c
> > > +++ b/fs/btrfs/extent-io-tree.c
> > > @@ -4,6 +4,7 @@
> > >  #include <trace/events/btrfs.h>
> > >  #include "messages.h"
> > >  #include "ctree.h"
> > > +#include "extent_io.h"
> > >  #include "extent-io-tree.h"
> > >  #include "btrfs_inode.h"
> > >
> > > @@ -1084,6 +1085,9 @@ static int __set_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
> > >                  */
> > >                 prealloc = alloc_extent_state(mask);
> > >         }
> > > +       /* Optimistically preallocate the extent changeset ulist node. */
> > > +       if (changeset)
> > > +               extent_changeset_prealloc(changeset, mask);
> > >
> > >         spin_lock(&tree->lock);
> > >         if (cached_state && *cached_state) {
> > > diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> > > index 96c6bbdcd5d6..8b33cfea6b75 100644
> > > --- a/fs/btrfs/extent_io.h
> > > +++ b/fs/btrfs/extent_io.h
> > > @@ -215,6 +215,11 @@ static inline struct extent_changeset *extent_changeset_alloc(void)
> > >         return ret;
> > >  }
> > >
> > > +static inline void extent_changeset_prealloc(struct extent_changeset *changeset, gfp_t gfp_mask)
> > > +{
> > > +       ulist_prealloc(&changeset->range_changed, gfp_mask);
> > > +}
> > > +
> > >  static inline void extent_changeset_release(struct extent_changeset *changeset)
> > >  {
> > >         if (!changeset)
> > > diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> > > index 183863f4bfa4..f35d3e93996b 100644
> > > --- a/fs/btrfs/ulist.c
> > > +++ b/fs/btrfs/ulist.c
> > > @@ -50,6 +50,7 @@ void ulist_init(struct ulist *ulist)
> > >         INIT_LIST_HEAD(&ulist->nodes);
> > >         ulist->root = RB_ROOT;
> > >         ulist->nnodes = 0;
> > > +       ulist->prealloc = NULL;
> > >  }
> > >
> > >  /*
> > > @@ -68,6 +69,8 @@ void ulist_release(struct ulist *ulist)
> > >         list_for_each_entry_safe(node, next, &ulist->nodes, list) {
> > >                 kfree(node);
> > >         }
> > > +       kfree(ulist->prealloc);
> > > +       ulist->prealloc = NULL;
> > >         ulist->root = RB_ROOT;
> > >         INIT_LIST_HEAD(&ulist->nodes);
> > >  }
> > > @@ -105,6 +108,12 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
> > >         return ulist;
> > >  }
> > >
> > > +void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> > > +{
> > > +       if (ulist && !ulist->prealloc)
> >
> > Btw, why the non-NULL ulist check?
> > There are no callers that pass a NULL ulist, and that pattern/check is
> > only used for free functions.
> 
> Boris?

Sorry, I thought about this but forgot to reply! Thanks for the reminder :)

I wanted to check ulist->prealloc to avoid leaking the prealloc if some
user prealloced in a loop without knowing that it actually got sinked
into the linked list.
At that point, I also didn't want to make assumptions on whether that
was a safe access to make.

Would you prefer changing it to just: `if (!ulist->prealloc)` ?
I could throw in an ASSERT(ulist) before as well.

Thanks for the review,
Boris

> 
> >
> > Otherwise it looks fine. Thanks.
> >
> >
> > > +               ulist->prealloc = kzalloc(sizeof(*ulist->prealloc), gfp_mask);
> > > +}
> > > +
> > >  /*
> > >   * Free dynamically allocated ulist.
> > >   *
> > > @@ -206,9 +215,15 @@ int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
> > >                         *old_aux = node->aux;
> > >                 return 0;
> > >         }
> > > -       node = kmalloc(sizeof(*node), gfp_mask);
> > > -       if (!node)
> > > -               return -ENOMEM;
> > > +
> > > +       if (ulist->prealloc) {
> > > +               node = ulist->prealloc;
> > > +               ulist->prealloc = NULL;
> > > +       } else {
> > > +               node = kmalloc(sizeof(*node), gfp_mask);
> > > +               if (!node)
> > > +                       return -ENOMEM;
> > > +       }
> > >
> > >         node->val = val;
> > >         node->aux = aux;
> > > diff --git a/fs/btrfs/ulist.h b/fs/btrfs/ulist.h
> > > index 8e200fe1a2dd..c62a372f1462 100644
> > > --- a/fs/btrfs/ulist.h
> > > +++ b/fs/btrfs/ulist.h
> > > @@ -41,12 +41,14 @@ struct ulist {
> > >
> > >         struct list_head nodes;
> > >         struct rb_root root;
> > > +       struct ulist_node *prealloc;
> > >  };
> > >
> > >  void ulist_init(struct ulist *ulist);
> > >  void ulist_release(struct ulist *ulist);
> > >  void ulist_reinit(struct ulist *ulist);
> > >  struct ulist *ulist_alloc(gfp_t gfp_mask);
> > > +void ulist_prealloc(struct ulist *ulist, gfp_t mask);
> > >  void ulist_free(struct ulist *ulist);
> > >  int ulist_add(struct ulist *ulist, u64 val, u64 aux, gfp_t gfp_mask);
> > >  int ulist_add_merge(struct ulist *ulist, u64 val, u64 aux,
> > > --
> > > 2.45.2
> > >
> > >

