Return-Path: <linux-btrfs+bounces-12731-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB6CA78063
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 18:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0409A188DD06
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Apr 2025 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41B020F07C;
	Tue,  1 Apr 2025 16:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="oifTJfpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D6llVK+X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21F71F09B8
	for <linux-btrfs@vger.kernel.org>; Tue,  1 Apr 2025 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743524380; cv=none; b=a2x5ErdF976Kex++5+5dcdj5pgGjR6jNgCZfgBVxguy1FqiRWdgNYF/XvlvzoXH6RkyE53qsrKyG75xd26qIfKbDkYojD1bPhVD5PVdUfGs7K5gQ0f0gUkWeZjcfCPhNNowQnb0reTwgO9DKymnHKz8X9dtsK/uWc7e0KZzNIV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743524380; c=relaxed/simple;
	bh=75U2PpIpl7LKKR6tvx06CMTiceFclCMUXGHikpFF1ZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqProwu/KZ9VQiA8mV6Waow2XG92/EhvEq4p3To4xQyGbkA8+o5H7/xMj24WzqMJgHFaViFYRbb3HxICvDHwvxTAg/feSTYrRjpqEsCt19ttUalVw5bI6Dc21rPTNAKhaCiVohGQlRjq9jjFkEq8zxGvh+SBiA/NWo6p65CedDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=oifTJfpX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D6llVK+X; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E720C11401A9;
	Tue,  1 Apr 2025 12:19:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 01 Apr 2025 12:19:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1743524377; x=1743610777; bh=oDRkWmlL0t
	J+aCnKvWlaU2njZNhPLWRU/+1fHNv0zHs=; b=oifTJfpXROqtkoBcXYHE5hiY7y
	4w5ryFeeiKliXuIcu6zM8CDffQlQlRkzJ+rygmoYoKXnB1eEZxX8BrSB6hlJE6dj
	gJ4YrBTMnP/Taf5I7GB/RKc4uC3TQdeZts0iljZbQzQ19yvpXiOlOBVVoGyLgWD/
	c8GvqVafmSiRARmTPp0URt9af57hDedXYY1/92dUxV66ArWZIjOCt7y/fxUqhsA5
	Ks0YIdzU+HUoFX973Sat10hnrTCXRXLHIZ9CAs4/5OjzG2YktmAlIg60N5JStOxL
	XXoEOU3lwo6WgVpr1Es+6Sd7jGyUdbanuENSzVnt2XzB0K78b8mU+CGd2NGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743524377; x=1743610777; bh=oDRkWmlL0tJ+aCnKvWlaU2njZNhPLWRU/+1
	fHNv0zHs=; b=D6llVK+XnP9ye8mMvmui3wr8oFeMAHEXMmV9UdO6b8oCDzrAKrr
	zXqSrdFjaSqpnuL7TRcaNGmceEthVTxireen9Zmgn1w9y2dzF+CBgfhOadfN0Iuo
	N1CBaUZfukMOYq1yvZe+wOb6P5Q9TbdcIIX+gVXHABwo0Y7h37f2vdhjGn0zgvbH
	pTwPestEMJGSHW/zcTCDuk30+Z7zdJKrQk2bsnwK+0mHV1RKCQS/2Bfq4zPCX1LU
	QhDZx5kigqnevPY/W9jWWOSCBjUyDfr4SznwxXDF2uUpzer90xqcXKL+4y1TgaKV
	t8mvhLeANzbcYKTKRTrFIKHiqMKBsEgNrIA==
X-ME-Sender: <xms:GRLsZ7Su3rgVSdwVc2qpJE42Y2poTkS7gxu41GRsOYLnHqjo1kXg0w>
    <xme:GRLsZ8w2rDVUJo5sqaXzhCGHrfcb-VUwhA0kNIsj7VFRlwQjYHazbWtbyz9g-qGMM
    NNWJh2GpbajgHQZaY0>
X-ME-Received: <xmr:GRLsZw31_vYzBH6WBkmX03u__5zRxZG_thuBgvMt1iuZbmVDWUmhq4_XbTn3bqtBej7gtIcaAAASWihy-2Zxf5QSWNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GRLsZ7Bwl61WeDLVA47MHJYmYuVIb5fS0yRnMcST2LDjlmvgn6ImhA>
    <xmx:GRLsZ0jfPLdOVrCJS5ig2lCxI5E8xYDZgra5D5UHqhLXEVTiNKgbrQ>
    <xmx:GRLsZ_pdzHw6L-0kTRFmmPKS1kqwZ2cyxD1xN8o3JN1MhKtyDqx6SQ>
    <xmx:GRLsZ_gwiKCdFROUIxMShZiV2PtQzprIviP7nNcfxjAU1M5w5Rinog>
    <xmx:GRLsZ3uNuSf4O4Di2B28AlNh8DdhdS9N3g20nHE7vzU2_V5c-msZ2aI7>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 12:19:37 -0400 (EDT)
Date: Tue, 1 Apr 2025 09:20:22 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/2] btrfs: two small and safe fixes for large folios
Message-ID: <20250401162022.GA3217546@zen.localdomain>
References: <cover.1743493507.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1743493507.git.wqu@suse.com>

On Tue, Apr 01, 2025 at 06:20:27PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Fix a bug that page_pgoff() usage lacks left page shift
> 
> Two small and simple fixes.
> 
> The first one is that with large folios, we can have order 6 folios which
> reached our current BITS_PER_LONG limit, triggering a previously
> impossible ASSERT(), which is based on the fact that our largest page
> size (64K) can not reach BITS_PER_LONG blocks per page.
> 
> An easily fix by extending the ASSERT() condition to cover
> blocks_per_folio == BITS_PER_LONG cases.
> 
> The second one is a little more complex, that with large folios, if we
> still go through the single page bio vec iteration, we can not call
> page_offset(), as non-head pages of a large folio do not have their
> page::index initialized properly.
> 
> Fix that by going a helper using page_pgoff() to calculate the file
> offset, which handles both head and non-head pages of a large folio.

LGTM, thanks.
Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Qu Wenruo (2):
>   btrfs: fix the ASSERT() inside GET_SUBPAGE_BITMAP()
>   btrfs: fix the file offset calculation inside
>     btrfs_decompress_buf2page()
> 
>  fs/btrfs/compression.c | 18 +++++++++++++++++-
>  fs/btrfs/subpage.c     |  2 +-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> -- 
> 2.49.0
> 

