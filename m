Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5344EA9E0
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbiC2I6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbiC2I57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:57:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C8D190B54
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648544176; x=1680080176;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8OCy0g7xB1UK3ZwczxP0PJny07qDFNDokaC0Iq1iSs=;
  b=kDrGYzyG682dKElN9H4VAkhzfCO0NGzFlmQEbu1CIitBm1sJWrwA84yd
   duMsERfJwhaESR2rlqK5yentRhl33NsGgujo8Ev77DpUOczH6uLvzqUJs
   6BSDuvisATMcZ6A6+goI3v8c0fwFsnYgPtVvov9TVgbMI90J/knAPgJ+F
   18Do7TdFtU8Thr5dC63MMo9KJatNlhQql5s066eHs1G2TW+0z0kVIyulW
   SacUzcAB5NjFW4If+5nu5carHiZDIojB3UYbazIwJKVPzYhoNK1DGINDU
   krPXlgnWY8WdXyH+ikfjqIlsLXP0Wrn0feHBQ+hPObrDzNgLkSqOyPcD9
   A==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="308481648"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:56:16 +0800
IronPort-SDR: 2arWa3iP21Gt3FTFEYaSU84S65bUO3rekd1G/O1vICvWxPc1JHpRUBjOoh5uJpRAByhMWYfHVR
 vVpwWGaDeOfsOlHpy69Kv3DJNAnY9u0iCEnQht+mESfXdgj2ZhhleIWOnoy/q/2GrzSRvketGG
 pknvowQdE2m6F5sgaag6F8ecI4yh1kUO+hU0xFAYSkRb+KfYnffK6w2hG3GPilqaOEYCLepw8i
 YKu1Io6RjwpyYU363iJk/itLx4cF1t55HLFUHDmGhbeq7INTQGpIbB5uMb2P+guYz48SWND1Rj
 3eAnHGzpEjvfO821yRCmaeAd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:28:00 -0700
IronPort-SDR: ZiH9Wna24tCwc2KbDLt+4JuBvhp2nMh2rzjhMFwXqK6ogwKPfHQegsnkCPBxkX0SUD1oZiDK67
 NdFKavdw9EGqd0S0YGrc9KtnzOpk4lKwMDMxUIVhAN/PUnbrSiTfKYLd++CuID+bnkBmjY2nhD
 +hpdbVD37XriITZ1ov82yepFyudN/HafBtGy+KscQu8PsgTzZc+Ixo4aI3l+NKvYhc8UmgQl6s
 4j//AftuWeFAKGsqErGTPShBBcpJg9RFPJ9jRH4eMzew4j2E+T+79myxjjN5XQhRS3q6bjwfy1
 DHk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2022 01:56:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/4] btrfs: make the bg_reclaim_threshold per-space info
Date:   Tue, 29 Mar 2022 01:56:06 -0700
Message-Id: <63d4d206dd2e652aa968ab0fa30dd9aab98a666b.1648543951.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648543951.git.johannes.thumshirn@wdc.com>
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

For !zoned file systems it's useful to have the auto reclaim feature,
however there are different use cases for !zoned, for example we may not
want to reclaim metadata chunks ever, only data chunks.  Move this sysfs
flag to per-space_info.  This won't affect current users because this
tunable only ever did anything for zoned, and that is currently hidden
behind BTRFS_CONFIG_DEBUG.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ jth restore global bg_reclaim_threshold ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/free-space-cache.c |  7 +++++--
 fs/btrfs/space-info.c       |  9 +++++++++
 fs/btrfs/space-info.h       |  6 ++++++
 fs/btrfs/sysfs.c            | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h            |  6 +-----
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 01a408db5683..ef84bc5030cd 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2630,16 +2630,19 @@ int __btrfs_add_free_space(struct btrfs_block_group *block_group,
 static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 					u64 bytenr, u64 size, bool used)
 {
-	struct btrfs_fs_info *fs_info = block_group->fs_info;
+	struct btrfs_space_info *sinfo = block_group->space_info;
 	struct btrfs_free_space_ctl *ctl = block_group->free_space_ctl;
 	u64 offset = bytenr - block_group->start;
 	u64 to_free, to_unusable;
-	const int bg_reclaim_threshold = READ_ONCE(fs_info->bg_reclaim_threshold);
+	int bg_reclaim_threshold = 0;
 	bool initial = (size == block_group->length);
 	u64 reclaimable_unusable;
 
 	WARN_ON(!initial && offset + size > block_group->zone_capacity);
 
+	if (!initial)
+		bg_reclaim_threshold = READ_ONCE(sinfo->bg_reclaim_threshold);
+
 	spin_lock(&ctl->tree_lock);
 	if (!used)
 		to_free = size;
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index b87931a458eb..60d0a58c4644 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -181,6 +181,12 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info *info)
 		found->full = 0;
 }
 
