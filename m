Return-Path: <linux-btrfs+bounces-13837-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C188AAFFE3
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 18:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 229F41BA155C
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDC327CCEB;
	Thu,  8 May 2025 16:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="u7KFoaw8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxEHGHJq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932B270ED8
	for <linux-btrfs@vger.kernel.org>; Thu,  8 May 2025 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746720334; cv=none; b=JWESjM9wogcSSFywvLkARO2icKzEy+jYLwnZdxqkx4Geladt19LcVlG1LjCpJSjLVOWdNCpv3TR9dL+zCHMZ2+ji148gENx9EkHoZ0cN1zjCThFUGlylV42jw5lfg2w6e7qsXQChG2WktZvkQMZE5irpzY8sRFk3K6PZchOElGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746720334; c=relaxed/simple;
	bh=wzFfD0UTIhAu+DNLpgl0Qvm8vZD+Re94298WNfZc94s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rkb5TD4n3eLHIisniZ5IuhE/rCijCSVwhH3SQrN2/PHmsDoT3qbQOVQ/O1JKWZsPmz5fWf8wtHC3AKwpVHYUJpScym2CM/9DPT4bZ4KLpnICab9XldIOJuAG0B3n25u9DhE0TFsNXqLAMxnpSOzDfqaO5DmwuBJqkR5HD9IGTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=u7KFoaw8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxEHGHJq; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E76A611401C3;
	Thu,  8 May 2025 12:05:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 08 May 2025 12:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1746720329;
	 x=1746806729; bh=fXaP+FZnG0OyB1AQIhR85pAsO4GF23lVyeMzt0CDoHY=; b=
	u7KFoaw8ilQACtFneJz5otWOkbP7FH6s1JRFmFGb/nlwTyJn3C8KaGRWWm9hE8r8
	+dD2ULu1Enf1fdRM318XQJJ4oXs2uEmz9m4YU8n3ADoGwYrtyPRCk5xLtMje7DMY
	BtSaqiaFKt+hp8n0NueHrcb9BuGD6DEbCetcdV/tcnSemSwXz+w7DrlmoNrMNEKQ
	/coUTGKNB3ktky9HDEXkZ7jLv+0BS7mtfF4YpkunyVcZcC04IOQa/0mhQ/xpFXbm
	CY7cK06FR2G3YNgElEIyibh3UOfpTaaYHju/z+L1rWGpYmK/fnOR3nwg57qxpb67
	nfrKGzzzdGr1SDJSTQ9xlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746720329; x=
	1746806729; bh=fXaP+FZnG0OyB1AQIhR85pAsO4GF23lVyeMzt0CDoHY=; b=L
	xEHGHJqyre+FFWnRpbyJvlXFlgjNLfPIzGNXUFREa35J1ml5xNqm9c9giVp/0ieA
	8QTXPi7EBcaTTnnDswZ3iBjoqhzZIi6/JINxvQt0OkOZ7lnryNngy65fWPxihiMz
	hTCsYHLoin0Z2etggBbjHxcqbqiJO8XHiYMJAqMWHqAdC6aXnrlhr1bCVTxcij4j
	17X6XnJXiTw0pTFg82DyTXx15Nk6bDRuVW0h1HW4lcO+fFTaXnoI509fjfBuLdyr
	zO56mQYhXnWyodXOMuiHinMFf8g7xuDsjQsZH7gLJT2GNMpLuCxv+ulK5iOPvVLi
	ujQVyvd3Rp4jjI4LaAT9A==
X-ME-Sender: <xms:SdYcaP-00-HyhOeb8Ye1vTZcXIJl1nQlWpdOJDaR29Igyuqh9Vvx1g>
    <xme:SdYcaLtGy6A7JuaELDlxZHBxCKIBRUXDzYPGUPhYG-P6nmc1zg9JZQ6uWk7YqmpN6
    6TEdQbLtVIiNyjhjSI>
