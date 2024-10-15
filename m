Return-Path: <linux-btrfs+bounces-8944-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A45599FA1D
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 23:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845FA1C2125B
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0223320262F;
	Tue, 15 Oct 2024 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="nhP1T0QY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o4f2jqGt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB651F80BC;
	Tue, 15 Oct 2024 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028019; cv=none; b=baI+J+yv+fEpjw5JtEjqbSL+mzK/qhXNB6fDIvxMWr2JQTTCXS0/00eORdSlB3O3s7H0//TvOB2V9M+xdHumci0GR3duUe9dY7NzZZM1jiL6svV1SuFa5h3mM2uTTcLJOVCisSx3XkC1iC7OKeXWZt8ymjrqzGBVppP84gtvc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028019; c=relaxed/simple;
	bh=Ai8jqOfsBX+iXUmm0/sd57CqZLmwcRTDiCcH4AFW4jE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IJc2jsmCul2OSrZANvErmJLa3UjjtgwhAdowdUgg8rDzMwTdkZApUO5GJaSoDbB+9Oa9vEplqsg9N8RXfHn/03b0tLy5M9abSmk+/Cp3YRfgQ3Bs02p/Kaua4dr7mxICVkW8Zepc4dmiS77lP4UasRtVC1TG3oxYZY7JxsaLoSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=nhP1T0QY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o4f2jqGt; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B864B11401B0;
	Tue, 15 Oct 2024 17:33:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 15 Oct 2024 17:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1729028015; x=1729114415; bh=XdlTjey+JfsKfK1lb0yUE
	YWOS/uMOTZlgL/nOGu8nOw=; b=nhP1T0QYCOvjHIOfB3rk4vNjAYpe1TK6bdfvP
	9/LrnBY7qiLeNZTCwdIgInqBgWbSctoH41yQIRpD+jV6ixpATmwq95cV3wTDloHk
	oU17L6U3lMJTPtUrG2pTzJTzMgvzol+XCCk0dQD7qh5Gk7NPOyK5scjW3UWHCKqD
	S6CBargtOoHov/MgOYmS43HmSiZOLCpdp7IzlKXRgD1zT2Hr2HPTmA3HpzmXLD3S
	GKNjYKR29J+R/klbsqlCozhRimbU9quNxA/IDYXWYbNDyZB6GgIxnUB0p6sS9r9+
	vhRfPI3YUcjlo+Nj6VAluHJLY+aiR+Xs+nkRHflCTExff5WOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729028015; x=1729114415; bh=XdlTjey+JfsKfK1lb0yUEYWOS/uM
	OTZlgL/nOGu8nOw=; b=o4f2jqGtj0ygpK1zi+t+L1zxeYmcoDfu+qvlv/HZMTCv
	JfmdgQRW9E1DTnoFYwsHqvHy8M63AtXqikYBoKi6BsoNCJK+SPP3UC9CG2ynkLQH
	BsMzI4/NtpaZdlkey74H35plM0B1s51FhybzB1/YDVBHAyH4lVzAgE2h1EviyNvU
	5dF/wqRdcyJbNK3RQ+MAnQ4cqwfWpCuew0NJDKuADUGUAPxK9/73ft7yG2EfQHyn
	IcIUC5nHoXwUsw0mvP6jhF+MBrWxdMh8y0yTn8hbe0cisKy07jwuHqOfvigdPX1H
	AocnxXzwDWUI0OH6eEkjvxpH2OFTMK0gBMJzIyF0iA==
X-ME-Sender: <xms:r98OZziQixwZHP3XkqcOph9xP4H7f1ml73_C8XQxxW5wmfa8QiyIbA>
    <xme:r98OZwDUlFYPJFfGDY9K_OvvdvcO259IMriaoZYcYgrEcUFUIwLp1Gfj6l0b2F1W2
    gltWL3JtbA9aEjNuhk>
X-ME-Received: <xmr:r98OZzGcNvvA6V6Yc5P_NkgZwMlapCr8UPWLt8dFseCm1DhfU3q__hdrCZpD7Jahp5p83PGhgNBSyNqVw-3Mh_ojybw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegkecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffogg
    fgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhs
    segsuhhrrdhioheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgf
    ejjeeigeekudduteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdgsthhrfhhs
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmh
    esfhgsrdgtohhmpdhrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:r98OZwTzo8bQnGerF8Tp06KTLrFRYrLubZ3KIE8UQdTNIq3cB4tITA>
    <xmx:r98OZwzVF5xBEUXolUACRVOTe-mkeoWU_ZIagFspcbzcM_Xu1Z9xOw>
    <xmx:r98OZ24ahS_CptBaWwCqCh_ju33tVooWRfxCGtYnvi6otG4Gvvq51Q>
    <xmx:r98OZ1ymcAWqLgHBxKLWu7B-Z6iaNLZkYyoD400BQ4o5ks7vdtxFHg>
    <xmx:r98OZ88fIdWDLwde_CuhAdN7gABfwPgjCU7kj8vOqvhRJ_GFdVWTCMuZ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 17:33:35 -0400 (EDT)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: add test for cleaner thread under seed-sprout
Date: Tue, 15 Oct 2024 14:33:12 -0700
Message-ID: <37a3018160b04d127ec8eef1f1ccfb3583ce0e40.1729027883.git.boris@bur.io>
X-Mailer: git-send-email 2.46.2
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

Signed-off-by: Boris Burkov <boris@bur.io>
---
 tests/btrfs/323     | 46 +++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/323.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/btrfs/323
 create mode 100644 tests/btrfs/323.out

diff --git a/tests/btrfs/323 b/tests/btrfs/323
new file mode 100755
index 000000000..0aa45633b
--- /dev/null
+++ b/tests/btrfs/323
@@ -0,0 +1,46 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2024 YOUR NAME HERE.  All Rights Reserved.
+#
+# FS QA Test 323
+#
+# Test that remounted seed/sprout device FS is fully functional. For example, that it can purge stale subvolumes.
+#
+. ./common/preamble
+_begin_fstest auto quick seed remount
+
+. ./common/filter
+_require_test
+_require_command "$BTRFS_TUNE_PROG" btrfstune
+_require_scratch_dev_pool 2
+
+_fixed_by_kernel_commit XXXXXXXX \
+	"btrfs: do not clear read-only when adding sprout device"
+
+_scratch_dev_pool_get 2
+dev_seed=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $1}')
+dev_sprout=$(echo $SCRATCH_DEV_POOL | $AWK_PROG '{print $2}')
+
+# create a read-write fs based off a read-only seed device
+_mkfs_dev $dev_seed
+$BTRFS_TUNE_PROG -S 1 $dev_seed
+_mount $dev_seed $SCRATCH_MNT >>$seqres.full 2>&1 
+_btrfs device add -f $dev_sprout $SCRATCH_MNT >>$seqres.full
+_mount -o remount,rw $SCRATCH_MNT
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
+_scratch_dev_pool_put
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
new file mode 100644
index 000000000..5dba9b5f0
--- /dev/null
+++ b/tests/btrfs/323.out
@@ -0,0 +1,2 @@
+QA output created by 323
+Silence is golden
-- 
2.46.0


