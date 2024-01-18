Return-Path: <linux-btrfs+bounces-1561-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F42128320EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 22:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEFB283032
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 21:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF362EB1D;
	Thu, 18 Jan 2024 21:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DSCs+Gnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ieJSy6uI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDE2E652
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613614; cv=none; b=ljchRJx/tDwe7mBt9tebHjKhdp3vH9g6e1xCfrV0nvpXnJ4bdOS9/Rs4inOzDp+9qjqWUTmTMeRxYqaxrWnKVxElGs5URgfjKm89hGcWo4xdU0tk8h6tzLGmyNPxsgQin3EBrqnlwK8qa52ADB6LwqK1TzxbcewV69kJnecKQIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613614; c=relaxed/simple;
	bh=GSHlSxaknGl5Xt6OtFz7ggYQVNMQIg7pwMdIG1y4v/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVHMtw2qhkLv0U8/C1DpAvRbBkTRu8Ml6aNDIzaXU3TphL4lOHFlAnJ4S3cAcB3SRFWE7zwKmC3ZOJ4CMCWUFbpKZbWG4usWjHmCsZIGMnTzbnWdKnzNJegJtnvWjz064ZZ1N+gwdV98QCK+vGWDGqns3CZYAc7SXGVHI4W3swU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DSCs+Gnb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ieJSy6uI; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 055A73200B3C;
	Thu, 18 Jan 2024 16:33:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Jan 2024 16:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705613610; x=1705700010; bh=ypMe77cDH3
	0r+K5IYdJpCXIvYuKaEGLvb2TVaBeIclY=; b=DSCs+GnbIgvU7KXRjQlAVqwVxJ
	8Iy/A7qrFhj+8NNhvjiIoDO9tdBxHwDw1KgyIIRGw5dUDDVSEjusgvchk48yESp5
	lY8C2ra/SXQq0yya5nwGwlky+bw+TB9rC91R7CMlbERXUctH6xCvPudqnoG5Gdvd
	GD48wFha8c+nljPnybN6tECEyTTy+MR+K0LQApY0AWs1IjP1Q0THQ3iNSsI1DxNY
	tQKjLa+cknGuHDLbAITrck5QIr9SbU0J6APATqCy2gOdsElum+QQqEm2lX+W0oK9
	89UTf3HAzb/NAjTYND/qhpgum1fDAYDRaMkl6MAE+n/i67TABXr05DTnpIfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705613610; x=1705700010; bh=ypMe77cDH30r+K5IYdJpCXIvYuKa
	EGLvb2TVaBeIclY=; b=ieJSy6uITJ38wDcL1tS0AowXqIEyqeHhVIjH7kYYkoB8
	d9cLz7EjxM7Pqrto8wHIKntEz84IbRWo11xxp5fxiE5ZLW6m5Z6Kfi0UU0+YL7f6
	a95Dd4SVxCs7JENEdInuFAg7tpbQPtNJ4E2ePSTvtKqAO3BCK8AOSc92UlYgprlo
	4o4H7g3GxqQuWWB+og6+oZzO7qA6uaix4kgL9SeChIliJ7/3mTk7Uv632kAX1WVd
	//NEqq3/jWflHmbeYgrOTIl7pP8UgKS1sgVbLRcXTVmHFwbe9EP9skFbJ/BYaRtz
	INOpjvJJ587Z9bv1vuVj6t6EU4JSQuL5Oa+oqi7xtg==
X-ME-Sender: <xms:KpmpZRaZt_fstikSlMoMcNySi02DgZERzp4QQT-KuFXyYtvmuJAJRQ>
    <xme:KpmpZYYO9OjuvMqnP4z75I_dTLHRmlBoxxXzcy0qqUz_GtwcWv_zkFmhvbBQjMYK-
    YFAw_8En4uISqg2LQg>
X-ME-Received: <xmr:KpmpZT_r3gOUAXjTsQFWRdrstmhouAkc4VzfVkmt4BYSKCpZmMe1hXwTliWU1P2cfvBcmJNwL8PnQglz_6LUDcIEWxc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:KpmpZfovPLJYOD2SXBOmLI_CSdm8h1tKIvHCx_Cyzyz23MHSOG2HoQ>
    <xmx:KpmpZcrNdjkxLhsN7pgtsHGafquwF6kI_3qcBUx2uDmZu7cJjL3KaQ>
    <xmx:KpmpZVS3l5dp115-ZBqolQMU3XdvVYMRUXv6FoR5dQ4jYdvshMshvw>
    <xmx:KpmpZZCAB6zDT5Qongfnc26AvyEBwjR_AKiaMI3omJitdLWX7jRidA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 16:33:29 -0500 (EST)
Date: Thu, 18 Jan 2024 13:34:40 -0800
From: Boris Burkov <boris@bur.io>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 2/4] btrfs: page to folio conversion:
 prealloc_file_extent_cluster()
Message-ID: <20240118213440.GB1356080@zen.localdomain>
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <55f236028fe97c2119ad8aa51cc6e5fe0cb04d0b.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f236028fe97c2119ad8aa51cc6e5fe0cb04d0b.1705605787.git.rgoldwyn@suse.com>

On Thu, Jan 18, 2024 at 01:46:38PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Convert usage of page to folio in prealloc_file_extent_cluster(). This converts
> all page-based function calls to folio-based.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/relocation.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index abe594f77f99..c365bfc60652 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2858,7 +2858,7 @@ static noinline_for_stack int prealloc_file_extent_cluster(
>  		struct address_space *mapping = inode->vfs_inode.i_mapping;
>  		struct btrfs_fs_info *fs_info = inode->root->fs_info;
>  		const u32 sectorsize = fs_info->sectorsize;
> -		struct page *page;
> +		struct folio *folio;
>  
>  		ASSERT(sectorsize < PAGE_SIZE);
>  		ASSERT(IS_ALIGNED(i_size, sectorsize));
> @@ -2889,16 +2889,16 @@ static noinline_for_stack int prealloc_file_extent_cluster(
>  		clear_extent_bits(&inode->io_tree, i_size,
>  				  round_up(i_size, PAGE_SIZE) - 1,
>  				  EXTENT_UPTODATE);
> -		page = find_lock_page(mapping, i_size >> PAGE_SHIFT);
> +		folio = filemap_lock_folio(mapping, i_size >> PAGE_SHIFT);
>  		/*
>  		 * If page is freed we don't need to do anything then, as we
>  		 * will re-read the whole page anyway.
>  		 */
> -		if (page) {
> -			btrfs_subpage_clear_uptodate(fs_info, page_folio(page), i_size,
> +		if (!IS_ERR(folio)) {
> +			btrfs_subpage_clear_uptodate(fs_info, folio, i_size,
>  					round_up(i_size, PAGE_SIZE) - i_size);
> -			unlock_page(page);
> -			put_page(page);
> +			folio_unlock(folio);
> +			folio_put(folio);
>  		}
>  	}
>  
> -- 
> 2.43.0
> 

