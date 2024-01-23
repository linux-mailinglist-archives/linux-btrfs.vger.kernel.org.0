Return-Path: <linux-btrfs+bounces-1655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F77F8399E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 20:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AB1B25E2E
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9D82D87;
	Tue, 23 Jan 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="G5O17Vld";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PHXBDKKp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178A823D4;
	Tue, 23 Jan 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706039760; cv=none; b=QVitUEBNx0sGTgiiREdl2FITIExuZnH947Qfb9g1BE/qNnxV4v6aELxwb8RDS5ILDaiDhepW3dDqzLKBB724Lxsw3efifzil4B0oOkzHU8lHb+gXbb4Uxj3Ple3wbHhBjFu+Y7iQ4TFurZoHA31OSHtD6ZxHhsihHwtIpAGxOe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706039760; c=relaxed/simple;
	bh=m0huhoxp7kWvSSu45o3xug39ChTNFf330CKJjkjlW7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Ud3wL6TlKZSkAaluPqjoMrtu8KLWimuroj4aS3CGLmRqOX7e1OY5atZ8ijxOcIc+tW5ArahE6qSVq5i3G0qnG/6zRAWuv1svpC70NenTqF5QJFu3CGvxEKrJecMt6GNXWBA58NQ9GIgo7mY7AH8ho5lCuPYVYymkpxuMjI4m3+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=G5O17Vld; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PHXBDKKp; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A82955C0156;
	Tue, 23 Jan 2024 14:55:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 23 Jan 2024 14:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1706039756; x=1706126156; bh=eMl2C/uXpJ/BLXUauamQn
	oArYSUUhvQB07dKNlFUspk=; b=G5O17Vlda9POE8yd6roDYOkl9Quz0VOyV7mMM
	lyquzotPB8wVxyjMqYg5geLBeAOqz407ouSChh2O4/4iaHAkb6FC+f3gQbtacKl9
	IPaFYv3gIv+hSuJeyHn21/BRzLos14N8/c32hk63ihFNb/HnLT3yaLCF6z1mnV9f
	fJNfjWHNbTsiIl3qkxvpTJD7m94qwge8fBL7wekT6z6mgosurzrq9zzc2dEdOVJo
	OQT88TvBphsWUGZY0IfDWnMzLcrzpxmANNJSFGbNQWdrGU6XbuGitEFZcZyWSlDC
	Fsyyc5K3ZYHCmeW3KSEV7WNr4QBA+EMZ7GbxbXRZT7TMGegIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706039756; x=1706126156; bh=eMl2C/uXpJ/BLXUauamQnoArYSUU
	hvQB07dKNlFUspk=; b=PHXBDKKpGsddWfeupHFWaIZ+VIRjz8ThF5J7Xg0gXANF
	pFFT670yqASJQnYEwM7Y5ppPnK5cG6uZBC4s7CaYeqH8zmqXH6Fs6xWBPXUC2yTo
	kjMyxMCG4VX30zsBEBEhtrW5EtNi+36t31NYEz1rL2tBlLXQmkZ1jTscxeHqSkSA
	r/LcyVXqxO/i/5SQhCvDfVLa3IMjorcRAyO0CVvpDetdOm5Dq6tLiBVW5i9fGmAl
	XMfS7oi+fA5m/dGUif8qNj0drOFp4+taIqrCVscjuaVwKfOLvDmIiLCzZB7gu43O
	uynZwJD5SVQMGkvxPmxkMZZkd3WEFDN2a5syE4k8cg==
X-ME-Sender: <xms:zBmwZcWVlOhAtQibEjVyiWJQGggv09yHw2MgPQAr7SJSOcvnF3hYrg>
    <xme:zBmwZQnfZLX4a7-1X7RiDh32ZgQJKOh0qb2GT8jlE7yilj4Y6tb4172u7U0ytA6_U
    RzdIdWh-c4t0IcEvp8>
X-ME-Received: <xmr:zBmwZQZlAT5Z0N9CyQFqc1EdF1zfzY_HWFjypMEn8-zwud76nmitidOz7zR8NV4gLQNzNKJwWWUiNd8Bdksm4RWR4ck>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekkedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:zBmwZbXTxkEq2LnlaZmLLV1SQT9P0Q60iwi5lIWnQ2RYVvac4MJyIA>
    <xmx:zBmwZWmG_ADGC2abSfDcgcurFrNlQOm2OM1fNvjJG8iINWtC11q-sg>
    <xmx:zBmwZQct-sOPB3n8EXLJ_vYExuVDN0XiBmozbLhnu7-En6fP6t5ZXw>
    <xmx:zBmwZavAnhe2iI42CupYhy73BnXVBl1YMF1jsDqJaRztEOf2JBlLGg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jan 2024 14:55:56 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: [PATCH] btrfs: Remove btrfs/303
