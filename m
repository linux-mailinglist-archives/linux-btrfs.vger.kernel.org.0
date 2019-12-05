Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236BC114538
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 17:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbfLEQ5o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 11:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfLEQ5o (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 11:57:44 -0500
Received: from debian5.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F0821835
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Dec 2019 16:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575565063;
        bh=nTWp32f8wD7zfY09g2GHSjowwr47G7KZugoRmNJ5j1o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VF82SVt/qvhtgRR3RaeVSwUcFzwc2qBPw6+Ie2Njxi1jt1boIj5BzORGpCP7Ojajo
         27Uo7WsnCNnSYnMlBpXcnWl3Mqi92GQR6DWCveEhJGRayRSdBF41+Pu9PMfs/Z6Lhq
         oJrSejhoFkyXdrhbKal6LOAFkn5h/AcIfbQpMQyE=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2] Btrfs: fix cloning range with a hole when using the NO_HOLES feature
Date:   Thu,  5 Dec 2019 16:57:39 +0000
Message-Id: <20191205165739.18381-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20191119120732.24729-1-fdmanana@kernel.org>
References: <20191119120732.24729-1-fdmanana@kernel.org>
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
  [ ----------- ]  [ hole, implicit, 4MB length ]  [ ------------- ]
  0            1MB                                 5MB            6MB

  Range to clone: [1MB, 6MB)

  Inode B:

    extent B1       extent B2        extent B3         extent B4
  [ ---------- ]  [ --------- ]    [ ---------- ]    [ ---------- ]
  0           1MB 1MB        2MB   2MB        5MB    5MB         6MB

  Target range: [1MB, 6MB) (same as source, to make it easier to explain)

The following can happen:

1) btrfs_punch_hole_range() gets -ENOSPC from __btrfs_drop_extents();

2) At that point, 'cur_offset' is set to 1MB and __btrfs_drop_extents()
   set 'drop_end' to 2MB, meaning it was able to drop only extent B2;

3) We then compute 'clone_len' as 'drop_end' - 'cur_offset' = 2MB - 1MB =
   1MB;

4) We then attempt to insert a file extent item at inode B with a file
   offset of 5MB, which is the value of clone_info->file_offset. This
   fails with error -EEXIST because there's already an extent at that
   offset (extent B4);

5) We abort the current transaction with -EEXIST and return that error
   to user space as well.

Another example, for extent corruption:

  Inode A:

    extent A1                                           extent A2
  [ ----------- ]   [ hole, implicit, 10MB length ]  [ ------------- ]
  0            1MB                                  11MB            12MB

  Inode B:

    extent B1         extent B2
  [ ----------- ]   [ --------- ]    [ ----------------------------- ]
  0            1MB 1MB         5MB  5MB                             12MB

  Target range: [1MB, 12MB) (same as source, to make it easier to explain)

1) btrfs_punch_hole_range() gets -ENOSPC from __btrfs_drop_extents();

2) At that point, 'cur_offset' is set to 1MB and __btrfs_drop_extents()
   set 'drop_end' to 5MB, meaning it was able to drop only extent B2;

3) We then compute 'clone_len' as 'drop_end' - 'cur_offset' = 5MB - 1MB =
   4MB;

4) We then insert a file extent item at inode B with a file offset of 11MB
   which is the value of clone_info->file_offset, and a length of 4MB (the
   value of 'clone_len'). So we get 2 extents items with ranges that
   overlap and an extent length of 4MB, larger then the extent A2 from
   inode A (1MB length);

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
Signed-off-by: David Sterba <dsterba@suse.com>
---

V2: Fixed the logic, it was broken except for trivial cases.

 fs/btrfs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0cb43b682789..8d47c76b7bd1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2599,8 +2599,8 @@ int btrfs_punch_hole_range(struct inode *inode, struct btrfs_path *path,
 			}
 		}
 
-		if (clone_info) {
-			u64 clone_len = drop_end - cur_offset;
+		if (clone_info && drop_end > clone_info->file_offset) {
+			u64 clone_len = drop_end - clone_info->file_offset;
 
 			ret = btrfs_insert_clone_extent(trans, inode, path,
 							clone_info, clone_len);
-- 
2.11.0

