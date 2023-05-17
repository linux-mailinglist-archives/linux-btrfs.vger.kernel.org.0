Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E215706609
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjEQLEt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjEQLEs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:04:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADDC1988
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7D616358E
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD7C4339B
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321427;
        bh=PKyDgRhl6g0mwpQN/xZBE/fREKmlMkZSLQ0LEDSrAWg=;
        h=From:To:Subject:Date:From;
        b=llcaKsEFYs1EBXkXfTKggz1fvUe4jyEUNXj8UcMfHBOu2jKddPDhe5QZZOjpIjOXn
         JUv5hR1Oe8sq0fyo/iI9edNcYNIgMo1ByFKhXZeqe4+mbQB7vwUMCGHbkfopiaQY3y
         Yb08QTV/dLiRjTggtjBX2VqDKsARQ559CKcK+eqZO5E7cLAoK/K4tiWD/6d4I5Fb09
         VqeeiHcb7ylZRO4c8ySTLKXam8OseI/5FmU6Dib+BMpe6gyBlS0hzWuWRYQR+oAT9L
         6Ux1+drgrRDFaTf7tJs2Wota/HXG7D/G/mePe9LSP0OTrShAbiTNDO8V/qRh3qWY3Q
         Ndl6BTgS6qpQQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix comment referring to no longer existing btrfs_clean_tree_block()
Date:   Wed, 17 May 2023 12:03:44 +0100
Message-Id: <fc211eab020f42f28eec496aca5bbc4e58bc262a.1684320937.git.fdmanana@suse.com>
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

There's a comment at btrfs_init_new_buffer() that refers to a function
named btrfs_clean_tree_block(), however the function was renamed to
btrfs_clear_buffer_dirty() in commit 190a83391bc4 ("btrfs: rename
btrfs_clean_tree_block to btrfs_clear_buffer_dirty"). So update the
comment to refer to the current name.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 581ddb24e113..4f7ac5a5d29e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -4797,7 +4797,7 @@ btrfs_init_new_buffer(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	    !test_bit(BTRFS_ROOT_RESET_LOCKDEP_CLASS, &root->state))
 		lockdep_owner = BTRFS_FS_TREE_OBJECTID;
 
-	/* btrfs_clean_tree_block() accesses generation field. */
+	/* btrfs_clear_buffer_dirty() accesses generation field. */
 	btrfs_set_header_generation(buf, trans->transid);
 
 	/*
-- 
2.34.1

