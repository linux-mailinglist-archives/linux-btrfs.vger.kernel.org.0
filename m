Return-Path: <linux-btrfs+bounces-2185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E06484C19F
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 02:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E98EEB23B67
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Feb 2024 01:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF7C2D6;
	Wed,  7 Feb 2024 01:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="NMe9broS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t8/cJdoC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46428F55
	for <linux-btrfs@vger.kernel.org>; Wed,  7 Feb 2024 01:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707267764; cv=none; b=s2PkKX/1B7RaYy1zqnsHHbBDoIjhTiLoHt+xRcsk8uL4oNWSp0y7BDg7gYodk4jLYtVTSFCyW1UV4mHHDlTS1MKVrroZMtQf4tc2PuatMFeQXxaoFoGv8wsIkr9ZoT7XGtICSWVE0HZEMWEWlUzD9cVQFXqttW+feiA0kK2oPz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707267764; c=relaxed/simple;
	bh=b3JrGJ6EECRy4uAxCozx+f6C9OOdwC3M6To+8zQRlbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTyaUICWwh5ExhBJX/BhjxFmj0WPlcSCOIIR8dniEGsZabJPhVJCvGo4XUmdRQBzF2X0P7+W3IdzS4rtuvhWBw4K6QDFD5FFU8B79XEQIvhk7km6eXPw45YRkX0YGZFx7xKHln6aKC92dGFvrd4TLb0zgFw4DM6KclIT5bAbaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=NMe9broS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t8/cJdoC; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id BFB903200A4F;
	Tue,  6 Feb 2024 20:02:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Feb 2024 20:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707267760; x=1707354160; bh=D3UrRn9fjK
	ZB6ngHp7HG5hUA/XQvreJWSyTbZy32SoE=; b=NMe9broSXpWBBh1Y7I3KA6B8OU
	Qsxx0ieK6ehWWi6aRyEUDj0ALf8wSakZWKFikYuTeNWIZGXIsLrHU6ggxIw+w16H
	1s+0k+CcVo4jm4x2xrVQPO9KHB88OV9wOVf8YGTJaKlNLZb8rdgCWxpO6QtS55F4
	OhTjvNxDthIQVBugMOiTGAQKPkeKp0ID0HfvuTdNRXCGT+Q0QNeENIAWzvWqTNp5
	NsNR/Gj04gMUeClIi0JiOJzwoiuOFR+tckh5xcPS4VW/LP5jmFrLjuiiov+kNmK5
	YI8uGaIdpm/D9ajg8LJ9unJdn+pF1DLpf+KmscgGhZf7ZsXK4zOoSNxOw9JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707267760; x=1707354160; bh=D3UrRn9fjKZB6ngHp7HG5hUA/XQv
	reJWSyTbZy32SoE=; b=t8/cJdoCkRtxcIPuCa+vgm5o6Sr4iwoaGDAUfOQ+B0g7
	Vm39+jOcAv/VipmDq9V36Arulb8Xv2b/Jv4Lb1fU9YKyi1jl6WU6gyY4c3JQAVPU
	ln+Fn/YSma7sxrNWOMhFb/+Eod9xejBmQYiTQyWVwbKRGOr+kHqNVmeorUpaEO2M
	QpOkwQ1XlGYkUCuTWb5uETmKBH79ocwIW6cTkjhNsZLBocxcATXH8y2gVGqkKn2Q
	OaX+ZFNt9qvef/gGIGGgAKvYT5EOBrnNwDo0ttdh9kzDBe9yklnuwZPkLxSKMY9a
	Vm8J+mEB3a3u9Pl/1na8BRhT9lgHXiogw3hph7c5Jg==
X-ME-Sender: <xms:sNbCZUf18DXOBXkFVZNJ-wbAFEKzG91Ht8fD_lEsxgZYaY4dGERb1g>
    <xme:sNbCZWNVYGtDOr881bDLUiuZFM5kNrMIw1TSB2h2H6B4SFAsn3u0RnDNv5422k3bU
    2GFpN_Vw9APCKPaBxQ>
X-ME-Received: <xmr:sNbCZVilX82gLCagt8WW3DVrQNYq8ZdbiE_-h4wG0t4xIP46WPnB3OtVVAI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepke
    dvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:sNbCZZ_iSWIJjVwR-Dgeix8ff5Fd3FO4lLDBrt5WSyiARP-Te5WbYQ>
    <xmx:sNbCZQsc6EP9BhJ9v3eGHfxRbxVNeqhLfnWhQ6-xc2R39Kn3gueYkQ>
    <xmx:sNbCZQFvEFhfYMbka0HqI4pYTpXUH6fMDAqXTEef861fon8EJnizSA>
    <xmx:sNbCZdUCmSzQfzaHie3tfRIIKbfsVpxNLQzy2sj33uAdgI_QWX5lOw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 20:02:39 -0500 (EST)
