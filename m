Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4765740D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 03:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbiGNBLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 13 Jul 2022 21:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiGNBLR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 13 Jul 2022 21:11:17 -0400
Received: from out20-194.mail.aliyun.com (out20-194.mail.aliyun.com [115.124.20.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8A20F58
        for <linux-btrfs@vger.kernel.org>; Wed, 13 Jul 2022 18:11:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04587852|-1;BR=01201311R131S80rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.108353-0.00661385-0.885033;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.OS0MVcN_1657761062;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.OS0MVcN_1657761062)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 09:11:02 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs: slience the sparse warn of rcu_string
Date:   Thu, 14 Jul 2022 09:11:02 +0800
Message-Id: <20220714011102.10544-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.36.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

slience the sparse warn of rcu_string reported by 'make C=1'

Signed-off-by: Wang Yugui <wangyugui@e16-tech.com>
---
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/volumes.c     | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f43196a893ca..25b94e0e433f 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -1007,7 +1007,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	btrfs_sysfs_update_devid(tgt_device);
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &src_device->dev_state))
 		btrfs_scratch_superblocks(fs_info, src_device->bdev,
-					  src_device->name->str);
+					  rcu_str_deref(src_device->name));
 
 	/* write back the superblocks */
 	trans = btrfs_start_transaction(root, 0);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bf4e140f6bfc..e9f62c9c3db5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -398,7 +398,7 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid,
 void btrfs_free_device(struct btrfs_device *device)
 {
 	WARN_ON(!list_empty(&device->post_commit_list));
-	rcu_string_free(device->name);
+	rcu_string_free(rcu_dereference(device->name));
 	extent_io_tree_release(&device->alloc_state);
 	btrfs_destroy_dev_zone_info(device);
 	kfree(device);
@@ -606,7 +606,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
 	if (!device->name)
 		return -EINVAL;
 
-	ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
+	ret = btrfs_get_bdev_and_sb(rcu_str_deref(device->name), flags, holder, 1,
 				    &bdev, &disk_super);
 	if (ret)
 		return ret;
@@ -873,7 +873,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 				disk_super->fsid, devid, found_transid, path,
 				current->comm, task_pid_nr(current));
 
-	} else if (!device->name || strcmp(device->name->str, path)) {
+	} else if (!device->name || strcmp(rcu_str_deref(device->name), path)) {
 		/*
 		 * When FS is already mounted.
 		 * 1. If you are here and if the device->name is NULL that
@@ -943,7 +943,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 			mutex_unlock(&fs_devices->device_list_mutex);
 			return ERR_PTR(-ENOMEM);
 		}
-		rcu_string_free(device->name);
+		rcu_string_free(rcu_dereference(device->name));
 		rcu_assign_pointer(device->name, name);
 		if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state)) {
 			fs_devices->missing_devices--;
@@ -1000,7 +1000,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
 		 * uuid mutex so nothing we touch in here is going to disappear.
 		 */
 		if (orig_dev->name) {
-			name = rcu_string_strdup(orig_dev->name->str,
+			name = rcu_string_strdup(rcu_str_deref(orig_dev->name),
 					GFP_KERNEL);
 			if (!name) {
 				btrfs_free_device(device);
@@ -2182,7 +2182,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	 */
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		btrfs_scratch_superblocks(fs_info, device->bdev,
-					  device->name->str);
+					  rcu_str_deref(device->name));
 		if (device->bdev) {
 			sync_blockdev(device->bdev);
 			invalidate_bdev(device->bdev);
@@ -2297,7 +2297,7 @@ void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev)
 	mutex_unlock(&fs_devices->device_list_mutex);
 
 	btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
-				  tgtdev->name->str);
+				  rcu_str_deref(tgtdev->name));
 
 	btrfs_close_bdev(tgtdev);
 	synchronize_rcu();
-- 
2.36.2

