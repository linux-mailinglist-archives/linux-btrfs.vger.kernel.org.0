Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F185B23B599
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 09:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgHDHZ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 03:25:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:36238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgHDHZ6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 4 Aug 2020 03:25:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6D8C8ACA9
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Aug 2020 07:26:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: prevent NULL pointer dereference in compress_file_range() when btrfs_compress_pages() hits default case
Date:   Tue,  4 Aug 2020 15:25:47 +0800
Message-Id: <20200804072548.34001-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200804072548.34001-1-wqu@suse.com>
References: <20200804072548.34001-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/071 with inode_need_compress() removed from
compress_file_range(), we got the following crash:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
  RIP: 0010:compress_file_range+0x476/0x7b0 [btrfs]
  Call Trace:
   ? submit_compressed_extents+0x450/0x450 [btrfs]
   async_cow_start+0x16/0x40 [btrfs]
   btrfs_work_helper+0xf2/0x3e0 [btrfs]
   process_one_work+0x278/0x5e0
   worker_thread+0x55/0x400
   ? process_one_work+0x5e0/0x5e0
   kthread+0x168/0x190
   ? kthread_create_worker_on_cpu+0x70/0x70
   ret_from_fork+0x22/0x30
  ---[ end trace 65faf4eae941fa7d ]---

This is already after the patch "btrfs: inode: fix NULL pointer
dereference if inode doesn't need compression."

[CAUSE]
@pages is firstly created by kcalloc() in compress_file_extent():
                pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);

Then passed to btrfs_compress_pages() to be utilized there:

                ret = btrfs_compress_pages(...
                                           pages,
                                           &nr_pages,
                                           ...);

btrfs_compress_pages() will initial each pages as output, in
zlib_compress_pages() we have:

                        pages[nr_pages] = out_page;
                        nr_pages++;

Normally this is completely fine, but there is a special case which
is in btrfs_compress_pages() itself:
        switch (type) {
        default:
                return -E2BIG;
        }

In this case, we didn't modify @pages nor @out_pages, leaving them
untouched, then when we cleanup pages, the we can hit NULL pointer
dereference again:

        if (pages) {
                for (i = 0; i < nr_pages; i++) {
                        WARN_ON(pages[i]->mapping);
                        put_page(pages[i]);
                }
        ...
        }

Since pages[i] are all initialized to zero, and btrfs_compress_pages()
doesn't change them at all, accessing pages[i]->mapping would lead to
NULL pointer dereference.

This is not possible for current kernel, as we check
inode_need_compress() before doing pages allocation.
But if we're going to remove that inode_need_compress() in
compress_file_extent(), then it's going to be a problem.

[FIX]
When btrfs_compress_pages() hits its default case, modify @out_pages to
0 to prevent such problem from happening.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 1ab56a734e70..17c27edd804b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -115,10 +115,14 @@ static int compression_compress_pages(int type, struct list_head *ws,
 	case BTRFS_COMPRESS_NONE:
 	default:
 		/*
-		 * This can't happen, the type is validated several times
-		 * before we get here. As a sane fallback, return what the
-		 * callers will understand as 'no compression happened'.
+		 * This happens when compression races with remount to no
+		 * compress, while caller doesn't call inode_need_compress()
+		 * to check if we really need to compress.
+		 *
+		 * Not a big deal, just need to inform caller that we
+		 * haven't allocated any pages yet.
 		 */
+		*out_pages = 0;
 		return -E2BIG;
 	}
 }
-- 
2.28.0

