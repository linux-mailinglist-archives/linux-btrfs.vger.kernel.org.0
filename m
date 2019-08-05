Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9890B81F64
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfHEOrO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:47:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729022AbfHEOrN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 10:47:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9DB63AFC3
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 14:47:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/6] btrfs: Remove BUG_ON from run_delalloc_nocow
Date:   Mon,  5 Aug 2019 17:47:08 +0300
Message-Id: <20190805144708.5432-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805144708.5432-1-nborisov@suse.com>
References: <20190805144708.5432-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Correctly handle failure cases when adding an ordered extents in case
of REGULAR or PREALLOC extents.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 6c3f9f3a7ed1..b935c301ca72 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1569,16 +1569,26 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_PREALLOC);
+			if (nocow)
+				btrfs_dec_nocow_writers(fs_info, disk_bytenr);
+			if (ret) {
+				btrfs_drop_extent_cache(BTRFS_I(inode),
+							cur_offset,
+							cur_offset + num_bytes - 1,
+							0);
+				goto error;
+			}
 		} else {
 			ret = btrfs_add_ordered_extent(inode, cur_offset,
 						       disk_bytenr, num_bytes,
 						       num_bytes,
 						       BTRFS_ORDERED_NOCOW);
+			if (nocow)
+				btrfs_dec_nocow_writers(fs_info, disk_bytenr);
+			if (ret)
+				goto error;
 		}
 
-		if (nocow)
-			btrfs_dec_nocow_writers(fs_info, disk_bytenr);
-		BUG_ON(ret); /* -ENOMEM */
 
 		if (root->root_key.objectid ==
 		    BTRFS_DATA_RELOC_TREE_OBJECTID)
-- 
2.17.1

