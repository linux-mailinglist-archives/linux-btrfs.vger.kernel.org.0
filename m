Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F763A0C6B
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jun 2021 08:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhFIG3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Jun 2021 02:29:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhFIG3m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Jun 2021 02:29:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A90B6219C2
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 06:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623220067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=A+jJaKNLgbXOp0BfnipdG2MhV44yu0K77RxVH28/yAk=;
        b=R9iBkcWCYLYGgwEFaXkp2intNplPhy0CDJLX9qD+ySBsFHI7l1TrWsVKGRQpF4wWtWtd87
        A0sW/aIq3uoUl4VEn6WK8jY+y9LlcqvNBPAwPIlAMjm4DGYLq9nlVqgc7JAVKXZVLSH781
        qgnlyFUdYL/D8dD771A8Q6rkI9PVn0Y=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 821C1A3B81
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Jun 2021 06:27:46 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: check: add the ability to reset btrfs_dev_item::bytes_used
Date:   Wed,  9 Jun 2021 14:27:42 +0800
Message-Id: <20210609062743.190936-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a report from the mail list that one user got its filesystem
with device item bytes_used mismatch.

This problem leaves the device item with some ghost bytes_used, meaning
even if we delete all device extents of that device, the bytes_used
still won't be 0.

This itself is not a big deal, but when the user used up all its
unallocated space, write time tree-checker can be triggered and make the
fs RO, as the new device::bytes_used can be larger than
device::total_bytes.

Thus we need to fix the problem in btrfs-check to avoid above write-time
tree check warning.

This patch will add the ability to reset a device's bytes_used to both
original mode and lowmem mode.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        |  8 ++++++-
 check/mode-common.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 check/mode-common.h |  2 ++
 check/mode-lowmem.c | 14 +++++++++--
 4 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index ee6cf793251c..6cf96b1a9b3b 100644
--- a/check/main.c
+++ b/check/main.c
@@ -8397,11 +8397,17 @@ static int check_device_used(struct device_record *dev_rec,
 	}
 
 	if (total_byte != dev_rec->byte_used) {
+		int ret = -1;
+
 		fprintf(stderr,
 			"Dev extent's total-byte(%llu) is not equal to byte-used(%llu) in dev[%llu, %u, %llu]\n",
 			total_byte, dev_rec->byte_used,	dev_rec->objectid,
 			dev_rec->type, dev_rec->offset);
-		return -1;
+		if (repair) {
+			ret = repair_dev_item_bytes_used(gfs_info,
+					dev_rec->devid, total_byte);
+		}
+		return ret;
 	} else {
 		return 0;
 	}
diff --git a/check/mode-common.c b/check/mode-common.c
index cb22f3233c00..5764bf6ee54c 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -21,6 +21,7 @@
 #include "kernel-shared/transaction.h"
 #include "common/utils.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/volumes.h"
 #include "common/repair.h"
 #include "check/mode-common.h"
 
@@ -1243,3 +1244,59 @@ out:
 	btrfs_release_path(&path);
 	return ret;
 }
+
+int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
+			       u64 devid, u64 bytes_used_expected)
+{
+	struct btrfs_trans_handle *trans;
+	struct btrfs_device *device;
+	int ret;
+
+	device = btrfs_find_device_by_devid(fs_info->fs_devices, devid, 0);
+	if (!device) {
+		error("failed to find device with devid %llu", devid);
+		return -ENOENT;
+	}
+
+	/* Bytes_used matches, not what we can repair */
+	if (device->bytes_used == bytes_used_expected)
+		return -ENOTSUP;
+
+	/*
+	 * We have to set the device bytes used right now, before
+	 * starting a new transaction, as it may allocate new chunk and
+	 * modify device->bytes_used.
+	 */
+	device->bytes_used = bytes_used_expected;
+	trans = btrfs_start_transaction(fs_info->chunk_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction: %d (\"%m\")", ret);
+		return ret;
+	}
+
+	/* Manually update the device item in chunk tree */
+	ret = btrfs_update_device(trans, device);
+	if (ret < 0) {
+		error(
+		"failed to update device item for devid %llu: %d (\"%m\")",
+		      devid, ret);
+		goto error;
+	}
+
+	/*
+	 * Commit transaction not only to save above change but also update
+	 * the device item in super block.
+	 */
+	ret = btrfs_commit_transaction(trans, fs_info->chunk_root);
+	if (ret < 0)
+		error("failed to commit transaction: %d (\"%m\")", ret);
+	else
+		printf("reset devid %llu bytes_used to %llu\n", devid,
+		       device->bytes_used);
+	return ret;
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index 3ba29ecab6cd..711eced3acf0 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -192,4 +192,6 @@ static inline void btrfs_check_subpage_eb_alignment(u64 start, u32 len)
 			start, start + len);
 }
 
+int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
+			       u64 devid, u64 bytes_used_expected);
 #endif
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 2f736712bc7f..64f09e68516c 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -4454,7 +4454,8 @@ out:
 /*
  * Check if the used space is correct with the dev item
  */
-static int check_dev_item(struct extent_buffer *eb, int slot)
+static int check_dev_item(struct extent_buffer *eb, int slot,
+			  u64 *bytes_used_expected)
 {
 	struct btrfs_root *dev_root = gfs_info->dev_root;
 	struct btrfs_dev_item *dev_item;
@@ -4543,6 +4544,7 @@ next:
 	}
 	btrfs_release_path(&path);
 
+	*bytes_used_expected = total;
 	if (used != total) {
 		btrfs_item_key_to_cpu(eb, &key, slot);
 		error(
@@ -4744,6 +4746,7 @@ static int repair_chunk_item(struct btrfs_root *chunk_root,
 static int check_leaf_items(struct btrfs_root *root, struct btrfs_path *path,
 			    struct node_refs *nrefs, int account_bytes)
 {
+	u64 bytes_used_expected = (u64)-1;
 	struct btrfs_key key;
 	struct extent_buffer *eb;
 	int slot;
@@ -4782,7 +4785,14 @@ again:
 		err |= ret;
 		break;
 	case BTRFS_DEV_ITEM_KEY:
-		ret = check_dev_item(eb, slot);
+		ret = check_dev_item(eb, slot, &bytes_used_expected);
+		if (repair && ret & ACCOUNTING_MISMATCH &&
+		    bytes_used_expected != (u64)-1) {
+			ret = repair_dev_item_bytes_used(root->fs_info,
+					key.offset, bytes_used_expected);
+			if (ret < 0)
+				ret = ACCOUNTING_MISMATCH;
+		}
 		err |= ret;
 		break;
 	case BTRFS_CHUNK_ITEM_KEY:
-- 
2.32.0

