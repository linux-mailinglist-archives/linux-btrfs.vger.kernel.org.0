Return-Path: <linux-btrfs+bounces-6138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0509240F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D97281B80
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AD31BA076;
	Tue,  2 Jul 2024 14:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="bqniBelb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EyOJwEZy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FEDBE7F
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930724; cv=none; b=o3cPp9/cPq7nAM9Xj/sljQL5wsvCfynETxaVnnP5HSjMWeLSmNhi+tSh9iUw3/0R5uGVuNRIoOMnh7Tsej/mFc0hIdJuPdsgLoGIvQIjswyahzCVTDy5IkiHOmS8s58SBDLqniix3q8jCvnnZP5OmYWygbAOatQ4FEodiC4Lgf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930724; c=relaxed/simple;
	bh=iFpuvWaUU7IvwJClKYpSE16+k51HWcWmCBLP6XWRY+I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Nfb3n6S02GvXBQx2DmKgHRQ2so1BL8xtJXtzRVcmwr9QkCR8q/iIDGoDtlPsIedmipqXdHdZ0DUK+n+u0Kn1dXIOQdS47QR05xaL2W8A25uZHk5ptRmJKhznCt8d6e2bs9cpbU6mvldkcqSa5eA5eFUlvxFD725ziEz+8NUfaEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=bqniBelb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EyOJwEZy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 95D8C1140209;
	Tue,  2 Jul 2024 10:32:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 02 Jul 2024 10:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1719930720; x=1720017120; bh=pj1YSrcAaSl/98XbvIXf0
	ma59vk139yQgMtRVxR7YnA=; b=bqniBelbvshMHU0ZZkAOV1JKjg17sN8D7RWuc
	4JF6nsDFEtadzh8oucO7x+yhyFcCij1TWVp9ifvWfmekFceWmlMlhZWD6Xw89E+R
	N8r46Ge6mtE+D58yomKRQCNaBg8cqTx3YKtHcBbgrw3jvdjTIxvtGY1Voq5XH59e
	384UNdljaRYCcMrZZ8YZ7rq+swVgSzMTJN5HQwoaxT6ixW45oebQRPHE9Lie37g8
	fRvIcaA9jNjd0R9/tal1RevEiuclp18AuqJDmWDVnXsSWp9MHNDxcc0YvpMnJRIr
	n/yxyasRZ6MgybKSJME747MXOlR3DYyi1FoiiEEuRI+MR+WAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719930720; x=1720017120; bh=pj1YSrcAaSl/98XbvIXf0ma59vk1
	39yQgMtRVxR7YnA=; b=EyOJwEZyuTq1bH6jG2xcDwWKa3qbuQ8MawixjVZpr5Yl
	z8FRB4W/Y2PPKRCYd8K34HskWNolKSo94qlxQNwZU5HdB/guuk9XaSYdAexeRwL9
	ugibvDHgTAf7S+xhASC5GV/mUs+PMzC5BhrKigwAOyW3bF0qOCEjNb4AiJFC6UKG
	P0kalOzf8Fn8+mF9D89Tn0AIYLdbI6krFP0Pk3yDRzqnU+KcWCh8zyVnTxHtUuaO
	GI3ojDSX9WgZKCU6nRjj0iTAE1leAOMgBMomvLVKO42n3KOu3O+TH9bsqY4ZO1er
	2EuFV2zqCz/YwjOnonIBKV+UblHo++H+322mPrPgkg==
X-ME-Sender: <xms:Xw-EZiKzE4w6neC_7zBIiLNvDvmofzxUbjHB8H75mPoJodJC0iIXYw>
    <xme:Xw-EZqLtoT7hEavddXEsc2mVyA1EkO06LvcMs82l3S8KUR2ZjoJR-VDh5aBSeFAcP
    YZRo6QQmsFDLpAQd9w>
X-ME-Received: <xmr:Xw-EZisSKqt0S_I_if66H0nlB6cY-janNraz0g8Bkj1qT2wV0WwTB2bF-vrwKHWVnJM_9zSQC44tACFpR6WSlHR2Igo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:Xw-EZnbKw_sixHT90wGbbNl3NeeaUdBaBjO4VIN0UJcj2Tfl-haLwg>
    <xmx:Xw-EZpb8Tk_H1_V0Ki6tHQAUmL27U-Y-vMhqr5VoPxNWOmnovtiX0A>
    <xmx:Xw-EZjDsviqkWlRIWc--_eSVZiDdDVs9fvghtzl58R9RiI8TgNYJpA>
    <xmx:Xw-EZvZBW4o-gkpHUGs3gU1vP81myDGi1OXXb_Mm_kV1SrksyJIk4w>
    <xmx:YA-EZonGiLBfsVum3JWh9fB0JrM1dKce6Y8jzmPWMOSES5CD3Mpi4ynH>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jul 2024 10:31:59 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 0/2] btrfs: fix __folio_put refcount errors
Date: Tue,  2 Jul 2024 07:31:12 -0700
Message-ID: <cover.1719930430.git.boris@bur.io>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching from __free_page to __folio_put introduced a bug because
__free_page called put_page_testzero while __folio_put does not. Fix the
two affected callers by changing to folio_put which does call
put_folio_testzero.
--
Changelog:
v3:
- split up patches for backporting
v2:
- add second callsite

Boris Burkov (2):
  btrfs: fix __folio_put refcount in btrfs_do_encoded_write
  btrfs: fix __folio_put refcount in __alloc_dummy_extent_buffer

 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/inode.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.45.2


