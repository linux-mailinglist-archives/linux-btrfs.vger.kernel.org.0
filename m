Return-Path: <linux-btrfs+bounces-5186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839A8CBAE8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22821282D9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 06:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E4178289;
	Wed, 22 May 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="djWMqdJS"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E185554784
	for <linux-btrfs@vger.kernel.org>; Wed, 22 May 2024 06:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357828; cv=none; b=Cd5LU7Thfz/7ekGxwE4UA83zYbIZcxDkNhI4dwN0SvFeIVzzk9JfX35pG/jwv/U+rBw3+UfjQglJl+i14QO5FjHY+/ztD0JoL03JwHbxzKeu13CUK8ypQVcPiu7mJXdUD6HHiV8VaiZ5NNdwnlDldayzSbYt4a58/5iWtcMLqaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357828; c=relaxed/simple;
	bh=mqtq6Zofgd59bWW6LEF9iOeD0q1uUFf/xD1zDyu48hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBG/WfYrKofkDRBsf0FjtkABBLwjt3bSe/8TGn7KYYORjQGERD9QAQfiznLR3bRqMUh6yFYMl7QKyutrLLQLyluOzWMFnvZzRMQk3gyoQvssJppCfS4J1O0rtAW5JJRJCdBwiYwzR6JEVjq5FJWeiApIS9hwLSX+OjAtRjtE/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=djWMqdJS; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716357827; x=1747893827;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mqtq6Zofgd59bWW6LEF9iOeD0q1uUFf/xD1zDyu48hg=;
  b=djWMqdJSTus7AY4N6NH9IKxXNM86v8X6Mh/vCsmcZ71PZhyv1VLwwHei
   Z3b3lAtl4AfjvS08hFHhSLujP8/8Y3EeVloQmYMFHpLctl5hqQbHnyUXA
   uyzYFRBHi5W0CbRSizamum0LPplVCqD91xlO/5rnFSYiMcBJim9hJnOCl
   wzgyiElAqL3bF5BPbSFvdfeppd2mfawWNI/TURreejr4Sl+wSbWMmDLt1
   E36q0WTXD2emz1nhQvioOmKmCf9tmwmjVRuZEIlrjUuOZWIRPSlzYafGz
   XWE3x1RQWFONttrVOxYGbkt85lusm/2Eivd8bVDH7YEsPZ43A6a7EEUDo
   A==;
X-CSE-ConnectionGUID: /ZTuGSmhTPmV3GZSI9eihw==
X-CSE-MsgGUID: o2AgooZxT8qByx9ANTlsZw==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16664803"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 14:03:42 +0800
IronPort-SDR: 664d7d21_2WzOM9s1gRC7w8CrE6IjcUa4s2kvj/QLZWw/PfkakSl3dpm
 mNK+WFp7MWxUj6woNz0KdhMmv3MiF7a0O2sGedw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 May 2024 22:05:37 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.60])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 May 2024 23:03:41 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 03/10] btrfs-progs: mkfs: unify zoned mode minimum size calc into btrfs_min_dev_size()
Date: Wed, 22 May 2024 15:02:25 +0900
Message-ID: <20240522060232.3569226-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240522060232.3569226-1-naohiro.aota@wdc.com>
References: <20240522060232.3569226-1-naohiro.aota@wdc.com>
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


