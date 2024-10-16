Return-Path: <linux-btrfs+bounces-8975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 429B19A1109
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 19:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAE11F22512
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2024 17:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0677212F05;
	Wed, 16 Oct 2024 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="dbY5rsH/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U2J9J8TR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC958210C39;
	Wed, 16 Oct 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729101300; cv=none; b=Cwpu6HQVy13syJ6NOVe6PYsgnC9PmMlnJzHvFTGCvqQI4zVFvUChhql+6kKd846cAHNdl2Kmmcpwg6pySrtnn5O4Bzl4SLODcpYj/zBBEJc8773AspqJb2Cjrdf/ufMVUU60y7h0gmTUC7hHz6H37hHpk/qtqSL18PGQD0lQ8c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729101300; c=relaxed/simple;
	bh=5qvMurcds7rUY6u9ZIMP61FWfAkGxylWAUi1bBQFOzA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OFfsDlpk3OaEx5UNKDx7Ns6O+8xkhNUZTvqye+SbJCf6uSnZi8/M5nNjJqOnxuiwh7Vjw9vjnjMzhiv3ovd8eYApZGttEPNUoYW3SEBsSwoP1EuZ1SQ22ulKaXLlkb8d8rPPeBDIIxCVnxydzuoRByPFnonNQ2J3Y5A5diadi2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=dbY5rsH/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U2J9J8TR; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BFC8411401B0;
	Wed, 16 Oct 2024 13:54:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Oct 2024 13:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729101297; x=1729187697; bh=e8xsORkjsL4z0I3f7l8nM
	9+jdI/mFFrsoAn1vAQVyhQ=; b=dbY5rsH/3YI4SuqEyPz6j9Ks6G9FWeQRks89E
	3eW1qRQA3uFFe533xpKGsAaI9CccZcbiXK3p9oItPm/csiCvJ4H69WkN6ufbiiPc
	j33C3pmxuKqf4H1LCdyhe+eEG6cxYbxwZ3XGTmrtTJsqbc7gR2QjBIaXPkuEXk3f
	NSP3xVdnw4YjVAMplnWXZVHM+3k4zxZIX9ekhpD5LT7IdVA3ZBzHQWmjPjWe6FqC
	oz9LKxCYvJIYkwB6gW2mJxRDvDUQS8e03KedCPMc0QU6r1cEMNuls9Uo/xNBmOUP
	Tpos9H80CMO3ZWgdvgXOt+CJCQEKRIEsAJoIgbqoQ0tRIj1sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729101297; x=1729187697; bh=e8xsORkjsL4z0I3f7l8nM9+jdI/m
	FFrsoAn1vAQVyhQ=; b=U2J9J8TRsqMB7uqblp3t9VoSUl/rLkslOz+2yC6p1iK6
	T8jAJTXa+yfmxs0VBxAmRY/Uu5lwWETqUtcfk3SdMjA9/cxzfNAeybo98wi33jxN
	6rlfnh5eOpRnZoaw4AWD2JDi/5EFPnoDte/eWaJFwDl+eAKyjsAYxKarQEH/YGYX
	Asgakk+/xgZMx5XJyCmznQLD466H2gcVZZ+L4maYWXUZcgt9ZWNUsxBOq1K+90Xg
	ivFVuLKPs6nw6X8Q/Z1nJIgIRDE/IXTWKm9UQS+9/Pn2GqAod/9sO24BlhCWgX4V
	/uhQjSUA1B1NGxqQkOy/2sD1CteNZ1dm8ufhtU20wg==
X-ME-Sender: <xms:8f0PZ4aUc0hEcqdf-Z3rkQ8COF4_jyrI46hRLR7exY7LoHs02kSJ8g>
    <xme:8f0PZza9JBjxmxaHVqp_81JMYXp6IA_111Qv68Llpjuk3TACKWqIBXcNkD9ec9Ihx
    dpH1yLbpFI7FSgA6xs>
X-ME-Received: <xmr:8f0PZy9sy4Kf5lgqpJk6FbG6M81KjN7Ql34ZjsvFyvY_sFhljcNX8vFVKhODKbIzdSP1MtyY1-EVOo7COUaVJzhfu5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegs
    ohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffve
    elieefgfejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprh
    gtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgs
    thhrfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhsthgvshhtsh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvghrnhgvlhdqthgvrghm
    sehfsgdrtghomh
