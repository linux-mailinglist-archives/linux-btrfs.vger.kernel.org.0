Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531A76643CA
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238763AbjAJO50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238749AbjAJO4x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704A9479CC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 126A7B81675
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66F9C433F0
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362607;
        bh=lu4lru6yzfzkLpd3u+WnCIu/Ui1fKhfpAtc6CspHGAA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aNmi7H2Rlxhu9PFS/K6LSyaqm0HeG0KU4jRTajQznrJf86aBD6URf3LHAXq69w6UY
         1WO2LptsKBscdY5tClkk6QYJnXBYJbMonliu/pOzMSdRgXU9aFe4cHLxb3xs8nO0B/
         K2fHRLybndXiu9oPLvzTP3BYXMsMEb5jBBxkkS6CxTAx+9UP/tqFookaF3S9Fx+A3U
         oPAN6zXJAtv2Y1FKzY8nIsryLk7g9bbnrfnsBDs0GRDjZ1qWn04mUwFnalDb5L8IET
         +7BTErJaT3s4JcznKkCL1NNvGPldWBu7ushC6RqVRBsHDL1DIewXoQ2H5iDAeqjyT5
         93jGY+IrsAxzA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/8] btrfs: add missing setup of log for full commit at add_conflicting_inode()
Date:   Tue, 10 Jan 2023 14:56:36 +0000
Message-Id: <47d6bbc4ce7158bafc6c1eac9d5c6aa3cd5aadf8.1673361215.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
References: <cover.1673361215.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When logging conflicting inodes, if we reach the maximum limit of inodes,
we return BTRFS_LOG_FORCE_COMMIT to force a transaction commit. However
we don't mark the log for full commit (with btrfs_set_log_full_commit()),
which means that once we leave the log transaction and before we commit
the transaction, some other task may sync the log, which is incomplete
as we have not logged all conflicting inodes, leading to some inconsistent
in case that log ends up being replayed.

So also call btrfs_set_log_full_commit() at add_conflicting_inode().

Fixes: e09d94c9e448 ("btrfs: log conflicting inodes without holding log mutex of the initial inode")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c09daab3f19e..afad44a0becf 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5598,8 +5598,10 @@ static int add_conflicting_inode(struct btrfs_trans_handle *trans,
 	 * LOG_INODE_EXISTS mode) and slow down other fsyncs or transaction
 	 * commits.
 	 */
-	if (ctx->num_conflict_inodes >= MAX_CONFLICT_INODES)
+	if (ctx->num_conflict_inodes >= MAX_CONFLICT_INODES) {
+		btrfs_set_log_full_commit(trans);
 		return BTRFS_LOG_FORCE_COMMIT;
+	}
 
 	inode = btrfs_iget(root->fs_info->sb, ino, root);
 	/*
-- 
2.35.1

