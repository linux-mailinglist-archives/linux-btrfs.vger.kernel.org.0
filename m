Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96B22BE30
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jul 2020 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGXGqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jul 2020 02:46:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:50238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgGXGqP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jul 2020 02:46:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1BD25AC20
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jul 2020 06:46:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: qgroup: fix wrong qgroup metadata reserve for delayed inode
Date:   Fri, 24 Jul 2020 14:46:09 +0800
Message-Id: <20200724064610.69442-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For delayed inode facility, qgroup metadata is reserved for it, and
later freed.

However we're freeing more bytes than we reserved.
In btrfs_delayed_inode_reserve_metadata():

	num_bytes = btrfs_calc_metadata_size(fs_info, 1);
	...
		ret = btrfs_qgroup_reserve_meta_prealloc(root,
				fs_info->nodesize, true);
		...
		if (!ret) {
			node->bytes_reserved = num_bytes;

But in btrfs_delayed_inode_release_metadata():

	if (qgroup_free)
		btrfs_qgroup_free_meta_prealloc(node->root,
				node->bytes_reserved);
	else
		btrfs_qgroup_convert_reserved_meta(node->root,
				node->bytes_reserved);

This means, we're always releasing more qgroup metadata rsv than we have
reserved.

This won't trigger selftest warning, as btrfs qgroup metadata rsv has
extra protection against cases like quota enabled half-way.

But we still need to fix this problem any way.

This patch will use the same num_bytes for qgroup metadata rsv so we
could handle it correctly.

Fixes: f218ea6c4792 ("btrfs: delayed-inode: Remove wrong qgroup meta reservation calls")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delayed-inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index bf1595a42a98..0727b10a9a89 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -627,8 +627,7 @@ static int btrfs_delayed_inode_reserve_metadata(
 	 */
 	if (!src_rsv || (!trans->bytes_reserved &&
 			 src_rsv->type != BTRFS_BLOCK_RSV_DELALLOC)) {
-		ret = btrfs_qgroup_reserve_meta_prealloc(root,
-				fs_info->nodesize, true);
+		ret = btrfs_qgroup_reserve_meta_prealloc(root, num_bytes, true);
 		if (ret < 0)
 			return ret;
 		ret = btrfs_block_rsv_add(root, dst_rsv, num_bytes,
-- 
2.27.0

