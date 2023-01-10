Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43D6643CD
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbjAJO5T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbjAJO4u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A874325C3
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45C5F6174C
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D000C433F2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362609;
        bh=UoFoxe9ZLPNVRdBv8DvgaAizG55O+eMh41+K5oF4CWI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mQAm/MfUh/05y6vjc223Yfk+LOvv3aMTduUjgbi1rMgaz4PiKx9RXkT0BfKD/lnKs
         0oEmjNCuCwLNtjCD5EqTv6EpADSHTtxUq3CvRQXOtQxlYsTCidskEvd3eu4pcoFFR0
         obEEaA6QLTfxpN9k/E/NGl+1reUEf5Sq32ZFlhwdkVA2w+pIeNNklZ8KBeFFLlawjo
         csKWD1s2QFqGZrgvt+QnY4IZYryAAsxcncdCUNb+MThMcfhlzQbPzRt9PaNxN8n+fu
         wwLuUlU6zWM/5GdD3Jz/6Rc2gmrTuSMbW6uBNdsBWBaz30vOIrWa/sYLH16D/v8DIb
         fCUIVo+VnKoWw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: do not abort transaction on failure to update log root
Date:   Tue, 10 Jan 2023 14:56:38 +0000
Message-Id: <937c64018b104e83fa8d26a1c54ae67eeb5806a4.1673361215.git.fdmanana@suse.com>
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

When syncing a log, if we fail to update a log root in the log root tree,
we are aborting the transaction if the failure was not -ENOSPC. This is
excessive because there is a chance that a transaction commit can succeed,
and therefore avoid to turn the filesystem into RO mode. All we need to be
careful about is to mark the log for a full commit, which we already do,
to make sure no one commits a super block pointing to an oudated log root
tree.

So don't abort the transaction if we fail to update a log root in the log
root tree, and log an error if the failure is not -ENOSPC, so that it does
not go completely unnoticed.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 1f70d4ebffae..d43261545264 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3044,15 +3044,12 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 		blk_finish_plug(&plug);
 		btrfs_set_log_full_commit(trans);
-
-		if (ret != -ENOSPC) {
-			btrfs_abort_transaction(trans, ret);
-			mutex_unlock(&log_root_tree->log_mutex);
-			goto out;
-		}
+		if (ret != -ENOSPC)
+			btrfs_err(fs_info,
+				  "failed to update log for root %llu ret %d",
+				  root->root_key.objectid, ret);
 		btrfs_wait_tree_log_extents(log, mark);
 		mutex_unlock(&log_root_tree->log_mutex);
-		ret = BTRFS_LOG_FORCE_COMMIT;
 		goto out;
 	}
 
-- 
2.35.1

