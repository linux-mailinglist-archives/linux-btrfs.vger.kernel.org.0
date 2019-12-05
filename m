Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C6D11453A
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 17:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbfLEQ6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 11:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLEQ6p (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 11:58:45 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB82821835
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2019 16:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575565124;
        bh=D+O0x1Aby6xbq96gSrT6v8SGHCnEFQXZRuoO0XWfcEA=;
        h=From:To:Subject:Date:From;
        b=BRnZ8OZwhqe9zo2DXoVUj+Hy3jzeOLBofpeGEIclIsuhcHc7HOaSfSHTNn8kAaxpV
         wmwdaszBtJJ5mxpOOx9SQ25FU9jtu12ByyT3H5lCVsBSyrXo23azS6DafYXIrBXthN
         uBRl+VQCmVyAVj0IcKEp+d6WmkgTw/zoAFpFJw1Y=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix hole extent items with a zero size after range cloning
Date:   Thu,  5 Dec 2019 16:58:41 +0000
Message-Id: <20191205165841.18524-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Normally when cloning a file range if we find an implicit hole at the end
of the range we assume it is because the NO_HOLES feature is enabled.
However that is not always the case. One well known case [1] is when we
have a power failure after mixing buffered and direct IO writes against
the same file.

In such cases we need to punch a hole in the destination file, and if
the NO_HOLES feature is not enabled, we need to insert explicit file
extent items to represent the hole. After commit 690a5dbfc51315
("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning
extents"), we started to insert file extent items representing the hole
with an item size of 0, which is invalid and should be 53 bytes (the size
of a btrfs_file_extent_item structure), resulting in all sorts of
corruptions and invalid memory accesses. This is detected by the tree
checker when we attempt to write a leaf to disk.

The problem can be sporadically triggered by test case generic/561 from
fstests. That test case does not exercise power failure and creates a new
filesystem when it starts, so it does not use a filesystem created by any
previous test that tests power failure. However the test does both
buffered and direct IO writes (through fsstress) and it's precisely that
which is creating the implicit holes in files. That happens even before
the commit mentioned earlier. I need to investigate why we get those
implicit holes to check if there is a real problem or not. For now this
change fixes the regression of introducing file extent items with an item
size of 0 bytes.

Fix the issue by calling btrfs_punch_hole_range() without passing a
btrfs_clone_extent_info structure, which ensures file extent items are
inserted to represent the hole with a correct item size. We were passing
a btrfs_clone_extent_info with a value of 0 for its 'item_size' field,
which was causing the insertion of file extent items with an item size
of 0.

[1] https://www.spinics.net/lists/linux-btrfs/msg75350.html

Fixes: 690a5dbfc51315 ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents")
Reported-by: David Sterba <dsterba@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1ee0b775e65..3418decb9e61 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3720,24 +3720,18 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 	ret = 0;
 
 	if (last_dest_end < destoff + len) {
-		struct btrfs_clone_extent_info clone_info = { 0 };
 		/*
-		 * We have an implicit hole (NO_HOLES feature is enabled) that
-		 * fully or partially overlaps our cloning range at its end.
+		 * We have an implicit hole that fully or partially overlaps our
+		 * cloning range at its end. This means that we either have the
+		 * NO_HOLES feature enabled or the implicit hole happened due to
+		 * mixing buffered and direct IO writes against this file.
 		 */
 		btrfs_release_path(path);
 		path->leave_spinning = 0;
 
-		/*
-		 * We are dealing with a hole and our clone_info already has a
-		 * disk_offset of 0, we only need to fill the data length and
-		 * file offset.
-		 */
-		clone_info.data_len = destoff + len - last_dest_end;
-		clone_info.file_offset = last_dest_end;
 		ret = btrfs_punch_hole_range(inode, path,
 					     last_dest_end, destoff + len - 1,
-					     &clone_info, &trans);
+					     NULL, &trans);
 		if (ret)
 			goto out;
 
-- 
2.11.0