+/*
+ * Block groups with more than this value (percents) of unusable space will be
+ * scheduled for background reclaim.
+ */
+#define BTRFS_DEFAULT_ZONED_RECLAIM_THRESH	75
+
 static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 {
 
@@ -203,6 +209,9 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
 	INIT_LIST_HEAD(&space_info->priority_tickets);
 	space_info->clamp = 1;
 
+	if (btrfs_is_zoned(info))
+		space_info->bg_reclaim_threshold = BTRFS_DEFAULT_ZONED_RECLAIM_THRESH;
+
 	ret = btrfs_sysfs_add_space_info_type(info, space_info);
 	if (ret)
 		return ret;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index d841fed73492..0c45f539e3cf 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -24,6 +24,12 @@ struct btrfs_space_info {
 				   the space info if we had an ENOSPC in the
 				   allocator. */
 
+	/*
+	 * Once a block group drops below this threshold we'll schedule it for
+	 * reclaim.
+	 */
+	int bg_reclaim_threshold;
+
 	int clamp;		/* Used to scale our threshold for preemptive
 				   flushing. The value is >> clamp, so turns
 				   out to be a 2^clamp divisor. */
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 17389a42a3ab..90da1ea0cae0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -722,6 +722,42 @@ SPACE_INFO_ATTR(bytes_zone_unusable);
 SPACE_INFO_ATTR(disk_used);
 SPACE_INFO_ATTR(disk_total);
 
+static ssize_t btrfs_sinfo_bg_reclaim_threshold_show(struct kobject *kobj,
+						     struct kobj_attribute *a,
+						     char *buf)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	ssize_t ret;
+
+	ret = sysfs_emit(buf, "%d\n", READ_ONCE(space_info->bg_reclaim_threshold));
+
+	return ret;
+}
+
+static ssize_t btrfs_sinfo_bg_reclaim_threshold_store(struct kobject *kobj,
+						      struct kobj_attribute *a,
+						      const char *buf, size_t len)
+{
+	struct btrfs_space_info *space_info = to_space_info(kobj);
+	int thresh;
+	int ret;
+
+	ret = kstrtoint(buf, 10, &thresh);
+	if (ret)
+		return ret;
+
+	if (thresh != 0 && (thresh <= 50 || thresh > 100))
+		return -EINVAL;
+
+	WRITE_ONCE(space_info->bg_reclaim_threshold, thresh);
+
+	return len;
+}
+
+BTRFS_ATTR_RW(space_info, bg_reclaim_threshold,
+	      btrfs_sinfo_bg_reclaim_threshold_show,
+	      btrfs_sinfo_bg_reclaim_threshold_store);
+
 /*
  * Allocation information about block group types.
  *
@@ -738,6 +774,7 @@ static struct attribute *space_info_attrs[] = {
 	BTRFS_ATTR_PTR(space_info, bytes_zone_unusable),
 	BTRFS_ATTR_PTR(space_info, disk_used),
 	BTRFS_ATTR_PTR(space_info, disk_total),
+	BTRFS_ATTR_PTR(space_info, bg_reclaim_threshold),
 	NULL,
 };
 ATTRIBUTE_GROUPS(space_info);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index cbf016a7bb5d..c489c08d7fd5 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -10,11 +10,7 @@
 #include "block-group.h"
 #include "btrfs_inode.h"
 
-/*
- * Block groups with more than this value (percents) of unusable space will be
- * scheduled for background reclaim.
- */
-#define BTRFS_DEFAULT_RECLAIM_THRESH		75
+#define BTRFS_DEFAULT_RECLAIM_THRESH           75
 
 struct btrfs_zoned_device_info {
 	/*
-- 
2.35.1

