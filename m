Return-Path: <linux-btrfs+bounces-12409-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B8AA684F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 07:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29332882316
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 06:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408D924F594;
	Wed, 19 Mar 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CoHKCcVl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA25D24EF8B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742364904; cv=none; b=Ku/IfW2ai7H6fUohXr3yP6CYFSxf8PGDbSkRtl6/gOSddmiAUMhUA94PVlykw/CHYjgr7hDac+yfcZlSlXF3bBc3yTtz1vLk8NepqyrHT44oGvnYcZ9+1ub1/zPu5EEM2AIFuJ2TgXXqg3fZi/htB7psabM8wDShY2vpePyu6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742364904; c=relaxed/simple;
	bh=g6qN3PnnfgqnJHHBbQTiE7I0+WwKh8I3g7daRrtm5nI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJNfu3fm3tjhCfvXZmHMmE3x+VqNhn/+86LU3m7gHBlKL8CQgFyMcmIiTnX5Zb3SGOafphnQ2wVZ/FCdEPYvIFiFTpJMZadOyTzmI1vm5GixQCTZ1O+rlKPkjOF0CZK0+5IzzyG1E8umnLxvgF2l2HlwigdM/hxQ8TVfYyoJn2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CoHKCcVl; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742364902; x=1773900902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g6qN3PnnfgqnJHHBbQTiE7I0+WwKh8I3g7daRrtm5nI=;
  b=CoHKCcVlKFkyzybsZZ4jNC6ZV4Gn3xGUf5lwGLLFDTlHvEa5C1ctCucg
   Yktt8ztFNRAFLJ7Ez4xIWXKrgNp7nY05/fsnsPZtW/4c2DVmyYgN6k6OU
   eli6UPk0/T/09I9xErGt0bg9NBp9BeahVUPUsTegE6mihz50tqn5948Cu
   4eia8K+F7aglWygWYMbVdwnjcavMzW/iO2FqDPAQLWF7/nN+aN/4Qa8v2
   IpbSW4Sdq4wTHDriVTthbGjTgKyiFenY+n5hdGOXIUACyVrQfrkWkJv6p
   UOSxZxUoKbPaR+E0q7uI0Zs4j+i9f/7a/ih91I0EAgmVqO8Pjj6kIv9vR
   g==;
X-CSE-ConnectionGUID: C07FNxRpT6+peu4R4q8xCA==
X-CSE-MsgGUID: PR0oM7ImRye0DGEPUH7UyA==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="55227249"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 14:15:02 +0800
IronPort-SDR: 67da5306_85x3UXGZngUioLXHHnTnXznGibsUyPDDE9NcTaQbOxpTfza
 URAHYiKYhXSQadhtvMnTdRsr/JrZRzFv3TTezyQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Mar 2025 22:15:51 -0700
WDCIronportException: Internal
Received: from gbdn3z2.ad.shared (HELO naota-xeon..) ([10.224.109.136])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Mar 2025 23:15:01 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 05/13] btrfs: factor out check_removing_space_info()
Date: Wed, 19 Mar 2025 15:14:36 +0900
Message-ID: <580c3b12069246506736dd829725feb500397f15.1742364593.git.naohiro.aota@wdc.com>
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

Factor out check_removing_space_info() from btrfs_free_block_groups(). It
sanity checks a to-be-removed space_info. There is no functional change.
---
 fs/btrfs/block-group.c | 51 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a8129f1ce78c..b0e0b4251f36 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -4402,6 +4402,34 @@ void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
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
@@ -4503,28 +4531,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
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


