Return-Path: <linux-btrfs+bounces-19839-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D7CC7F84
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 14:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90684309193E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB713491F6;
	Wed, 17 Dec 2025 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hJ9rqZur"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1553347FCF
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 13:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765978911; cv=none; b=SfhmUYV3bDcimc1ZXrBdo8rUwgHK02MUKSGPGQMuX2rSCwBpAiEiitCpWCfx+vC13uqo6bhzfyWcbOHIrcNb/jWcui/e3ZosvQyvEvgxo+IfxVRl7EnqYzljgXjSBBul4uisLVV/AULTQSuk1HrcEDltxyHDqM/rt8iu9ev4f2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765978911; c=relaxed/simple;
	bh=spf9x8jLrxchu71rDOe/XOymVFoSNaTgP0zdmu1bxQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tjgxyrmrv+vcXLhYSa7VRVUp50+zYWpN8LHwy9wQ2vkWS2tfT22as0d0SeV3FT6PRlg48b1clRcB3b0BXoiWDx7ui8FRwyOLyd8IGTxdi/63ptFOmYshH6mK9C+puvZ9MKILKt5wVrgGny1pB5mVVybLLPrk7yHfbpCQFAIBuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hJ9rqZur; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765978909; x=1797514909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=spf9x8jLrxchu71rDOe/XOymVFoSNaTgP0zdmu1bxQQ=;
  b=hJ9rqZur9Sk2/g7ilDQwuZ6p9byN94yp2L0LvCL2pl9iXnQS3/SUpKts
   32pi/90QHb6KG4LkZ15tdrxwoKeWSTvexUHGmfWpeoDCV7mVvdx2mckov
   DiY7RR//OeZcg0G1n2G6uieasigl+ieiz0zUBgMdU+I4s33P/ZMmis4U3
   vX22AS9hF6AEgKysedC0mAe5xbP+ouMPckWFSQFWDFx3jFpEyO6j3uxE8
   KxtjD7vsTPQtxTtyIhKGxTmz7wQPcpTXVLAj0S40+UJJm6NKHXTDPHi82
   aMQKI81fTnfvctUF+qb3r1r6RQTDQedmmoeNx9RoxsX+GMVq5Cj8/g91T
   A==;
X-CSE-ConnectionGUID: uUHl+VGSQJ2i2YWTTn3xHw==
X-CSE-MsgGUID: d5XBk7zBTWauByW4M82bJQ==
X-IronPort-AV: E=Sophos;i="6.21,155,1763395200"; 
   d="scan'208";a="136693796"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2025 21:41:49 +0800
IronPort-SDR: 6942b31d_Lj3olOytwxHvdNJakOI7b7He6roo9n3v+tlBe+Dfn4vZm2c
 GSNlUObW/UCuKo2WpRR63fFAxHpFCfmZgEDoKYg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Dec 2025 05:41:49 -0800
WDCIronportException: Internal
Received: from 5cg1443rm2.ad.shared (HELO neo.fritz.box) ([10.224.28.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Dec 2025 05:41:48 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Filipe Manana <fdmanana@suse.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 3/4] btrfs: move space_info_flag_to_str() to space-info.h
Date: Wed, 17 Dec 2025 14:41:38 +0100
Message-ID: <20251217134139.275174-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
References: <20251217134139.275174-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move space_info_flag_to_str() to space-info.h and as it now isn't static
to space-info.c any more prefix it with 'btrfs_'.

This way it can be re-used in other places.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/space-info.c | 18 +-----------------
 fs/btrfs/space-info.h | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 6babbe333741..7b7b7255f7d8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -602,22 +602,6 @@ do {									\
 	spin_unlock(&__rsv->lock);					\
 } while (0)
 
-static const char *space_info_flag_to_str(const struct btrfs_space_info *space_info)
-{
-	switch (space_info->flags) {
-	case BTRFS_BLOCK_GROUP_SYSTEM:
-		return "SYSTEM";
-	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
-		return "DATA+METADATA";
-	case BTRFS_BLOCK_GROUP_DATA:
-		return "DATA";
-	case BTRFS_BLOCK_GROUP_METADATA:
-		return "METADATA";
-	default:
-		return "UNKNOWN";
-	}
-}
-
 static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
@@ -630,7 +614,7 @@ static void dump_global_block_rsv(struct btrfs_fs_info *fs_info)
 static void __btrfs_dump_space_info(const struct btrfs_space_info *info)
 {
 	const struct btrfs_fs_info *fs_info = info->fs_info;
-	const char *flag_str = space_info_flag_to_str(info);
+	const char *flag_str = btrfs_space_info_type_str(info);
 	lockdep_assert_held(&info->lock);
 
 	/* The free space could be negative in case of overcommit */
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 446c0614ad4a..0703f24b23f7 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -307,4 +307,20 @@ int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
 void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
+static inline const char *btrfs_space_info_type_str(const struct btrfs_space_info *space_info)
+{
+	switch (space_info->flags) {
+	case BTRFS_BLOCK_GROUP_SYSTEM:
+		return "SYSTEM";
+	case BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA:
+		return "DATA+METADATA";
+	case BTRFS_BLOCK_GROUP_DATA:
+		return "DATA";
+	case BTRFS_BLOCK_GROUP_METADATA:
+		return "METADATA";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.52.0


