Return-Path: <linux-btrfs+bounces-8444-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8614B98E2C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E201DB24C0E
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 18:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F0C2141B6;
	Wed,  2 Oct 2024 18:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="FMQNouP4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cwUCVjMH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC781D07B0
	for <linux-btrfs@vger.kernel.org>; Wed,  2 Oct 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727894719; cv=none; b=H96CtIkZ1qbvlNadkfngI45QVhsC8AMozX7Jy522b0iMdQMy11AGtvCsYpAfM4zJpTPc9M06m1Djru1AsXJ36so/mJRpZAq9iSB4AbGII+UpVu2Cu+Ui4W8PhJzWICwKP8kgdm0pzsU9qJw+OHGCnUk0vHD4doP/ER6qdhWUBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727894719; c=relaxed/simple;
	bh=SiiiFKpo1OivJEdL4FKnYIemWy1fUOo5TWCgNJGnMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgaXNp7grKXSc1py8LTZBnKaJmozLhdclEnsBUrxdPg5O0vRyZtRdMk61Y00aOsF0Xt28z2w/uMhlAduSWigJYE4SaWsI+eJlymTvHvyacIxodWka43V+4nmSdUORU0ux6C8UU4wY2rWEzPgizH6HkqWgjP9hNlYwF76ZO6mEQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=FMQNouP4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cwUCVjMH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A14FC114015E;
	Wed,  2 Oct 2024 14:45:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 02 Oct 2024 14:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1727894716; x=1727981116; bh=RGIaDU9nem
	N/MPWU/e14FvnwI9gepIem2N3oSc0pzmg=; b=FMQNouP4WUoYwRLKa/u50j0x9q
	GrgTBX7ap+C5i8SUWJcdhbGJPbgdbU+k5kJyPN0UZuWx2hTAs0vNzylBrQZ8ORoK
	JUXj1hM2PxqAkUFiG/E7NvWJ4cm2gVbYas4hNIL4w5ixcts3mNj+Lpj5s+8+D3Rt
	QbizEo6eZullXEJzPjHSegh88lWIU1r5n8NQRgm7Lb8X4OCCcdPONQwuA/TQ16O+
	5Vr9hU9nhcRlha3pzYDVEUl4CtN4kXd9r6VwdDs8G9KUNHFRBydv0St/Z8Gnt8aC
	IVw9hhQJhZmWcxuNa9F7wlOwUmU/dgy4WNrmftH8uG6O/PppZvD+wfqKeGtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727894716; x=1727981116; bh=RGIaDU9nemN/MPWU/e14FvnwI9ge
	pIem2N3oSc0pzmg=; b=cwUCVjMHIxxWLjRvNWgsRfuBoS1EQ32mPBdTPZkxJK6B
	hiMmzH5K4iw0Qvf4WUZz2YCwTzTba5X2dvzECyyq1GTzJzuz9SHR2sh+DF54192H
	aWCFe6ztLCarMO2O5yMXRfHA/KrUzfMu/GBabZXlGOhgN2zJPffhux097mgnqAtk
	TBtC6PcPyaLdO2OV7cqP+vciO5NEAqnfqHwvVsV7iUX5nO8w5HLQTyzHDOfEWW8G
	tI18hBVycRYVICoclVUFAap8X5bpvmLe3gD+xXMOrh84BBeH71PMi8fCuT99WaiV
	Ba7bMmiAfQnCWKu1ueyZpNvEMyY4fYVfc6LhjDzw0Q==
X-ME-Sender: <xms:vJT9Zk64_JUJaRZ6oGBXY3Wgtn76CImoR_XBTXFdsVjO1KGDclxNxg>
    <xme:vJT9Zl6pDr7uQPCwWhDJM7qCta4jZmqW2TpHNwNvTzNgRPv9l9jjgXOyt8AB58gQy
    uV3eBSBUjp6E7_fkL0>
X-ME-Received: <xmr:vJT9ZjfpcLbYpQ1p4Ya_wVAiCRHibebGR8Cz3HmgZUkOEg0BGusTkDiJfs-nTJ9d-UHTMamX9IWjLLrDMtRghmiAmHo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhishcuuehurhhkohhv
    uceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeekvdekffejleelhf
    evhedvjeduhfejtdfhvdevieeiiedugfeugfdtjefgfeeljeenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhovghm
    rhgrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghtrhhfsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghm
    sehfsgdrtghomh
X-ME-Proxy: <xmx:vJT9ZpIiMhXH2NKpza4VN-RukmVviRuk2pOpL2hnXr2Eo1DICglhGw>
    <xmx:vJT9ZoKoQ8hlyCh5bnnLfC_G58dgcmvOwQT7n0h-xikyGlhxVcW08A>
    <xmx:vJT9Zqwn8qLabMU_Me3VCT-4_jfEgYvD9CuJ95G3sXGYbcWaTuI8zA>
    <xmx:vJT9ZsL97B33l99tofssumRNIXiBdXCYUvjdhEbL6kckF30VmzF92g>
    <xmx:vJT9Zs1WX93hLM99ElSE75tn0Twry8Yntve0YWJkLLfJ0FdSRvdh6yDw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 14:45:16 -0400 (EDT)
Date: Wed, 2 Oct 2024 11:45:14 -0700
From: Boris Burkov <boris@bur.io>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/2] btrfs-progs: mkfs free-space-info bug
Message-ID: <20241002184514.GC3917419@zen.localdomain>
References: <cover.1727732460.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727732460.git.loemra.dev@gmail.com>

On Mon, Sep 30, 2024 at 03:23:10PM -0700, Leo Martins wrote:
> Currently mkfs creates a few block-groups to bootstrap the filesystem.
> Along with these block-groups some free-space-infos are created. When
> the block-group cleanup happens the block-groups are deleted and the
> free-space-infos are not. This patch set introduces a fix that deletes
> the free-space-infos when the block-groups are deleted.
> 
> When implementing a test for my changes I found that there was already
> some code in free-space-tree.c that attempts to verify that all
> free-space-infos correspond to a block-group. This code only checks if
> there exists a block-group that has an objectid >= free-space-info's
> objectid. I added an additional check to make sure that the block-group
> actually matches the free-space-info's objectid and offset.
> 
> Making this change to fsck will cause all filesystems that were created
> using mkfs.btrfs to warn that there is some free-space-info that doesn't
> correspond to a block-group. This seems like a bad idea, I considered
> adding to the message to signify that this is not a big issue and maybe
> point them to this patchset to get the fix. Open to ideas on how to
> handle this.

A few thoughts:
- You should also add a diagnostic to the in-kernel tree checker (but not
  one that flips us read-only)
- You can add support in check --repair for removing the free space info
- I don't think it hurts to use some softer language in the warning, but
  fundamentally people are going to be hitting it and dealing with it
  eventually, so better to do include it than not. Otherwise, it's just
  a timebomb until we write some kernel logic that DOES choke on this
  problem.

  I don't think there is a precedent for a very soft warning in fsck
  output, but if there is, let's just follow that. I certainly wouldn't
  hate links to a wiki, for example :)

Boris

> 
> Leo Martins (2):
>   btrfs-progs: delete free space when deleting block group
>   btrfs-progs: check free space maps to block group
> 
>  common/clear-cache.c            |  3 ++-
>  kernel-shared/extent-tree.c     | 10 ++++++++++
>  kernel-shared/free-space-tree.c |  3 +++
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> -- 
> 2.43.5
> 

