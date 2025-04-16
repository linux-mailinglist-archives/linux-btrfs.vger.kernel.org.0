Return-Path: <linux-btrfs+bounces-13088-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B71CA9068E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD90C8A6532
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458F1FDE01;
	Wed, 16 Apr 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HKUonaj4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DE21FDE12
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813723; cv=none; b=hCEzFge/a2uSLJj9CC+ZxKCYgsCGlWhMlhKxZEK8xfE5NBLCehUwmQZRa6IR3y1oCPQhaW+ewKxt/GRCW4GPfkGwOhobCSpeIjLtnvA2m7nPOavJYByM4LAEUQaQCl3dPHFVBHAzpvSVIWrxtkFJAlciyZFF+cOc1JdZraQqnSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813723; c=relaxed/simple;
	bh=UBfgXN6gBLlaw65UBgmlXeVKmrb3MPa206NgHYolr+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdnVBPqZKMTedlZIF8rpFk/9tdT3iibfuyuL/TdzVHgcg1wSZMnccq1bZ+d50ixtKMApAS6NYgY1pvdII4+cdDBUTFWA9XTbeEB9wjw5d07IsR+fyexuViu6wumLPqtGrORX8R+UmvA26Tms1H8lksGyLZ8NsUqtShVcwcR2Fwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HKUonaj4; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813721; x=1776349721;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UBfgXN6gBLlaw65UBgmlXeVKmrb3MPa206NgHYolr+A=;
  b=HKUonaj4oyuAi1muEgWXMsF/E+Zu4qZfR074U4nCNOf3NIQVx8FQ6u+I
   Ux6OzxcXreu0KarY8htLzpDpPKC6UpZulbd/2SZAbpCax7a2V4Xi4EyHw
   eeLu66ZfIMvZG2XDpz1Wa/qJeegqC6JByIQkJOzQMs+ckD9SAXK0o02Eq
   Y2ZSfGoTJSmXaVS/SKq9qcSKg6hxYp27SDvj7F1SLvCUJoOCG7lBfz5Oc
   ZHu4uWrQ5UQyeFBZU0qJI0fiB2EeH1d656YMs1t+3cqNtJ2mSJt3C+SUG
   VpzaGpmFRAci2NhH3ohepM+MeGv1UU1uvGmE0u1oES0vCLVLgJmRwJxMR
   w==;
X-CSE-ConnectionGUID: jXMxEkEYQWOdYgdGsU5V7Q==
X-CSE-MsgGUID: B+cUkyUaSc2gvatRYrfVyw==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484534"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:36 +0800
IronPort-SDR: 67ffb087_GFxkiMpUzigolI/mO+HDI5gh8NvvJhvOumb8mid+3HyCBPs
 8O92SxCvHlFQ29B5jJ/I0CNp4g1WEfFJ3RmOm8w==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:39 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:36 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 12/13] btrfs: add block_rsv for treelog
Date: Wed, 16 Apr 2025 23:28:17 +0900
Message-ID: <3a317ad692057695d49cd8428ed660f551eb759b.1744813603.git.naohiro.aota@wdc.com>
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

We need to add a dedicated block_rsv for tree-log, because the block_rsv
serves for a tree node allocation in btrfs_alloc_tree_block(). Currently,
tree-log tree uses fs_info->empty_block_rsv, which is shared across trees
and points to the normal metadata space_info. Instead, we add a dedicated
block_rsv and that block_rsv can use the dedicated sub-space_info.

Currently, we use the dedicated block_rsv only for the zoned mode, but it
might be somewhat useful for the regular btrfs too.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-rsv.c | 12 ++++++++++++
 fs/btrfs/block-rsv.h |  1 +
 fs/btrfs/disk-io.c   |  1 +
 fs/btrfs/fs.h        |  2 ++
 4 files changed, 16 insertions(+)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 3f3608299c0b..680b395b32ad 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -418,6 +418,12 @@ void btrfs_init_root_block_rsv(struct btrfs_root *root)
 	case BTRFS_CHUNK_TREE_OBJECTID:
 		root->block_rsv = &fs_info->chunk_block_rsv;
 		break;
+	case BTRFS_TREE_LOG_OBJECTID:
+		if (btrfs_is_zoned(fs_info))
+			root->block_rsv = &fs_info->treelog_rsv;
+		else
+			root->block_rsv = NULL;
+		break;
 	default:
 		root->block_rsv = NULL;
 		break;
@@ -438,6 +444,12 @@ void btrfs_init_global_block_rsv(struct btrfs_fs_info *fs_info)
 	fs_info->delayed_block_rsv.space_info = space_info;
 	fs_info->delayed_refs_rsv.space_info = space_info;
 
+	/* The treelog_rsv uses a dedicated space_info on the zoned mode. */
+	if (!btrfs_is_zoned(fs_info))
+		fs_info->treelog_rsv.space_info = space_info;
+	else
+		fs_info->treelog_rsv.space_info = space_info->sub_group[SUB_GROUP_METADATA_TREELOG];
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
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 59da809b7d57..88dbda24ad46 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2822,6 +2822,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
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


