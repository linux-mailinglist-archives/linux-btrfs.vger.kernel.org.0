Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45875058E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Apr 2022 16:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245515AbiDROLs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Apr 2022 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344482AbiDROKQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Apr 2022 10:10:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4D536E09
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 06:10:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BF169210EE
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 13:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650287431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D6pnD33ydbcGt4kJ9gwMzCh5E/jm0KmEjg7zRACxSJM=;
        b=kLPNUlNYU0U9AXNTKTYzk4F96NRqQqSiuhQlTq9IZaT3ktppjnSWfv/stbgrXwZWtObSHY
        Wl0e8Y9TeAk8dxBuquBgIoAMSsVqZ/cZiuaPLwpV5B93gfN/qF10w+kTvlIrFmoV71Kp2N
        nT4ANFxhMiYPTVf4yscjjkHjzydY910=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14BF713ACB
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 13:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2G0YM0ZjXWKBMAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 18 Apr 2022 13:10:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fix a memory leak when starting a transaction on fs with error
Date:   Mon, 18 Apr 2022 21:10:07 +0800
Message-Id: <0aa27221eba9359cd566fc6448d46b12583211f2.1650287150.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650287150.git.wqu@suse.com>
References: <cover.1650287150.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Function btrfs_start_transaction() will allocate the memory
unconditionally, but if the fs has an aborted transaction we don't free
the allocated memory but return error directly.

Fix it by only allocate the new memory after the transaction_aborted
check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/transaction.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 0201226678ba..799520a0ef71 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -25,13 +25,15 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
 		int num_blocks)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_trans_handle *h = kzalloc(sizeof(*h), GFP_NOFS);
-
+	struct btrfs_trans_handle *h;
+	
 	if (fs_info->transaction_aborted)
 		return ERR_PTR(-EROFS);
 
+	h = kzalloc(sizeof(*h), GFP_NOFS);
 	if (!h)
 		return ERR_PTR(-ENOMEM);
+
 	if (root->commit_root) {
 		error("commit_root already set when starting transaction");
 		kfree(h);
-- 
2.35.1

