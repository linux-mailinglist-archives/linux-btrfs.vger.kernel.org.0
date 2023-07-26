Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D320A763BD1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjGZP6I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbjGZP5f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34615213F
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1510661A21
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6BDC433C8
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387053;
        bh=7nFN7Zzni+c1bl8gFdH55bcgmbG+dSp3MXqlggjBtJ4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SS1XnTwk1ktEtCSfqIhR6pTWranieT6as+P0iD5URHDvzKTVViMT8UYIusQvEBSYL
         FiH+e25umB2vtgZUWZqzykF4//+SADkO9ZtTSi9+WOzoZSGyqCoPPvBMOwWQ/ibOPR
         t8alwxqE9P6RuTvzzsxBJc3We9VJCr85cUjqkDPOco6uPpNqIlyJipce6nI1J0T3Z7
         aSoFpeC/uWQemxxc+y7vOxaygk3A/lprbMbnDN5rdWN/VduhKJaldaAxWZDHVrQ3Yp
         hsai9Xs/spi/E7Dn/BaxD613+FRLaSnNMCCKBcB73M6SUJf1FjnQSmzQECba6FIiHf
         +yLwjsRs/yquw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 17/17] btrfs: avoid start and commit empty transaction when flushing qgroups
Date:   Wed, 26 Jul 2023 16:57:13 +0100
Message-Id: <347457df0613a568658e0bb4101ab19a06ba15db.1690383587.git.fdmanana@suse.com>
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

When flushing qgroups, we try to join a running transaction, with
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
 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 1ef60ea8f0bc..b99230db3c82 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3758,9 +3758,11 @@ static int try_flush_qgroup(struct btrfs_root *root)
 		goto out;
 	btrfs_wait_ordered_extents(root, U64_MAX, 0, (u64)-1);
 
-	trans = btrfs_join_transaction(root);
+	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
+		if (ret == -ENOENT)
+			ret = 0;
 		goto out;
 	}
 
-- 
2.34.1

