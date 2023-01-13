Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14BA66954E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241285AbjAMLQG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 06:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241503AbjAMLOn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 06:14:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D875E662
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 03:11:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 882E760306
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 11:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673608317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xt5EJocVDHW8/pZqHmnK/VdHll/AEM1hkHNBSBrvTu0=;
        b=dt84DA6X+P03Bsi9WavAHH8PgokwqLGHNi/DWhZMon4o/m/auQBXh17KodIjw1u3sbnrm2
        wyDf2hPK9FU82GJdU0QrBfbDqdSb1gD5/5LTngiVwi/jmSpM3jusalPXHg198i7CTMudps
        wyCYMYkBbRtiK4c5eV1xFD91r/rAbYw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 022DB1358A
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 11:11:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HnGqMXw8wWMSLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 11:11:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5] btrfs: update fs features sysfs directory asynchronously
Date:   Fri, 13 Jan 2023 19:11:39 +0800
Message-Id: <c750a14702a842dcd359b05ee79700ae0d0f550f.1673608117.git.wqu@suse.com>
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

- Make __btrfs_(set|clear)_fs_(incompat|compat_ro) helpers to set
  BTRFS_FS_FEATURE_CHANGED flag when needed

- Update btrfs_sysfs_feature_update() to use sysfs_update_group()
  And drop unnecessary arguments.

- Call btrfs_sysfs_feature_update() in cleaner_kthread
  If we have the BTRFS_FS_FEATURE_CHANGED flag set.

- Wake up cleaner_kthread in btrfs_commit_transaction if we have
  BTRFS_FS_FEATURE_CHANGED flag

By this, all the previously dangerous call sites like
btrfs_create_chunk() need no new changes, as above helpers would
have already set the BTRFS_FS_FEATURE_CHANGED flag.

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
  BTRFS_FS_FEATURE_CHANGED flag
  So we don't need to check the return value and manually set the flag.

- Wake up the cleaner in btrfs_commit_transaction()
  This can make the sysfs update as fast as happening in
  btrfs_commit_transaction(), but still doesn't slow down
  btrfs_commit_transaction().

  This also means we don't need to wake up the cleaner manually.

v4:
- Move set_bit(BTRFS_FS_FEATURE_CHANGED) into
  __btrfs_(set|clear)_fs_(incompat|compat_ro) helpers

- Remove unnecessary changes to btrfs_(set|clear)_fs_(incompat|compat_ro)
  helpers
  Since we no longer needsto check the return value, they can stay void.
  This greately reduced the patch size.

- Update the error message for btrfs_sysfs_feature_update()
  Now we output the full per-fs feature path.

- Fix the commit message
  BTRFS_FS_FEATURE_CHANGING -> BTRFS_FS_FEATURE_CHANGED, only in commit
  message.

v5:
- Update the commit message to reflects the change in v4
---
 fs/btrfs/disk-io.c     |  3 +++
 fs/btrfs/fs.c          |  4 ++++
 fs/btrfs/fs.h          |  6 ++++++
 fs/btrfs/sysfs.c       | 29 ++++++++---------------------
 fs/btrfs/sysfs.h       |  3 +--
 fs/btrfs/transaction.c |  5 +++++
 6 files changed, 27 insertions(+), 23 deletions(-)

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
index 5553e1f8afe8..31c1648bc0b4 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -24,6 +24,7 @@ void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
 	}
 }
 
@@ -46,6 +47,7 @@ void __btrfs_clear_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
 	}
 }
 
@@ -68,6 +70,7 @@ void __btrfs_set_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
 	}
 }
 
@@ -90,5 +93,6 @@ void __btrfs_clear_fs_compat_ro(struct btrfs_fs_info *fs_info, u64 flag,
 				name, flag);
 		}
 		spin_unlock(&fs_info->super_lock);
+		set_bit(BTRFS_FS_FEATURE_CHANGED, &fs_info->flags);
 	}
 }
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 37b86acfcbcf..69ce270c5ff9 100644
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
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 45615ce36498..b9f5d1052c0c 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -2272,36 +2272,23 @@ void btrfs_sysfs_del_one_qgroup(struct btrfs_fs_info *fs_info,
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
-
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
+		btrfs_err(fs_info,
+			  "failed to update /sys/fs/btrfs/%pU/features: %d",
+			  fs_info->fs_devices->fsid, ret);
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

