Return-Path: <linux-btrfs+bounces-20985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKnJMis9dWmbCgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-20985-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:44:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA797F15C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 22:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6B6F73002D2C
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Jan 2026 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164E27A927;
	Sat, 24 Jan 2026 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="GM27uw/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HfijgxYd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F0D280308
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Jan 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769291045; cv=none; b=AA20Wl1CJDWN5ggLHs4mkCuIIeppVR/Q0CzRq7gqEZQhnTi1WHythFvqElv3rZex5SJ90P9dZKNz1bmW7H/bIUhNlvrpvCRY1MQKGGtURPfXUoc3kz0jscTbNQWCc4st7Bg7oPcyqLlfVFGLuxYeudBBMarkyNE/3AQYAs/IO5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769291045; c=relaxed/simple;
	bh=i00D/Dm/aivOcS3UEfDuY/jFkerQDYlkW/6zcLkUyCs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjvYFUbW8K2RwLah6U3GxSE7jr7U6r8EMgAoSRtw4aL17EFor1DmkK1mVSrVMNVruDvdZjw+N6Ox7MGeQouyiUC/g93AvKGubsbPsuEl6rVbpd5U+68zyajAHN8WD5vkcuOX8d2eV+ut1QqBcaVmKkSux32hl3wB7wr5Pu1VU9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=GM27uw/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HfijgxYd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A3F2EC00A7;
	Sat, 24 Jan 2026 16:44:02 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sat, 24 Jan 2026 16:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769291042; x=
	1769377442; bh=cLdoF+gitBpnh90RLQtfGugifXuKxwCYs8QpxrKHfl4=; b=G
	M27uw/xX4XJ5YnkkXraunpwgtzDZGAHQWOvRNcRPWK7dGtmAxL0da/Tf0TeTVIIL
	MAFWK998P+jmloxcapqGHLT1drxHIGPsjpGm/3DTDGcrHE8hCQUtrmW8XFuaA8+7
	Vs8a9eeGZ7+vGshxvYTTiFKZc6DKiICcuFDJjtcas8Fqt9TI3779MyPN8fMBYs9T
	VnwcbS14BGq6hmr6VHEPyK6xBjuZoZDvst6beleEGZYJ27yCxEsu9BZ61TJ2G9Zz
	R/bMdo/6fQbdR1CC8L+yVGMA2/yItWpCrppTKGGQiT/5MH32acTnQQTMPk+qJOQk
	9/SLb3Df2mDUjxoMk7qNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1769291042; x=1769377442; bh=cLdoF+gitBpnh90RLQtfGugifXuK
	xwCYs8QpxrKHfl4=; b=HfijgxYdHx8IdlVCBNKZXOES1CTXPhPBmh3ub1SJ/vts
	R8K0RiW/lPRpcSpJwMv7/jfKc5s9jYFaNAp8jowdzw0ALxUi3PMcpSYVEya5fZSw
	B0TZxOTsxWm5GtVNuVnup9PLpSKA7B8EmWws4eRsdKLKrnKwd3HZdbHf76Gq+4v5
	0MMJD+Wni95pyu3vAIK2F+EFocP79w+7w1jvfbqAihmDvT4DP4cdoXj5p10LIl2T
	PV01bWUcL/fT5SqAIzCUqhJgnwKpGm1zySEpkOeUcebLD0LOuo8pdXlpeIhby0MU
	U1Iqdo1GOT0IE+NfDeqje+K7smKOOkvGbNIoY8jekQ==
X-ME-Sender: <xms:Ij11aVRmPnfePEwKZoI4TojXbC_W9e0xKBx1Lu6wV_R49pSLA0hdmQ>
    <xme:Ij11aUyphNuhP6Xh3CMwle295I8wNsUOtuHWYEYXJsYtdI3v6wZz7haVveYgdn7Ej
    ASZRH4yofckLxaJS93LU5MyxwN2Db1GK-TURwRwZTH99boMEuALYQ>
