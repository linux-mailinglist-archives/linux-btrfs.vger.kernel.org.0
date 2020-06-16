Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402041FC289
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 02:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbgFQAAI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 20:00:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:54566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFQAAI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 20:00:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E9AEAD4A;
        Wed, 17 Jun 2020 00:00:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH 3/5] btrfs: file: reserve qgroup space after the hole punch range is locked
Date:   Wed, 17 Jun 2020 07:59:53 +0800
Message-Id: <20200616235955.21385-4-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616235955.21385-1-wqu@suse.com>
References: <20200616235955.21385-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The incoming qgroup reserved space timing will move the data reservation
to ordered extent completely.

However in btrfs_punch_hole_lock_range() will call
btrfs_invalidate_page(), which will clear QGROUP_RESERVED bit for the
range.

In current stage it's OK, but if we're making ordered extents handle the
reserved space, then btrfs_punch_hole_lock_range() can clear the
QGROUP_RESERVED bit before we submit ordered extent, leading to qgroup
reserved space leakage.

So here change the timing to make reserve data space after
btrfs_punch_hole_lock_range().
The new timing is fine for either current code or the new code.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 6733b2bf1c7a..d13cfffe1112 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3146,14 +3146,14 @@ static int btrfs_zero_range(struct inode *inode,
 		if (ret < 0)
 			goto out;
 		space_reserved = true;
-		ret = btrfs_qgroup_reserve_data(inode, &data_reserved,
-						alloc_start, bytes_to_reserve);
-		if (ret)
-			goto out;
 		ret = btrfs_punch_hole_lock_range(inode, lockstart, lockend,
 						  &cached_state);
 		if (ret)
 			goto out;
+		ret = btrfs_qgroup_reserve_data(inode, &data_reserved,
+						alloc_start, bytes_to_reserve);
+		if (ret)
+			goto out;
 		ret = btrfs_prealloc_file_range(inode, mode, alloc_start,
 						alloc_end - alloc_start,
 						i_blocksize(inode),
-- 
2.27.0

