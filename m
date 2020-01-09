Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0B13539C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2020 08:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgAIHQx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Jan 2020 02:16:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:60476 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728152AbgAIHQw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Jan 2020 02:16:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1EB77AC65
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Jan 2020 07:16:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 1/4] btrfs: Reset device size when btrfs_update_device() failed in btrfs_grow_device()
Date:   Thu,  9 Jan 2020 15:16:31 +0800
Message-Id: <20200109071634.32384-2-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109071634.32384-1-wqu@suse.com>
References: <20200109071634.32384-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When btrfs_update_device() failed due to ENOMEM, we didn't reset device
size back to its original size, causing the in-memory device size larger
than original.

If somehow the memory pressure get solved, and the fs committed, since
the device item is not updated, but super block total size get updated,
it would cause mount failure due to size mismatch.

So here revert device size and super size to its original size when
btrfs_update_device() failed, just like what we did in shrink_device().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d8e5560db285..be638465f210 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2633,8 +2633,10 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
+	u64 old_device_size;
 	u64 old_total;
 	u64 diff;
+	int ret;
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
@@ -2642,6 +2644,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	new_size = round_down(new_size, fs_info->sectorsize);
 
 	mutex_lock(&fs_info->chunk_mutex);
+	old_device_size = device->total_bytes;
 	old_total = btrfs_super_total_bytes(super_copy);
 	diff = round_down(new_size - device->total_bytes, fs_info->sectorsize);
 
@@ -2663,7 +2666,22 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 			      &trans->transaction->dev_update_list);
 	mutex_unlock(&fs_info->chunk_mutex);
 
-	return btrfs_update_device(trans, device);
+	ret = btrfs_update_device(trans, device);
+	if (ret < 0) {
+		/*
+		 * Although we dropped chunk_mutex halfway for
+		 * btrfs_update_device(), we have FS_EXCL_OP bit to prevent
+		 * shrinking/growing race.
+		 * So we're safe to use the old size directly.
+		 */
+		mutex_lock(&fs_info->chunk_mutex);
+		btrfs_set_super_total_bytes(super_copy, old_total);
+		device->fs_devices->total_rw_bytes -= diff;
+		btrfs_device_set_total_bytes(device, old_device_size);
+		btrfs_device_set_disk_total_bytes(device, old_device_size);
+		mutex_unlock(&fs_info->chunk_mutex);
+	}
+	return ret;
 }
 
 static int btrfs_free_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
-- 
2.24.1

