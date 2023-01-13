Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C906668AF6
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 05:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjAMEkS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 23:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbjAMEkP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 23:40:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83C5B91
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 20:40:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DD075D760
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 04:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673584811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GXhg6rrf2Jiz5D6OOdp9uwzU9FJjzkPcXrXDNE0XXC0=;
        b=O70qDwN6rcbUk+jUqcBE9iRNE5a7jf0+OfZaDN7ZNn6okX3iUbI3B99oyYoHej3VG5wUcb
        ZRaoI/TW1muHmSwzqB1TDxYFzNurMkgmqdtjUAQZCuZq6S6nmyAGrP+hgnP/0mLbi7tGU8
        9p4FmF17dlhz8w12Kj0+4keIKOM/6ME=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C1B0D1358A
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 04:40:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +mwGI6rgwGModQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 04:40:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3] btrfs: update fs features sysfs directory asynchronously
Date:   Fri, 13 Jan 2023 12:39:53 +0800
Message-Id: <86ceb095fdfec9fe86dfb8efdd354a298fb685ff.1673583926.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
From the introduction of per-fs feature sysfs interface
(/sys/fs/btrfs/<UUID>/features/), the content of that directory is never
updated.

Thus for the following case, that directory will not show the new
features like RAID56:

 # mkfs.btrfs -f $dev1 $dev2 $dev3
 # mount $dev1 $mnt
 # btrfs balance start -f -mconvert=raid5 $mnt
 # ls /sys/fs/btrfs/$uuid/features/
 extended_iref  free_space_tree  no_holes  skinny_metadata

While after unmount and mount, we got the correct features:

 # umount $mnt
 # mount $dev1 $mnt
 # ls /sys/fs/btrfs/$uuid/features/
 extended_iref  free_space_tree  no_holes  raid56 skinny_metadata

[CAUSE]
Because we never really try to update the content of per-fs features/
directory.

We had an attempt to update the features directory dynamically in commit
14e46e04958d ("btrfs: synchronize incompat feature bits with sysfs
files"), but unfortunately it get reverted in commit e410e34fad91
("Revert "btrfs: synchronize incompat feature bits with sysfs files"").

The exported by never utilized function, btrfs_sysfs_feature_update() is
the leftover of such attempt.

The problem in the original patch is, in the context of
btrfs_create_chunk(), we can not afford to update the sysfs group.

As even if we go sysfs_update_group(), new files will need extra memory
allocation, and we have no way to specify the sysfs update to go
GFP_NOFS.

[FIX]
This patch will address the old problem by doing asynchronous sysfs
update in cleaner thread.

This involves the following changes:

- Allow __btrfs_(set|clear)_fs_(incompat|compat_ro) functions to return
  bool
  This allows us to know if we changed the feature.

- Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
  BTRFS_FS_FEATURE_CHANGING flag when needed

- Update btrfs_sysfs_feature_update() to use sysfs_update_group()
  And drop unnecessary arguments.

- Call btrfs_sysfs_feature_update() in cleaner_kthread
  If we have the BTRFS_FS_FEATURE_CHANGING flag set.

- Wake up cleaner_kthread in btrfs_commit_transaction if we have
  BTRFS_FS_FEATURE_CHANGING flag

By this, all the previously dangerous call sites like
btrfs_create_chunk() can just call the new
btrfs_async_update_feature_change() and call it a day.

The real work happens at cleaner_kthread, thus we pay the cost of
delaying the update to sysfs directory, but the delayed time should be
small enough that end user can not distinguish.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix an unused variable in btrfs_parse_options()
  Add the missing btrfs_async_update_feature_change() call.

v3:
- Make btrfs_(set|clear)_fs_(incompat|compat_ro) functions to set
  BTRFS_FS_FEATURE_CHANGING flag
  So we don't need to check the return value and manually set the flag.

- Wake up the cleaner in btrfs_commit_transaction()
  This can make the sysfs update as fast as happening in
  btrfs_commit_transaction(), but still doesn't slow down
  btrfs_commit_transaction().

  This also means we don't need to wake up the cleaner manually.
  The timing is chosen to just after we switched to UNBLOCKED state,
  to avoid cleaner kthread to wait for running transaction.
---
 fs/btrfs/disk-io.c     |  3 +++
 fs/btrfs/fs.c          | 28 +++++++++++++++++++--------
 fs/btrfs/fs.h          | 44 +++++++++++++++++++++++++++++++++---------
 fs/btrfs/sysfs.c       | 26 ++++++-------------------
 fs/btrfs/sysfs.h       |  3 +--
 fs/btrfs/transaction.c |  5 +++++
 6 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7586a8e9b718..a6f89ac1c086 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1914,6 +1914,9 @@ static int cleaner_kthread(void *arg)
 			goto sleep;
 		}
 
