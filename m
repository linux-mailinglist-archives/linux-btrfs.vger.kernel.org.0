Return-Path: <linux-btrfs+bounces-13408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA7A9BB51
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 01:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7FD79268F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 23:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BC328B4F2;
	Thu, 24 Apr 2025 23:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="YwWAcZXj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2B6GA05"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17FC1F463E
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537419; cv=none; b=SMeLusw7EO5gIw0TxiKaiTNr9uZ5KqBz+gkGXy62mujj7b12oTRSr6EBsuMney9TGFVbrvksPQP7hZgFaYBoHhvo+Hk9C8FZCuNkzRxMNYWSmNLr08J9zRq1DGeodNNDaycOjU+gfP1luddUpcQEBQu9GynfOqsC1IpmuGp4T/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537419; c=relaxed/simple;
	bh=eKYDbIID1krZB/k7C1pJsXVTx88I+BOGYy3wzMVedGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsIgTI6R5P7wIQFGre3tAbcR9gcp+Fv6u5ESIOWRMiRG0ZO6DRf0dC+863o8OCuvD18dgcEWiiZMrz+BbneZpVOw5yxA2eXh/xwBg77B+HkeWKn4PyyNUKjDpgE138mfc7aDIvmG7b7rTdb7nirq5xxq2DvP46o4rg8dhYpTx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=YwWAcZXj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2B6GA05; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B565C1380201;
	Thu, 24 Apr 2025 19:30:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Apr 2025 19:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1745537413;
	 x=1745623813; bh=eV8fD3xRMU9eiTCzCaOABbsHykC4+MpkNfiT2YxsbtQ=; b=
	YwWAcZXj41fOlZEELxQdrP0FJeQAHejUTPYBYXMH35TwT/yhOsD6Dy65zJWZUpxN
	7K1VzvGvBgyNdyuN/ttha47VaVAoAmCfzT8PZZrRpXqCIzMIxwq2OPgyxI6KJBg1
	JvLW4fd1K7++uhWkUuLgnjSNTCeiX8P5LNAhMCp9d5F09uGc2Rfii4rnjw7+C18I
	tJ9iYuSRhTsEDJ3s33tY8Ssv1yIvx0UpEEBtk0paLIJY3Xd3EH4k0EbxGkn6BYPz
	Ngb5Yu7uIhZJ0JYMHhtAwUk6gjWxzRL8YKsYqNOnM+QrlP2XqqqJ24BS/uEXMDbS
	QSvVQ3AxxspThDkzsASpnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745537413; x=
	1745623813; bh=eV8fD3xRMU9eiTCzCaOABbsHykC4+MpkNfiT2YxsbtQ=; b=X
	2B6GA05fnWYY6sjruZqEJJoBSTeycVESx3iNMYZTTrRijK3LU7NAf+FueYAhurKV
	jS5RBKYA7hOgAlEy84oBUnnff/ocZyS4jbWxK2Xk+KofhZtYTJl62k4fEXT9MIb+
	zwV4GofLDO5ND+ja4JmMvf0PHKoVaIOr/25OkcUqpiJZc8AUCqTLRt3Liwv3WYnK
	6HuF+v1JIwnZajADALqdZWDDM2N33K3kQ0ryPsodvvwtlA3tVe8v/0W44nMv4Vuh
	aDVOk+ZKbXY6vAIzC+OjnHb0xulw9G3b4ioOrGPCo385BIu9NqIjRFLqgJUrQfBp
	bT4kei/4KQyNxprvBP1sg==
X-ME-Sender: <xms:hckKaKK0v2TchEzyqPwCORJ5N5R0gL7lmUrt3E2QZ_c1MrgvCCzYGA>
    <xme:hckKaCKRN2vTmNWi4iD4X2YMgyCs51VD5JQ0_bJ8HzdQa_axW8ziIIg_mnrOjSkgR
    uEodbJ1vx_XJPpedTg>
X-ME-Received: <xmr:hckKaKuvxdGipcchoUQU2n2iD3OzuHMxVmap7XfZnn-aKs7s7isiRoytj7EKO4S-GBmnYcNdNatHG1QKuBGv8jvZb9Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtth
    hopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:hckKaPbZhm1No99zWw1myF4ITTlXP3ANIU41z04THdEcb531WuzX4w>
    <xmx:hckKaBaWSUk3JED6TsRHG7Yuztne1-EUA3mYLys9Fx9d9FGX9wnEYg>
    <xmx:hckKaLBHW0JosXaVpsHa7y8Lyp0b62w8lDjGlMYJkRv52Z03o3_HMA>
    <xmx:hckKaHY3I2xsg2KzRjBCMj-OGglVn0IE3y6yNlQo_BEW8pO61tG34Q>
    <xmx:hckKaBpf88o7PkKr_PU6ng6SgUn_4hPcfqdz5yJRA7H1femgywyQ71Yz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:30:13 -0400 (EDT)
Date: Thu, 24 Apr 2025 16:31:17 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
Message-ID: <20250424233117.GA350350@zen.localdomain>
References: <3a03310eda52461869be5711dc712f295c190b83.1745531701.git.boris@bur.io>
 <9b32db21-e116-4eb5-9a54-7cc23a737523@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b32db21-e116-4eb5-9a54-7cc23a737523@suse.com>

