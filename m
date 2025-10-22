Return-Path: <linux-btrfs+bounces-18167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4964BFCDAB
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 17:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D71684E9CE4
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Oct 2025 15:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B30032AABC;
	Wed, 22 Oct 2025 15:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="e+H/Dz+k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c+zYMw5+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E334844D
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Oct 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146713; cv=none; b=W9W7Inq3t+RqULYuPQxmLqs2FVz1y/MvLDdqUCjiB5OHUSbLI9/kLAGXfhO3SvRYydT/XeiNbi6US+slYmzl68pIIyQx/4oDm80Y5x5dc6eh/C228IDRWRHzX1726KeBgE50UmULx2+eLgNewcx8NZdvjNry/BYTmPwASKtmI34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146713; c=relaxed/simple;
	bh=HlsTn/Tazk8R1HS0l81+ISHEUVAVO6tMU8r4m0A2G2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0aJ39aDJ53J1pUdLFzCcma4MZ7oSPENQDGs6ZLeijZnr2mrPefG7ZS3uhKHu+EV91J+4f9Ntw90SKx3hkuLHlnLWdARbPeZbXRiIpJK4i+9NY2xepY2K0/bBAieC3U8OCZt+w8SUXf6iaKbMFZqg3W26ABS6ZKmK3/9uv66E3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=e+H/Dz+k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c+zYMw5+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F20741400204;
	Wed, 22 Oct 2025 11:25:08 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 22 Oct 2025 11:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761146708;
	 x=1761233108; bh=w9JnQfS5/YAntHYNu3/6iKoyUsBwlTv3rCAOBN5XJoM=; b=
	e+H/Dz+k6gaViAkYAIGYLmsmiQn/Mdw/jC3EP849hLDUtzT5JYLOPVjUBYUxqT4t
	TWAWOYRSZMUufNWv6MP+2z9bxs6ewPsfQ5jQMZqoJjeh1mU2gxKpSBRD0Vt13EKg
	innJFrJpJiOb71n+f3acWZnGCicjtju03WnmOHddJ6xjwd7lG9eBy2czA7RsXBCX
	tZNThw0qbBe0ZVROL43jmrW0JxRoIrrUQ575reAMIEOifJdOfawsj7DGDZirO4Ly
	mbTrfXGxXtefNbkeRrqfWvaMvGyjcqQn0Z044QxnnSQnU3knpP3JZW4o2bJIAxtK
	cblrzxNUgXDpO9y87ABAXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761146708; x=
	1761233108; bh=w9JnQfS5/YAntHYNu3/6iKoyUsBwlTv3rCAOBN5XJoM=; b=c
	+zYMw5+JfHxVuGIE00WakM2xiFPdvDGKWgLj+tAglprqqWiIMsjKfD6C7TinrWkP
	H9ms/Du1ZRa9jxx0BZog+N1SLRQZcE3d9oIUThAwme0OhoMvXs7lsR5dU2vok3Pv
	jmsjYEbVhuvN1P9Dv1MLLkjeTwDb+ECc90r6EADikNlasDMYzucsFLNU6HuDS+w7
	gPbH8/l2lmjcPb7eHdrlwDOjH28nuM3J59mOgqbK9M+CvjUfEOpUYUNRnsXdAM2e
	eqFCmTC/Gc3tYhDeR3ylgsBBR3i5sU/E7JVTBHVAqXrFo8232FK8rOOPwYzgRSj1
	K/hDNBIcbYtUMXZfotIqw==
X-ME-Sender: <xms:VPf4aA3F0NXG_L4dg2BFbDz2UTvMoS6jnJV-PFWQTaoaeB08Zyx5oQ>
    <xme:VPf4aBE0fWF-tksJiPVeTfMrzqT_HyqB8NFkJvQCN0yXIeH_RmQna2ZCgvRd7KYOu
    e68nyuCAhABLpicmJ-QitYILeuZn5yt7sTPJpPpwtRMtpLc2Q1jiDc>
