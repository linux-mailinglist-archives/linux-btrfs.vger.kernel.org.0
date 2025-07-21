Return-Path: <linux-btrfs+bounces-15614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA79B0CBD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 22:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCD97A619F
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jul 2025 20:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E1D238C3C;
	Mon, 21 Jul 2025 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="vaYZxM1G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MLJ91skB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849B7DA7F
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Jul 2025 20:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129898; cv=none; b=YwmbOTHkiGQZcXGkbsW7w4Inf++kQ1MgBr9GB9/xY9zWPHKjVXEQlZE3XixM6Nv7eUMVjYwmU3gQ703CyMTHa9V7ShxAL+MhFRQMt93stz+MviUZbYTcCub8/lfCAxQw3M/HA78VKFaUIeieSLG8/ahT7T8LiAFyVnMVRWo24ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129898; c=relaxed/simple;
	bh=l5PihvpNDAyeoA4rap6ixguly3ezH2HeySQGSCVMRQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2rOJXCd9V0TGVJFcUTglMSqQQuir1kh90qiH7UNJXjZRhB4oLnThuVN8W4AhP1Z0YtpNkwkpSxSxwOwg2a5SErFOdi8lYP1KrEy7/cTV3orAbq2X1+AID+anFMai8/I89CQ287UHzamQPOPrvHuvNVCsDdIZhvaqz+iabRiznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=vaYZxM1G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MLJ91skB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E24ED140020B;
	Mon, 21 Jul 2025 16:31:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 21 Jul 2025 16:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1753129893; x=1753216293; bh=DC8tCK3Ytr
	Wun2UtSWefcxCZP9Kembo07tLb48G2DSA=; b=vaYZxM1Gb3aj8ewo9KqyE5rRkL
	oxoKa2ru4NnpWnS1/U5tdQyXGvZEa3QZWMAO9u/E9Wyhm+qptXeoYkd60saGrMUy
	+OmTVqfn/hNTpQ7GK5wik5HvCHtWmFJEUhfa2XTNRpVKe5vdXb//TDceUjKJaDYV
	H4q9Bft8jtk0RLqpSuOUu0t7jLrjTe51KnPJF4CaS5G+tibqV5gcpn/lGHuOw1f8
	IPA6EJur9BPuSyyzeVK8AtEWVZvG+gwgwIAaM15foVOcypp7Pb1DpeA4A2T+WBzf
	VeXfHZKeUO85WVnyw/wBjllQdDipfYWm5uYrys8ovVgThFtHw9dvRxd8+97Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753129893; x=1753216293; bh=DC8tCK3YtrWun2UtSWefcxCZP9Kembo07tL
	b48G2DSA=; b=MLJ91skBIpgm9/ni+I6VvMbGxyHUNEY4J9iE4nUN1idcnobPKP5
	RiYCCeOWQ4FNkIXfUTZY4xRFnliRjpCLgR1NCCvRhR2WTpoYk2rIHCl8GjgxH1mY
	xb44BHK7al+G7Ex75EEtyM7XVpE1eLL9r1LtsxzTKUOBsLSbUtBpv+9yM1A6GZgB
	+CP7q1gmeqloj2+CPp40+zQod3biGNZLxyLVGyvEzJmjFcNUZiu3gOZg1xCOqqM1
	9WQ8se3t9lr2SyBrE7EkAcz4Q2AQdlpLngtcnv7yFLVuuAeagT/OYD2jGHmM43dt
	ZTljscmzl48tWQSGVq+SlmKeuFu1PZ3r2Cw==
X-ME-Sender: <xms:paN-aCW4MZlcjDxHqgcFcBC7jg8Rqh0pk3pFJQJFcmiwt9hJlr-nVw>
    <xme:paN-aOybAfLQ7YOKfJkleFZ38E9BVy0PA-cnOXX8GXoiIBpAB3GOQcU0XApcpPE2i
    U6PmSsQKmYvFpm4gb8>
X-ME-Received: <xmr:paN-aIO0LwoqGcwvtW3GMJ-VDok1MR5L99fnVe39yK2rfDq1nbiWqrvqxdryCnyg5HfgmGHJ4eoFDtHmRxX4WMazDdU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejfedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:paN-aH4LCB-zjsoZDnh6f2M1VTovUC09Jy6jucoWl_KzrfeSnWQy8g>
    <xmx:paN-aBMEgOo1I-0nGGUDadBGFagVl4UCBJEBjen7airyCee53kKgKg>
    <xmx:paN-aNmAQ_Ob8WUoiis6Jwr5kHE8xY0hw09c0GGsdK4Ii-mLIZnTFw>
    <xmx:paN-aATKXuFeVR4RlGcNMKgLP2W6VK5Tmf_vYT6Pas2tWREwyEUR9A>
    <xmx:paN-aGm3aO_Ah7jnfjXQmO3x0RiA_KAaBfdDjD11smxqnPWiVEej4v7f>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Jul 2025 16:31:33 -0400 (EDT)
Date: Mon, 21 Jul 2025 13:32:58 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: make btrfs_cleanup_ordered_extents() to
 support large folios
Message-ID: <20250721203258.GC2071341@zen.localdomain>
References: <cover.1752992367.git.wqu@suse.com>
 <73ff1bee04330a931e235a6100390dbf7c0af00e.1752992367.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73ff1bee04330a931e235a6100390dbf7c0af00e.1752992367.git.wqu@suse.com>

On Sun, Jul 20, 2025 at 03:59:10PM +0930, Qu Wenruo wrote:
> When hitting a large folio, btrfs_cleanup_ordered_extents() will get the
> same large folio multiple times, and clearing the same range again and
> again.
> 
> Thankfully this is not causing anything wrong, just inefficiency.
> 
> This is caused by the fact that we're iterating folios using the old
> page index, thus can hit the same large folio again and again.
> 
> Enhance it by increasing @index to the index of the folio end, and only
> increase @index by 1 if we failed to grab a folio.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/inode.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fc47e234b729..5259bb8ec430 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -404,10 +404,12 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
>  
>  	while (index <= end_index) {
>  		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
> -		index++;
> -		if (IS_ERR(folio))
> +		if (IS_ERR(folio)) {
> +			index++;
>  			continue;
> +		}
>  
> +		index = folio_end(folio) >> PAGE_SHIFT;
>  		/*
>  		 * Here we just clear all Ordered bits for every page in the
>  		 * range, then btrfs_mark_ordered_io_finished() will handle
> -- 
> 2.50.0
> 

