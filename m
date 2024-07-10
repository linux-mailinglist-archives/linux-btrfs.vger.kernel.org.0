Return-Path: <linux-btrfs+bounces-6341-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5456492D4E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B33C5B2567E
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jul 2024 15:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFE01946A7;
	Wed, 10 Jul 2024 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FgzLtteu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D28190678
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Jul 2024 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720625052; cv=none; b=VkqrzuLRuJVsdPMWmlyLIG6+0llbtHNAgvwYYK7Blc+jjpVNwDnc50D0+1BehiRXAtzHxj7LvYBiEah4SgeP2QrowebbNQGSQEXNlveXSKF+t0kwitpeHHxVBbK8uDETJZR6wAMh9uGudeB24B7obMAzYKZ+HZatXKBq1Ot54r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720625052; c=relaxed/simple;
	bh=EeSnUjiCUczNIHDWU5kJLqsEKk9yyf65WuFaI2U/eFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pkIz+LiyLIsRb44USfnAJ0mSY+L+4HN6x2BScCwgNGy8MQ1tQgx5RBgsCd3ylJTlxCCu8UdFrfz06P9I6tfJnMI/OxXWQ4gQOYOAxz3Kji8TmaPhnZuSaEJ/UppleeREEff8irfSkDpMqacbqGhsQthdnws7rA2jhL60RGoBglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FgzLtteu; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720625050; x=1752161050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EeSnUjiCUczNIHDWU5kJLqsEKk9yyf65WuFaI2U/eFc=;
  b=FgzLtteug548+Wsjngsowaz6bcJPASfdx6N7y4QqyApxRLMYL1bNkpAp
   wawtkJK8zKdTHCZa1V87Smv8LyMgtVRE45oEOiG/I2a285Ob4tNS6gEci
   J9pL4vB4zC8TQBEXPpTJRgCeuXsBuoeN5eS44KDjwwkpn9xHnzu5AikVu
   LsOFFll6W5VhDtqDhm2L8fMXgqaweYCvDbmqtix1gW669Bu1zsBesjrMS
   nE19T+AOuK8FvFC3vKjH5tC6u/Auchx5WwbnSC9HQsUJIkX9m4XcF2W3H
   HIPNaNy1hBkYRJKckpC9WScaRF9ZCAuetd5QV9/19C1F6vi35sb2z+oha
   g==;
X-CSE-ConnectionGUID: ZAfjY+IjTBizMsgUn/QDhg==
X-CSE-MsgGUID: ASlyYFJ1TRqZWqgrVuKXdg==
X-IronPort-AV: E=Sophos;i="6.09,198,1716220800"; 
   d="scan'208";a="21386595"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2024 23:24:02 +0800
IronPort-SDR: 668e9b0e_Nyut2zG8ohtWsqj+4iPHQr18U7XZ+aGIAWeZqQyVS+I2Ghp
 F7iZrLyC7Mu4hOnpOpXFKKC1+D56jjYNVHdi1qg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 07:30:39 -0700
WDCIronportException: Internal
Received: from unknown (HELO naota-xeon.wdc.com) ([10.225.163.104])
  by uls-op-cesaip02.wdc.com with ESMTP; 10 Jul 2024 08:24:01 -0700
From: Naohiro Aota <naohiro.aota@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] btrfs: zoned: fix zone_unusable accounting on making BG RW again
Date: Thu, 11 Jul 2024 00:23:54 +0900
Message-ID: <1626ef0d42713eaa6e050a6a64be8a811446ad5a.1720624977.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When btrfs makes a block group read-only, it adds all free regions in the
BG to space_info->bytes_readonly. That free space excludes reserved and
pinned regions. OTOH, when btrfs makes the BG read-write again, it moves
all the unused regions into the block group's zone_unusable. That unused
region includes reserved and pinned regions. As a result, it counts too
much zone_unusable bytes.

Fortunately (or unfortunately), having erroneous zone_unusable does not
affect the calculation of space_info->bytes_readonly, because free
space (num_bytes in btrfs_dec_block_group_ro) calculation is done based on
the erroneous zone_unusable and it reduces the num_bytes just to cancel the
error.

This behavior can be easily discovered by adding a WARN_ON to check e.g,
"bg->pinned > 0" in btrfs_dec_block_group_ro(), and running fstests test
case like btrfs/282.

