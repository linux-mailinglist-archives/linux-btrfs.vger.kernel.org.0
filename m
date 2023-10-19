Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C137CF89B
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Oct 2023 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjJSMTk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 08:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345442AbjJSMTj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 08:19:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CDDAB
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 05:19:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16105C433CA
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 12:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697717977;
        bh=NBRuM95DyCsyNahvDpLshlxlrGDw1RInQWmJjl47EiU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QfLz7pRkxOCAcBwom621Bzhpog7PA2gnJmG416Awl3d1FlNcYLyrOczzUWEIXVPIl
         Z1ce3QpuqL7NBflB8/9wlD/2nEAQ998TXaO3A9IgowJorThQtUYnDxeZuUFZF2PS6F
         Qoph3Q1bnKhjCKPoI0vnrKntrtV5oJdR+7TnW2MmI92f4A8k9doP8fMBhz4i831xWM
         eSQyQri/q42a5BJC5cUmLsIxWXTZ0VB9I8p6KwY7dzgvkfQhf5eURnU/FrryiwqxsJ
         lDKqT0juDz6KXnNqgwGe7S4DulmR6A9tUs4G0i41EyZp4WScZvlwzqNmE6AXVRs326
         PmQm1UXLmgtuw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: make the logic from btrfs_block_can_be_shared() easier to read
Date:   Thu, 19 Oct 2023 13:19:30 +0100
Message-Id: <99a667b6a8cc9f221c18c5b185f5dac2ed6dad18.1697716427.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1697716427.git.fdmanana@suse.com>
References: <cover.1697716427.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The logic in btrfs_block_can_be_shared() is hard to follow as we have a
lot of conditions in a single if statement including a subexpression with
a logical or and two nested if statements inside the main if statement.

Make this easier to read by using separate if statements that return
immediately when we find a condition that determines if a block can be
or can not be shared.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 3cc3ec472497..788f0dd90f8a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -374,27 +374,35 @@ bool btrfs_block_can_be_shared(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root,
 			       struct extent_buffer *buf)
 {
+	const u64 buf_gen = btrfs_header_generation(buf);
+
 	/*
 	 * Tree blocks not in shareable trees and tree roots are never shared.
 	 * If a block was allocated after the last snapshot and the block was
 	 * not allocated by tree relocation, we know the block is not shared.
 	 */
-	if (test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
-	    buf != root->node &&
-	    (btrfs_header_generation(buf) <=
-	     btrfs_root_last_snapshot(&root->root_item) ||
-	     btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))) {
-		if (buf != root->commit_root)
-			return true;
-		/*
-		 * An extent buffer that used to be the commit root may still be
-		 * shared because the tree height may have increased and it
-		 * became a child of a higher level root. This can happen when
-		 * snapshoting a subvolume created in the current transaction.
-		 */
-		if (btrfs_header_generation(buf) == trans->transid)
-			return true;
-	}
+
+	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
+		return false;
+
+	if (buf == root->node)
+		return false;
+
+	if (buf_gen > btrfs_root_last_snapshot(&root->root_item) &&
+	    !btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
+		return false;
+
+	if (buf != root->commit_root)
+		return true;
+
+	/*
+	 * An extent buffer that used to be the commit root may still be shared
+	 * because the tree height may have increased and it became a child of a
+	 * higher level root. This can happen when snapshoting a subvolume
+	 * created in the current transaction.
+	 */
+	if (buf_gen == trans->transid)
+		return true;
 
 	return false;
 }
-- 
2.40.1

