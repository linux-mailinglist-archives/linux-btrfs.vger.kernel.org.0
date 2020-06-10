Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84381F4A99
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Jun 2020 03:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgFJBE5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Jun 2020 21:04:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:34914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgFJBE4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Jun 2020 21:04:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1576AADA8
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Jun 2020 01:04:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 3/5] btrfs: file: reserve qgroup space after the hole punch range locked
Date:   Wed, 10 Jun 2020 09:04:42 +0800
Message-Id: <20200610010444.13583-4-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610010444.13583-1-wqu@suse.com>
References: <20200610010444.13583-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The incoming qgroup reserved space timing will move the data reserve to
ordered extent completely.

However in btrfs_punch_hole_lock_range() will call
btrfs_invalidate_page(), which will clear QGROUP_RESERVED bit for the
range.

In current stage it's OK, but if we're making ordered extents to handle
the reserved space, then btrfs_punch_hole_lock_range() can clear the
QGROUP_RESERVED bit before we submit ordered extent, leading to qgroup
reserved space leakage.

So here change the timing to make reserve data space after
btrfs_punch_hole_lock_range().
The new timing is fine for either current code or the new code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index fde125616687..3f4b8f7666a9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3188,14 +3188,14 @@ static int btrfs_zero_range(struct inode *inode,
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
2.26.2

