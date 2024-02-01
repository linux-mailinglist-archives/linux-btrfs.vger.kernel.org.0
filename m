Return-Path: <linux-btrfs+bounces-2038-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7622845F63
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 19:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0471C21F55
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96451128806;
	Thu,  1 Feb 2024 18:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+n5XHKt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAB384FB2;
	Thu,  1 Feb 2024 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810654; cv=none; b=eNpdBp9xKVaTQuwoyVXmx7zkrX+Cl+/gsf996EBxmmQ1ge2cMcq73c+xOpdJssjJ8RyIWrbGHRLLz7PqmwEqfRyN3fM4uqJYE3KLwFFoIKgBCHX3+sGQtrn3tx/HaLOUcnz57cQvqdC57+Lmyyhfk33UCnrU9+2NbdQjRf8mjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810654; c=relaxed/simple;
	bh=BWiqFVO3jlZeDfqjBtpe5k9UV8+EHbM889pu2XrE0X4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Npvyr4cvE0R/RIfAUzTw8KsZOTFL3Rf4mNCsBPYB6Qs9mZEji69j8Q47SMaOGFgyPAmaNxtsRDW6um0foD0SGGGuwbGkQf7VR+BCQmtTgC9kl37UKJbq7zes3JFg9122I7FTr8KYGPNOhfllcW/qA2E6SER3h9sqh+FvyyhVjv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+n5XHKt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E7CC433C7;
	Thu,  1 Feb 2024 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706810654;
	bh=BWiqFVO3jlZeDfqjBtpe5k9UV8+EHbM889pu2XrE0X4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A+n5XHKtpIAPy6kh+z4TLy1uweNtAMCbZl7QOvYvxRR2accFYzWR9HWO/G1YuL3JF
	 Q8sgcCKERyWbXzmd0cJvFOmcPdgKus0cAtXPcFD6oVvAO656Y1dTy1ous/Ow9Xobgt
	 VHZBnFY/qEaxFBMl0Lc83X9O92RRebJ/nHrw/iru8yXrRa3YIQ0zJyWmgtMKHm+/1+
	 2duvow9qtD31netPNNwbulidIqX+tVNXQAMXaGt29CK5mo868W3JitKt+x831RPQvh
	 WeC/x20w1hT4p5PiS57ACLSQvYEn2Rd4DJ1Puu/j0AUUX4ufwXcxhATaFHuPmHJFLM
	 YPcsN3jt14Pog==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 4/4] btrfs: require no nodatacow for tests that exercise read repair
Date: Thu,  1 Feb 2024 18:03:50 +0000
Message-Id: <5c3c56241dcb8d2b6c87bb4d6875d2c0659b9219.1706810184.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1706810184.git.fdmanana@suse.com>
References: <cover.1706810184.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Several test cases that exercise the ability to detect corrupted data and
repair it, fail when "-o nodatacow" is passed to MOUNT_OPTIONS, because
that ability requires the existence of data checksums, and those are
disabled in nodatacow mode. So skip the tests when "-o nodatacow" is
present.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/140 | 3 ++-
 tests/btrfs/141 | 2 ++
 tests/btrfs/157 | 2 ++
 tests/btrfs/158 | 2 ++
 tests/btrfs/215 | 2 ++
 tests/btrfs/265 | 2 ++
 tests/btrfs/266 | 2 ++
 tests/btrfs/267 | 2 ++
 tests/btrfs/268 | 2 ++
 tests/btrfs/269 | 2 ++
 tests/btrfs/289 | 2 ++
 11 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/140 b/tests/btrfs/140
index 247a7356..5ce65886 100755
--- a/tests/btrfs/140
+++ b/tests/btrfs/140
@@ -22,7 +22,8 @@ _begin_fstest auto quick read_repair fiemap
 # Modify as appropriate.
 _supported_fs btrfs
 _require_scratch_dev_pool 2
-
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_btrfs_command inspect-internal dump-tree
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
diff --git a/tests/btrfs/141 b/tests/btrfs/141
index 90a90d00..e1adb91e 100755
--- a/tests/btrfs/141
+++ b/tests/btrfs/141
@@ -22,6 +22,8 @@ _begin_fstest auto quick read_repair
 
 # Modify as appropriate.
 _supported_fs btrfs
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_scratch_dev_pool 2
 
 _require_btrfs_command inspect-internal dump-tree
diff --git a/tests/btrfs/157 b/tests/btrfs/157
index 022db511..648db0d0 100755
--- a/tests/btrfs/157
+++ b/tests/btrfs/157
@@ -30,6 +30,8 @@ _begin_fstest auto quick raid read_repair
 
 # Modify as appropriate.
 _supported_fs btrfs
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
diff --git a/tests/btrfs/158 b/tests/btrfs/158
index aa85835a..28599d09 100755
--- a/tests/btrfs/158
+++ b/tests/btrfs/158
@@ -22,6 +22,8 @@ _begin_fstest auto quick raid scrub
 
 # Modify as appropriate.
 _supported_fs btrfs
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_scratch_dev_pool 4
 _require_btrfs_command inspect-internal dump-tree
 _require_btrfs_fs_feature raid56
diff --git a/tests/btrfs/215 b/tests/btrfs/215
index 00646898..6fa226fe 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -25,6 +25,8 @@ get_physical()
 # Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device $SCRATCH_DEV
 
diff --git a/tests/btrfs/265 b/tests/btrfs/265
index b75d9c84..127da7ad 100755
--- a/tests/btrfs/265
+++ b/tests/btrfs/265
@@ -19,6 +19,8 @@ _begin_fstest auto quick read_repair
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/266 b/tests/btrfs/266
index 42aff7c0..acfb1d59 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -18,6 +18,8 @@ _begin_fstest auto quick read_repair
 # real QA test starts here
 
 _supported_fs btrfs
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_scratch_dev_pool 3
 
 _require_odirect
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index 75a6fdcc..51b28d9b 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -20,6 +20,8 @@ _begin_fstest auto quick read_repair
 _supported_fs btrfs
 _require_scratch_dev_pool 3
 
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
diff --git a/tests/btrfs/268 b/tests/btrfs/268
index 9dc14a18..d122ee36 100755
--- a/tests/btrfs/268
+++ b/tests/btrfs/268
@@ -16,6 +16,8 @@ _begin_fstest auto quick read_repair
 _supported_fs btrfs
 _require_scratch
 _require_odirect
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/269 b/tests/btrfs/269
index ad8f7286..7ffad125 100755
--- a/tests/btrfs/269
+++ b/tests/btrfs/269
@@ -20,6 +20,8 @@ _begin_fstest auto quick read_repair
 _supported_fs btrfs
 _require_scratch
 _require_odirect
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 4
 _scratch_dev_pool_get 4
diff --git a/tests/btrfs/289 b/tests/btrfs/289
index 39d8f733..f1aaf4cc 100755
--- a/tests/btrfs/289
+++ b/tests/btrfs/289
@@ -16,6 +16,8 @@ _begin_fstest auto quick scrub repair
 # Modify as appropriate.
 _supported_fs btrfs
 _require_scratch
+# No data checksums for NOCOW case, so can't detect corruption and repair data.
+_require_btrfs_no_nodatacow
 
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
-- 
2.40.1