X-ME-Received: <xmr:Ij11aYdT79VcJcY7owiB-hu4iIKXnXD1NH9hlLKFdJayFeMM5fjEOThBlabGn8Cz1id_LX08g74dFcHzwJs_ayWPDy0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeftdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffvedvhe
    dtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:Ij11aYIjQFaCryYNvyEXxCNL3bOCx1DT-HTWZCuDev0uY_cBshlmBg>
    <xmx:Ij11aRFo1Lpep_oNBJtQ-id9UGC-LdiOWQyLRTTvcjsehouh_M-ZGQ>
    <xmx:Ij11aaqAM62BUWMuivCoJRh8e1kaGPeK3LY66yGwKGqFcHW5h6-g0A>
    <xmx:Ij11aSQ30-jhDKjcwihde0O0AWmNSOfU-SWpBJbtp-FxgqndJ-l5mA>
    <xmx:Ij11aTIDcoh1mkOSIswNEm0oiCVkNLrcvmYCwV0LWfnzJUEvYY8sXJFR>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jan 2026 16:44:01 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2 2/3] btrfs: unit tests for pending extent walking functions
Date: Sat, 24 Jan 2026 13:43:34 -0800
Message-ID: <efc4b5a3fbcbc7473afc228badd3e1306298bf33.1769290938.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769290938.git.boris@bur.io>
References: <cover.1769290938.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-20985-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bur.io:email,bur.io:dkim,bur.io:mid]
X-Rspamd-Queue-Id: 1FA797F15C
X-Rspamd-Action: no action

I ran into another sort of trivial bug in v1 of the patch and concluded
that these functions really ought to be unit tested.

These two functions form the core of searching the chunk allocation pending
extent bitmap and have relatively easily definable semantics, so unit
testing them can help ensure the correctness of chunk allocation.

Note: I used claude code running claude opus 4.5 to stamp out the test
case definitions and do some code mods around the sizes and positions of
the holes. I added the Assisted-by: tag to indicate that, as I saw that
used on some other recent kernel commits. But if some other notation
(or throwing this out...) is preferable, I wanted to be as open about
it as possible. I did carefully check each case to make sure they were
what was expected.

Assisted-by: claude-opus-4-5
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/Makefile                       |   3 +-
 fs/btrfs/tests/btrfs-tests.c            |   3 +
 fs/btrfs/tests/btrfs-tests.h            |   1 +
 fs/btrfs/tests/chunk-allocation-tests.c | 481 ++++++++++++++++++++++++
 fs/btrfs/volumes.c                      |  14 +-
 fs/btrfs/volumes.h                      |   4 +
 6 files changed, 498 insertions(+), 8 deletions(-)
 create mode 100644 fs/btrfs/tests/chunk-allocation-tests.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 743d7677b175..975104b74486 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -44,4 +44,5 @@ btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
 	tests/extent-io-tests.o tests/inode-tests.o tests/qgroup-tests.o \
 	tests/free-space-tree-tests.o tests/extent-map-tests.o \
-	tests/raid-stripe-tree-tests.o tests/delayed-refs-tests.o
+	tests/raid-stripe-tree-tests.o tests/delayed-refs-tests.o \
+	tests/chunk-allocation-tests.o
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index b576897d71cc..7f13c05d3736 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -301,6 +301,9 @@ int btrfs_run_sanity_tests(void)
 			ret = btrfs_test_delayed_refs(sectorsize, nodesize);
 			if (ret)
 				goto out;
+			ret = btrfs_test_chunk_allocation(sectorsize, nodesize);
+			if (ret)
+				goto out;
 		}
 	}
 	ret = btrfs_test_extent_map();
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 4307bdaa6749..b0e4b98bdc3d 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -45,6 +45,7 @@ int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_raid_stripe_tree(u32 sectorsize, u32 nodesize);
 int btrfs_test_extent_map(void);
 int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize);
+int btrfs_test_chunk_allocation(u32 sectorsize, u32 nodesize);
 struct inode *btrfs_new_test_inode(void);
 struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
