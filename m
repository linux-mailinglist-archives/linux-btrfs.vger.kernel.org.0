Return-Path: <linux-btrfs+bounces-21067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDmKIjSid2kCjQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21067-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:48 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB678B64A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 18:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC0F03034E0E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD334BA33;
	Mon, 26 Jan 2026 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WOnBqZIG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tk70lqVU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC2D2C0F63
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769447966; cv=none; b=LvTEN0WCRsQdYNkI5WzgjRn1HGbLjjWgnpZskTzBlWOzXy5PIGndO3FHktl9tWS6bsEXahNvNTHPSIoshrHebc93HAyAA2GIhUUq5nuEqKd3b7sPF9+9cyVopgqAEN1eZ8pHTyT5MSP0LeCGm6p57n83i3T5+I2nShEzqnMPSZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769447966; c=relaxed/simple;
	bh=RYqhu1UuhWY111KCBndtcx7OMbGqKlHpzKEJazcrAbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpchNyUfj/PRq/dVMlkoJr1T31zz4AuhWnGSVYc8iyKoz91iT5yYWu6KSbu4bR+o5cWy3F0ZQLiMcvcmq4r0ZrWZB1gzqGtrHvlJcy7dqmWsvD+jNmIzlJbl+72jXgqgPhK5NG7ri15XhvVN9HswLUo5d8hzXSN2M6tTnPl0QEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WOnBqZIG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tk70lqVU; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 90142EC0226;
	Mon, 26 Jan 2026 12:19:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Jan 2026 12:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1769447963; x=
	1769534363; bh=IXMECdYsEJm01H5EkTkWTk6aOkTvmrSYXPM3xHVFLsY=; b=W
	OnBqZIGYZx4P3rqdnrktUnvSbt0ReLLYvWgIfQVpvZAWX5A5Ok+2ZQZvZHuICGcH
	+aoLHYWwsrxc/LhWb3CJfJ1O8O4RFLZ75zoqiQCaZAdEcFc7niFTpe4orR2RCwwe
	giUrgY0LPUYXOqbqB+TNRVJnWdCnQLSFat/yQgHTPqoH4fUENlEneeo54UuzYWR9
	aDcv/nPGBAI41itNdSv/0Dbu3pMnItE12B79scMHyJ5/+gZ0CrwnA9N9sKw3zn7K
	MNjm+lRUk3ByMmzhEx/jJl4BlLSdw4SgH2p9ayUuELGof9+WUJYcoxjvZ6Eyt5zH
	dt1cbTbWNnuHXplZe1YMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1769447963; x=1769534363; bh=IXMECdYsEJm01H5EkTkWTk6aOkTv
	mrSYXPM3xHVFLsY=; b=tk70lqVUdXR0Nm1GyUrABL2pvEUTGZgG0cZ8Z901JP2N
	SIKiSSIr+aOSI9RyXYZh5mhk645KGC3DYKqkjaee7PgtNExRcJTnXGwrPl4KFCe1
	2RqpelZacGwxMyv7hoUFlpECIXaHLSXpWRNeRtjy9ZfKgeWaXYZgooxgDV/v3tsz
	1nNMYvMyGzrgEcq8PG1q3TiDz1CneZZM4A1kopKDcq53svp3GnhGc9x7awlkCIdL
	AZPE70MtMvgdtUDncQ99UQ8XMyB/scY8sJox1n1BtFc/J4QwauZ8+cgVeTczPUNj
	duTNl/2af12CGEM92qxNnA0FCW3PV3Npw+5GFCQv1Q==
X-ME-Sender: <xms:G6J3ab1vIQ50wvvCYqAi_BthznpwA-YWVf4lxLj5BCO3bl0SAPq0GA>
    <xme:G6J3aQEBcM-GmNTsepPnvd-HzodQ8i3ToluPh-WHM6RodWCtcZM2GYLJlbdnjxy2r
    iLwoISzUNevJvyvFnUoBVD3Dp5CJZva9ryKfxKQEWyYCWKYYFynB1UC>
X-ME-Received: <xmr:G6J3aZhJzPIoKyNZrDmbKTYp_wEyJlBpCm_tkRRzpJWzmKSaqJpfwn2obz4XnLA-mERQuOxkcGlcLvPMirbQ3EhJS1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeeiueffuedvieeujefhheeigfekvedujeejjeffvedvhe
    dtudefiefhkeegueehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghmsehfsgdrtghomh
X-ME-Proxy: <xmx:G6J3ab8uFLv-kLp470rkeHAARNeL7Iaasbzx7hppV32iO1zNN_-Qeg>
    <xmx:G6J3aQr_cW3_f0LY1BLJn5OdhyPyLvlxP-9GJ0W6-qEZ1XN1sjpVmQ>
    <xmx:G6J3aa9-fGuqUEum0MEwBSlJuX_WJJD96EFx8BltDynBRBFYIw4y2g>
    <xmx:G6J3aUXduwTBvt1VXBQ-TrKNT9aTJBLWy7ifZSbtm0THYX3vLFzArg>
    <xmx:G6J3aVaUti_Pwlj9oiL59qivPNu0F4fhdknQxvW-lhf_fRwv6WrSVvNx>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:19:23 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 2/3] btrfs: unit tests for pending extent walking functions
Date: Mon, 26 Jan 2026 09:18:52 -0800
Message-ID: <38d581dd4374d651136f8c3dfe7afe2d357a506f.1769447820.git.boris@bur.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769447820.git.boris@bur.io>
References: <cover.1769447820.git.boris@bur.io>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bur.io:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bur.io:+,messagingengine.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[bur.io];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-21067-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boris@bur.io,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: DEB678B64A
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
 fs/btrfs/volumes.h                      |   5 +
 6 files changed, 499 insertions(+), 8 deletions(-)
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
index e4644352314a..8cb72e84dc84 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -892,6 +892,11 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb);
 int btrfs_update_device(struct btrfs_trans_handle *trans, struct btrfs_device *device);
 void btrfs_chunk_map_device_clear_bits(struct btrfs_chunk_map *map, unsigned int bits);
 
+bool btrfs_first_pending_extent(struct btrfs_device *device, u64 start, u64 len,
+				u64 *pending_start, u64 *pending_end);
+bool btrfs_find_hole_in_pending_extents(struct btrfs_device *device,
+					u64 *start, u64 *len, u64 min_hole_size);
+
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
 						u64 logical, u16 total_stripes);
-- 
2.52.0


