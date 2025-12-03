Return-Path: <linux-btrfs+bounces-19496-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5410ECA1A65
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 46800301A1E3
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA02848AD;
	Wed,  3 Dec 2025 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NNTqyaXp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dPKbGfIr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BB158535
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796661; cv=none; b=geoo7ZR8eSROoDa7AsRorvqh8Cc0v1Zp3zcJ5AB6CNT+4J1Xm5qddJ1G6jNnuv3xdbXDUZngrGMyZ9rf/b+p5+gJVl8r2zEjyNvssSViC6Ww7ucQk6v3GHISwFD/OGSdSmbqSAOuUzcdk3BqTPWouBrQWk3Tg0a3El1urURJ3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796661; c=relaxed/simple;
	bh=OsushNEdnrYqmNSjkAcH2xSoHxmkQ87Bhjw0EEExxh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5kE7LTwA8tC5iSSy3qSmIG4wYhjp5EWxEpsVc/hHEmAepGX6FDx10GgiJhaaKYbYCWQ1b9Vy4O+aqeH8xLmMpFn330Bz6fOAAGtylv9pxLLNclu5hXWD019dw/VCyArU+E4xxG6Lx/O2BmmxeoZ2pyCYHffEzRLzvZ6FcxNiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NNTqyaXp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dPKbGfIr; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D82DC7A0196;
	Wed,  3 Dec 2025 16:17:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Dec 2025 16:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1764796658; x=1764883058; bh=6tU5uZ1SIq
	5+C1MliEyJI9oqLAlTg7aM4niZ+F9E2h4=; b=NNTqyaXpQJEUOe1d8z+qG4kNpM
	Lo+9x+OuMYy5DAJm79u31y2ATYrr1N9sPQQnSolomWnC4Ptcor9JEGYlPGdN9/Jh
	OYQYfkTSaUgOr+fFwoQnfydnoNUJLBkXQcXovgcExmN93SHm6G7XEhNimSHS364b
	pVtmC8oiYhoIg9joP+savsxdTaWlLWLsQ3K6PMkbtfeo5N/rVxPZVXkp1ftqGUOW
	Crvx55oBVl07b10UGx+KtNNE0hSCvd7rXjNfux3e0SXZnxGGIJ4UhKZbHCGB5eEu
	aTbLLHNVwuq1MIhOWMabs5przUZNSnpwx2rHcw/vc4tFHcvCJs0JKNmwJ5pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764796658; x=1764883058; bh=6tU5uZ1SIq5+C1MliEyJI9oqLAlTg7aM4ni
	Z+F9E2h4=; b=dPKbGfIrIX4zs+2w3V//qQ7r2k6FlTug74i3mgTkp4Sr5WObp1Y
	tgrgIaesgGRxAyPUII/y5GjSztRSCpjAld9oYgmjmssE2M/CgqcZP22tTjzGXL5t
	o+fJtbTXI4kPSOL5xAVIvRIz6aWQl5ahJp6dICYMkiPfqRjwelGbUudTZuFjNnrI
	ITDOiYijbypDsx+oyqyO4hLf/FcesTCBrTVfIAzCCmS3+V5w/yuyvp5eGPXgZyQd
	H2rT4MM/mXf3INcCc68cDyA8Wb6Rw8XZdmmAM7Bsdo8Iw9S6KZNY4lZeAL/yZDbW
	hxAXBVEil9MEzw8oidlzBA45Fe4XadxnCew==
X-ME-Sender: <xms:8qgwaVKDWHOiSojeo68GA2i_iPHGdk45euxQ53bP3mQxoqGcb9vFGQ>
    <xme:8qgwaXI116ZIzYB06k4zGVoK25PPBntezSdx-H2eXbuVjIiS1YiEniSfvPNP0PJI3
    0Utf9Ae0F6lQ0cCHNLrggNJeZ_96IXei13A8mXJGj7BZTEupLugZqE>
X-ME-Received: <xmr:8qgwabUjB7lTtlt6hoI_R0k-TDYq081CsCGcLwRDAoE6-VOA0KKQnSmM9BluQznA87LcURCoGBM6-XdC5Wsk5dRBqUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhephedthfevgffhtdevgffhlefhgfeuueegtdevudeiheeihe
    etleeghedvfeegfeegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrd
    hiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    fhgumhgrnhgrnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgsth
    hrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8qgwaRgb1Tp8QLC8jqCvIwxE_1zJbI0xx2dBDrKZReFpNF-CCtXKvQ>
    <xmx:8qgwae-W-jYi7751-uhuEmA7EyJs5pUAhETyXqolu7JjxmINbyMZ-w>
    <xmx:8qgwaTDpOJCPKFE5NafNqbO-cbARJYl6Y2us8CzZnobb1G8dG2mxdw>
    <xmx:8qgwaTIckf2raHIro8DNlhIUlyEFlpcGhUfj-EwGTla6N87xX32_pA>
    <xmx:8qgwaU-KmsxDWZXbqn25adKTy0NvBHsi5We5x2mShSpM3PE7q9kKCaTX>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:17:38 -0500 (EST)
Date: Wed, 3 Dec 2025 13:17:58 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: do not skip logging new dentries when logging a
 new name
Message-ID: <20251203211758.GA3589713@zen.localdomain>
References: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b70971f8b73d44695ab6af56b69e0ae1010179.1764783284.git.fdmanana@suse.com>

On Wed, Dec 03, 2025 at 05:38:05PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When we are logging a directory and the log context indicates that we
> are logging a new name for some other file (that is or was inside that
> directory), we skip logging the inodes for new dentries in the directory.
> 
> This is ok most of the time, but if after the rename or link operation
> that triggered the logging of that directory, we have an explicit fsync
> of that directory without the directory inode being evicted and reloaded,
> we end up never logging the inodes for the new dentries that we found
> during the new name logging, as the next directory fsync will only process
> dentries that were added after the last time we logged the directory (we
> are doing an incremental directory logging).
> 
> So make sure we always log new dentries for a directory even if we are
> in a context of logging a new name.
> 
> A test case for fstests will follow soon.
> 

At first I was confused why it wasn't more clear that it was a revert of
the original patch, but that one was from 2021 so I think that this more
"natural" undo makes more sense.

Reviewed-by: Boris Burkov <boris@bur.io>

> Reported-by: Vyacheslav Kovalevsky <slava.kovalevskiy.2014@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/84c4e713-85d6-42b9-8dcf-0722ed26cb05@gmail.com/
> Fixes: c48792c6ee7a ("btrfs: do not log new dentries when logging that a new name exists")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 64c1155160a2..31edc93a383e 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -5865,14 +5865,6 @@ static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
>  	struct btrfs_inode *curr_inode = start_inode;
>  	int ret = 0;
>  
> -	/*
> -	 * If we are logging a new name, as part of a link or rename operation,
> -	 * don't bother logging new dentries, as we just want to log the names
> -	 * of an inode and that any new parents exist.
> -	 */
> -	if (ctx->logging_new_name)
> -		return 0;
> -
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> -- 
> 2.47.2
> 

