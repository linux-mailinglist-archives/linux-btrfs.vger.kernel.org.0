Return-Path: <linux-btrfs+bounces-209-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688B57F1E89
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 22:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A8FB20E44
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 21:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AC5374EB;
	Mon, 20 Nov 2023 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="xsnvIWJn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0COq6kl1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36529ED;
	Mon, 20 Nov 2023 13:10:07 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A3BEB5C1149;
	Mon, 20 Nov 2023 16:10:06 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Nov 2023 16:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:sender:subject:subject:to:to; s=fm2; t=1700514606; x=
	1700601006; bh=Sa0f0GHQC8WQnzQAyAmRlF3G+ki4/JBjxAMau6w2BTA=; b=x
	snvIWJnEIHNfzQQPUr3HvhXYb4f57Boa87CyGRojNaKLV0VmG9cy6/bS13USg/dd
	xWeocHOKVkexVBuoaUTtEY8M8bqB9qzCHcgrp8gc9g+MsUHFi9GcWyTQN3oGN+Va
	FNp988PqdcACFLW9kvthE17X9TS09TCy8U5X26uuMXv2Q1lsRTtxxQvFTPhHvLcb
	dHXTtRHYv5mL8XWfWsG7cCWwAmRyjP3nCXNnuyWnwrdkR4fCkNP//ICf6oRmSW8G
	b5qMVPwK0A368mSva9B06DdDACZRQDZ3c1BHffgqXj2hyUNM2Qs3KnMGDgkyu0ut
	yQ9XhzcZ8Cy22YD6WKpCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1700514606; x=1700601006; bh=S
	a0f0GHQC8WQnzQAyAmRlF3G+ki4/JBjxAMau6w2BTA=; b=0COq6kl1rnjlRVKWx
	XV6KZNM1PJgegZprLsw5JCsC6b3EsZ5zn5n0Pm88h/7CG3vOj/Q/5B8Sw9nhRBdx
	s/KAEkFx3wYglZZYlT3ymo5GiLRzE79MI4q2Sm9ZIllNzsHqBKQDpWf/SSsy6ipm
	aHSl6ao1g2O8Y95fpwnPP8okUvWePRZu7cIpp+T4VwtZVxVgEmxRcXw5YhrInf4y
	KoKOY4G1GmoRLst+VrpxLBL6OWlZx15qxD1QET6ocCs1bU6wr2k5RTMUlLRW0lnv
	OkzTUWEa5KDgwNXYdZesP/R/z9L08moIU+0Tl8m+8zbKLvguInhko1WClVb15/sN
	S6BZA==
X-ME-Sender: <xms:LstbZXbY-zsvbQGMMlfHS3yVGmDHoWytrIMqlyIlSvI54EKg8RTs4A>
    <xme:LstbZWZKc_f3tAF2iL4uYlGgBQC850ASj28xrAGDoZyhhmnFYg1Z5-FtbvzA_08TR
    yIGszrK0Krig4SOYKQ>
X-ME-Received: <xmr:LstbZZ-pVvItKUUPhCR5njCt1r9hOOAfx9-b7WU6PFB743P8lldDRMiTeGQZOo7CtnuxGgN7kNM0yoBqOn8CAbzu6aI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudegjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:LstbZdp-wpAcHcxl0zKqM-bFMhthcz6KOs-aEmhpGEV20Ld_73DKcA>
    <xmx:LstbZSqjA5q-8lMerTQXNAMDiiLtAtwuJRAvL7IbGdfkjj3QsLZ2sQ>
    <xmx:LstbZTTRwi98HGbX5XgqNtlsxATHeKYw4UWrQ6pcpyVQtPS5ijzpIA>
    <xmx:LstbZXDLtEx6H4fceuLFBcE73orV2cHH0hQNIZGKvWZtHJGMAL4eoA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Nov 2023 16:10:06 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs/301: require_no_compress
Date: Mon, 20 Nov 2023 13:10:55 -0800
Message-ID: <f93722f124c528622e6f0717949a4df45738827b.1700514431.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1700514431.git.boris@bur.io>
References: <cover.1700514431.git.boris@bur.io>
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
index dbc6d9aef..82363f717 100755
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


