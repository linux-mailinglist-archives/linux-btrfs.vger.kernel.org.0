Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 752FF1EB80B
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 11:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgFBJJX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 05:09:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:43072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728005AbgFBJJV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Jun 2020 05:09:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 618FFAC4A
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Jun 2020 09:09:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v9 4/5] btrfs: Reset device size when btrfs_update_device() failed in btrfs_grow_device()
Date:   Tue,  2 Jun 2020 17:09:04 +0800
Message-Id: <20200602090905.63899-5-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602090905.63899-1-wqu@suse.com>
References: <20200602090905.63899-1-wqu@suse.com>
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
 fs/btrfs/volumes.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9f6c1b5eaa3e..fec2a62cbcf9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2931,6 +2931,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = device->fs_info;
 	struct btrfs_super_block *super_copy = fs_info->super_copy;
+	u64 old_device_size;
 	u64 old_total;
 	u64 diff;
 	int ret;
@@ -2941,6 +2942,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	new_size = round_down(new_size, fs_info->sectorsize);
 
 	mutex_lock(&fs_info->chunk_mutex);
+	old_device_size = device->total_bytes;
 	old_total = btrfs_super_total_bytes(super_copy);
 	diff = round_down(new_size - device->total_bytes, fs_info->sectorsize);
 
@@ -2963,9 +2965,25 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	ret = calc_per_profile_avail(fs_info);
 	mutex_unlock(&fs_info->chunk_mutex);
 	if (ret < 0)
-		return ret;
+		goto out;
 
-	return btrfs_update_device(trans, device);
+	ret = btrfs_update_device(trans, device);
+out:
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
2.26.2

