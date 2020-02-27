Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD16172924
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Feb 2020 21:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730789AbgB0UBL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Feb 2020 15:01:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:55698 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730761AbgB0UBL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Feb 2020 15:01:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E9D32B117;
        Thu, 27 Feb 2020 20:01:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0C3D3DA83A; Thu, 27 Feb 2020 21:00:50 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: return void from csum_tree_block
Date:   Thu, 27 Feb 2020 21:00:49 +0100
Message-Id: <c6518711b16ccd373084b8df681db41c198cb1ec.1582832619.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1582832619.git.dsterba@suse.com>
References: <cover.1582832619.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that csum_tree_block is not returning any errors, we can make
csum_tree_block return void and simplify callers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5f74eb69f2fe..8401852cf9c0 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -253,10 +253,8 @@ struct extent_map *btree_get_extent(struct btrfs_inode *inode,
 
 /*
  * Compute the csum of a btree block and store the result to provided buffer.
- *
- * Returns error if the extent buffer cannot be mapped.
  */
-static int csum_tree_block(struct extent_buffer *buf, u8 *result)
+static void csum_tree_block(struct extent_buffer *buf, u8 *result)
 {
 	struct btrfs_fs_info *fs_info = buf->fs_info;
 	const int num_pages = fs_info->nodesize >> PAGE_SHIFT;
@@ -276,8 +274,6 @@ static int csum_tree_block(struct extent_buffer *buf, u8 *result)
 	}
 	memset(result, 0, BTRFS_CSUM_SIZE);
 	crypto_shash_final(shash, result);
-
-	return 0;
 }
 
 /*
@@ -528,8 +524,7 @@ static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
 				    offsetof(struct btrfs_header, fsid),
 				    BTRFS_FSID_SIZE) == 0);
 
-	if (csum_tree_block(eb, result))
-		return -EINVAL;
+	csum_tree_block(eb, result);
 
 	if (btrfs_header_level(eb))
 		ret = btrfs_check_node(eb);
@@ -640,9 +635,7 @@ static int btree_readpage_end_io_hook(struct btrfs_io_bio *io_bio,
 	btrfs_set_buffer_lockdep_class(btrfs_header_owner(eb),
 				       eb, found_level);
 
-	ret = csum_tree_block(eb, result);
-	if (ret)
-		goto err;
+	csum_tree_block(eb, result);
 
 	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
 		u32 val;
-- 
2.25.0

