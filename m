Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0819E72B8A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jun 2023 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234501AbjFLHeQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jun 2023 03:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjFLHeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jun 2023 03:34:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7235819B7
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 00:29:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 04DE422838
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686554627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=U2U4JF5TXWDexy0lLPiCF4ShQtVi0n/m4mBBnfDXRYY=;
        b=AiA2NODAdBq1d3NWrLka40opn0mzoNLJzhTm5QkZEiM1owqocdIKkFn87clYgXEZ2YqMbH
        dQ3HAnz6LGZtk26vNGV59v6O3LG2npsdZ6SuOcnX1IPlp4bVx+2ywNrzZBB4V3bwr/l7TM
        DAcTKbKW7/lW8QZuh5aOaK5A7qNHcNQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64C011357F
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:23:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Oi31DALIhmTSXwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jun 2023 07:23:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: scrub: remove btrfs_fs_info::scrub_wr_completion_workers
Date:   Mon, 12 Jun 2023 15:23:29 +0800
Message-ID: <6e0ace5a15c44d7264a2261597c66a975f214a21.1686554551.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the scrub rework introduced by commit 2af2aaf98205 ("btrfs:
scrub: introduce structure for new BTRFS_STRIPE_LEN based interface")
and later commits, scrub only needs one single workqueue,
fs_info::scrub_worker.

That scrub_wr_completion_workers is initially to handle the delay work
after write bios finished.
But the new scrub code goes submit-and-wait for write bios, thus all the
work are done inside the scrub_worker.

The last user of fs_info::scrub_wr_completion_workers is removed in
commit 16f93993498b ("btrfs: scrub: remove the old writeback
infrastructure"), so we can safely remove the workqueue.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/fs.h    |  1 -
 fs/btrfs/scrub.c | 19 ++-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 5dd24c2916a1..396e2a463480 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -642,7 +642,6 @@ struct btrfs_fs_info {
 	 */
 	refcount_t scrub_workers_refcnt;
 	struct workqueue_struct *scrub_workers;
-	struct workqueue_struct *scrub_wr_completion_workers;
 	struct btrfs_subpage_info *subpage_info;
 
 	struct btrfs_discard_ctl discard_ctl;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index a1a1991c83e9..15e0d9fa80d2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2698,17 +2698,12 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 	if (refcount_dec_and_mutex_lock(&fs_info->scrub_workers_refcnt,
 					&fs_info->scrub_lock)) {
 		struct workqueue_struct *scrub_workers = fs_info->scrub_workers;
-		struct workqueue_struct *scrub_wr_comp =
-						fs_info->scrub_wr_completion_workers;
 
 		fs_info->scrub_workers = NULL;
-		fs_info->scrub_wr_completion_workers = NULL;
 		mutex_unlock(&fs_info->scrub_lock);
 
 		if (scrub_workers)
 			destroy_workqueue(scrub_workers);
-		if (scrub_wr_comp)
-			destroy_workqueue(scrub_wr_comp);
 	}
 }
 
@@ -2719,7 +2714,6 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 						int is_dev_replace)
 {
 	struct workqueue_struct *scrub_workers = NULL;
-	struct workqueue_struct *scrub_wr_comp = NULL;
 	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
@@ -2732,18 +2726,12 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	else
 		scrub_workers = alloc_workqueue("btrfs-scrub", flags, max_active);
 	if (!scrub_workers)
-		goto fail_scrub_workers;
-
-	scrub_wr_comp = alloc_workqueue("btrfs-scrubwrc", flags, max_active);
-	if (!scrub_wr_comp)
-		goto fail_scrub_wr_completion_workers;
+		return -ENOMEM;
 
 	mutex_lock(&fs_info->scrub_lock);
 	if (refcount_read(&fs_info->scrub_workers_refcnt) == 0) {
-		ASSERT(fs_info->scrub_workers == NULL &&
-		       fs_info->scrub_wr_completion_workers == NULL);
+		ASSERT(fs_info->scrub_workers == NULL);
 		fs_info->scrub_workers = scrub_workers;
-		fs_info->scrub_wr_completion_workers = scrub_wr_comp;
 		refcount_set(&fs_info->scrub_workers_refcnt, 1);
 		mutex_unlock(&fs_info->scrub_lock);
 		return 0;
@@ -2754,10 +2742,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 
 	ret = 0;
 
-	destroy_workqueue(scrub_wr_comp);
-fail_scrub_wr_completion_workers:
 	destroy_workqueue(scrub_workers);
-fail_scrub_workers:
 	return ret;
 }
 
-- 
2.41.0