diff --git a/fs/btrfs/tests/chunk-allocation-tests.c b/fs/btrfs/tests/chunk-allocation-tests.c
new file mode 100644
index 000000000000..6c8054684cd5
--- /dev/null
+++ b/fs/btrfs/tests/chunk-allocation-tests.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Meta.  All rights reserved.
+ */
+
+#include <linux/sizes.h>
+#include "btrfs-tests.h"
+#include "../volumes.h"
+#include "../disk-io.h"
+#include "../extent-io-tree.h"
+
+/*
+ * Tests for chunk allocator pending extent internals.
+ * These two functions form the core of searching the chunk allocation pending
+ * extent bitmap and have relatively easily definable semantics, so unit
+ * testing them can help ensure the correctness of chunk allocation.
+ */
+
+/*
+ * Describes the inputs to the system and expected results
+ * when testing btrfs_find_hole_in_pending_extents().
+ */
+struct pending_extent_test_case {
+	const char *name;
+	/* Input range to search */
+	u64 hole_start;
+	u64 hole_len;
+	/* The size of hole we are searching for */
+	u64 min_hole_size;
+	/*
+	 * Pending extents to set up (up to 2 for up to 3 holes)
+	 * If len == 0, then it is skipped.
+	 */
+	struct {
+		u64 start;
+		u64 len;
+	} pending_extents[2];
+	/* Expected outputs */
+	bool expected_found;
+	u64 expected_start;
+	u64 expected_len;
+};
+
+static const struct pending_extent_test_case find_hole_tests[] = {
+	{
+		.name = "no pending extents",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {},
+		.expected_found = true,
+		.expected_start = 0,
+		.expected_len = 10ULL * SZ_1G,
+	},
+	{
+		.name = "pending extent at start of range",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {
+			{ .start = 0, .len = SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = SZ_1G,
+		.expected_len = 9ULL * SZ_1G,
+	},
+	{
+		.name = "pending extent overlapping start of range",
+		.hole_start = SZ_1G,
+		.hole_len = 9ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {
+			{ .start = 0, .len = SZ_2G },
+		},
+		.expected_found = true,
+		.expected_start = SZ_2G,
+		.expected_len = 8ULL * SZ_1G,
+	},
+	{
+		.name = "two holes; first hole is exactly big enough",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = 0,
+		.expected_len = SZ_1G,
+	},
+	{
+		.name = "two holes; first hole is big enough",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {
+			{ .start = SZ_2G, .len = SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = 0,
+		.expected_len = SZ_2G,
+	},
+	{
+		.name = "two holes; second hole is big enough",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_2G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = SZ_2G,
+		.expected_len = 8ULL * SZ_1G,
+	},
+	{
+		.name = "three holes; first hole big enough",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_2G,
+		.pending_extents = {
+			{ .start = SZ_2G, .len = SZ_1G },
+			{ .start = 4ULL * SZ_1G, .len = SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = 0,
+		.expected_len = SZ_2G,
+	},
+	{
+		.name = "three holes; second hole big enough",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_2G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+			{ .start = 5ULL * SZ_1G, .len = SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = SZ_2G,
+		.expected_len = 3ULL * SZ_1G,
+	},
+	{
+		.name = "three holes; third hole big enough",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_2G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+			{ .start = 3ULL * SZ_1G, .len = 5ULL * SZ_1G },
+		},
+		.expected_found = true,
+		.expected_start = 8ULL * SZ_1G,
+		.expected_len = SZ_2G,
+	},
+	{
+		.name = "three holes; all holes too small",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_2G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+			{ .start = 3ULL * SZ_1G, .len = 6ULL * SZ_1G },
+		},
+		.expected_found = false,
+		.expected_start = 0,
+		.expected_len = SZ_1G,
+	},
+	{
+		.name = "three holes; all holes too small; first biggest",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = 3ULL * SZ_1G,
+		.pending_extents = {
+			{ .start = SZ_2G, .len = SZ_1G },
+			{ .start = 4ULL * SZ_1G, .len = 5ULL * SZ_1G },
+		},
+		.expected_found = false,
+		.expected_start = 0,
+		.expected_len = SZ_2G,
+	},
+	{
+		.name = "three holes; all holes too small; second biggest",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = 3ULL * SZ_1G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+			{ .start = 4ULL * SZ_1G, .len = 5ULL * SZ_1G },
+		},
+		.expected_found = false,
+		.expected_start = SZ_2G,
+		.expected_len = SZ_2G,
+	},
+	{
+		.name = "three holes; all holes too small; third biggest",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = 3ULL * SZ_1G,
+		.pending_extents = {
+			{ .start = SZ_1G, .len = SZ_1G },
+			{ .start = 3ULL * SZ_1G, .len = 5ULL * SZ_1G },
+		},
+		.expected_found = false,
+		.expected_start = 8ULL * SZ_1G,
+		.expected_len = SZ_2G,
+	},
+	{
+		.name = "hole entirely allocated by pending",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {
+			{ .start = 0, .len = 10ULL * SZ_1G },
+		},
+		.expected_found = false,
+		.expected_start = 10ULL * SZ_1G,
+		.expected_len = 0,
+	},
+	{
+		.name = "pending extent at end of range",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {
+			{ .start = 9ULL * SZ_1G, .len = SZ_2G },
+		},
+		.expected_found = true,
+		.expected_start = 0,
+		.expected_len = 9ULL * SZ_1G,
+	},
+	{
+		.name = "zero length input",
+		.hole_start = SZ_1G,
+		.hole_len = 0,
+		.min_hole_size = SZ_1G,
+		.pending_extents = {},
+		.expected_found = false,
+		.expected_start = SZ_1G,
+		.expected_len = 0,
+	},
+};
+
+static int test_find_hole_in_pending(u32 sectorsize, u32 nodesize)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_device *device;
+	int ret = 0;
+	int i, j;
+
+	test_msg("running find_hole_in_pending_extents tests");
+
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	device = btrfs_alloc_dummy_device(fs_info);
+	if (IS_ERR(device)) {
+		test_err("failed to allocate dummy device");
+		ret = PTR_ERR(device);
+		goto out_free_fs_info;
+	}
+
+	/* Device must have fs_info set for lockdep_assert_held check */
+	device->fs_info = fs_info;
+
+	for (i = 0; i < ARRAY_SIZE(find_hole_tests); i++) {
+		const struct pending_extent_test_case *test_case = &find_hole_tests[i];
+		u64 hole_start = test_case->hole_start;
+		u64 hole_len = test_case->hole_len;
+		bool found;
+
+		/* Set up pending extents */
+		for (j = 0; j < ARRAY_SIZE(test_case->pending_extents); j++) {
+			u64 start = test_case->pending_extents[j].start;
+			u64 len = test_case->pending_extents[j].len;
+
+			if (!len)
+				continue;
+			btrfs_set_extent_bit(&device->alloc_state,
+					     start, start + len - 1,
+					     CHUNK_ALLOCATED, NULL);
+		}
+
+		/* Take the chunk_mutex to satisfy lockdep */
+		mutex_lock(&fs_info->chunk_mutex);
+		found = btrfs_find_hole_in_pending_extents(device, &hole_start, &hole_len,
+							   test_case->min_hole_size);
+		mutex_unlock(&fs_info->chunk_mutex);
+
+		/* Verify results */
+		if (found != test_case->expected_found) {
+			test_err("%s: expected found=%d, got found=%d",
+				 test_case->name, test_case->expected_found, found);
+			ret = -EINVAL;
+			goto out_clear_pending_extents;
+		}
+		if (hole_start != test_case->expected_start ||
+		    hole_len != test_case->expected_len) {
+			test_err("%s: expected [%llu, %llu), got [%llu, %llu)",
+				 test_case->name, test_case->expected_start,
+				 test_case->expected_start +
+					 test_case->expected_len,
+				 hole_start, hole_start + hole_len);
+			ret = -EINVAL;
+			goto out_clear_pending_extents;
+		}
+out_clear_pending_extents:
+		btrfs_clear_extent_bit(&device->alloc_state, 0, (u64)-1,
+				       CHUNK_ALLOCATED, NULL);
+		if (ret)
+			break;
+	}
+
+out_free_fs_info:
+	btrfs_free_dummy_fs_info(fs_info);
+	return ret;
+}
+
+/*
+ * Describes the inputs to the system and expected results
+ * when testing btrfs_first_pending_extent().
+ */
+struct first_pending_test_case {
+	const char *name;
+	u64 hole_start;
+	u64 hole_len;
+	struct {
+		u64 start;
+		u64 len;
+	} pending_extent;
+	bool expected_found;
+	u64 expected_pending_start;
+	u64 expected_pending_end;
+};
+
+static const struct first_pending_test_case first_pending_tests[] = {
+	{
+		.name = "no pending extent",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.pending_extent = { 0, 0 },
+		.expected_found = false,
+	},
+	{
+		.name = "pending extent at search start",
+		.hole_start = SZ_1G,
+		.hole_len = 9ULL * SZ_1G,
+		.pending_extent = { SZ_1G, SZ_1G },
+		.expected_found = true,
+		.expected_pending_start = SZ_1G,
+		.expected_pending_end = SZ_2G - 1,
+	},
+	{
+		.name = "pending extent overlapping search start",
+		.hole_start = SZ_1G,
+		.hole_len = 9ULL * SZ_1G,
+		.pending_extent = { 0, SZ_2G },
+		.expected_found = true,
+		.expected_pending_start = 0,
+		.expected_pending_end = SZ_2G - 1,
+	},
+	{
+		.name = "pending extent inside search range",
+		.hole_start = 0,
+		.hole_len = 10ULL * SZ_1G,
+		.pending_extent = { SZ_2G, SZ_1G },
+		.expected_found = true,
+		.expected_pending_start = SZ_2G,
+		.expected_pending_end = 3ULL * SZ_1G - 1,
+	},
+	{
+		.name = "pending extent outside search range",
+		.hole_start = 0,
+		.hole_len = SZ_1G,
+		.pending_extent = { SZ_2G, SZ_1G },
+		.expected_found = false,
+	},
+	{
+		.name = "pending extent overlapping end of search range",
+		.hole_start = 0,
+		.hole_len = SZ_2G,
+		.pending_extent = { SZ_1G, SZ_2G },
+		.expected_found = true,
+		.expected_pending_start = SZ_1G,
+		.expected_pending_end = 3ULL * SZ_1G - 1,
+	},
+};
+
+static int test_first_pending_extent(u32 sectorsize, u32 nodesize)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_device *device;
+	int ret = 0;
+	int i;
+
+	test_msg("running first_pending_extent tests");
+
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	if (!fs_info) {
+		test_std_err(TEST_ALLOC_FS_INFO);
+		return -ENOMEM;
+	}
+
+	device = btrfs_alloc_dummy_device(fs_info);
+	if (IS_ERR(device)) {
+		test_err("failed to allocate dummy device");
+		ret = PTR_ERR(device);
+		goto out_free_fs_info;
+	}
+
+	device->fs_info = fs_info;
+
+	for (i = 0; i < ARRAY_SIZE(first_pending_tests); i++) {
+		const typeof(first_pending_tests[0]) *test_case = &first_pending_tests[i];
+		u64 start = test_case->pending_extent.start;
+		u64 len = test_case->pending_extent.len;
+		u64 pending_start, pending_end;
+		bool found;
+
+		/* Set up pending extent if specified */
+		if (len) {
+			btrfs_set_extent_bit(&device->alloc_state,
+					     start, start + len - 1,
+					     CHUNK_ALLOCATED, NULL);
+		}
+
+		mutex_lock(&fs_info->chunk_mutex);
+		found = btrfs_first_pending_extent(device, test_case->hole_start,
+						   test_case->hole_len,
+						   &pending_start, &pending_end);
+		mutex_unlock(&fs_info->chunk_mutex);
+
+		if (found != test_case->expected_found) {
+			test_err("%s: expected found=%d, got found=%d",
+				 test_case->name, test_case->expected_found, found);
+			ret = -EINVAL;
+			goto out_clear_pending_extents;
+		}
+		if (!found)
+			goto out_clear_pending_extents;
+
+		if (pending_start != test_case->expected_pending_start ||
+			pending_end != test_case->expected_pending_end) {
+			test_err("%s: expected pending [%llu, %llu], got [%llu, %llu]",
+					test_case->name,
+					test_case->expected_pending_start,
+					test_case->expected_pending_end,
+					pending_start, pending_end);
+			ret = -EINVAL;
+			goto out_clear_pending_extents;
+		}
+
+out_clear_pending_extents:
+		btrfs_clear_extent_bit(&device->alloc_state, 0, (u64)-1,
+				       CHUNK_ALLOCATED, NULL);
+		if (ret)
+			break;
+	}
+
+out_free_fs_info:
+	btrfs_free_dummy_fs_info(fs_info);
+	return ret;
+}
+
+int btrfs_test_chunk_allocation(u32 sectorsize, u32 nodesize)
+{
+	int ret;
+
+	test_msg("running chunk allocation tests");
+
+	ret = test_first_pending_extent(sectorsize, nodesize);
+	if (ret)
+		return ret;
+
+	ret = test_find_hole_in_pending(sectorsize, nodesize);
+	if (ret)
+		return ret;
+
+	return 0;
+}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 2b632d238d4a..55a7b3801e9d 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1526,8 +1526,8 @@ struct btrfs_device *btrfs_scan_one_device(const char *path,
  * may still be modified, to something outside the range and should not
  * be used.
  */
-static bool first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
-				 u64 *pending_start, u64 *pending_end)
+bool btrfs_first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
+				u64 *pending_start, u64 *pending_end)
 {
 	lockdep_assert_held(&device->fs_info->chunk_mutex);
 
@@ -1567,8 +1567,8 @@ static bool first_pending_extent(struct btrfs_device *device, u64 start, u64 len
  * If there are no holes at all, then *start is set to the end of the range and
  * *len is set to 0.
  */
-static bool find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
-					 u64 min_hole_size)
+bool btrfs_find_hole_in_pending_extents(struct btrfs_device *device, u64 *start, u64 *len,
+					u64 min_hole_size)
 {
 	u64 pending_start, pending_end;
 	u64 end;
@@ -1589,7 +1589,7 @@ static bool find_hole_in_pending_extents(struct btrfs_device *device, u64 *start
 	 * At the end of the iteration, set the output variables to the max hole.
 	 */
 	while (true) {
-		if (first_pending_extent(device, *start, *len, &pending_start, &pending_end)) {
+		if (btrfs_first_pending_extent(device, *start, *len, &pending_start, &pending_end)) {
 			/*
 			 * Case 1: the pending extent overlaps the start of
 			 * candidate hole. That means the true hole is after the
@@ -1757,7 +1757,7 @@ static bool dev_extent_hole_check(struct btrfs_device *device, u64 *hole_start,
 
 again:
 	*hole_size = hole_end - *hole_start + 1;
-	found = find_hole_in_pending_extents(device, hole_start, hole_size, num_bytes);
+	found = btrfs_find_hole_in_pending_extents(device, hole_start, hole_size, num_bytes);
 	if (!found)
 		return found;
 	ASSERT(*hole_size >= num_bytes);
@@ -5191,7 +5191,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	 * in-memory chunks are synced to disk so that the loop below sees them
 	 * and relocates them accordingly.
 	 */
-	if (first_pending_extent(device, start, diff,
+	if (btrfs_first_pending_extent(device, start, diff,
 				 &pending_start, &pending_end)) {
 		mutex_unlock(&fs_info->chunk_mutex);
 		ret = btrfs_commit_transaction(trans);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index e4644352314a..48d82a1903a7 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -895,6 +895,10 @@ void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 						u64 logical, u16 total_stripes);
+bool btrfs_first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
+				u64 *pending_start, u64 *pending_end);
+bool btrfs_find_hole_in_pending_extents(struct btrfs_device *device,
+					u64 *start, u64 *len, u64 min_hole_size);
 #endif
 
 #endif
-- 
2.52.0