Date: Tue, 23 Jan 2024 11:56:59 -0800
Message-ID: <a3f51f2fff6581a6b4dd2e5776b7f40d22dcf65b.1706039782.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test was reproducing a bug triggered by creating a subvolume qgroup
before creating the subvolume itself with a snapshot.

The kernel patch:
btrfs: forbid creating subvol qgroups

explicitly prevents that and makes it fail with EINVAL. I could "fix"
this test by expecting the EINVAL message in the output, but at that
point it would simply be a test that creating a subvolume and
snapshotting it works with qgroups, which is adequately tested by other
tests which focus on accurately measuring shared/exclusive usage in
various snapshot/reflink scenarios. To avoid confusion, I think it is
best to simply delete this test.

Signed-off-by: Boris Burkov
---
 tests/btrfs/303     | 77 ---------------------------------------------
 tests/btrfs/303.out |  2 --
 2 files changed, 79 deletions(-)
 delete mode 100755 tests/btrfs/303
 delete mode 100644 tests/btrfs/303.out

diff --git a/tests/btrfs/303 b/tests/btrfs/303
deleted file mode 100755
index 410460af5..000000000
--- a/tests/btrfs/303
+++ /dev/null
@@ -1,77 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (C) 2023 SUSE Linux Products GmbH. All Rights Reserved.
-#
-# FS QA Test 303
-#
-# A regression test to make sure snapshot creation won't cause transaction
-# abort if there is already an existing qgroup.
-#
-. ./common/preamble
-_begin_fstest auto quick snapshot subvol qgroup
-
-. ./common/filter
-
-_supported_fs btrfs
-_require_scratch
-
-_fixed_by_kernel_commit xxxxxxxxxxxx \
-	"btrfs: do not abort transaction if there is already an existing qgroup"
-
-_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
-_scratch_mount
-
-# Create the first subvolume and get its id.
-# This subvolume id should not change no matter if there is an existing
-# qgroup for it.
-$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
-$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
-	"$SCRATCH_MNT/snapshot">> $seqres.full
-
-init_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
-
-if [ -z "$init_subvolid" ]; then
-	_fail "Unable to get the subvolid of the first snapshot"
-fi
-
-echo "Subvolumeid: ${init_subvolid}" >> $seqres.full
-
-_scratch_unmount
-
-# Re-create the fs, as btrfs won't reuse the subvolume id.
-_scratch_mkfs >> $seqres.full 2>&1 || _fail "2nd mkfs failed"
-_scratch_mount
-
-$BTRFS_UTIL_PROG quota enable "$SCRATCH_MNT" >> $seqres.full
-_qgroup_rescan $SCRATCH_MNT >> $seqres.full
-
-# Create a qgroup for the first subvolume, this would make the later
-# subvolume creation to find an existing qgroup, and abort transaction.
-$BTRFS_UTIL_PROG qgroup create 0/"$init_subvolid" "$SCRATCH_MNT" >> $seqres.full
-
-# Now create the first snapshot, which should have the same subvolid no matter
-# if the quota is enabled.
-$BTRFS_UTIL_PROG subvolume create "$SCRATCH_MNT/subvol" >> $seqres.full
-$BTRFS_UTIL_PROG subvolume snapshot "$SCRATCH_MNT/subvol" \
-	"$SCRATCH_MNT/snapshot" >> $seqres.full
-
-# Either the snapshot create failed and transaction is aborted thus no
-# snapshot here, or we should be able to create the snapshot.
-new_subvolid=$(_btrfs_get_subvolid "$SCRATCH_MNT" "snapshot")
-
-echo "Subvolumeid: ${new_subvolid}" >> $seqres.full
-
-if [ -z "$new_subvolid" ]; then
-	_fail "Unable to get the subvolid of the first snapshot"
-fi
-
-# Make sure the subvolumeid for the first snapshot didn't change.
-if [ "$new_subvolid" -ne "$init_subvolid" ]; then
-	_fail "Subvolumeid for the first snapshot changed, has ${new_subvolid} expect ${init_subvolid}"
-fi
-
-echo "Silence is golden"
-
-# success, all done
-status=0
-exit
diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
deleted file mode 100644
index d48808e60..000000000
--- a/tests/btrfs/303.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 303
-Silence is golden
-- 
2.43.0


