Return-Path: <linux-btrfs+bounces-9631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64A9C848B
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 09:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBDB8B23924
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 08:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CF71F7087;
	Thu, 14 Nov 2024 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MH3sgjUs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2AF163
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 08:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571486; cv=none; b=DeQwXBbK5k6i0WaYu0Nrw/gLxTZbSkbfI9dZ3QA72LOJWz0/NZ8RhFb0bq+197uz08wpEs7BDHczQvaH4NdwvW6qlPI/whWw3/HVRrldvEA5i+Xfj8xYm/RRjXSZ5prpU+PjacHhQPKA6yiDHwNGYWOVvIcsDYX9nZhMmqx6jMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571486; c=relaxed/simple;
	bh=8Ouzb4E8uaeyT8WcHy1CYAR5KmZHhOFOlwP8qUO+sO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHKmgOYOApwlA9xJyTOtetwhYzw2A2bqiGRzSqt0bkzRCcXtyWB56ExbBHa4nTTwKapQLMl7es8anFmasi53LpmtQSF4ls38ogUVs8YO2PpM3IZZJEx3RpPWOyOVmZ8SzpYay6FFPdN2WuCh+nR9EozAgbm7ftBoAX1eIy0ywy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MH3sgjUs; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731571485; x=1763107485;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Ouzb4E8uaeyT8WcHy1CYAR5KmZHhOFOlwP8qUO+sO8=;
  b=MH3sgjUsXTtkfk9ERmWcG//z7zVpfsQBIvRGuRcjQvQMbRMqZl00ZfIv
   jnr13Gj2CI3NFZRhb4SLPwHzs8jkrhyrIQv8mbwU6I4N4x860uwbQwiu4
   BCrysrDhhErc37wfXTi9abcmCSr+Sjs3JeGozsBcUz1LtMD4lnbDaF4gL
   DwfjclpKm1/DbH5qJ57El3+J5+4VQsavQbHXUzhViKbdUqXbymbgfGt1s
   kcqw6BYcFjdoDQIhbjlAQb7qbcgG7hVirgItyzXbmNqWUcKhceFhzm19Y
   BCDGxf5c4U6tguExRB2eaIDBoHrdGeKfs5Mrq6Kr8aasw1YpbAQYD5nXf
   A==;
X-CSE-ConnectionGUID: OD8Od+lMQw+NyJBdVvAWQg==
X-CSE-MsgGUID: gx1ChyehRNSQe1/FCNAHTA==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="31543757"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 16:04:43 +0800
IronPort-SDR: 6735a1d9_bDNtDp3+RqbGwypPcQ/pf1fAIxqspIXQevKZNgaj4oUnc7T
 N+zAFbfOUvn3QlQ/8fxA8r4CZiI1/Hdlefw6wtw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Nov 2024 23:08:10 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.24])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2024 00:04:42 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] btrfs: introduce btrfs_return_free_space()
Date: Thu, 14 Nov 2024 17:04:27 +0900
Message-ID: <8848f10974bbbf4dc2618c606ee71ee0142b2bbe.1731571240.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731571240.git.naohiro.aota@wdc.com>
References: <cover.1731571240.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit factors out a part of unpin_extent_range() into a function for
the next commit. Also, move the "len" variable into the loop to clarify we
don't need to carry it beyond an iteration.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c | 25 ++++---------------------
 fs/btrfs/space-info.c  | 29 +++++++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  1 +
 3 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 412e318e4a22..ce7c963dd0a6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2724,15 +2724,15 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_block_group *cache = NULL;
 	struct btrfs_space_info *space_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_free_cluster *cluster = NULL;
-	u64 len;
 	u64 total_unpinned = 0;
 	u64 empty_cluster = 0;
 	bool readonly;
 	int ret = 0;
 
 	while (start <= end) {
+		u64 len;
+
 		readonly = false;
 		if (!cache ||
 		    start >= cache->start + cache->length) {
@@ -2790,25 +2790,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			readonly = true;
 		}
 		spin_unlock(&cache->lock);
-		if (!readonly && return_free_space &&
-		    global_rsv->space_info == space_info) {
-			spin_lock(&global_rsv->lock);
-			if (!global_rsv->full) {
-				u64 to_add = min(len, global_rsv->size -
-						      global_rsv->reserved);
-
-				global_rsv->reserved += to_add;
-				btrfs_space_info_update_bytes_may_use(fs_info,
-						space_info, to_add);
-				if (global_rsv->reserved >= global_rsv->size)
-					global_rsv->full = 1;
-				len -= to_add;
-			}
-			spin_unlock(&global_rsv->lock);
-		}
-		/* Add to any tickets we may have */
-		if (!readonly && return_free_space && len)
-			btrfs_try_granting_tickets(fs_info, space_info);
+		if (!readonly && return_free_space)
+			btrfs_return_free_space(space_info, len);
 		spin_unlock(&space_info->lock);
 	}
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 255e85f78313..93818339a9a9 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2082,3 +2082,32 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 			do_reclaim_sweep(space_info, raid);
 	}
 }
+
+void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+
+	lockdep_assert_held(&space_info->lock);
+
+	/* Prioritize the global reservation to receive the freed space. */
+	if (global_rsv->space_info != space_info)
+		goto grant;
+
+	spin_lock(&global_rsv->lock);
+	if (!global_rsv->full) {
+		u64 to_add = min(len, global_rsv->size - global_rsv->reserved);
+
+		global_rsv->reserved += to_add;
+		btrfs_space_info_update_bytes_may_use(fs_info, space_info, to_add);
+		if (global_rsv->reserved >= global_rsv->size)
+			global_rsv->full = 1;
+		len -= to_add;
+	}
+	spin_unlock(&global_rsv->lock);
+
+grant:
+	/* Add to any tickets we may have */
+	if (len)
+		btrfs_try_granting_tickets(fs_info, space_info);
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index efbecc0c5258..4c9e8aabee51 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -295,5 +295,6 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool
 bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
 int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
+void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.47.0


