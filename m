Return-Path: <linux-btrfs+bounces-13079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E71CA90665
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16511744C7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9291EF39B;
	Wed, 16 Apr 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nIXMTTAr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED971DED4A
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813718; cv=none; b=se56HdhEn6CEH93wME+t8Mw98/4w7PjmcWE5rWzrjGrrmNjLkT9CHLKdfg1N0WPeW3DjXe4bjbzqc4wif/A4pbS36TVdUwX7CMm0tDcXN6uwvOXSwkwgMx8ukcHMufVYNe/Pxwa/lCcif8V38FP3NAcVYDLJQBf5EnJhYlhI6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813718; c=relaxed/simple;
	bh=1WOFkZFChn4tMIum2aOJxBG3IglU3PprRyVo+8t3a+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D3dtV7z8RIGGVKSJDUJhVuOAlL5Jtvb75O/HbUZFe6mUPYDICg5myK3YTiohWdBHs5dYw7nmosF71pSzYPtkOcRfS9n1HBM9yjbyuAVVZoA2D3qkhEU9ZYPf344CzFOVdpWHwwyOpVSSCf4arMymkwWd9gKScpiQTdEL79tcBKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=nIXMTTAr; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813716; x=1776349716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WOFkZFChn4tMIum2aOJxBG3IglU3PprRyVo+8t3a+c=;
  b=nIXMTTArrApslfBJy21hKbAzrociEcmlRWM+l84BdLRYUZ1yj08Rr9aj
   gE61Yhl6IJ+QiXEtj4NnevBA2x46/8zyKzuoQSTaw5SGTuLQjswScIcu9
   isastZn14F4WgvNs1OBzdfgz4M55fB+LAgwmoz/DMy2GbufIKKp7iS+Dp
   XC2k7M9PDbJUxwG2u+PJVPPhos8/Nllj2z36dcSkxoHqbDYXRynbl69Kn
   NTF27gUSnxsVGBi75WBwoVVZ1dwqyS63rWbKjZ2BuO9LnYxB/gXPQE9WV
   or5GQNAt7AVxnIfJBs2x/8n74N/0935TW3Sl4cDfThCoiTItQ50WhJUgz
   g==;
X-CSE-ConnectionGUID: pANJXq9OTGuIwppqTNUafw==
X-CSE-MsgGUID: KtWSJ9S+QcenY7CGYgYiWQ==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484521"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:30 +0800
IronPort-SDR: 67ffb080_UmWMfTQgtsPB2pW/FtKkAKml0pZ8fVJOTtXODtegSw4GVuf
 vxUNiUwP/wYzpx/W40qwCShZYPYL6oBAgUq2EZw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:33 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:29 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 04/13] btrfs: spin out do_async_reclaim_{data,metadata}_space()
Date: Wed, 16 Apr 2025 23:28:09 +0900
Message-ID: <65daa5055b3769c8c4078137cfae990b222c1107.1744813603.git.naohiro.aota@wdc.com>
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

Factor out the main part of btrfs_async_reclaim_data_space() to
do_async_reclaim_data_space(), so it can take data space_info parameter it
is working on. Do the same for metadata. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 45 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 7334ffa67a86..d6d33ab754ba 100644
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


