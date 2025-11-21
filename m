Return-Path: <linux-btrfs+bounces-19233-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EDEC76D50
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 02:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A8B124E4777
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 01:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B851E5B60;
	Fri, 21 Nov 2025 01:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="boB5wCGp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OmJJrBnK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525501FDA
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763686986; cv=none; b=p123crkmrg865wlBuajCY6YZyusuLG40IiJeGaNeR0y0fxup0w+by9Cv+4JEWNQVXE79CS6Rxtzdd2ct12Eqw1jAvKrpMQ9ejsPqfELWAFts2C7vD1gu1pDkX5hMKQlW8iXk4+pECUBD7qRagPoaOnXB+o1JDAucuATbFYS6Gsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763686986; c=relaxed/simple;
	bh=lLmPGBCyNIJSHi5vtxXaMEgY7EJYDYDchnEe/wV9R/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj/IvxTEVUdkpuSEib9/5cGd3jBoo2GQP/u3DNh4YoCKZobjaG/w9664Zja//O+C4Njoi6FdWhnf2kyM566vGEN2eouzsmj6TqE92Wd5nwWUt4RP8yjSmfosC55rsGkJ8Fv4YPt020G9xI7CAQnGRy4hC2z47Vnd3A2HvFZh9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=boB5wCGp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OmJJrBnK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46A6414000D0;
	Thu, 20 Nov 2025 20:03:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Nov 2025 20:03:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763686983; x=1763773383; bh=bAMQ56lAH6
	z3cAYVfYYxf5g6uOIxcUkxX0537K4Atn8=; b=boB5wCGpxF92LNvHy2znWKa5yy
	OLIYraigLsmeigvPxb94XwdfghkG+Ae6rKAWczTJpTCgviEnveDMfUpefXBqOQp5
	BiOmRckGg8Y+FQGcMjD9zuuF/GINjiu/1ASz31siusiTnWTj8vLb2Noid5c7GlSV
	jrbF5bFRBwprSFOXcFoVnV3n1vaTQQI5mNm896jaRqiJ1aaQD1gdb6neMPOpQO4R
	S2Q5IwDgMYeF1CYMLUklsQEuOBuSRwS1EMHnRJcgrxr6Rw/4JqGORPQptj/YkPHz
	rcrIeWuKQy6s2jVRlVqpyDzaPLFCHSqLJ6JSzQqtNno98KqmsPtDQTHx23eA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763686983; x=1763773383; bh=bAMQ56lAH6z3cAYVfYYxf5g6uOIxcUkxX05
	37K4Atn8=; b=OmJJrBnKg32YcMjeOFrcqbiP/TusrPGa0AxYTrncym8o3b2W+7v
	iHIZYKlhBWgMch0sDpWch8HA786UKBLMdXVDonLWKneECFkObvF8tZrEEFqTwlL9
	/cC9SXPON043nZLe78/X3SQvQIDpUzqj5xjzpUeuCQ2ZXAIGX6MsZ1VabTXo+EKe
	dH9PXFTH4jw96XRbrjb3Ctl2mrWeruVBhnZRyZysrE5VvSK4iGLG990zVVIxxXOd
	3mKHNDM4xtrK6s+ELeBLwNwdIMZ+4KRng/igkTrDTfkL4QLGbAKli8CBOPOhrW7V
	5/BZJgqTzAonlOFoVPwDVLaJTf9VQA2jlsQ==
X-ME-Sender: <xms:RrofaaZBSWHsRGfZoqWiMt_prL5UzI7bu9FBBGGSxMzOo1OadxCh7Q>
    <xme:RrofaTa3x44mzI3hPOA9pdwRZqqp6sA3rlVXRBpXJn_xWiBeIYzBn_p8-WjEOdFqk
    zePgwRTYxoDUO1XVEltQKZr_j2INEHsfKD1P8bkm8O4rNII_bDTFPU>
X-ME-Received: <xmr:RrofaSl8tCdHT42S1E_yJLUr40wezuNz470VL5CYEXsHW4mTYdBZhVUww6hBCTat57Z8qQoYorkgN2XKlnVdyGm3cJI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvd
    ekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuh
    hrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RrofaXz8CztAjffczuaE1wkBfMjmnkVdUClVSmjD1DWtHv6CZ6UJCA>
    <xmx:RrofaYNmCB3AtAgXvRlOtuo7cFV_rqGwvCSkjKimeTtZngQqMotykA>
    <xmx:RrofaTRDCaFCyvRqBlyo2HX-8ZVSELlflRctPnaTWtUT3FaLSjCPWg>
    <xmx:RrofaeYH18p37LvaY9Qu5ChDr7jJKlhOnGIG2wGPEsYNh0rdODgBrg>
    <xmx:R7ofaflGq1nvt14YODVCD200y0F_-BsZFr0kBASXcI4wrIAf1j_Bu_Ft>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 20:03:02 -0500 (EST)
Date: Thu, 20 Nov 2025 17:02:15 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/4] btrfs: reduce btrfs_get_extent() calls for
 buffered write path
Message-ID: <20251121010043.GC2899191@zen.localdomain>
References: <cover.1763629982.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763629982.git.wqu@suse.com>

On Thu, Nov 20, 2025 at 07:46:45PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v3:
> - Use @cur_len for btrfs_get_extent() in the last patch
>   And remove the hole related comment.
>   This should not cause any behavior change.
> 
>   The @len parameter for btrfs_get_extent() is only going to cause a
>   difference when the range is completely a hole (e.g. beyond EOF).
> 
>   For our writeback routine, there should be an extent map for us thus
>   it's no different passing @cur_len or sectorsize.
> 
>   I think this @len parameter of btrfs_get_extent() is causing
>   unnecessary complexity, and want to remove it completely. But that
>   will be a new series.
> 
> v2:
> - Fix a potential bug where OEs beyond EOF are not truncated properly
>   This replace the original patch to extract the code into a helper.
> 
> - Replace more for_each_set_bit() with for_each_set_bitrange()
> 
> - Fix several copy-n-pasted incorrect range inside submit_range()
> 
> 
> Although btrfs has bs < ps support for a long time, and the larger data
> folios support is also going to be graduate from experimental features
> soon, the write path is still iterating each fs block and call
> btrfs_get_extent() on each fs block.
> 
> What makes the situation worse is that, for the write path we do not
> have any cached extent map, meaning even with large folios and we got a
> continuous range that can be submitted in one go, we still call
> btrfs_get_extent() many times and get the same range extent map again
> and again.
> 
> This series will reduce the duplicated btrfs_get_extent() calls by only
> call it once for each range, other than for each fs block.
> 
> The first one is a potential bug inspired by Boris' review.
> Patch 2~3 are minor cleanups.
> Patch 4 is the core of the optimization.
> 
> Although I don't expect there will be much difference in the real world though.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> 
> Qu Wenruo (4):
>   btrfs: make sure all ordered extents beyond EOF is properly truncated
>   btrfs: integrate the error handling of submit_one_sector()
>   btrfs: replace for_each_set_bit() with for_each_set_bitmap()
>   btrfs: reduce extent map lookup during writes
> 
>  fs/btrfs/extent_io.c    | 230 ++++++++++++++++++++--------------------
>  fs/btrfs/ordered-data.c |  38 +++++++
>  fs/btrfs/ordered-data.h |   2 +
>  3 files changed, 156 insertions(+), 114 deletions(-)
> 
> -- 
> 2.52.0
> 

