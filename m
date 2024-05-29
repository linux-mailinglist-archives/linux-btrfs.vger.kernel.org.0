Return-Path: <linux-btrfs+bounces-5340-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C548D2DE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 09:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAE31C23EE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 May 2024 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255E167287;
	Wed, 29 May 2024 07:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UM4jPGCN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0431667D1
	for <linux-btrfs@vger.kernel.org>; Wed, 29 May 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716966821; cv=none; b=UDyu8jH7gFQY8hzkuMiM4OHKNANgimFEEuhF/3wV0Y0oSwXdxyXq7RlbA+YuRA8NWyiHxRxpVxoL1L2HRNMZZYjaJIokY68ndq327hDHLYgEQWwBidpLPPY0yFJ1M6B9t3yNd1bUh7DAp+RFYT9eatni9T2lIfxNNW3Hb92SyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716966821; c=relaxed/simple;
	bh=dRO0k9wA/abSGDe2GyjHKnw78xcScbqtiN0eU87ImLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoQuJW7WvW99ECredbhdyfyZ2SW3uUbWhpz8RlZTFaWGOj6D5deX2ziw55xo/NgA+du1/90EC0xPCVQjpnQsnRajGezfCZX1K/rN/ZdQagHkqq7TRVBGhf6A53GDVOQe22c7unlh9dKmZ7MWudtI/178lqw/OVw1rD1Wla9n9Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UM4jPGCN; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716966820; x=1748502820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dRO0k9wA/abSGDe2GyjHKnw78xcScbqtiN0eU87ImLY=;
  b=UM4jPGCNoFlcACbgw/rugtLIPGoiqbO8uZYHvpUx8oYTzISjqMC/SVJP
   yXwiisAStdzsKiUfnZCecvVaHh7MaitVhwhuQwzWmeYATxUBj1WvLtQSO
   MFc+V0/dqzvwwn092qthDhMWsbPJlcxydclO01121QUwLU1jE2+ujNpcN
   euJ+9qXO7kAVl6nOl/bgEJcQC9gdvfDT2H4v+ScJO2g30YEyJyFhWjqRc
   JxBMtkmX8vRm73iEdOmfob+Jc1+MRn0o88pFDMurXq/4rlW8fSz2NKogI
   HuSZKwQ5dUo6vmsGCNBv85Lvrb8dYOFRdc38+xUTvuRNXQmv32ZI2BgxC
   A==;
X-CSE-ConnectionGUID: p+EqTmK2RKCMLCNOX6Zugw==
X-CSE-MsgGUID: ewbi+wY+Q3WUunXqHfCvMg==
X-IronPort-AV: E=Sophos;i="6.08,197,1712592000"; 
   d="scan'208";a="16865341"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2024 15:13:32 +0800
IronPort-SDR: 6656c94c_MasPhWXjL5QrCOOQNVzmR9g8F79aRyMDeqh1AXnzJgK9vgH
 39l3fyHViQH9CKKZSUOGsXuHvx8DFIGkTC7t4Vg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 May 2024 23:21:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.62])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 May 2024 00:13:32 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>
Subject: [PATCH v4 03/10] btrfs-progs: mkfs: unify zoned mode minimum size calc into btrfs_min_dev_size()
Date: Wed, 29 May 2024 16:13:18 +0900
Message-ID: <20240529071325.940910-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 11 ++++++++++-
 mkfs/common.h |  2 +-
 mkfs/main.c   | 22 +++++-----------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index e61020002417..2550c2219c90 100644
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
2.45.1


