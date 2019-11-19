Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B71023E8
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Nov 2019 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfKSMHi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Nov 2019 07:07:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSMHi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Nov 2019 07:07:38 -0500
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40849222CD
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Nov 2019 12:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574165257;
        bh=IofSgCiJWkzyZtttH7o5BARjNgM/jumMZHZU+RXGXss=;
        h=From:To:Subject:Date:From;
        b=P9XrXvWf9X3LvNCj/PbExyHHHaUr7kiXtQOrKZ61WDH06ySQvqXqHrUsFD0/iF6D6
         ejYlknuHPgseP7D6FlNpK3bkIqlHyOOGg1Fgm+6fh6QaBNHx+sHfW7tb3W4uMrFcB4
         XZaf/7+NWLQYWgY040vTbEwBn8tweBlakL0Zw/K4=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix cloning range with a hole when using the NO_HOLES feature
Date:   Tue, 19 Nov 2019 12:07:32 +0000
Message-Id: <20191119120732.24729-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using the NO_HOLES feature if we clone a range that contains a hole
and a temporary ENOSPC happens while dropping extents from the target
inode's range, we can end up failing and aborting the transaction with
-EEXIST or with a corrupt file extent item, that has a length greater
than it should and overlaps with other extents. For example when cloning
the following range from inode A to inode B:

  Inode A:

    extent A1                                          extent A2
  [ ----------- ]  [ hole, implicit, 4Mb length ]  [ ------------- ]
  0            1Mb                                 5Mb            6Mb

  Range to clone: [1Mb, 6Mb[

  Inode B:

    extent B1       extent B2        extent B3         extent B4
  [ ---------- ]  [ --------- ]    [ ---------- ]    [ ---------- ]
  0           1Mb 1Mb        2Mb   2Mb        5Mb    5Mb         6Mb

  Target range: [1Mb, 6Mb[ (same as source, to make it easier to explain)

The following can happen:

1) btrfs_punch_hole_range() gets -ENOSPC from __btrfs_drop_extents();

2) At that point, 'cur_offset' is set to 1Mb and __btrfs_drop_extents()
   set 'drop_end' to 2Mb, meaning it was able to drop only extent B2;

3) We then compute 'clone_len' as 'drop_end' - 'cur_offset' = 2Mb - 1Mb =
   1Mb;

4) We then attempt to insert a file extent item at inode B with a file
   offset of 5Mb, which is the value of clone_info->file_offset. This
   fails with error -EEXIST because there's already an extent at that
   offset (extent B4);

5) We abort the current transaction with -EEXIST and return that error
   to user space as well.

Another example, for extent corruption:

  Inode A:

    extent A1                                           extent A2
  [ ----------- ]   [ hole, implicit, 10Mb length ]  [ ------------- ]
  0            1Mb                                  11Mb            12Mb

  Inode B:

    extent B1         extent B2
  [ ----------- ]   [ --------- ]    [ ----------------------------- ]
  0            1Mb 1Mb         5Mb  5Mb                             12Mb

  Target range: [1Mb, 12Mb[ (same as source, to make it easier to explain)

1) btrfs_punch_hole_range() gets -ENOSPC from __btrfs_drop_extents();

2) At that point, 'cur_offset' is set to 1Mb and __btrfs_drop_extents()
   set 'drop_end' to 5Mb, meaning it was able to drop only extent B2;

3) We then compute 'clone_len' as 'drop_end' - 'cur_offset' = 5Mb - 1Mb =
   4Mb;

4) We then insert a file extent item at inode B with a file offset of 11Mb
   which is the value of clone_info->file_offset, and a length of 4Mb (the
   value of 'clone_len'). So we get 2 extents items with ranges that
   overlap and an extent length of 4Mb, larger then the extent A2 from
   inode A (1Mb length);

5) After that we end the transaction, balance the btree dirty pages and
   then start another or join the previous transaction. It might happen
   that the transaction which inserted the incorrect extent was committed
   by another task so we end up with extent corruption if a power failure
   happens.

So fix this by making sure we attempt to insert the extent to clone at
the destination inode only if we are past dropping the sub-range that
corresponds to a hole.

Fixes: 690a5dbfc51315 ("Btrfs: fix ENOSPC errors, leading to transaction aborts, when cloning extents")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index c332968f9056..454aaf0b825c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2601,7 +2601,7 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			}
 		}
 
-		if (clone_info) {
+		if (clone_info && cur_offset >= clone_info->file_offset) {
 			u64 clone_len = drop_end - cur_offset;
 
 			ret = btrfs_insert_clone_extent(trans, inode, path,
-- 
2.11.0

