Return-Path: <linux-btrfs+bounces-13259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104A9A97CE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88EF07A7050
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD377264A86;
	Wed, 23 Apr 2025 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hGvSHN+T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C11F4CB6
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376266; cv=none; b=i8d6tS8oLRfAAfYjdSgcw47DWk9WvuoHGhcLttLV18J0QK8/fqHIvnTIAcGHeuE5fvpzegfCzDKy3FPoiUOoyMyZ1tJisljOWkr4fMSdEKV92frgOf/LqB3WvqnHDyuSDjF8x3DV/iKRSBulgyT2JHFBVoCNCvw+zeomC7aHbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376266; c=relaxed/simple;
	bh=1WOFkZFChn4tMIum2aOJxBG3IglU3PprRyVo+8t3a+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPkqFrx2/qDQSzqsjm1EJcMRDY5j3znt8M0ShsVaKKXQzCVDRzopjDTvHMyOlGD9SXZMM3BkqSY0bJ8vBwVVZk8JbNF1DnHd0snvMPqnWyiDHDgZHHCkrxez/0s5+g0mVHUMMRRnWrpecv+aLjVxaiYBtNUagfR9c7Z5GNdBei8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hGvSHN+T; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376264; x=1776912264;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1WOFkZFChn4tMIum2aOJxBG3IglU3PprRyVo+8t3a+c=;
  b=hGvSHN+T3z0Jxauu+9QJN0ZSEkSS5roaR1giMTUeeTpuyHUCZnhkhTKG
   aH9zzmoy9PyZuWoStYBsgEFAlaJJ42RWmqQTX84N8hHwr7S4qABukRoTk
   4YBV0hnc8d6SVIhsFQz1VWXn2eqNfD/fXcC6LVPtAXWmbdIhLE+EZGUT2
   kxgEepjJ236KKkShUqJQlmLQ+AZ4uqC41lxkX5aCcl0qxfJ4mFcKKTu2a
   QHW+5j/5JUb7Og8i5AJkYiITYXuBmVyY0KfcXxHyiDt+PKgjydnZqJLoB
   u672c0BADRSmM64JcR+W/H59HY1WDzIW4oIEkDARdUgrzEEQGaXaT4DFd
   w==;
X-CSE-ConnectionGUID: eWlsYqWuT4elorisOFvY/g==
X-CSE-MsgGUID: Jo7w/cSyTPWbnTRrn9mcdA==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011837"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:19 +0800
IronPort-SDR: 680845ea_+CvrhrK03CqdCmfw838qdBLUIqMmSEUhyEDHTJqi3e+2049
 gG847UVvCQ/43l+oORuw/ai28SdB7z0wc8BtOSQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:10 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:18 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 04/13] btrfs: spin out do_async_reclaim_{data,metadata}_space()
Date: Wed, 23 Apr 2025 11:43:44 +0900
Message-ID: <5d6b43e907a8ae133eddda7cd7457ce85474c6d7.1745375070.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745375070.git.naohiro.aota@wdc.com>
References: <cover.1745375070.git.naohiro.aota@wdc.com>
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


