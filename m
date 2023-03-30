Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC96D0873
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 16:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjC3OjQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 10:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjC3OjP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 10:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB53BDE
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 07:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A976206F
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1C2C433EF
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680187153;
        bh=d0z/EYtopePuyYijzLgLw8g1XqODOlNUFKzL1MwGHAA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UHejVH9OCSNfLmCVCMxyYW7aVePuk8sWm8WYSJpD9XWC+FcDzpy96IOplkXX0e/5p
         LjDF/6o/aSrekARVaOkUxIwcZttgD62ifCuSrXeyJz+gcLGV8wmyiJG2LKHojRfsd4
         +JkI1QypglOEP0ptnZ+/W3tzcCRlSoFO/E1uAI9US9p1JpzDhpR1/5sUpwchptUj6o
         X79LPUyiukz4u7EORfenKAZrylOkDqBFHNfIuvggkZNXMtvDIikmdgZ1BCPLOiir8E
         3puXHDwT0nG2FJg8XxSH9mWDcwvZVvC/BUVHUheSLfXLd4XpiFH+30mUcM15nDQoJ4
         YxKgjVtNmUZmA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: correctly calculate delayed ref bytes when starting transaction
Date:   Thu, 30 Mar 2023 15:39:03 +0100
Message-Id: <93c382a002210831e1051456cdc5c44dbcef4562.1680185833.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1680185833.git.fdmanana@suse.com>
References: <cover.1680185833.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When starting a transaction, we are assuming the number of bytes used for
each delayed ref update matches the number of bytes used for each item
update, that is the return value of:

   btrfs_calc_insert_metadata_size(fs_info, num_items)

However that is not correct when we are using the free space tree, as we
need to multiply that value by 2, since delayed ref updates need to modify
the free space tree besides the extent tree.

So fix this by using btrfs_calc_delayed_ref_bytes() to get the correct
number of bytes used for delayed ref updates.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index a54a5c5a5db3..9e7ba07a35e8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -601,15 +601,16 @@ start_transaction(struct btrfs_root *root, unsigned int num_items,
 		/*
 		 * We want to reserve all the bytes we may need all at once, so
 		 * we only do 1 enospc flushing cycle per transaction start.  We
-		 * accomplish this by simply assuming we'll do 2 x num_items
-		 * worth of delayed refs updates in this trans handle, and
-		 * refill that amount for whatever is missing in the reserve.
+		 * accomplish this by simply assuming we'll do num_items worth
+		 * of delayed refs updates in this trans handle, and refill that
+		 * amount for whatever is missing in the reserve.
 		 */
 		num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_items);
 		if (flush == BTRFS_RESERVE_FLUSH_ALL &&
 		    !btrfs_block_rsv_full(delayed_refs_rsv)) {
-			delayed_refs_bytes = num_bytes;
-			num_bytes <<= 1;
+			delayed_refs_bytes = btrfs_calc_delayed_ref_bytes(fs_info,
+									  num_items);
+			num_bytes += delayed_refs_bytes;
 		}
 
 		/*
-- 
2.34.1

