Return-Path: <linux-btrfs+bounces-13257-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70057A97CE7
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804ED189E377
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2412D264619;
	Wed, 23 Apr 2025 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dez+yVTW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84512262FD3
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376264; cv=none; b=JlsiRgDeZURz4ZUWwytxDWSzER+87oYTTChtYUp4kXXASWJkpUTufgzeR625PGlx2Y2F6A59zl9UJOIvbffP4WxQnkpzRBYltAu6qEKQqAk0KKxuwjrysLvrcI3u4JKFM0hB/WOUw98qKp43Muwp4pWLh/RL4//mCk3RIaGrIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376264; c=relaxed/simple;
	bh=CNxn5T8cyv3QVZhRb5fWxLVPWjCkLrC3RSqjgxC1a5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZPs1pKB9ZVUaaTRr8dwjEh6WP++sumd1jZtnLGGgis1VKTl6XJSQlvGKlPyHQBjS6/d9XBK347PH3fIUmBCrSYe6mIxN8orsA81KDp46HKSKNijNm1YK8T/zJsP+7yjJL6F7X0XzNEKWPcclMg8c9c0/tmQq3LnxZzgnKEqV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dez+yVTW; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376262; x=1776912262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNxn5T8cyv3QVZhRb5fWxLVPWjCkLrC3RSqjgxC1a5M=;
  b=dez+yVTWUJrBzHlmNdA8guD0EXECrvzkRPuvI58oDo6Vviks5yRbHKOp
   g8pl5Banie9zh/xAJZGPOppB5SQQbMZ0rkWyYIg6HnIEK9ZCXySQrVty5
   SzrUSClbq97wDOX/1FvjXUXKyRpQinsClDQP54V/kefipxXcKSJnGwZp9
   WRMjshphpB1k+cUC0oh+HroSspsOVJUsGlxOj6jzMGkdXwnm3DfyZGiib
   Ar+c+OTONjawYRjMjjlCVu+qpfGaCWInfnQRMcPqdFQNjcv2LNIjj4jg3
   Vhtc89hkFxG7rgP0XZ5ImsjOFElijmEnTfBHhS00QxOx8/pLfkP+woNcO
   g==;
X-CSE-ConnectionGUID: nXYgU74IRMq0gVI2unS8JA==
X-CSE-MsgGUID: RzlEb9/EQCSooFa8ztt3wQ==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011832"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:15 +0800
IronPort-SDR: 680845e7_HVqkNtHoOhkF7bnjUpn15nfgXKZNKUbeC3sbMzrBMB9prnx
 grP9+HyhpWVjcEm5g22M1wCYicio5I8oSgIgKQA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:07 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:15 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 01/13] btrfs: take btrfs_space_info in btrfs_reserve_data_bytes
Date: Wed, 23 Apr 2025 11:43:41 +0900
Message-ID: <6136fc13daa48d66961f7f7494dc05e8fb1dd1e1.1745375070.git.naohiro.aota@wdc.com>
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

Take struct btrfs_space_info in btrfs_reserve_data_bytes() to allow
reserving the data from multiple data space_info candidates.

This is a preparation for the following commits and there is no functional
change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/delalloc-space.c |  4 ++--
 fs/btrfs/space-info.c     | 10 +++++-----
 fs/btrfs/space-info.h     |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 1479be2427cb..c7181779b013 100644
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
index 77cc5d4a5a47..3bb7246f40fa 100644
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


