Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1378981F65
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbfHEOrQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:47:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48288 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729003AbfHEOrN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 10:47:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F4F0AFB6
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 14:47:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/6] btrfs: Simplify extent type check
Date:   Mon,  5 Aug 2019 17:47:07 +0300
Message-Id: <20190805144708.5432-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805144708.5432-1-nborisov@suse.com>
References: <20190805144708.5432-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Extent type can only be regular/prealloc/inline. The main branch of the
'if' already handles the first two, leaving the 'else' to handle inline.
Furthermore, tree-checker ensures that leaf items are correct.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8e24b7641247..6c3f9f3a7ed1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1502,18 +1502,14 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 			if (!btrfs_inc_nocow_writers(fs_info, disk_bytenr))
 				goto out_check;
 			nocow = true;
-		} else if (extent_type == BTRFS_FILE_EXTENT_INLINE) {
-			extent_end = found_key.offset +
-				btrfs_file_extent_ram_bytes(leaf, fi);
-			extent_end = ALIGN(extent_end,
-					   fs_info->sectorsize);
+		} else {
+			extent_end = found_key.offset + ram_bytes;
+			extent_end = ALIGN(extent_end, fs_info->sectorsize);
 			/* Skip extents outside of our requested range */
 			if (extent_end <= start) {
 				path->slots[0]++;
 				goto next_slot;
 			}
-		} else {
-			BUG();
 		}
 out_check:
 		/*
-- 
2.17.1

