Return-Path: <linux-btrfs+bounces-13082-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53696A9067A
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1205E189E845
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9F1C54B2;
	Wed, 16 Apr 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nKWlEey1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFF21EB5DA
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813720; cv=none; b=BJouxINjQwf2Hf5B3Zsi0Ib4T8a8NrGA20ShZOEIyO3M+JhiQ0Uw+rxLGK/L8/r4/mo6Uhb1xDwIvFLM8CejXX0ad03/J1rbuNQRdv6djRCg/R1OisO09pUrrTcAyP8JGnTBeB+F7eEkLjoABLnCE3T/Pw1SCh4ZAFPfiOzSQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813720; c=relaxed/simple;
	bh=nDlRIctq9sSTuK3XV/+XqLxDMgu+Vnk/w/VMvkuRWWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAcY+tZm2XzONBX8TIiG636R1vd/xdXPKkgSjZtIuSUJCSqEgty3j/CtXpKUlDtUJ9slTNVS7pCfUUaGquKOxLzuHdgfG032TLOL2Pvy9rWTvt7eYKlv3o37ikjJPFr2+xHLEE1HTWwN4BkLZCajX4/LH1GJmQmhPcsO6XY8fQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nKWlEey1; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813718; x=1776349718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nDlRIctq9sSTuK3XV/+XqLxDMgu+Vnk/w/VMvkuRWWQ=;
  b=nKWlEey13u/XGZznoc1mGLbRuiM6oNdsWTZPKbjq7iTmSGFB6nR4uuU2
   HVqxdiy5GslpqcB/NF7DfBTd7yDyE4jzA4WULNeFtK7B5X4YepDGb8hk4
   lwHnLrkiq39pP2AAj7Mpt/dFc3YdFgqqOe72nty63SPwPG7Ame51uUXpX
   MHP1qAM6OTs1sXu/JA/psTQYuAFJ+kWi2Q3V+3u2kYSyfjXK3AduE3OkI
   rhhNzM5oyFlJjylH0kXTH2XLLCubKsog+c8NvB3tvEkFxyyJkR8fiDnSU
   Nzgc6OKgbWGETobPvgpDwt56NhclMSw3Dd/Epr8KwSsUxDFLwImeWrhlB
   w==;
X-CSE-ConnectionGUID: vD5e5scKTt6XEt7+WZtOIg==
X-CSE-MsgGUID: aErMLORnSmOxhxT2el5WFw==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484524"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:32 +0800
IronPort-SDR: 67ffb082_H4s+/PR3a9EdG6OmmIGFWl0y+ljZjnbd3SifnEMqxK/JxXG
 X0/MvxKDMibwkMMcftUuUa5WO/gLUNoJ0kI/wBg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:34 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:31 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 06/13] btrfs: introduce space_info argument to btrfs_chunk_alloc
Date: Wed, 16 Apr 2025 23:28:11 +0900
Message-ID: <bf7314dc720dbeb1de64b95512cc796fdaba7ef3.1744813603.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744813603.git.naohiro.aota@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take an optional btrfs_space_info argument in btrfs_chunk_alloc(). If
specified, btrfs_chunk_alloc() works on the space_info. If not, the default
space_info is used as the same as before.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 19 ++++++++++++-------
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/space-info.c  |  2 +-
 fs/btrfs/transaction.c |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b700d80089d3..12cc9069d4bb 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3018,7 +3018,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 */
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
-			ret = btrfs_chunk_alloc(trans, alloc_flags,
+			ret = btrfs_chunk_alloc(trans, NULL, alloc_flags,
 						CHUNK_ALLOC_FORCE);
 			/*
 			 * ENOSPC is allowed here, we may have enough space
@@ -3047,7 +3047,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		goto unlock_out;
 
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	ret = btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
 	/*
@@ -3899,7 +3899,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
 
-	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
 static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
@@ -4102,12 +4102,15 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
  *    - return 0 if it doesn't need to allocate a new chunk,
  *    - return 1 if it successfully allocates a chunk,
  *    - return errors including -ENOSPC otherwise.
+ *
+ * @space_info can optionally be specified to make a new chunk belong to it. If
+ * it is NULL, it is set automatically.
  */
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
+		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	struct btrfs_space_info *space_info;
 	struct btrfs_block_group *ret_bg;
 	bool wait_for_alloc = false;
 	bool should_alloc = false;
@@ -4146,8 +4149,10 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
 	if (flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -ENOSPC;
 
-	space_info = btrfs_find_space_info(fs_info, flags);
-	ASSERT(space_info);
+	if (!space_info) {
+		space_info = btrfs_find_space_info(fs_info, flags);
+		ASSERT(space_info);
+	}
 
 	do {
 		spin_lock(&space_info->lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 36937eeab9b8..c01f3af726a1 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -342,7 +342,8 @@ int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
 			     bool force_wrong_size_class);
 void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
 			       u64 num_bytes, int delalloc);
-int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
+int btrfs_chunk_alloc(struct btrfs_trans_handle *trans,
+		      struct btrfs_space_info *space_info, u64 flags,
 		      enum btrfs_chunk_alloc_enum force);
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type);
 void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index a68a8a07caff..1dad1a42c9c1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4159,7 +4159,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+			ret = btrfs_chunk_alloc(trans, NULL, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index d6d33ab754ba..2489c2a16123 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -817,7 +817,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 			ret = PTR_ERR(trans);
 			break;
 		}
-		ret = btrfs_chunk_alloc(trans,
+		ret = btrfs_chunk_alloc(trans, space_info,
 				btrfs_get_alloc_profile(fs_info, space_info->flags),
 				(state == ALLOC_CHUNK) ? CHUNK_ALLOC_NO_FORCE :
 					CHUNK_ALLOC_FORCE);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 39e48bf610a1..670e0527996c 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -763,7 +763,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	if (do_chunk_alloc && num_bytes) {
 		u64 flags = h->block_rsv->space_info->flags;
 
-		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
+		btrfs_chunk_alloc(h, NULL, btrfs_get_alloc_profile(fs_info, flags),
 				  CHUNK_ALLOC_NO_FORCE);
 	}
 
-- 
2.49.0


