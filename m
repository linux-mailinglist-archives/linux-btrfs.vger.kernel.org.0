Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78F116B86
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Dec 2019 11:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfLIKyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Dec 2019 05:54:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:40244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727435AbfLIKyp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Dec 2019 05:54:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDAF7AD2D;
        Mon,  9 Dec 2019 10:54:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Mike Gilbert <floppymaster@gmail.com>
Subject: [PATCH 4/4] btrfs: tree-checker: Verify location key for DIR_ITEM/DIR_INDEX
Date:   Mon,  9 Dec 2019 18:54:35 +0800
Message-Id: <20191209105435.36041-4-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209105435.36041-1-wqu@suse.com>
References: <20191209105435.36041-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[PROBLEM]
There is a user report in the mail list, showing the following corrupted
tree blocks:

       item 62 key (486836 DIR_ITEM 2543451757) itemoff 6273 itemsize 74
               location key (4065004 INODE_ITEM 1073741824) type FILE
               transid 21397 data_len 0 name_len 44
               name: 0390cb341d248c589c419007da68b2-7351.manifest

Note that location key, its offset should be 0 for all INODE_ITEMS.

This caused btrfs kernel failed to lookup the inode.

[CAUSE]
That offending value, 1073741824, is 0x40000000. So this looks like a
memory bit flip.

[FIX]
This patch will enhance tree-checker to check location key of
DIR_INDEX/DIR_ITEM/XATTR_ITEM.

There are several different combinations needs to check:
- item_key.type == DIR_INDEX/DIR_ITEM
  * location_key.type == BTRFS_INODE_ITEM_KEY
    This location_key should follow the check in inode_item check.
  * location_key.type == BTRFS_ROOT_ITEM_KEY
    Despite the existing check, DIR_INDEX/DIR_ITEM can only points to
    subvolume trees.
  * All other keys are not allowed.

- item_key.type == XATTR_ITEM
  location_key should be all 0.

Reported-by: Mike Gilbert <floppymaster@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 9a6743ee874a..7bd1a2f986c4 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -468,12 +468,14 @@ static int check_dir_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	di = btrfs_item_ptr(leaf, slot, struct btrfs_dir_item);
 	while (cur < item_size) {
+		struct btrfs_key location_key;
 		u32 name_len;
 		u32 data_len;
 		u32 max_name_len;
 		u32 total_size;
 		u32 name_hash;
 		u8 dir_type;
+		int ret;
 
 		/* header itself should not cross item boundary */
 		if (cur + sizeof(*di) > item_size) {
@@ -483,6 +485,24 @@ static int check_dir_item(struct extent_buffer *leaf,
 			return -EUCLEAN;
 		}
 
+		/* Location key check */
+		btrfs_dir_item_key_to_cpu(leaf, di, &location_key);
+		if (location_key.type == BTRFS_ROOT_ITEM_KEY) {
+			ret = check_root_key(leaf, &location_key, slot);
+			if (ret < 0)
+				return ret;
+		} else if (location_key.type == BTRFS_INODE_ITEM_KEY ||
+			   location_key.type == 0) {
+			ret = check_inode_key(leaf, &location_key, slot);
+			if (ret < 0)
+				return ret;
+		} else {
+			dir_item_err(leaf, slot,
+			"invalid location key type, have %u, expect %u or %u",
+				     location_key.type, BTRFS_ROOT_ITEM_KEY,
+				     BTRFS_INODE_ITEM_KEY);
+			return -EUCLEAN;
+		}
 		/* dir type check */
 		dir_type = btrfs_dir_type(leaf, di);
 		if (dir_type >= BTRFS_FT_MAX) {
-- 
2.24.0

