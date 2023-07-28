Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10370766B7E
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 13:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236206AbjG1LOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 07:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbjG1LOd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 07:14:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC002727
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 04:14:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DD2431F8AA
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690542871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEfGKddt/7yisUw7rjRvRxRTTBgqL13QGDkVldRB5ds=;
        b=o1pRTXsL5r2pB8sJMuWGlDPkqpdAERl/s3Uma4Min482cSQPqX+kBkiFUpsMWHkldo1SeI
        zlRdHJjTO+WrG8A9ZT/OP9jOVQqj5UWruDpXqVdTj0b+ujnyK9e/bhwGCeWBUpKwQ21o5f
        A2AcKeQfQoqZH8LNuUM+V45jBxJcNAI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36F79133F7
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CIRLABejw2RBQAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 11:14:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: scrub: don't go ordered workqueue for dev-replace
Date:   Fri, 28 Jul 2023 19:14:07 +0800
Message-ID: <4ff0451b138db382fdb6eceebc1be146d6110f79.1690542141.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1690542141.git.wqu@suse.com>
References: <cover.1690542141.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The workqueue fs_info->scrub_worker would go ordered workqueue if it's a
device replace operation.

However the scrub is relying on multiple workers to do data csum
verification, and we always submit several read requests in a row.

Thus there is no need to use ordered workqueue just for dev-replace.
We have extra synchronization (the main thread will always
submit-and-wait for dev-replace writes) to handle it for zoned devices.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index bfa8feee257f..1001c7724e4c 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2779,8 +2779,7 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 /*
  * get a reference count on fs_info->scrub_workers. start worker if necessary
  */
-static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
-						int is_dev_replace)
+static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 {
 	struct workqueue_struct *scrub_workers = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
@@ -2790,10 +2789,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	if (refcount_inc_not_zero(&fs_info->scrub_workers_refcnt))
 		return 0;
 
-	if (is_dev_replace)
-		scrub_workers = alloc_ordered_workqueue("btrfs-scrub", flags);
-	else
-		scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
+	scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
 	if (!scrub_workers)
 		return -ENOMEM;
 
@@ -2845,7 +2841,7 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 	if (IS_ERR(sctx))
 		return PTR_ERR(sctx);
 
-	ret = scrub_workers_get(fs_info, is_dev_replace);
+	ret = scrub_workers_get(fs_info);
 	if (ret)
 		goto out_free_ctx;
 
-- 
2.41.0

