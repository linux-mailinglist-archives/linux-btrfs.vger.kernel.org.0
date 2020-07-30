Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40AF2330DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Jul 2020 13:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG3LT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Jul 2020 07:19:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:36138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgG3LT2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Jul 2020 07:19:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AB5FABCE
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Jul 2020 11:19:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: trim: fix underflow in trim length to prevent access beyond device boundary
Date:   Thu, 30 Jul 2020 19:19:21 +0800
Message-Id: <20200730111921.60051-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script can lead to tons of beyond device boundary access:

  mkfs.btrfs -f $dev -b 10G
  mount $dev $mnt
  trimfs $mnt
  btrfs filesystem resize 1:-1G $mnt
  trimfs $mnt

[CAUSE]
Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
find_first_clear_extent_bit"), we try to avoid trimming ranges that's
already trimmed.

So we check device->alloc_state by finding the first range which doesn't
have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.

But if we shrunk the device, that bits are not cleared, thus we could
easily got a range starts beyond the shrunk device size.

This results the returned @start and @end are all beyond device size,
then we call "end = min(end, device->total_bytes -1);" making @end
smaller than device size.

Then finally we goes "len = end - start + 1", totally underflow the
result, and lead to the beyond-device-boundary access.

[FIX]
This patch will fix the problem in two ways:
- Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
  This is the root fix

- Add extra safe net when trimming free device extents
  We check if the returned range is already beyond current device
  boundary.

Link: https://github.com/kdave/btrfs-progs/issues/282
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c |  5 +++++
 fs/btrfs/volumes.c     | 12 ++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 61ede335f6c3..758f963feb96 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5667,6 +5667,11 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		find_first_clear_extent_bit(&device->alloc_state, start,
 					    &start, &end,
 					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
+		if (start >= device->total_bytes) {
+			mutex_unlock(&fs_info->chunk_mutex);
+			ret = 0;
+			break;
+		}
 
 		/* Ensure we skip the reserved area in the first 1M */
 		start = max_t(u64, start, SZ_1M);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 537ccf66ee20..906704c61a51 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4705,6 +4705,18 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	}
 
 	mutex_lock(&fs_info->chunk_mutex);
+	/*
+	 * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond the
+	 * current device boundary.
+	 */
+	ret = clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
+				CHUNK_TRIMMED | CHUNK_ALLOCATED);
+	if (ret < 0) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		goto done;
+	}
 	btrfs_device_set_disk_total_bytes(device, new_size);
 	if (list_empty(&device->post_commit_list))
 		list_add_tail(&device->post_commit_list,
-- 
2.28.0

