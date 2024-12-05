Return-Path: <linux-btrfs+bounces-10080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EABB69E4EF2
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC51881BF5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEA31CCB26;
	Thu,  5 Dec 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YBMTzkml"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FE1C4A13
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385031; cv=none; b=IRs6qjO2R3pdcYCWKf21rEXFvfO1JjGQJX2BREOiJO+uRCqoeDWRVBGdTqeLQwUum+kOQ3wFHL6sKMAarbQtRgcVnF9hSYYElc5VKFYiYG0Ou4JMCM17fP5z4NEiyMke2swaEbjP/AynHcV4zldxSoY0GjhXn2ayG8C1wnNcRMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385031; c=relaxed/simple;
	bh=VhoQsMWSlMKsnY+HDBm6j7DjgomzY8oFLNxDxXaiyN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLCXxL7aE8f6Ux4/n0f8tZXMfxpCzptaI31cwMMuWTr8ACiCylZ37kSyaxQ9dZilAemzAraAQOjfa5VdNIj8u6ehjmM6qC6rtC7t98EuXMjr5yf9nITUdTZ2TxiTxD9GY4GRc5FA+w0HkbI7/qy7hm0K3jFurPX8oahxSV5UKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YBMTzkml; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385029; x=1764921029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VhoQsMWSlMKsnY+HDBm6j7DjgomzY8oFLNxDxXaiyN4=;
  b=YBMTzkmlMKskNLKv002UqWl3VyoIEAnjSGJwmarlWJ19ZmLiS1XjY5XF
   D/CDppArFfyOnBZSNmp1F2flKBMkM21j+Wv89eYNY6ypBUbeC5k3LzyN1
   KhESAsZR1TyrjgMoMGnXwMA7h2bGtYBCIGz07GyEVkoJrzz5FmJaCb1Mx
   hqqRosVTTV6LgREYUy32/S62VVYSM5u5OzjAQdA9mrg8AhqvKrzT/ydT7
   vHVQsB8n3eSLEhImlept0HrFabLUCSKd5jDUTwxqGo0BKfwn2/VPv2pFh
   MWjNZButa/zEUrezLR0zklRfzGRjD9+lfjerSOSu9Rnt8R4/VHvNtnTNx
   Q==;
X-CSE-ConnectionGUID: 9W8coqWGRXuQEuONhddNYg==
X-CSE-MsgGUID: KdsZel5hQqaPy0RR7/u/Dg==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626112"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:20 +0800
IronPort-SDR: 67514c5b_qdirNMJa/HPXO+eO/cnOrfq8sW0bOObqcf3GF037uqyOeGg
 TU9YVeT+4uIxF3GYpt6XFbC3Czz+IIFWhODnNVQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:51 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:20 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 06/11] btrfs: introduce space_info argument to btrfs_chunk_alloc
Date: Thu,  5 Dec 2024 16:48:22 +0900
Message-ID: <57f3882377b6783592d3e13ca7c85ac19ac4f71c.1733384171.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733384171.git.naohiro.aota@wdc.com>
References: <cover.1733384171.git.naohiro.aota@wdc.com>
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
index 4b8071a8d795..ad78c8f1d381 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2985,7 +2985,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		 */
 		alloc_flags = btrfs_get_alloc_profile(fs_info, cache->flags);
 		if (alloc_flags != cache->flags) {
-			ret = btrfs_chunk_alloc(trans, alloc_flags,
+			ret = btrfs_chunk_alloc(trans, NULL, alloc_flags,
 						CHUNK_ALLOC_FORCE);
 			/*
 			 * ENOSPC is allowed here, we may have enough space
@@ -3014,7 +3014,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 		goto unlock_out;
 
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
-	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	ret = btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
 		goto out;
 	/*
@@ -3870,7 +3870,7 @@ int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
 {
 	u64 alloc_flags = btrfs_get_alloc_profile(trans->fs_info, type);
 
-	return btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
+	return btrfs_chunk_alloc(trans, NULL, alloc_flags, CHUNK_ALLOC_FORCE);
 }
 
 static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags)
@@ -4073,12 +4073,15 @@ static struct btrfs_block_group *do_chunk_alloc(struct btrfs_trans_handle *trans
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
@@ -4117,8 +4120,10 @@ int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
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
index 2f9126528a01..334a1701ff33 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4118,7 +4118,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 				return ret;
 			}
 
-			ret = btrfs_chunk_alloc(trans, ffe_ctl->flags,
+			ret = btrfs_chunk_alloc(trans, NULL, ffe_ctl->flags,
 						CHUNK_ALLOC_FORCE_FOR_EXTENT);
 
 			/* Do not bail out on ENOSPC since we can do more. */
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 1fb55655f49d..1d0f0c9d8956 100644
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
index 15312013f2a3..e5852316f0b6 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -755,7 +755,7 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 	if (do_chunk_alloc && num_bytes) {
 		u64 flags = h->block_rsv->space_info->flags;
 
-		btrfs_chunk_alloc(h, btrfs_get_alloc_profile(fs_info, flags),
+		btrfs_chunk_alloc(h, NULL, btrfs_get_alloc_profile(fs_info, flags),
 				  CHUNK_ALLOC_NO_FORCE);
 	}
 
-- 
2.47.1


