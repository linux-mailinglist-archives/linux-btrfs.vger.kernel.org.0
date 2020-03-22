Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7170D18E7BA
	for <lists+linux-btrfs@lfdr.de>; Sun, 22 Mar 2020 10:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCVJJR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Mar 2020 05:09:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:50148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgCVJJR (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Mar 2020 05:09:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 11987AC58;
        Sun, 22 Mar 2020 09:09:15 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v2] btrfs: sysfs: Use scnprintf() instead of snprintf()
Date:   Sun, 22 Mar 2020 10:09:11 +0100
Message-Id: <20200322090911.25296-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

snprintf() is a hard-to-use function, and it's especially difficult to
use it properly for concatenating substrings in a buffer with a
limited size.  Since snprintf() returns the would-be-output size, not
the actual size, the subsequent use of snprintf() may point to the
incorrect position easily.  Also, returning the value from snprintf()
directly to sysfs show function would pass a bogus value that is
higher than the actually truncated string.

That said, although the current code doesn't actually overflow the
buffer with PAGE_SIZE, it's a usage that shouldn't be done.  Or it's
worse; this gives a wrong confidence as if it were doing safe
operations.

This patch replaces such snprintf() calls with a safer version,
scnprintf().  It returns the actual output size, hence it's more
intuitive and the code does what's expected.

Cc: Anand Jain <anand.jain@oracle.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

v1->v2: Rephrase changelog
	Cover more snprintf() calls

 fs/btrfs/sysfs.c | 80 ++++++++++++++++++++++++++++----------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 93cf76118a04..aeb9fd1ef74e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -155,7 +155,7 @@ static ssize_t btrfs_feature_attr_show(struct kobject *kobj,
 	} else
 		val = can_modify_feature(fa);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 
 static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
@@ -295,7 +295,7 @@ static const struct attribute_group btrfs_feature_attr_group = {
 static ssize_t rmdir_subvol_show(struct kobject *kobj,
 				 struct kobj_attribute *ka, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "0\n");
+	return scnprintf(buf, PAGE_SIZE, "0\n");
 }
 BTRFS_ATTR(static_feature, rmdir_subvol, rmdir_subvol_show);
 
@@ -310,12 +310,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 		 * This "trick" only works as long as 'enum btrfs_csum_type' has
 		 * no holes in it
 		 */
-		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				(i == 0 ? "" : " "), btrfs_super_csum_name(i));
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
+				 (i == 0 ? "" : " "), btrfs_super_csum_name(i));
 
 	}
 
-	ret += snprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
@@ -350,8 +350,8 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%lld\n",
-			atomic64_read(&fs_info->discard_ctl.discardable_bytes));
+	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+			 atomic64_read(&fs_info->discard_ctl.discardable_bytes));
 }
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
 
@@ -361,8 +361,8 @@ static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n",
-			atomic_read(&fs_info->discard_ctl.discardable_extents));
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 atomic_read(&fs_info->discard_ctl.discardable_extents));
 }
 BTRFS_ATTR(discard, discardable_extents, btrfs_discardable_extents_show);
 
@@ -372,8 +372,8 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%lld\n",
-			fs_info->discard_ctl.discard_bitmap_bytes);
+	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+			 fs_info->discard_ctl.discard_bitmap_bytes);
 }
 BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
 
@@ -383,7 +383,7 @@ static ssize_t btrfs_discard_bytes_saved_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%lld\n",
+	return scnprintf(buf, PAGE_SIZE, "%lld\n",
 		atomic64_read(&fs_info->discard_ctl.discard_bytes_saved));
 }
 BTRFS_ATTR(discard, discard_bytes_saved, btrfs_discard_bytes_saved_show);
@@ -394,8 +394,8 @@ static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%lld\n",
-			fs_info->discard_ctl.discard_extent_bytes);
+	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+			 fs_info->discard_ctl.discard_extent_bytes);
 }
 BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
 
@@ -405,8 +405,8 @@ static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			READ_ONCE(fs_info->discard_ctl.iops_limit));
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 READ_ONCE(fs_info->discard_ctl.iops_limit));
 }
 
 static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
@@ -435,8 +435,8 @@ static ssize_t btrfs_discard_kbps_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			READ_ONCE(fs_info->discard_ctl.kbps_limit));
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 READ_ONCE(fs_info->discard_ctl.kbps_limit));
 }
 
 static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
