Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016C721CCB7
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 03:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgGMBDj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 21:03:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMBDj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 21:03:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC8DBADAB
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Jul 2020 01:03:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/4] btrfs: relocation: review the call sites which can be interrupted by signal
Date:   Mon, 13 Jul 2020 09:03:21 +0800
Message-Id: <20200713010322.18507-4-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713010322.18507-1-wqu@suse.com>
References: <20200713010322.18507-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since most metadata reservation calls can return -EINTR when get
interrupted by fatal signal, we need to review the all the metadata
reservation call sites.

In relocation code, the metadata reservation happens in the following
sites:
- btrfs_block_rsv_refill() in merge_reloc_root()
  merge_reloc_root() is a pretty critical section, we don't want to be
  interrupted by signal, so change the flush status to
  BTRFS_RESERVE_FLUSH_LIMIT, so it won't get interrupted by signal.
  Since such change can be ENPSPC-prone, also shrink the amount of
  metadata to reserve a little to avoid deadly ENOSPC there.

- btrfs_block_rsv_refill() in reserve_metadata_space()
  It calls with BTRFS_RESERVE_FLUSH_LIMIT, which won't get interrupted
  by signal.

- btrfs_block_rsv_refill() in prepare_to_relocate()
- btrfs_block_rsv_add() in prepare_to_relocate()
- btrfs_block_rsv_refill() in relocate_block_group()
- btrfs_delalloc_reserve_metadata() in relocate_file_extent_cluster()
- btrfs_start_transaction() in relocate_block_group()
- btrfs_start_transaction() in create_reloc_inode()
  Can be interrupted by fatal signal and we can handle it easily.
  For these call sites, just catch the -EINTR value in btrfs_balance()
  and count them as canceled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 13 +++++++++++--
 fs/btrfs/volumes.c    | 14 +++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2b869fb2e62c..23914edd4710 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1686,12 +1686,21 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		btrfs_unlock_up_safe(path, 0);
 	}
 
-	min_reserved = fs_info->nodesize * (BTRFS_MAX_LEVEL - 1) * 2;
+	/*
+	 * In merge_reloc_root(), we modify the upper level pointer to swap
+	 * the tree blocks between reloc tree and subvolume tree.
+	 * Thus for tree block COW, we COW at most from level 1 to root level
+	 * for each tree.
+	 *
+	 * Thus the needed metadata space is at most root_level * nodesize,
+	 * and * 2 since we have two trees to COW.
+	 */
+	min_reserved = fs_info->nodesize * btrfs_root_level(root_item) * 2;
 	memset(&next_key, 0, sizeof(next_key));
 
 	while (1) {
 		ret = btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
-					     BTRFS_RESERVE_FLUSH_ALL);
+					     BTRFS_RESERVE_FLUSH_LIMIT);
 		if (ret) {
 			err = ret;
 			goto out;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c7a3d4d730a3..40072e10a2fc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4135,7 +4135,19 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	mutex_lock(&fs_info->balance_mutex);
 	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
 		btrfs_info(fs_info, "balance: paused");
-	else if (ret == -ECANCELED && atomic_read(&fs_info->balance_cancel_req))
+	/*
+	 * Balance can be canceled by:
+	 * - Regular cancel request
+	 *   Then ret == -ECANCELED and balance_cancel_req > 0
+	 * - Fatal signal to "btrfs" process
+	 *   Either the signal caught by wait_reserve_ticket() and callers
+	 *   got -EINTR, or caught by btrfs_should_cancel_balance() and
+	 *   got -ECANCELED.
+	 *   Either way, in this case balance_cancel_req = 0, and
+	 *   ret == -EINTR or ret == -ECANCELED.
+	 * So here we only check the return value to catch canceled balance.
+	 */
+	else if (ret == -ECANCELED  || ret == -EINTR)
 		btrfs_info(fs_info, "balance: canceled");
 	else
 		btrfs_info(fs_info, "balance: ended with status: %d", ret);
-- 
2.27.0