X-ME-Received: <xmr:VPf4aGhnC_FM8044fRtp7hOx9oT6mTt72t5uGdefeaXfKhSREl9W5O9Sl9crNDmQDXq3VGjMbb8gF_BGtW7CikGYUl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeefleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepud
    elhfdthfetuddvtefhfedtiedtteehvddtkedvledtvdevgedtuedutdeitdeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:VPf4aE_AfIzEsaLGGTUN0PY7Z8UDs2HY0NDlbUx4ngjjBzaOkfMLhg>
    <xmx:VPf4aFpZf5r178SxRARQzpwAQulTq8wUrSuXpszrnvtZ0xKLa1_gqQ>
    <xmx:VPf4aL_SDzv00tmz4IG0v9skgK4TD9NprBn6dCwT7FokYuIURcAwDw>
    <xmx:VPf4aBUIvSL2-sJagkA4rW3RYflFjfEXxqgaxqUK-NB6ECRrKMWnSw>
    <xmx:VPf4aNgA6NojA6X7pJIBFb5aroD7nqcsM7ORWRxe-gwNSAuyY2aFVlfz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 11:25:08 -0400 (EDT)
Date: Wed, 22 Oct 2025 08:25:12 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: subpage: simplify the PAGECACHE_TAG_TOWRITE
 handling
Message-ID: <20251022152512.GA464731@zen.localdomain>
References: <377fc6736bba9df49b7bdeeb80f36b17f610eeb2.1761018694.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <377fc6736bba9df49b7bdeeb80f36b17f610eeb2.1761018694.git.wqu@suse.com>

On Tue, Oct 21, 2025 at 02:21:48PM +1030, Qu Wenruo wrote:
> In function btrfs_subpage_set_writeback() we need to keep the
> PAGECACHE_TAG_TOWRITE tag if the folio is still dirty.
> 
> This is a needed quirk for support async extents, as a subpage range can
> almost suddenly go writeback, without touching other subpage ranges in
> the same folio.
> 
> However we can simplify the handling by replace the open-coded tag
> clearing by passing the @keep_write flag depending on if the folio is
> dirty.
> 
> Since we're holding the subpage lock already, no one is able to change
> the dirty/writeback flag, thus it's safe to check the folio dirty before
> calling __folio_start_writeback().
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/subpage.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 0a4a1ee81e63..80cd27d3267f 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -440,6 +440,7 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>  	unsigned int start_bit = subpage_calc_start_bit(fs_info, folio,
>  							writeback, start, len);
>  	unsigned long flags;
> +	bool keep_write;
>  
>  	spin_lock_irqsave(&bfs->lock, flags);
>  	bitmap_set(bfs->bitmaps, start_bit, len >> fs_info->sectorsize_bits);
> @@ -450,18 +451,9 @@ void btrfs_subpage_set_writeback(const struct btrfs_fs_info *fs_info,
>  	 * assume writeback is complete, and exit too early — violating sync
>  	 * ordering guarantees.
>  	 */
> +	keep_write = folio_test_dirty(folio);
>  	if (!folio_test_writeback(folio))
> -		__folio_start_writeback(folio, true);
> -	if (!folio_test_dirty(folio)) {
> -		struct address_space *mapping = folio_mapping(folio);
> -		XA_STATE(xas, &mapping->i_pages, folio->index);
> -		unsigned long xa_flags;
> -
> -		xas_lock_irqsave(&xas, xa_flags);
> -		xas_load(&xas);
> -		xas_clear_mark(&xas, PAGECACHE_TAG_TOWRITE);
> -		xas_unlock_irqrestore(&xas, xa_flags);
> -	}
> +		__folio_start_writeback(folio, keep_write);
>  	spin_unlock_irqrestore(&bfs->lock, flags);
>  }
>  
> -- 
> 2.51.0
> 

