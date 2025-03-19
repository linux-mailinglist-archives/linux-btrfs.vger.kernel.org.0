Return-Path: <linux-btrfs+bounces-12405-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A56A684ED
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49023882069
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17A24EF82;
	Wed, 19 Mar 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CjSmwJIG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286793208
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364901; cv=none; b=aEtuL6OtCy8p390SGZR44HfjTr0LDyDEtiF2XpKhcf/rNTWEuQMAGpshK85xo3seay/ef5nWjlpjLlN3FCYI0n2vyIb4VfUbwexXTuURRck6EyWfDMv/3/8N3Urvb5epYnXnG6stlMFtZJQ4iFQuXMKYPb9vC3IyVwZn93LBGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364901; c=relaxed/simple;
	bh=d7tUZT9iUwp3BKUetm5BCLgw5hMdXI7emogdO88KCc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiFXYI9bo3RDiQfB/liOkYvTDuwOh0aA6snrBU7WRnw+lpmEY1Z+62mYZy/tsIjdfWpqYwdrfEaWTzPeKcuH0/PZZL7EbC+04fj2M7RhYKPqEGnaFDunub+mJI+yZFVamDuOvzIY9N+lTIGIPAO05s0jOCjFnpgJiBokW9IVvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CjSmwJIG; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364900; x=1773900900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d7tUZT9iUwp3BKUetm5BCLgw5hMdXI7emogdO88KCc8=;
  b=CjSmwJIG2E7+AcPIR7j22XjuwsWJAKvV1/TDVtCSLqvkTsEo0MVnUsgs
   /ZfunJB5WJmD06lBoE8KBw3YRfdMtoMUsOmda+ZUcT/B73T2Axe1qRPCv
   8l+vuFZG4EhUt9okuxBUcp2dMCxNHyXlgxuF5LR3oD7e1Owb4/+u2gXuY
   qj3Xp+mses85dS8s+SP3C0EDi2aRIoxyhIcR5OYVY/vucr5V7vaFQb+nH
   JbOjDPi+dRz8PVg0yRyt+m3ZGwZpAyZIgPCUYGGtmQqPgI7MwqYFJ7B5g
   FEuN95elutgfNKG9YOtBPK7CaUP60NOubN/vDylKSysZ8SVui3CNPRjZ7
   g==;
X-CSE-ConnectionGUID: 4t+w0Io1RiaLFahEJpR1hA==
X-CSE-MsgGUID: ydJQRVtmT0e1AwuUhGaTng==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227131"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:14:58 +0800
IronPort-SDR: 67da5302_rVS5/QjxNeiD8WqueKNzKhyA7SRkQzLW+lGX10oq5hF+/js
 EHQ2XL4Jimw3DhdbILk3bfKTVPk16T0pUQVKy1g==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:46 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:14:57 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 01/13] btrfs: take btrfs_space_info in btrfs_reserve_data_bytes
Date: Wed, 19 Mar 2025 15:14:32 +0900
Message-ID: <246f558df2b10e2c1efb34f0dd9e274e8d51af7f.1742364593.git.naohiro.aota@wdc.com>
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

Take struct btrfs_space_info in btrfs_reserve_data_bytes() to allow
reserving the data from multiple data space_info candidates.

This is a preparation for the following commits and there is no functional
change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/delalloc-space.c |  4 ++--
 fs/btrfs/space-info.c     | 10 +++++-----
 fs/btrfs/space-info.h     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 88e900e5a43d..e9750f96f86c 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -123,7 +123,7 @@ int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 	if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	return btrfs_reserve_data_bytes(fs_info, bytes, flush);
+	return btrfs_reserve_data_bytes(fs_info->data_sinfo, bytes, flush);
 }
 
 int btrfs_check_data_free_space(struct btrfs_inode *inode,
@@ -144,7 +144,7 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	else if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
 
-	ret = btrfs_reserve_data_bytes(fs_info, len, flush);
+	ret = btrfs_reserve_data_bytes(fs_info->data_sinfo, len, flush);
 	if (ret < 0)
 		return ret;
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ff089e3e4103..71c562e78b16 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1836,10 +1836,10 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
  * This will reserve bytes from the data space info.  If there is not enough
  * space then we will attempt to flush space as specified by flush.
  */
-int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush)
 {
-	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	int ret;
 
 	ASSERT(flush == BTRFS_RESERVE_FLUSH_DATA ||
@@ -1847,12 +1847,12 @@ int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
 	       flush == BTRFS_RESERVE_NO_FLUSH);
 	ASSERT(!current->journal_info || flush != BTRFS_RESERVE_FLUSH_DATA);
 
-	ret = __reserve_bytes(fs_info, data_sinfo, bytes, flush);
+	ret = __reserve_bytes(fs_info, space_info, bytes, flush);
 	if (ret == -ENOSPC) {
 		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
-					      data_sinfo->flags, bytes, 1);
+					      space_info->flags, bytes, 1);
 		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
-			btrfs_dump_space_info(fs_info, data_sinfo, bytes, 0);
+			btrfs_dump_space_info(fs_info, space_info, bytes, 0);
 	}
 	return ret;
 }
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index a96efdb5e681..7459b4eb99cd 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -288,7 +288,7 @@ static inline void btrfs_space_info_free_bytes_may_use(
 	btrfs_try_granting_tickets(space_info->fs_info, space_info);
 	spin_unlock(&space_info->lock);
 }
-int btrfs_reserve_data_bytes(struct btrfs_fs_info *fs_info, u64 bytes,
+int btrfs_reserve_data_bytes(struct btrfs_space_info *space_info, u64 bytes,
 			     enum btrfs_reserve_flush_enum flush);
 void btrfs_dump_space_info_for_trans_abort(struct btrfs_fs_info *fs_info);
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
-- 
2.49.0


