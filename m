Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2C9EA5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfH0OFW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 10:05:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42212 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728834AbfH0OFW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 10:05:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4E2CFB022;
        Tue, 27 Aug 2019 14:05:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2] btrfs: tree-checker: Fix wrong check on max devid
Date:   Tue, 27 Aug 2019 22:05:11 +0800
Message-Id: <20190827140511.7081-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs doesn't reuse devid, thus if we add and delete device in a loop,
we can increase devid to higher value, triggering tree checker to give a
false alert.

Furthermore, we have dev extent verification already (after
tree-checker, at mount time).
So even if user had bitflip on some dev items, we can still detect it
and refuse to mount.

Reported-by: Anand Jain <anand.jain@oracle.com>
Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove devid check completely
  As we already have verify_one_dev_extent().
---
 fs/btrfs/tree-checker.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 43e488f5d063..076d5b8014fb 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -686,9 +686,7 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
 static int check_dev_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, int slot)
 {
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_dev_item *ditem;
-	u64 max_devid = max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHUNK);
 
 	if (key->objectid != BTRFS_DEV_ITEMS_OBJECTID) {
 		dev_item_err(leaf, slot,
@@ -696,12 +694,6 @@ static int check_dev_item(struct extent_buffer *leaf,
 			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
 		return -EUCLEAN;
 	}
-	if (key->offset > max_devid) {
-		dev_item_err(leaf, slot,
-			     "invalid devid: has=%llu expect=[0, %llu]",
-			     key->offset, max_devid);
-		return -EUCLEAN;
-	}
 	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
 	if (btrfs_device_id(leaf, ditem) != key->offset) {
 		dev_item_err(leaf, slot,
-- 
2.23.0

