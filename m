Return-Path: <linux-btrfs+bounces-13268-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFF3A97CF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672C4189E506
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FD265CC6;
	Wed, 23 Apr 2025 02:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EdhmFqFo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88A265623
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376271; cv=none; b=fc9xgfZgm4CYU8f+wRDUSnXlZ05UshvXCh38j1CWHF56DaZ2/RXIbSqPJuoXifzVl35+o65juuZTH0fvD5B+fjaFOMQYQXwniKZ/eO3Spmq/Zkg1/dcK2M4eoatllIeD8N/R12XVhonYi0/8khvU7YBTok8x2QsV3XG2fDyxxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376271; c=relaxed/simple;
	bh=ZM69Souizdc62hECLH0Yu9xpWAGDjlG8mtwEmIu2xO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pBtkCtuGQhK6sTNMmtaHgMGsFJWnipYwLyVNNxnsm4HjaMYikxLoS5XPQsz0n6/GyDvfTpMvU1YYzXaHeVllEWkBrg1Uuium4lhmrja1YKWenyOtpHNo0HlhFPEydj08hZ8Jox+2BSjCs4aE++K7U3lG9mufjfzP9t7iaLGTkQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EdhmFqFo; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376269; x=1776912269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZM69Souizdc62hECLH0Yu9xpWAGDjlG8mtwEmIu2xO8=;
  b=EdhmFqFobHK1j3g7d5Iyow7b2APg8nSCG5OC3e+k2oj7WRg/Pkq2IJZd
   5lhEkunQCksnduGVrxigizAbC7/X0CjivNYf9GFfX6rPYB1Dp4G2yO08h
   npXR9UflbH9t6XnfJAN3YKfqcyMSWq9YrjNnH5Jb2Y0AsR+aYoloYk6B3
   mIP7POpXLZupxJrzbMNfsK6t8UembI8qVg9gzkNRhzFmNR4BKBuInO/yP
   12YrOvVffS/PVz/DLjIk+pJ8w0P1EhopEURM+OGe+MClO/2TP5H/YyIkA
   CenqlaI8DHjei9UHtOpYQ3Aqh0Yv+bW1YxPp5NnKJKT6ghPR/b3SfkLp1
   A==;
X-CSE-ConnectionGUID: riDC8rB8SByOd24j9GeYhA==
X-CSE-MsgGUID: o1qvgsuZTMOj0Uf2JDDp6Q==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011851"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:26 +0800
IronPort-SDR: 680845f1_deLsNdNlFPqmN72VsU6HMrm7oqzzr63uZ8+J5vvE9c3RfWn
 dnwMR1SjIm/n6xt0KGFAf3dILYU9ULgO8kqkYxQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:17 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:26 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 12/13] btrfs: add block_rsv for treelog
Date: Wed, 23 Apr 2025 11:43:52 +0900
Message-ID: <0d1f1bbcef250667f8a02e2da671b8d18e195ea9.1745375070.git.naohiro.aota@wdc.com>
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

We need to add a dedicated block_rsv for tree-log, because the block_rsv
serves for a tree node allocation in btrfs_alloc_tree_block(). Currently,
tree-log tree uses fs_info->empty_block_rsv, which is shared across trees
and points to the normal metadata space_info. Instead, we add a dedicated
block_rsv and that block_rsv can use the dedicated sub-space_info.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c      | 11 +++++++++++
 fs/btrfs/block-rsv.h      |  1 +
 fs/btrfs/delalloc-space.c |  7 +++++--
 fs/btrfs/disk-io.c        |  1 +
 fs/btrfs/fs.h             |  2 ++
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 3f3608299c0b..5ad6de738aee 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -418,6 +418,9 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_CHUNK_TREE_OBJECTID:
 		root->block_rsv = &fs_info->chunk_block_rsv;
 		break;
+	case BTRFS_TREE_LOG_OBJECTID:
+		root->block_rsv = &fs_info->treelog_rsv;
+		break;
 	default:
 		root->block_rsv = NULL;
 		break;
@@ -438,6 +441,14 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	fs_info->delayed_block_rsv.space_info = space_info;
 	fs_info->delayed_refs_rsv.space_info = space_info;
 
+	/* The treelog_rsv uses a dedicated space_info on the zoned mode. */
+	if (!btrfs_is_zoned(fs_info)) {
+		fs_info->treelog_rsv.space_info = space_info;
+	} else {
+		ASSERT(space_info->sub_group[0]->subgroup_id == BTRFS_SUB_GROUP_TREELOG);
+		fs_info->treelog_rsv.space_info = space_info->sub_group[0];
+	}
+
 	btrfs_update_global_block_rsv(fs_info);
 }
 
diff --git a/fs/btrfs/block-rsv.h b/fs/btrfs/block-rsv.h
index d12b1fac5c74..79ae9d05cd91 100644
--- a/fs/btrfs/block-rsv.h
+++ b/fs/btrfs/block-rsv.h
@@ -24,6 +24,7 @@ enum btrfs_rsv_type {
 	BTRFS_BLOCK_RSV_CHUNK,
 	BTRFS_BLOCK_RSV_DELOPS,
 	BTRFS_BLOCK_RSV_DELREFS,
+	BTRFS_BLOCK_RSV_TREELOG,
 	BTRFS_BLOCK_RSV_EMPTY,
 	BTRFS_BLOCK_RSV_TEMP,
 };
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index f7927657e036..62b608bea414 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -115,8 +115,11 @@ static inline struct btrfs_space_info *data_sinfo_for_inode(const struct btrfs_i
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	if (btrfs_is_zoned(fs_info) && btrfs_is_data_reloc_root(inode->root))
-		return fs_info->data_sinfo->sub_group[SUB_GROUP_DATA_RELOC];
+	if (btrfs_is_zoned(fs_info) && btrfs_is_data_reloc_root(inode->root)) {
+		ASSERT(fs_info->data_sinfo->sub_group[0]->subgroup_id ==
+		       BTRFS_SUB_GROUP_DATA_RELOC);
+		return fs_info->data_sinfo->sub_group[0];
+	}
 	return fs_info->data_sinfo;
 }
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1541fd19d5ce..5286c25f3429 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2823,6 +2823,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
 	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
+	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
 	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
 	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
 			     BTRFS_BLOCK_RSV_DELOPS);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index bcca43046064..0d5af9732a3c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -471,6 +471,8 @@ struct btrfs_fs_info {
 	struct btrfs_block_rsv delayed_block_rsv;
 	/* Block reservation for delayed refs */
 	struct btrfs_block_rsv delayed_refs_rsv;
+	/* Block reservation for treelog tree */
+	struct btrfs_block_rsv treelog_rsv;
 
 	struct btrfs_block_rsv empty_block_rsv;
 
-- 
2.49.0


