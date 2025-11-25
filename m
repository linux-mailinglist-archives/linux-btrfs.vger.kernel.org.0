Return-Path: <linux-btrfs+bounces-19347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D95CC8623B
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 18:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8AA33528E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Nov 2025 17:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9854E329E6C;
	Tue, 25 Nov 2025 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="hJEsPOVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFn8bF+h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152E5329C4B
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Nov 2025 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090348; cv=none; b=Rzlbmfv/AVigSdbB8xbSMtX1tEV0CrTK/iyIXAaTmB5JM1KMg49sWjj5QKGegg2Gw1JTq2WdcO2FsElNsX2O+8gQfJo5MHNYxJFQPQ25VUdB7RTp2X38hgKInc0TWNRM+FFRn/5j9PkP4hEaaNFaWE3z51V3+56FgMy4pdk6DRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090348; c=relaxed/simple;
	bh=J4HOirlry6ESELt5IM6LFZHGC5A1+WuXcj5TZAjjzIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=foZNwufBsJS5JvpQSa2j0Kc5G1Y0THBjT3onRBHZ9PNoxgS9+Dbb5iZB6+bpjT529hznhou99votGsbWA53L5igVvb5W0KJKafu76vOtxysLeCNKGQE/Y3Tcfxym5Fg9eUxxSy/eOg4bAjNE816+nGliNpJqNiir95W+s/hKyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=hJEsPOVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFn8bF+h; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3BEBB14000D6;
	Tue, 25 Nov 2025 12:05:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Nov 2025 12:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764090345; x=1764176745; bh=iIKLA61qwJ
	1REzUtG7umEeVCkfPn5Emk9cj98u+hRJI=; b=hJEsPOVd5H5OPgEIEas4BiPwTm
	ci0u1qVfDlyZEe5ISVlQ/R8ZJ1BkOWoJY/YQZmQIaF0hG4I/wVyhM6C8BbzegMJ2
	ldoCWfyfNkQCY8uMB/wrmyuF7S6Cl9ouHjVBh2vEiBg8XVS2w0n7DcDh2G5qvhW8
	jI7i3wcBv92p6O6TYoIpl7/ExgzOttnTFL60AGoli5vVF0JgdXwz64K6D+oihT/Z
	2uoxz4cKRjNXl3R56ymQskPoObSUIlfCv3/N7ji9yaExBXEmtrzeFmgQsY+HNSmY
	3GcB1SDbLebXntXeuh+3Dexzw4zRIHtk6lCB4VC1HWOtoVqGCU5ARWWrCMeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1764090345; x=1764176745; bh=iIKLA61qwJ1REzUtG7umEeVCkfPn5Emk9cj
	98u+hRJI=; b=DFn8bF+hRLNKhvoYeawoqb9loSKDgcwnhJqnImf+/dx08UZcPXS
	y8opiMTLI4BhIi3ngbjPSEhZAZbxPAcPLySY1nbCGG4Y67912q4UHuoFmrreT8wn
	+Z6VXl9jxuXSrKiAzf/wfvYrm2mhqrDFtiZOWVV81ObKxQp7C+o6nmuMgQJr/BHa
	SHDzLjgsaBvskq+bzxIPan32i5oHdPA+U0Q3Vmt33G2VHpo3/1OWA0lZkuF7nXy4
	qYbB1qhzhdNPpAtsNi0Lnli8OuysChl2luR//SwS7Pzu5P+lZVV9TZ17Sih44X1i
	poFNRMliZFhD9+VMHZHF/t2spcDWI+055OA==
X-ME-Sender: <xms:6OEladm2EzQbkRlc3At9zxEPCb6m05UP7qpkwBhpmBRikCijB3y54Q>
    <xme:6OElae1vS3m4ne-65LBejP5TKrXyWLG89gkX6RNHVYdukN1HPQtVLSewkuoJqzh7c
    9bms1u6wXO-Of7TjRl5SqfoSX0z0FiShsmUloy3iGytpUWQ_AwPxS0>
X-ME-Received: <xmr:6OElaRSMclQU_5s4rSBi8nRkP0XmmokM8wHxTUPZ9ngB2Jh-Hcl5REZMnvSnSJJRdIHevydCMiWwMT3oJQbwbPMAKFQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6OElaYvl6YBrfltB8bst0jPQ3jbGJZH8xu-WXnX-L3mBZsoedbb1Aw>
    <xmx:6OElaeYbvBehV4v7solky_hcBz-IszA3UH1qDmyuolKJNcF3KuPatw>
    <xmx:6OElaVtwyOW76G_R2LrGprbZO4I_ieD4yHRkuXcb1iWDpRObTw8G0g>
    <xmx:6OElaYFLwkRywWutw9HmGyQ_76z0tux-QqvRXegAszbaPbxh0g3zvg>
    <xmx:6eElaQRyhuBVLWlcGfVg6cziQv2FsvVhjQKI0r6zEMjSoA3WA3GgfdOx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 12:05:44 -0500 (EST)
Date: Tue, 25 Nov 2025 09:05:57 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: enhance error handling of
 __free_extent()
Message-ID: <20251125170557.GD1650435@zen.localdomain>
References: <cover.1763957608.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763957608.git.wqu@suse.com>

On Mon, Nov 24, 2025 at 02:45:25PM +1030, Qu Wenruo wrote:
> There is a github bug report about btrfs-convert crash, where
> btrfs_print_leaf() is called on NULL path->nodes[0].
> 
> The first patch fix the bug by cross-port a fix from kernel part.
> 
> The second patch refactor the error handling of __free_extent(), mostly
> follow the kernel patch "btrfs: refactor the error handling of __btrfs_free_extent()".

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Qu Wenruo (2):
>   btrfs-progs: do not dump leaf if the path is released inside
>     __free_extent()
>   btrfs-progs: btrfs: refactor the error handling of __free_extent()
> 
>  kernel-shared/extent-tree.c | 154 ++++++++++++++++++------------------
>  1 file changed, 75 insertions(+), 79 deletions(-)
> 
> --
> 2.52.0
> 

