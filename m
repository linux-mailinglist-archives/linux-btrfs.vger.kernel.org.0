Return-Path: <linux-btrfs+bounces-13261-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B550A97CEF
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 04:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BABBF7A774B
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 02:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553F2264FBA;
	Wed, 23 Apr 2025 02:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="F85kwlIy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D0264638
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 02:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376267; cv=none; b=CvBmEo0gUrmwCNQ864HXkfAN4a5p1X+acRSMj5ViNetUsEGD+Fl2WUhMZ85cTzka5HUVE6lEMkgQG2W5rIR8jRz9VBy/WG7x+hv3uMmc8K1zvD1ZhtfOYrg7P0EwSOlytr5HC9C6xw27SWSB+9tUgsiuU29WwaZj4d7ngPlKEfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376267; c=relaxed/simple;
	bh=vKXVPOaBUUxuZW9IiU1O+R0eGzV6K4f4LAPuW0RP+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7heMKhTEyHWc/2JErc6tTQfq5l3trlJ1ZnXeyzb1UbsElOCnIEmzhH/HY77wJ5W6ExLbUhC/Ln2EGG23+5FQghjQnus3EkXTEFrskl1sbWOat4KXnrNAVF0lrNdcL9WODUQ3Ia/aXEwn2kSal/kAKBdXMo1HA/NDaLeJyboXlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=F85kwlIy; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745376265; x=1776912265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vKXVPOaBUUxuZW9IiU1O+R0eGzV6K4f4LAPuW0RP+AU=;
  b=F85kwlIyEzIToyBfvRx6tFirXjUT73KKUW9PEQQoKTZtKXcAEnyeJB+U
   Uc67h3HRNkm72Nb7V2MqGA37Uw36wzbHHNybmnJWaj4UzefdXsmzGZx5O
   7vrVCAmO84/LL171iqroxX6Z8d4NgEfXeGMIT0oKWACpD/2jVN2zyrlIS
   mfHreB3m8xOFH5sPjd6bmwiT3W/4lB1+Swg/kvS6y+tfkewKqvMTtzIUS
   JPVtHcPiGU+IeKs/Wg+ETDufUOdEFh+Fncki0eE6LDeI2bZr5x9TMG820
   oP5v3bnUXNL5Ocuowz23MwnDIq1kwZEUsQnpU2gV5s1X9V3yT2Co6saxp
   w==;
X-CSE-ConnectionGUID: UKvUz4j9S5O30HxbA1/13g==
X-CSE-MsgGUID: vQUij6lAS0usNAuNaHwJ2Q==
X-IronPort-AV: E=Sophos;i="6.15,232,1739808000"; 
   d="scan'208";a="83011840"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Apr 2025 10:44:19 +0800
IronPort-SDR: 680845eb_LxGy1Tzu57IlTKZkFDCiTq6OXGlui3qZYtOOJS6MeV4zl6t
 SScKd7ESTnbDokoR4Jp3+WridvPjPJ/CbPp7vzw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Apr 2025 18:44:11 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon..) ([10.224.173.39])
  by uls-op-cesaip02.wdc.com with ESMTP; 22 Apr 2025 19:44:19 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 05/13] btrfs: factor out check_removing_space_info()
Date: Wed, 23 Apr 2025 11:43:45 +0900
Message-ID: <adf94101e60cf881b61dafe106370b12ab9a774e.1745375070.git.naohiro.aota@wdc.com>
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


