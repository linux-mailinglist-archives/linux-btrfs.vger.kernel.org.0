Return-Path: <linux-btrfs+bounces-5971-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E3916F90
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 19:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD0E1C212EF
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 17:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C93176AD5;
	Tue, 25 Jun 2024 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="as5ENeLp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RI898vfN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008EB4437A
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337718; cv=none; b=F7D65dJqNkzWHyiQyeGMHYn6l041fYbbKIgeKMI1AusuGPA7MzplEtunpFyZ9pnHYWdC77mKCZqsY0lkuyubl+wQVtn/uPMva6FWO6wyBTK/YwCvyg1rWu78LVUxIyzCEl9iAFWPV7pw1kkca/h7BekaHFd3AzFgW1vPyKDfrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337718; c=relaxed/simple;
	bh=Aq+cJsTXXuz4+KxRgWPojXazzx4BMjaGUss0LS3e2DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvgJ9mzlfiSjB8ScnEVYdhbbORm7aPRPyF26OCq9EGx/sJxlwG5LiMlyIAs4+/F6d0eZCmJRCWnelHkMKhkH2RvS0fmLG/24nAllwLh5Ux6CozZA2P62HeTRxd5AGPyIvpka2G//a3fbqv/lIKSZ/rBqr5n4+EPdBBtZhWMWYHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=as5ENeLp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RI898vfN; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 005531380475;
	Tue, 25 Jun 2024 13:48:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 Jun 2024 13:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1719337715;
	 x=1719424115; bh=HS9sQxqPfqMEOlWa+LWWQHwZ7IspAyHwy4uAMODd9Lo=; b=
	as5ENeLphT9kPjJ9XojCYF1O+xTLW4K218zT1o3yibEzz+xrltIeCquBioytrw5H
	FwV5/vu8HkUJxS5T0rxUsWOCg2/EUWX6+lqLwp6xkVX8G3q9cyZtxY8NcIjO6tg6
	Y2I0dd1ZnaZYVjob0XqJJbAZXhIW6ZAYM9QzEyYEr2z+QCG8Yquv3r0uCc6P+Okj
	xoXK6OXqjwcZ77yXyijdZXcmx/yfTtmkZMsXj8gBHVqzBV0f0dGLUoA0vb1RUirk
	W6TIzx3DO2c7pnWtUlFt3jfyxHNoVl9zQIfLD55V0eqgqbbi9mhX320TQEZihXvS
	9W3y7NftMl7FKdBolygopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719337715; x=
	1719424115; bh=HS9sQxqPfqMEOlWa+LWWQHwZ7IspAyHwy4uAMODd9Lo=; b=R
	I898vfNgVqA+Qz1lBp80Et+IvR75gRs5CnS/eqsKhL+hYRY4fCnsvXW2+NLexASF
	PXZZ7NgutHNzvTuIKdk5KMS5Y1BUNRqLuEOfAu2ih0IN+8kRDPm0CukG2FwaIKFt
	nuDvGA7cevAZ1hGx/D8sIOJQYolYB7dDZNkJ/7TbyRwVdosf4yhqMlafkokv5fx/
	lLUvwFLN6zaYHXktwI+bDxqduz5YX7RtyCIAPFVkHUqdK90o8XRXxHTxlIQrU2Wu
	DUSqjkxuEr0vkjV7oFUwZaVAuIHqOBgEqlmKbv0ZgoqdWi72BeMjssOOzm5TmISy
	sLf+jXOkvB5DvJ98UyT0w==
X-ME-Sender: <xms:8wJ7Zv5Kvn43QwTkvo_OKxXv-V31iWP0OgUiKCm_O5UvyByp-DgOuw>
    <xme:8wJ7Zk4-hJzySXJl4N6_nBy1hKC3-gkhlj2gWmUmC2jMb4h6H2FcfhBROx-M2EaSf
    DIYTrtguj0KbKSPhls>
X-ME-Received: <xmr:8wJ7ZmfzkH_p18XXHXq5Hss39qGs0CRTbOvvJn0tznYMK-8PWUxaJrNWubwjplTkxQ3-XhFqpp5RTne-K7qGB8IAdfk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    dulefhtdfhteduvdethfeftdeitdethedvtdekvdeltddvveegtdeuuddtiedtieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:8wJ7ZgKZPYWDQyXV_4EiFl0utC-0Ex5nvnUEPKgRshwO5vGBqzt8pA>
    <xmx:8wJ7ZjK2zRi4lLoK1wih00HMA-CE4HXDEQrtsYF4__jovBKNsM7qFg>
    <xmx:8wJ7ZpwbRjTC_eaZNjHc9b4O8gTE4Si3vc_EOE1Enlm65EqcW9csog>
    <xmx:8wJ7ZvJ6FW1Euo0edVyTesPacg9YPLh4LNuWZcHdt4eR-Towe5FmYw>
    <xmx:8wJ7Zr3YYw8FVygN5Aiz-Mw4yHMz-03EGUhBhWhSn67je5Q_ib99dIke>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 13:48:35 -0400 (EDT)
Date: Tue, 25 Jun 2024 10:48:05 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: don't check NULL ulist in ulist_prealloc
Message-ID: <20240625174805.GA1535197@zen.localdomain>
References: <3034f66918cf06066b769f4d834905e25824ae8c.1719336718.git.boris@bur.io>
 <CAL3q7H49_gt=GnhOJEfH0eCRywYQfzNmEgcM=QNob9y05Pr+Sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H49_gt=GnhOJEfH0eCRywYQfzNmEgcM=QNob9y05Pr+Sw@mail.gmail.com>

On Tue, Jun 25, 2024 at 06:45:01PM +0100, Filipe Manana wrote:
> On Tue, Jun 25, 2024 at 6:35 PM Boris Burkov <boris@bur.io> wrote:
> >
> > There are no callers with a NULL ulist, so the check is not meaningful.
> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Looks, good thanks.
> Can be squashed into the patch that introduced this function.
> 

Done, thanks.

> > ---
> >  fs/btrfs/ulist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/ulist.c b/fs/btrfs/ulist.c
> > index f35d3e93996b..fc59b57257d6 100644
> > --- a/fs/btrfs/ulist.c
> > +++ b/fs/btrfs/ulist.c
> > @@ -110,7 +110,7 @@ struct ulist *ulist_alloc(gfp_t gfp_mask)
> >
> >  void ulist_prealloc(struct ulist *ulist, gfp_t gfp_mask)
> >  {
> > -       if (ulist && !ulist->prealloc)
> > +       if (!ulist->prealloc)
> >                 ulist->prealloc = kzalloc(sizeof(*ulist->prealloc), gfp_mask);
> >  }
> >
> > --
> > 2.45.2
> >
> >

