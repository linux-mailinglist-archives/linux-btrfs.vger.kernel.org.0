Return-Path: <linux-btrfs+bounces-12408-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9F4A684EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28D288170A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DDA24EAAC;
	Wed, 19 Mar 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Lvw0GM9F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39524EF74
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364903; cv=none; b=qBxf4faAwfpU5cWfkHlo1gNVNSBMhOSHX1sQY9JTm3y9BKMmKw1ia3EWvMSdVEl7k0sIgdO+cJcNudO6DIKvJWdkskTHSqfHu0ejrwf4z5bLbCULmFeV72qthrbfrq4Mt4CkyKaCWh89qzx2zBKxLyBNFjp+WM0U/ea3YSF+He4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364903; c=relaxed/simple;
	bh=3Og5b8Jz9omO7bsj8HKjX4RYvUW9aHrQNzJXh18Y430=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZuZBa2M6miscrkJIAh1jNj+GfSRmy2wAvKnNyY6X7zK1RK6ZEuWnwFke1l9umzBxF7RrFMQ+tGMqyXdAxVSKWFILyen+zmtBg74Bf3A6iKSUBiNE2/umIqip0ubFVmgUHW0PPd7U8JqLdSRpm/XQO6p8fPcsdhtzoFYRHmfEt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Lvw0GM9F; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364902; x=1773900902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3Og5b8Jz9omO7bsj8HKjX4RYvUW9aHrQNzJXh18Y430=;
  b=Lvw0GM9FUg5dA83Unpd0VtguybSFYgU2zG92P5WZRt4qW3QURJuiFPjd
   wQuvXuf2qJxd5n5b19zF1rYBUvjyik7Gy0ZAaEofzEgyz5gI3/xF7xGY9
   GDc9PnoA6zXqSljpq8mcfWhfpuqhtcLC/ZfQLAVzjSEzLoUROCbEYZN6M
   cASqYo/Yz5B6AI7G1i5iwapK0zBbkbCCMxWdOEtNo293imObZetm74ReA
   p2cCQEOYCwV98F24cypsj/jWxu8jdsShGsSUajp/hBAcG7/jnr+enEts5
   ytSxHQoXFqN/kGr+NCs1eGI/hivAjfvIxchPviW6qRFCcKQdkdOyP9zKv
   g==;
X-CSE-ConnectionGUID: jmMm8ZCRSvSSwE+I79rKrg==
X-CSE-MsgGUID: soFYq4xwQ2uXviwjTvSvZg==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227243"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:01 +0800
IronPort-SDR: 67da5305_LqyTzZgSe0YW2GBCLM5XWIiHVzoDYSoJWty5oe5+TIQGEjH
 OLhFQnbBm2GUiBw5FspCMVd5scb6Bcpti6w4rmA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:50 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:00 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 04/13] btrfs: spin out do_async_reclaim_{data,metadata}_space()
Date: Wed, 19 Mar 2025 15:14:35 +0900
Message-ID: <acc94e2e3af2f5bdf59ed6c86de3a156e4e33b8e.1742364593.git.naohiro.aota@wdc.com>
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

Factor out the main part of btrfs_async_reclaim_data_space() to
do_async_reclaim_data_space(), so it can take data space_info parameter it
is working on. Do the same for metadata. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/space-info.c | 45 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 60f76afc5fe9..3982c0300640 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1088,23 +1088,15 @@ static bool maybe_fail_all_tickets(struct btrfs_fs_info *fs_info,
 	return (tickets_id != space_info->tickets_id);
 }
 
-/*
- * This is for normal flushers, we can wait all goddamned day if we want to.  We
- * will loop and continuously try to flush as long as we are making progress.
- * We count progress as clearing off tickets each time we have to loop.
- */
-static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
+static void do_async_reclaim_metadata_space(struct btrfs_space_info *space_info)
 {
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_space_info *space_info;
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 to_reclaim;
 	enum btrfs_flush_state flush_state;
 	int commit_cycles = 0;
 	u64 last_tickets_id;
 	enum btrfs_flush_state final_state;
 
-	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
-	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	if (btrfs_is_zoned(fs_info))
 		final_state = RESET_ZONES;
 	else
@@ -1178,6 +1170,21 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= final_state);
 }
 
+/*
+ * This is for normal flushers, we can wait all goddamned day if we want to.  We
+ * will loop and continuously try to flush as long as we are making progress.
+ * We count progress as clearing off tickets each time we have to loop.
+ */
+static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *space_info;
+
+	fs_info = container_of(work, struct btrfs_fs_info, async_reclaim_work);
+	space_info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	do_async_reclaim_metadata_space(space_info);
+}
+
 /*
  * This handles pre-flushing of metadata space before we get to the point that
  * we need to start blocking threads on tickets.  The logic here is different
@@ -1323,16 +1330,12 @@ static const enum btrfs_flush_state data_flush_states[] = {
 	ALLOC_CHUNK_FORCE,
 };
 
-static void btrfs_async_reclaim_data_space(struct work_struct *work)
+static void do_async_reclaim_data_space(struct btrfs_space_info *space_info)
 {
-	struct btrfs_fs_info *fs_info;
-	struct btrfs_space_info *space_info;
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	u64 last_tickets_id;
 	enum btrfs_flush_state flush_state = 0;
 
-	fs_info = container_of(work, struct btrfs_fs_info, async_data_reclaim_work);
-	space_info = fs_info->data_sinfo;
-
 	spin_lock(&space_info->lock);
 	if (list_empty(&space_info->tickets)) {
 		space_info->flush = 0;
@@ -1400,6 +1403,16 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	spin_unlock(&space_info->lock);
 }
 
+static void btrfs_async_reclaim_data_space(struct work_struct *work)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_space_info *space_info;
+
+	fs_info = container_of(work, struct btrfs_fs_info, async_data_reclaim_work);
+	space_info = fs_info->data_sinfo;
+	do_async_reclaim_data_space(space_info);
+}
+
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info)
 {
 	INIT_WORK(&fs_info->async_reclaim_work, btrfs_async_reclaim_metadata_space);
-- 
2.49.0


