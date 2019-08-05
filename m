Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7A781F63
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Aug 2019 16:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfHEOrN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Aug 2019 10:47:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:48282 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728998AbfHEOrN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 5 Aug 2019 10:47:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 04F4EABE7
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Aug 2019 14:47:12 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 4/6] btrfs: Streamline code in run_delalloc_nocow in case of inline extents
Date:   Mon,  5 Aug 2019 17:47:06 +0300
Message-Id: <20190805144708.5432-5-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805144708.5432-1-nborisov@suse.com>
References: <20190805144708.5432-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extent range check right after the "out_check" label is redundant,
because the only way it can trigger is if we have an inline extent. In
this case it makes more sense to actually move it in the branch
explictly dealing with inlines extents. What's more, the nested
'if (nocow)' can never be true because for inline extents we always do
CoW and there is no chance 'noco' can be true, just remove that check.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 49db8090e62f..8e24b7641247 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1507,17 +1507,15 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 				btrfs_file_extent_ram_bytes(leaf, fi);
 			extent_end = ALIGN(extent_end,
 					   fs_info->sectorsize);
+			/* Skip extents outside of our requested range */
+			if (extent_end <= start) {
+				path->slots[0]++;
+				goto next_slot;
+			}
 		} else {
 			BUG();
 		}
 out_check:
-		/* Skip extents outside of our requested range */
-		if (extent_end <= start) {
-			path->slots[0]++;
-			if (nocow)
-				btrfs_dec_nocow_writers(fs_info, disk_bytenr);
-			goto next_slot;
-		}
 		/*
 		 * If nocow is false then record the beginning of the range
 		 * that needs to be CoWed
-- 
2.17.1

