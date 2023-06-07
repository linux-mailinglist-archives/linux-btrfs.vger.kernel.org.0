Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C237269AB
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjFGTZE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 15:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjFGTYx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 15:24:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753821FD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 12:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A212636CF
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8443C433D2
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686165891;
        bh=cLNnx81VDwC6n0N1/CBF5gYd5ZObE+tHvJouD2Vb2jY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZKoCq6KqrOAxT3iFKCOWIPY9X9ht4u5i/ePB8saJkm3mxGMUC0FS3O5x92oy1B6BB
         bo+oPV2xP8gjZf9OfvgQqY4VmvhrGMKBJxPIYgOSHPTd+/ZjCt9z9GGjIi5COSsBGl
         ZSzdPYEQehjbJ+vL3v/oHJNhanjuIGDUECJCKCV2Dttf3F6JEQ5qQNEBuBPLCMvKz/
         lVHseml4EzBhzXtcf7D0VkUGUuKHJtsNj4R760XjREyZbQQ7jKKHisyzt8OYTqq52m
         JziKqP4RZxCyByfgiKdbXyHYvSGWXpCmi3QgBDvkxn5toWgWI5EFuuHPDsQTbY7pX7
         fGx3Q6WCn+ldw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/13] btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()
Date:   Wed,  7 Jun 2023 20:24:35 +0100
Message-Id: <7d9be8388f0a32f5ae8bcaf73c215997e76253ed.1686164820.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686164789.git.fdmanana@suse.com>
References: <cover.1686164789.git.fdmanana@suse.com>
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

At insert_new_root(), instead of doing a BUG_ON() in case we fail to
record the tree mod log operation, just return the error to the callers
after releasing the allocated tree block. At this point we haven't made
any changes to the b+tree, so we haven't left it in an inconsistent state
and therefore have no need to abort the transaction. All we need to do is
to unlock and free the extent buffer we just allocated with the purpose
of making it the new root.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index e3c949fa136f..6e59343034d6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2956,7 +2956,12 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
 	old = root->node;
 	ret = btrfs_tree_mod_log_insert_root(root->node, c, false);
-	BUG_ON(ret < 0);
+	if (ret < 0) {
+		btrfs_free_tree_block(trans, btrfs_root_id(root), c, 0, 1);
+		btrfs_tree_unlock(c);
+		free_extent_buffer(c);
+		return ret;
+	}
 	rcu_assign_pointer(root->node, c);
 
 	/* the super has an extra ref to root->node */
-- 
2.34.1

