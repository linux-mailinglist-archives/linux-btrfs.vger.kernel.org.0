Return-Path: <linux-btrfs+bounces-13393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C99A9B649
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 20:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD649A64B6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F328934E;
	Thu, 24 Apr 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="v0xyQ8VL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AB66wB8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BA28F501;
	Thu, 24 Apr 2025 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518854; cv=none; b=M37zYwUShO4gvZBlP/SWWnu7VFZxt2TkpchsVvBagjCbQ6amXgljsKiaYK6EJzNt4dl8WKQCAf1SHEhrWPrfkAKXP1MkJLAJQeMAxKnabjXrMGzuN9H8QpGFw1HToXrT/BSBSt0E+t+NX1LrzilAMgYkKSov2q95Nz0OCL7dSQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518854; c=relaxed/simple;
	bh=w9XDNMrQy6uyNf+fQzmb40l49o55digRyTVAV/Fqo3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgwJ7pCtenYOWfJl0gAXlX/n8zzXlPu7NfR8+s8cCCkQe/kCtnx3eS1LpGt6CtVoBxwnJgucm+u5dF2qJiixIn4iRwua/xbV8+uYUEiA9/wrLTGhpOGnfTnFr1Zl59qg7GQCB7cx/aXVEBQwysOQ2Yv0BGV5mbcZ/gDBWY0uCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=v0xyQ8VL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AB66wB8Y; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2D757114020A;
	Thu, 24 Apr 2025 14:20:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 24 Apr 2025 14:20:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1745518850; x=1745605250; bh=fvsfPHcxgY
	3gYTa61n0of+zF8tOmo18oblg3QLtTipI=; b=v0xyQ8VLf1IZ3BBdoqyP4uuvs4
	3rvtCOYLKLkkwqAADlLZInY+2eTbWhAzjvInDyhZJw4Gb+3KC0OTvJBdox/twHkM
	dS0pxcPp+yzJ1GXZm+CaNc7/zPSgSRgM9jRaosHyl9h8afv0XgTxP0z9x9Q30w5i
	TJH6NXGrExdZnfbCVtNcBwJ2REiZdcRgR/NTQM63S6ox2XH/kBNyITBacEtzi6W+
	lj0gv8VNprEVT3z74glt4QKSLyW+zCEoW0h47UdoOzn1fjFYlct8W9tNhgSFEDUA
	UbJUSbz77u9MCcoL3gh4a6YgORFPqszl0XSFYg2qaaHBRGcqCLGcLNk7YwfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745518850; x=1745605250; bh=fvsfPHcxgY3gYTa61n0of+zF8tOmo18oblg
	3QLtTipI=; b=AB66wB8YEJSuUpGrFO9MAfljK6WXIllJt8uu+0QycpbuQOj8ar+
	kbODKGbzRWPAT0LZPoTyjl3a7B7oZZijHWEjCv7wfOgAXQgUTsJ0xfAcfxJj+tO2
	2cMmbE8/Jwob5C5bY6B6H1y+hseR8V4oASVBknmqrB1KADaSFCdr7rWxOmjRLhvD
	zVAWDmDHpm8VERXwLtbCp0TxfSSoaWczpv9fIx4ZTwPFqTsPwRWO6HuGcqwoHmCR
	Wt1C7MDf8zZoI4hvQhnUGQKu5WPHGrlYujmuvAKUSwCvK50iGYlNLscbOjlB1k9B
	DutGZkQPp/yzuUh9RLREDBCst7+p96bS4Tw==
X-ME-Sender: <xms:AYEKaO3XVCXrvq0Y2Og3Gn-JHiSvCLLTqGRhTma9Aw0l1VJu1R6NxA>
    <xme:AYEKaBH6kPsJrAwu07wvtXS1tsu0zu7ay8crZXWBq6x0N-yOYkxeOTXuglrr8BojL
    rbRZqW6Iz-ArK9qVxg>
