Return-Path: <linux-btrfs+bounces-4983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F848C5B06
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7363B1F2214E
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 18:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5EA180A90;
	Tue, 14 May 2024 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SmeOspU/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A1180A64
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715711094; cv=none; b=FzWArK/zywePhKwDqYTzMmQ5JgMPZriGzPYcQ/FwAvFEd9qsgA9aKEYdatydE9Z/uasruGlCUyEOYmXVflY509jUw8Pln2HUdifkgRgonikEamDr0yMpdFWngtdfpCo1wduTd9IQjQ7toW1sXBRwSnBwCDjbWBGnE1h09NVDDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715711094; c=relaxed/simple;
	bh=Ek0WCq6b/0O2vdSWF3CqjsqnmxmWFaX6kUGKL3z2U+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFNH1eG+/d42106dUEWjsnqWfyvf9aS+5CETfi3IFv7Ho5LTFkBJAQPEGTLzAGm67OSrjbNiuogFkEma30XqKa6Onk6cOpEGVfoB/ULxGKOd7xhoDGIQxYWjUdbogpVAPCaXdD9kId/+m/f5F7YVapj3VIJTb1bKZmEM21qj3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SmeOspU/; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715711092; x=1747247092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ek0WCq6b/0O2vdSWF3CqjsqnmxmWFaX6kUGKL3z2U+I=;
  b=SmeOspU/5lQm8Ksk6rfasEJgvSOvEJCKHb5QNCMee4tdjU3GDOIHpmpz
   /u21o9IluGvQeixRh3JJ+XjiCGyvaH3ttRTLk8twgEd+zg+KJDpaEXfNL
   x2BIAwm/MbZBsfmp14vl4vMYNbrEVUm6781KbMqmoo+HG+aunLOW4Pkt+
   jpF+jzBfj3QaelUoR0/L6kPv+7LMCUQWfiZSo8nrTunlRHvLrA5+389YJ
   fKPFmc6yVLQp9F4kCmuGIHXvXtL+fv7qdj2TLmMVmXjpJ4iU15TxFp8WV
   +GfHrlFFCVmfEVLMMSqfP3uwIt88QV/ZXM9f/ooVyBPeR9a6AWgmecfRX
   g==;
X-CSE-ConnectionGUID: r2hifLoZSXuv//PwfjYDTg==
X-CSE-MsgGUID: g/TEb5UgTSuUjwmYRNmUrA==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="17162639"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 02:24:49 +0800
IronPort-SDR: 6643a032_Pwci4xFsspUakuv5NJfZpPoGOml+RS52Jd2/LvpHNFTaCcs
 KuaJGMTENcC/urc3DjsuXwdvjeYI9r9iRepEXmw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 10:32:35 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-x1.wdc.com) ([10.225.163.56])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 May 2024 11:24:47 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/8] btrfs-progs: mkfs: unify zoned mode minimum size calc into btrfs_min_dev_size()
Date: Tue, 14 May 2024 12:22:22 -0600
Message-ID: <20240514182227.1197664-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514182227.1197664-1-naohiro.aota@wdc.com>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to implement a better minimum size calculation for the zoned
mode. Move the current logic to btrfs_min_dev_size() and unify the size
checking path.

Also, convert "int mixed" to "bool mixed" while at it.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 mkfs/common.c | 11 ++++++++++-
 mkfs/common.h |  2 +-
 mkfs/main.c   | 22 +++++-----------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index 3c48a6c120e7..af54089654a0 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -811,13 +811,22 @@ static u64 btrfs_min_global_blk_rsv_size(u32 nodesize)
 	return (u64)nodesize << 10;
 }
 
-u64 btrfs_min_dev_size(u32 nodesize, int mixed, u64 meta_profile,
+u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile,
 		       u64 data_profile)
 {
 	u64 reserved = 0;
 	u64 meta_size;
 	u64 data_size;
 
+	/*
+	 * 2 zones for the primary superblock
+	 * 1 zone for the system block group
+	 * 1 zone for a metadata block group
+	 * 1 zone for a data block group
+	 */
+	if (zone_size)
+		return 5 * zone_size;
+
 	if (mixed)
 		return 2 * (BTRFS_MKFS_SYSTEM_GROUP_SIZE +
 			    btrfs_min_global_blk_rsv_size(nodesize));
diff --git a/mkfs/common.h b/mkfs/common.h
index d9183c997bb2..de0ff57beee8 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -105,7 +105,7 @@ struct btrfs_mkfs_config {
 int make_btrfs(int fd, struct btrfs_mkfs_config *cfg);
 int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
 			struct btrfs_root *root, u64 objectid);
-u64 btrfs_min_dev_size(u32 nodesize, int mixed, u64 meta_profile,
+u64 btrfs_min_dev_size(u32 nodesize, bool mixed, u64 zone_size, u64 meta_profile,
 		       u64 data_profile);
 int test_minimum_size(const char *file, u64 min_dev_size);
 int is_vol_small(const char *file);
diff --git a/mkfs/main.c b/mkfs/main.c
index f6f67abf3b0e..a437ecc40c7f 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1588,8 +1588,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	min_dev_size = btrfs_min_dev_size(nodesize, mixed, metadata_profile,
-					  data_profile);
+	min_dev_size = btrfs_min_dev_size(nodesize, mixed,
+					  opt_zoned ? zone_size(file) : 0,
+					  metadata_profile, data_profile);
 	/*
 	 * Enlarge the destination file or create a new one, using the size
 	 * calculated from source dir.
@@ -1650,21 +1651,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (byte_count && byte_count < min_dev_size) {
 		error("size %llu is too small to make a usable filesystem",
 			byte_count);
-		error("minimum size for btrfs filesystem is %llu",
-			min_dev_size);
-		goto error;
-	}
-	/*
-	 * 2 zones for the primary superblock
-	 * 1 zone for the system block group
-	 * 1 zone for a metadata block group
-	 * 1 zone for a data block group
-	 */
-	if (opt_zoned && byte_count && byte_count < 5 * zone_size(file)) {
-		error("size %llu is too small to make a usable filesystem",
-			byte_count);
-		error("minimum size for a zoned btrfs filesystem is %llu",
-			min_dev_size);
+		error("minimum size for a %sbtrfs filesystem is %llu",
+		      opt_zoned ? "zoned mode " : "", min_dev_size);
 		goto error;
 	}
 
-- 
2.45.0


