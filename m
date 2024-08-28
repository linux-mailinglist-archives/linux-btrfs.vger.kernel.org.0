Return-Path: <linux-btrfs+bounces-7629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1228E962DF0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157A1282EA0
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 16:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420011A4F27;
	Wed, 28 Aug 2024 16:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qjXUEo8y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KJwMlf7f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F11A3BD1;
	Wed, 28 Aug 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864235; cv=none; b=uoWve8wTYbsNEGI6mzhK+hASukzb96lIOguWsZqA8WeW0spHcg8DBocC6v8iGchYhXubLr3NqiiVw9Z6bLBFMK9zTxE2YJoLEHUajZILjeIjbCQgzHT505pkWQo/nUexh0/Ptff1kqAMlB0XJy1gFdXxMU6BurRzvdgtgz/f53g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864235; c=relaxed/simple;
	bh=qSQZaic1piiRaVwBistKi7MzxIz1c4l5xA0Yz7ujkV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gbLaSMFPLxnwFaVpdz/Axh//fm0MM4VNw+5kJIxzmJtbLgQLxgnxV9p8Y94CWuruxYJWA/43b8b9ofTj57NWTnh7NU+8S144A9ZDvPkfgJ0IedpwsQ/qC2dpvnwHqvovGYh3p/pmidwfFWmJdb+++H1B4GiZ8gaqL0s49Ru34dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qjXUEo8y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KJwMlf7f; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B33021150DE1;
	Wed, 28 Aug 2024 12:57:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 28 Aug 2024 12:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1724864231; x=1724950631; bh=yZDFJ+uBkJ
	NN6I5DAKEUENScf20U9fLYyspVCQoBezg=; b=qjXUEo8y0CJNW4ycmbwMxJSKA0
	IIxzcgKwTNW2gse0g7STqGQhi95Cn1ahjhuOaeBbNaSrS7+8kSoTMwuqhP+X06sp
	U7OdBDyL1MjS6RMlvHtkgf/4IrLCBvqHoVcByVibRw1VDoNdymVuwXtCLihfgjEK
	QSHmyqV4QQlU8vNfyqOFkXODMPnEHzoWcxeOOEUs8XvpEMs3xMzcoJ3uOy4Fcf3P
	rgGyJTDtp/amWoCQmPWRCfR5ujVTbA5I3vq1Zc4iMgc1JNaR1/JINMgK0hvV5SIV
	ckc+ikkh1/tNV4SkOCXcg7u3GFETNYSWh3Tx06GSGpAdl/V2+GRuIt+Ae1Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724864231; x=1724950631; bh=yZDFJ+uBkJNN6I5DAKEUENScf20U
	9fLYyspVCQoBezg=; b=KJwMlf7fI+IJ0KyEG70caoGJTZxGgqCEMbuSPkPq1ts2
	whb1v4W5CoUEz5Nqu0ObL1W4Iy/l88Q9QzCIXk45StwLrQ3aqNdDYTKOvLUxvRUL
	cD08cZVyQb+NWYfq/0xBzMHZ7XX7wLYd3PuayDgiCzxA/f+2wBNzJH5ep+UhQNJ3
	SGutwDOvPAS4wRioXoc0uyynDPOflDxOzJv3qChJqhyrXYUatw2IySrb/y1vajsP
	z6Yc9Q6/SirCZ8JX7Y2oNBIQGPB0PteP+wFAMkM4uc/Cr9mKdfLobhXe2t7ulsHd
	uy2iUi6prMdPz0+gnB/t8P+uzayDVZjDMSeoKCr8FA==
X-ME-Sender: <xms:51bPZhlrSfa93G5JhiCXBTmwrignRq5Dn8MNbAcHLI-XY71oXGf0SQ>
    <xme:51bPZs0rfYRwsHIP_SKKDU1N_5f6WWGXxOZJLVOA0PCKX_VqCZpZ0R2PLYWt2dKO8
    01oVsJ80sIrNrj5zF8>
