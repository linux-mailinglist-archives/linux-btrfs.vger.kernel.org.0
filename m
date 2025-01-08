Return-Path: <linux-btrfs+bounces-10805-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305A0A068B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 23:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01B31883851
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB5B2040B9;
	Wed,  8 Jan 2025 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="azbc4ZZr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xvr5zSys"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED79719EEBF
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376366; cv=none; b=Y1iET1W7q8vKBT+St5bq7xk2EkFLk9lhff/73mEnNgcvY39TVTE2+gNRZX6jfKPZoJYv3rFQn+ZvjyIp6LLZkTyvUjkK8DVl97TuJoUo6pWNUsJYttGzzCfWOuISEUYbR/9hj+WurqJ5U3HY4xQvbjvyrf19Skv5WEM1SYctA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376366; c=relaxed/simple;
	bh=VFzuVpmCFqH2FRXnYGc7yXi1iPjaKr3zljKhN7Cji48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzY+U3h2IQuBTOixM9lcZE5+flaktjYQ0S4ZzRlzdJGZVI1l7A4TXdLAVC3HxQqrY7+z1jAASEm7zz7IttQvMiqkOxsW1XpjT94HsF1lHf27elFIqcawI2Qhh9452/eR6F/eVPyikWeNEyTQjZFmylTg8kRGANuMrSDE7ODzFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=azbc4ZZr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xvr5zSys; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D124B25401D8;
	Wed,  8 Jan 2025 17:46:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 08 Jan 2025 17:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736376360; x=1736462760; bh=Iiv5mQlsPm
	Yln6Vn8rzKjIWYqveNPZk3wpVxQkjevEc=; b=azbc4ZZrrf46U1wy+zPp3oLPcs
	RnCOHSoQtsvcRJaUgsbLwskCDR5NVocxY4sGhUHot7nrRpJUVBu6LTMqvs2AAnW4
	vZXE/xFsBJcQsi90COorSNJ5Ih43bzL34Y35iM29lp+QBxSXqwaZGQcPwZWlVoCx
	gCIpxk3OMa/3HVsZhu/Zw777z9gqQo8Ge6QZb75IQQfYhUBa/QSuOtfZQGC7q8Vy
	RHq30rKBG5nYNclhunwz8gHFSuEVOJO/53Ncuzh06bmuD7EQEE/t1QhBq98/iGR0
	RwzJSC3sh0251Iwbldg7Bzd+Rpnf11v5gUe1gSc3ThsWCHITWN6hKOBWmb1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736376360; x=1736462760; bh=Iiv5mQlsPmYln6Vn8rzKjIWYqveNPZk3wpV
	xQkjevEc=; b=Xvr5zSyswdbGa4eoJv28J/JjfGP3+49K5NXeeEOsePY7azSP1ec
	qGBnJOAz9VLFNSPYmY81e4VZYFh66TbHhPJ+CFGEKQe3Gck0veCaeDsU9DHB460n
	5RIE2L82BdmC21FmK5RzkJzBa5/DfwIw8vjV2GuYL43SttlB8E4gbl92OgihNbXa
	NqLXzcXO7fYSsT0D57p2n/ukaWNFOyvoiVLPU48CbCSX0OVjFQZ7gXKeMMjYrUW9
	4dHyAF1hD2kPcrg0T7t+cKh5fIGhNrj74QgWqVUSzuJKqXAGvbmOKBuXdN9dHxM5
	I3aoANWIEwWekAaRGcA9jXjS/sftsWX5O7A==
X-ME-Sender: <xms:KAB_Z6ieo1ctHOiYECoRzvEEX3FKtMVcCDQjEX2wjTAdDftYwAsiZw>
    <xme:KAB_Z7CZC4xv_B6wz-FXheHZcjhoIDQg0QR-qkPrQmNHUy7O9XF5bUHX4TCIPRp5T
    Z8LNSVZZhY1woRibfk>
X-ME-Received: <xmr:KAB_ZyHopFID5ijYcUkZ--CWFyDHkRHpBa6e0gFRIZSFkQD2BSx-1OKvtrLktIHWSJQbWGr8Apaypyo3eJVETPd3EFg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KAB_ZzToEzrlH9xti5YJDLVqp6K7bomFN7g0FFPM7Op1ybaoLxRqSQ>
    <xmx:KAB_Z3xaTAH-_RwRl0wed7mHBNwOUnD95EP1dGVycgfv4O9ZSmFhNA>
    <xmx:KAB_Zx6LBJpSV5mftU_q9UUaQAkbwIbJ_kCgfP6AVjvHvUCuSPuOeA>
    <xmx:KAB_Z0zBMV-Vxc3YcxpHBAZ7pyhiXf0hGdz707DsyH5R6mLi1Hs69g>
    <xmx:KAB_Zy-7wWvsJwsvAr8k3xDJxAIl_JcsnclqD95R7gVLTPjAw--Pu57N>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:46:00 -0500 (EST)
