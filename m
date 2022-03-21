Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9744E2DA3
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 17:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245536AbiCUQQI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351049AbiCUQQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C888D23147
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 09:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647879269; x=1679415269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o8OCy0g7xB1UK3ZwczxP0PJny07qDFNDokaC0Iq1iSs=;
  b=UweI23HpWR8pNRzO7QmwhayoQ3Mf1tgqx+Cjyh88uMAxgA4q/o1pJjdF
   M6cS4RkEUMqT9GIxWJmGpQw78Exj1rUBEx2OJmzMYy6pio2lMPzu8LrwC
   MYC29KaGV5+sUYgvG5eHconiSXnqV6vcSpboiOIYMbUutmrQNXXVb1fBR
   OqCwqQDAc5i4vExgi8Mqa7r9qq/VNOHh/ccXhqtlGfDKgMSgIq/PZ8Ut/
   Q88dH83XQulpvCQADHiWGwLqokCJyedqmbG2f7H3eFHXfy8DS/NCtZc0Q
   lBEw1attNfuK27iJz/8w7Jiup3931KA329pdPqPxi5oWDBdnJfD/h+77o
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643644800"; 
   d="scan'208";a="307836348"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 00:14:28 +0800
IronPort-SDR: V+Uxe3JQgV0eV7BFE+hKdON78WEIf4GNRZr7zGiXWcy22TkitL5dLZMm6+48xtsN3UGFVR/b2J
 Bm4FipOYDKaUe1Aea30WYgS1fa9N3JE7m7bHX8G47m7umO658iKGZUbC6Ucb7hXx/eLyzKjfNH
 Abk0jd771ePcezaiU4/m5LfrT4H1ccB79FuR3P9vbpTG3cgLhmvO0PCj9L5VSh3vO2D0kIV/XP
 BSPFFW0YrSq8C2XEAQrtT4gexHTTer9pCRdQhQwgiVgBYt0W/EDuK2wBauno4xpOmtLC3HyavV
 4LAwJZSBr994nT+zbCmNuF6C
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:45:28 -0700
IronPort-SDR: CDOf1aNlWWM81ye3ib/TtyLzZ/Vtr3EyjC0YKeytfI3R7CZ9Vo9TChgEEbiJ6z6hmimsUiqsG1
 7eRq8jxucz1b5IgoqWgt2f6lBocliZqjrZcFCJYKVjjmDRA+Pxj8YvbSRu2E+GOLabQbxt1l+T
 AImZwyWOwlQylG1pEKHd62W9/n3L4DwOIHzUGCLCD2MhbmEW1Llee7xWlSJcBbZ1vn1YIyywhr
 aZ6QBl3bj1KRXWgLwpChOiWC6f8MFwUgtTOQcunDrRrnZQ3GoPr5IOpx+OHtqHLbGqvOFm/Ll5
 ciQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Mar 2022 09:14:27 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/5] btrfs: make the bg_reclaim_threshold per-space info
Date:   Mon, 21 Mar 2022 09:14:10 -0700
Message-Id: <63d4d206dd2e652aa968ab0fa30dd9aab98a666b.1647878642.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647878642.git.johannes.thumshirn@wdc.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
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

