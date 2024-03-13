Return-Path: <linux-btrfs+bounces-3252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A4A87AA97
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 16:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523281C20B25
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Mar 2024 15:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE5A47A73;
	Wed, 13 Mar 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHGjV+xR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648C47A40;
	Wed, 13 Mar 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344505; cv=none; b=QgZR/tz7xt93/hoQG4QWXpVU764iHE4Cy0xXiIYCm+84rnYGZO9fJDfTv37fxKB0Kfkl3+AzvAtcL5XsQ8ZR7trsspkJpwo3qVaCQ37sY9vjgaLBadrOyPUmMJFrSRowSvvA2pWQadnD79hjzyrhp0oN68Xf95j9VQFgnPM100s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344505; c=relaxed/simple;
	bh=fyhfEQPReRMuaos4/P9XywQjRZMuFhsSVcOru9ShhrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N3v8xWfrntHwmecIOQW0FQkUesbAANtX9rkrSjrN+A+UpTAzGoMT9mbZ7jG4U1+0xzvko1/mnbDFpwUiGIU6arltZnLAnuyrFzxSfZ7R+DBDD1dHRTru73M02xb6WWF7imHYZS5VsQ0RDsWktfP4IElSDKc+VDS6Q7fX5/OXECQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHGjV+xR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D36C433C7;
	Wed, 13 Mar 2024 15:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710344504;
	bh=fyhfEQPReRMuaos4/P9XywQjRZMuFhsSVcOru9ShhrM=;
	h=From:To:Cc:Subject:Date:From;
	b=HHGjV+xRi+wYwbNbRyxNi5wha8Vgxd6YEwXMXS/eoatM3p7ZXrMV/aQhpzm60fq5t
	 enterQyNlkSDHONqoeeIyMhqnRS/rvGqolwivVY8LUDiphw0UCiaYGPo8VQNWZl3L4
	 vWv6TJeTmAaqZOJxU1iMDnQky6UGJRR34L0RwL1tNVuvwfV9X21MSg6gyuqV/ZWCY6
	 ejH16UOM/q3aWETPIepzLI834wPJMWjV7niJOoWYFMXOvRw3LwN0j2eZ9ywg3U/+GL
	 1LBfZYQjmh3To2mI7cweWcFGuSqo5aV5s+HAC2kcJvI3cnLLL7wVhfmSkRxJQTaoHf
	 xbjUvX4MnQkTg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2] fstests: add missing commit IDs to some tests
Date: Wed, 13 Mar 2024 15:41:36 +0000
Message-ID: <198116c12575e5a3f76fe7ef47e1fe7f82a22695.1710344411.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

Some tests are still using a 'xxx...' commit ID but the respective patches
were already merged to Linus' tree or btrfs-progs, so update them with the
correct commit IDs and in two cases update the subject as well, because it
was modified after the test case was added and before being sent to Linus
(btrfs/317 and generic/707).

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

V2: Also add a missing btrfs-progs commit ID to btrfs/249 and ext4 commit ID
    to generic/707.

 tests/btrfs/249   | 2 +-
 tests/btrfs/303   | 2 +-
 tests/btrfs/309   | 2 +-
 tests/btrfs/316   | 2 +-
 tests/btrfs/317   | 4 ++--
 tests/generic/707 | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/249 b/tests/btrfs/249
index 06cc444b..0355434b 100755
--- a/tests/btrfs/249
+++ b/tests/btrfs/249
@@ -28,7 +28,7 @@ _require_command "$WIPEFS_PROG" wipefs
 _require_btrfs_forget_or_module_loadable
 _wants_kernel_commit a26d60dedf9a \
 	"btrfs: sysfs: add devinfo/fsid to retrieve actual fsid from the device"
-_fixed_by_git_commit btrfs-progs xxxxxxxxxxxx \
+_fixed_by_git_commit btrfs-progs 32c2e57c65b9 \
 	"btrfs-progs: read fsid from the sysfs in device_is_seed"
 
 _scratch_dev_pool_get 2
diff --git a/tests/btrfs/303 b/tests/btrfs/303
index 26bcfe41..ed3abcc1 100755
--- a/tests/btrfs/303
+++ b/tests/btrfs/303
@@ -25,7 +25,7 @@ _require_test
 _require_scratch
 _require_xfs_io_command "fiemap"
 
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 5897710b28ca \
 	"btrfs: send: don't issue unnecessary zero writes for trailing hole"
 
 send_files_dir=$TEST_DIR/btrfs-test-$seq
diff --git a/tests/btrfs/309 b/tests/btrfs/309
index 5cbcd223..d1eb953f 100755
--- a/tests/btrfs/309
+++ b/tests/btrfs/309
@@ -12,7 +12,7 @@ _begin_fstest auto quick snapshot subvol
 _supported_fs btrfs
 _require_scratch
 _require_test_program t_snapshot_deleted_subvolume
-_fixed_by_kernel_commit XXXXXXXXXXXX \
+_fixed_by_kernel_commit 7081929ab257 \
 	"btrfs: don't abort filesystem when attempting to snapshot deleted subvolume"
 
 _scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
diff --git a/tests/btrfs/316 b/tests/btrfs/316
index 07a94334..f78a0235 100755
--- a/tests/btrfs/316
+++ b/tests/btrfs/316
@@ -17,7 +17,7 @@ _begin_fstest auto quick qgroup
 _supported_fs btrfs
 _require_scratch
 
-_fixed_by_kernel_commit xxxxxxxxxxxx \
+_fixed_by_kernel_commit d139ded8b9cd \
 	"btrfs: qgroup: always free reserved space for extent records"
 
 _scratch_mkfs >> $seqres.full
diff --git a/tests/btrfs/317 b/tests/btrfs/317
index 59686b72..b17ba584 100755
--- a/tests/btrfs/317
+++ b/tests/btrfs/317
@@ -10,8 +10,8 @@
 . ./common/preamble
 _begin_fstest auto volume raid convert
 
-_fixed_by_kernel_commit XXXXXXXXXX \
-	"btrfs: zoned: don't skip block group profile checks on conv zones"
+_fixed_by_kernel_commit 5906333cc4af \
+	"btrfs: zoned: don't skip block group profile checks on conventional zones"
 
 . common/filter.btrfs
 
diff --git a/tests/generic/707 b/tests/generic/707
index ad1592a1..da9dc5b6 100755
--- a/tests/generic/707
+++ b/tests/generic/707
@@ -16,8 +16,8 @@ _require_scratch
 
 _fixed_by_kernel_commit f950fd052913 \
 	"udf: Protect rename against modification of moved directory"
-_fixed_by_kernel_commit XXXXXXXXXXXX \
-	"ext4: fix possible corruption when moving a directory"
+_fixed_by_kernel_commit 0813299c586b \
+	"ext4: Fix possible corruption when moving a directory"
 
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
-- 
2.43.0


