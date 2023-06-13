Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38072E787
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jun 2023 17:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbjFMPmY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jun 2023 11:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjFMPmX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jun 2023 11:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F65DF
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 08:42:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15DE16253F
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 15:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F5DC433F0
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jun 2023 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686670939;
        bh=6CIFfOTWhmIclM4DwwImDotooBtOfG/JJ8dB7PWD8BU=;
        h=From:To:Subject:Date:From;
        b=J5ZyIeIj9iS6v7vTUg2pn+///fdQAJW59PFxYIbhXggMwxSAfjYbROG3wViVhmpeN
         b97fTK4QMgPWM4YlPyJBAoQZPCMXukXMJbjq9YJpPS0bhXQGiioKTUDM7F0iWTLv/1
         wRt1L1cFV4HIbjxjy9wZ7Kpll7JJBgc/E2ba3H0VFZP3o1MHnMAzcim8vr0TsoCGIa
         vfgT2khXsqKTbVjUKqRlWgtjDkz24Q7ipcWHIKxmRWcsx+oOk8wxZle7+1/IvPaKFK
         nq0rDjNBiZ+6sQPfNSgmI+YZ0u9Q4jtJZHHLcltJKWRCk3wAQqS3OoTjtTJNsmEy12
         EWHXtTCfyuGhA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: do not BUG_ON on failure to get dir index for new snapshot
Date:   Tue, 13 Jun 2023 16:42:16 +0100
Message-Id: <5563d2c9f143485c62d3ab07446ed1f77f765a2c.1686670878.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During the transaction commit path, at create_pending_snapshot(), there
is no need to BUG_ON() in case we fail to get a dir index for the snapshot
in the parent directory. This should fail very rarely because the parent
inode should be loaded in memory already, with the respective delayed
inode created and the parent inode's index_cnt field already initialized.

However if it fails, it may be -ENOMEM like the comment at
create_pending_snapshot() says or any error returned by
btrfs_search_slot() through btrfs_set_inode_index_count(), which can be
pretty much anything such as -EIO or -EUCLEAN for example. So the comment
is not correct when it says it can only be -ENOMEM.

However doing a BUG_ON() here is overkill, since we can instead abort
the transaction and return the error. Note that any error returned by
create_pending_snapshot() will eventually result in a transaction
abort at cleanup_transaction(), called from btrfs_commit_transaction(),
but we can explicitly abort the transaction at this point instead so that
we get a stack trace to tell us that the call to btrfs_set_inode_index()
failed.

So just abort the transaction and return in case btrfs_set_inode_index()
returned an error at create_pending_snapshot().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/transaction.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index fe0f00e717a8..cf306351b148 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1684,7 +1684,10 @@ static noinline int create_pending_snapshot(struct btrfs_trans_handle *trans,
 	 * insert the directory item
 	 */
 	ret = btrfs_set_inode_index(BTRFS_I(parent_inode), &index);
-	BUG_ON(ret); /* -ENOMEM */
+	if (ret) {
+		btrfs_abort_transaction(trans, ret);
+		goto fail;
+	}
 
 	/* check if there is a file/dir which has the same name. */
 	dir_item = btrfs_lookup_dir_item(NULL, parent_root, path,
-- 
2.34.1

