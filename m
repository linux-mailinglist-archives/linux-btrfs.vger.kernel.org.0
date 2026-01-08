Return-Path: <linux-btrfs+bounces-20288-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7FBD059A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 19:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 855D330131FC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 18:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1E31D72B;
	Thu,  8 Jan 2026 18:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="e/lYa1s3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P7Zjzp4U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC7131D399
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 18:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897444; cv=none; b=D5i7eDEPIetqfZDun5ANA3Un0CTXX6PXTFzFWqXo0jY5E4iesxpPV3LX1nxBpcc9/FF6hwmJHJeoI3dbNaZpnFMkBWryPuE68EXiZU/bKlN6G3h7cKEryhbmzYiu0sNc15rPf5/R0NZwBQ27oqImYJKDyscciGm70SzIUFjUOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897444; c=relaxed/simple;
	bh=lxc1ZImNWimH6SSCd8CzwtJaKw+zmaDZKzDpvJR11do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2slidyt3l8+3vuWe+Yblidr9dUe1pDk+DT1BMech+uI8S3H7+qLVmWTPg7++jl6EZlLMdHZaZEm9UfvEFfdRyKwK9nX7iaT6w7PJu7iOQ7gi6KqliZV7MtsxYr07a+CmoWMeX+3+Y5NpC0zi2/sESOTtbWB+qyN4JFSNkOsFD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=e/lYa1s3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P7Zjzp4U; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 432987A0046;
	Thu,  8 Jan 2026 13:37:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 08 Jan 2026 13:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767897436; x=1767983836; bh=g0YUA844ic
	Z6H7Tkil7b0nvgXU0RczrS4iGPaUbZMXE=; b=e/lYa1s3bqHcgmiNjprrBYEIZR
	yTJGEIq7ZKXfaGv6QhTU7pIDSbaRbIu1vIhJrms/KgfefQK8MEPv0k2YDoNAqaaY
	82kzq6FFdUqiKkGkDv0wuU5TivY8ZmfzlX7dR2Tpki/2mRL2e1YRYnDDSKNkPYfA
	GU+kkdS70naPP70Lz4CEYm0hil8eqEv3xECcMxn+VbBDLAH/f2h2wqUvpHNHGLOn
	14G2mL1j1WRkW7hL31Ag6VmJupB8OiuAQwiFp+MGsHSRa9VaOqodPjOytTYkHG/J
	GDPjTm9zKx7rfiiB+FOJytGd+FewWIHcaKNlUcDpsOrNuyY8mXsR8Ch8X3og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767897436; x=1767983836; bh=g0YUA844icZ6H7Tkil7b0nvgXU0RczrS4iG
	PaUbZMXE=; b=P7Zjzp4UeofVkc0i8XJgIvrMyod2E0RQc0hDKh7W5d5tRQm8D8G
	c0ciY39L1xcCrSuPHjFH45yyVBm7VjkSG3sF4YiYTvHu32rGvjXo+h3RQk7hznpM
	BrtaEv7mpnMsUgxiaQ9XnCn6CKzpuqjclHJ6ORCkMhEjrp54VOuXaXp0qiz6Pxo8
	Lftzhp51CITskN+Q4hwwG0lQtV47ob8hJgBsdYf5TsfHB5OjElge7uZeODdzMRrd
	a3/p28UNAUJtb3MQ2W8L4ZW3Nfz8MI9w8GBMpKyHtDXaWScR8LvpyG3n29iOgwET
	fnXkxMMa+5l0c+xS3bH/vUX9ONy21lq6q2g==
X-ME-Sender: <xms:W_lfabK6b5hg2L69bPYAVohFLRtcqwWSJ0U_JEA8unk_mYDIo5Y_zQ>
    <xme:W_lfaVIJ-pnMDOrQ2M8XPv82hG7X3NufQNyWpucQGwHamor90pmecGMd1sEX3OCpI
    PlxRJxK8iprdmNzOMsWZjLf6GCoVZIvMGrUCs3i8X3IbR1_Cfs9>
X-ME-Received: <xmr:W_lfaRWathsEtfNVA8A7H43GmGFvN_MKg-Moz1xjHABLYMHH7TG3nRRhd0nqSLac_-_1twjEymjhUD09lXBVWlY7WCo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeiieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrh
    hfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:W_lfafjBZEQW1p30KCBIY8V83E-Di13M3jPsUxkLaOSdaDcANpRORQ>
    <xmx:W_lfaU_kkW9WcZZ1LBSwDDri0WrpK7FgMGNXToytvGhLpmzFBQOQcQ>
    <xmx:W_lfaRAbqSyoRbuU6A9NR__ymD6HnVf4JVth6Qr-ArDFmtpNjiPdMQ>
    <xmx:W_lfaZKYpaAxB1whKjT0ULyxK3_ia9o2Mz0A81NsjZgefJRTQ_Swsw>
    <xmx:XPlfaWVpTe9jpd8j200CfgR-ZoN-h8PEXwSP7PJqY30e7Ai1mKRmj_h_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 13:37:15 -0500 (EST)
Date: Thu, 8 Jan 2026 10:37:25 -0800
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 09/12] btrfs: zlib: remove local variable nr_dest_folios
 in zlib_compress_folios()
Message-ID: <20260108183725.GH2216040@zen.localdomain>
References: <cover.1767716314.git.dsterba@suse.com>
 <6a4a71802a5f26209bed59b492fd07029d52686f.1767716314.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a4a71802a5f26209bed59b492fd07029d52686f.1767716314.git.dsterba@suse.com>

On Tue, Jan 06, 2026 at 05:20:32PM +0100, David Sterba wrote:
> The value of *out_folios does not change and nr_dest_folios is only a
> local copy, we can remove it. This saves 8 bytes of stack.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/zlib.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index bb4a9f70714682..fa35513267ae42 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -158,8 +158,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  	struct folio *in_folio = NULL;
>  	struct folio *out_folio = NULL;
>  	unsigned long len = *total_out;
> -	unsigned long nr_dest_folios = *out_folios;
> -	const unsigned long max_out = nr_dest_folios << min_folio_shift;
> +	const unsigned long max_out = *out_folios << min_folio_shift;
>  	const u64 orig_end = start + len;
>  
>  	*out_folios = 0;

I may be missing something, but it looks like it does change here?
Then it only gets set to nr_folios at the out: label. So in the other
two uses of nr_dest_folios, *out_folios is wrong.

> @@ -257,7 +256,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  		 * the stream end if required
>  		 */
>  		if (workspace->strm.avail_out == 0) {
> -			if (nr_folios == nr_dest_folios) {
> +			if (nr_folios == *out_folios) {
>  				ret = -E2BIG;
>  				goto out;
>  			}
> @@ -292,7 +291,7 @@ int zlib_compress_folios(struct list_head *ws, struct btrfs_inode *inode,
>  			goto out;
>  		} else if (workspace->strm.avail_out == 0) {
>  			/* Get another folio for the stream end. */
> -			if (nr_folios == nr_dest_folios) {
> +			if (nr_folios == *out_folios) {
>  				ret = -E2BIG;
>  				goto out;
>  			}
> -- 
> 2.51.1
> 

