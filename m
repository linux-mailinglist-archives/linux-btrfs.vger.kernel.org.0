Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846E6118127
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 08:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfLJHOH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 02:14:07 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:53111 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727334AbfLJHOH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 02:14:07 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 47XBBN4Gf4z8tk0;
        Tue, 10 Dec 2019 08:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1575962044; bh=GDPEtcLteM6DrZvlrn39MBW0Xw9i60XgnadnwiEeMxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=e/OGtR/z/RaCXRL9aFAuvU24nLjEB8OB6NmWwYh9ntGhxhbjAUO3imShK4HT/S+Uu
         BrkSgmIlmuXyNylYGZZbUKFryMNDOObEcL+oUml9RcjWUmRl0FNXsPAgGDQL9Jxbh3
         B4f2lYdWZMnXM32+wadW0YVpdvaxioArk37Hh0yOmjmJMxDAYhKMN3kv5zbT58bLGP
         4jTPuX1ie7bOiIex0/YMaZnCe7a8yw/I/YmMEcltyeeArOR9k55e8gstmwWkSYr/KW
         u4egPmnGVG58FOpveeDlTVQSQHlsuOuGl5oaU5c7JfbbIxUlnviEhCbsQ6KAuXI+Z5
         582dvGHckCmpw==
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.22.146
Received: from localhost.localdomain (firewall.henke.stw.uni-erlangen.de [131.188.22.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+J9Ii4XGJ5Qye3YUXmIDLnOcPvROGOJP8=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 47XBBK5SfLz8v8y;
        Tue, 10 Dec 2019 08:14:01 +0100 (CET)
From:   Sebastian <sebastian.scherbel@fau.de>
To:     dsterba@suse.com
Cc:     josef@toxicpanda.com, clm@fb.com, linux-btrfs@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Sebastian Scherbel <sebastian.scherbel@fau.de>,
        Ole Wiedemann <ole.wiedemann@fau.de>
Subject: [PATCH 1/5] fs_btrfs_sysfs: code cleanup
Date:   Tue, 10 Dec 2019 08:13:53 +0100
Message-Id: <20191210071357.5323-2-sebastian.scherbel@fau.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191210071357.5323-1-sebastian.scherbel@fau.de>
References: <20191210071357.5323-1-sebastian.scherbel@fau.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Sebastian Scherbel <sebastian.scherbel@fau.de>

This patch changes several instances in sysfs where the coding style is not
in line with the Linux kernel guidelines to improve readability.

1. Symbolic permissions like 'S_IRUGO' are not preferred, they are
converted into their octal representation
2. lines with more than 80 characters are broken into sensible chunks,
unless exceeding the limit significantly increases readability
3. missing blank lines after declerations are added
4. tabs are used for indentations where possible

Signed-off-by: Sebastian Scherbel <sebastian.scherbel@fau.de>
Co-developed-by: Ole Wiedemann <ole.wiedemann@fau.de>
Signed-off-by: Ole Wiedemann <ole.wiedemann@fau.de>
---
 fs/btrfs/sysfs.c | 33 ++++++++++++++++++++++++++-------
 fs/btrfs/sysfs.h |  5 +++--
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..30221dfb7f5c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -51,7 +51,7 @@ struct raid_kobject {
 
 #define BTRFS_FEAT_ATTR(_name, _feature_set, _feature_prefix, _feature_bit)  \
 static struct btrfs_feature_attr btrfs_attr_features_##_name = {	     \
-	.kobj_attr = __INIT_KOBJ_ATTR(_name, S_IRUGO,			     \
+	.kobj_attr = __INIT_KOBJ_ATTR(_name, 0444,			     \
 				      btrfs_feature_attr_show,		     \
 				      btrfs_feature_attr_store),	     \
 	.feature_set	= _feature_set,					     \
@@ -90,6 +90,7 @@ static u64 get_features(struct btrfs_fs_info *fs_info,
 			enum btrfs_feature_set set)
 {
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
+
 	if (set == FEAT_COMPAT)
 		return btrfs_super_compat_flags(disk_super);
 	else if (set == FEAT_COMPAT_RO)
@@ -102,6 +103,7 @@ static void set_features(struct btrfs_fs_info *fs_info,
 			 enum btrfs_feature_set set, u64 features)
 {
 	struct btrfs_super_block *disk_super = fs_info->super_copy;
+
 	if (set == FEAT_COMPAT)
 		btrfs_set_super_compat_flags(disk_super, features);
 	else if (set == FEAT_COMPAT_RO)
@@ -114,6 +116,7 @@ static int can_modify_feature(struct btrfs_feature_attr *fa)
 {
 	int val = 0;
 	u64 set, clear;
+
 	switch (fa->feature_set) {
 	case FEAT_COMPAT:
 		set = BTRFS_FEATURE_COMPAT_SAFE_SET;
@@ -147,8 +150,10 @@ static ssize_t btrfs_feature_attr_show(struct kobject *kobj,
 	int val = 0;
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	struct btrfs_feature_attr *fa = to_btrfs_feature_attr(a);
+
 	if (fs_info) {
 		u64 features = get_features(fs_info, fa->feature_set);
+
 		if (features & fa->feature_bit)
 			val = 1;
 	} else
@@ -239,7 +244,7 @@ static umode_t btrfs_feature_visible(struct kobject *kobj,
 		features = get_features(fs_info, fa->feature_set);
 
 		if (can_modify_feature(fa))
-			mode |= S_IWUSR;
+			mode |= 0200;
 		else if (!(features & fa->feature_bit))
 			mode = 0;
 	}
@@ -358,6 +363,7 @@ static const struct attribute_group btrfs_debug_feature_attr_group = {
 static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 {
 	u64 val;
+
 	if (lock)
 		spin_lock(lock);
 	val = *value_ptr;
@@ -371,6 +377,7 @@ static ssize_t global_rsv_size_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
+
 	return btrfs_show_u64(&block_rsv->size, &block_rsv->lock, buf);
 }
 BTRFS_ATTR(allocation, global_rsv_size, global_rsv_size_show);
@@ -380,6 +387,7 @@ static ssize_t global_rsv_reserved_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj->parent);
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
+
 	return btrfs_show_u64(&block_rsv->reserved, &block_rsv->lock, buf);
 }
 BTRFS_ATTR(allocation, global_rsv_reserved, global_rsv_reserved_show);
@@ -436,6 +444,7 @@ static ssize_t btrfs_space_info_show_##field(struct kobject *kobj,	\
 					     char *buf)			\
 {									\
 	struct btrfs_space_info *sinfo = to_space_info(kobj);		\
+									\
 	return btrfs_show_u64(&sinfo->field, &sinfo->lock, buf);	\
 }									\
 BTRFS_ATTR(space_info, field, btrfs_space_info_show_##field)
@@ -446,6 +455,7 @@ static ssize_t btrfs_space_info_show_total_bytes_pinned(struct kobject *kobj,
 {
 	struct btrfs_space_info *sinfo = to_space_info(kobj);
 	s64 val = percpu_counter_sum(&sinfo->total_bytes_pinned);
+
 	return snprintf(buf, PAGE_SIZE, "%lld\n", val);
 }
 
@@ -479,6 +489,7 @@ ATTRIBUTE_GROUPS(space_info);
 static void space_info_release(struct kobject *kobj)
 {
 	struct btrfs_space_info *sinfo = to_space_info(kobj);
+
 	percpu_counter_destroy(&sinfo->total_bytes_pinned);
 	kfree(sinfo);
 }
@@ -682,8 +693,10 @@ static inline struct btrfs_fs_info *to_fs_info(struct kobject *kobj)
 
 #define NUM_FEATURE_BITS 64
 #define BTRFS_FEATURE_NAME_MAX 13
-static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS][BTRFS_FEATURE_NAME_MAX];
-static struct btrfs_feature_attr btrfs_feature_attrs[FEAT_MAX][NUM_FEATURE_BITS];
+static char btrfs_unknown_feature_names[FEAT_MAX][NUM_FEATURE_BITS]
+				       [BTRFS_FEATURE_NAME_MAX];
+static struct btrfs_feature_attr btrfs_feature_attrs[FEAT_MAX]
+						    [NUM_FEATURE_BITS];
 
 static const u64 supported_feature_masks[FEAT_MAX] = {
 	[FEAT_COMPAT]    = BTRFS_FEATURE_COMPAT_SUPP,
@@ -703,6 +716,7 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 			.attrs = attrs,
 		};
 		u64 features = get_features(fs_info, set);
+
 		features &= ~supported_feature_masks[set];
 
 		if (!features)
@@ -719,6 +733,7 @@ static int addrm_unknown_feature_attrs(struct btrfs_fs_info *fs_info, bool add)
 			attrs[0] = &fa->kobj_attr.attr;
 			if (add) {
 				int ret;
+
 				ret = sysfs_merge_group(&fs_info->fs_devices->fsid_kobj,
 							&agroup);
 				if (ret)
@@ -772,7 +787,8 @@ void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info)
 		kobject_put(fs_info->space_info_kobj);
 	}
 	addrm_unknown_feature_attrs(fs_info, false);
-	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj, &btrfs_feature_attr_group);
+	sysfs_remove_group(&fs_info->fs_devices->fsid_kobj,
+			   &btrfs_feature_attr_group);
 	sysfs_remove_files(&fs_info->fs_devices->fsid_kobj, btrfs_attrs);
 	btrfs_sysfs_rm_device_link(fs_info->fs_devices, NULL);
 }
@@ -831,6 +847,7 @@ static void init_feature_attrs(void)
 		struct btrfs_feature_attr *sfa;
 		struct attribute *a = btrfs_supported_feature_attrs[i];
 		int bit;
+
 		sfa = attr_to_btrfs_feature_attr(a);
 		bit = ilog2(sfa->feature_bit);
 		fa = &btrfs_feature_attrs[sfa->feature_set][bit];
@@ -841,6 +858,7 @@ static void init_feature_attrs(void)
 	for (set = 0; set < FEAT_MAX; set++) {
 		for (i = 0; i < ARRAY_SIZE(btrfs_feature_attrs[set]); i++) {
 			char *name = btrfs_unknown_feature_names[set][i];
+
 			fa = &btrfs_feature_attrs[set][i];
 
 			if (fa->kobj_attr.attr.name)
@@ -850,7 +868,7 @@ static void init_feature_attrs(void)
 				 btrfs_feature_set_names[set], i);
 
 			fa->kobj_attr.attr.name = name;
-			fa->kobj_attr.attr.mode = S_IRUGO;
+			fa->kobj_attr.attr.mode = 0444;
 			fa->feature_set = set;
 			fa->feature_bit = 1ULL << i;
 		}
@@ -1189,7 +1207,8 @@ int __init btrfs_init_sysfs(void)
 		goto out_remove_group;
 
 #ifdef CONFIG_BTRFS_DEBUG
-	ret = sysfs_create_group(&btrfs_kset->kobj, &btrfs_debug_feature_attr_group);
+	ret = sysfs_create_group(&btrfs_kset->kobj,
+				 &btrfs_debug_feature_attr_group);
 	if (ret)
 		goto out2;
 #endif
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index e10c3adfc30f..7c2222d7046e 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -17,7 +17,7 @@ const char * const btrfs_feature_set_name(enum btrfs_feature_set set);
 int btrfs_sysfs_add_device_link(struct btrfs_fs_devices *fs_devices,
 		struct btrfs_device *one_device);
 int btrfs_sysfs_rm_device_link(struct btrfs_fs_devices *fs_devices,
-                struct btrfs_device *one_device);
+		struct btrfs_device *one_device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs,
 				struct kobject *parent);
 int btrfs_sysfs_add_device(struct btrfs_fs_devices *fs_devs);
@@ -26,7 +26,8 @@ void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices,
 				    const u8 *fsid);
 void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
 		u64 bit, enum btrfs_feature_set set);
-void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
+void btrfs_kobject_uevent(struct block_device *bdev,
+			  enum kobject_action action);
 
 int __init btrfs_init_sysfs(void);
 void __cold btrfs_exit_sysfs(void);
-- 
2.20.1

