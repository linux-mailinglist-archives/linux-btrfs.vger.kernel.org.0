Return-Path: <linux-btrfs+bounces-9675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6299C9525
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 23:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DF1B24FAC
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 22:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE921B0F06;
	Thu, 14 Nov 2024 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="VugYE/86";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5LgS2+w"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97161AF0D2
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731623172; cv=none; b=cpU4UfNuDLYZu1NgkfEYoB8X8eouLfExi+BgrLIoK/H9yyFn4RYOiK5EiNBF+oIb5hm3YqpAN7iLmgFkahlxNnQtkVdU86Xc6rf0y3dRmgxbge6honPabfZuFKEcfSHWZyAtXH3EyZlxuoNkGcrTatkOJr/oPpfDFQEiDpSAQhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731623172; c=relaxed/simple;
	bh=Kn0QmbncG7QZv8EJhxJMEYTK4Yi7pT/LHRFEalTUa10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WU9GymD/ju18LwZp1sb3QHswCD+2lXwHYwZ7ejkFlzvl6TiTkBiSMUNXXhv+8MNnezVtTv2XfRawdHnbWF7riGlKd2LGuqp4bDIstV7rQGDARbLyjuU0CmcrOYc+MIRV+Wb+cEHrw7N/CZASII0ek5bod5wdXeAxWFPKl0UO0+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=VugYE/86; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5LgS2+w; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C5D641140175;
	Thu, 14 Nov 2024 17:26:07 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 14 Nov 2024 17:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1731623167; x=1731709567; bh=Q6ioknD2gi
	z/+F2wmiSsRSwo9CvgvOhdJPOTHiMSugM=; b=VugYE/86cotwkDqL/N17bCUa3n
	Y/Rpia6V4zWJu9JSCWz4ROz0pg2xt2kGR1q4pmubRR+ZWhHpPluFguqTDiTSGsj4
	6f/6ldl8x6uS7aG4YSApGwjlf5i/RPiIXUOsEh118nVTxNublEwgaGHU7L2bS2/h
	whQDdYFx68VvuuJ2vz/1iczXwQYeY8l3ZpNgARZ+ffi/3WBgs1N2H4gl/QgVjIc+
	lndEsuk881FbBcrc9fK050wZNU8t2FtRGWMZGDcuoz7IdXJL4Qa6SNBVWVDZfGhF
	oCRYp/Sm2XVCi7KbwSj1pXg+eir2UGo/DuioWO05LXGy2ByUeQisbO9Y1rCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731623167; x=1731709567; bh=Q6ioknD2giz/+F2wmiSsRSwo9CvgvOhdJPO
	THiMSugM=; b=H5LgS2+wwCq8BjNX6e9E4qJox816lk5Nhv9w9xJ6jIQsBbnznlR
	6C/glCj6NejCG0/GjT2g3jgiWiHLY/qeZXLODgHNJp6p71GneSB0Kl/V3aYHcFwY
	zrBdEXtRXXajtp7p5klqPcf2al2EEqDrPLM5l77Du0vRo7vo7Az97S3uKX3TnDkE
	qMC0QoxZW74QyFkikO0PyJdfIQOnDVAorattZybX87GUrdDGKikTAqhs0cBsrsWa
	oCGHRcJhZIYWbnYvzBAqknNHtthVH40rOSJSki5iFEeKkcsGlpHd9jBZVlMNVzpp
	I+cUm6mmveoiCo8MSyutZ1IwGWOOFyjfFKw==
X-ME-Sender: <xms:_3g2Z3St4wLSNi5zuUrNiy3T9Ky1Yfr6LtbXTGL1nF6lVwoxkcAuUA>
    <xme:_3g2Z4wurY8pmYDlv_z8pJdxp8qrlj8_nszP578XD4m4NRH5C_nlzVFUefAIEaoAf
    KH_qlf9hp3vE0i7ZUg>
X-ME-Received: <xmr:_3g2Z83x_gyBJvDZJOwigO9HflR7i08aN4n5iz7Eircc_fZ8nJY_GeyhD1vNJeRiYaBnQ-mK0PFLAYYD0jz7sSmnZ_k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddvgdduheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhoshgvfhesthhogihitghprghnuggrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:_3g2Z3COqon1c5sAFcBrSQklmWO3zALpRP1q-tK06hTraj7hb4p_Eg>
    <xmx:_3g2ZwgKG4XcZtDpFIl1-WA7QpB1Uq8MmaQjDP42VvM1O2szi_QSJQ>
    <xmx:_3g2Z7oRzaeRhHXD42WgWm9gGYVcJVs4qv1Sqw4crlyC3MNo0EUy-A>
    <xmx:_3g2Z7g5U8Yorc8x8tQ3qJw6P-omaF34An6Y2JviH0cPVHfIwp5Qiw>
    <xmx:_3g2Z5s0_Pr06YAErYAn23n3BvxCNXsrbgpY9bj_FZ6Q3RfRDlEPvvi8>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 17:26:07 -0500 (EST)
Date: Thu, 14 Nov 2024 14:24:55 -0800
From: Boris Burkov <boris@bur.io>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: add a delayed ref self test
Message-ID: <20241114222455.GB3037257@zen.localdomain>
References: <cover.1731614132.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1731614132.git.josef@toxicpanda.com>

On Thu, Nov 14, 2024 at 02:57:47PM -0500, Josef Bacik wrote:
> Hello,
> 
> I made a silly mistake when refactoring the delayed ref code to make it easier
> to understand, and that resulted in a whole lot of not fun trying to find what
> went wrong with boxes started falling over when we were deploying 6.11.  This
> style of bug is easy to catch with basic unit testing, so add a variety of unit
> tests for delayed refs to make sure I don't break things again.  One patch moves
> an important helper and exports it so that we can do the testing, the other
> patch is a giant patch of all the tests with a few changes that are necessary to
> make everything work.  I validated these work properly and catch a variety of
> bugs that I hand introduced to the delayed ref code.  Thanks,

These are great, thanks.

I brought up some high level but non-blocking thoughts/questions
on the test patch, but please feel free to add

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Josef Bacik (2):
>   btrfs: move select_delayed_ref and export it
>   btrfs: add delayed ref self tests
> 
>  fs/btrfs/Makefile                   |    2 +-
>  fs/btrfs/delayed-ref.c              |   41 +-
>  fs/btrfs/delayed-ref.h              |    2 +
>  fs/btrfs/extent-tree.c              |   26 +-
>  fs/btrfs/tests/btrfs-tests.c        |   18 +
>  fs/btrfs/tests/btrfs-tests.h        |    6 +
>  fs/btrfs/tests/delayed-refs-tests.c | 1012 +++++++++++++++++++++++++++
>  7 files changed, 1078 insertions(+), 29 deletions(-)
>  create mode 100644 fs/btrfs/tests/delayed-refs-tests.c
> 
> -- 
> 2.43.0
> 

