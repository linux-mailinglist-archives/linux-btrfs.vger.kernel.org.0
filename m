Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D9F1EA727
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbgFAPi1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727935AbgFAPhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E0A3B1FB;
        Mon,  1 Jun 2020 15:37:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 18/46] btrfs: Make btrfs_qgroup_release_data take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:16 +0300
Message-Id: <20200601153744.31891-19-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It just forwards its argument to __btrfs_qgroup_release_data.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c  | 2 +-
 fs/btrfs/qgroup.c | 4 ++--
 fs/btrfs/qgroup.h | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9794895d16fe..28dfadb97a6a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2523,7 +2523,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	 * Release the reserved range from inode dirty range map, as it is
 	 * already moved into delayed_ref_head
 	 */
-	ret = btrfs_qgroup_release_data(inode, file_pos, ram_bytes);
+	ret = btrfs_qgroup_release_data(BTRFS_I(inode), file_pos, ram_bytes);
 	if (ret < 0)
 		goto out;
 	qg_released = ret;
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 4a09aa2fd975..c884f3ec89a0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3570,9 +3570,9 @@ int btrfs_qgroup_free_data(struct btrfs_inode *inode,
  *
  * NOTE: This function may sleep for memory allocation.
  */
-int btrfs_qgroup_release_data(struct inode *inode, u64 start, u64 len)
+int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len)
 {
-	return __btrfs_qgroup_release_data(BTRFS_I(inode), NULL, start, len, 0);
+	return __btrfs_qgroup_release_data(inode, NULL, start, len, 0);
 }

 static void add_root_meta_rsv(struct btrfs_root *root, int num_bytes,
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index a40ea1c187d7..139cad24a95d 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -346,7 +346,7 @@ int btrfs_verify_qgroup_counts(struct btrfs_fs_info *fs_info, u64 qgroupid,
 /* New io_tree based accurate qgroup reserve API */
 int btrfs_qgroup_reserve_data(struct inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len);
-int btrfs_qgroup_release_data(struct inode *inode, u64 start, u64 len);
+int btrfs_qgroup_release_data(struct btrfs_inode *inode, u64 start, u64 len);
 int btrfs_qgroup_free_data(struct btrfs_inode *inode,
 			   struct extent_changeset *reserved, u64 start,
 			   u64 len);
--
2.17.1

