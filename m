Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586B66643C7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjAJO5V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbjAJO4t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3F711C3D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C173261573
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F60C433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362608;
        bh=BWcYOWQnMIZoDIkSoIb3t8VtubY+R8piJaxbsdCbf2g=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Jh6xdlML5y7apmpfVGAA6lzZzVE6NkzihZ7qrYArb/9IwVxWjYA65mwv77EaPVrmV
         EzEAOrX7/Ba+KbT2h0ZslS104qaTfvm1BQZOuhNBUQWkhkyIya6T5o0Xh4+xKon8+u
         aBMSJ1n+bP+zvzWPGOU4O5ZzeJUPRxidFeEde8e5Wf/6X/sAVVz9XqHWO6AVmzsUlJ
         tMN7WCos6q+pW+hBPdwAcfOo/YBfv0hzO/lIEaYrknIBEJWPemNRJr8LaWDbvJH/Pi
         0n4qKLwF+Zh15A8VKCkRljIcrlm8fv3rdnt2SaLo4lImVNPw///UGiVmR3QssJCe4A
         nmLsXcMSpAsXQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/8] btrfs: do not abort transaction on failure to write log tree when syncing log
Date:   Tue, 10 Jan 2023 14:56:37 +0000
Message-Id: <bd9231ea9024932a1c3da15d3e130f50fc2f9086.1673361215.git.fdmanana@suse.com>
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

When syncing the log, if we fail to write log tree extent buffers, we mark
the log for a full commit and abort the transaction. However we don't need
to abort the transaction, all we really need to do is to make sure no one
can commit a superblock pointing to new log tree roots. Just because we
got a failure writing extent buffers for a log tree, it does not mean we
will also fail to do a transaction commit.

One particular case is if due to a bug somewhere, when writing log tree
extent buffers, the tree checker detects some corruption and the writeout
fails because of that. Aborting the transaction can be very disruptive for
a user, specially if the issue happened on a root filesystem. One example
is the scenario in the Link tag below, where an isolated corruption on log
tree leaves was causing transaction aborts when syncing the log.

Link: https://lore.kernel.org/linux-btrfs/ae169fc6-f504-28f0-a098-6fa6a4dfb612@leemhuis.info/
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c  | 9 ++++++++-
 fs/btrfs/tree-log.c | 2 --
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a7d5a3967ba0..7586a8e9b718 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -367,7 +367,14 @@ static int csum_one_extent_buffer(struct extent_buffer *eb)
 	btrfs_print_tree(eb, 0);
 	btrfs_err(fs_info, "block=%llu write time tree block corruption detected",
 		  eb->start);
-	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
+	/*
+	 * Be noisy if this is an extent buffer from a log tree. We don't abort
+	 * a transaction in case there's a bad log tree extent buffer, we just
+	 * fallback to a transaction commit. Still we want to know when there is
+	 * a bad log tree extent buffer, as that may signal a bug somewhere.
+	 */
+	WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
+		btrfs_header_owner(eb) == BTRFS_TREE_LOG_OBJECTID);
 	return ret;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index afad44a0becf..1f70d4ebffae 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2980,7 +2980,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		ret = 0;
 	if (ret) {
 		blk_finish_plug(&plug);
-		btrfs_abort_transaction(trans, ret);
 		btrfs_set_log_full_commit(trans);
 		mutex_unlock(&root->log_mutex);
 		goto out;
@@ -3112,7 +3111,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		goto out_wake_log_root;
 	} else if (ret) {
 		btrfs_set_log_full_commit(trans);
-		btrfs_abort_transaction(trans, ret);
 		mutex_unlock(&log_root_tree->log_mutex);
 		goto out_wake_log_root;
 	}
-- 
2.35.1