+		if (test_and_clear_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags))
+			btrfs_sysfs_feature_update(fs_info);
+
 		btrfs_run_delayed_iputs(fs_info);
 
 		again = btrfs_clean_one_deleted_snapshot(fs_info);
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 5553e1f8afe8..a02e6b6cb97c 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -5,15 +5,17 @@
 #include "fs.h"
 #include "accessors.h"
 
-void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name)
 {
 	struct btrfs_super_block *disk_super;
+	bool changed;
 	u64 features;
 
 	disk_super = fs_info->super_copy;
 	features = btrfs_super_incompat_flags(disk_super);
-	if (!(features & flag)) {
+	changed = !(features & flag);
+	if (changed) {
 		spin_lock(&fs_info->super_lock);
 		features = btrfs_super_incompat_flags(disk_super);
 		if (!(features & flag)) {
@@ -25,17 +27,20 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
+	return changed;
 }
 
-void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			       const char *name)
 {
 	struct btrfs_super_block *disk_super;
+	bool changed;
 	u64 features;
 
 	disk_super = fs_info->super_copy;
 	features = btrfs_super_incompat_flags(disk_super);
-	if (features & flag) {
+	changed = features & flag;
+	if (changed) {
 		spin_lock(&fs_info->super_lock);
 		features = btrfs_super_incompat_flags(disk_super);
 		if (features & flag) {
@@ -47,17 +52,20 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
+	return changed;
 }
 
-void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 			      const char *name)
 {
 	struct btrfs_super_block *disk_super;
+	bool changed;
 	u64 features;
 
 	disk_super = fs_info->super_copy;
 	features = btrfs_super_compat_ro_flags(disk_super);
-	if (!(features & flag)) {
+	changed = !(features & flag);
+	if (changed) {
 		spin_lock(&fs_info->super_lock);
 		features = btrfs_super_compat_ro_flags(disk_super);
 		if (!(features & flag)) {
@@ -69,17 +77,20 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
+	return changed;
 }
 
-void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				const char *name)
 {
 	struct btrfs_super_block *disk_super;
+	bool changed;
 	u64 features;
 
 	disk_super = fs_info->super_copy;
 	features = btrfs_super_compat_ro_flags(disk_super);
-	if (features & flag) {
+	changed = features & flag;
+	if (changed) {
 		spin_lock(&fs_info->super_lock);
 		features = btrfs_super_compat_ro_flags(disk_super);
 		if (features & flag) {
@@ -91,4 +102,5 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 		}
 		spin_unlock(&fs_info->super_lock);
 	}
+	return changed;
 }
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 37b86acfcbcf..503132d90239 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -130,6 +130,12 @@ enum {
 	BTRFS_FS_32BIT_ERROR,
 	BTRFS_FS_32BIT_WARN,
 #endif
+
+	/*
+	 * Indicate if we have some features changed, this is mostly for
+	 * cleaner thread to update the sysfs interface.
+	 */
+	BTRFS_FS_FEATURE_CHANGED,
 };
 
 /*
@@ -868,14 +874,18 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
 void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 			  enum btrfs_exclusive_operation op);
 
-/* Compatibility and incompatibility defines */
-void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+/*
+ * Compatibility and incompatibility defines.
+ *
+ * Return value is whether the operation changed the specified feature.
+ */
+bool __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
-void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			       const char *name);
-void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 			      const char *name);
-void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
+bool __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				const char *name);
 
 #define __btrfs_fs_incompat(fs_info, flags)				\
@@ -885,19 +895,35 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 	(!!(btrfs_super_compat_ro_flags((fs_info)->super_copy) & (flags)))
 
 #define btrfs_set_fs_incompat(__fs_info, opt)				\
-	__btrfs_set_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, #opt)
+({									\
+	if (__btrfs_set_fs_incompat((__fs_info),			\
+				BTRFS_FEATURE_INCOMPAT_##opt, #opt))	\
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
+})
 
 #define btrfs_clear_fs_incompat(__fs_info, opt)				\
-	__btrfs_clear_fs_incompat((__fs_info), BTRFS_FEATURE_INCOMPAT_##opt, #opt)
+({									\
+	if (__btrfs_clear_fs_incompat((__fs_info),			\
+				BTRFS_FEATURE_INCOMPAT_##opt, #opt))	\
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
+})
 
 #define btrfs_fs_incompat(fs_info, opt)					\
 	__btrfs_fs_incompat((fs_info), BTRFS_FEATURE_INCOMPAT_##opt)
 
 #define btrfs_set_fs_compat_ro(__fs_info, opt)				\
-	__btrfs_set_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, #opt)
+({									\
+	if (__btrfs_set_fs_compat_ro((__fs_info),			\
+			BTRFS_FEATURE_COMPAT_RO_##opt, #opt))		\
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
+})
 
 #define btrfs_clear_fs_compat_ro(__fs_info, opt)			\
-	__btrfs_clear_fs_compat_ro((__fs_info), BTRFS_FEATURE_COMPAT_RO_##opt, #opt)
+({									\
+	if (__btrfs_clear_fs_compat_ro((__fs_info),			\
+			BTRFS_FEATURE_COMPAT_RO_##opt, #opt))		\
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &(__fs_info)->flags);	\
+})
 
 #define btrfs_fs_compat_ro(fs_info, opt)				\
 	__btrfs_fs_compat_ro((fs_info), BTRFS_FEATURE_COMPAT_RO_##opt)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 45615ce36498..f86c107ea2e4 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2272,36 +2272,22 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
  * Change per-fs features in /sys/fs/btrfs/UUID/features to match current
  * values in superblock. Call after any changes to incompat/compat_ro flags
  */
-void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
-		u64 bit, enum btrfs_feature_set set)
+void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info)
 {
-	struct btrfs_fs_devices *fs_devs;
 	struct kobject *fsid_kobj;
-	u64 __maybe_unused features;
-	int __maybe_unused ret;
+	int ret;
 
 	if (!fs_info)
 		return;
 
-	/*
-	 * See 14e46e04958df74 and e410e34fad913dd, feature bit updates are not
-	 * safe when called from some contexts (eg. balance)
-	 */
-	features = get_features(fs_info, set);
-	ASSERT(bit & supported_feature_masks[set]);
-
-	fs_devs = fs_info->fs_devices;
-	fsid_kobj = &fs_devs->fsid_kobj;
+	fsid_kobj = &fs_info->fs_devices->fsid_kobj;
 
 	if (!fsid_kobj->state_initialized)
 		return;
 
-	/*
-	 * FIXME: this is too heavy to update just one value, ideally we'd like
-	 * to use sysfs_update_group but some refactoring is needed first.
-	 */
-	sysfs_remove_group(fsid_kobj, &btrfs_feature_attr_group);
-	ret = sysfs_create_group(fsid_kobj, &btrfs_feature_attr_group);
+	ret = sysfs_update_group(fsid_kobj, &btrfs_feature_attr_group);
+	if (ret < 0)
+		btrfs_err(fs_info, "failed to update features: %d", ret);
 }
 
 int __init btrfs_init_sysfs(void)
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index bacef43f7267..86c7eef12873 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -19,8 +19,7 @@ void btrfs_sysfs_remove_device(struct btrfs_device *device);
 int btrfs_sysfs_add_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_remove_fsid(struct btrfs_fs_devices *fs_devs);
 void btrfs_sysfs_update_sprout_fsid(struct btrfs_fs_devices *fs_devices);
-void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info,
-		u64 bit, enum btrfs_feature_set set);
+void btrfs_sysfs_feature_update(struct btrfs_fs_info *fs_info);
 void btrfs_kobject_uevent(struct block_device *bdev, enum kobject_action action);
 
 int __init btrfs_init_sysfs(void);
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 528efe559866..18329ebcb1cb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2464,6 +2464,11 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	wake_up(&fs_info->transaction_wait);
 	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_UNBLOCKED);
 
+	/* If we have features changed, wake up the cleaner to update sysfs. */
+	if (test_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags) &&
+	    fs_info->cleaner_kthread)
+		wake_up_process(fs_info->cleaner_kthread);
+
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (ret) {
 		btrfs_handle_fs_error(fs_info, ret,
-- 
2.39.0

