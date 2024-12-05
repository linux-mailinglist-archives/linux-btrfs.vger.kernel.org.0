Return-Path: <linux-btrfs+bounces-10075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCE9E4EED
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3311881BED
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C551C3F36;
	Thu,  5 Dec 2024 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qNH+yyTz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72D1C07C0
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385027; cv=none; b=bfqv+kNIlpWnlGQ35Ihy6zNkqLYk/v8+61FLNHfodszTMhJarhi6Y4d5mfToVg4Vd7OEwMyZ8GX23l2zNxiEIRdI3mpCgq6GF8iB2aV4Ivl/NI4hEBrvrAYJzyhtRXthCX8HiwqBzJPvcE4lA7/prEFD9/T4a7v2KmEHUIja0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385027; c=relaxed/simple;
	bh=YjjDeHf+w8o96lOUWoaiRELiQqsiRMvqrYboslEmP1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sAXqyI6Bsfz7dW13FpqddO/LsmeTHhNqFrJe4ong/dQp11qjiYiloy6bTPB+p47a37l6xb3IxGaxB0nsxAe9X+B2ArC81GTwMmy7lY8ES+d0doYhW/v8L04iQSH5d3x5VgK7hbXZeRai6TrcXqxhzXkzSRRsRJHH4gOUwCYWTQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qNH+yyTz; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385025; x=1764921025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YjjDeHf+w8o96lOUWoaiRELiQqsiRMvqrYboslEmP1c=;
  b=qNH+yyTz0q6rx90aqVi5VLOW2k61pLKJYD7tIxCk5IZZXTW3I8NsvEM9
   fyhKZgUfZXOoK9tJUfysc68rHM8rnzEl6nh6HqhbSj1qKEeX6K10EjBbQ
   PbesczejT45GX4uIJSD0hoK5JOnW316fUNRtsS/QD27yBvzKOrjbE0Akh
   6jpbY6PeqeyQx4UtcQkd2/zeIbILXgpA6qeWuErUDWqoYRLNQFvtddCqk
   Quyb4x1f27jx27fMfsDhDpAm++EjJ33W6NyTk3dgtKTWz+rBgPdhjkXOm
   l5uJ8YHyxXDRmO9oIWEv3UdspN8wheb8b7eSJ1xOh6wBXSwKnwDof7+IA
   w==;
X-CSE-ConnectionGUID: ongSMWW2SrCd63shs5xAlQ==
X-CSE-MsgGUID: /vRgEzn7TP2yss9gaWdchw==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626100"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:16 +0800
IronPort-SDR: 67514c57_6LA2j008VhpWlEq7qvSByj57VIpBlx0DfUTgO0hwWHW2peK
 h1KnLX4nc9mfdyoLJ1CsPHKYXlV/bFgEU5qRFQA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:47 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:16 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 01/11] btrfs: take btrfs_space_info in btrfs_reserve_data_bytes
Date: Thu,  5 Dec 2024 16:48:17 +0900
Message-ID: <c6184ce683ff003641bc7177ba958121156461d7.1733384171.git.naohiro.aota@wdc.com>
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

Take struct btrfs_space_info in btrfs_reserve_data_bytes() to allow reserving
the data from multiple data space_info candidates.

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
index a341d087567a..2c07871480b6 100644
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
2.47.1


