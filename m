Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE5A583D88
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Jul 2022 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbiG1Lgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Jul 2022 07:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbiG1Lgm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Jul 2022 07:36:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2094B4A9
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Jul 2022 04:36:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3BEAB20C57;
        Thu, 28 Jul 2022 11:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1659008200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24DJsbp5Hvt1kge6l/mIyALGCOKU31eWwLytnpBFKZU=;
        b=lEp7sEAyBXPvF773Z5XMBv1Y8xjtrlANhGg334IOB++vnQCkHDEWXrxdiBVELudrb5r/7A
        hUOESlYc0PT3/QUkeaRPYwGPZNSr3VcdLXQs/0FoxrgDVgRddkNmsRzdtWEROCthCpOkcd
        sAA2jhRPhHWuE8vSBVJkGYFPU+P5xlk=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1C1E82C141;
        Thu, 28 Jul 2022 11:36:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C36A4DA83C; Thu, 28 Jul 2022 13:31:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: sysfs: show discard stats and tunables in non-debug build
Date:   Thu, 28 Jul 2022 13:31:41 +0200
Message-Id: <20220728113141.15545-1-dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220727175659.16661-1-dsterba@suse.com>
References: <20220727175659.16661-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v2:
- add CONFIG_BTRFS_DEBUG back to btrfs_sysfs_remove_mounted when
  debug_kobj is removed

 fs/btrfs/ctree.h |  2 +-
 fs/btrfs/sysfs.c | 35 ++++++++++++++++-------------------
 2 files changed, 17 insertions(+), 20 deletions(-)

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
index d5d0717fd09a..32714ef8e22b 100644
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
@@ -1427,13 +1427,12 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
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
+#ifdef CONFIG_BTRFS_DEBUG
 	if (fs_info->debug_kobj) {
 		sysfs_remove_files(fs_info->debug_kobj, btrfs_debug_mount_attrs);
 		kobject_del(fs_info->debug_kobj);
@@ -2001,20 +2000,18 @@ int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info)
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

