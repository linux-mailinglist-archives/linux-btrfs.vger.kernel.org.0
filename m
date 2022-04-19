Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6135069B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351029AbiDSLVx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 07:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351024AbiDSLVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 07:21:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5165B2B26D
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 04:18:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D31AB1F750
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650367084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7dOI+SVuZ4qJAjJcWfN6naYvw1Au5pSB/wTIxpm9qU=;
        b=NiyzFXcNXl/TtVGm4S2sJFQJ5oRpp6iK8sz64Z4jck7HpKhkSSVJ3Fc+e2Rh7AY3f+v3rG
        DbaUH1QtyrVlQgJ2n92cMl3sW65fOhHI/StuEXAhjy6MvAz+XXxK7r/9t5KCDByAuvpVQc
        VwcgKH2eobHvWZBTFGIYHVPq2zaHMtY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14E46139BE
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:18:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8OW2MWuaXmJLRwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 11:18:03 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: fix a memory leak when starting a transaction on fs with error
Date:   Tue, 19 Apr 2022 19:17:41 +0800
Message-Id: <eb2a7f4ffaead80af30e12c43e8ad3989d7fa83f.1650366929.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650366929.git.wqu@suse.com>
References: <cover.1650366929.git.wqu@suse.com>
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

Fix it by only allocate the new memory after all the checks.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/transaction.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 0201226678ba..56828ee1714b 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -25,23 +25,24 @@ struct btrfs_trans_handle* btrfs_start_transaction(struct btrfs_root *root,
 		int num_blocks)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_trans_handle *h = kzalloc(sizeof(*h), GFP_NOFS);
-
+	struct btrfs_trans_handle *h;
+	
 	if (fs_info->transaction_aborted)
 		return ERR_PTR(-EROFS);
 
-	if (!h)
-		return ERR_PTR(-ENOMEM);
 	if (root->commit_root) {
 		error("commit_root already set when starting transaction");
-		kfree(h);
 		return ERR_PTR(-EINVAL);
 	}
 	if (fs_info->running_transaction) {
 		error("attempt to start transaction over already running one");
-		kfree(h);
 		return ERR_PTR(-EINVAL);
 	}
+
+	h = kzalloc(sizeof(*h), GFP_NOFS);
+	if (!h)
+		return ERR_PTR(-ENOMEM);
+
 	h->fs_info = fs_info;
 	fs_info->running_transaction = h;
 	fs_info->generation++;
-- 
2.35.1

