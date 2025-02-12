Return-Path: <linux-btrfs+bounces-11433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7BA33376
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46272163325
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5CD263C61;
	Wed, 12 Feb 2025 23:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwo08Gnb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F386C261364;
	Wed, 12 Feb 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403323; cv=none; b=NePaGLtBezZN2SUKQRMOa1YzFgo5OPHF7P9hC1C2fF/hk5rk95SQ/2ncAf+UNpgBtxxH2rTK+ZykMK5Na6bVFKAezqkQSyjPjmXpGsctLyoTZndCfABVxgZ4qyehVHAwQ6xWuxQNjoT8Toq0CWVNcY8HsixTs9onYb431Xtn0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403323; c=relaxed/simple;
	bh=YAX+qxIcE/XtJa2HS8/EY/sAhnhF6Vp8gg0UUCqZAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+U8pzdfolxd0Qa3NQUvM7k8IWHRQ3YiwR2Utm2ZEjA6RHilCbwadp5d4NkP5SUi17mAzbPGk6qNHAdm8OVeUdl3Kyf3aRn4XBL+kP6hxz/qLQ/R+xvps2YYXYZELGG3xtiiQKbfuD85enczlXusaI5Tygx3SkwOADyS1xiWa7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwo08Gnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB150C4CEDF;
	Wed, 12 Feb 2025 23:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403322;
	bh=YAX+qxIcE/XtJa2HS8/EY/sAhnhF6Vp8gg0UUCqZAds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cwo08GnbMBsqN0sGFIw3UlvU/cOVZMroAWUfwRvNdCJQnYbRrX2TGbeoZZP2a568l
	 FWed7NfcxcFa3aHW3yTcrpmeZtGvDLBPA4qCiVVXrlt1lMzzpv0c66SIdBxjaTDGeR
	 Sb2Ex4UzYQxsVqJMNl7ExVSVRYh05vRvH4nhXyIwnaGoDyIlrZIIohUSpJu8o9G+IF
	 f1Ajd9bnue2jGpiFAwoM/mFGccgk70uBPwr5CPnehUJR9Ufyy9Tte0+dIJvQSlseK4
	 ExXZoODeS+L1Ubj/yWMjmppFTsy8zxl4VMOE5ILdkISOdHnKKVXY8OYsbqlljymLtQ
	 hoym9A/Zhi4mg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 6/8] btrfs: skip tests exercising data corruption and repair when using nodatasum
Date: Wed, 12 Feb 2025 23:35:04 +0000
Message-ID: <3933f432a25909190d730f3d8c1cd8b47d899d24.1739403114.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
References: <cover.1739403114.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several tests exercise corrupting data and then checking that on read the
data is repaired, but this requires using checksums, so the tests fail
when running with the nodatasum mount option.

So add a _require_btrfs_no_nodatasum call to these tests.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/140 | 4 +++-
 tests/btrfs/141 | 4 +++-
 tests/btrfs/157 | 4 +++-
 tests/btrfs/158 | 4 +++-
 tests/btrfs/215 | 4 +++-
 tests/btrfs/265 | 4 +++-
 tests/btrfs/266 | 4 +++-
 tests/btrfs/267 | 4 +++-
 tests/btrfs/268 | 4 +++-
 tests/btrfs/269 | 4 +++-
 tests/btrfs/289 | 4 +++-
 11 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index b2c8451d..cb70f967 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -17,8 +17,10 @@ _begin_fstest auto quick read_repair fiemap
 . ./common/filter
 
 _require_scratch_dev_pool 2
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_btrfs_command inspect-internal dump-tree
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 3d48dff3..4afd3304 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -17,8 +17,10 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_scratch_dev_pool 2
 
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index c49229f0..00393fc8 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -25,8 +25,10 @@ _begin_fstest auto quick raid read_repair
 
 . ./common/filter
 
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_raid_type raid6
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index ff28defe..87d16cdf 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -17,8 +17,10 @@ _begin_fstest auto quick raid scrub
 
 . ./common/filter
 
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_raid_type raid5
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 2418cc90..bd82fb79 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -21,8 +21,10 @@ get_physical()
 }
 
 _require_scratch
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device $SCRATCH_DEV
 # We need to ensure a fixed amount of written blocks to trigger a specific
diff --git a/tests/btrfs/265 b/tests/btrfs/265
index 5640e714..823d4d96 100755
--- a/tests/btrfs/265
+++ b/tests/btrfs/265
@@ -15,8 +15,10 @@ _begin_fstest auto quick read_repair
 
 _require_scratch_dev_pool 3
 
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/266 b/tests/btrfs/266
index 681cefda..bffcec27 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -14,8 +14,10 @@ _begin_fstest auto quick read_repair
 
 . ./common/filter
 
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_scratch_dev_pool 3
 
 _require_odirect
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index ceba974d..b4ea3106 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -16,8 +16,10 @@ _begin_fstest auto quick read_repair
 
 _require_scratch_dev_pool 3
 
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/268 b/tests/btrfs/268
index 99e1ee4a..7681b1a5 100755
--- a/tests/btrfs/268
+++ b/tests/btrfs/268
@@ -15,8 +15,10 @@ _begin_fstest auto quick read_repair
 
 _require_scratch
 _require_odirect
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/269 b/tests/btrfs/269
index 183aeb73..c048da44 100755
--- a/tests/btrfs/269
+++ b/tests/btrfs/269
@@ -19,8 +19,10 @@ _begin_fstest auto quick read_repair
 
 _require_scratch
 _require_odirect
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 # We need to ensure a fixed extent size and we corrupt by writing directly to
 # the device, so skip if compression is enabled.
diff --git a/tests/btrfs/289 b/tests/btrfs/289
index b340b97d..1e8336a7 100755
--- a/tests/btrfs/289
+++ b/tests/btrfs/289
@@ -12,8 +12,10 @@ _begin_fstest auto quick scrub repair
 . ./common/filter
 
 _require_scratch
-# No data checksums for NOCOW case, so can't detect corruption and repair data.
+# No data checksums for NOCOW and NODATACOW cases, so can't detect corruption
+# and repair data.
 _require_btrfs_no_nodatacow
+_require_btrfs_no_nodatasum
 
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
-- 
2.45.2


