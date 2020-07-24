Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA422BBA9
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 03:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgGXBqq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jul 2020 21:46:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:44372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgGXBqq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jul 2020 21:46:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A3D19AE39;
        Fri, 24 Jul 2020 01:46:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     stable@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: reloc: clear DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance
Date:   Fri, 24 Jul 2020 09:46:40 +0800
Message-Id: <20200724014640.20784-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

commit 1dae7e0e58b484eaa43d530f211098fdeeb0f404 upstream.

[BUG]
There are several reported runaway balance, that balance is flooding the
log with "found X extents" where the X never changes.

[CAUSE]
Commit d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after
merge_reloc_roots") introduced BTRFS_ROOT_DEAD_RELOC_TREE bit to
indicate that one subvolume has finished its tree blocks swap with its
reloc tree.

However if balance is canceled or hits ENOSPC halfway, we didn't clear
the BTRFS_ROOT_DEAD_RELOC_TREE bit, leaving that bit hanging forever
until unmount.

Any subvolume root with that bit, would cause backref cache to skip this
tree block, as it has finished its tree block swap.  This would cause
all tree blocks of that root be ignored by balance, leading to runaway
balance.

[FIX]
Fix the problem by also clearing the BTRFS_ROOT_DEAD_RELOC_TREE bit for
the original subvolume of orphan reloc root.

Add an umount check for the stale bit still set.

Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Cc: <stable@vger.kernel.org> # 5.7.x
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c    | 1 +
 fs/btrfs/relocation.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f71e4dbe1d8a..f00e64fee5dd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1998,6 +1998,7 @@ void btrfs_put_root(struct btrfs_root *root)
 
 	if (refcount_dec_and_test(&root->refs)) {
 		WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
+		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 157452a5e110..f67d736c27a1 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2642,6 +2642,8 @@ void merge_reloc_roots(struct reloc_control *rc)
 					root->reloc_root = NULL;
 					btrfs_put_root(reloc_root);
 				}
+				clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE,
+					  &root->state);
 				btrfs_put_root(root);
 			}
 
-- 
2.27.0

