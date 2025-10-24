Return-Path: <linux-btrfs+bounces-18289-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CADC06884
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC3F53B4101
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 13:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441DF2DEA8E;
	Fri, 24 Oct 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="DzQIOBdd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mEwksrwi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA93303C88
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312849; cv=none; b=h3h8IggOed9P0k4tEtVsM2XArMprGbt0gFC/q+O1WZoDhc5zggtFSSIhRKa66I1B9doqsGnMd0xCaP2uNB6t+Lu8VVWCQUPqMjMZ8uAC8JECYQZh5l3HQqNIM1/tuUBfPiHVvFXfl3yg17XSkel/yoj7UC90MMbZUnL+zmev9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312849; c=relaxed/simple;
	bh=rNe/wMVh+r43gOdK8YRpl2xWvTEexBZFYxKyF8+XnCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bCN0/8qu7jXwWqxIA3NG3fkTPZSVgAQV0yVR52ROt7jv8gWhOHjp0ZNnpkApzeqZSmBLdzh7bDuWEaD5dwjQtUrTF+d1KvzvQ5q8mCpqO7xWo+ykKND8Rnndl7jxfgAAF19qawbldCttpBHDTOM/acrlty1pdpcQt6mOhT0IQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=DzQIOBdd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mEwksrwi; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9EBA114001E1;
	Fri, 24 Oct 2025 09:34:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 09:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761312844; x=1761399244; bh=JUoF31XGhe
	GVPhu6yNPHfmcQ/jqLec9tHuNWP/DAcsE=; b=DzQIOBdd6YUpJC6qODYlCPj65i
	a6yM07qRdtoodU5rIkPelVlI+ZmvkE5FOm1ownASnjVu5pkbVkYFuryeqKfTG0fE
	ISrLM0R2rGfgqr1nBhl0QMrW7lvfIFne5Z6DE5WLkWy1v04sQocHAWH5FvRgw6BP
	3FuGy08hR9yUhNGn19elayMvsqRP+lqa7sACvWbpIqWrXdwM8IyXX1SyslLYwLIC
	Tv7v7RyLBBDpMpexWBZquFMO8EdefRLMOqhuQT+7GEhi8aeBMavp7MuNCexNc3wN
	LpPdXPjXI7NYU2NnZoSL/QnzKAROxpNuMDkCCB3ESZJgv9gYn/G2MkKCjq5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761312844; x=1761399244; bh=JUoF31XGheGVPhu6yNPHfmcQ/jqLec9tHuN
	WP/DAcsE=; b=mEwksrwiJRukr46t7a0Y3eGJiuIM6G9eEneHA3PdXZUPnOY02Wj
	ESE8hrujVIqf087nPUoaXmTGdalPQf4VBg9Uzi2RIgk4QFJxuSZKAz9JlVyK9ORi
	vEC/OHQU+r0k23FUK5z50HO3kukI2QjLXH9wKx1zeH/Ckt1hqmAgTZgaUbA8LVin
	tzdfhHdT+eZFijX5BCD8B0S6FjO2mOe2awFtTsb3V3MkBH0C4uTdmBhi8KuV/S2x
	sFUvULOb36Oa1/1VwgJYV6zntNT1j/kGaPXnxp3ivNMPEfVEOb7sZ4Dkg0uRFlET
	RxnpstlbOvBwajYUZ1Qpn1F13VY5w6i63uA==
X-ME-Sender: <xms:TID7aDyGQL6YCy30DazfT_97rRPLc1iLXwDR46rXRN-kTCqE-Yx0OA>
    <xme:TID7aBSv9pnn84tTSPNLeF-hOZkxSgonleHvdwtaIAnFYp0U3q4-6sJb2LkW55_SB
    h_eukd9czZbm6yU9EAxJUG0mlZyH5I78rdzDJ-pNtpUYXXAUUEo--E>
