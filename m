Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613D72524E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 03:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgHZBDp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 21:03:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:47796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgHZBDm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 21:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C752B16D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:53:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check/original: add inode transid detect and repair support
Date:   Wed, 26 Aug 2020 08:52:32 +0800
Message-Id: <20200826005233.90063-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826005233.90063-1-wqu@suse.com>
References: <20200826005233.90063-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The inode transid detect and repair is reusing the existing inode
geneartion code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/check/main.c b/check/main.c
index 9a2ee2a00f9a..e7996b7c8c0e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -620,7 +620,7 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 		fprintf(stderr, ", invalid inode mode bit 0%o",
 			rec->imode & ~07777);
 	if (errors & I_ERR_INVALID_GEN)
-		fprintf(stderr, ", invalid inode generation");
+		fprintf(stderr, ", invalid inode generation or transid");
 	fprintf(stderr, "\n");
 
 	/* Print the holes if needed */
@@ -912,7 +912,8 @@ static int process_inode_item(struct extent_buffer *eb,
 	 * inode generation uplimit, use super_generation + 1 anyway
 	 */
 	gen_uplimit = btrfs_super_generation(gfs_info->super_copy) + 1;
-	if (btrfs_inode_generation(eb, item) > gen_uplimit)
+	if (btrfs_inode_generation(eb, item) > gen_uplimit ||
+	    btrfs_inode_transid(eb, item) > gen_uplimit)
 		rec->errors |= I_ERR_INVALID_GEN;
 	maybe_free_inode_rec(&active_node->inode_cache, rec);
 	return 0;
@@ -2835,9 +2836,10 @@ static int repair_inode_gen_original(struct btrfs_trans_handle *trans,
 	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_inode_item);
 	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
+	btrfs_set_inode_transid(path->nodes[0], ii, trans->transid);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_release_path(path);
-	printf("resetting inode generation to %llu for ino %llu\n",
+	printf("resetting inode generation/transid to %llu for ino %llu\n",
 		trans->transid, rec->ino);
 	rec->errors &= ~I_ERR_INVALID_GEN;
 	return 0;
-- 
2.28.0

