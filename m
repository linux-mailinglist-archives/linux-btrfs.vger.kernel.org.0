Return-Path: <linux-btrfs+bounces-12415-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D072DA684FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C5426204
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099FB212D96;
	Wed, 19 Mar 2025 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HpQVREOU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC252500BA
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364912; cv=none; b=sJjVaY1QelGzpKxqx0+kr1hNAaSiAo2j20sensIPhgi92ZL6F6T+2wrepY2wFxxY72XXFw58T3+LryxLe1VLahXb6CLX8vKO5md2gifv7skKYhZq6JRAqtd1HKlAwbFQTplou96WwfdZYeem5j/FfyrVafnhb2E5A3s+b7g/UG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364912; c=relaxed/simple;
	bh=LKFnztNMIkuZx7GqSHh072tyo+d3HXkaVRG0AqrvyVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEdV7XqAIDoZkwb7Jhmw5DoaLW4v6foQkDyuEHDVSce+ACZTcTfXq0JXZPdwXDXhKMCCVonQuyi59EAKbTyN6Ex49vqqGhh4crAjtagUScQfGWhSzCZDG83X3ssaa2bvtwvsp/sKJrm6cW76bvFKkHFqiv+YokDVv7qc7tpa15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HpQVREOU; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364910; x=1773900910;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LKFnztNMIkuZx7GqSHh072tyo+d3HXkaVRG0AqrvyVU=;
  b=HpQVREOUmMW/uDrc1j6+eE1+XfFAawUePZsqTk+lKcCitApTOB/exRsm
   ftWbSK7KWjgX/ypdlgpMy+Ni1SyqJyWqnMLTiLRitAZGfIdK8Jm5rHnsf
   M0BBRG25ZTIGMqt+nSpwbWSVVY5DQR6NwKEWcjVh2To6zjXgGHtmkZ6Lp
   NPk1b0t6oBCn7I/Ae0jvMJzEXWpWjcedg6ZrHKER53H0pCsPPTOLp9vg5
   JSVmiKjtxveqjl0PW5zHHPY5hkWvdMWOioP1wb6r2MOMatLICJSHoJ2Pw
   S6jZGBiIIFd/veNoRfN2Xs4DaRf3qVIsz2zJDT4MNYeonCwfoiFr/GIIE
   g==;
X-CSE-ConnectionGUID: dKbDhUFeSgekUsXkAneLZA==
X-CSE-MsgGUID: qEK0u/mwTDq++UMQ60sexQ==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227280"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:09 +0800
IronPort-SDR: 67da530d_V90RFpjQyK77jbBHawqIOTCw9yafJeg4NgeOzhOkUo1z7YG
 5CfmP2I6qSbhfdq/64s7ZXkBv2OG+JMRiqcmBYw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:58 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:08 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 12/13] btrfs: add block_rsv for treelog
Date: Wed, 19 Mar 2025 15:14:43 +0900
Message-ID: <cbb972d4719e45833b59f6c28765a290af466a02.1742364593.git.naohiro.aota@wdc.com>
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

We need to add a dedicated block_rsv for tree-log, because the block_rsv
serves for a tree node allocation in btrfs_alloc_tree_block(). Currently,
tree-log tree uses fs_info->empty_block_rsv, which is shared across trees
and points to the normal metadata space_info. Instead, we add a dedicated
block_rsv and that block_rsv can use the dedicated sub-space_info.

Currently, we use the dedicated block_rsv only for the zoned mode, but it
might be somewhat useful for the regular btrfs too.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
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
index 1a916716cefe..0fb114619b0e 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2829,6 +2829,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 			     BTRFS_BLOCK_RSV_GLOBAL);
 	btrfs_init_block_rsv(&fs_info->trans_block_rsv, BTRFS_BLOCK_RSV_TRANS);
 	btrfs_init_block_rsv(&fs_info->chunk_block_rsv, BTRFS_BLOCK_RSV_CHUNK);
+	btrfs_init_block_rsv(&fs_info->treelog_rsv, BTRFS_BLOCK_RSV_TREELOG);
 	btrfs_init_block_rsv(&fs_info->empty_block_rsv, BTRFS_BLOCK_RSV_EMPTY);
 	btrfs_init_block_rsv(&fs_info->delayed_block_rsv,
 			     BTRFS_BLOCK_RSV_DELOPS);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5a346d4a4b91..2deb0394115d 100644
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


