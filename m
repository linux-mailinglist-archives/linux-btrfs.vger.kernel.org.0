Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92460E8E16
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Oct 2019 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfJ2R2t (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 13:28:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727456AbfJ2R2t (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 13:28:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A1381B229;
        Tue, 29 Oct 2019 17:28:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 94749DA734; Tue, 29 Oct 2019 18:28:57 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: sink write flags to cow_file_range_async
Date:   Tue, 29 Oct 2019 18:28:57 +0100
Message-Id: <8bfe15d0c80d0011c5fc48893345e7870e0f4e49.1572369984.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572369984.git.dsterba@suse.com>
References: <cover.1572369984.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In commit "Btrfs: use REQ_CGROUP_PUNT for worker thread submitted bios",
cow_file_range_async gained wbc as a parameter and this makes passing
write flags redundant. Set it inside the function and remove the
parameter.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/inode.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09118a0f82d1..e7ea139a8e63 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1201,8 +1201,7 @@ static int cow_file_range_async(struct inode *inode,
 				struct writeback_control *wbc,
 				struct page *locked_page,
 				u64 start, u64 end, int *page_started,
-				unsigned long *nr_written,
-				unsigned int write_flags)
+				unsigned long *nr_written)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct cgroup_subsys_state *blkcg_css = wbc_blkcg_css(wbc);
@@ -1214,6 +1213,7 @@ static int cow_file_range_async(struct inode *inode,
 	int i;
 	bool should_compress;
 	unsigned nofs_flag;
+	const unsigned int write_flags = wbc_to_write_flags(wbc);
 
 	unlock_extent(&BTRFS_I(inode)->io_tree, start, end);
 
@@ -1724,7 +1724,6 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 {
 	int ret;
 	int force_cow = need_force_cow(inode, start, end);
-	unsigned int write_flags = wbc_to_write_flags(wbc);
 
 	if (BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW && !force_cow) {
 		ret = run_delalloc_nocow(inode, locked_page, start, end,
@@ -1740,8 +1739,7 @@ int btrfs_run_delalloc_range(struct inode *inode, struct page *locked_page,
 		set_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
 			&BTRFS_I(inode)->runtime_flags);
 		ret = cow_file_range_async(inode, wbc, locked_page, start, end,
-					   page_started, nr_written,
-					   write_flags);
+					   page_started, nr_written);
 	}
 	if (ret)
 		btrfs_cleanup_ordered_extents(inode, locked_page, start,
-- 
2.23.0

