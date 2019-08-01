Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0472A7E54C
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Aug 2019 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389419AbfHAWTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Aug 2019 18:19:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34386 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbfHAWTt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Aug 2019 18:19:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so53332955qkt.1
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2019 15:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ux82wp1UgdD8obLQVA0sVIz+qvs0enkxEkCiRcoZqsk=;
        b=IAcu3yg+HZBonOrf1fd4dZT+vtUe5kU1Y/noldwxxrITY/pkI5AFUXxIvvCoJhuA5Y
         onUyzKpqsX15APip8jcVqIrCZlj+/9qDgYXLM57PGGGZERtZUh8nXyhRix9BaPEka2NG
         AudPdflrwBkXEPuDYFdAHhXfrLoWPJOZY7NdVP4Q7GDVkQH9VZRYr4GYHUps6FpAV/dx
         fbEL+ccoN6wHfoYPqrFoJbkwuORAd2ApAcJQ8FmtGKJPecN/AGEjCFd4nnQ4LWOX/K2G
         yLb9b4NgMuJnE7VPKrvM1vIA/ujVDzs3RnlevblIvQMxGuEfCMSuhVpLAJB4A22qOw9O
         2xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ux82wp1UgdD8obLQVA0sVIz+qvs0enkxEkCiRcoZqsk=;
        b=VQ3E81FgQVYXg4yoIyg4ewTQJLLtcVqGd1yJl4PvBqkov81KUYUjA8YX23NVmCZlmP
         7QqzOSJsIUZBS8PML9Yj4BsJjLlfhQrpN6AgOm7nOvP+DtaOQ7av0EhSc1NDwtVhXqFF
         eXXmdki6n9TI+4mHNgyzScI/wpJCSs5abBj4UUnWC4kYJIXD356C3UsK38M1UQSH0CVd
         9ZqT4XW7aUDiJlEjDs36yWgPrPd7coxiTN5jU7UQY7/sap7KZHAHn0PMHKhZcEtVmGBt
         x/xhRAq0BWc19RxZRma6KqVNWLbthUPfZ3KqnjnOv+Bhgozsl4GweFE2/k6oTuPIDG+w
         TDfA==
X-Gm-Message-State: APjAAAXMbQrl/jHJbctXNxC1YVHzLsuCEqMpGERaexqtbGC2c50HeISj
        dlrd+zVcvE9NzlcXbGpv6ExH4lXmjIU=
X-Google-Smtp-Source: APXvYqyX5dvyMsP/suKuIeOvJRoQnfbDYiiJMSuGnRGnz5IrvUhuxcqN/eTg0CBZnowB+MO07mbQig==
X-Received: by 2002:a05:620a:16b2:: with SMTP id s18mr85670537qkj.323.1564697987770;
        Thu, 01 Aug 2019 15:19:47 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b13sm43430144qtk.55.2019.08.01.15.19.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 15:19:47 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: introduce an evict flushing state
Date:   Thu,  1 Aug 2019 18:19:37 -0400
Message-Id: <20190801221937.22742-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801221937.22742-1-josef@toxicpanda.com>
References: <20190801221937.22742-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have this weird space flushing loop inside inode.c for evict where
we'll do the normal LIMIT flush, and then commit the transaction and
hope we get our space.  This is super janky, and in fact there's really
nothing stopping us from using FLUSH_ALL except that we run delayed
iputs, which means we could deadlock.  So introduce a new flush state
for eviction that does the normal priority flushing with all of the
states that are safe for eviction.

The nice side-effect of this is that we'll try harder for evictions.
Previously if (for example generic/269) you had a bunch of other
operations happening on the fs you could race with those reservations
when committing the transaction, and eventually miss getting a
reservation for the evict.  With this code we'll have our ticket in
place through the transaction commit, so any pinned bytes will go to our
pending evictions first.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h      |  1 +
 fs/btrfs/inode.c      | 81 +++++++++++++++++++------------------------
 fs/btrfs/space-info.c | 27 +++++++++++++--
 3 files changed, 62 insertions(+), 47 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 313a8194c0ef..ecd52c86d061 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2721,6 +2721,7 @@ enum btrfs_reserve_flush_enum {
 	 * case, use FLUSH LIMIT
 	 */
 	BTRFS_RESERVE_FLUSH_LIMIT,
+	BTRFS_RESERVE_FLUSH_EVICT,
 	BTRFS_RESERVE_FLUSH_ALL,
 };
 
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ee582a36653d..10a3f62470b9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5347,59 +5347,50 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_block_rsv *global_rsv = &fs_info->global_block_rsv;
+	struct btrfs_trans_handle *trans;
 	u64 delayed_refs_extra = btrfs_calc_trans_metadata_size(fs_info, 1);
