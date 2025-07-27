Return-Path: <linux-btrfs+bounces-15696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE26AB13177
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 21:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A881896252
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Jul 2025 19:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF781E5B82;
	Sun, 27 Jul 2025 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="Taj/WVpO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fFiPE+ep"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A391C5F37
	for <linux-btrfs@vger.kernel.org>; Sun, 27 Jul 2025 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753643167; cv=none; b=bB/CLskotrC8i+uueMzofuE2e9OW9oAjRTamnTJ8pkT2PEh8PVHHpjDMZWCR/8Hy9h+ISblp3Hq/ulFYR536pK9AabF/7o9H9/rrTzcfi5no4cD+hjgwt9wAkSkgH4nEGkO9Ppa6MepF2bluHLdsUcu219v8Cpr2DMljbVSWvL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753643167; c=relaxed/simple;
	bh=x7amoG78VqygEVKsixgvbq4ItHbEjs12wjJnQ5JxeV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjX5kQYP89QuqH1qzt0UUKF5KibUeyimBhj5FjaN21zZHq15mxSDNd9qOzTIUh9LxyqZ+cppYTeoClvgA5ebIthzTfusGqw6uj7E7I48YuDuO6CcCZNT13KxWLJJDL12H7hCVwXMF1XnbcNvvmdsp+r++7ssV1CB+HxHHkyVLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=Taj/WVpO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fFiPE+ep; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 143F27A01AB;
	Sun, 27 Jul 2025 15:06:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 27 Jul 2025 15:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753643160; x=1753729560; bh=OXvgcHGcyU
	MRzBBYwpRDfifMoLAKG0HZmq94pSI27sk=; b=Taj/WVpOwuBHupcLzAQJstFEEW
	KwuO21Mk44WNk/7MfukLP05Gyw1ClLe6Qu37FbzxEFF2u3jhqGbLXqWYj9R5JZSl
	0OomKiNBk8rYfJ/+Vw5j5KDnLIcCAp05FYuQXeuy+34B6HpX1CEVrVfFt2nYb0oT
	ew8nzy2o/fydlluP1pzNoKZzKdFB3t4mf40GR8/0y8D7+is3DDefO2kkXiQ1nkJZ
	0EmmZgCbJRNYnj2SDJWVbKr5tSYx4odl3a1Oa/vi5NU/IH081+fCcgz7b06gElkN
	jTshFkb4SF9kW07SB8yS04pzhquYfp+f5baBEQSCG0hYtWJesWLz/7I4yStw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753643160; x=1753729560; bh=OXvgcHGcyUMRzBBYwpRDfifMoLAKG0HZmq9
	4pSI27sk=; b=fFiPE+epeCPTYVMGDS7IVZAWFo7CSYpSASMXAte8dq9kXzXCIkk
	naA55EdnUrpOQFS9r0S90npDcv/8Gw5M0thgiEOynPShC5mPZKCL6mK85Eefuzdl
	nKAASqq/Ndin/W+d/U5eq643eI7nRCdIZUXtAkcSc269HWQv6fmggGX+yGA5pY73
	ifjOOJJZ2wDihRIqp6Ecv5KBi1Fk1J0dqvMQJCU0Ja702E6sd5Ix6GuPIZ3MmwP/
	2GVrHzh3mebQZMN2rKHih4FGOJZNcJ0G7M/z/FNyBHSqoa+hHrEqzTCJ0Dc8sZmD
	cX8w5FF9N4wrGUnKoPLciFu/FVn5ZmEEknA==
X-ME-Sender: <xms:mHiGaD-j6uIoUZ6E3DOc3R-rouGaUe9wt5UYPV4tKuCGS24SwXPgtA>
    <xme:mHiGaP4R78AsxcJ28ERwctmo5MHwLXU-7y-JZVFPUArpnF98TpUu4vU24vV5r8AgX
    _xi1lfVJVv5d2x5YU0>
X-ME-Received: <xmr:mHiGaC0m9_HVP_0KCtJGJZyzvFEMMgrg82xk5MMOOKJGcnUCkLiau3GEXTXL_xYBdpHE_dwD6STVF26464uJuY1FXfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeltddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhrihhsuceu
    uhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepkedvke
    ffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurh
    drihhopdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    peifqhhusehsuhhsvgdrtghomhdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:mHiGaOAsyjOE1YviED3mXO6gONI0glZ_fWzAw-ErygO6TiQFfc47sQ>
    <xmx:mHiGaM1Gfu0nefTcZ3P4C_n8IKjAQApeIjsbpEpcwEO8QVuREVG7uQ>
    <xmx:mHiGaAsG8Xgz_sqZ3ARB1_QrPupp2aRP77lhVr9baDVJx03KQ6mkkg>
    <xmx:mHiGaE5sA9gfs8Ch6DXTmg3fvT2wEB3iWY6M1rQM54nOLaQzdfDIMQ>
    <xmx:mHiGaNMC2sWA8l5eG0OpbGxSmujQQNy_2F5tQxGRiP6At8FW9OMneiAS>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 27 Jul 2025 15:06:00 -0400 (EDT)
Date: Sun, 27 Jul 2025 12:07:14 -0700
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs-progs: check: add detection for missing
 root orphan items
Message-ID: <20250727190613.GA2866105@zen.localdomain>
References: <cover.1753569082.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753569082.git.wqu@suse.com>

On Sun, Jul 27, 2025 at 08:02:59AM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Enhance the original mode to detect any refs mismatch
>   Thus even if the root item has 0 refs but we find some unexpected
>   backref, then it will also report it as an error.
> 
>   Thanks Boris for point this out.
> 
> There is an internal bug report that some half-dropped subvolume makes
> balance to fail.
> 
> It turns out that, the involved subvolume doesn't have an orphan item,
> this means the half-dropped subvolume is never going to be cleaned up.
> 
> Then at balance time, a reloc tree is created for that half-dropped
> subvolume, and since balance doesn't expect to get a half-dropped
> subvolume, it doesn't check the drop_process_key and increased ref on
> already dropped nodes.
> 
> The problem for progs is that, neither original mode nor lowmem detects
> this kind of problem.
> 
> Original mode has a bad logic which prevents us from calling the proper
> orphan item check.
> Lowmem mode doesn't even take orphan item into consideration.
> 
> This series will add the detection part for btrfs-check, for both
> original and lowmem mode, with a hand crafted image for test.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> 
> Qu Wenruo (3):
>   btrfs-progs: check/original: detect missing orphan items correctly
>   btrfs-progs: check/lowmem: detect missing orphan items correctly
>   btrfs-progs: fsck-tests: a new test case for missing root orphan item
> 
>  check/main.c                                  |  39 +++++++++++-------
>  check/mode-lowmem.c                           |  11 +++++
>  check/mode-original.h                         |   3 ++
>  .../default.img.xz                            | Bin 0 -> 13468 bytes
>  .../066-missing-root-orphan-item/test.sh      |  14 +++++++
>  5 files changed, 51 insertions(+), 16 deletions(-)
>  create mode 100644 tests/fsck-tests/066-missing-root-orphan-item/default.img.xz
>  create mode 100755 tests/fsck-tests/066-missing-root-orphan-item/test.sh
> 
> --
> 2.50.1
> 

