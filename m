Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 647812ADE7
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 07:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbfE0FLE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 01:11:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58200 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfE0FLE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 01:11:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0265EAD26
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 05:11:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: convert: Workaround delayed ref bug by limiting the size of a transaction
Date:   Mon, 27 May 2019 13:10:54 +0800
Message-Id: <20190527051054.533-1-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In convert we use trans->block_reserved >= 4096 as a threshold to commit
transaction, where block_reserved is the number of new tree blocks
allocated inside a transaction.

The problem is, we still have a hidden bug in delayed ref implementation
in btrfs-progs, when we have a large enough transaction, delayed ref may
failed to find certain tree blocks in extent tree and cause transaction
abort.

This workaround will workaround it by committing transaction at a much
lower threshold.

The old 4096 means 4096 new tree blocks, when using default (16K)
nodesize, it's 64M, which can contain over 12k inlined data extent or
csum for around 60G, or over 800K file extents.

The new threshold will limit the size of new tree blocks to 2M, aligning
with the chunk preallocator threshold, and reducing the possibility to
hit that delayed ref bug.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index a136e5652898..63cf71fe10d5 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -829,7 +829,18 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
 		pthread_mutex_unlock(&p->mutex);
 		if (ret)
 			return ret;
-		if (trans->blocks_used >= 4096) {
+		/*
+		 * blocks_used is the number of new tree blocks allocated in
+		 * current transaction.
+		 * Use a small amount of it to workaround a bug where delayed
+		 * ref may fail to locate tree blocks in extent tree.
+		 *
+		 * 2M is the threshold to kick chunk preallocator into work,
+		 * For default (16K) nodesize it will be 128 tree blocks,
+		 * large enough to contain over 300 inlined files or
+		 * around 26k file extents. Which should be good enough.
+		 */
+		if (trans->blocks_used >= SZ_2M / root->fs_info->nodesize) {
 			ret = btrfs_commit_transaction(trans, root);
 			BUG_ON(ret);
 			trans = btrfs_start_transaction(root, 1);
-- 
2.21.0

