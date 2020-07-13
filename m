Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1AF21CCB6
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 03:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGMBDh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 12 Jul 2020 21:03:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:53948 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMBDh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 12 Jul 2020 21:03:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C49CAC20;
        Mon, 13 Jul 2020 01:03:37 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v3 2/4] btrfs: avoid possible signal interruption for btrfs_drop_snapshot() on relocation tree
Date:   Mon, 13 Jul 2020 09:03:20 +0800
Message-Id: <20200713010322.18507-3-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200713010322.18507-1-wqu@suse.com>
References: <20200713010322.18507-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report about bad signal timing could lead to read-only
fs during balance:

  BTRFS info (device xvdb): balance: start -d -m -s
  BTRFS info (device xvdb): relocating block group 73001861120 flags metadata
  BTRFS info (device xvdb): found 12236 extents, stage: move data extents
  BTRFS info (device xvdb): relocating block group 71928119296 flags data
  BTRFS info (device xvdb): found 3 extents, stage: move data extents
  BTRFS info (device xvdb): found 3 extents, stage: update data pointers
  BTRFS info (device xvdb): relocating block group 60922265600 flags metadata
  BTRFS: error (device xvdb) in btrfs_drop_snapshot:5505: errno=-4 unknown
  BTRFS info (device xvdb): forced readonly
  BTRFS info (device xvdb): balance: ended with status: -4

[CAUSE]
The direct cause is the -EINTR from the following call chain when a
fatal signal is pending:

 relocate_block_group()
 |- clean_dirty_subvols()
    |- btrfs_drop_snapshot()
       |- btrfs_start_transaction()
          |- btrfs_delayed_refs_rsv_refill()
             |- btrfs_reserve_metadata_bytes()
                |- __reserve_metadata_bytes()
                   |- wait_reserve_ticket()
                      |- prepare_to_wait_event();
                      |- ticket->error = -EINTR;

Normally this behavior is fine for most btrfs_start_transaction()
callers, as they need to catch the fatal signal and exit asap.

However for balance, especially for the clean_dirty_subvols() case, we're
already doing cleanup works, such -EINTR from btrfs_drop_snapshot()
could cause a lot of unexpected problems.

From the mentioned forced read-only, to later balance error due to half
dropped reloc trees.

[FIX]
Fix this problem by using btrfs_join_transaction() if
btrfs_drop_snapshot() is called from relocation context.

Since btrfs_join_transaction() won't get interrupted by signal, we can
continue the cleanup.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index c0bc35f932bf..d8ef48a807d1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5298,7 +5298,10 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 		goto out;
 	}
 
-	trans = btrfs_start_transaction(tree_root, 0);
+	if (for_reloc)
+		trans = btrfs_join_transaction(tree_root);
+	else
+		trans = btrfs_start_transaction(tree_root, 0);
 	if (IS_ERR(trans)) {
 		err = PTR_ERR(trans);
 		goto out_free;
-- 
2.27.0

