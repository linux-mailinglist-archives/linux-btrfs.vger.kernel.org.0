Return-Path: <linux-btrfs+bounces-481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4D18014E9
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 22:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5324D1F21031
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Dec 2023 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168F58ADC;
	Fri,  1 Dec 2023 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="I8zmJv/U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xhXAeSrQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEA9D54;
	Fri,  1 Dec 2023 13:08:18 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B7AE55C01D6;
	Fri,  1 Dec 2023 16:08:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 16:08:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1701464897; x=1701551297; bh=nh8JeosZ65
	b+tKpjl7Qmw/fSpCn0JuTPBXOhkR4kHaU=; b=I8zmJv/UdXXOjksjsLDhsxxI4n
	fbOdvP0KJ3Mqq8BnjkEmsgaYBJyryvzijP6TvYpwdJua9DxWk/z2QYzygHLPOXdc
	5VNhsVF4DNfv/CMszhNLLyLRuRo+/s39LBaW25KSy8uP+qyfFFpt4AOPBSEQ2fAX
	b0BQ5y4omEs84640OrxV9MEQNdNRXiZInprYYvMHhEg11gfo1I/3uQ5b/xQBPrA/
	rlNpOuc1T6JzhHw/Pf+gOnT4RV2dsVaaWhagNGAQtoE/IFq8okwji3b1YQ4ibb10
	/8CP6om+5O9975d43stGXOuBTtkicYe2s+O2PiuUOM2YVv7mYbBkDIk4T2Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1701464897; x=1701551297; bh=nh8JeosZ65b+tKpjl7Qmw/fSpCn0
	JuTPBXOhkR4kHaU=; b=xhXAeSrQJVozFeYnwwuKJJCqGHTwg9MEVu6jSyG6f5kH
	3deNIdIyOHO3IofSStbEs1f5vOO0tH0AZE3ldhfSoMMRMnMPrQ758/utre1arAgI
	7FcMCXTakaAeB2AYWTkQqgofHCi+D0P6OcxPd2j53G8ydhfpmr1Cz00DYl4TOMnf
	7e4OP/z5k4ASrkHdfjBNjEKOkxHgwv7lm2jMSdzwyAma/3u4z/byiH+V/7eMTxL/
	5+hh7igegoRjQg+v7WJm69ARlfEo6VOFVNGp1QUKQ5GUqCu5NAaZdQuZdVetI0Wl
	2FvMNYN+v9zwX1kdTwrbf8QNEyeqWqxfdgg7rFriOA==
X-ME-Sender: <xms:QUtqZSd_-T5m8PEtm9eOMYsjBUmNZXrxrG8aRZYvc0Cvdk78g7EaeQ>
    <xme:QUtqZcNJYkq0wBe7O9W0dJA82mQNlL5v3ienJnJ0l89su9BHzZFaMAy7-EwjkVrya
    dnYd9pM2cgM6yEqIdc>
X-ME-Received: <xmr:QUtqZTjyQgt2BjMa3YixM3KaFteqB2i4DxwHdPq4BlGmAMaLP8MNWrTmBfyb0SLQVwvBP_q-7FeUazbWgHScA8qOTQk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:QUtqZf_dohFA2w7vyxtCDIZ_bAaiDDP1TGviISIL46qAPrAkBzjE8w>
    <xmx:QUtqZetjI9tSoyypgT3fEc9SIsA9rmmBkL85O2GdDLW1wFNvBioh6w>
    <xmx:QUtqZWFJYYFdcysc_EVJmmtu9eBcO61Y7K4InBgRy0FsOiOY4sZpyg>
    <xmx:QUtqZTUKEgADOHWHTFMfn3j4ELgirKo7_o1cVm0Hw6R3H4oDjN2M4w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 16:08:17 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs/303: use quota rescan wrapper
Date: Fri,  1 Dec 2023 13:09:45 -0800
Message-ID: <18afc03e67772666190415c742f0793e8207c5e6.1701464909.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This new test called quota rescan directly rather than with the new
wrapper. As a result, it failed with -O squota in MKFS_OPTIONS. Using
the wrapper, it skips the rescan and passes again.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/303 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/303 b/tests/btrfs/303
index b9d6c61d1..410460af5 100755
--- a/tests/btrfs/303
+++ b/tests/btrfs/303
@@ -43,7 +43,7 @@ _scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
 _scratch_mount
 
 $BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
-$BTRFS_UTIL_PROG quota rescan -w "$SCRATCH_MNT" >> $seqres.full
+_qgroup_rescan $SCRATCH_MNT >> $seqres.full
 
 # Create a qgroup for the first subvolume, this would make the later
 # subvolume creation to find an existing qgroup, and abort transaction.
-- 
2.42.0


