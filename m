Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50A8F5A3C
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Nov 2019 22:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbfKHVi6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Nov 2019 16:38:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:45870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731097AbfKHVi6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 8 Nov 2019 16:38:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 735B3B19A;
        Fri,  8 Nov 2019 21:38:56 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH next 2/2] btrfs: extent-tree: Fix error format string
Date:   Fri,  8 Nov 2019 22:38:53 +0100
Message-Id: <20191108213853.16635-3-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191108213853.16635-1-afaerber@suse.de>
References: <20191108213853.16635-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Andreas Färber <afaerber@suse.com>

sizeof() returns type size_t, thus we need %zu instead of %lu.

This fixes the following build warning on 32-bit arm:

  In file included from ../include/linux/printk.h:7,
                   from ../include/linux/kernel.h:15,
                   from ../include/asm-generic/bug.h:19,
                   from ../arch/arm/include/asm/bug.h:60,
                   from ../include/linux/bug.h:5,
                   from ../include/linux/thread_info.h:12,
                   from ../include/asm-generic/current.h:5,
                   from ./arch/arm/include/generated/asm/current.h:1,
                   from ../include/linux/sched.h:12,
                   from ../fs/btrfs/extent-tree.c:6:
  ../fs/btrfs/extent-tree.c: In function '__btrfs_free_extent':
  ../include/linux/kern_levels.h:5:18: warning: format '%lu' expects argument of type 'long unsigned int', but argument 8 has type 'unsigned int' [-Wformat=]
      5 | #define KERN_SOH "\001"  /* ASCII Start Of Header */
        |                  ^~~~~~
  ../include/linux/kern_levels.h:10:19: note: in expansion of macro 'KERN_SOH'
     10 | #define KERN_CRIT KERN_SOH "2" /* critical conditions */
        |                   ^~~~~~~~
  ../fs/btrfs/ctree.h:2986:24: note: in expansion of macro 'KERN_CRIT'
   2986 |  btrfs_printk(fs_info, KERN_CRIT fmt, ##args)
        |                        ^~~~~~~~~
  ../fs/btrfs/extent-tree.c:3207:4: note: in expansion of macro 'btrfs_crit'
   3207 |    btrfs_crit(info,
        |    ^~~~~~~~~~
  ../fs/btrfs/extent-tree.c:3208:83: note: format string is defined here
   3208 | "invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %lu",
        |                                                                                 ~~^
        |                                                                                   |
        |                                                                                   long unsigned int
        |                                                                                 %u

Fixes: 0c171e9095e4 ("btrfs: extent-tree: Kill BUG_ON() in __btrfs_free_extent() and do better comment")
Cc: Qu Wenruo <wqu@suse.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Andreas Färber <afaerber@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 7c7a3e30e917..631c9743ddc7 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3205,7 +3205,7 @@ static int __btrfs_free_extent(struct btrfs_trans_handle *trans,
 		struct btrfs_tree_block_info *bi;
 		if (unlikely(item_size < sizeof(*ei) + sizeof(*bi))) {
 			btrfs_crit(info,
-"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %lu",
+"invalid extent item size for key (%llu, %u, %llu) owner %llu, has %u expect >= %zu",
 				   key.objectid, key.type, key.offset,
 				   owner_objectid, item_size,
 				   sizeof(*ei) + sizeof(*bi));
-- 
2.16.4

