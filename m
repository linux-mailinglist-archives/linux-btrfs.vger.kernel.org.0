Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64FFE727CCA
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jun 2023 12:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235802AbjFHK2P (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jun 2023 06:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236135AbjFHK2H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jun 2023 06:28:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C022736
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 03:28:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3581360ABF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21ADEC433EF
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jun 2023 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686220083;
        bh=lxXWvJd9ptHEas5fjqgtEn2EeJwV8FqcMoxbPxG2xfg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=padvQe7aQDCctE6/gEG1IqMs+FPgz8zqyEke7Utn2++aN40iRlqUcoutcMmLNQcST
         XRisXYxjy6AtjpTGeWniWn8tysv24ImjDl2XmH+b926lES0wfhK4jOUHjJqgk4IwwR
         GBzz0cI7ul8dfNXecJmmKaDRBq59q1dCjJLQlRDOLDhE3cOQd7RuPFAwTl9233F/o5
         t6kI2KuyQK8VuRZs59D8w68nXvRxjUJhlNYQoDAmHiXxMhSK0KzFfTF/vUmZ3LZIhU
         NO7fxXCJDGTH5JAEF1Cw2BWi4d5RHKE9XP7AoBPJXlujFBv1a4KydvAQe4ZjB2iUHh
         vXUQhCdNcmBIA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 11/13] btrfs: do not BUG_ON() on tree mod log failure at insert_new_root()
Date:   Thu,  8 Jun 2023 11:27:47 +0100
Message-Id: <f1fe3d3561dc5bc194b7802240eaf2ff95ce197a.1686219923.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686219923.git.fdmanana@suse.com>
References: <cover.1686219923.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 620ed3a3e51e..056b174c4b33 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2964,7 +2964,12 @@ static noinline int insert_new_root(struct btrfs_trans_handle *trans,
 
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

