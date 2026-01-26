Return-Path: <linux-btrfs+bounces-21065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBxBGySid2mWjgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21065-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C05398B643
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7576F3002B56
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67734B42B;
	Mon, 26 Jan 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="OT7ztZEu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dz39FmhJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189234B43D
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447963; cv=none; b=LUens2Z4paXA46zLDoT594H/v7pT0NF7C7jTYhcUEoZsY6FM+F1Z/PPjNWspAccJRHknlXHBWFHniAqw2CiGBZM+PvoLiFUexRnya9X4/0gl17bJY+9Kd6stcVLmesNxBDADlK1rJMtzwN577RhO1aDKTyCGjhje8G2IS4H8iE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447963; c=relaxed/simple;
	bh=0ayckA+oKZIVCRMUMo2+yiwY4+IPw7rI9aP2N+BHLtA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VdPitVUqGmEWiED8SoGVFnQXG7qrv8NpeOcREQaJfghv++2ngBAFL3wSvxfoP/m9WPXY7JBjbx6M1R/U/DRDzSEZqQ0Ye7h2jq7yjFMf3YcaTLFOJqgNb9N3FTUGGEDqWyUBgFNHtonypezB3bhskQHWswXvzqHYgbxYlv5mXSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=OT7ztZEu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dz39FmhJ; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A4001400074;
	Mon, 26 Jan 2026 12:19:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Jan 2026 12:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1769447960; x=1769534360; bh=MWMVTdOa4h
	HDu9P0mIbV/4E130UgCa6ViB/9wGsNotQ=; b=OT7ztZEuRnV8mxTrzSdMD1Wcyb
	04Jyv/r9d+b0xRGDU22jWV2Qs2i/U7PXXiXfZYAU/Lpvcc9p9Bffsj+xP1l1b5z4
	cMTCbDoEJ5qPNdwyuibvH6w5t8117OWaNF7Bu+3CjDA2NVxq2oaRL1f5pvg1SO3p
	z9G9MAmR9zGK0UeTwgzSvlmlAb4mvFTqXVkXZ7OcyI7zj/rPx1MtHkZfCT3b8Upa
	iuYH8To1eaVNkto2V+W597oikgiwUL/FD0g4VjEcsB44s2CwS6TUmEAFPDCwOfov
	1o/RwziyS3EMdqs3HqewNZ6BVP5l4kjpdEosJwc1s6KsLSTCsf7Np4EzJNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769447960; x=1769534360; bh=MWMVTdOa4hHDu9P0mIbV/4E130UgCa6ViB/
	9wGsNotQ=; b=Dz39FmhJDNg0Y7DP2tLwkBitNBvlngv+dCF/UwkxIwtojVV5CDh
	lAXPJ/UDLXovb9CRS9GsURsDp2tvmwQWzUSqwMwN0Tb2Q3PWt5TcZiXOJEwWVnNi
	mkBFOqwuw1A/cWparYbWD2+E2sLJicqPiFc4Q9syX5iH+sEL4Ni4BU3zRK+kpvN7
	iEDNvq+m8qfOW3efBawZscGiUHOGlDDpPYTNBMsUqkTdksSmbqlFRBth7iIwQrsM
	6ab37BHm26QVqQfpVc3JGxAlJS/66hM67hGS30zyQxfAWg7Pvhy+vJy/+LtHoF44
	lRR53aG1WLNXeIsbKDrzk6XFHum8jdP7VfQ==
X-ME-Sender: <xms:GKJ3aYBWTmXtji7wDV0VozO8y5Gy1HNgFGXUzb8ThIA8ndRDPo4oag>
    <xme:GKJ3aQh0pRolnSmN2SwWmGC4kDsbCdI-P2Fpwd00V8iOVLXhxiWY9YRPcB2DrVRe3
    XYzkVsGdnpcirtpNeGB73y8NRk0EL0ZnmmHde0fUVjkvWUYbFrYqClZ>
X-ME-Received: <xmr:GKJ3aZONWhpFaZYKc63GPHaIo5kmkCfq49eSnDXODVeqseDLXf5bc5shQWoS5kjlGJdukaQUDRnKfRnuOa99-rl1q7o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofggtgfgsehtkeertdertd
    ejnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnheptdfgkeeufeehvdetvdekuddvudffvdegveeifedtvdekhf
    ehkeevleekleeuvefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:GKJ3aZ6iHrnS3m9Sq5FbZYMKZ1Bs2YZ3pJO37iMgrshGFBG7fXgySQ>
    <xmx:GKJ3af2uky_M3L0UIlytIUjDErFBwD50VEQjloR6CtotJgS1loJTFg>
    <xmx:GKJ3aSa77EVVZTYVRn7Jd67pay3czxdc1NlvKiFenwtiE-GV-7L0dw>
    <xmx:GKJ3afCFjMxfIyu7iTj_4q8IHoCNduum2pGtwGpFmRWCS46SRv-BnQ>
    <xmx:GKJ3ack5ZkZ3RC0bDR50T_TenEwjF8fEQ-qRnT5Kj3uVQrPat8lmm8cK>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:19:19 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/3] pending chunk allocation EEXIST fix
Date: Mon, 26 Jan 2026 09:18:50 -0800
Message-ID: <cover.1769447820.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[bur.io];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-21065-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C05398B643
X-Rspamd-Action: no action

Fix a somewhat convoluted bug in chunk allocation with non consecutive
pending extents. Also, add unit tests covering the new search functions
and fix a build warning

Changelog:
v3:
- fix build warning when CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
v2:
- change the semantics of btrfs_find_hole_in_pending_extents to return
  the largest hole on failure. A different bug in the implementation of
  the incorrect v1 semantics was hiding this.
- add the unit tests
- add the build warning fix

Boris Burkov (3):
  btrfs: fix EEXIST abort due to non-consecutive gaps in chunk
    allocation
  btrfs: unit tests for pending extent walking functions
  btrfs: forward declare btrfs_fs_info in volumes.h

 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/chunk-allocation-tests.c | 481 ++++++++++++++++++++++++
 fs/btrfs/volumes.c                      | 246 +++++++++---
 fs/btrfs/volumes.h                      |   6 +
 6 files changed, 678 insertions(+), 62 deletions(-)
 create mode 100644 fs/btrfs/tests/chunk-allocation-tests.c

-- 
2.52.0


