Return-Path: <linux-btrfs+bounces-12108-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A65AA574F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 23:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673FC1793BB
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF338257AFC;
	Fri,  7 Mar 2025 22:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="tv/MRDwS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UGJ9lVMD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9FF21CC7E
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741386711; cv=none; b=WUJv6iXvbhOPOFgKOuOQf3O4xjhSZ8VavDzsWRqsQ9DbA7BBGsKtHFZCbRfPvwQGGYQzxuv0hy5efBy3OTY/fUgEvLnYYGBDxZyASZXr0ovGsCSlaJUW7DgSHX2T6u53SDXFPr5UjYhM3Z4Mb5pHzSJuxZhcJzMTG3PQyLBpDLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741386711; c=relaxed/simple;
	bh=/iepEB7BPJ3uw5N+5foZMP4pF+tX20utcRcZMMjQwrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJMsMC1s6+sdAtuzZ0LuUpikQu+aI0DLHefZCNUfsABSG8TWjnM7w/meoamhGP+2XNiHboD2QzC5NlsrDy/wAVmxSZI2LUgl6jiIUQ0C6rYejHvgXeIBMJ7eul+lgvXAsyUw5GR6MH6X3DkozPEtdRj1E09+n9yAfZfIfxInGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=tv/MRDwS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UGJ9lVMD; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A082B254010F;
	Fri,  7 Mar 2025 17:31:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 07 Mar 2025 17:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1741386707;
	 x=1741473107; bh=W78P/zHdxjiAbTTCPbHUu+58qW4szjyep23aZRz0IDE=; b=
	tv/MRDwSY5Qg3yPfKN2cHdI+6Gl8cmntQwoJBlszndgYQaMPHuSLiXdz3Kq8WrxJ
	gUz7a6lwfUCVfOaFjqyp+3yZdrbzuiMECNTy1beYZ+fZ/lzKciPCVQK86EdLL9YR
	T3HNrgXcswhlJ76ibs1IiakbANROojdTzF2yVmylxYeIUouyu+K018L+7VJoyIZo
	rCTB0orSQNa6OyA0ELtQoilVLH50H59Tr2yHC1cZbNjhXcm/KFeKsjarJaCWziVE
	VQSjvoqe1wfxkMGSZTH4GhP+E1yQcUDX4VW0tjKMYkqJ3nMadqLk8IZjhHlBZlSO
	EOfky9eXC4c44ZDgzzAesw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741386707; x=
	1741473107; bh=W78P/zHdxjiAbTTCPbHUu+58qW4szjyep23aZRz0IDE=; b=U
	GJ9lVMDvnuUeXzvrAY+2+DeV4jB1aRsIJXfqCXBdEbPxZGGrNEdShJ5TPbrSN1WB
	N65EJTdMN+4xxBy8h+u97R1T4uvpqiDEru9MNLvzm+dNK79D4ZPAd81NI6Cq6znD
	9SzcQU6CZRbtBeEDzNj6orhuO85cIbpEGOuVhpTjHdShNeVLGQYiap+Owb0o0MRF
	MXHLQauAhUXFz3ciltn8CUGAZQwwFB3QQJbyeYFl4WdACqX9UTydbz5Efg+ksOiY
	F6InMNS3xRdrbXt5FuUoIbMfpBPpOV3/mYIu0/MQBn1mWM+xdTC8v5a9aqdBuKtz
	GLduln/Xkd0fx+1RNY+XQ==
X-ME-Sender: <xms:03PLZ0pW_CBQ7-OIXFfcm-71rBmnq_5xwTaYPfxevvOCBjCIkImEFA>
    <xme:03PLZ6pVJcGLD3cpYdpbOUK99sjqSM-qFzKDOrOc4HuGCxxW1U1a9QMEd6a5bafbO
    of3KVuYtiv3UdOsMow>