Date: Tue, 6 Feb 2024 17:02:35 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: defrag: avoid unnecessary defrag caused by
 incorrect extent size
Message-ID: <ZcLWq9FZJvVAjN88@devvm12410.ftw0.facebook.com>
References: <abb506b3d54837f79119cdff6c3e08a61e28eba7.1707259963.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb506b3d54837f79119cdff6c3e08a61e28eba7.1707259963.git.wqu@suse.com>

On Wed, Feb 07, 2024 at 10:00:42AM +1030, Qu Wenruo wrote:
> [BUG]
> With the following file extent layout, defrag would do unnecessary IO
> and result more on-disk space usage.
> 
>  # mkfs.btrfs -f $dev
>  # mount $dev $mnt
>  # xfs_io -f -c "pwrite 0 40m" $mnt/foobar
>  # sync
>  # xfs_io -f -c "pwrite 40m 16k" $mnt/foobar.
>  # sync

Are you planning to make this an xfstest? I think that would be good!

> 
> Above command would lead to the following file extent layout:
> 
>         item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>                 generation 7 type 1 (regular)
>                 extent data disk byte 298844160 nr 41943040
>                 extent data offset 0 nr 41943040 ram 41943040
>                 extent compression 0 (none)
>         item 7 key (257 EXTENT_DATA 41943040) itemoff 15763 itemsize 53
>                 generation 8 type 1 (regular)
>                 extent data disk byte 13631488 nr 16384
>                 extent data offset 0 nr 16384 ram 16384
>                 extent compression 0 (none)
> 
> Which is mostly fine. We can allow the final 16K to be merged with the
> previous 40M, but it's upon the end users' preference.
> 
> But if we defrag the file using the default parameters, it would result
> worse file layout:
> 
>  # btrfs filesystem defrag $mnt/foobar
>  # sync
> 
>         item 6 key (257 EXTENT_DATA 0) itemoff 15816 itemsize 53
>                 generation 7 type 1 (regular)
>                 extent data disk byte 298844160 nr 41943040
>                 extent data offset 0 nr 8650752 ram 41943040
>                 extent compression 0 (none)
>         item 7 key (257 EXTENT_DATA 8650752) itemoff 15763 itemsize 53
>                 generation 9 type 1 (regular)
>                 extent data disk byte 340787200 nr 33292288
>                 extent data offset 0 nr 33292288 ram 33292288
>                 extent compression 0 (none)
>         item 8 key (257 EXTENT_DATA 41943040) itemoff 15710 itemsize 53
>                 generation 8 type 1 (regular)
>                 extent data disk byte 13631488 nr 16384
>                 extent data offset 0 nr 16384 ram 16384
>                 extent compression 0 (none)
> 
> Note the original 40M extent is still there, but a new 32M extent is
> created for no benefit at all.
> 
> [CAUSE]
> There is an existing check to make sure we won't defrag a large enough
> extent (the threshold is by default 32M).
> 
> But the check is using the length to the end of the extent:
> 
> 	range_len = em->len - (cur - em->start);
> 
> 	/* Skip too large extent */
> 	if (range_len >= extent_thresh)
> 		goto next;
> 
> This means, for the first 8MiB of the extent, the range_len is always
> smaller than the default threshold, and would not be defragged.
> But after the first 8MiB, the remaining part would fit the requirement,
> and be defragged.
> 
> Such different behavior inside the same extent caused the above problem,
> and we should avoid different defrag decision inside the same extent.
> 
> [FIX]
> Instead of using @range_len, just use @em->len, so that we have a
> consistent decision among the same file extent.
> 
> Now with this fix, we won't touch the extent, thus not making it any
> worse.
> 
> Fixes: 0cb5950f3f3b ("btrfs: fix deadlock when reserving space during defrag")
> Reported-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>)
> ---
>  fs/btrfs/defrag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 8fc8118c3225..eb62ff490c48 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1046,7 +1046,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
>  			goto add;
>  
>  		/* Skip too large extent */
> -		if (range_len >= extent_thresh)
> +		if (em->len >= extent_thresh)
>  			goto next;

The next check is using em->len and checking the max extnt lengths,
so we could theoretically merge the max extent size and thresh checks now,
by taking the min of all the relevant options or something.

>  
>  		/*
> 
> -- 
> 2.43.0
> 

