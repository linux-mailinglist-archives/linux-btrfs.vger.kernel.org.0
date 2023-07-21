Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BC275C3B3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 11:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjGUJw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjGUJwE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 05:52:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D0749C8
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 02:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FFCB60C6E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D487C433C7
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689932970;
        bh=szIdt3W4siF2P0GK26m8ELcnIOxzFkVK+I2zokgs1YI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=j+xvGqAEIRH6B1uG+09rWJLbIxZZh+C+UENa0TMrgOUJg0CAAL6HPHq5q7x9ugS1A
         cmE7DBPPyqNbsdBE2PLu6BsfOFM8Bajv6BncXjjwJIWcXvc5+6S/vinq56htcxVlEa
         rmlatmyP7KrF7Wjb/TCuHBfFR/W3l6NJr0uWlc9lf4fzmxyRvXBg9qrJd3IUCEiC3N
         zYOJqzrS5BJpts+sCKnW/uRpf6EYQ+FAN6R8qaALQZWwxqfALkBwnf7uKjruSd+omR
         6/seWH2mfyqLzIPT9M2V68niZ1MN1g2VMKHyv/Vwv+x1+1X9ElsIvoUBsbW+jc6kUm
         ZnJmw9XCBHs6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: check for commit error at btrfs_attach_transaction_barrier()
Date:   Fri, 21 Jul 2023 10:49:21 +0100
Message-Id: <ce368edf9997c7bc4bd1f0a3e7b8c9fd96450db6.1689932501.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1689932501.git.fdmanana@suse.com>
References: <cover.1689932501.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs_attach_transaction_barrier() is used to get a handle pointing to the
current running transaction if the transaction has not started its commit
yet (its state is < TRANS_STATE_COMMIT_START). If the transaction commit
has started, then we wait for the transaction to commit and finish before
returning - however we completely ignore if the transaction was aborted
due to some error during its commit, we simply return ERR_PT(-ENOENT),
which makes the caller assume everything is fine and no errors happened.

This could make an fsync return success (0) to user space when in fact we
had a transaction abort and the target inode changes were therefore not
persisted.

Fix this by checking for the return value from btrfs_wait_for_commit(),
and if it returned an error, return it back to the caller.

Fixes: d4edf39bd5db ("Btrfs: fix uncompleted transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 8ab85465cdaa..4bb9716ad24a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -826,8 +826,13 @@ btrfs_attach_transaction_barrier(struct btrfs_root *root)
 
 	trans = start_transaction(root, 0, TRANS_ATTACH,
 				  BTRFS_RESERVE_NO_FLUSH, true);
-	if (trans == ERR_PTR(-ENOENT))
-		btrfs_wait_for_commit(root->fs_info, 0);
+	if (trans == ERR_PTR(-ENOENT)) {
+		int ret;
+
+		ret = btrfs_wait_for_commit(root->fs_info, 0);
+		if (ret)
+			return ERR_PTR(ret);
+	}
 
 	return trans;
 }
-- 
2.34.1

