Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA3DB1714
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2019 03:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfIMBvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Sep 2019 21:51:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:40840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfIMBvd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Sep 2019 21:51:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64C18AE4B;
        Fri, 13 Sep 2019 01:51:31 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 1/2] btrfs: qgroup: Fix the wrong target io_tree when freeing reserved data space
Date:   Fri, 13 Sep 2019 09:51:26 +0800
Message-Id: <20190913015127.14953-1-wqu@suse.com>
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

In the error handling path, btrfs_delalloc_release_space() calls
btrfs_qgroup_free_data() which should clear EXTENT_QGROUP_RESERVED flag
and reduce the reserved data space accroding to the cleared range.

However due to a completion bug, btrfs_qgroup_free_data() will clear
EXTENT_QGROUP_RESERVED flag in BTRFS_I(inode)->io_failure_tree, other
than the correct BTRFS_I(inode)->io_tree.
Since io_failure_tree is never marked with that flag,
btrfs_qgroup_free_data() will not free any data reserved space at all,
causing a leakage.

All of such error handling cases can only be triggered some errors not
from qgroup, so regular EDQUOT error won't trigger the bug.
Normally we need error injection to trigger such bug.

[FIX]
Fix the wrong target io_tree.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflow by only freeing reserved ranges")
Signed-off-by: Qu Wenruo <wqu@suse.com>
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

