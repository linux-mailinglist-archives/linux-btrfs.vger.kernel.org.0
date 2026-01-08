Return-Path: <linux-btrfs+bounces-20291-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5A8D05ABE
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 19:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C203031655
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 18:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F26322B96;
	Thu,  8 Jan 2026 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="iKTOYvia";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cQ/1EreZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8614F304968
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 18:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898409; cv=none; b=QQu1MJOGTkBSdYGSEpI+h73t88VnCWi+66Nwly+b3tqD6XL7LkCT6X1Lp1yfvO3tVsnlUKJ6YoQbON9daj3mHaa19aBBROK/k5PV7NF3pN6NDqGAb1fWJgAI5FUbLeY+EAgFrv0yzHWW7YYuH86fTmBQgZTF0KLyRooClLMYX3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898409; c=relaxed/simple;
	bh=xG3nNb3lo4OFRTIxL6pe33Qw1KcTBWd9T8bN1AtslvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTCmvkA08eJSdTq3H/i+7Ft8BKPmgI0DjjKdPMHAzxUZVA/NGsvNLkkmnHawKFcvUsbM5/g0C6fRmRJxPgnupNP07YpGuPq38ynIz1b8Xg+hhRZYgDsGscy7tF49+Nfl1rMbPFfADdN2ABndYtrsH4Y/N3bRJiO5vB1lH6+dcaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=iKTOYvia; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cQ/1EreZ; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DE82A7A0105;
	Thu,  8 Jan 2026 13:53:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 08 Jan 2026 13:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767898407; x=1767984807; bh=UOh9Z6lZmD
	wIqG7YXY5ijSCAOAyzxZjM1/g0ipJEtyg=; b=iKTOYviaCBqAnMqj+HsyKt+7xm
	yXvLsbwYNDuSAOcjFZ+OUcVI8QVMJtM7xKgmTLG+eNn0cfNHcZ658TnHSDB9GtZ/
	ybGdRWFHjfjBrk3ew+BGYxiKIovgSrgiNI+XjSwwOCmLRbsctS9NnCGruDismelR
	JGzy4fc3RL27V6oLLGQpv4yf35oV8mqn9H0nZI9dxpY/MgmdQJUBpNRXF5w08LLn
	oLMkaDRT73d3lOBrONtuPP2HafzhjkhVShHq9zKmeFci163T2Qu88k4G/kDELwqO
	3kxfVptzkyoHd9DPLp5Z4NUYOrDncBGCorAjeXMyhXWHXqNMANPJ7ByJy/Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767898407; x=1767984807; bh=UOh9Z6lZmDwIqG7YXY5ijSCAOAyzxZjM1/g
	0ipJEtyg=; b=cQ/1EreZ0MicWlIUjAnEFCjd8+TnU26lflz6tXWoFKo2gjuWGHS
	ZWRM/spjHeg5HJho0+S1tWgKz2WsRFEzJL9K2m3C3B067d91Ch2byXdeCodDVQ2Y
	u78ceDjykeNGY4hqxzMAkG1222ejGeAL7ExW2qj8nZKtp359TQ3tqSHfCDAbaOLl
	lNILU34YE1r7ydnrH8vMJXj2sToZ3iSVFWKFGkTN0DWpVXUeHyWPA8UPBQo6W9ci
	f9cwwA61xfz4x2/J/y1vr+Ff+pU0KFrurdd5rWVLkey/ScqXKI0uVPCilwxrRtCv
	IEwhkUybmqeCY86IhKfoAn48XI88L84IWWA==
X-ME-Sender: <xms:J_1faUp_Jx8nHSAppFFL4ej43HBFk5L44PRrLwqj-VA076dVDs9aBQ>
    <xme:J_1faQpO-RxeYMpKiVnfNpmBrQ6LlX5YTS3RLqfjMHu_BRLYLpt657K3zF3ynYIEM
    ufo5koFowqE9H1dXUsjhZ4RmPAcDYKh-O_xpLOnE8Zp_iNDtWTc7QE>
X-ME-Received: <xmr:J_1faW0sxCNvKiy5DAtkeVf1AANi3GAYPb8BL0egNO6t2C49rNTAnH7xnAuret75rjGsE5VCo6InrCHinuhgaVHm5_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeijedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J_1faXAhxxz6QGSUgEUq5oymczhvwC9mJ8KnK2ttjAVCn44SOHNR1Q>
    <xmx:J_1faWda2gXzRlXLJRAwYNaSgkutPlRBP0tRcIna3LvA_W_zDvF7YA>
    <xmx:J_1faUjzvPHSrYoD-TPNPGDEP4CuS3XuKA6WOjokp89t654kLhgm0Q>
    <xmx:J_1faWr4-kGKXdvVEBBN76FRHXdowKevSklO4M6Xtyz1bOTGQRIwSg>
    <xmx:J_1fab30tfE11H7dSSz6hL21KcRZ2xkLbmKQusbYQdUWqlR3ReShbgpW>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 13:53:27 -0500 (EST)
