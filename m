Return-Path: <linux-btrfs+bounces-10079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 699999E4EF1
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 08:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43199165198
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FFD1CBE94;
	Thu,  5 Dec 2024 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BLwtlqru"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793271C4A07
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2024 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733385031; cv=none; b=eb60Du6gbzdPdnaRCNZFINZ3ygyjL3PxiAKfBl1dj11OJVw6jBdQGV7SVCYbU59HW3nSrpvhSnG4RExd4AgEnA3jESdeKOF7UtmfHULtk1eeSyqsKEAImlh3mS5cVvDUKohNScSFB+G+yaEJ8Svn8P2YEdMnldtnXnQbaIez8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733385031; c=relaxed/simple;
	bh=lZ+yT6pwbh23dlNXWUiG5N2+oMNnGGtMCFbEkWjS5Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRkjcqDF9rrAG7RBbIsxSumzTOS1uz4RkjamYcEa+f8UoacZT+JWF8Q2V8wasmh5Eg0AaHxmjsxkp/rEbzkT6Vd8RtcKPvok0Drj4NeiA1KQ9xAf1YlMfYlUZH/jOqhiyUfFmMB+I97J1/7JxdNqpaLcl4Pi7ohBDCpp3YyPBvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BLwtlqru; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733385029; x=1764921029;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZ+yT6pwbh23dlNXWUiG5N2+oMNnGGtMCFbEkWjS5Nc=;
  b=BLwtlqrukwlTWo6367MsHC7g4umzKYIVa+8IaoD+kip7TyJygsG+wbjw
   fgwbSZ8ojSwSjbSuGkDkYA87MIyisOGB/0lANWEmSH7SE9rzGdOMSsfoZ
   zZTE/0CnO1ZcA5w0LAsJ4sRHIgpoenbTmgUVsJ4BSxKAO0sZjPydJoQqq
   SA8Y/cZIiKgfKDx1AV68A9B4ZcmAGyKRswHImTDnwNBAKqcAEcdMamp6q
   GtOBRJBg7u01scjJeyFhXy02NeY8n3M3lxzJMAaXXfB28qDEZUcEYICaw
   DxdkpoS2n3iRlKWJO1+IWUDsZJt7eNsodKZUdnLO7SlJqIYZv+2LH4Brm
   Q==;
X-CSE-ConnectionGUID: lRBe0N3cQvKqebC+neTuaQ==
X-CSE-MsgGUID: g9aKElVhSWqKVZy3LzG7Jg==
X-IronPort-AV: E=Sophos;i="6.12,209,1728921600"; 
   d="scan'208";a="33626111"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Dec 2024 15:49:19 +0800
IronPort-SDR: 67514c5a_xgmzIVUvNaPkyC0XBGeNU3OwuiNjzjHXTdpc4McoJokYEEI
 0KxWYaBMJGGU0kuk/d+B32of/xaq5L98QSPO9UA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2024 22:46:50 -0800
WDCIronportException: Internal
Received: from naota-x1.dhcp.fujisawa.hgst.com (HELO naota-x1.ad.shared) ([10.89.81.175])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2024 23:49:20 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 05/11] btrfs: factor out check_removing_space_info()
Date: Thu,  5 Dec 2024 16:48:21 +0900
Message-ID: <f4f89b4574df77147cffb21e5f74fd033a8dffbf.1733384171.git.naohiro.aota@wdc.com>
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

Factor out check_removing_space_info() from btrfs_free_block_groups(). It
sanity checks a to-be-removed space_info. There is no functional change.
---
 fs/btrfs/block-group.c | 51 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..4b8071a8d795 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4371,6 +4371,34 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
 	}
 }
 
+static void check_removing_space_info(struct btrfs_space_info *space_info)
+{
+	struct btrfs_fs_info *info = space_info->fs_info;
+
+	/*
+	 * Do not hide this behind enospc_debug, this is actually
+	 * important and indicates a real bug if this happens.
+	 */
+	if (WARN_ON(space_info->bytes_pinned > 0 ||
+		    space_info->bytes_may_use > 0))
+		btrfs_dump_space_info(info, space_info, 0, 0);
+
+	/*
+	 * If there was a failure to cleanup a log tree, very likely due
+	 * to an IO failure on a writeback attempt of one or more of its
+	 * extent buffers, we could not do proper (and cheap) unaccounting
+	 * of their reserved space, so don't warn on bytes_reserved > 0 in
+	 * that case.
+	 */
+	if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
+	    !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
+		if (WARN_ON(space_info->bytes_reserved > 0))
+			btrfs_dump_space_info(info, space_info, 0, 0);
+	}
+
+	WARN_ON(space_info->reclaim_size > 0);
+}
+
 /*
  * Must be called only after stopping all workers, since we could have block
  * group caching kthreads running, and therefore they could race with us if we
@@ -4472,28 +4500,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 					struct btrfs_space_info,
 					list);
 
-		/*
-		 * Do not hide this behind enospc_debug, this is actually
-		 * important and indicates a real bug if this happens.
-		 */
-		if (WARN_ON(space_info->bytes_pinned > 0 ||
-			    space_info->bytes_may_use > 0))
-			btrfs_dump_space_info(info, space_info, 0, 0);
-
-		/*
-		 * If there was a failure to cleanup a log tree, very likely due
-		 * to an IO failure on a writeback attempt of one or more of its
-		 * extent buffers, we could not do proper (and cheap) unaccounting
-		 * of their reserved space, so don't warn on bytes_reserved > 0 in
-		 * that case.
-		 */
-		if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
-		    !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
-			if (WARN_ON(space_info->bytes_reserved > 0))
-				btrfs_dump_space_info(info, space_info, 0, 0);
-		}
-
-		WARN_ON(space_info->reclaim_size > 0);
+		check_removing_space_info(space_info);
 		list_del(&space_info->list);
 		btrfs_sysfs_remove_space_info(space_info);
 	}
-- 
2.47.1


