Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 485FE1AE010
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgDQOkZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 10:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgDQOkY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 10:40:24 -0400
Received: from debian7.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B34E220936
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Apr 2020 14:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587134424;
        bh=ImTghPRolruIPqp+iugOtcvVQq9vYSWfePUWoKuKw5A=;
        h=From:To:Subject:Date:From;
        b=B5vjsaKpMSNjLXGRRoxvohmgcDPAajdxXeA8M+bzWHeDIh9PuptaHN2ETgGTttKMb
         gTQhDQ2LZGg/8jQGt6ZcqA5KTDB/FU94vcvjbCxm6Ftq+kxm03oBGyotDQXagMXM/M
         oY2xTZtF6ND7k6jTjeB9M1y9/9pzhOjr8kJLTsRI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] Btrfs: simplify error handling of clean_pinned_extents()
Date:   Fri, 17 Apr 2020 15:40:21 +0100
Message-Id: <20200417144021.9319-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At clean_pinned_extents(), whether we end up returning success or failure,
we pretty much have to do the same things:

1) unlock unused_bg_unpin_mutex
2) decrement reference count on the previous transaction

We also call btrfs_dec_block_group_ro() in case of failure, but that is
better done in its caller, btrfs_delete_unused_bgs(), since its the
caller that calls inc_block_group_ro(), so it should be responsible for
the decrement operation, as it is in case any of the other functions it
calls fail.

So move the call to btrfs_dec_block_group_ro() from clean_pinned_extents()
into  btrfs_delete_unused_bgs() and unify the error and success return
paths for clean_pinned_extents(), reducing duplicated code and making it
simpler.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 93c180ffcb80..a615d8585df4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1280,25 +1280,17 @@ static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
 		ret = clear_extent_bits(&prev_trans->pinned_extents, start, end,
 					EXTENT_DIRTY);
 		if (ret)
-			goto err;
+			goto out;
 	}
 
 	ret = clear_extent_bits(&trans->transaction->pinned_extents, start, end,
 				EXTENT_DIRTY);
-	if (ret)
-		goto err;
+out:
 	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
 	if (prev_trans)
 		refcount_dec(&prev_trans->use_count);
 
-	return true;
-
-err:
-	mutex_unlock(&fs_info->unused_bg_unpin_mutex);
-	if (prev_trans)
-		refcount_dec(&prev_trans->use_count);
-	btrfs_dec_block_group_ro(bg);
-	return false;
+	return ret == 0;
 }
 
 /*
@@ -1396,8 +1388,10 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 		 * We could have pending pinned extents for this block group,
 		 * just delete them, we don't care about them anymore.
 		 */
-		if (!clean_pinned_extents(trans, block_group))
+		if (!clean_pinned_extents(trans, block_group)) {
+			btrfs_dec_block_group_ro(block_group);
 			goto end_trans;
+		}
 
 		/*
 		 * At this point, the block_group is read only and should fail
-- 
2.11.0

