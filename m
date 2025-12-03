Return-Path: <linux-btrfs+bounces-19492-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28382CA1A22
	for <lists+linux-btrfs@lfdr.de>; Wed, 03 Dec 2025 22:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9841301AF6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Dec 2025 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAC52D3A9B;
	Wed,  3 Dec 2025 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="G7RHsNRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfuznevi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC98E398F97
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Dec 2025 21:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764796256; cv=none; b=EnJdpcDrP+H5Xh/WTJkmZPpE862K+vwPiwm+PqMA3mXzWHJ3Q8fiv3ENIv7K6H4P1dUhUOC5ynpXVFjucx2teCFLg0E24amtouMLsnAAzeuqzAVu+RHXIivrcWo6H9vVGa4GLQ7I3pJw0uNL5AIfk9MTETI0vusCq35XytN7T74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764796256; c=relaxed/simple;
	bh=8naV0+1pJ1HxGBkreP8RcglgooXKAxLtcY+hNELl2kM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mBX7l5cmy9lKG04FCWrSn/b921IbSukbGIfVuAcVWAwBurkwu7BEgFsKAAiY+REvgcO1u3RB32rTslhwrvGwgfe9JX3Oe9fryvEXm6MloZY6/O6F5onFnCA7yntTpGKt3002nvFBIsG3U0ymtqopUfjpaj0ZVKjh/QvRYRbWC48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=G7RHsNRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfuznevi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EDDC51D0022D;
	Wed,  3 Dec 2025 16:10:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Dec 2025 16:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1764796252; x=1764882652; bh=1+GMW6fG2/Tagj1d6GeFS
	9p2+W0N7QPbV5Sy+jz2vaU=; b=G7RHsNRvUV8pBz+1nA0uUMvq9LS9vIcWf6MDD
	2LBueqH5IhJUceRN8aL6OGBZLsIlmltTvDGxIQC//VjPPxdZfmvI2rs+olfJMXGr
	lG1xU/deljh/sg6WOfh+4BYpesrXbwerjI4f0y7T4PdF48a/3xeGn+T0Tx1RkSnq
	mMUhkPWAt4iFOtiva3rUb1HYwXXqRuM6At33Ue4xRv9g0X5xDtEDKu04BRIlIc3C
	F6bQgDe8ngAYOLLwboA44bfKgJEFsK5tHfnDA2pWeywKpatx8GMh0fGQsQIVoLNP
	o0d7qlnMsYGR6+TvwAq8WfQACXVdYl0JgNmof/omWyO5Ewz2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764796252; x=1764882652; bh=1+GMW6fG2/Tagj1d6GeFS9p2+W0N7QPbV5S
	y+jz2vaU=; b=vfuzneviEMrqPFkHVcgdP+Sih8nS04gh0J2S7GfUi/3FHYy3Fsg
	bEd3k8OhCueYePX8e+F8DcGPVHaaTtqimqbdHdQbkMd012fRL3RVGY0nnZ+tZKis
	f11GrfQZNa9LyI1/v/FMwlEg94X9XWYgvER2/GS4F3E+SYHBqeWd1r0chj6+C/9L
	1sgYZxz7fhmbrcq79LA+qnuNkdrLswomtISAnfmkViAO/if9HRC9mAPEddyYuihs
	U2/azUXcGrXrxaF0KMyjU463swpSWaQz123jX7bhEUgacWsd9TeKM+3Bw73LqCla
	1t4Kfrj6Hh5agavViQhA6MVv2TRsEFMqu5g==
X-ME-Sender: <xms:XKcwaZwZajMRhCln99W2JqqX81z0q2-u_2YCWw8I9fBuOrpSL8CccA>
    <xme:XKcwafSukvPlILn8KC4v92iGLbDxYKXjSoI7k5ezUwhYPgldmNgXQti5xSdeROe-c
    mw2Bi21cShbb-_Lf0GUhq85iJQyT1XPDOlDRtZB4sL3OGtySW5wOlM>
X-ME-Received: <xmr:XKcwaQ-s3JNy2Tep9MYWdDPPsvYBDzQ4MmvIRBqYHEe6AeUJFn3x48mCD-Ru9-ZaiNp_0kawMxB0ru8Jd8Q47g6HwXE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenuc
    fhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucgg
    tffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduudetfeekff
    eftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:XKcwaWoFOf-HoGOt9QdEQQEYDRduQ-AYTyanqyVAULSXQDuqndJ65A>
    <xmx:XKcwadkHo7nMDoOdU9lWlSVgIIrHAGuUyIrY6m3Lh_WRUzr9PGMcag>
    <xmx:XKcwadI4G4uU2vGPrry_NMkUPMSugZOD0w9PMEDOGpo0mBqwUEfTzw>
    <xmx:XKcwaSyQ0Ah_SlmIaCw61JZ_Uwyfr3vLG_iR_KLBlTyJpiuJEBNoxw>
    <xmx:XKcwaaUwv-ZCbE7mJa8TSJhNAXZ_eOz5J42mYOhX1IHzAFbZD9FQC9nk>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 16:10:52 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH 0/3] btrfs: squota inheritance improvements
Date: Wed,  3 Dec 2025 13:11:08 -0800
Message-ID: <cover.1764796022.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One bug fix for an off-by-one metadata accounting error and two generic
improvements. Details in the patches.

Boris Burkov (3):
  btrfs: fix qgroup_snapshot_quick_inherit() squota bug
  btrfs: check squota parent usage on membership change
  btrfs: relax squota parent qgroup deletion rule

 fs/btrfs/qgroup.c | 93 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 15 deletions(-)

-- 
2.52.0


