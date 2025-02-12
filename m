Return-Path: <linux-btrfs+bounces-11428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED34A33370
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2025 00:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02AC5163FB5
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 23:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C1262179;
	Wed, 12 Feb 2025 23:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5KbuPNu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0221324C;
	Wed, 12 Feb 2025 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739403316; cv=none; b=qoyWAOAXp7YC1cnYpMuigeieI1vno/g9gCnt50IonQVuCzMa8SC2C0guwDVDLW326pLFZHQt/nzS4eVlGr/5HCGcKn9gRwKtz3ZDlyGBkQYoBsMH708rBJGYPAUhesI78284yZK7jhFRfFvDx72bfXNRNqRCHi4NWAPbIKMXIQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739403316; c=relaxed/simple;
	bh=5cqsjQHVCF6lM0enUHHTi62zyBAIBPtNBz6VIlRFwrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1nw5h8325n2qcsZjUF8nWI2nC3wMNtYsgWZVLfvGSy/C8yd3XKo9kh/YNTs5ZOpNlyex9kGPDo/EIUXllx0eU4NEhgU7VpyspYDDcfbFKOq+GbtqP49SFnn2G/HqdTG9J4fd6g6GEUoXcE32C9dkbbXu9xuEvDhIqpuJLVBKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5KbuPNu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33066C4CEE5;
	Wed, 12 Feb 2025 23:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739403315;
	bh=5cqsjQHVCF6lM0enUHHTi62zyBAIBPtNBz6VIlRFwrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U5KbuPNu+4hyrdBlfHJZRkRPG0NIEU3RQ2Ro4pLjEmlaBDx5ng/lKiAxDqFn8xkog
	 O6dCEWM+ZF0c+1cA+UQ8cfGpGQUKfZN5c6Qjtu5m0cqeCgNOR5UiDtUtHfzn9QBMM4
	 12DZAuuhOOlPzr6ESua9He4m+wMZjTyYJdfY8KARFL9jntx4VloHJP1YOG33o40but
	 6zgr/d6VAkFrAp0J3kayn9CbLgnaumI79eGQvDj9shohZFGwj0tiPQAhQ+yZV7DHWf
	 loWI8zlbx8iDwahl76zCI/0r+LXfIBS8Hz3sTOEAXpiOIH5iwE4hu+QGqB7XPghgQW
	 8+dndc//Rv6lg==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/8] btrfs: skip tests incompatible with compression when compression is enabled
Date: Wed, 12 Feb 2025 23:34:59 +0000
Message-ID: <700c5fba050de47dfece422a96a3b179567c1874.1739403114.git.fdmanana@suse.com>
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

We have several tests that fail when compression is enabled (MOUNT_OPTIONS
has "-o compress" or "-o compress-force"") because they expect a fixed
extent size and they trigger corruption by writing directly to a device,
therefore making them incompatible with compression.

So add a _require_no_compress call to them.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/215 | 4 ++++
 tests/btrfs/265 | 3 +++
 tests/btrfs/266 | 3 +++
 tests/btrfs/267 | 3 +++
 tests/btrfs/268 | 3 +++
 tests/btrfs/269 | 3 +++
 tests/btrfs/289 | 4 +++-
 tests/btrfs/297 | 4 ++++
 8 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/215 b/tests/btrfs/215
index b63ebff6..2418cc90 100755
--- a/tests/btrfs/215
+++ b/tests/btrfs/215
@@ -25,6 +25,10 @@ _require_scratch
 _require_btrfs_no_nodatacow
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device $SCRATCH_DEV
+# We need to ensure a fixed amount of written blocks to trigger a specific
+# number of read errors and we corrupt by writing directly to the device, so
+# skip if compression is enabled.
+_require_no_compress
 
 _scratch_mkfs > /dev/null
 # disable freespace inode to ensure file is the first thing in the data
diff --git a/tests/btrfs/265 b/tests/btrfs/265
index 0fa55a7f..5640e714 100755
--- a/tests/btrfs/265
+++ b/tests/btrfs/265
@@ -20,6 +20,9 @@ _require_btrfs_no_nodatacow
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
 
 _scratch_dev_pool_get 3
 # step 1, create a raid1 btrfs which contains one 128k file.
diff --git a/tests/btrfs/266 b/tests/btrfs/266
index 0788ba94..681cefda 100755
--- a/tests/btrfs/266
+++ b/tests/btrfs/266
@@ -21,6 +21,9 @@ _require_scratch_dev_pool 3
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
 
 _scratch_dev_pool_get 3
 # step 1, create a raid1 btrfs which contains one 128k file.
diff --git a/tests/btrfs/267 b/tests/btrfs/267
index 151ccdae..ceba974d 100755
--- a/tests/btrfs/267
+++ b/tests/btrfs/267
@@ -21,6 +21,9 @@ _require_btrfs_no_nodatacow
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
 
 _scratch_dev_pool_get 3
 # step 1, create a raid1 btrfs which contains one 128k file.
diff --git a/tests/btrfs/268 b/tests/btrfs/268
index dce5cb95..99e1ee4a 100755
--- a/tests/btrfs/268
+++ b/tests/btrfs/268
@@ -20,6 +20,9 @@ _require_btrfs_no_nodatacow
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
 _require_scratch_dev_pool 2
 _scratch_dev_pool_get 2
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
 
 echo "step 1......mkfs.btrfs"
 
diff --git a/tests/btrfs/269 b/tests/btrfs/269
index 129a4a41..183aeb73 100755
--- a/tests/btrfs/269
+++ b/tests/btrfs/269
@@ -22,6 +22,9 @@ _require_odirect
 # No data checksums for NOCOW case, so can't detect corruption and repair data.
 _require_btrfs_no_nodatacow
 _require_non_zoned_device "${SCRATCH_DEV}" # no overwrites on zoned devices
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
 _require_scratch_dev_pool 4
 _scratch_dev_pool_get 4
 
diff --git a/tests/btrfs/289 b/tests/btrfs/289
index 86e91021..b340b97d 100755
--- a/tests/btrfs/289
+++ b/tests/btrfs/289
@@ -18,7 +18,9 @@ _require_btrfs_no_nodatacow
 _require_odirect
 # Overwriting data is forbidden on a zoned block device
 _require_non_zoned_device "${SCRATCH_DEV}"
-
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
 # The errors reported would be in the unit of sector, thus the number
 # is dependent on the sectorsize.
 _require_btrfs_support_sectorsize 4096
diff --git a/tests/btrfs/297 b/tests/btrfs/297
index eb4f365e..1f3f7c08 100755
--- a/tests/btrfs/297
+++ b/tests/btrfs/297
@@ -14,6 +14,10 @@ _begin_fstest auto quick raid scrub
 _require_odirect
 _require_non_zoned_device "${SCRATCH_DEV}"
 _require_scratch_dev_pool 3
+# We need to ensure a fixed extent size and we corrupt by writing directly to
+# the device, so skip if compression is enabled.
+_require_no_compress
+
 _fixed_by_kernel_commit 486c737f7fdc \
 	"btrfs: raid56: always verify the P/Q contents for scrub"
 
-- 
2.45.2