X-ME-Proxy: <xmx:8f0PZyq2Bja8nEdeXCyxoRLAUYpMTL1fdfKZFURIEl44GsV58PVApQ>
    <xmx:8f0PZzoQgZ9DxRULST2Kibv8rqgB6YXcUfNdzTice7DraO0jDfEEKw>
    <xmx:8f0PZwSh5qBEg1Q20vTWCIUxDACQ6qUriHsmQ-P3km-15TGD-BA41Q>
    <xmx:8f0PZzq4KRHtNa0noJagXEG0kbHPvrpECMYNAsNVmsPJ1kMhpiblgA>
    <xmx:8f0PZyWj-KI5w7qGgLb44kNk8qoKCT1wvv0srX_H3p2Q_ffYvtjxrbDn>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 13:54:57 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3] btrfs: add test for cleaner thread under seed-sprout
Date: Wed, 16 Oct 2024 10:54:33 -0700
Message-ID: <20ebca40c55ed9207b6ea77aa50e93f3baf698ad.1729101127.git.boris@bur.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have a longstanding bug that creating a seed sprout fs with the
ro->rw transition done with

mount -o remount,rw $mnt

instead of

umount $mnt
mount $sprout_dev $mnt

results in an fs without BTRFS_FS_OPEN set, which fails to ever run the
critical btrfs cleaner thread.

This test reproduces that bug and detects it by creating and deleting a
subvolume, then triggering the cleaner thread. The expected behavior is
for the cleaner thread to delete the stale subvolume and for the list to
show no entries. Without the fix, we see a DELETED entry for the subvol.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v3:
- add volume group
- switch to SCRATCH_DEV/SPARE_DEV
- filter scratch devs from mount/findmnt output instead of suppressing.
  This adds the expected read only message that comes with mounting seed
  devices to the golden output, and makes the ro/rw check more natural.
v2:
- update to real copyright info
- add extra rw->ro transition checks
- remove unnecessary _require_test
---
 tests/btrfs/323     | 47 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/323.out |  4 ++++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/btrfs/323
 create mode 100644 tests/btrfs/323.out

diff --git a/tests/btrfs/323 b/tests/btrfs/323
new file mode 100755
index 000000000..4e389d66a
--- /dev/null
+++ b/tests/btrfs/323
@@ -0,0 +1,47 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
+#
+# FS QA Test 323
+#
+# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
+#
+. ./common/preamble
+_begin_fstest auto quick seed remount
+
+. ./common/filter
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_scratch_dev_pool 2
+
+_fixed_by_kernel_commit XXXXXXXX \
+	"btrfs: do not clear read-only when adding sprout device"
+
+_scratch_dev_pool_get 1
+_spare_dev_get
+
+# create a read-only fs based off a read-only seed device
+_scratch_mkfs >>$seqres.full
+$BTRFS_TUNE_PROG -S 1 $SCRATCH_DEV
+_scratch_mount 2>&1 | _filter_scratch
+_btrfs device add -f $SPARE_DEV $SCRATCH_MNT >>$seqres.full
+
+# switch ro to rw, checking that it was ro before and rw after
+findmnt -n -O ro -o TARGET $SCRATCH_MNT | _filter_scratch
+_mount -o remount,rw $SCRATCH_MNT
+findmnt -n -O rw -o TARGET $SCRATCH_MNT | _filter_scratch
+
+# do stuff in the seed/sprout fs
+_btrfs subvolume create $SCRATCH_MNT/subv
+_btrfs subvolume delete $SCRATCH_MNT/subv
+
+# trigger cleaner thread without remounting
+_btrfs filesystem sync $SCRATCH_MNT
+
+# expect no deleted subvolumes remaining
+$BTRFS_UTIL_PROG subvolume list -d $SCRATCH_MNT
+
+_spare_dev_put
+
+# success, all done
+status=0
+exit
diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
new file mode 100644
index 000000000..1ca2e4b13
--- /dev/null
+++ b/tests/btrfs/323.out
@@ -0,0 +1,4 @@
+QA output created by 323
+mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
+SCRATCH_MNT
+SCRATCH_MNT
-- 
2.46.0


