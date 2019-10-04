Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04087CB75D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Oct 2019 11:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387660AbfJDJbk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Oct 2019 05:31:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbfJDJbk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Oct 2019 05:31:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0BA4AB14E;
        Fri,  4 Oct 2019 09:31:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: tree-checker: Fix false alerts on log trees
Date:   Fri,  4 Oct 2019 17:31:31 +0800
Message-Id: <20191004093133.83582-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004093133.83582-1-wqu@suse.com>
References: <20191004093133.83582-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When running btrfs/063 in a loop, we got the following random write time
tree checker error:

  BTRFS critical (device dm-4): corrupt leaf: root=18446744073709551610 block=33095680 slot=2 ino=307 file_offset=0, invalid previous key objectid, have 305 expect 307
  BTRFS info (device dm-4): leaf 33095680 gen 7 total ptrs 47 free space 12146 owner 18446744073709551610
  BTRFS info (device dm-4): refs 1 lock (w:0 r:0 bw:0 br:0 sw:0 sr:0) lock_owner 0 current 26176
          item 0 key (305 1 0) itemoff 16123 itemsize 160
                  inode generation 0 size 0 mode 40777
          item 1 key (305 12 257) itemoff 16111 itemsize 12
          item 2 key (307 108 0) itemoff 16058 itemsize 53 <<<
                  extent data disk bytenr 0 nr 0
                  extent data offset 0 nr 614400 ram 671744
          item 3 key (307 108 614400) itemoff 16005 itemsize 53
                  extent data disk bytenr 195342336 nr 57344
                  extent data offset 0 nr 53248 ram 57344
          item 4 key (307 108 667648) itemoff 15952 itemsize 53
                  extent data disk bytenr 194048000 nr 4096
                  extent data offset 0 nr 4096 ram 4096
	  [...]
  BTRFS error (device dm-4): block=33095680 write time tree block corruption detected
  BTRFS: error (device dm-4) in btrfs_commit_transaction:2332: errno=-5 IO failure (Error while writing out transaction)
  BTRFS info (device dm-4): forced readonly
  BTRFS warning (device dm-4): Skipping commit of aborted transaction.
  BTRFS info (device dm-4): use zlib compression, level 3
  BTRFS: error (device dm-4) in cleanup_transaction:1890: errno=-5 IO failure

[CAUSE]
Commit 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_ITEM")
assumes all XATTR_ITEM/DIR_INDEX/DIR_ITEM/INODE_REF/EXTENT_DATA items
should have previous key with the same objectid as ino.

But it's only true for fs trees. For log-tree, we can get above log tree
block where an EXTENT_DATA item has no previous key with the same ino.
As log tree only records modified items, it won't record unmodified
items like INODE_ITEM.

So this triggers write time tree check warning.

[FIX]
As a quick fix, check header owner to skip the previous key if it's not
fs tree (log tree doesn't count as fs tree).

This fix is only to be merged as a quick fix.
There will be a more comprehensive fix to refactor the common check into
one function.

Reported-by: David Sterba <dsterba@suse.com>
Fixes: 59b0d030fb30 ("btrfs: tree-checker: Try to detect missing INODE_ITEM")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index b8f82d9be9f0..5e34cd5e3e2e 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -148,7 +148,8 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 	 * But if objectids mismatch, it means we have a missing
 	 * INODE_ITEM.
 	 */
-	if (slot > 0 && prev_key->objectid != key->objectid) {
+	if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
+	    prev_key->objectid != key->objectid) {
 		file_extent_err(leaf, slot,
 		"invalid previous key objectid, have %llu expect %llu",
 				prev_key->objectid, key->objectid);
@@ -322,7 +323,8 @@ static int check_dir_item(struct extent_buffer *leaf,
 	u32 cur = 0;
 
 	/* Same check as in check_extent_data_item() */
-	if (slot > 0 && prev_key->objectid != key->objectid) {
+	if (slot > 0 && is_fstree(btrfs_header_owner(leaf)) &&
+	    prev_key->objectid != key->objectid) {
 		dir_item_err(leaf, slot,
 		"invalid previous key objectid, have %llu expect %llu",
 			     prev_key->objectid, key->objectid);
-- 
2.23.0