X-ME-Received: <xmr:SdYcaNB33W3A1MXhhylkxo-KI2wy5KNLdoJ0wumKfPG4QI-Nh3GNH-7BV0qF7ux9E9RhHYCmQAHqpAG_xi6Jpx2Py5E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtudejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:SdYcaLdPlNl9Knn9_E8Y8Ev6gwTS3zk7kIBs9yY3Ar2wjvRo8b9jaQ>
    <xmx:SdYcaEMfvE53KrmT8_ApHpb3XrqRII2MuEYaSNxXkVwrCDw6MVKsxQ>
    <xmx:SdYcaNkd2vZUOmU371CQ44Kq5gMIFHpCVQT475ps04kteEUddrx9lA>
    <xmx:SdYcaOs8WTbBH6_oqM0Zo3AbENo-PHqzJlOYZhefz5txJ9zAHeG74g>
    <xmx:SdYcaP5V2IDaNtzbz5twrYzrFh-l4nB8y_vtNFpnPfSTJ0j4hNVa93nR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 12:05:28 -0400 (EDT)
Date: Thu, 8 May 2025 09:06:10 -0700
From: Boris Burkov <boris@bur.io>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix folio leak in submit_one_async_extent()
Message-ID: <20250508160610.GA3935696@zen.localdomain>
References: <a9458a40fed8e6a27ada539372170d52c45967f0.1746652135.git.boris@bur.io>
 <CAL3q7H4tV-i95ORA91LPVBbgOVp8+Ym8=dBqn94+0KgFWiEWSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4tV-i95ORA91LPVBbgOVp8+Ym8=dBqn94+0KgFWiEWSQ@mail.gmail.com>

On Thu, May 08, 2025 at 03:02:46PM +0100, Filipe Manana wrote:
> On Wed, May 7, 2025 at 10:08 PM Boris Burkov <boris@bur.io> wrote:
> >
> > If btrfs_reserve_extent() fails while submitting an async_extent for a
> > compressed write, then we fail to call free_async_extent_pages() on the
> > async_extent and leak its folios. A likely cause for such a failure
> > would be btrfs_reserve_extent() failing to find a large enough
> > contiguous free extent for the compressed extent.
> >
> > I was able to reproduce this by:
> > 1. mount with compress-force=zstd:3
> > 2. fallocating most of a filesystem to a big file
> > 3. fragmenting the remaining free space
> > 4. trying to copy in a file which zstd would generate large compressed
> > extents for (vmlinux worked well for this)
> >
> > Step 4. hits the memory leak and can be repeated ad nauseam to
> > eventually exhaust the system memory.
> >
> > Fix this by detecting the case where we fallback to uncompressed
> > submission for a compressed async_extent and ensuring that we call
> > free_async_extent_pages().
> >
> > Fixes: 131a821a243f ("btrfs: fallback if compressed IO fails for ENOSPC")
> > Co-authored-by: Josef Bacik <josef@toxicpanda.com>
> > Signed-off-by: Boris Burkov <boris@bur.io>
> > ---
> >  fs/btrfs/inode.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 2666b0f73452..9d4b99ba8950 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -1092,6 +1092,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
> >         struct extent_state *cached = NULL;
> >         struct extent_map *em;
> >         int ret = 0;
> > +       bool free_pages = false;
> >         u64 start = async_extent->start;
> >         u64 end = async_extent->start + async_extent->ram_size - 1;
> >
> > @@ -1112,6 +1113,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
> >         }
> >
> >         if (async_extent->compress_type == BTRFS_COMPRESS_NONE) {
> > +               ASSERT(!async_extent->folios);
> > +               ASSERT(!async_extent->nr_folios);
> 
> It wouldn't hurt to still set free_pages to true in this case.
> This is just to be safe and prevent leaks in case running on a kernel
> with CONFIG_BTRFS_DEBUG not set - which several distros do like Debian
> for example (since the Kconfg says this setting is meant for
> developers).

Sounds good. I will leave the ASSERTs, though, to communicate our
current understanding of the state, right?

> 
> Anyway:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> 
> Thanks.
> 
> >                 submit_uncompressed_range(inode, async_extent, locked_folio);
> >                 goto done;
> >         }
> > @@ -1128,6 +1131,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
> >                  * fall back to uncompressed.
> >                  */
> >                 submit_uncompressed_range(inode, async_extent, locked_folio);
> > +               free_pages = true;
> >                 goto done;
> >         }
> >
> > @@ -1169,6 +1173,8 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
> >  done:
> >         if (async_chunk->blkcg_css)
> >                 kthread_associate_blkcg(NULL);
> > +       if (free_pages)
> > +               free_async_extent_pages(async_extent);
> >         kfree(async_extent);
> >         return;
> >
> > --
> > 2.49.0
> >
> >

