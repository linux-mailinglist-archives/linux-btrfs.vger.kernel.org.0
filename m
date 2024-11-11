Return-Path: <linux-btrfs+bounces-9413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A169C3932
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DC4B21D29
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E2815CD79;
	Mon, 11 Nov 2024 07:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BJwbrzrK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EE715B14B
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 07:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731311336; cv=none; b=BEAcl/OJBlE+3ESj1B5oOcV6R1Pd7HP8eZEdwecWkSLoF8FXNpBZNVaHzGJV9RO+UlRe6ISjo6+i0cDvyd/N1K+6B9Z9Hv6V1EdTwkmBK1Ciiwfwgnwrk3W/gQm0STsVtRsDY+IS8ET79sG//1D5AOv1Ru+IhETfVgF7JYilGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731311336; c=relaxed/simple;
	bh=nmLaaVWDS3TKfrMLPWsfvbpSGMeQemFNuueHsC1F42U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAZFxC++4vI9VpVAClRV0Qmj8vT5mr1aEFhO5+EVpSC/hI/Vzj0v+g8+ly5s4sNNSvIL72QRZ5CsNE3md8lcWD5Hpw2WQdU4Q+hICU30gsAfaVcs+cz6fXZzuSHUzJNNHRhijJOyy/fPivIGfrdDfgpJPMFBcQANlN6CZJhTwGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BJwbrzrK; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731311335; x=1762847335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nmLaaVWDS3TKfrMLPWsfvbpSGMeQemFNuueHsC1F42U=;
  b=BJwbrzrKJPaQyA5SncjpItOLa8F0/RvBBPlS8hx34CB2FGOefU0jB/+v
   jpr3WRZkB3Uv6eVPkNLbXJvbRBB7QKCePK8tizBJeUpgCOQRnHD+J33Rx
   Ee0oHvfxf+gsbRgFJjwQWO2znh9EZ/dG3wMiBJ7SxyO1ce03ayvJsmXAH
   Z+gicHn8HUimyXDLljV90iKV5908L41LUIBwdU/5xlyVjoL3VRflquomt
   RrUpOEq3zW2ROcqM51OdUvdlPZL58O/LC5Jp5Xuu8wgHwxKx3ZG2sTejP
   opjaNkQWSMwnXPAQiFQGDWqSM0hvsVGEic2asbhUjBZkT/DYVlMdx1I12
   g==;
X-CSE-ConnectionGUID: twUFZgD5Q16GSIGRuoLlNw==
X-CSE-MsgGUID: xOQ4T0QnRvqrIBBNThJbVw==
X-IronPort-AV: E=Sophos;i="6.12,144,1728921600"; 
   d="scan'208";a="32235395"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2024 15:47:46 +0800
IronPort-SDR: 6731a81a_JzU4WobrxBc2K9tIH4hBh8+o+QFXk1zVkA5n/Lc7om2THmu
 rLyJ85oozlzmzSUqcSdd30vue6+Vtt/Xtuloxzg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Nov 2024 22:45:47 -0800
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.23])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2024 23:47:46 -0800
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/3] btrfs: introduce btrfs_return_free_space()
Date: Mon, 11 Nov 2024 16:46:37 +0900
Message-ID: <042529cc81a8704c07d006d1e03db47aa0ef88db.1731310741.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731310741.git.naohiro.aota@wdc.com>
References: <cover.1731310741.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit factors out a part of unpin_extent_range() into a function for
the next commit. Also, move the "len" variable into the loop to clarify we
don't need to carry it beyond an iteration.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 25 ++++---------------------
 fs/btrfs/space-info.c  | 24 ++++++++++++++++++++++++
 fs/btrfs/space-info.h  |  1 +
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 412e318e4a22..ce7c963dd0a6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2724,15 +2724,15 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_block_group *cache = NULL;
 	struct btrfs_space_info *space_info;
-	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
 	struct btrfs_free_cluster *cluster = NULL;
-	u64 len;
 	u64 total_unpinned = 0;
 	u64 empty_cluster = 0;
 	bool readonly;
 	int ret = 0;
 
 	while (start <= end) {
+		u64 len;
+
 		readonly = false;
 		if (!cache ||
 		    start >= cache->start + cache->length) {
@@ -2790,25 +2790,8 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			readonly = true;
 		}
 		spin_unlock(&cache->lock);
-		if (!readonly && return_free_space &&
-		    global_rsv->space_info == space_info) {
-			spin_lock(&global_rsv->lock);
-			if (!global_rsv->full) {
-				u64 to_add = min(len, global_rsv->size -
-						      global_rsv->reserved);
-
-				global_rsv->reserved += to_add;
-				btrfs_space_info_update_bytes_may_use(fs_info,
-						space_info, to_add);
-				if (global_rsv->reserved >= global_rsv->size)
-					global_rsv->full = 1;
-				len -= to_add;
-			}
-			spin_unlock(&global_rsv->lock);
-		}
-		/* Add to any tickets we may have */
-		if (!readonly && return_free_space && len)
-			btrfs_try_granting_tickets(fs_info, space_info);
+		if (!readonly && return_free_space)
+			btrfs_return_free_space(space_info, len);
 		spin_unlock(&space_info->lock);
 	}
 
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 255e85f78313..bcdf0fdfa2d3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -2082,3 +2082,27 @@ void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info)
 			do_reclaim_sweep(space_info, raid);
 	}
 }
+
+void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len)
+{
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
+	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+
+	lockdep_assert_held(&space_info->lock);
+
+	if (global_rsv->space_info == space_info) {
+		guard(spinlock)(&global_rsv->lock);
+		if (!global_rsv->full) {
+			u64 to_add = min(len, global_rsv->size - global_rsv->reserved);
+
+			global_rsv->reserved += to_add;
+			btrfs_space_info_update_bytes_may_use(fs_info, space_info, to_add);
+			if (global_rsv->reserved >= global_rsv->size)
+				global_rsv->full = 1;
+			len -= to_add;
+		}
+	}
+	/* Add to any tickets we may have */
+	if (len)
+		btrfs_try_granting_tickets(fs_info, space_info);
+}
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index efbecc0c5258..4c9e8aabee51 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -295,5 +295,6 @@ void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_info, bool
 bool btrfs_should_periodic_reclaim(struct btrfs_space_info *space_info);
 int btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_info);
 void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
+void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 len);
 
 #endif /* BTRFS_SPACE_INFO_H */
-- 
2.47.0