-	int failures = 0;
-
-	for (;;) {
-		struct btrfs_trans_handle *trans;
-		int ret;
-
-		ret = btrfs_block_rsv_refill(root, rsv,
-					     rsv->size + delayed_refs_extra,
-					     BTRFS_RESERVE_FLUSH_LIMIT);
-
-		if (ret && ++failures > 2) {
-			btrfs_warn(fs_info,
-				   "could not allocate space for a delete; will truncate on mount");
-			return ERR_PTR(-ENOSPC);
-		}
-
-		/*
-		 * Evict can generate a large amount of delayed refs without
-		 * having a way to add space back since we exhaust our temporary
-		 * block rsv.  We aren't allowed to do FLUSH_ALL in this case
-		 * because we could deadlock with so many things in the flushing
-		 * code, so we have to try and hold some extra space to
-		 * compensate for our delayed ref generation.  If we can't get
-		 * that space then we need see if we can steal our minimum from
-		 * the global reserve.  We will be ratelimited by the amount of
-		 * space we have for the delayed refs rsv, so we'll end up
-		 * committing and trying again.
-		 */
-		trans = btrfs_join_transaction(root);
-		if (IS_ERR(trans) || !ret) {
-			if (!IS_ERR(trans)) {
-				trans->block_rsv = &fs_info->trans_block_rsv;
-				trans->bytes_reserved = delayed_refs_extra;
-				btrfs_block_rsv_migrate(rsv, trans->block_rsv,
-							delayed_refs_extra, 1);
-			}
-			return trans;
-		}
+	int ret;
 
+	/*
+	 * Eviction should be taking place at some place safe because of our
+	 * delayed iputs.  However the normal flushing code will run delayed
+	 * iputs, so we cannot use FLUSH_ALL otherwise we'll deadlock.
+	 *
+	 * We reserve the delayed_refs_extra here again because we can't use
+	 * btrfs_start_transaction(root, 0) for the same deadlocky reason as
+	 * above.  We reserve our extra bit here because we generate a ton of
+	 * delayed refs activity by truncating.
+	 *
+	 * If we cannot make our reservation we'll attempt to steal from the
+	 * global reserve, because we really want to be able to free up space.
+	 */
+	ret = btrfs_block_rsv_refill(root, rsv, rsv->size + delayed_refs_extra,
+				     BTRFS_RESERVE_FLUSH_EVICT);
+	if (ret) {
 		/*
 		 * Try to steal from the global reserve if there is space for
 		 * it.
 		 */
-		if (!btrfs_check_space_for_delayed_refs(fs_info) &&
-		    !btrfs_block_rsv_migrate(global_rsv, rsv, rsv->size, 0))
-			return trans;
+		if (btrfs_check_space_for_delayed_refs(fs_info) ||
+		    btrfs_block_rsv_migrate(global_rsv, rsv, rsv->size, 0)) {
+			btrfs_warn(fs_info,
+				   "could not allocate space for delete; will truncate on mount");
+			return ERR_PTR(-ENOSPC);
+		}
+		delayed_refs_extra = 0;
+	}
 
-		/* If not, commit and try again. */
-		ret = btrfs_commit_transaction(trans);
-		if (ret)
-			return ERR_PTR(ret);
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return trans;
+
+	if (delayed_refs_extra) {
+		trans->block_rsv = &fs_info->trans_block_rsv;
+		trans->bytes_reserved = delayed_refs_extra;
+		btrfs_block_rsv_migrate(rsv, trans->block_rsv,
+					delayed_refs_extra, 1);
 	}
+	return trans;
 }
 
 void btrfs_evict_inode(struct inode *inode)
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 03556e411b11..95bf2625ff9b 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -868,6 +868,17 @@ static const enum btrfs_flush_state priority_flush_states[] = {
 	ALLOC_CHUNK,
 };
 
+static const enum btrfs_flush_state evict_flush_states[] = {
+	FLUSH_DELAYED_ITEMS_NR,
+	FLUSH_DELAYED_ITEMS,
+	FLUSH_DELAYED_REFS_NR,
+	FLUSH_DELAYED_REFS,
+	FLUSH_DELALLOC,
+	FLUSH_DELALLOC_WAIT,
+	ALLOC_CHUNK,
+	COMMIT_TRANS,
+};
+
 static void
 priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 				struct btrfs_space_info *space_info,
@@ -944,12 +955,24 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	u64 reclaim_bytes = 0;
 	int ret;
 
-	if (flush == BTRFS_RESERVE_FLUSH_ALL)
+	switch (flush) {
+	case BTRFS_RESERVE_FLUSH_ALL:
 		wait_reserve_ticket(fs_info, space_info, ticket);
-	else
+		break;
+	case BTRFS_RESERVE_FLUSH_LIMIT:
 		priority_reclaim_metadata_space(fs_info, space_info, ticket,
 						priority_flush_states,
 						ARRAY_SIZE(priority_flush_states));
+		break;
+	case BTRFS_RESERVE_FLUSH_EVICT:
+		priority_reclaim_metadata_space(fs_info, space_info, ticket,
+						evict_flush_states,
+						ARRAY_SIZE(evict_flush_states));
+		break;
+	default:
+		ASSERT(0);
+		break;
+	}
 
 	spin_lock(&space_info->lock);
 	ret = ticket->error;
-- 
2.21.0

