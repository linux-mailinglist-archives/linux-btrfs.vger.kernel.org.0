Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDA58328F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jul 2022 20:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbiG0S6C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jul 2022 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiG0S5s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jul 2022 14:57:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E97E6B
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jul 2022 11:02:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C74933E739;
        Wed, 27 Jul 2022 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658944919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=rL4JI1Y9e5+luxJtUoAQ23ch+F57SdDAXQi3b88fZDc=;
        b=G+8RG4KlF+jLJdrMkO1/GmD8uy7QcDZDpmro6UqscXsLh2lFxfsXvq1r8dpBIf5KabQ5GC
        Ih7Z4WQmDltO1TdifFnQ4Ft26TG51f/Y86lqvuhAW1qJRQYr9z0o8iIqKIVhjSZb/xbBof
        aQAWTfPz2ov1DY+Mb/UkapGF2FS6dbM=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C002E2C141;
        Wed, 27 Jul 2022 18:01:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BEDF1DA83C; Wed, 27 Jul 2022 19:57:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: sysfs: show discard stats and tunables in non-debug build
Date:   Wed, 27 Jul 2022 19:56:59 +0200
Message-Id: <20220727175659.16661-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When discard=async was introduced there were also sysfs knobs and stats
for debugging and tuning, hidden under CONFIG_BTRFS_DEBUG. The defaults
have been set and so far seem to satisfy all users on a range of
workloads. As there are not only tunables (like iops or kbps) but also
stats tracking amount of discardable bytes, that should be available
when the async discard is on (otherwise it's not).

The stats are moved from the per-fs debug directory, so it's under
  /sys/fs/btrfs/FSID/discard

- discard_bitmap_bytes - amount of discarded bytes from data tracked as
                         bitmaps
- discard_extent_bytes - dtto but as extents
- discard_bytes_saved -
- discardable_bytes - amount of bytes that can be discarded
- discardable_extents - number of extents to be discarded
- iops_limit - tunable limit of number of discard IOs to be issued
- kbps_limit - tunable limit of kilobytes per second issued as discard IO
- max_discard_size - tunable limit for size of one IO discard request

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h |  2 +-
 fs/btrfs/sysfs.c | 36 ++++++++++++++++--------------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db85b9dc7ed..9631059d2733 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -891,6 +891,7 @@ struct btrfs_fs_info {
 
 	struct kobject *space_info_kobj;
 	struct kobject *qgroups_kobj;
+	struct kobject *discard_kobj;
 
 	/* used to keep from writing metadata until there is a nice batch */
 	struct percpu_counter dirty_metadata_bytes;
@@ -1102,7 +1103,6 @@ struct btrfs_fs_info {
 
 #ifdef CONFIG_BTRFS_DEBUG
 	struct kobject *debug_kobj;
-	struct kobject *discard_debug_kobj;
 	struct list_head allocated_roots;
 
 	spinlock_t eb_leak_lock;
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index d5d0717fd09a..95782f3b55da 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -35,12 +35,12 @@
  * qgroup_attrs				/sys/fs/btrfs/<uuid>/qgroups/<level>_<qgroupid>
  * space_info_attrs			/sys/fs/btrfs/<uuid>/allocation/<bg-type>
  * raid_attrs				/sys/fs/btrfs/<uuid>/allocation/<bg-type>/<bg-profile>
+ * discard_attrs			/sys/fs/btrfs/<uuid>/discard
  *
  * When built with BTRFS_CONFIG_DEBUG:
  *
  * btrfs_debug_feature_attrs		/sys/fs/btrfs/debug
  * btrfs_debug_mount_attrs		/sys/fs/btrfs/<uuid>/debug
- * discard_debug_attrs			/sys/fs/btrfs/<uuid>/debug/discard
  */
 
 struct btrfs_feature_attr {
@@ -429,12 +429,10 @@ static const struct attribute_group btrfs_static_feature_attr_group = {
 	.attrs = btrfs_supported_static_feature_attrs,
 };
 
-#ifdef CONFIG_BTRFS_DEBUG
-
 /*
  * Discard statistics and tunables
  */
-#define discard_to_fs_info(_kobj)	to_fs_info((_kobj)->parent->parent)
+#define discard_to_fs_info(_kobj)	to_fs_info(get_btrfs_kobj(_kobj))
 
 static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 					    struct kobj_attribute *a,
@@ -583,11 +581,11 @@ BTRFS_ATTR_RW(discard, max_discard_size, btrfs_discard_max_discard_size_show,
 	      btrfs_discard_max_discard_size_store);
 
 /*
- * Per-filesystem debugging of discard (when mounted with discard=async).
+ * Per-filesystem stats for discard (when mounted with discard=async).
  *
- * Path: /sys/fs/btrfs/<uuid>/debug/discard/
+ * Path: /sys/fs/btrfs/<uuid>/discard/
  */
-static const struct attribute *discard_debug_attrs[] = {
+static const struct attribute *discard_attrs[] = {
 	BTRFS_ATTR_PTR(discard, discardable_bytes),
 	BTRFS_ATTR_PTR(discard, discardable_extents),
 	BTRFS_ATTR_PTR(discard, discard_bitmap_bytes),
@@ -599,6 +597,8 @@ static const struct attribute *discard_debug_attrs[] = {
 	NULL,
 };
 
+#ifdef CONFIG_BTRFS_DEBUG
+
 /*
  * Per-filesystem runtime debugging exported via sysfs.
  *
@@ -1427,19 +1427,17 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 		kobject_del(fs_info->space_info_kobj);
 		kobject_put(fs_info->space_info_kobj);
 	}
-#ifdef CONFIG_BTRFS_DEBUG
-	if (fs_info->discard_debug_kobj) {
-		sysfs_remove_files(fs_info->discard_debug_kobj,
-				   discard_debug_attrs);
-		kobject_del(fs_info->discard_debug_kobj);
-		kobject_put(fs_info->discard_debug_kobj);
+	if (fs_info->discard_kobj) {
+		sysfs_remove_files(fs_info->discard_kobj, discard_attrs);
+		kobject_del(fs_info->discard_kobj);
+		kobject_put(fs_info->discard_kobj);
 	}
 	if (fs_info->debug_kobj) {
 		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
 		kobject_del(fs_info->debug_kobj);
 		kobject_put(fs_info->debug_kobj);
 	}
-#endif
+
 	addrm_unknown_feature_attrs(fs_info, false);
 	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
 	sysfs_remove_files(fsid_kobj, btrfs_attrs);
@@ -2001,20 +1999,18 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
 	error = sysfs_create_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
 	if (error)
 		goto failure;
+#endif
 
 	/* Discard directory */
-	fs_info->discard_debug_kobj = kobject_create_and_add("discard",
-						     fs_info->debug_kobj);
-	if (!fs_info->discard_debug_kobj) {
+	fs_info->discard_kobj = kobject_create_and_add("discard", fsid_kobj);
+	if (!fs_info->discard_kobj) {
 		error = -ENOMEM;
 		goto failure;
 	}
 
-	error = sysfs_create_files(fs_info->discard_debug_kobj,
-				   discard_debug_attrs);
+	error = sysfs_create_files(fs_info->discard_kobj, discard_attrs);
 	if (error)
 		goto failure;
-#endif
 
 	error = addrm_unknown_feature_attrs(fs_info, true);
 	if (error)
-- 
2.36.1

