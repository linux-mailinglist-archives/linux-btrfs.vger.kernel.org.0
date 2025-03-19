Return-Path: <linux-btrfs+bounces-12410-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2E5A684F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DE9A425AF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E5724EF63;
	Wed, 19 Mar 2025 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hOHgtvV6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5224EF70
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364905; cv=none; b=kOoE7oC5dvTjlMRzVrl6rOS2J2fuJi/INdodKYe9vDNKMpvQ1pafiJMRnSMycp+sh+oylTW7yEEm3jwVh1qTqTq3CzzHAkx2LanEB68XNSc7pqewQIMvFr+vM6//MQ0Zmp7ATCBTk1taso+PvsdVJ52VXlwg162shMR/CKSiv2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364905; c=relaxed/simple;
	bh=92eV0uk5DRe47AyGTfcmgv5zzaozrTPrOGSODqpWdEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8Q0he/zJEL0GQYjQTZ6UdnfhFx0U/kWzRdl+VHdcK2eGPaFfV4+Lau2KdLLxqKiLLajn5q04Xz+w2nbcX6susewsRaPOpzG80XZTS+EnOWO55/GqJCKFpVwkZmLNeIxHHiA4+qmeYy10hy6tlw1I3rmqeSn1XFY2peD5mP+9jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hOHgtvV6; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364903; x=1773900903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=92eV0uk5DRe47AyGTfcmgv5zzaozrTPrOGSODqpWdEE=;
  b=hOHgtvV67jCM0ZQI/zZYeTHsVWrJMX/sWlG+9ZKf9ilq3dExXdj4oUfW
   Od6yaTs5oYPGY/WbVLICsCstl0iIAmIqW/ywJpRAcKr0xhuZOC6mHebio
   /4Q2gJ1rtQrcV4Zrg9uz0agu3fix7m0cr7TXL6evW7LJNs6QAbhRItWCx
   6ymqn0Vt5rAQKu6DfNiCifJekUl6MgJu/RyNubQgraXu25oCfEYNrP4gy
   OREYkp2Wmijz88PQBTK7tqpESpheEFC0mMgbymZ4qOBJOLSTbBZrZ7xt2
   XowYaTb/sEr/Ml8+SGqUFmvYOO/HzBD/0VchhfZeSN+otSypRd+pywR1E
   Q==;
X-CSE-ConnectionGUID: krg0oQleQROdGCT+f03jIg==
X-CSE-MsgGUID: qvDT8dfJRKm3DpqcxhhAIw==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227251"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:03 +0800
IronPort-SDR: 67da5307_rNtlL+SvKaPMGEWSVBhK4YM5WiSZ84XcEYiDhiKI+4BayXF
 knsWo7rbbw3Kiq/9/Wgq2q1RA5BO4VrXBX74S1Q==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:52 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:02 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 06/13] btrfs: introduce space_info argument to btrfs_chunk_alloc
Date: Wed, 19 Mar 2025 15:14:37 +0900
Message-ID: <cab0fc0b6199100cf9c740a8ceb205bbbdcffa74.1742364593.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1742364593.git.naohiro.aota@wdc.com>
References: <cover.1742364593.git.naohiro.aota@wdc.com>
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
---
 fs/btrfs/block-group.c | 19 ++++++++++++-------
 fs/btrfs/block-group.h |  3 ++-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/space-info.c  |  2 +-
 fs/btrfs/transaction.c |  2 +-
 5 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b0e0b4251f36..fa08d7b67b1f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3020,7 +3020,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 */
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
-			ret = btrfs_chunk_alloc(trans, alloc_flags,
+			ret = btrfs_chunk_alloc(trans, NULL, alloc_flags,
 						CHUNK_ALLOC_FORCE);
 			/*
 			 * ENOSPC is allowed here, we may have enough space
@@ -3049,7 +3049,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		goto unlock_out;
 
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	ret = btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
 	/*
@@ -3901,7 +3901,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
 
-	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
 static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
@@ -4104,12 +4104,15 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
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
@@ -4148,8 +4151,10 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
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
index 957230abd827..062f860ec379 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4165,7 +4165,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+			ret = btrfs_chunk_alloc(trans, NULL, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3982c0300640..c421161f4237 100644
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
index f26a394a9ec5..ae6ee8b91d71 100644
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


