Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1FE242592
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 08:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgHLGoR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Aug 2020 02:44:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:35786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726629AbgHLGoQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Aug 2020 02:44:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09A95AB71;
        Wed, 12 Aug 2020 06:44:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C92DDA81B; Wed, 12 Aug 2020 08:43:12 +0200 (CEST)
Date:   Wed, 12 Aug 2020 08:43:12 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        nborisov@suse.com
Subject: Re: [PATCH v5] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
Message-ID: <20200812064312.GW2026@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        nborisov@suse.com
References: <20200731112911.115665-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731112911.115665-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The v5 changes were discussed but were not all trivial to be just
committed. I need to add the patch to pull request branch soon so am
not waiting for your v5

v5:

- add mask for chunk state bits and use that to clear the range a after
  device shrink; on a second thought doing all ones did not look clean
  to me

- removed assert after clear_extent_bits - make it consistent with all
  other calls where we don't check the return value for now

- reworded comments

---

From: Qu Wenruo <wqu@suse.com>
Subject: [PATCH] btrfs: trim: fix underflow in trim length to prevent access
 beyond device boundary

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

- Add extra safety check when trimming free device extents
  We check and warn if the returned range is already beyond current
  device.

Link: https://github.com/kdave/btrfs-progs/issues/282
Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_first_clear_extent_bit")
CC: stable@vger.kernel.org # 5.4+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-io-tree.h |  2 ++
 fs/btrfs/extent-tree.c    | 14 ++++++++++++++
 fs/btrfs/volumes.c        |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index f39d47a2d01a..219a09a2b734 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -34,6 +34,8 @@ struct io_failure_record;
  */
 #define CHUNK_ALLOCATED				EXTENT_DIRTY
 #define CHUNK_TRIMMED				EXTENT_DEFRAG
+#define CHUNK_STATE_MASK			(CHUNK_ALLOCATED |		\
+						 CHUNK_TRIMMED)
 
 enum {
 	IO_TREE_FS_PINNED_EXTENTS,
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fa7d83051587..597505df90b4 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -33,6 +33,7 @@
 #include "delalloc-space.h"
 #include "block-group.h"
 #include "discard.h"
+#include "rcu-string.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 					    &start, &end,
 					    CHUNK_TRIMMED | CHUNK_ALLOCATED);
 
+		/* Check if there are any CHUNK_* bits left */
+		if (start > device->total_bytes) {
+			WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+			btrfs_warn_in_rcu(fs_info,
+"ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
+					  start, end - start + 1,
+					  rcu_str_deref(device->name),
+					  device->total_bytes);
+			mutex_unlock(&fs_info->chunk_mutex);
+			ret = 0;
+			break;
+		}
+
 		/* Ensure we skip the reserved area in the first 1M */
 		start = max_t(u64, start, SZ_1M);
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d7670e2a9f39..ee96c5869f57 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4720,6 +4720,10 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	}
 
 	mutex_lock(&fs_info->chunk_mutex);
+	/* Clear all state bits beyond the shrunk device size */
+	clear_extent_bits(&device->alloc_state, new_size, (u64)-1,
+			  CHUNK_STATE_MASK);
+
 	btrfs_device_set_disk_total_bytes(device, new_size);
 	if (list_empty(&device->post_commit_list))
 		list_add_tail(&device->post_commit_list,
-- 
2.25.0

