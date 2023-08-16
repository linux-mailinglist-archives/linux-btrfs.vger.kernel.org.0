Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEB277DEA3
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Aug 2023 12:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243900AbjHPK24 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Aug 2023 06:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjHPK2X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Aug 2023 06:28:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41101BD4
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 03:28:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 892A1218A9
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692181700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qF6vmh0VK93ouKMzsWEJMOGL9pCGGv/EUzwDuwDQ7zY=;
        b=Ef0pv8VQ4WRCxUv2QpvKM9O9vwGSNR5mnBS6SA/OInC5WJKSaCrs1dbsAzUHJfnVvqsLXo
        xb91sxyQL3X9VnxlanVh/pZGkZrnczOau7LawigM+DPlrN6ybKBCJBuz6PA739cB41A1fk
        7M+HB8P1djOFzSdeHCootOTivU3lwLM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EFBE81353E
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 10:28:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jbFUL8Ok3GTtbQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Aug 2023 10:28:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: retry flushing for del_balance_item() if the transaction is interrupted
Date:   Wed, 16 Aug 2023 18:28:16 +0800
Message-ID: <77ec19769e75c704cb260b98b41e33340a51c40c.1692181669.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]

There is an internal bug report that there are only 3 lines of btrfs
errors, then btrfs falls read-only:

 [358958.022131] BTRFS info (device dm-9): balance: canceled
 [358958.022148] BTRFS: error (device dm-9) in __cancel_balance:4014: errno=-4 unknown
 [358958.022150] BTRFS info (device dm-9): forced readonly

[CAUSE]
The error number -4 is -EINTR, and according to the code line (although
backported kernel, the code is still relevant upstream), it's the
btrfs_handle_fs_error() call inside reset_balance_state().

This can happen when we try to start a transaction which requires
metadata flushing.

This metadata flushing can be interrupted by signal, thus it can return
-EINTR.

For our case, the -EINTR is deadly because we don't handle the error at
all, and immediately mark the fs read-only in the following call chain:

reset_balance_state()
|- del_balance_item()
|  `- btrfs_start_transation_fallback_global_rsv()
|     `- start_transaction()
|	 `- btrfs_block_rsv_add()
|	    `- __reserve_bytes()
|	       `- handle_reserve_ticket()
|		  `- wait_reserve_ticket()
|		     `- prepare_to_wait_event()
|			This wait has TASK_KILLABLE, thus can be
|			interrupted.
|			Thus we return -EINTR.
|
|- IS_ERR(trans) triggered
|- btrfs_handle_fs_error()
   The fs is marked read-only.

[FIX]
For this particular call site, we can not afford just erroring out with
-EINTR.

This patch would fix the error by retry until either we got a valid
transaction handle, or got an error other than -EINTR.

Since we're here, also enhance the error message a little to make it
more readable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 189da583bb67..e83711fe31bb 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -3507,7 +3507,15 @@ static int del_balance_item(struct btrfs_fs_info *fs_info)
 	if (!path)
 		return -ENOMEM;
 
-	trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
+	do {
+		/*
+		 * The transaction starting here can be interrupted, but if we
+		 * just error out we would mark the fs read-only.
+		 * Thus here we try to start the transaction again if it's
+		 * interrupted.
+		 */
+		trans = btrfs_start_transaction_fallback_global_rsv(root, 0);
+	} while (IS_ERR(trans) && PTR_ERR(trans) == -EINTR);
 	if (IS_ERR(trans)) {
 		btrfs_free_path(path);
 		return PTR_ERR(trans);
@@ -3594,7 +3602,7 @@ static void reset_balance_state(struct btrfs_fs_info *fs_info)
 	kfree(bctl);
 	ret = del_balance_item(fs_info);
 	if (ret)
-		btrfs_handle_fs_error(fs_info, ret, NULL);
+		btrfs_handle_fs_error(fs_info, ret, "failed to delete balance item");
 }
 
 /*
-- 
2.41.0