Date: Wed, 8 Jan 2025 14:46:33 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 7/9] btrfs: subpage: dump the involved bitmap when
 ASSERT() failed
Message-ID: <20250108224633.GE1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <498c74501d1e3546bca42cceae875b3e8c90a1d1.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498c74501d1e3546bca42cceae875b3e8c90a1d1.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:44:01PM +1030, Qu Wenruo wrote:
> For btrfs_folio_assert_not_dirty() and btrfs_folio_set_lock(), we call
> bitmap_test_range_all_zero() to ensure the involved range has not bit
> set.
> 
> However with my recent enhanced delalloc range error handling, I'm
> hitting the ASSERT() inside btrfs_folio_set_lock(), and is wondering if
> it's some error handling not properly cleanup the locked bitmap but
> directly unlock the page.
> 
> So add some extra dumpping for the ASSERTs to dump the involved bitmap
> to help debug.
> 
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/subpage.c | 41 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 03d7bfc042e2..d692bc34a3af 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -635,6 +635,28 @@ IMPLEMENT_BTRFS_PAGE_OPS(ordered, folio_set_ordered, folio_clear_ordered,
>  IMPLEMENT_BTRFS_PAGE_OPS(checked, folio_set_checked, folio_clear_checked,
>  			 folio_test_checked);
>  
> +#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
> +{									\
> +	const int sectors_per_page = fs_info->sectors_per_page;		\
> +									\
> +	ASSERT(sectors_per_page < BITS_PER_LONG);			\
> +	*dst = bitmap_read(subpage->bitmaps,				\
> +			   sectors_per_page * btrfs_bitmap_nr_##name,	\
> +			   sectors_per_page);				\
> +}
> +
> +#define subpage_dump_bitmap(fs_info, folio, name, start, len)		\
> +{									\
> +	struct btrfs_subpage *subpage = folio_get_private(folio);	\
> +	unsigned long bitmap;						\
> +									\
> +	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
> +	btrfs_warn(fs_info,						\
> +	"dumpping bitmap start=%llu len=%u folio=%llu" #name "_bitmap=%*pbl", \
> +		   start, len, folio_pos(folio),			\
> +		   fs_info->sectors_per_page, &bitmap);			\
> +}
> +
>  /*
>   * Make sure not only the page dirty bit is cleared, but also subpage dirty bit
>   * is cleared.
> @@ -660,6 +682,10 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
>  	subpage = folio_get_private(folio);
>  	ASSERT(subpage);
>  	spin_lock_irqsave(&subpage->lock, flags);
> +	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
> +		subpage_dump_bitmap(fs_info, folio, dirty, start, len);
> +		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
> +	}
>  	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  }
> @@ -689,23 +715,16 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
>  	nbits = len >> fs_info->sectorsize_bits;
>  	spin_lock_irqsave(&subpage->lock, flags);
>  	/* Target range should not yet be locked. */
> -	ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
> +	if (unlikely(!bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits))) {
> +		subpage_dump_bitmap(fs_info, folio, locked, start, len);
> +		ASSERT(bitmap_test_range_all_zero(subpage->bitmaps, start_bit, nbits));
> +	}
>  	bitmap_set(subpage->bitmaps, start_bit, nbits);
>  	ret = atomic_add_return(nbits, &subpage->nr_locked);
>  	ASSERT(ret <= fs_info->sectors_per_page);
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  }
>  
> -#define GET_SUBPAGE_BITMAP(subpage, fs_info, name, dst)			\
> -{									\
> -	const int sectors_per_page = fs_info->sectors_per_page;		\
> -									\
> -	ASSERT(sectors_per_page < BITS_PER_LONG);			\
> -	*dst = bitmap_read(subpage->bitmaps,				\
> -			   sectors_per_page * btrfs_bitmap_nr_##name,	\
> -			   sectors_per_page);				\
> -}
> -
>  void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
>  				      struct folio *folio, u64 start, u32 len)
>  {
> -- 
> 2.47.1
> 

