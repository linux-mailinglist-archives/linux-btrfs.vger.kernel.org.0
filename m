Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D6299670
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388382AbfHVOZ1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 10:25:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:49818 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388345AbfHVOZ0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 10:25:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4B4FAC47
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 14:25:25 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     dsterb@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Streamline code in run_delalloc_nocow
Date:   Thu, 22 Aug 2019 17:25:23 +0300
Message-Id: <20190822142523.1425-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821154039.GA2752@twin.jikos.cz>
References: <20190821154039.GA2752@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a comment explaining why we keep the BUG also use the already read
and cached value of extent ram bytes stored in 'ram_bytes'.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6cb22d82e6aa..161439122a29 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1503,16 +1503,15 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				goto out_check;
 			nocow = true;
 		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-			extent_end = found_key.offset +
-				btrfs_file_extent_ram_bytes(leaf, fi);
-			extent_end = ALIGN(extent_end,
-					   fs_info->sectorsize);
+			extent_end = found_key.offset + ram_bytes;
+			extent_end = ALIGN(extent_end, fs_info->sectorsize);
 			/* Skip extents outside of our requested range */
 			if (extent_end <= start) {
 				path->slots[0]++;
 				goto next_slot;
 			}
 		} else {
+			/* If this triggers then we have a memory corruption */
 			BUG();
 		}
 out_check:
-- 
2.17.1