X-ME-Received: <xmr:03PLZ5ON9COgHNp23zmF2X5vozCH6E2J0CyzjxZNFRbxRkgSP-WTZeZk4-DlOipAD7bgYACgval2qE7Swm9KEXYkwdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddukeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioh
    eqnecuggftrfgrthhtvghrnhepudelhfdthfetuddvtefhfedtiedtteehvddtkedvledt
    vdevgedtuedutdeitdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:03PLZ77FuUjji6_n8Mp5vBWcZYKQwuvev7eQAzAXQcvOKmTAvK084g>
    <xmx:03PLZz6qLSrcTsQSYfhUCxGPbVq8G5TXN0iyicyphWoHf797NonhTQ>
    <xmx:03PLZ7jMczLHgddPsalG4SjCTfiBpX0hrazeujoCx4AgWvTNbxN8nA>
    <xmx:03PLZ94LeUEWmj1a6Jlkduuf1p9k4fVtu_hYTAUOZL69WQZzsqH8Gg>
    <xmx:03PLZ1kRVDGJOzt8JF_Jic70e4U3IS_BNQGeoctXDy3NacQnIO7U0RN6>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 17:31:46 -0500 (EST)
Date: Fri, 7 Mar 2025 14:32:39 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/5] btrfs: explicitly ref count block_group on new_bgs
 list
Message-ID: <20250307223239.GA3585120@zen.localdomain>
References: <cover.1741306938.git.boris@bur.io>
 <817581cbc85cfda4c2232fecbfdb6b615b7067ca.1741306938.git.boris@bur.io>
 <CAL3q7H75p9GUAav64pvTZf4SVpQ=rbcVHAuo5zUEeAytkxXkYA@mail.gmail.com>
 <20250307214040.GC3554015@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250307214040.GC3554015@zen.localdomain>

On Fri, Mar 07, 2025 at 01:40:40PM -0800, Boris Burkov wrote:
> On Fri, Mar 07, 2025 at 02:37:28PM +0000, Filipe Manana wrote:
> > On Fri, Mar 7, 2025 at 12:31 AM Boris Burkov <boris@bur.io> wrote:
> > >
> > > All other users of the bg_list list_head inc the refcount when adding to
> > > a list and dec it when deleting from the list. Just for the sake of
> > > uniformity and to try to avoid refcounting bugs, do it for this list as
> > > well.
> > 
> > Please add a note that the reason why it's not ref counted is because
> > the list of new block groups belongs to a transaction handle, which is
> > local and therefore no other tasks can access it.
> > 
> 
> Just to make sure, I understand you correctly: you'd like me to add this
> as a historical note to the commit message? Happy to do so if that's what
> you mean.
> 
> Otherwise, I'm confused about your intent. If you are saying that it's
> better to not refcount it, then we can drop this patch, it's not a fix,
> just another "try to establish invariants" kinda thing.
> 
> > >
> > > Signed-off-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  fs/btrfs/block-group.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > > index 2db1497b58d9..e4071897c9a8 100644
> > > --- a/fs/btrfs/block-group.c
> > > +++ b/fs/btrfs/block-group.c
> > > @@ -2801,6 +2801,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
> > >                 spin_lock(&fs_info->unused_bgs_lock);
> > >                 list_del_init(&block_group->bg_list);
> > >                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
> > > +               btrfs_put_block_group(block_group);
> > >                 spin_unlock(&fs_info->unused_bgs_lock);
> > >
> > >                 /*
> > > @@ -2939,6 +2940,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
> > >         }
> > >  #endif
> > >
> > > +       btrfs_get_block_group(cache);
> > >         list_add_tail(&cache->bg_list, &trans->new_bgs);
> > >         btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
> > 
> > There's a missing btrfs_put_block_group() call at
> > btrfs_cleanup_pending_block_groups().
> 
> Good catch, thanks.
> 

Actually, just for the record, the btrfs_put_block_group *is* there,
it just was the mystery btrfs_put_block_group from the other patch
that you also noticed. So that put should be in this patch! I think
that will make both of them make more sense.

Good eye.

> > 
> > Thanks.
> > 
> > 
> > >
> > > --
> > > 2.48.1
> > >
> > >

