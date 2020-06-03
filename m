Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE531EC914
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgFCF4B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:42484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgFCFz6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 69625B009;
        Wed,  3 Jun 2020 05:56:00 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 26/46] btrfs: Make inode_can_compress take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:26 +0300
Message-Id: <20200603055546.3889-27-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gets rid of superfluous BTRFS_I() calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8a41c19b0bb..1c3704b18f3a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -411,10 +411,10 @@ static noinline int add_async_extent(struct async_chunk *cow,
 /*
  * Check if the inode has flags compatible with compression
  */
-static inline bool inode_can_compress(struct inode *inode)
+static inline bool inode_can_compress(struct btrfs_inode *inode)
 {
-	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW ||
-	    BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)
+	if (inode->flags & BTRFS_INODE_NODATACOW ||
+	    inode->flags & BTRFS_INODE_NODATASUM)
 		return false;
 	return true;
 }
@@ -427,7 +427,7 @@ static inline int inode_need_compress(struct inode *inode, u64 start, u64 end)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);

-	if (!inode_can_compress(inode)) {
+	if (!inode_can_compress(BTRFS_I(inode))) {
 		WARN(IS_ENABLED(CONFIG_BTRFS_DEBUG),
 			KERN_ERR "BTRFS: unexpected compression for ino %llu\n",
 			btrfs_ino(BTRFS_I(inode)));
@@ -1808,7 +1808,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 	} else if (BTRFS_I(inode)->flags & BTRFS_INODE_PREALLOC && !force_cow) {
 		ret = run_delalloc_nocow(BTRFS_I(inode), locked_page, start, end,
 					 page_started, 0, nr_written);
-	} else if (!inode_can_compress(inode) ||
+	} else if (!inode_can_compress(BTRFS_I(inode)) ||
 		   !inode_need_compress(inode, start, end)) {
 		ret = cow_file_range(BTRFS_I(inode), locked_page, start, end,
 				      page_started, nr_written, 1);
--
2.17.1