X-ME-Received: <xmr:AYEKaG4XcprbNeT1utelHjl9DekxbOW2gJkBJ4b_broiSKNZqQebH2lTGFUHnwzwvjrIgLjhtzhBg477GAJ8vCimBWc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqe
    enucggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedu
    gfeugfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepnhgvvghlgiesshhushgvrdgtohhmpdhrtghpth
    htoheptghlmhesfhgsrdgtohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghn
    uggrrdgtohhmpdhrtghpthhtohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpth
    htoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AYEKaP057IWn8oQqVigoUR3ahBYe4a0lD42DJ0Pd8JliWvCkq8ud0A>
    <xmx:AYEKaBHDLVksfTeVIpX1LfFPxrerKmMHhUqGYX-pezSJTiV1CgHBrA>
    <xmx:AYEKaI_wTygI967yCCQGr5TD4WdyFhvhMnXe_nWRXPnOdDgxsY9o9g>
    <xmx:AYEKaGl4mzSXYSxKxI3s50dxwLWcW0U9eqm-tI_ozrnFxgo0sytXSA>
    <xmx:AoEKaJc_JU53PK2jqzFRgRFu1eVNC0Y039EIsN8Fi0eZiKBhjize_KoZ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Apr 2025 14:20:49 -0400 (EDT)
Date: Thu, 24 Apr 2025 11:21:54 -0700
From: Boris Burkov <boris@bur.io>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: put all allocated extent buffer folios in
 failure case
Message-ID: <20250424182154.GB3340135@zen.localdomain>
References: <20250422125701.3939257-1-neelx@suse.com>
 <20250424150809.4170099-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424150809.4170099-1-neelx@suse.com>

On Thu, Apr 24, 2025 at 05:08:08PM +0200, Daniel Vacek wrote:
> When attaching a folio fails, for example if another one is already mapped,
> we need to put all newly allocated folios. And as a consequence we do not
> need to flag the eb UNMAPPED anymore.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/extent_io.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 197f5e51c4744..7023dd527d3e7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3385,30 +3385,26 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>  	 * we'll lookup the folio for that index, and grab that EB.  We do not
>  	 * want that to grab this eb, as we're getting ready to free it.  So we
>  	 * have to detach it first and then unlock it.
> -	 *
> -	 * We have to drop our reference and NULL it out here because in the
> -	 * subpage case detaching does a btrfs_folio_dec_eb_refs() for our eb.
> -	 * Below when we call btrfs_release_extent_buffer() we will call
> -	 * detach_extent_buffer_folio() on our remaining pages in the !subpage
> -	 * case.  If we left eb->folios[i] populated in the subpage case we'd
> -	 * double put our reference and be super sad.
>  	 */
> -	for (int i = 0; i < attached; i++) {
> -		ASSERT(eb->folios[i]);
> -		detach_extent_buffer_folio(eb, eb->folios[i]);
> -		folio_unlock(eb->folios[i]);
> -		folio_put(eb->folios[i]);
> +	for (int i = 0; i < num_extent_pages(eb); i++) {
> +		struct folio *folio = eb->folios[i];
> +
> +		if (i < attached) {
> +			ASSERT(folio);
> +			detach_extent_buffer_folio(eb, folio);
> +			folio_unlock(folio);
> +		} else if (!folio)
> +			continue;
> +
> +		ASSERT(!folio_test_private(folio));
> +		folio_put(folio);
>  		eb->folios[i] = NULL;
>  	}
> -	/*
> -	 * Now all pages of that extent buffer is unmapped, set UNMAPPED flag,
> -	 * so it can be cleaned up without utilizing folio->mapping.
> -	 */
> -	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
> -
>  	btrfs_release_extent_buffer(eb);
> +
>  	if (ret < 0)
>  		return ERR_PTR(ret);
> +
>  	ASSERT(existing_eb);
>  	return existing_eb;
>  }
> -- 
> 2.47.2
> 

