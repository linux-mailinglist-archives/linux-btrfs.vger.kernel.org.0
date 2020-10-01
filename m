Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252D027F93B
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbgJAF6R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 01:58:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40348 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgJAF6R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 01:58:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601531895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc9gTJGcWro3JtQkjyZ/HYQ1ZGTn6vPEfAUrEe8AiL4=;
        b=pjcoh8qztzuOBfu2bYPiP68mLkBY5ecVDWtSa7NIelUj4brJq8wywtl1RipVV2wD9nauKf
        4WHRVKQFSm0Hjhl49Rl+/fQZnixMzdL4A8QoD/QYpVHDCq6x7K+c/FJWqqSzRf0cEPg/QG
        glCDGbeJ2dmsUksn794034u5Vxo6bdM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8BE3DB328
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Oct 2020 05:58:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 9 09/12] btrfs: volumes: call btrfs_update_per_profile_avail() for chunk allocation and removal
Date:   Thu,  1 Oct 2020 13:57:41 +0800
Message-Id: <20201001055744.103261-10-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001055744.103261-1-wqu@suse.com>
References: <20201001055744.103261-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For chunk allocation, if we failed to update per profile available
space, we need to revert the newly created block group, revert the
device status, then return error.

For chunk removal, if we failed we just abort transaction, like all
error patterns in btrfs_remove_chunk().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e28d6a304f87..12c08648f5b6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3135,7 +3135,13 @@ int btrfs_remove_chunk(struct btrfs_trans_handle *trans, u64 chunk_offset)
 					device->bytes_used - dev_extent_len);
 			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
 			btrfs_clear_space_info_full(fs_info);
+			ret = btrfs_update_per_profile_avail(fs_info);
 			mutex_unlock(&fs_info->chunk_mutex);
+			if (ret < 0) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+				btrfs_abort_transaction(trans, ret);
+				goto out;
+			}
 		}
 
 		ret = btrfs_update_device(trans, device);
@@ -5275,6 +5281,12 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 				      &trans->transaction->dev_update_list);
 	}
 
+	ret = btrfs_update_per_profile_avail(info);
+	if (ret < 0) {
+		btrfs_revert_block_group(trans, start);
+		goto error_revert_devices;
+	}
+
 	atomic64_sub(ctl->stripe_size * map->num_stripes,
 		     &info->free_chunk_space);
 
@@ -5284,6 +5296,13 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 
 	return 0;
 
+error_revert_devices:
+	for (i = 0; i < map->num_stripes; i++) {
+		struct btrfs_device *dev = map->stripes[i].dev;
+
+		btrfs_device_set_bytes_used(dev,
+				dev->bytes_used - ctl->stripe_size);
+	}
 error_del_extent:
 	write_lock(&em_tree->lock);
 	remove_extent_mapping(em_tree, em);
-- 
2.28.0

