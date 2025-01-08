Return-Path: <linux-btrfs+bounces-10804-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC50A068B3
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 23:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F1164966
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A697204F75;
	Wed,  8 Jan 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Hm99XhuU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZxZ04PTy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5F120468A
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376302; cv=none; b=NZ1Erl4E9Tu2BYVPhd9ll+L8rJDrm4/eU5Wd1x5C7o2RA6Uo7vZ1COAgXrhYmk0Tn/uRT721kiDKnHLi9hW+8rEQv0fal4tzfPlfHxcieG8CayaoE2nU3HyfVjZzB60vUKPNK+uv9PEmOpDHacyBBwI8KNTjQvWxFosVnzqUEkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376302; c=relaxed/simple;
	bh=JjuM/fg31i1GLLIy4KjOAr8jHLLdjXB5ULOoF8K/JSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqFO/uqusAiEM6YASVGdSUJzIm6iuv0KfnpJw3QmdRfDVyeC26hVheFXW1Xbz8gJ8AfLT67VoMwwwASEFgO9KWktB1dLvtgsASQ5ipsnUvvwqdZkZ4CYtGXxaQAUfutYl2KPSA1tTLpvbHzr3hoL3frkXcoi6bzds7/svS56R1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Hm99XhuU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZxZ04PTy; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0F8625401D2;
	Wed,  8 Jan 2025 17:44:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 17:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736376297; x=1736462697; bh=OOZmOM+ivm
	GYFkghnMyBp3vmgVIimVygrITPQX1Z3WE=; b=Hm99XhuUjB8GE6eZAUo+3zQZXs
	+WlASewcpRg9VwYNXzoqilAn3x8TE1W3e/NsCgukGTZCVbBEomHLsuGDfr8ModfX
	h0wUuSpiMALEB0gNI4bhAbhzZU888wD7C1uZ5L86ulfcg3SdwXuCvB8Rqp0oqyB9
	x0/NAkFaSHnHhqbqNGMPDEB+u4qacY75Z7VHpMujTr05WoSKUpchjL7mXdplCVmi
	uLCOR53t3au8SD/zb4vNzAP2tJfK7tGxN5uD5IFdSke1QoTQcofKf0uLaDI1+6nB
	uc6vUKsckh3l4/aaZQtU6incfA6Fyc2G+L/FeLkZA0IQb67CKteLKUcRhF6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736376297; x=1736462697; bh=OOZmOM+ivmGYFkghnMyBp3vmgVIimVygrIT
	PQX1Z3WE=; b=ZxZ04PTyC4mPS6NY6Uxm5Rh04feFKOs9Qtev9Zgk5MBHpNAYnCX
	/7mvM9aVqm6hLhVD2Sip+T/gBoukg/gapVnwouaPQNL9x8OP2yM6IkZuG788H/ww
	RrpM9SDf/jhHXWa64a8wgLpYiSYRrOruAuM4XysJP/+OZctoku06rydXgPmOAEpT
	O4vHeqS+oiH3dmTcTC2vGhUc4hHIxVWUOhqea7oIq/uDnitF21WGKjlErLKiv+H/
	uCJkUGwf9JdoDIwHW/qOOKyXWHJ+wLlF2zHBoBwy2c56jcq3v9pahm9GiaWFmSuH
	nfNmQ6R/qA/Zu9kIMkx+aI63dpgvq08941w==
X-ME-Sender: <xms:6f9-Z1u4bCivqom2K6O11iQLO08HMYE16_dwlZtGaY7GZgkmIe4F9g>
    <xme:6f9-Z-dcxgnrvVtE91KM6K7B6VKra07_5XxXcERQ2EkOySOpht8NeJgnC3ZCrkj3g
    ADviP1ICIP1McSldqY>
X-ME-Received: <xmr:6f9-Z4xwQU-L33AqRxrOlYDwGk5P5nvCBdHOGuZetabLguC3bJO1HHp0vV6ELtWwoDdrikB3_CaGVdq8UDgBtmzNx6o>
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
X-ME-Proxy: <xmx:6f9-Z8Mf7vcrFjY5Bqmr0ElqqgbJ0_5WHcvnrVsGd-G60aO47RK1KA>
    <xmx:6f9-Z1989B4Xn4LO-rsEpgHzNBqWjvVQUE_q28gMp59FHVF-JczZQw>
    <xmx:6f9-Z8XqUGBEU8fdPHkwffU6-H1BixV8Ty49Irvh3uICvdNnSnxrCw>
    <xmx:6f9-Z2eFmmucJoa9no1O9JVRPFKpXOEScrItbwEHRXiqHApzZzuwbQ>
    <xmx:6f9-Z3IWSY6WVxRbrgqu-asOKyHznDwycEyXdCHxiQ125uDt79Ts2V5M>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:44:57 -0500 (EST)
Date: Wed, 8 Jan 2025 14:45:30 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 6/9] btrfs: subpage: fix the bitmap dump for the
 locked flags
Message-ID: <20250108224530.GD1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <7533f835b9a6da0a73a55d85cb3ab6388b3ac2df.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7533f835b9a6da0a73a55d85cb3ab6388b3ac2df.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:44:00PM +1030, Qu Wenruo wrote:
> We're dumping the locked bitmap into the @checked_bitmap variable,
> causing incorrect values during debug.
> 
> Thankfuklly even during my development I haven't hit a case where I need
> to dump the locked bitmap.
> But for the sake of consistency, fix it by dumpping the locked bitmap
> into @locked_bitmap variable for output.
> 
> Fixes: 75258f20fb70 ("btrfs: subpage: dump extra subpage bitmaps for debug")
Reviewed-by: Boris Burkov <boris@bur.io>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/subpage.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index 8c68059ac1b0..03d7bfc042e2 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -716,6 +716,7 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
>  	unsigned long writeback_bitmap;
>  	unsigned long ordered_bitmap;
>  	unsigned long checked_bitmap;
> +	unsigned long locked_bitmap;
>  	unsigned long flags;
>  
>  	ASSERT(folio_test_private(folio) && folio_get_private(folio));
> @@ -728,15 +729,16 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
>  	GET_SUBPAGE_BITMAP(subpage, fs_info, writeback, &writeback_bitmap);
>  	GET_SUBPAGE_BITMAP(subpage, fs_info, ordered, &ordered_bitmap);
>  	GET_SUBPAGE_BITMAP(subpage, fs_info, checked, &checked_bitmap);
> -	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &checked_bitmap);
> +	GET_SUBPAGE_BITMAP(subpage, fs_info, locked, &locked_bitmap);
>  	spin_unlock_irqrestore(&subpage->lock, flags);
>  
>  	dump_page(folio_page(folio, 0), "btrfs subpage dump");
>  	btrfs_warn(fs_info,
> -"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
> +"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl locked=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
>  		    start, len, folio_pos(folio),
>  		    sectors_per_page, &uptodate_bitmap,
>  		    sectors_per_page, &dirty_bitmap,
> +		    sectors_per_page, &locked_bitmap,
>  		    sectors_per_page, &writeback_bitmap,
>  		    sectors_per_page, &ordered_bitmap,
>  		    sectors_per_page, &checked_bitmap);
> -- 
> 2.47.1
> 