Fix it by properly considering pinned and reserved in
btrfs_dec_block_group_ro(). Also, add a WARN_ON and introduce
btrfs_space_info_update_bytes_zone_unusable() to catch a similar mistake.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c       | 13 ++++++++-----
 fs/btrfs/extent-tree.c       |  2 +-
 fs/btrfs/free-space-cache.c  |  4 +++-
 fs/btrfs/space-info.c        |  2 +-
 fs/btrfs/space-info.h        |  1 +
 include/trace/events/btrfs.h |  8 ++++++++
 6 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 498442d0c216..2e49d978f504 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1223,8 +1223,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 	block_group->space_info->total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
-	block_group->space_info->bytes_zone_unusable -=
-		block_group->zone_unusable;
+	btrfs_space_info_update_bytes_zone_unusable(fs_info, block_group->space_info,
+						    -block_group->zone_unusable);
 	block_group->space_info->disk_total -= block_group->length * factor;
 
 	spin_unlock(&block_group->space_info->lock);
@@ -1396,7 +1396,8 @@ static int inc_block_group_ro(struct btrfs_block_group *cache, int force)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes to readonly */
 			sinfo->bytes_readonly += cache->zone_unusable;
-			sinfo->bytes_zone_unusable -= cache->zone_unusable;
+			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
+								    -cache->zone_unusable);
 			cache->zone_unusable = 0;
 		}
 		cache->ro++;
@@ -3056,9 +3057,11 @@ void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
 		if (btrfs_is_zoned(cache->fs_info)) {
 			/* Migrate zone_unusable bytes back */
 			cache->zone_unusable =
-				(cache->alloc_offset - cache->used) +
+				(cache->alloc_offset - cache->used - cache->pinned -
+				 cache->reserved) +
 				(cache->length - cache->zone_capacity);
-			sinfo->bytes_zone_unusable += cache->zone_unusable;
+			btrfs_space_info_update_bytes_zone_unusable(cache->fs_info, sinfo,
+								    cache->zone_unusable);
 			sinfo->bytes_readonly -= cache->zone_unusable;
 		}
 		num_bytes = cache->length - cache->reserved -
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d77498e7671c..f2df49b46f35 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2793,7 +2793,7 @@ static int unpin_extent_range(struct btrfs_fs_info *fs_info,
 			readonly = true;
 		} else if (btrfs_is_zoned(fs_info)) {
 			/* Need reset before reusing in a zoned block group */
-			space_info->bytes_zone_unusable += len;
+			btrfs_space_info_update_bytes_zone_unusable(fs_info, space_info, len);
 			readonly = true;
 		}
 		spin_unlock(&cache->lock);
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3f9b7507543a..f5996a43db24 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2723,8 +2723,10 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	 * If the block group is read-only, we should account freed space into
 	 * bytes_readonly.
 	 */
-	if (!block_group->ro)
+	if (!block_group->ro) {
 		block_group->zone_unusable += to_unusable;
+		WARN_ON(block_group->zone_unusable > block_group->length);
+	}
 	spin_unlock(&ctl->tree_lock);
 	if (!used) {
 		spin_lock(&block_group->lock);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 9ac94d3119e8..5227eadcaaa8 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -316,7 +316,7 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	found->bytes_used += block_group->used;
 	found->disk_used += block_group->used * factor;
 	found->bytes_readonly += block_group->bytes_super;
-	found->bytes_zone_unusable += block_group->zone_unusable;
+	btrfs_space_info_update_bytes_zone_unusable(info, found, block_group->zone_unusable);
 	if (block_group->length > 0)
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 4db8a0267c16..88b44221ce97 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -249,6 +249,7 @@ btrfs_space_info_update_##name(struct btrfs_fs_info *fs_info,		\
 
 DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
 DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
+DECLARE_SPACE_INFO_UPDATE(bytes_zone_unusable, "zone_unusable");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index eeb56975bee7..de55a555d95b 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2383,6 +2383,14 @@ DEFINE_EVENT(btrfs__space_info_update, update_bytes_pinned,
 	TP_ARGS(fs_info, sinfo, old, diff)
 );
 
+DEFINE_EVENT(btrfs__space_info_update, update_bytes_zone_unusable,
+
+	TP_PROTO(const struct btrfs_fs_info *fs_info,
+		 const struct btrfs_space_info *sinfo, u64 old, s64 diff),
+
+	TP_ARGS(fs_info, sinfo, old, diff)
+);
+
 DECLARE_EVENT_CLASS(btrfs_raid56_bio,
 
 	TP_PROTO(const struct btrfs_raid_bio *rbio,
-- 
2.45.2