X-ME-Received: <xmr:TID7aK95DSIPlNrQ9kB_Bj2Y-8sybabPZ_ch3ImYDuSus9xse8W0-KrOAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeihe
    eiheetleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqd
    gsthhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TID7aIpSPrLOS8RpnG5g99HjoDjyHHCglRhG36yayl2DeYx7Ooeg9Q>
    <xmx:TID7aHmer4-2pbzqfxwNNINF2eoyDbHz2u-XTHrPTVBiIIyhi4ZCmA>
    <xmx:TID7aPIaS5lr6yzOkCTVdRUNyDJaFNVr7rQqIvmhOZIj2v4_HzqU6Q>
    <xmx:TID7aMyX3E06miR4v4TZ7-w5g9_E9s-d3xLwORxak1UcgJ3elLvpMw>
    <xmx:TID7aOna3RkoEz2OcD-h54lAcXZsEfYZnVU8QrO40me4KNUI8AqKdlhy>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 09:34:04 -0400 (EDT)
Date: Fri, 24 Oct 2025 06:34:01 -0700
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: set inode flag BTRFS_INODE_COPY_EVERYTHING when
 logging new name
Message-ID: <aPuASRBCj9Dy1PCO@devvm12410.ftw0.facebook.com>
References: <cf3df42390ff83be421dcdc375d072716a67d561.1761306236.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3df42390ff83be421dcdc375d072716a67d561.1761306236.git.fdmanana@suse.com>

On Fri, Oct 24, 2025 at 12:52:02PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we are logging a new name make sure our inode has the runtime flag
> BTRFS_INODE_COPY_EVERYTHING set so that at btrfs_log_inode() we will find
> new inode refs/extrefs in the subvolume tree and copy them into the log
> tree.
> 
> We are currently doing it when adding a new link but we are missing it
> when renaming.
> 
> An example where this makes a new name not persisted:
> 
>   1) create symlink with name foo in directory A
>   2) fsync directory A, which persists the symlink
>   3) rename the symlink from foo to bar
>   4) fsync directory A to persist the new symlink name
> 
> Step 4 isn't working correctly as it's not logging the new name and also
> leaving the old inode ref in the log tree, so after a power failure the
> symlink still has the old name of "foo". This is because when we first
> fsync directoy A we log the symlink's inode (as it's a new entry) and at
> btrfs_log_inode() we set the log mode to LOG_INODE_ALL and then because
> we are using that mode and the inode has the runtime flag
> BTRFS_INODE_NEEDS_FULL_SYNC set, we clear that flag as well as the flag
> BTRFS_INODE_COPY_EVERYTHING. That means the next time we log the inode,
> during the rename through the call to btrfs_log_new_name() (calling
> btrfs_log_inode_parent() and then btrfs_log_inode()), we will not search
> the subvolume tree for new refs/extrefs and jump directory to the
> 'log_extents' label.
> 
> Fix this by making sure we set BTRFS_INODE_COPY_EVERYTHING on an inode
> when we are about to log a new name. A test case for fstests will follow
> soon.
> 
> Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/ac949c74-90c2-4b9a-b7fd-1ffc5c3175c7@gmail.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c    | 1 -
>  fs/btrfs/tree-log.c | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 79732756b87f..03e9c3ac20ed 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6885,7 +6885,6 @@ static int btrfs_link(struct dentry *old_dentry, struct inode *dir,
>  	BTRFS_I(inode)->dir_index = 0ULL;
>  	inode_inc_iversion(inode);
>  	inode_set_ctime_current(inode);
> -	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
>  
>  	ret = btrfs_add_link(trans, BTRFS_I(dir), BTRFS_I(inode),
>  			     &fname.disk_name, 1, index);
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 65079eb651da..8dfd504b37ae 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -7905,6 +7905,9 @@ void btrfs_log_new_name(struct btrfs_trans_handle *trans,
>  	bool log_pinned = false;
>  	int ret;
>  
> +	/* The inode has a new name (ref/extref), so make sure we log it. */
> +	set_bit(BTRFS_INODE_COPY_EVERYTHING, &inode->runtime_flags);
> +
>  	btrfs_init_log_ctx(&ctx, inode);
>  	ctx.logging_new_name = true;
>  
> -- 
> 2.47.2
> 

