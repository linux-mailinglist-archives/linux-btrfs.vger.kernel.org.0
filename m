Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD9B2524DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 03:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHZBDq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 21:03:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:47806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHZBDm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 21:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6F056B13D
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:53:14 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check/lowmem: add inode transid detect and repair support
Date:   Wed, 26 Aug 2020 08:52:31 +0800
Message-Id: <20200826005233.90063-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826005233.90063-1-wqu@suse.com>
References: <20200826005233.90063-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are quite some reports on kernel rejecting invalid inode
generation, but it turns out to be that, kernel is just rejecting inode
transid. It's a bug in kernel error message.

To solve the problem and make the fs mountable again, add the detect and
repair support for lowmem mode.

The implementation is pretty much the same, just re-use the existing
inode generation detect and repair code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 837bacf920ac..2b689b2abf63 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -2554,6 +2554,7 @@ static int repair_inode_gen_lowmem(struct btrfs_root *root,
 	ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
 			    struct btrfs_inode_item);
 	btrfs_set_inode_generation(path->nodes[0], ii, trans->transid);
+	btrfs_set_inode_transid(path->nodes[0], ii, trans->transid);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	ret = btrfs_commit_transaction(trans, root);
 	if (ret < 0) {
@@ -2561,7 +2562,7 @@ static int repair_inode_gen_lowmem(struct btrfs_root *root,
 		error("failed to commit transaction: %m");
 		goto error;
 	}
-	printf("resetting inode generation to %llu for ino %llu\n",
+	printf("resetting inode generation/transid to %llu for ino %llu\n",
 		transid, key.objectid);
 	return ret;
 
@@ -2597,6 +2598,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	u64 extent_end = 0;
 	u64 extent_size = 0;
 	u64 generation;
+	u64 transid;
 	u64 gen_uplimit;
 	unsigned int dir;
 	unsigned int nodatasum;
@@ -2629,6 +2631,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	dir = imode_to_type(mode) == BTRFS_FT_DIR;
 	nlink = btrfs_inode_nlink(node, ii);
 	generation = btrfs_inode_generation(node, ii);
+	transid = btrfs_inode_transid(node, ii);
 	nodatasum = btrfs_inode_flags(node, ii) & BTRFS_INODE_NODATASUM;
 
 	if (!is_valid_imode(mode)) {
@@ -2648,10 +2651,10 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	else
 		gen_uplimit = btrfs_super_generation(super);
 
-	if (generation > gen_uplimit) {
+	if (generation > gen_uplimit || transid > gen_uplimit) {
 		error(
-	"invalid inode generation for ino %llu, have %llu expect [0, %llu)",
-		      inode_id, generation, gen_uplimit);
+"invalid inode generation or transid for ino %llu, have %llu,%llu expect [0, %llu)",
+		      inode_id, generation, transid, gen_uplimit);
 		if (repair) {
 			ret = repair_inode_gen_lowmem(root, path);
 			if (ret < 0)
-- 
2.28.0

