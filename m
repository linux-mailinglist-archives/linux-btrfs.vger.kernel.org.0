Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4B81DAB31
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 08:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgETG7D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 02:59:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgETG7D (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 02:59:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CDA97AC77
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 06:59:04 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: relocation: Clear the DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance
Date:   Wed, 20 May 2020 14:58:51 +0800
Message-Id: <20200520065851.12689-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520065851.12689-1-wqu@suse.com>
References: <20200520065851.12689-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There are several reported runaway balance, that balance is flooding the
kernel with "Found X extents" where the X never changes.

[CAUSE]
Commit d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after
merge_reloc_roots") introduced BTRFS_ROOT_DEAD_RELOC_TREE bit to
indicate that one subvolume has finished its tree blocks swap with its
reloc tree.

However if balance is canceled or hits ENOSPC halfway, we didn't clear
the BTRFS_ROOT_DEAD_RELOC_TREE bit, leaving that bit hanging forever
until unmount.

Any subvolume root with that bit, would cause backref cache to skip this
tree block, as it has finished its tree block swap.
This would cause all tree blocks of that root be ignored by balance,
leading to runaway balance.

[FIX]
Fix the problem by also clearing the BTRFS_ROOT_DEAD_RELOC_TREE bit for
the original subvolume of orphan reloc root.

Furthermore to avoid such damn bug to bother anybody anymore, add
unmount time check to detect and warn about this bit.

Fixes: d2311e698578 ("btrfs: relocation: Delay reloc tree deletion after merge_reloc_roots")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c    | 1 +
 fs/btrfs/relocation.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fced949b150c..e6def8fc87dd 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1996,6 +1996,7 @@ void btrfs_put_root(struct btrfs_root *root)
 
 	if (refcount_dec_and_test(&root->refs)) {
 		WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
+		WARN_ON(test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state));
 		if (root->anon_dev)
 			free_anon_bdev(root->anon_dev);
 		btrfs_drew_lock_destroy(&root->snapshot_lock);
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 420348606123..595097c4a060 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1936,6 +1936,8 @@ void merge_reloc_roots(struct reloc_control *rc)
 					root->reloc_root = NULL;
 					btrfs_put_root(reloc_root);
 				}
+				clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE,
+					  &root->state);
 				btrfs_put_root(root);
 			}
 
-- 
2.26.2

