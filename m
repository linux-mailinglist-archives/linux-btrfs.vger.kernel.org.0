Return-Path: <linux-btrfs+bounces-19621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D7ECB2C22
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 12:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C68D301EF2A
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD46320CA2;
	Wed, 10 Dec 2025 11:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FJ/bM+W2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ED52A1BA
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 11:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765364758; cv=none; b=j9VedRoGpRQq9HfUWDblrP6sp9jeaeKI36vkNK3j4BkcHT9dafASujZ16VL6v7DhKcr4EH3DEimRqWrmT6O0QAS/oZB3vkeX90By7UqjBWMWNKXmzsVA1mObbBHCWwvT46ClwG7QVcHnho5pXiVS2iRi1c/8mCqaw17670WNWuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765364758; c=relaxed/simple;
	bh=ZzRSGnbZXyW1wzxSGrEVUdfRbv7B0KFTD/FHN1Up1Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGGdKbfMv7UMjLL+pNqhab4NtyaJazQ0PIwn4GIUGciKEzTiuQF1w5c+XKqW0xOJ11O9I8gwcEyULFlJb/1fuAea6bpH676ZMKcLoIGCABEEH1J4ggteLHlC8/J5V696l2rrYbKPcfqGlgNAA3Wk4JYdZ9zY8PAT3WR/4+RxDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FJ/bM+W2; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765364757; x=1796900757;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZzRSGnbZXyW1wzxSGrEVUdfRbv7B0KFTD/FHN1Up1Vo=;
  b=FJ/bM+W29O6/zGkn/K5YrPO4WPTc+pZ/tYe8Rl/Se/oPQRFuPI9oV2aU
   VhMCYhVRD/uRp337CMuWjP3slX0LEin6pT12imEzjn0gmojB7ywwYhzaG
   a0tR+ujegQOZ975uzijBGTTRUUVZib1bnN0fcSub4L5pCIwnIlbIAM5Jz
   4IaD6UaYjdOzO5xvvByG+O14aq3pNlUrsZWR4hoK1t3HvbC1fVJnkkNI+
   Fib4ahHl04T+z/9ysRCaVsnhL5Ek/CaJBmNw/b3tsXZ/XTVm9onKlqHjn
   Q7vZqhdU//2wpu9BJxAaH8Ut2XpbTUnxbIPxgFweIiaLP7XoHTWvi6jP1
   w==;
X-CSE-ConnectionGUID: X6q1zaFPStev3ejxjlW2nA==
X-CSE-MsgGUID: F0S7mqNlQemG+IyQV7pVYw==
X-IronPort-AV: E=Sophos;i="6.20,263,1758556800"; 
   d="scan'208";a="136248345"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2025 19:04:48 +0800
IronPort-SDR: 693953d0_mV1S/tkwkrGNiirzuRHJq+DXZK/9XkbJZD3ubWQ25AKCZcx
 Q7FfYs+Ad83ySGiaYwRXw9hY3bcCbgFqUOkSfsQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Dec 2025 03:04:49 -0800
WDCIronportException: Internal
Received: from 402g0j3.ad.shared (HELO neo.wdc.com) ([10.224.28.113])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Dec 2025 03:04:46 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: print block-group type for zoned statistics
Date: Wed, 10 Dec 2025 12:04:42 +0100
Message-ID: <20251210110442.11866-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When printing the zoned statistics, also include the block-group type in
the block-group listing output.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/sysfs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7f00e4babbc1..5411e5275f83 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1188,6 +1188,20 @@ static ssize_t btrfs_commit_stats_store(struct kobject *kobj,
 }
 BTRFS_ATTR_RW(, commit_stats, btrfs_commit_stats_show, btrfs_commit_stats_store);
 
+static const char *btrfs_block_group_type_name(u64 flags)
+{
+	switch (flags & BTRFS_BLOCK_GROUP_TYPE_MASK) {
+	case BTRFS_BLOCK_GROUP_SYSTEM:
+		return "SYSTEM";
+	case BTRFS_BLOCK_GROUP_METADATA:
+		return "METADATA";
+	case BTRFS_BLOCK_GROUP_DATA:
+		return "DATA";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
 				      struct kobj_attribute *a, char *buf)
 {
@@ -1229,9 +1243,9 @@ static ssize_t btrfs_zoned_stats_show(struct kobject *kobj,
 	ret += sysfs_emit_at(buf, ret, "active zones:\n");
 	list_for_each_entry(bg, &fs_info->zone_active_bgs, active_bg_list) {
 		ret += sysfs_emit_at(buf, ret,
-				     "\tstart: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu\n",
+				     "\tstart: %llu, wp: %llu used: %llu, reserved: %llu, unusable: %llu (%s)\n",
 				     bg->start, bg->alloc_offset, bg->used,
-				     bg->reserved, bg->zone_unusable);
+				     bg->reserved, bg->zone_unusable, btrfs_block_group_type_name(bg->flags));
 	}
 	spin_unlock(&fs_info->zone_active_bgs_lock);
 	return ret;
-- 
2.52.0


