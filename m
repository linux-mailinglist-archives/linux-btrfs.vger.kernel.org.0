Return-Path: <linux-btrfs+bounces-11408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DF6A32CB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 18:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FC7816837D
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59322586D2;
	Wed, 12 Feb 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nda9O3hJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC099254B09;
	Wed, 12 Feb 2025 17:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379744; cv=none; b=XyoRno3q5dRHtUECaWzWfZoalAPfV9Rty3Uw6HJKUk+5hss3iE2yvSGlzXNGZYEVYqnZiUZsqhnBlF+7v16U//ukcj2EVuWxSYcr60owL7sEoZFnv33nNLjCZ4Q5SuQc+zW8DoSABeT+wmYVg1+Cz9k3dmPiYV/wV2pq7HXpDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379744; c=relaxed/simple;
	bh=YAX+qxIcE/XtJa2HS8/EY/sAhnhF6Vp8gg0UUCqZAds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fs/RgqbZ+XDAAsAYrSCw4f4PfXIJI7FM2f9Sa3O2/mSlCEUmGLmIgGEKr7s2yJAMS5bojvMX03BldZwUXwObnWKWdqmTXAP3wIZ0OlH76s4Dv4aDIvYqrs+YxSFUN5MkUxGWkrPpPnaTZRrOJstZW+7dv3PnRBp1L5QjMjzz3b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nda9O3hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D16AC4CEE4;
	Wed, 12 Feb 2025 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739379744;
	bh=YAX+qxIcE/XtJa2HS8/EY/sAhnhF6Vp8gg0UUCqZAds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nda9O3hJNrQsQcrdV0d6NWHBoiC6trKDDiuBjUBZEAl1dW5O7oEtMuUGChiSZgeQ5
	 /+equ2BNaHkgS4cDWVgqDsdZGpPeiU5DsVUqAdNbHuCRrRWIPdgxkR7hkIONWgRdYv
	 X2ORbCwiIp2C1Ol5h8iFAn1mhnba2075z26T9deJV+pBH6Y98tSi1HGOFGpuSHCQ3P
	 tZX9EbuMJdh0U7VgFZcp8WHXyCcaVL9orF1WVoKsKQE/mkfzOnJtzj/9L+frRmau6d
	 NjCKeZl+iE4CoVWTOFVvzKGP+Fl3fwxcdHlx1KfieVGuyZ/5PBnnpAmdeXZgpY5764
	 dAEPYQS/8IgOw==
From: fdmanana@kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 6/8] btrfs: skip tests exercising data corruption and repair when using nodatasum
Date: Wed, 12 Feb 2025 17:01:54 +0000
Message-ID: <dd3d5c6226ddb4963ac740c01ad670382c4acdc2.1739379185.git.fdmanana@suse.com>
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


