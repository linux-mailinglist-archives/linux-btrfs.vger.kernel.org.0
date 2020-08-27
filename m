Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD0125487E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Aug 2020 17:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgH0PG6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Aug 2020 11:06:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727968AbgH0PEa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC158B040;
        Thu, 27 Aug 2020 15:05:01 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: check: Support precise nlink tracking
Date:   Thu, 27 Aug 2020 18:04:26 +0300
Message-Id: <20200827150426.23842-4-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827150426.23842-1-nborisov@suse.com>
References: <20200827150426.23842-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This commit makes progs compatible with a kernel that has implemented
subdirectory tracking in nlink. To achieve this the logic is modified
such that found_link is incremented for the parent dir for every
DIR_ITEM found which points to a subdirectory. Another change is to
always set found_link to 1 when parsing INODE_ITEM which corresponds to
a subvolume/snapshot root. This is to account for the fact that such
inodes are the root in their respective fs trees so they won't have
their found_link count bumped when parsing their DIR_ITEM in the parent
directory.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check/main.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index c622caa8e04f..eec18132f8e5 100644
--- a/check/main.c
+++ b/check/main.c
@@ -908,6 +908,8 @@ static int process_inode_item(struct extent_buffer *eb,
 	if (S_ISLNK(rec->imode) &&
 	    flags & (BTRFS_INODE_IMMUTABLE | BTRFS_INODE_APPEND))
 		rec->errors |= I_ERR_ODD_INODE_FLAGS;
+	if (S_ISDIR(rec->imode) && rec->ino == BTRFS_FIRST_FREE_OBJECTID)
+		rec->found_link = 1;
 	/*
 	 * We don't have accurate root info to determine the correct
 	 * inode generation uplimit, use super_generation + 1 anyway
@@ -1421,6 +1423,16 @@ static int process_dir_item(struct extent_buffer *eb,
 			goto next;
 		}
 
+		if ((location.type == BTRFS_INODE_ITEM_KEY ||
+			location.type == BTRFS_ROOT_ITEM_KEY) && filetype == BTRFS_FT_DIR &&
+				key->type == BTRFS_DIR_ITEM_KEY) {
+			struct inode_record *dir_rec = get_inode_rec(inode_cache,
+					key->objectid, 1);
+			BUG_ON(IS_ERR(rec));
+			dir_rec->found_link++;
+			maybe_free_inode_rec(inode_cache, dir_rec);
+		}
+
 		if (location.type == BTRFS_INODE_ITEM_KEY) {
 			add_inode_backref(inode_cache, location.objectid,
 					  key->objectid, key->offset, namebuf,
@@ -1893,7 +1905,7 @@ static int check_root_dir(struct inode_record *rec)
 		goto out;
 	}
 
-	if (rec->nlink != 1 || rec->found_link != 0) {
+	if (rec->nlink != rec->found_link) {
 		rec->errors |= I_ERR_LINK_COUNT_WRONG;
 		goto out;
 	}
-- 
2.17.1