@@ -465,8 +465,8 @@ static ssize_t btrfs_discard_max_discard_size_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
-			READ_ONCE(fs_info->discard_ctl.max_discard_size));
+	return scnprintf(buf, PAGE_SIZE, "%llu\n",
+			 READ_ONCE(fs_info->discard_ctl.max_discard_size));
 }
 
 static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
@@ -530,7 +530,7 @@ static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 	val = *value_ptr;
 	if (lock)
 		spin_unlock(lock);
-	return snprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
 }
 
 static ssize_t global_rsv_size_show(struct kobject *kobj,
@@ -576,7 +576,7 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 			val += block_group->used;
 	}
 	up_read(&sinfo->groups_sem);
-	return snprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
 }
 
 static struct attribute *raid_attrs[] = {
@@ -613,7 +613,7 @@ static ssize_t btrfs_space_info_show_total_bytes_pinned(struct kobject *kobj,
 {
 	struct btrfs_space_info *sinfo = to_space_info(kobj);
 	s64 val = percpu_counter_sum(&sinfo->total_bytes_pinned);
-	return snprintf(buf, PAGE_SIZE, "%lld\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%lld\n", val);
 }
 
 SPACE_INFO_ATTR(flags);
@@ -670,7 +670,7 @@ static ssize_t btrfs_label_show(struct kobject *kobj,
 	ssize_t ret;
 
 	spin_lock(&fs_info->super_lock);
-	ret = snprintf(buf, PAGE_SIZE, label[0] ? "%s\n" : "%s", label);
+	ret = scnprintf(buf, PAGE_SIZE, label[0] ? "%s\n" : "%s", label);
 	spin_unlock(&fs_info->super_lock);
 
 	return ret;
@@ -718,7 +718,7 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
+	return scnprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -728,8 +728,8 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			fs_info->super_copy->sectorsize);
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -739,8 +739,8 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			fs_info->super_copy->sectorsize);
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
@@ -752,7 +752,7 @@ static ssize_t quota_override_show(struct kobject *kobj,
 	int quota_override;
 
 	quota_override = test_bit(BTRFS_FS_QUOTA_OVERRIDE, &fs_info->flags);
-	return snprintf(buf, PAGE_SIZE, "%d\n", quota_override);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", quota_override);
 }
 
 static ssize_t quota_override_store(struct kobject *kobj,
@@ -790,8 +790,8 @@ static ssize_t btrfs_metadata_uuid_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%pU\n",
-			fs_info->fs_devices->metadata_uuid);
+	return scnprintf(buf, PAGE_SIZE, "%pU\n",
+			 fs_info->fs_devices->metadata_uuid);
 }
 
 BTRFS_ATTR(, metadata_uuid, btrfs_metadata_uuid_show);
@@ -802,9 +802,9 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
 
-	return snprintf(buf, PAGE_SIZE, "%s (%s)\n",
-			btrfs_super_csum_name(csum_type),
-			crypto_shash_driver_name(fs_info->csum_shash));
+	return scnprintf(buf, PAGE_SIZE, "%s (%s)\n",
+			 btrfs_super_csum_name(csum_type),
+			 crypto_shash_driver_name(fs_info->csum_shash));
 }
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
@@ -992,7 +992,7 @@ char *btrfs_printable_features(enum btrfs_feature_set set, u64 flags)
 			continue;
 
 		name = btrfs_feature_attrs[set][i].kobj_attr.attr.name;
-		len += snprintf(str + len, bufsize - len, "%s%s",
+		len += scnprintf(str + len, bufsize - len, "%s%s",
 				len ? "," : "", name);
 	}
 
@@ -1201,7 +1201,7 @@ static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 BTRFS_ATTR(devid, in_fs_metadata, btrfs_devinfo_in_fs_metadata_show);
 
@@ -1214,7 +1214,7 @@ static ssize_t btrfs_devinfo_missing_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 BTRFS_ATTR(devid, missing, btrfs_devinfo_missing_show);
 
@@ -1228,7 +1228,7 @@ static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 BTRFS_ATTR(devid, replace_target, btrfs_devinfo_replace_target_show);
 
@@ -1241,7 +1241,7 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
-- 
2.16.4

