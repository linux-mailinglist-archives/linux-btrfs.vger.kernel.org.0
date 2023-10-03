Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B967B5DF5
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Oct 2023 02:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjJCAJn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Oct 2023 20:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjJCAJm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 2 Oct 2023 20:09:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F991
        for <linux-btrfs@vger.kernel.org>; Mon,  2 Oct 2023 17:09:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55C0F1F893
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 00:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696291777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=6t0sd0+RWh18cRqiBVSaFBBsNQYUBKdbstofHIFVITw=;
        b=aMhnHYFjDZ6te4MPJ8ySU1JGlymQOra2ISeO7PAC6KzOTzj1k3hbdHuJTAAWz8P9LrbDJU
        kAskr9YupwuAv56mDPGDJa7v2Db4hqSHPwlJ7CrlsekvPCXkSzHyFtTHcUg76S7fLB9gpM
        twUQ+W+wNWCw2sWSts4NWCksylg0yrg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 87C65139F9
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Oct 2023 00:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WpvMEcBbG2XGbgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Oct 2023 00:09:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: properly reserve metadata space for bgt conversion
Date:   Tue,  3 Oct 2023 10:39:18 +1030
Message-ID: <6c556ce0456303fb8ec23a454c3b5e18b874ae91.1696291742.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is a bug report that btrfstune failed to convert to block group
tree.
The bug report shows some very weird call trace, mostly fail at free
space tree code.

One of the concern is the failed conversion may be caused by exhausted
metadata space.
In that case, we're doing quite some metadata operations (one
transaction to convert 64 block groups in one go).

But for each transaction we have only reserved the metadata for one
block group conversion (1 block for extent tree and 1 block for block
group tree, this excludes free space and extent tree operations, as they
should go global rsv).

Although we're not 100% sure about the failed conversion, at least we
should handle the metadata reservation correctly, by properly reserve
the needed space for the batch, and reduce the batch size just in case
there isn't much metadata space left.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/convert-bgt.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tune/convert-bgt.c b/tune/convert-bgt.c
index 77cba3930ae1..dd3a8c750604 100644
--- a/tune/convert-bgt.c
+++ b/tune/convert-bgt.c
@@ -28,7 +28,7 @@
 #include "tune/tune.h"
 
 /* After this many block groups we need to commit transaction. */
-#define BLOCK_GROUP_BATCH	64
+#define BLOCK_GROUP_BATCH	16
 
 int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
 {
@@ -71,7 +71,8 @@ int convert_to_bg_tree(struct btrfs_fs_info *fs_info)
 		error_msg(ERROR_MSG_COMMIT_TRANS, "new bg root: %d", ret);
 		goto error;
 	}
-	trans = btrfs_start_transaction(fs_info->tree_root, 2);
+	trans = btrfs_start_transaction(fs_info->tree_root,
+					2 * BLOCK_GROUP_BATCH);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		errno = -ret;
@@ -119,7 +120,8 @@ iterate_bgs:
 				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
 				return ret;
 			}
-			trans = btrfs_start_transaction(fs_info->tree_root, 2);
+			trans = btrfs_start_transaction(fs_info->tree_root,
+							2 * BLOCK_GROUP_BATCH);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
 				errno = -ret;
@@ -181,7 +183,8 @@ int convert_to_extent_tree(struct btrfs_fs_info *fs_info)
 		error_msg(ERROR_MSG_COMMIT_TRANS, "new extent tree root: %m");
 		goto error;
 	}
-	trans = btrfs_start_transaction(fs_info->tree_root, 2);
+	trans = btrfs_start_transaction(fs_info->tree_root,
+					2 * BLOCK_GROUP_BATCH);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
 		errno = -ret;
@@ -227,7 +230,8 @@ iterate_bgs:
 				error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
 				return ret;
 			}
-			trans = btrfs_start_transaction(fs_info->tree_root, 2);
+			trans = btrfs_start_transaction(fs_info->tree_root,
+							2 * BLOCK_GROUP_BATCH);
 			if (IS_ERR(trans)) {
 				ret = PTR_ERR(trans);
 				errno = -ret;
-- 
2.42.0

