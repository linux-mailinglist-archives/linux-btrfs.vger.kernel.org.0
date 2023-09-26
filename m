Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07B7AED1A
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234685AbjIZMpe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjIZMpd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA91101
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6EFC433C9
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732325;
        bh=whffOXEe4jKO0DIqq0Up5LUMQ8nSfHosfHoB81Johtw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aQyajFsk5ZgEJ6Ppr9jX7XAGZjvXGOzQizGLq/nCSX/Ujkj0+1e62RSFBKO8gWf4+
         gv4dSBVhvEf+m9zeBZytIcHjxIx6NI1Cmn6txJTi/G0EHWg8z/RKEXW/L4chNCPW4A
         UracjHA2TC/hCyLz7GBDgDekfR3tmbU+V1WOlom7thGVc/kC6OjuWKTvvQU699q6ua
         S7GHXdjK+ZoklUhYDYTCyWuhO3S2Vk0EYlg8PxyLttuy5xg8xjcaZPm0eHhStgh5IX
         tip71dBCCApN+1+iumGa18kiAgPh+0zUFCa/M0Uj9LSD7yJwrcyIzfBrma5u6Klxyi
         9Dl/+oZJsXp6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: error when COWing block from a root that is being deleted
Date:   Tue, 26 Sep 2023 13:45:14 +0100
Message-Id: <ff0e4083df92ea1a6d36ba8f53271b74b098a0cd.1695731842.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_cow_block() we check if the block being COWed belongs to a root
that is being deleted and if so we log an error message. However this is
an unexpected case and it indicates a bug somewhere, so we should return
an error and abort the transaction. So change this in the following ways:

1) Move the check after the checks for a stale transaction, so that if
   those checks pass, we can abort the transaction;

2) Abort the transaction with -EUCLEAN, so that if the issue ever happens
   it can easily be noticed;

3) Change the logged message level from error to critical, and change the
   message itself to print the block's logical address and the ID of the
   root;

4) Return -EUCLEAN to the caller;

5) As this is an unexpected scenario, that should never happen, mark the
   check as unlikely, allowing the compiler to potentially generate better
   code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index dff2e07ba437..4eef1a7d1db6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -682,10 +682,6 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 	u64 search_start;
 	int ret;
 
-	if (test_bit(BTRFS_ROOT_DELETING, &root->state))
-		btrfs_err(fs_info,
-			"COW'ing blocks on a fs root that's being dropped");
-
 	/*
 	 * COWing must happen through a running transaction, which always
 	 * matches the current fs generation (it's a transaction with a state
@@ -703,6 +699,14 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		return -EUCLEAN;
 	}
 
+	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+		   "attempt to COW block %llu on root %llu that is being deleted",
+			   buf->start, btrfs_root_id(root));
+		return -EUCLEAN;
+	}
+
 	if (!should_cow_block(trans, root, buf)) {
 		*cow_ret = buf;
 		return 0;
-- 
2.40.1

