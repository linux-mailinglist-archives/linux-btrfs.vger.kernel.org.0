Return-Path: <linux-btrfs+bounces-15857-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ECECB1B9C7
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 20:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D845166462
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Aug 2025 18:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA39293C5C;
	Tue,  5 Aug 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="TFbB1+aL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1ixT2hy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6155E11712
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Aug 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754416986; cv=none; b=M4GTZLR05peHhZ5CwNuMrmpAM0pmhRy2t3QdLlQZdHGA90OhagmDtL0kVzf8TmtXmTH1NYKOnCz3E9D/SiJ9BuR5Fkso/y22WACd3gtU2fxR3B1JukqyTxHRiC8OQ2EyuNrV1yAV7RDN5zP0ZvXA/xK2JYRO9gksmUhPz9MXCOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754416986; c=relaxed/simple;
	bh=pdg48m79CGDFOTAJa7UdunlVInN4tk2pcamopax1zsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWSk4rYFx9PqFm6m+03gfUC4Mp95XwQfLGfpGCZp3/skKjr4mVyXmcHkhuRTyujjfWBhAN4XL8d1i/Q+pa8f3vEY11Fe14GNASAK+HgCrLCuTDz6qC6rgtFsT1te3aZKAiZHYN3lrWxtgcnOMg67mhZSGEnSkcEVKeyCtO/OlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=TFbB1+aL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1ixT2hy; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5326A1400143;
	Tue,  5 Aug 2025 14:03:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 05 Aug 2025 14:03:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1754416983; x=1754503383; bh=pT//nNPLDz
	GfaeDh239813NwMUEEM1mx1d+T5pJ8L1I=; b=TFbB1+aLDSn0jm7TuzUAYonxwb
	XDK5nc7/LXqx2Qh+nE3HCBdIXpt/dLH5IJWaq96O/QRe22fqyAigA2srdE8N6Lh7
	CT44T0foIY/Bn02sJhcRdojy33TNU+akJo1TQl+ZI+rz3F8RHGo6rJdZqR+NNtfy
	i8D6YHqvfrclKGXLX2t1rYlatLayWG0uHjltFDWlUwCbAJLVqRa4DhdCPtUKjlX8
	0D8CwkSGLcAZs9KCiO29cuWWdSGsPq7Eb1VdEMud+NAvF/W7A8FxFMt6tYgV6+m/
	ZooLrwaMqD8SEfIC6fqhkWcwUE2Wv7oOQdM4nR0hLxujT/kht/wPX4+Ai2Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754416983; x=1754503383; bh=pT//nNPLDzGfaeDh239813NwMUEEM1mx1d+
	T5pJ8L1I=; b=B1ixT2hyw1GOyAm2P9MR2VIS1wINoVj2G1E817J+WZo3InuNdVB
	y5HAXBUvhKuPYXHGdp3pfw62BGFqfpWYi0TQDxHx2H1a5RM43lfL2+utHFQv4kaD
	/xZV5+veU4wfK3tGYCkWbzbOb2YjzjCCoxoFGV/ny3jAele+A3rE/TH8VTTo6IPW
	UCDNeZ8znlfzKFtXH3bNCQIbXdxfiBc8HcqSBQ+QX3TSScGFIOWMYVqvGRNT2J64
	rxWMCWpqTZwwf9gssghard3dgzUbbuy6cKb4m1S8MSkWVxICBQ61A/Fmkgd8igOC
	yQX0zurBkG78Cp3X77Gaytg/GOmocVCFR5A==
X-ME-Sender: <xms:VkeSaMUulsEwpBxNjqF9HwEXFS1-zb8XH2r4wkfoz63f8UKrwhquZg>
    <xme:VkeSaAze24I7HBCNeyCsYlXwfWvAOjCj-X_RXDEs5DDF2KzZm1KlpmYFPxJ527-1b
    4Mw9HOojaNft9g2Q-w>
