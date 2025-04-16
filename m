Return-Path: <linux-btrfs+bounces-13081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1704DA90679
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 16:31:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C249E189D2D3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 14:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2501FC0ED;
	Wed, 16 Apr 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qPeEpg6f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86331C54B2
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 14:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744813719; cv=none; b=fQlLzCYC3GX67XSK7BektmpFtJK8JvkDHc/RUzwgeDhKdHXsxHOFCq3QCyNYBrKhYD7od7xFXTfgAfmg/0R7kSbwI/5KwOSWrxnNFTl3Ct2U8f7I/c9NqK62Jg7pOciOi0ztErfQcyv1SjAQU6HXmoefRZVYntolgbjxvso0xZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744813719; c=relaxed/simple;
	bh=vKXVPOaBUUxuZW9IiU1O+R0eGzV6K4f4LAPuW0RP+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2dsdho7JHn3FKN5mCy6m19ETNkZVnT7gYcccMKQwmmxTBxpwtI3RAol6fY/eoMkNCLpLfJmMA/WrkvYryqRTWAaj41vd5S60ooOeIYTsqkvHmNIQsRS/R5IhnJHL3t2aR49+njxDaDS8pqyKumMWQCAGT+Tpgpe7qQH/RnVsos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qPeEpg6f; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744813717; x=1776349717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKXVPOaBUUxuZW9IiU1O+R0eGzV6K4f4LAPuW0RP+AU=;
  b=qPeEpg6faSNqd2eGu+MxR6JqmPjYKfMUK/l4G95KMQH91lAcD/ZXsbe8
   sfM4OdSSzZrdLVw5Mp4AaegkHnI9AHSn0ws43ZQJsy/c5CljrIaDflZAX
   mi6R2TpgDIuyegzozuIeoPqOBa7H2ZnMigmbBxJS7OJ6aBuCVbE2aHGCg
   A6I5n8eAZp6fxyj/WSE8T3Xq5yQXmCqdgyCbt9tpsJ25TPUzYA/k0pbYj
   25ypqVjS4VMA4S8Cy4UC6TdQPduTZLv6ah1SUaNQ3F8/9vNZPMQNf4PFt
   Saq6eZAuW9u2aCt5Z4qsKYQKEGGR6loELEQi5+BFm++x+d9KuTdDMt+Pt
   Q==;
X-CSE-ConnectionGUID: YlAov7MvTKqwiQ9uD5cjyA==
X-CSE-MsgGUID: C+RQDj9ATeWQDzlHMCFMgA==
X-IronPort-AV: E=Sophos;i="6.15,216,1739808000"; 
   d="scan'208";a="81484523"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2025 22:28:31 +0800
IronPort-SDR: 67ffb081_ohqwXsfjHl5FQfxqFYZB2fQYCTM5k4V63cG/gbVn0zxqYT4
 /TAGGjb09CP+ZFDd6KJ3UJ0h64HU3jYLrqcIwdA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2025 06:28:34 -0700
WDCIronportException: Internal
Received: from 5cg2075gjp.ad.shared (HELO naota-xeon..) ([10.224.104.89])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2025 07:28:30 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 05/13] btrfs: factor out check_removing_space_info()
Date: Wed, 16 Apr 2025 23:28:10 +0900
Message-ID: <9f12a9c25bb0bfc760a3a6aad5357d4365bff502.1744813603.git.naohiro.aota@wdc.com>
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

Factor out check_removing_space_info() from btrfs_free_block_groups(). It
sanity checks a to-be-removed space_info. There is no functional change.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 51 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 91807d294366..b700d80089d3 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4400,6 +4400,34 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
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
@@ -4501,28 +4529,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
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
2.49.0


