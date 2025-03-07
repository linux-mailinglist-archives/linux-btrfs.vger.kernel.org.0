Return-Path: <linux-btrfs+bounces-12106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA12A573CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 22:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 389B4170E35
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Mar 2025 21:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F41257452;
	Fri,  7 Mar 2025 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="QunrMQcm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7P8f54QB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBDA1AA1D9
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Mar 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741383590; cv=none; b=ZneNO/Z/DVWBeBSLewR6Dke3Xla/H+fGwOLsa2AtJ9oJaspyRauvYSSeSDLVG2AJO4it6g3+lfzbV+zbQ2MXqhH495CY9RpZbZLrCN299KXT6toptrXLRAJfYy2DL5VKmXil5LZkfpFXgKSZsjperTPutS2dljsGsrs+31yZ7/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741383590; c=relaxed/simple;
	bh=FOvF6icIufMmz9YD9rO0NwyJ1d801IfWOcw9g7mJSxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZjx/ldO2KvzAYRBxwMEBgaTKJuKRW61s5vtpfw71ZxBNagrDbrKBwd/yfBPZ0PizAZYOgbs6ywLqpJrnY0a9nFsUQNGRe5Uzgqsx1XUFjSAOzvDLfGVyecdnJC/TQAaouczP6gvxbck4AMW+CRfNPjTxguLv1ql6M0g4o6uwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=QunrMQcm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7P8f54QB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 9B5B21140195;
	Fri,  7 Mar 2025 16:39:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 07 Mar 2025 16:39:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1741383587;
	 x=1741469987; bh=no6DVR45LnkKAZfk68ah4Qg3THqJ7pP2CMs9sDSiiOU=; b=
	QunrMQcm97+QLUy4Otb7sitJ+pz3HC25WVyKVxm+c7z6AC8F3SGoSuFm0h8rLEG9
	McITITW2gvFsBBHQxl3pqSeuaLYklOGOz+TnhUCCoaes3n3izmJQQheN1bo6S1M6
	NBzYD0EPB5rHTVQaovHmi7CZk7oUNd2g64+FN/9OPFodzAk2Qu4C8xFuGwQnMqRJ
	m+92d5zhcQixNGIrDF5+lpNzfJH9q+g9qhafhnPPgjWwAkRcq1V/mEInLKAb1Lkf
	ssjwaVDO38yp0vkgtx0LsY14yi/s0pzRR64qpxp70hIWJlSUVvu7nfRQzM9Q1Y+R
	CAqFCIZRRtwwt4spaG5i/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741383587; x=
	1741469987; bh=no6DVR45LnkKAZfk68ah4Qg3THqJ7pP2CMs9sDSiiOU=; b=7
	P8f54QBCRSJz05fuhCGZ22KNbotgEt2u7yBifKn/RzC5lg9DzutVa2seh8MK4+dB
	dG4Z4hA3d3zzp1k+crFJB4CEHhoTzDQoGx/iiSyQt3eSSNMEO1Akl1CcY0ceLUk6
	G4hKnGuMkAPBTiBQfT1MgdJvQt4WNgcdwUQCRtM621pT05h1dDiS7HY3erORNO4p
	++fGpKgbP1cGt7PdeDBg0/q03sJjO4+ae/KndnVeayxproJZuEUAETGEPyE2oO/S
	y0qHLCNWxflS5aRMqzJIfW2GJmAAwdOVEvVBkbAP5uLEPz3S2EM/J4E+ZI0125/l
	MsozzBKPsTTPflTY9fmzw==
X-ME-Sender: <xms:o2fLZw19n2ic4wpjBgwLbaeb6IG7vev-2y8T6DQDuth2nPF6T-733A>
    <xme:o2fLZ7EINKxkVG5BT5LrzgK-ZnzBNH9kY2oLX1K1hvzLtvPyfkbdrrzj5awJCd7i7
    jDO2rcKYyaLphb39Tc>
X-ME-Received: <xmr:o2fLZ44Rg4p8Xen8ZNr4ySHJv92GvWGx_99LTIs9zeLXuZ8wHcIigvlZFWpJyTlrxPTNJln92nJr4rTaScb8M3ngxdM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddujeeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:o2fLZ515X1OrsYa41hBwjUuOFtGzFQQqstQzwHuyinBsTvU1tgChYQ>
    <xmx:o2fLZzGa6cWyFTXzOjSiQbzC6trCpC2H_udpm1bh5ofYBjeT2APFXQ>
    <xmx:o2fLZy9JEUnUklUD15_roRQjd_jSKkcANqmZtCqsWl1z9JMsX-mA-g>
    <xmx:o2fLZ4n0DVDvfsJO9bNUI7zEPl0XdEAdEz41VKX04WeNV9pYiu009A>
    <xmx:o2fLZ7AFItKYvaE7h7J-gKP7f19q7TgY8TftdkSz94ZRmn4YWav1QEYW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 16:39:46 -0500 (EST)
Date: Fri, 7 Mar 2025 13:40:40 -0800
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 4/5] btrfs: explicitly ref count block_group on new_bgs
 list
Message-ID: <20250307214040.GC3554015@zen.localdomain>
References: <cover.1741306938.git.boris@bur.io>
 <817581cbc85cfda4c2232fecbfdb6b615b7067ca.1741306938.git.boris@bur.io>
 <CAL3q7H75p9GUAav64pvTZf4SVpQ=rbcVHAuo5zUEeAytkxXkYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H75p9GUAav64pvTZf4SVpQ=rbcVHAuo5zUEeAytkxXkYA@mail.gmail.com>

On Fri, Mar 07, 2025 at 02:37:28PM +0000, Filipe Manana wrote:
> On Fri, Mar 7, 2025 at 12:31 AM Boris Burkov <boris@bur.io> wrote:
> >
> > All other users of the bg_list list_head inc the refcount when adding to
> > a list and dec it when deleting from the list. Just for the sake of
> > uniformity and to try to avoid refcounting bugs, do it for this list as
> > well.
> 
> Please add a note that the reason why it's not ref counted is because
> the list of new block groups belongs to a transaction handle, which is
> local and therefore no other tasks can access it.
> 

Just to make sure, I understand you correctly: you'd like me to add this
as a historical note to the commit message? Happy to do so if that's what
you mean.

Otherwise, I'm confused about your intent. If you are saying that it's
better to not refcount it, then we can drop this patch, it's not a fix,
just another "try to establish invariants" kinda thing.

> >
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/block-group.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 2db1497b58d9..e4071897c9a8 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -2801,6 +2801,7 @@ void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans)
> >                 spin_lock(&fs_info->unused_bgs_lock);
> >                 list_del_init(&block_group->bg_list);
> >                 clear_bit(BLOCK_GROUP_FLAG_NEW, &block_group->runtime_flags);
> > +               btrfs_put_block_group(block_group);
> >                 spin_unlock(&fs_info->unused_bgs_lock);
> >
> >                 /*
> > @@ -2939,6 +2940,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
> >         }
> >  #endif
> >
> > +       btrfs_get_block_group(cache);
> >         list_add_tail(&cache->bg_list, &trans->new_bgs);
> >         btrfs_inc_delayed_refs_rsv_bg_inserts(fs_info);
> 
> There's a missing btrfs_put_block_group() call at
> btrfs_cleanup_pending_block_groups().

Good catch, thanks.

> 
> Thanks.
> 
> 
> >
> > --
> > 2.48.1
> >
> >

