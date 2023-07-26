Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C98763BD2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjGZP6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbjGZP5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE88F1FDA
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CFBC61B5F
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0620EC433C7
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387052;
        bh=7/Y4pGkDavGww+PdirIjvgUr0Stdn+nHSXolG87588M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZdDxAWXmte1y1sybFFZ84p7DZFNu4YmMk1Qy0JtMmtwbdd4UPcYj4XhnveKjASSnY
         rQ5SeRDD0mDeqzfoaNZZE0R2FvnMKzYv4TuKJfv0xrLPER18jFq1bXsx7pgOJYlmXG
         sVBKU35IN6ZK7r1ioxetEH9m+w8Ie26sEVeTAKhgBlsMoAHIrg1PAqPJZn9FehrMv5
         PVcgV6UnZpEaeG0qUXWtys5Yzi8dpQzaLiOYxjelGZPyS3vwgmd29Dkx6dq8GlS7UK
         KoDLMdQ/lQ08uDTN4YdAejzNX4v2P4ucA2rertfrNG0RWzl3N34iDR4pqz+CIHf48d
         e8GqZwKsw1VKA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 16/17] btrfs: avoid start and commit empty transaction when starting qgroup rescan
Date:   Wed, 26 Jul 2023 16:57:12 +0100
Message-Id: <fc34290c4f32cbba64f89372f8a21789998225d9.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
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

When starting a qgroup rescan, we try to join a running transaction, with
btrfs_join_transaction(), and then commit the transaction. However using
btrfs_join_transaction() will result in creating a new transaction in case
there isn't any running or if there's an existing one already committing.
This is pointless as we only need to attach to an existing one that is
not committing and in case there's an existing one committing, wait for
its commit to complete. Creating and committing an empty transaction is
wasteful, pointless IO and unnecessary rotation of the backup roots.

So use btrfs_attach_transaction_barrier() instead, to avoid creating and
committing empty transactions.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/qgroup.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 2637d6b157ff..1ef60ea8f0bc 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3590,15 +3590,16 @@ btrfs_qgroup_rescan(struct btrfs_fs_info *fs_info)
 	 * going to clear all tracking information for a clean start.
 	 */
 
-	trans = btrfs_join_transaction(fs_info->fs_root);
-	if (IS_ERR(trans)) {
+	trans = btrfs_attach_transaction_barrier(fs_info->fs_root);
+	if (IS_ERR(trans) && trans != ERR_PTR(-ENOENT)) {
 		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
 		return PTR_ERR(trans);
-	}
-	ret = btrfs_commit_transaction(trans);
-	if (ret) {
-		fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
-		return ret;
+	} else if (trans != ERR_PTR(-ENOENT)) {
+		ret = btrfs_commit_transaction(trans);
+		if (ret) {
+			fs_info->qgroup_flags &= ~BTRFS_QGROUP_STATUS_FLAG_RESCAN;
+			return ret;
+		}
 	}
 
 	qgroup_rescan_zero_tracking(fs_info);
-- 
2.34.1

