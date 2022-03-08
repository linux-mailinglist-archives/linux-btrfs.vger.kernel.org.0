Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479814D0F3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Mar 2022 06:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245261AbiCHFh6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 00:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbiCHFh5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 00:37:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A333B570
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 21:36:58 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D436210F2;
        Tue,  8 Mar 2022 05:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646717817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eozi+HKksslypAmBtB/YNSM0YJo3JL3e/VsI50+78dU=;
        b=aM9tFNkNtb2iu/RI23moGZ82sQM2EQ5IEWGiiPHfBwlZPCROUIi+4cjQFGx8WFGduVN/FD
        8bbOfKxAmMMprJH2xKbpPgn/lbOzFGXaMV0F5WRdTyyzU9E5sTldwhvd/xuPj1LViluzwJ
        M1h73KkrYpSR+VCIb9TzOebYEU2jUP8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C50913C0F;
        Tue,  8 Mar 2022 05:36:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KOPYCnjrJmKfTwAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 08 Mar 2022 05:36:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?Luca=20B=C3=A9la=20Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Subject: [PATCH] btrfs: make device item removal and super block num devices update happen in the same transaction
Date:   Tue,  8 Mar 2022 13:36:38 +0800
Message-Id: <b86647c31a09ccc44447367865ecac8d5b358b7c.1646717720.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a report that a btrfs has a bad super block num devices.

This makes btrfs to reject the fs completely.

  BTRFS error (device sdd3): super_num_devices 3 mismatch with num_devices 2 found here
  BTRFS error (device sdd3): failed to read chunk tree: -22
  BTRFS error (device sdd3): open_ctree failed

[CAUSE]
During btrfs device removal, chunk tree and super block num devs are
updated in two different transactions:

  btrfs_rm_device()
  |- btrfs_rm_dev_item(device)
  |  |- trans = btrfs_start_transaction()
  |  |  Now we got transaction X
  |  |
  |  |- btrfs_del_item()
  |  |  Now device item is removed from chunk tree
  |  |
  |  |- btrfs_commit_transaction()
  |     Transaction X got committed, super num devs untouched,
  |     but device item removed from chunk tree.
  |     (AKA, super num devs is already incorrect)
  |
  |- cur_devices->num_devices--;
  |- cur_devices->total_devices--;
  |- btrfs_set_super_num_devices()
     All those operations are not in transaction X, thus it will
     only be written back to disk in next transaction.

So after the transaction X in btrfs_rm_dev_item() committed, but before
transaction X+1 (which can be minutes away), a power loss happen, then
we got the super num mismatch.

[FIX]
Instead of starting and committing a transaction inside
btrfs_rm_dev_item(), start a transaction in side btrfs_rm_device() and
pass it to btrfs_rm_dev_item().

And only commit the transaction after everything is done.

Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 65 ++++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 57a754b33f10..6115c302f4ae 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1896,23 +1896,18 @@ static void update_dev_time(const char *device_path)
 	path_put(&path);
 }
 
-static int btrfs_rm_dev_item(struct btrfs_device *device)
+static int btrfs_rm_dev_item(struct btrfs_trans_handle *trans,
+			     struct btrfs_device *device)
 {
 	struct btrfs_root *root = device->fs_info->chunk_root;
 	int ret;
 	struct btrfs_path *path;
 	struct btrfs_key key;
-	struct btrfs_trans_handle *trans;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction(root, 0);
-	if (IS_ERR(trans)) {
-		btrfs_free_path(path);
-		return PTR_ERR(trans);
-	}
 	key.objectid = BTRFS_DEV_ITEMS_OBJECTID;
 	key.type = BTRFS_DEV_ITEM_KEY;
 	key.offset = device->devid;
@@ -1923,21 +1918,12 @@ static int btrfs_rm_dev_item(struct btrfs_device *device)
 	if (ret) {
 		if (ret > 0)
 			ret = -ENOENT;
-		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
 		goto out;
 	}
 
 	ret = btrfs_del_item(trans, root, path);
-	if (ret) {
-		btrfs_abort_transaction(trans, ret);
-		btrfs_end_transaction(trans);
-	}
-
 out:
 	btrfs_free_path(path);
-	if (!ret)
-		ret = btrfs_commit_transaction(trans);
 	return ret;
 }
 
@@ -2078,6 +2064,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		    struct btrfs_dev_lookup_args *args,
 		    struct block_device **bdev, fmode_t *mode)
 {
+	struct btrfs_trans_handle *trans;
 	struct btrfs_device *device;
 	struct btrfs_fs_devices *cur_devices;
 	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
@@ -2098,7 +2085,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 
 	ret = btrfs_check_raid_min_devices(fs_info, num_devices - 1);
 	if (ret)
-		goto out;
+		return ret;
 
 	device = btrfs_find_device(fs_info->fs_devices, args);
 	if (!device) {
@@ -2106,27 +2093,22 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 			ret = BTRFS_ERROR_DEV_MISSING_NOT_FOUND;
 		else
 			ret = -ENOENT;
-		goto out;
+		return ret;
 	}
 
 	if (btrfs_pinned_by_swapfile(fs_info, device)) {
 		btrfs_warn_in_rcu(fs_info,
 		  "cannot remove device %s (devid %llu) due to active swapfile",
 				  rcu_str_deref(device->name), device->devid);
-		ret = -ETXTBSY;
-		goto out;
+		return -ETXTBSY;
 	}
 
-	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
-		ret = BTRFS_ERROR_DEV_TGT_REPLACE;
-		goto out;
-	}
+	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
+		return BTRFS_ERROR_DEV_TGT_REPLACE;
 
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
-	    fs_info->fs_devices->rw_devices == 1) {
-		ret = BTRFS_ERROR_DEV_ONLY_WRITABLE;
-		goto out;
-	}
+	    fs_info->fs_devices->rw_devices == 1)
+		return BTRFS_ERROR_DEV_ONLY_WRITABLE;
 
 	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
 		mutex_lock(&fs_info->chunk_mutex);
@@ -2139,14 +2121,22 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	if (ret)
 		goto error_undo;
 
-	/*
-	 * TODO: the superblock still includes this device in its num_devices
-	 * counter although write_all_supers() is not locked out. This
-	 * could give a filesystem state which requires a degraded mount.
-	 */
-	ret = btrfs_rm_dev_item(device);
-	if (ret)
+	trans = btrfs_start_transaction(fs_info->chunk_root, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
 		goto error_undo;
+	}
+
+	ret = btrfs_rm_dev_item(trans, device);
+	if (ret) {
+		/* Any error in dev item removal is critical */
+		btrfs_crit(fs_info,
+			   "failed to remove device item for devid %llu: %d",
+			   device->devid, ret);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
 
 	clear_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 	btrfs_scrub_cancel_dev(device);
@@ -2229,7 +2219,8 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		free_fs_devices(cur_devices);
 	}
 
-out:
+	ret = btrfs_commit_transaction(trans);
+
 	return ret;
 
 error_undo:
@@ -2240,7 +2231,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 		device->fs_devices->rw_devices++;
 		mutex_unlock(&fs_info->chunk_mutex);
 	}
-	goto out;
+	return ret;
 }
 
 void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev)
-- 
2.35.1

