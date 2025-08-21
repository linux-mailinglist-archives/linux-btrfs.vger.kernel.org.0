Return-Path: <linux-btrfs+bounces-16258-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3758B308B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 23:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7828A1C25C31
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 21:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6F42EA16A;
	Thu, 21 Aug 2025 21:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="qtjvS0ew";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mM6mjmEo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DF0393DDD;
	Thu, 21 Aug 2025 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813523; cv=none; b=fm47XFzInXd1l6Yc1zVtdvZRf0BoGypBMHZkMhWC4k3pYYrrV+0kBJBzp1/GthHKBbmzLfMd1n9Lmz1nJWKHF8Xnf1ztmh1op0uPDltQBSESo0O9GnMG8y/eQgVqEHnyo11gtj2l7cYJylZsfr1ar2zUwBz+unreP/JOdbi2EDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813523; c=relaxed/simple;
	bh=AHzvwdH4OlsrC3WecwQaH5iFvjwL2CErVH3aT5EESn4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UC61iwQ4tZ+4ajwcnm2ijXSd/GGSwCqk1Zk3bQ0iibfCzSqs1Ouhnd3GrRezKWAluHK01QW3YcjmMo6xcYuxk+IXCQN6ZTLlfFRD/FvJT+xrlnkCZzY+fmWeYj1enqRo6e6Nj7TOH7YXo9tcBNE2999Awl1fjG2S0DrvBIsWEoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=qtjvS0ew; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mM6mjmEo; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 995FF7A0148;
	Thu, 21 Aug 2025 17:58:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 21 Aug 2025 17:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1755813520; x=1755899920; bh=q+Vz1QIp1l6NM+QVhGD2d
	RBWcax9kULVm8LiU3xcl8s=; b=qtjvS0ewTLk6bOFFiLgOXLiMl3PLGOhNC7JPg
	b1JWR/2CrlFzaRdNfEo8wVyn7HivlHk30tvNb0b+t2FfIhAYKGaMkK8DU1HGHG5w
	sAsIBs1TbJPwSP2mbXrlPcaqG2ECxqB+UZeaj2it/9CUKrv6UbJlhNi7pX2zpghh
	UJcRBxW9INB8XaRvDcT8Oy4Lk/QFABvH+AJQAbOSBgB8ux/yWwqanI9MOPRPAHE/
	cY9/pHsoGa093ranbfO34dhpMhzbyU/YPrEnGhL5Dzdukd1HASZAPVQ88Ygkpgwm
	gdHs1Yy20sl27/b7e1yv9PecT8xWGwqtLx+9ZWTLixBX/rLlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755813520; x=1755899920; bh=q+Vz1QIp1l6NM+QVhGD2dRBWcax9kULVm8L
	iU3xcl8s=; b=mM6mjmEo6Q761A0602JzVn3cImXxPYBaB6/GKgeP2zCLjTwc0ru
	6Vgdj3jlo5KU3HcFRCzSGZ3oBN8mvoKAoeg9SfkyGE0DaQNgVc24AVdg99lqpXaF
	zRvI+pEtc08fALQ3YECoxq8HKWp4/9JXOEeu10ZLaNvz548LZQM4ti0SIBMvw0AS
	FHI1SVlBQExZMH65Uf6UZemHMmfGt8jdp0OliJrGRgx1VwjnT3dcioDlA+UJsZNZ
	1t1+IC6sCjH62l648wi18O51GoGGFk+ElZkH8bw1KLqVXMKgEq2As1Mlo28bA0S5
	MCa/OO/eIqSrKNn1kjzCHE2iXxcfDHerh+A==
X-ME-Sender: <xms:kJanaAyVcgra0NKXVOgGJovrkXUv0XK3gcR5dCVVx-fhuqwaAxMkSw>
    <xme:kJanaLK5I54yTOY5-zkhkeK07R2oExrUgyWBqzLlkgmfEll9zKkdWKiLwmojDYQgO
    qkxemAhYl1_v6W0IN4>
X-ME-Received: <xmr:kJanaPR9tQR3A-6XtWRfSyFojZLELIxhoEdwYf7ZgzPInbvwoFLPOZOvHC0RsPsyfWgrMni97tHENaK-OQzNEnT1N1k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedvvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtredttd
    enucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeen
    ucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduudetfe
    ekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhm
X-ME-Proxy: <xmx:kJanaLriMjMQRLGZAPJoiK3KZ-d65BeTMak-aKyRWyweYDGdDsFI4A>
    <xmx:kJanaMplBDczhP3vcaGzErYP6usEpsrP4bHAzNAQv_6SMBagXb8OqA>
    <xmx:kJanaNPgdNAI1giCEOsa-sBAhGyckcfkHsE3paEBuv-zEN24z59wwA>
    <xmx:kJanaNxZZdmlqT0JLlB7ixT8WLOiV25cbYSYonOAzNQZUf2xqdCiUw>
    <xmx:kJanaL06qmsfHjdawJ2JPj5-lDUR0fWRamYcKSFzFJEb3bZ18Dvb3QQQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 17:58:39 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs/301: test nested squota teardown
Date: Thu, 21 Aug 2025 14:59:10 -0700
Message-ID: <4095ca2ed24f4159650d282ef1aeefa46c028215.1755813480.git.boris@bur.io>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
 tests/btrfs/301 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 7f676001..4c0ba119 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -21,6 +21,8 @@ _require_no_compress
 
 _fixed_by_kernel_commit XXXXXXXXXXXX \
 	"btrfs: fix iteration bug in __qgroup_excl_accounting()"
+_fixed_by_kernel_commit XXXXXXXXXXXX \
+	"btrfs: fix squota _cmpr stats leak"
 
 subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
@@ -393,6 +395,13 @@ nested_accounting()
 	check_qgroup_usage 2/100 $(($subv_usage + $nested_usage))
 	do_enospc_falloc $nested/large_falloc 2G
 	do_enospc_write $nested/large 2G
+	# ensure we can tear everything down in the nested scenario
+	$BTRFS_UTIL_PROG qgroup limit none 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG subvolume delete $nested >> $seqres.full
+	$BTRFS_UTIL_PROG subvolume delete $subv >> $seqres.full
+	trigger_cleaner
+	$BTRFS_UTIL_PROG qgroup destroy 1/100 $SCRATCH_MNT
+	$BTRFS_UTIL_PROG qgroup destroy 2/100 $SCRATCH_MNT
 	_scratch_unmount
 }
 
-- 
2.49.0


