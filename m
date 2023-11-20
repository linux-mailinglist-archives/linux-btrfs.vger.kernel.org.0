Return-Path: <linux-btrfs+bounces-201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ECB7F1CD9
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 19:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8621C2186C
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5563136AF0;
	Mon, 20 Nov 2023 18:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="r5mqjNhb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpiWA9sv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D0C4;
	Mon, 20 Nov 2023 10:44:19 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 2F3415C096F;
	Mon, 20 Nov 2023 13:44:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Nov 2023 13:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1700505859; x=
	1700592259; bh=LGn+7m57aJDLX71HpyMIOBN8GbucAhQvA3k9GM4Y7Pw=; b=r
	5mqjNhb4b6lXCTccuc/LNrd7wQSWO6mktzk2QRwWNbEKwx8PahVHPmMfUDWDkaqW
	2tp1Ho/EuMKoOhWSXuB4y5jpfY/KBS1rqvW7F5JtRGzmnUJhcDnx56DvzJFJcfg9
	dFJrPjdAm4wGNfl1wqfKKooJZk4zb9rGYdoAX96g2grTO5t16e+Bw8EmhIQ2wDyC
	0CXnsF3GFDuFPAKvjJXdam91vurnuYcVdzenQzgasm8cFopSM6uCRen2iFD+uQnR
	WR3FdMZs6lGEHkmEfhfjMOuhHVSPloqdhJVAa20bYYVH35SqMVQd+yE/djT+N3Q2
	lSWHwgmbgPpFHDA5rzNkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1700505859; x=1700592259; bh=L
	Gn+7m57aJDLX71HpyMIOBN8GbucAhQvA3k9GM4Y7Pw=; b=QpiWA9svVQY/K2Urp
	GSJ0pUgoFN7y5QiarLKbCdXi1lTX1rNB/6xrnynF4/LUuYKQnyuZmQVdV5j78qTt
	Y6JGMpKRvxxBoW41WKtsjNB6BZFlaKrx2oweOMh43m+MMnS+ijBvcIJD3Oc7PmjH
	o2LCRZJ7FJhEkgWjNa4Z5f2HnE4ppAWUNkitFkapG219FCQHYzo2SqKmcqP3nSQl
	enAnEp8Wz6VikuyRP9OSuWkewoj/fbrRbCaF8tbdygOT5if958gVAkApWkWQ5J9n
	snfhYFGjiqND6QM0rN4kv0FzK0IOOncupMnJiDw6KbSpxuXGn/Xp1hARDn0UkWiL
	cJ61Q==
X-ME-Sender: <xms:AqlbZSXw-M-FphWyQJnSkGk52S_M8UXskNg_LtaE0s4Rw11FcvE3UA>
    <xme:AqlbZemZ0fRcQQu8No4wVdv3n3_F-7ZJ9ftRHu3qdbHj7TqOHPcFi5jnycHLdOFMZ
    I0nhmmL5OaxGzgNYdw>
X-ME-Received: <xmr:AqlbZWY2snWUzWx5MtwSKCLpLRH-ROxIeOyVziLrt89tCu4M9WHGxLLouFvzsWXrmI2dudSbTCX9Omyck-S0jCWquGE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdr
    ihhoqeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffve
    dvhedtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:A6lbZZU5rBhbU7FXyB3McYFjgzJEeu9YWiCIqjyxgkMadBbKHjJYLw>
    <xmx:A6lbZckmsMTTCYWuNPbSOk0_BBLpv5vCVQxDHL_yHevCVsK5drPygw>
    <xmx:A6lbZee1C5KmzdvK3oEJscBx7-ssm2Hv1fDw96gJt_vkjQqXeWbeNQ>
    <xmx:A6lbZYsC1x7BVeyTGp241gJaD0gedmvsoalPbxHKtA4OHobv_lGXSg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 13:44:18 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH 2/2] btrfs/301: require_no_compress
Date: Mon, 20 Nov 2023 10:45:03 -0800
Message-ID: <87126391fec8bcba888f8fe0f8978f5363a2bb91.1700505679.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700505679.git.boris@bur.io>
References: <cover.1700505679.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs/301 makes detailed size calculations to test squota edge cases
which rely on assumptions that break down with compression enabled.

Fix it by disabling the test with compression. Compression + squotas
still gets quite solid test coverage via squotas support in fsck and
normal compression enabled fstests runs.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/301 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/btrfs/301 b/tests/btrfs/301
index 5bb6b16a6..165c6e417 100755
--- a/tests/btrfs/301
+++ b/tests/btrfs/301
@@ -22,6 +22,7 @@ _require_cp_reflink
 _require_btrfs_command inspect-internal dump-tree
 _require_xfs_io_command "falloc"
 _require_scratch_enable_simple_quota
+_require_no_compress
 
 subv=$SCRATCH_MNT/subv
 nested=$SCRATCH_MNT/subv/nested
-- 
2.42.0


