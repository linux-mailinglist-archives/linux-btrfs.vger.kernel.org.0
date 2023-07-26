Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B90A763BCF
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjGZP6H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbjGZP5e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FDF212B
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2331D61A21
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D68C433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387051;
        bh=ci+v5pYze/SgbTOwXUWl2+aX/mtugpW70pThNVlwvEI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bVw5mpUNvrTJYBRD9pql+Wo9Repn4hWCiJr2zjPwb22J8e0daK8SW8qnBL0xwBPeX
         xkyQFUjSX231cVoaDqA44phqArlB4sgYdnc2AAHjA+fQuTAGV1nyw1jbAb5Uh7DW0W
         aOKMfa5Ddy+wMecdkV+Ya1bI45drZlQtsYBd6QOX2gVHttWUHvdOBxH0eBo6HPNHRp
         1YDLvq7pNLZNpNNQ53WLV4Gj4woG+NGWFBaQQIUqoeGSFII9f+IbbWFOd5UULZb4Vr
         1HQMxjYU605PYnWcW8CoRlZyMsC+OWy2jKHH1jnYcCbrXfA6OGzIcVfz7L6ROH6O7u
         AUULXU1YO2y5Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 15/17] btrfs: avoid starting and committing empty transaction when flushing space
Date:   Wed, 26 Jul 2023 16:57:11 +0100
Message-Id: <b7b65360d65db68392505b76a509ea79893a08cd.1690383587.git.fdmanana@suse.com>
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

When flushing space and we are in the COMMIT_TRANS state, we join a
transaction with btrfs_join_transaction() and then commit the returned
transaction. However btrfs_join_transaction() starts a new transaction if
there is none currently open, which is pointless since comitting a new,
empty transaction, doesn't achieve anything, it only wastes time, IO and
creates an unnecessary rotation of the backup roots.

So use btrfs_attach_transaction_barrier() to avoid starting a new
transaction. This also waits for any ongoing transaction that is
committing (state >= TRANS_STATE_COMMIT_DOING) to fully complete, and
therefore wait for all the extents that were pinned during the
transaction's lifetime to be unpinned.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/space-info.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2db92a201697..17c86db7b1b1 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -814,9 +814,18 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		break;
 	case COMMIT_TRANS:
 		ASSERT(current->journal_info == NULL);
-		trans = btrfs_join_transaction(root);
+		/*
+		 * We don't want to start a new transaction, just attach to the
+		 * current one or wait it fully commits in case its commit is
+		 * happening at the moment. Note: we don't use a nostart join
+		 * because that does not wait for a transaction to fully commit
+		 * (only for it to be unblocked, state TRANS_STATE_UNBLOCKED).
+		 */
+		trans = btrfs_attach_transaction_barrier(root);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
+			if (ret == -ENOENT)
+				ret = 0;
 			break;
 		}
 		ret = btrfs_commit_transaction(trans);
-- 
2.34.1

