Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738F3218485
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 12:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgGHKAe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 06:00:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:44046 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgGHKAd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Jul 2020 06:00:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CBDAAD41
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 10:00:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: relocation: review the call sites which can be interruped by signal
Date:   Wed,  8 Jul 2020 18:00:22 +0800
Message-Id: <20200708100022.90085-2-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200708100022.90085-1-wqu@suse.com>
References: <20200708100022.90085-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since most metadata reservation calls can return -EINTR when get
interruped by fatal signal, we need to review the all the metadata
reservation call sites.

In relocation code, the metadata reservation happens in the following
sites:
- btrfs_block_rsv_refill() in merge_reloc_root()
  merge_reloc_root() is a pretty critial section, we don't want get
  interrupted by signal, so change the flush status to
  BTRFS_RESERVE_FLUSH_LIMIT, so it won't get interrupted by signal.
  Since such change can be ENPSPC-prone, also shrink the amount of
  metadata to reserve a little to avoid deadly ENOSPC there.

- btrfs_block_rsv_refill() in reserve_metadata_space()
  It calls with BTRFS_RESERVE_FLUSH_LIMIT, which won't get interrupred
  by signal.

- btrfs_block_rsv_refill() in prepare_to_relocate()
- btrfs_block_rsv_add() in prepare_to_relocate()
- btrfs_block_rsv_refill() in relocate_block_group()
- btrfs_delalloc_reserve_metadata() in relocate_file_extent_cluster()
- btrfs_start_transaction() in relocate_block_group()
- btrfs_start_transaction() in create_reloc_inode()
  Can be interruped by fatal signal and we can handle it easily.
  For these call sites, just catch the -EINTR value in btrfs_balance()
  and count them as canceled.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 4 ++--
 fs/btrfs/volumes.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2b869fb2e62c..29bbead29be5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1686,12 +1686,12 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 		btrfs_unlock_up_safe(path, 0);
 	}
 
-	min_reserved = fs_info->nodesize * (BTRFS_MAX_LEVEL - 1) * 2;
+	min_reserved = fs_info->nodesize * level * 2;
 	memset(&next_key, 0, sizeof(next_key));
 
 	while (1) {
 		ret = btrfs_block_rsv_refill(root, rc->block_rsv, min_reserved,
-					     BTRFS_RESERVE_FLUSH_ALL);
+					     BTRFS_RESERVE_FLUSH_LIMIT);
 		if (ret) {
 			err = ret;
 			goto out;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index aabc6c922e04..d60df30bdc47 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4135,7 +4135,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	mutex_lock(&fs_info->balance_mutex);
 	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req))
 		btrfs_info(fs_info, "balance: paused");
-	else if (ret == -ECANCELED && atomic_read(&fs_info->balance_cancel_req))
+	else if (ret == -ECANCELED  || ret == -EINTR)
 		btrfs_info(fs_info, "balance: canceled");
 	else
 		btrfs_info(fs_info, "balance: ended with status: %d", ret);
-- 
2.27.0

