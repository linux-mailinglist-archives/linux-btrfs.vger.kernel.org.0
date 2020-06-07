Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5541F0A58
	for <lists+linux-btrfs@lfdr.de>; Sun,  7 Jun 2020 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgFGHZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 7 Jun 2020 03:25:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:53596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgFGHZV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 7 Jun 2020 03:25:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B2613AD89
        for <linux-btrfs@vger.kernel.org>; Sun,  7 Jun 2020 07:25:22 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: extent_io: fix qgroup reserved data space leakage when releasing a page
Date:   Sun,  7 Jun 2020 15:25:11 +0800
Message-Id: <20200607072512.31721-2-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607072512.31721-1-wqu@suse.com>
References: <20200607072512.31721-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following simple workload from fsstress can lead to qgroup reserved
data space leakage:
  0/0: creat f0 x:0 0 0
  0/0: creat add id=0,parent=-1
  0/1: write f0[259 1 0 0 0 0] [600030,27288] 0
  0/4: dwrite - xfsctl(XFS_IOC_DIOINFO) f0[259 1 0 0 64 627318] return 25, fallback to stat()
  0/4: dwrite f0[259 1 0 0 64 627318] [610304,106496] 0

This would cause btrfs qgroup to leak 20480 bytes for data reserved
space.
If btrfs qgroup limit is enabled, such leakage can lead to unexpected
early EDQUOT and unusable space.

[CAUSE]
When doing direct IO, kernel will try to writeback existing buffered
page cache, then invalidate them:
  iomap_dio_rw()
  |- filemap_write_and_wait_range();
  |- invalidate_inode_pages2_range();

However for btrfs, the bi_end_io hook doesn't finish all its heavy work
right after bio ends.
In fact, it delays its work further:
  submit_extent_page(end_io_func=end_bio_extent_writepage);
  end_bio_extent_writepage()
  |- btrfs_writepage_endio_finish_ordered()
     |- btrfs_init_work(finish_ordered_fn);

  <<< Work queue execution >>>
  finish_ordered_fn()
  |- btrfs_finish_ordered_io();
     |- Clear qgroup bits

This means, when filemap_write_and_wait_range() returns,
btrfs_finish_ordered_io() is not ensured to be executed, thus the
qgroup bits for related range is not cleared.

Now into how the leakage happens, this will only focus on the
overlapping part of buffered and direct IO part.

1. After buffered write
   The inode had the following range with QGROUP_RESERVED bit:
   	596		616K
	|///////////////|
   Qgroup reserved data space: 20K

2. Writeback part for range [596K, 616K)
   Write back finished, but btrfs_finish_ordered_io() not get called
   yet.
   So we still have:
   	596K		616K
	|///////////////|
   Qgroup reserved data space: 20K

3. Pages for range [596K, 616K) get released
   This will clear all qgroup bits, but don't update the reserved data
   space.
   So we have:
   	596K		616K
	|		|
   Qgroup reserved data space: 20K
   That number doesn't match with the qgroup bit range anymore.

4. Dio prepare space for range [596K, 700K)
   Qgroup reserved data space for that range, we got:
   	596K		616K			700K
	|///////////////|///////////////////////|
   Qgroup reserved data space: 20K + 104K = 124K

5. btrfs_finish_ordered_range() get executed for range [596K, 616K)
   Qgroup free reserved space for that range, we got:
   	596K		616K			700K
	|		|///////////////////////|
   We need to free that range of reserved space.
   Qgroup reserved data space: 124K - 20K = 104K

6. btrfs_finish_ordered_range() get executed for range [596K, 700K)
   However qgroup bit for range [596K, 616K) is already cleared in
   previous step, so we only free 84K for qgroup reserved space.
   	596K		616K			700K
	|		|			|
   We need to free that range of reserved space.
   Qgroup reserved data space: 104K - 84K = 20K

   Now there is no way to release that 20K unless disabling qgroup or
   unmount the fs.

[FIX]
This patch will fix the problem by calling btrfs_qgroup_free_data() when
a page is released.

So that even a dirty page is released, its qgroup reserved data space
will get freed along with it.

Fixes: f695fdcef83a ("btrfs: qgroup: Introduce functions to release/free qgroup reserve data space")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c59e07360083..f86e11d571ea 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -24,6 +24,7 @@
 #include "rcu-string.h"
 #include "backref.h"
 #include "disk-io.h"
+#include "qgroup.h"
 
 static struct kmem_cache *extent_state_cache;
 static struct kmem_cache *extent_buffer_cache;
@@ -4476,21 +4477,40 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
 		ret = 0;
 	} else {
+		int tmp;
+
+		/*
+		 * When releasepage is called, some page can still be dirty and
+		 * has qgroup reserved bit.
+		 *
+		 * This is caused by delayed endio work, the real endio work,
+		 * finish_ordered_io(), is queued into another workqueue in
+		 * bio endio function.
+		 * Thus even writeback finishes, we do not clear dirty and
+		 * qgroup bits immediately.
+		 *
+		 * So here we still need to clear qgroup bits at release page
+		 * time, or we may leak qgroup reserved data space.
+		 */
+		tmp = btrfs_qgroup_free_data(page->mapping->host, NULL, start,
+					     PAGE_SIZE);
+		if (tmp < 0)
+			ret = 0;
+
 		/*
-		 * at this point we can safely clear everything except the
-		 * locked bit and the nodatasum bit
+		 * At this point we can safely clear everything except the
+		 * locked bit and the nodatasum bit.
 		 */
-		ret = __clear_extent_bit(tree, start, end,
+		tmp = __clear_extent_bit(tree, start, end,
 				 ~(EXTENT_LOCKED | EXTENT_NODATASUM),
 				 0, 0, NULL, mask, NULL);
 
-		/* if clear_extent_bit failed for enomem reasons,
+		/*
+		 * If clear_extent_bit failed for enomem reasons,
 		 * we can't allow the release to continue.
 		 */
-		if (ret < 0)
+		if (tmp < 0)
 			ret = 0;
-		else
-			ret = 1;
 	}
 	return ret;
 }
-- 
2.26.2

