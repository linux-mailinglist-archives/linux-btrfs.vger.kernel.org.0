Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4051C74A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2019 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfENKyx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 May 2019 06:54:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40876 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbfENKyv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 May 2019 06:54:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E5D0AF8F
        for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2019 10:54:49 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 7/8] btrfs: Ensure replaced device doesn't have pending chunk allocation
Date:   Tue, 14 May 2019 13:54:44 +0300
Message-Id: <20190514105445.23051-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514105445.23051-1-nborisov@suse.com>
References: <20190514105445.23051-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recent FITRIM work, namely bbbf7243d62d ("btrfs: combine device update
operations during transaction commit") combined the way certain
operations are recoded in a transaction. As a result an ASSERT was
added in dev_replace_finish to ensure the new code works correctly.
Unfortunately I got reports that it's possible to trigger the assert,
meaning that during a device replace it's possible to have an unfinished
chunk allocation on the source device.

This is supposed to be prevented by the fact that a transaction is
committed before finishing the replace oepration and alter acquiring
the chunk mutex. This is not sufficient since by the time the
transaction is committed and the chunk mutex acquired it's possible to
allocate a chunk depending on the workload being executed on the
replaced device. This bug has been present ever since device replace was
introduced but there was never code which checks for it.

The correct way to fix is to ensure that there is no pending device
modification operation when the chunk mutex is acquire and if there is
repeat transaction commit. Unfortunately it's not possible to just
exclude the source device from btrfs_fs_devices::dev_alloc_list since
this causes ENOSPC to be hit in transaction commit.

Fixes: 391cd9df81ac ("Btrfs: fix unprotected alloc list insertion during the finishing procedure of replace")
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/dev-replace.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index fb2bbc2a53a9..8ec9328609bd 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -599,17 +599,28 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	}
 	btrfs_wait_ordered_roots(fs_info, U64_MAX, 0, (u64)-1);
 
-	trans = btrfs_start_transaction(root, 0);
-	if (IS_ERR(trans)) {
-		mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
-		return PTR_ERR(trans);
+	while (1) {
+		trans = btrfs_start_transaction(root, 0);
+		if (IS_ERR(trans)) {
+			mutex_unlock(&dev_replace->lock_finishing_cancel_unmount);
+			return PTR_ERR(trans);
+		}
+		ret = btrfs_commit_transaction(trans);
+		WARN_ON(ret);
+
+		/* Prevent write_all_supers() during the finishing procedure */
+		mutex_lock(&fs_info->fs_devices->device_list_mutex);
+		/* Prevent new chunks being allocated on the source device */
+		mutex_lock(&fs_info->chunk_mutex);
+
+		if (!list_empty(&src_device->post_commit_list)) {
+			mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+			mutex_unlock(&fs_info->chunk_mutex);
+		} else {
+			break;
+		}
 	}
-	ret = btrfs_commit_transaction(trans);
-	WARN_ON(ret);
 
-	/* keep away write_all_supers() during the finishing procedure */
-	mutex_lock(&fs_info->fs_devices->device_list_mutex);
-	mutex_lock(&fs_info->chunk_mutex);
 	down_write(&dev_replace->rwsem);
 	dev_replace->replace_state =
 		scrub_ret ? BTRFS_IOCTL_DEV_REPLACE_STATE_CANCELED
@@ -658,7 +669,6 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 	btrfs_device_set_disk_total_bytes(tgt_device,
 					  src_device->disk_total_bytes);
 	btrfs_device_set_bytes_used(tgt_device, src_device->bytes_used);
-	ASSERT(list_empty(&src_device->post_commit_list));
 	tgt_device->commit_total_bytes = src_device->commit_total_bytes;
 	tgt_device->commit_bytes_used = src_device->bytes_used;
 
-- 
2.17.1

