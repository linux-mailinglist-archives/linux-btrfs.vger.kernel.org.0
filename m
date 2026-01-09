Return-Path: <linux-btrfs+bounces-20349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F1CD0BCB7
	for <lists+linux-btrfs@lfdr.de>; Fri, 09 Jan 2026 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67B533026C1F
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jan 2026 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB715366DCA;
	Fri,  9 Jan 2026 18:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="fb+fJl+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSvmWKZJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D2366DB7
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Jan 2026 18:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982063; cv=none; b=dl7XhmhA97Km1Gt/n7B4j2nBjQs5769wgkzVH0j98Tcod61saZ/vtagHQk3wBx73fgdaPWvZM5P1p+Cv29Vwqn6jxlFmwroGkkURP5EYzqqxQzDqlsABQzPh20ojWd511XyB6QLf1jlQ7RIbfSHbqBnG99lS/N/1Y9Ux+sckqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982063; c=relaxed/simple;
	bh=xXq4I1q9qtORso6ZGEMh06VMFvVJgOnvG0fa3oVkT9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN0ze2rWHmyZj7tJSWySqo3ZgGdjHLWibSZMPFtcOGiiSE9iNfx1CpG3RzHlvR9twBoGJktj/oy3qjcBDmFjx2KjdAWRBZY8hlcQWSf7EQbq/o71umkU6aJFZ9kc9Ahe4EBvRFx4/hWwJQwJuKFeYblxptrtqdFCKD4e+oRsYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=fb+fJl+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSvmWKZJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E273DEC00FF;
	Fri,  9 Jan 2026 13:07:37 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 09 Jan 2026 13:07:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767982057; x=1768068457; bh=MrscVtIHf/
	SQyDfVOF9hLO13tDaMith4OlYyAD+XvpA=; b=fb+fJl+jmsbQMpQQBz6dcA6CCX
	sZ4ttw3eaQPn3ocAWjNkkuE9LozZW5Zm20LUxYxb1tI8npIRSunjGYnaC83sEL4J
	YmZtZH7wDVdqtUkePdm3OGoXj5p3eSaeNS6hEGfUbi7tOIwmv1uPurGyvln57RRd
	RKAZvo54QRAVUZkvAHeUgmrnuNmAB20sXCO3j4iRrKtd7VUFozu6jDPbd1b/OUsP
	yGp3d5K0JRB9/2ofo2sCrtwZ0OD47DkuTC5RFrZDd278RmC+iRcahpppFR93SV/X
	ntIMGwGkyN4dqo51ghMWpxyWBYsxqJDbCNjyQqNDOx5xuD6h57MlBykR6kQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767982057; x=1768068457; bh=MrscVtIHf/SQyDfVOF9hLO13tDaMith4OlY
	yAD+XvpA=; b=BSvmWKZJgA8BTT1kUYrAW9UdZsQ0yjNeU8/jjIl/brFM6YNiy9k
	y58d7w1l9nqphVkgwKy/0Si8/ZSKXwJSPszqb8y/gEFmPyb5PqZIxXgFJSc12Grd
	kNfYi8Sm88m6r0r5r5k5eWH34mgTlxRUKDb+p3+61ndG/WmYUNmtIGadLVsWhgVG
	+JEUL18MNVmy868kSLz2JBEhl5A/nRGsoCWgaAIG0WJElUfbz3gWGpDeMn5XJKxU
	abgEDW0dg1gc5vxTlfvE68qAoLNxzKo8UwrKlg946UFcqt9wXLZaRGM7+eBN6j5V
	lk/8pa2F2bWhKBzAl0Gy/YNBoe7XkrzeRxA==
X-ME-Sender: <xms:6UNhaXwRYgxdsDi_DxIYeQarLhLGGo00pUqeN6ZZ2PWWLuDARlb0kg>
    <xme:6UNhaVR5WuDYQdMiqwt5HxH7EZl4qnHPG-f8rsJPlEJ7BMXhz8FDKA0ZnJ6MTk1td
    Twsgyy4CJt1aBLX37640lC1CVnKSFOpS4FuPhptcQejJRZ_lFzav_w>
X-ME-Received: <xmr:6UNhae8WQLUdswOShJE-w9qQlY1_zH_tzXVHhBPPXvqrOtywwsliCnl1S_iqfnhw41P04x2M6PB3mo0_e0SXjAJO6Ns>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:6UNhacrGEk8PRqMUgJ_bVCEnt4j0--UVOjXqNOBXGQzSITs4a2Lstw>
    <xmx:6UNhabmdluEvs9JSzjxeSUQ6Ur9ceSTdA966Nu6IrAcplujOF9bxrQ>
    <xmx:6UNhaTJJ-dB_gb19ImefNyQV1iybvmlREmTMu-Ox-G_C8L10_BMZJw>
    <xmx:6UNhaQzJk6PN0u6mHJltna6aS-Nd-1u6Ev7mZr3QRlZccRKfPNZb2g>
    <xmx:6UNhaSmsRrNcCyYn5eieCjWVn7utO-XMzc735TnoSVWmGy66CEoU_ImC>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 13:07:37 -0500 (EST)
Date: Fri, 9 Jan 2026 10:07:45 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 2/2] btrfs: update comment for delalloc flush and oe
 wait in btrfs_clone_files()
Message-ID: <20260109180745.GA3036615@zen.localdomain>
References: <cover.1767960735.git.fdmanana@suse.com>
 <12c71c470eb0c53d0431ce7ddb1bfd58443fd872.1767960735.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12c71c470eb0c53d0431ce7ddb1bfd58443fd872.1767960735.git.fdmanana@suse.com>

On Fri, Jan 09, 2026 at 12:29:51PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Make the comment more detailed about why we need to flush delalloc and
> wait for ordered extent completion before attempting to invalidate the
> page cache.
> 

Thank you very much for the extra explanation.

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/reflink.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index ab4ce56d69ee..314cb95ba846 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -754,8 +754,13 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  
>  	/*
>  	 * We may have copied an inline extent into a page of the destination
> -	 * range, so wait for writeback to complete before invalidating pages
> -	 * from the page cache. This is a rare case.
> +	 * range. So flush delalloc and wait for ordered extent completion.
> +	 * This is to ensure the invalidation below does not fail, as if for
> +	 * example it finds a dirty folio, our folio release callback
> +	 * (btrfs_release_folio()) returns false, which makes the invalidation
> +	 * return an -EBUSY error. We can't ignore such failures since they
> +	 * could come from some range other than the copied inline extent's
> +	 * destination range and we have no way to know that.
>  	 */
>  	ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
>  	if (ret < 0)
> -- 
> 2.47.2
> 

