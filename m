Return-Path: <linux-btrfs+bounces-4845-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E18348C0100
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 17:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E8E1C2479D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 May 2024 15:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ADE1272B4;
	Wed,  8 May 2024 15:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="o8Ku0X/S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YgNA0I2N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264058664B
	for <linux-btrfs@vger.kernel.org>; Wed,  8 May 2024 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182365; cv=none; b=B9JYEFtS25QBkFpdlLblCg1QReJVgCOtstVaWgU2upOyPIxpTByETbl9P0vb0B4RctV6VVqBWQ2VH7BxKMvr/K94aIIFhjOLicHlDc2z6/5UMnhlfT9j59miz7Mp3PmL3VCRVVfxvFg5zPglh7XVBOhjsWMI/r7/+mwpvFkfhWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182365; c=relaxed/simple;
	bh=4lzmXRHLwzjpW+eGkNDko2Atw38Wdr7y6FHMuyg9bOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwBwEO5H1NhP6MMRgckIFY0Bg7U8R9i7u+9gbZqnFqWVdBGHp4xMZiOdeCuyznD0ku5QoOBloOeZWW5PFZDD/gaKnXcDei8NyJ3DyLEgoo1X1ZPF5Zjoh+oa/JH3GAghW3YqOhvcQC4KV0RB0zwhR2KGpQntYaU6Z1YMurkbW+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=o8Ku0X/S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YgNA0I2N; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 174D518000C6;
	Wed,  8 May 2024 11:32:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 08 May 2024 11:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1715182361; x=1715268761; bh=NOMZ7MYJ6q
	QLroUeEInUlaCcWX+2X3H1eoUhLZneWBI=; b=o8Ku0X/SHXtc1fLMvyGlRBhLfc
	pLT5FT4kUKiTVvAp+Dhcntt8Z/vtdQ4rJ3k328HOk6IxA9xA6T32l93C26Z4sy3b
	C4NxvhrNWk6GqM2QayB2IwhHtd9SqiXtbZBZKihsat8jaJ7sQDjRqTdpfEYUp+g/
	M5ezFwMcYJrehWpgcLs18lkw9MabQsHf+weTSpMWoobWBeOrDoNBe22RzNyP27OT
	EM5BKSIAebw1xvAFVTdAW5IFEg6gWB+JzyzFcCrNjP9GRSiEBts/hQBN23Jy95Tk
	8Dm8DbTKWaUCYnIrNcyQBE7B6Dvg+0BSGCYZ8ivVaIsBL8W6uqjYAQYvPV6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715182361; x=1715268761; bh=NOMZ7MYJ6qQLroUeEInUlaCcWX+2
	X3H1eoUhLZneWBI=; b=YgNA0I2NsGmUXMoYgT3DWS3TC2y6ZWCHr4D31yK+gJ33
	XaS5f020R93oL1Amlq8cORIW1dZRKrFefqWPBqK4sT9G6HYu5ZuIHBhLmIqfsKCZ
	MSY0mxLapmKVbQ0BaVld5qViiS3NzsDol8BNdWxAblk7kB03rvX/U198hsBA3wKr
	QihMYLs3fR0jdhalKL2vGKnko2GA0NnmjXwEMqxbXnH7JvFasIcLEUpWaU5YSHAO
	c4PpaImoHmPqwhtRGncX+huLdAA5t6sPq/AnvxTed1pKhU7YVtmZ4/6H8TxrAM/s
	4HChea0LYwzc1BvGnxqvkJIbzx74Yurw+hOGR1fTgA==
X-ME-Sender: <xms:GZs7ZhKMq4tx1J9IirCIKCtBBRlTF39vBF-9ZmTkSY0ieIu4uRzgow>
    <xme:GZs7ZtLrcJyVa64yyFQ_UWipxkdLhDck88E1mx3hngRU1WJ1UcnnEwt3W3xrOJkuV
    -qK4vkxpj86atJM5H8>
X-ME-Received: <xmr:GZs7Zpts64glmRhIW35Y_Pch89dFwlwcwElaaqgIN20vTuNcjxxHNmbiA_xS_RX_jIa221s91d5uZIIJeVcqDdfZhDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    ekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:GZs7Zibsl50abmYrneT5Si-ioIoyjzMMbeZdZKBTW9RmPqbGUMABiQ>
    <xmx:GZs7ZoZ0JXsSpFVYrZs-FZ3exfQfzDCph3G8-AuRm6JMllC0u5WBKw>
    <xmx:GZs7ZmCdETYWyeDBEIXEppr5whgA_32iDvJiHaHVdhMVXK0CiI8QRQ>
    <xmx:GZs7ZmbTAaBgPOmssZqamzeGjwIMPuU65xBP5-bRi-D3x7l1RB22Hw>
    <xmx:GZs7ZnlMXPHwIu66RY6Tn4nSm4iIF4vrp2bAEAmLSKa-1D341NTno9Hz>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 11:32:41 -0400 (EDT)
Date: Wed, 8 May 2024 08:34:59 -0700
From: Boris Burkov <boris@bur.io>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: update rescan message levels and error
 codes
Message-ID: <20240508153459.GA372255@zen.localdomain>
References: <20240502204558.16824-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502204558.16824-1-dsterba@suse.com>

On Thu, May 02, 2024 at 10:45:58PM +0200, David Sterba wrote:
> On filesystems without enabled quotas there's still a warning message in
> the logs when rescan is called. In that case it's not a problem that
> should be reported, rescan can be called unconditionally and leads.
> Change the error code to ENOTCONN which is used for 'quotas not enabled'
> elsewhere.
> 
> Remove message (also a warning) when rescan is called during an ongoing
> rescan, this brings no useful information and the error code is
> sufficient.
> 
> Change message levels to debug for now, they can be removed eventually.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/qgroup.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 1768fc6f232f..4714644daa78 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3820,14 +3820,14 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
>  		/* we're resuming qgroup rescan at mount time */
>  		if (!(fs_info->qgroup_flags &
>  		      BTRFS_QGROUP_STATUS_FLAG_RESCAN)) {
> -			btrfs_warn(fs_info,
> +			btrfs_debug(fs_info,
>  			"qgroup rescan init failed, qgroup rescan is not queued");
>  			ret = -EINVAL;
>  		} else if (!(fs_info->qgroup_flags &
>  			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
> -			btrfs_warn(fs_info,
> +			btrfs_debug(fs_info,
>  			"qgroup rescan init failed, qgroup is not enabled");
> -			ret = -EINVAL;
> +			ret = -ENOTCONN;
>  		}
>  
>  		if (ret)
> @@ -3838,14 +3838,12 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
>  
>  	if (init_flags) {
>  		if (fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_RESCAN) {
> -			btrfs_warn(fs_info,
> -				   "qgroup rescan is already in progress");
>  			ret = -EINPROGRESS;
>  		} else if (!(fs_info->qgroup_flags &
>  			     BTRFS_QGROUP_STATUS_FLAG_ON)) {
> -			btrfs_warn(fs_info,
> +			btrfs_debug(fs_info,
>  			"qgroup rescan init failed, qgroup is not enabled");
> -			ret = -EINVAL;
> +			ret = -ENOTCONN;
>  		} else if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED) {
>  			/* Quota disable is in progress */
>  			ret = -EBUSY;
> -- 
> 2.44.0
> 