X-ME-Received: <xmr:VkeSaCOcBoTFQwLyV52qQvzPj_XYp3GGogj2F3cSmRc5IVeQUjxW9QgvuDWkA3w5ajDt8d5WVEok9fpOlJXqaZ2yo5s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeegff
    fhleeiueevgeefveffjeevfeetgedttdfffeekkeeiffekieetudeiiefgffenucffohhm
    rghinhepvhgrlhhuvgdrtggrthdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhgrnh
    gurdhjrghinhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhf
    shesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VkeSaJ5qIlui0GnshmVcu_itHlpakyDs_txyQTdIJ_3Y23lIhpEQHA>
    <xmx:V0eSaLNEsaQQmWUQfLdDKjeqnuf7G9M0kEeJBGEDcYHsSEKuABP1ww>
    <xmx:V0eSaPnEy80tc_l8Ipt0bG-cBb5_J6uOEWohMsLYtxprm7E9V_AGWg>
    <xmx:V0eSaKSLGOgS9Oy0ZAiWIBfXQvHgnKJBHX19pbAbdmaRYFADrJPdwg>
    <xmx:V0eSaLt_d6ijIYb6iWU_bU86lih9MfrF4NQoJFlscitw-_gqd1k41t4g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 14:03:02 -0400 (EDT)
Date: Tue, 5 Aug 2025 11:04:01 -0700
From: Boris Burkov <boris@bur.io>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs-progs: check discard_max_bytes in
 discard_supported()
Message-ID: <20250805180401.GA4088788@zen.localdomain>
References: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <614684a6dfeafb1e4d2fe721b2b89f564449d223.1754413755.git.anand.jain@oracle.com>

On Wed, Aug 06, 2025 at 01:14:19AM +0800, Anand Jain wrote:
> Some devices may advertise discard support but have discard_max_bytes=0,
> effectively disabling it. Add a check to read discard_max_bytes and
> treat zero as no discard support.
> 
> Example:
> $ cat /sys/block/sda/queue/discard_granularity
> 512
> 
> $ ./mkfs.btrfs -vvv -f /dev/sda
> ...
> Performing full device TRIM /dev/sda (3.00GiB) ...
> discard_range ret -1 errno Operation not supported
> ...
> 
> Fix is to also check discard_max_bytes for a non-zero value.
> 
> $ cat /sys/block/sda/queue/discard_max_bytes
> 0
> 
> Helps avoid false positives in discard capability detection.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> v1: https://lore.kernel.org/linux-btrfs/2f9687740a9f9d60bdea8d24f215c6c0e2a9657b.1753713395.git.anand.jain@oracle.com/
> 
> v2: Checks for discard_max_bytes().
> 
>  common/device-utils.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/common/device-utils.c b/common/device-utils.c
> index 783d79555446..d110292fe718 100644
> --- a/common/device-utils.c
> +++ b/common/device-utils.c
> @@ -76,6 +76,17 @@ static int discard_supported(const char *device)
>  		}
>  	}
>  
> +	ret = device_get_queue_param(device, "discard_max_bytes", buf, sizeof(buf));
> +	if (ret == 0) {

Looks good overall, one small thing I noticed:

I was a little surprised by this check so I read
device_get_queue_param() and saw that it does return 0 on every error
condition, except for the final read() call. So if that read() fails, it
will return -1 and then this logic won't work. That applies equally to
the existing code for granularity, so it's not a new bug in your patch.

Unless I'm missing something in that analysis, I would either:
make both of these checks for <= 0
or
fix the return at read() in device_get_queue_param()

Thanks,
Boris

> +		pr_verbose(3, "cannot read discard_max_bytes for %s\n", device);
> +		return 0;
> +	} else {
> +		if (atoi(buf) == 0) {
> +			pr_verbose(3, "%s: discard_max_bytes %s", device, buf);
> +			return 0;
> +		}
> +	}
> +
>  	return 1;
>  }
>  
> -- 
> 2.50.1
> 

