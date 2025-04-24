Return-Path: <linux-btrfs+bounces-13407-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BADEBA9BB37
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Apr 2025 01:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDCD51BA4599
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 23:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B228BAB6;
	Thu, 24 Apr 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="g44RX/Nf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hpuDb+H/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00DC21CC68
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745537060; cv=none; b=eQ73FSw3nkyxdsBjigKrPyNCt7UOTH2b1hFSJB2YRuSCsy4n4Ih8qBZZD0RPvegzmRJ4ua6exT1m/TiXC+wVHZpBSTBDcBFdcSYOKXhAbMQry12khITLM7Di2NVOA2norjnaffA3xoZf5NC+UKKXbYGjFVczw2GMkIWRPQdStkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745537060; c=relaxed/simple;
	bh=UdbjTx6rPNEd8WmxJCzKj7wS5VIYxP94jWJGY/+mJMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD3+fVZRfy+3YefeeSe0gaPT0BgAJEAUVAv3mZGHTnEUWeDp3qOj42RR4I2nk9lDcvVeNHHNOutJ121HIIo3BoYZ02gPUblcDrHIPk+jvvnzeXtsbfR1YZFkWSBqwKYGGfqo1s5dVxREOTnY8B5mNS+oLV1RrvYA/BjtHy+EBf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=g44RX/Nf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hpuDb+H/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id AB74C1380210;
	Thu, 24 Apr 2025 19:24:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 24 Apr 2025 19:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1745537055;
	 x=1745623455; bh=eljRg4aYVplxvq+wGnNur1FAm2LC1Vrn/RVMZ2SYx3U=; b=
	g44RX/Nfng3H66j7IBg+7gsPaN720hpXzLKt0D4PZeLV6btFCY3tJCJlDeQcaQnR
	ePzJcxfrDRAMRHvkLAAyXVzrxGKMorS2saYoYpd/+O/uH5NwQBNkg9JvX92GWKmU
	81jo/tle6LyfaHY7skYp7aRdheAR+PhzgMtbMoeKXUpyM23HVtKEWgRev3N5Gpiq
	w+KgLJ/+ykmKk33EFFJN60YYz7ja1QUIcYgINX0HIZTsjom9Xg/HEUrsFHMFdIml
	uCf1ZNJWaMjtWQ+Du6H3cwWIHV9wvN12rQORYccm1xWcx+d15HXU3l3IpX5lzIp+
	6Wdei++x0iVy+1HNko7N9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745537055; x=
	1745623455; bh=eljRg4aYVplxvq+wGnNur1FAm2LC1Vrn/RVMZ2SYx3U=; b=h
	puDb+H/TDicA2Oh44PM/92DPP+weOTfo8l+XZzFCbv20eE1wKzqRKXshhnYCQIBC
	IUBM61HAh0IioTZA6py34e+QbOHs7Dfw5vtWNbTxEfnIqtWFxRTMAfVXpB6FPsxx
	58ePcuBTP89zBfrsFcpAa4/apPWmlT3Eb6FWq56CtVJxgirjSSj4MhuOcP2Ud53D
	85ieE1XlLv2kbhKTD1E1AbK3aQ2R8j7rm49AUOmK2s0dIY6j+iZT16QaYVPWB64m
	2nrZhhX8o5mBiEYkpQ35wLk+BXwlnMkSeIwWUQqCXQPAfIcTwOWjAN7rX4Qxsu3u
	coKN2PR0DjT7FbK3QJl2g==
X-ME-Sender: <xms:H8gKaKQavygVgQxOU3qMo2Rf3flRApMGCC3pHG5HTVSrV-JoZ9PKXg>
    <xme:H8gKaPzLcxphyDWwUj3HvLzq3eb7HoSKXomTzjPTNsiinw-lmHmWXDURSlemTSnBO
    WxC22BLXQ_w2YMaejE>
X-ME-Received: <xmr:H8gKaH2aQthvZPZQjvybbCd3PcVJW2furWYi-XbwmD1ovTjXoyO1hiRhjoHj35lB8djIIy6RivabN6yNnjTCbcIjEhQ>
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
X-ME-Proxy: <xmx:H8gKaGCBRwEyo0RmFT65W1DVliOKEB0g3fhfDxckPl2LLsL-3JlGPw>
    <xmx:H8gKaDgacooutMP6e5ieVirZ02bLcDwGrXKv_0DZwoXC0xg5KC5w4Q>
    <xmx:H8gKaCoWqrKfWpsTsQLwRY-nbRPf3K5ndYzN2I-lsamFKJZh74D8QA>
    <xmx:H8gKaGi9qi-W6--fmNUan6afwJzX_rMwE4bpZaWGq9QPLlb583qszQ>
    <xmx:H8gKaMRmAixuaTmqslHDxls-T3e4WYN4hU4bZOMxuYlDy4s8jZLu5CbT>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 19:24:14 -0400 (EDT)
Date: Thu, 24 Apr 2025 16:25:19 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix folio leak in btrfs_clone_extent_buffer()
Message-ID: <20250424232519.GA321466@zen.localdomain>
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

I believe that attaching the folios is not relevant to whether or not
they are NULL.

eb->folios is filled out by alloc_eb_folio_array() which returns 0 only
if it allocates all the needed folios and sets them in the eb array.

And we don't call cleanup_extent_buffer_folios() from paths where
alloc_eb_folio_array() failed, we jump straight to the release_eb label
in those cases.

This is further supported by the calls to attach_extent_buffer_folio()
assuming eb->folios[i] is non NULL. Finally, I don't see any logic in
attach_extent_buffer_folio() that would set eb->folios[i] to NULL.

If you agree with this analysis, I can document this more explicitly
than just the ASSERT as a pre-condition of this cleanup function?

Alternatively, I was thinking of a no-functional-change followup of
making folio_put() an optional step in
btrfs_release_extent_buffer_folios() so that it can not call folio_put()
during normal ref count driven frees but to call it in these cleanup
paths.

> In that case eb->folios[0] is still NULL, while num_extent_folios() will
> call folio_order() on NULL.
> 
> I think we need to enhance num_extent_folios() to handle ebs without any
> attached folios.

Not a bad idea! Return 0 if eb->folios[0] is NULL?

> 
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

Thanks for the review,
Boris

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