X-ME-Received: <xmr:51bPZnosAv3ao6mjzp6Juof3r0bP4hlsoNMIgC91HhRVtVEr8AXCfNQy-VlLSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqne
    cuggftrfgrthhtvghrnhepffekgeffueegffeitdeviedvvdeliefgkedvtdejieffffdu
    ffduhffgjeelvedunecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghdpkh
    gvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedutddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphgthhgvlhhkihhnsehishhprhgrshdrrhhu
    pdhrtghpthhtohepqhhufigvnhhruhhordgsthhrfhhssehgmhigrdgtohhmpdhrtghpth
    htohepughsthgvrhgsrgesshhushgvrdgtohhmpdhrtghpthhtoheptghlmhesfhgsrdgt
    ohhmpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpdhrtghpth
    htoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlvhgtqdhprhhojhgvtghtsehlihhnuhigthgvshhtihhnghdrohhrghdprhgt
    phhtthhopehshiiisghothdokeduieejtdefiedvtgdvkeeffhefuggukeeklegtsehshi
    iikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:51bPZhn4Pb9cATyffAApZvHsXUfy_Dz7Sw5Wo8Uv7oxTLxxLfYBonw>
    <xmx:51bPZv3cmLswj7tdXprordllUjzex-qkUz6aQA3ftJ7d5rAJp91pDw>
    <xmx:51bPZgsCxNajM1J9wWZHLga3ZgPaykxjxsfVvueWxQcWs55C6BvfTg>
    <xmx:51bPZjVSDGqAD8GuTBeCWVYGJzVtj0uWdtHdHxTYwawM_lnfzT285A>
    <xmx:51bPZouolGbTmzj-nSG2hWMEdZ8iKhJcEJXdcMWxyRMHXPpmjQh7PLgm>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Aug 2024 12:57:10 -0400 (EDT)
Date: Wed, 28 Aug 2024 09:57:05 -0700
From: Boris Burkov <boris@bur.io>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, David Sterba <dsterba@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: qgroup: don't use extent changeset when not
 needed
Message-ID: <Zs9W4dIlckbUt5JM@devvm12410.ftw0.facebook.com>
References: <8d26b493-6bc4-488c-b0a7-f2d129d94089@gmx.com>
 <20240828161411.534042-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828161411.534042-1-pchelkin@ispras.ru>

On Wed, Aug 28, 2024 at 07:14:11PM +0300, Fedor Pchelkin wrote:
> The local extent changeset is passed to clear_record_extent_bits() where
> it may have some additional memory dynamically allocated for ulist. When
> qgroup is disabled, the memory is leaked because in this case the
> changeset is not released upon __btrfs_qgroup_release_data() return.
> 
> Since the recorded contents of the changeset are not used thereafter, just
> don't pass it.
> 
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> 
> Reported-by: syzbot+81670362c283f3dd889c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/000000000000aa8c0c060ade165e@google.com
> Fixes: af0e2aab3b70 ("btrfs: qgroup: flush reservations during quota disable")
> Cc: stable@vger.kernel.org # 6.10+
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

This version looks even better, to me. Thanks for the catch and fix!

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
> v2: rework the fix as Qu Wenruo suggested - just don't pass unneeded
>     changeset. Update the commit title and description accordingly.
> 
>  fs/btrfs/qgroup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 5d57a285d59b..f6118c5f3c9f 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -4344,10 +4344,9 @@ static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
>  	int ret;
>  
>  	if (btrfs_qgroup_mode(inode->root->fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
> -		extent_changeset_init(&changeset);
>  		return clear_record_extent_bits(&inode->io_tree, start,
>  						start + len - 1,
> -						EXTENT_QGROUP_RESERVED, &changeset);
> +						EXTENT_QGROUP_RESERVED, NULL);
>  	}
>  
>  	/* In release case, we shouldn't have @reserved */
> -- 
> 2.39.2
> 

