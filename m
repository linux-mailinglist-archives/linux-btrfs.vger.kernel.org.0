Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5AB0665
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2019 03:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbfILBNN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 21:13:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:58860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfILBNM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 21:13:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57323AEC4;
        Thu, 12 Sep 2019 01:13:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] btrfs: qgroup: Fix the wrong io_tree when freeing reserved data space
Date:   Thu, 12 Sep 2019 09:13:06 +0800
Message-Id: <20190912011306.14858-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Commit bc42bda22345 ("btrfs: qgroup: Fix qgroup reserved space underflow by
only freeing reserved ranges") is freeing wrong range in
BTRFS_I()->io_failure_tree, which should be BTRFS_I()->io_tree.

Just fix it.

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