On Fri, Apr 25, 2025 at 08:11:34AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/4/25 07:25, Boris Burkov 写道:
> > If btrfs_clone_extent_buffer() hits an error halfway through attaching
> > the folios, it will not call folio_put() on its folios.
> > 
> > Unify its error handling behavior with alloc_dummy_extent_buffer() under
> > a new function 'cleanup_extent_buffer_folios()'
> > 
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >   fs/btrfs/extent_io.c | 55 ++++++++++++++++++++++++++++----------------
> >   1 file changed, 35 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> > index 152bf042eb0f..99f03cad997f 100644
> > --- a/fs/btrfs/extent_io.c
> > +++ b/fs/btrfs/extent_io.c
> > @@ -2829,6 +2829,22 @@ static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info *fs_info
> >   	return eb;
> >   }
> > +/*
> > + * Detach folios and folio_put() them.
> > + *
> > + * For use in eb allocation error cleanup paths, as btrfs_release_extent_buffer()
> > + * does not call folio_put().
> > + */
> > +static void cleanup_extent_buffer_folios(struct extent_buffer *eb)
> > +{
> > +	for (int i = 0; i < num_extent_folios(eb); i++) {
> 
> What if we hit error attaching the first folio?
> 
> In that case eb->folios[0] is still NULL, while num_extent_folios() will
> call folio_order() on NULL.

I don't believe this is correct.

Whether or not eb->folios are NULL is determined by
alloc_eb_folio_array(), which sets them all to non-NULL if it succeeds.
And we only call cleanup_extent_buffer_folios() in paths where
alloc_eb_folio_array() succeeded, otherwise we jump to
btrfs_release_extent_buffer().

I also don't see anything in btrfs_extent_buffer_folio() that would set
the folio to NULL on error. Furthermore, that loop also assumes the
folios are non-NULL.

If you agree with my analysis, would you like me to add more
documentation of this pre-condition of cleanup_extent_buffer_folios()
beyond just the ASSERT(eb->folios[i])?

> 
> I think we need to enhance num_extent_folios() to handle ebs without any
> attached folios.
> 

That's a cool idea! Make it return 0 if eb->folios[0] is NULL?

I was also thinking of making a refactor to make
btrfs_release_extent_buffer plumb through a variable that decides
whether or not we do the folio_put() (basically for normal calls vs.
these cleanup paths) and get rid of cleanup_extent_buffer_folio() at the
cost of a weird parameter in btrfs_release_extent_buffer. Curious what
you think of that idea.

Thanks for the review,
Boris

> > +		ASSERT(eb->folios[i]);
> 
> And even if the first folio is properly attached, we can still have an eb
> with part of its folios not yet attached.
> 
> Meanwhile the original cleanup inside alloc_dummy_extent_buffer() is doing
> proper check other than ASSERT().
> 
> Wouldn't the ASSERT() be triggered unnecessarily?
> 
> Thanks,
> Qu
> 
> > +		detach_extent_buffer_folio(eb, eb->folios[i]);
> > +		folio_put(eb->folios[i]);
> > +		eb->folios[i] = NULL;
> > +	}
> > +}
> > +
> >   struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> >   {
> >   	struct extent_buffer *new;
> > @@ -2846,26 +2862,30 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
> >   	set_bit(EXTENT_BUFFER_UNMAPPED, &new->bflags);
> >   	ret = alloc_eb_folio_array(new, false);
> > -	if (ret) {
> > -		btrfs_release_extent_buffer(new);
> > -		return NULL;
> > -	}
> > +	if (ret)
> > +		goto release_eb;
> >   	for (int i = 0; i < num_extent_folios(src); i++) {
> >   		struct folio *folio = new->folios[i];
> >   		ret = attach_extent_buffer_folio(new, folio, NULL);
> > -		if (ret < 0) {
> > -			btrfs_release_extent_buffer(new);
> > -			return NULL;
> > -		}
> > +		if (ret < 0)
> > +			goto cleanup_folios;
> >   		WARN_ON(folio_test_dirty(folio));
> > -		folio_put(folio);
> >   	}
> > +	for (int i = 0; i < num_extent_folios(src); i++)
> > +		folio_put(new->folios[i]);
> > +
> >   	copy_extent_buffer_full(new, src);
> >   	set_extent_buffer_uptodate(new);
> >   	return new;
> > +
> > +cleanup_folios:
> > +	cleanup_extent_buffer_folios(new);
> > +release_eb:
> > +	btrfs_release_extent_buffer(new);
> > +	return NULL;
> >   }
> >   struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> > @@ -2880,12 +2900,12 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> >   	ret = alloc_eb_folio_array(eb, false);
> >   	if (ret)
> > -		goto out;
> > +		goto release_eb;
> >   	for (int i = 0; i < num_extent_folios(eb); i++) {
> >   		ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
> >   		if (ret < 0)
> > -			goto out_detach;
> > +			goto cleanup_folios;
> >   	}
> >   	for (int i = 0; i < num_extent_folios(eb); i++)
> >   		folio_put(eb->folios[i]);
> > @@ -2896,15 +2916,10 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
> >   	return eb;
> > -out_detach:
> > -	for (int i = 0; i < num_extent_folios(eb); i++) {
> > -		if (eb->folios[i]) {
> > -			detach_extent_buffer_folio(eb, eb->folios[i]);
> > -			folio_put(eb->folios[i]);
> > -		}
> > -	}
> > -out:
> > -	kmem_cache_free(extent_buffer_cache, eb);
> > +cleanup_folios:
> > +	cleanup_extent_buffer_folios(eb);
> > +release_eb:
> > +	btrfs_release_extent_buffer(eb);
> >   	return NULL;
> >   }
> 