Date: Thu, 8 Jan 2026 10:53:36 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 11/12] btrfs: zstd: don't cache sectorsize in a local
 variable
Message-ID: <20260108185336.GK2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <8980a59aca9cb257150989aa2f2ea425ec7175a4.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8980a59aca9cb257150989aa2f2ea425ec7175a4.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:34PM +0100, David Sterba wrote:
> The sectorsize is used once or at most twice in the callbacks, no need
> to cache it on stack. Minor effect on zstd_compress_folios() where it
> saves 8 bytes of stack.
> 

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/zstd.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
> index 4edc5f6f63a110..75294302fe0530 100644
> --- a/fs/btrfs/zstd.c
> +++ b/fs/btrfs/zstd.c
> @@ -370,7 +370,6 @@ void zstd_free_workspace(struct list_head *ws)
>  
>  struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
>  {
> -	const u32 blocksize = fs_info->sectorsize;
>  	struct workspace *workspace;
>  
>  	workspace = kzalloc(sizeof(*workspace), GFP_KERNEL);
> @@ -383,7 +382,7 @@ struct list_head *zstd_alloc_workspace(struct btrfs_fs_info *fs_info, int level)
>  	workspace->req_level = level;
>  	workspace->last_used = jiffies;
>  	workspace->mem = kvmalloc(workspace->size, GFP_KERNEL | __GFP_NOWARN);
> -	workspace->buf = kmalloc(blocksize, GFP_KERNEL);
> +	workspace->buf = kmalloc(fs_info->sectorsize, GFP_KERNEL);
>  	if (!workspace->mem || !workspace->buf)
>  		goto fail;
>  
> @@ -411,7 +410,6 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  	unsigned long len = *total_out;
>  	const unsigned long nr_dest_folios = *out_folios;
>  	const u64 orig_end = start + len;
> -	const u32 blocksize = fs_info->sectorsize;
>  	const u32 min_folio_size = btrfs_min_folio_size(fs_info);
>  	unsigned long max_out = nr_dest_folios * min_folio_size;
>  	unsigned int cur_len;
> @@ -469,7 +467,7 @@ int zstd_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  		}
>  
>  		/* Check to see if we are making it bigger */
> -		if (*total_in + workspace->in_buf.pos > blocksize * 2 &&
> +		if (*total_in + workspace->in_buf.pos > fs_info->sectorsize * 2 &&
>  				*total_in + workspace->in_buf.pos <
>  				*total_out + workspace->out_buf.pos) {
>  			ret = -E2BIG;
> @@ -589,7 +587,6 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  	size_t srclen = cb->compressed_len;
>  	zstd_dstream *stream;
>  	int ret = 0;
> -	const u32 blocksize = fs_info->sectorsize;
>  	const unsigned int min_folio_size = btrfs_min_folio_size(fs_info);
>  	unsigned long folio_in_index = 0;
>  	unsigned long total_folios_in = DIV_ROUND_UP(srclen, min_folio_size);
> @@ -614,7 +611,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
>  
>  	workspace->out_buf.dst = workspace->buf;
>  	workspace->out_buf.pos = 0;
> -	workspace->out_buf.size = blocksize;
> +	workspace->out_buf.size = fs_info->sectorsize;
>  
>  	while (1) {
>  		size_t ret2;
> @@ -675,7 +672,6 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
>  {
>  	struct workspace *workspace = list_entry(ws, struct workspace, list);
>  	struct btrfs_fs_info *fs_info = btrfs_sb(folio_inode(dest_folio)->i_sb);
> -	const u32 sectorsize = fs_info->sectorsize;
>  	zstd_dstream *stream;
>  	int ret = 0;
>  	unsigned long to_copy = 0;
> @@ -699,7 +695,7 @@ int zstd_decompress(struct list_head *ws, const u8 *data_in,
>  
>  	workspace->out_buf.dst = workspace->buf;
>  	workspace->out_buf.pos = 0;
> -	workspace->out_buf.size = sectorsize;
> +	workspace->out_buf.size = fs_info->sectorsize;
>  
>  	/*
>  	 * Since both input and output buffers should not exceed one sector,
> -- 
> 2.51.1
> 

