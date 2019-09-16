Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F69B39EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2019 14:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731993AbfIPMCq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Sep 2019 08:02:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:55128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727795AbfIPMCq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Sep 2019 08:02:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77AC0AFF3;
        Mon, 16 Sep 2019 12:02:44 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/2] btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space
Date:   Mon, 16 Sep 2019 20:02:38 +0800
Message-Id: <20190916120239.12570-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Under the follow case with qgroup enabled, if some error happened after
we have reserved delalloc space, then in error handling path, we could
cause qgroup data space leakage:

From btrfs_truncate_block() in inode.c:

	ret = btrfs_delalloc_reserve_space(inode, &data_reserved,
					   block_start, blocksize);
	if (ret)
		goto out;

again:
	page = find_or_create_page(mapping, index, mask);
	if (!page) {
		btrfs_delalloc_release_space(inode, data_reserved,
					     block_start, blocksize, true);
		btrfs_delalloc_release_extents(BTRFS_I(inode), blocksize, true);
		ret = -ENOMEM;
		goto out;
	}

[CAUSE]
In above case, btrfs_delalloc_reserve_space() will call
btrfs_qgroup_reserve_data() and mark the io_tree range with
EXTENT_QGROUP_RESERVED flag.

In the error handling path, we have the following call stack:
btrfs_delalloc_release_space()
|- btrfs_free_reserved_data_space()
   |- btrsf_qgroup_free_data()
      |- __btrfs_qgroup_release_data(reserved=@reserved, free=1)
         |- qgroup_free_reserved_data(reserved=@reserved)
            |- clear_record_extent_bits();
            |- freed += changeset.bytes_changed;

However due to a completion bug, qgroup_free_reserved_data() will clear
EXTENT_QGROUP_RESERVED flag in BTRFS_I(inode)->io_failure_tree, other
than the correct BTRFS_I(inode)->io_tree.
Since io_failure_tree is never marked with that flag,
btrfs_qgroup_free_data() will not free any data reserved space at all,
causing a leakage.

This type of error handling can only be triggered by errors outside of
qgroup code. So EDQUOT error from qgroup can't trigger it.

[FIX]
Fix the wrong target io_tree.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflow by only freeing reserved ranges")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Commit message polishment
  Use proper call chain to describe the error, as it's pretty deep.
  And rephrase how to trigger the bug.
---
 fs/btrfs/qgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2891b57b9e1e..64bdc3e3652d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3492,7 +3492,7 @@ static int qgroup_free_reserved_data(struct inode *inode,
 		 * EXTENT_QGROUP_RESERVED, we won't double free.
 		 * So not need to rush.
 		 */
-		ret = clear_record_extent_bits(&BTRFS_I(inode)->io_failure_tree,
+		ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree,
 				free_start, free_start + free_len - 1,
 				EXTENT_QGROUP_RESERVED, &changeset);
 		if (ret < 0)
-- 
2.23.0

