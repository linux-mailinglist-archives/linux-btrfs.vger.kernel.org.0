Return-Path: <linux-btrfs+bounces-11403-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5744A32CAF
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028FD1889619
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9EC2144AC;
	Wed, 12 Feb 2025 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6IBa1tk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD968253B51;
	Wed, 12 Feb 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379737; cv=none; b=AbaMwV638rY53wKd1gwFLr7mnvB3qc/ZY6onZb1r2/x3Tf2mlkxYWJ603UnQQkhcDQxl8AuJCIFhUfI12ccRrSy0SMhTKGEnWID4gPph1sKx/ozj5meh8dkdfc8JkXXZ5mtC7TuItu5cSRCDRRjlD8wG52ovTD08Obe5JCSfpGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379737; c=relaxed/simple;
	bh=mEA6zR7taKLZ1OBPGOXVQmZv+1C07ayZnEAe5m9zUf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDw/EiDcM6+2fIIrDomPh2V1Q0rlmC56VT9wxsAIGlICT3zOAsh7CgXojt9niV+B6s+steSmkPazxJk8QAVH3KcNp5qj9+ZOo8EUNAwbBpOV+spaHdIEz00DbjJlXNlHi5nA9CVph7dWRIDLpxUwYMi3z06z81z4zlxttgXagok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6IBa1tk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A4EC4CEE2;
	Wed, 12 Feb 2025 17:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379737;
	bh=mEA6zR7taKLZ1OBPGOXVQmZv+1C07ayZnEAe5m9zUf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6IBa1tkJh6g/yWRvg1qYhbggFXPqoyHQTO9WRR7BalEXcF3fJsryLXWARFWyeZD2
	 yCFC6XGYAP2S3SBUArghkrxdEXPv/W2/a/tQQBodFaCimDEQW3nisOBv+DStkN0NTp
	 Vm24PBBGeIjHpW58wJ0f5CYoTs7791ylEB9gyB0TmboOmogwPcAJ4/MgPmeRXFRHcN
	 nT4z5YPepWngPdNHgOTyk++xcmpGsQK6myMCkp+Igof9LAD5fcrwEnWEN/gMOB5iUH
	 wXUdqrZKuNdn80JX6M8nsmE3qPW/fZ6gFnrqnVrUYlfR48N0n/3Vbdls1sLXshYw4k
	 voohBjM3TcYNQ==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/8] btrfs: skip tests incompatible with compression when compression is enabled
Date: Wed, 12 Feb 2025 17:01:49 +0000
Message-ID: <4a038d084d22c06a7d905b2dc8001f24707f9006.1739379184.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1739379182.git.fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
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


