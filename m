Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE7A2281F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jul 2020 16:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgGUOXG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Jul 2020 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728971AbgGUOXE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Jul 2020 10:23:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54545C061794
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 6so16255328qtt.0
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Jul 2020 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQxqsUrlp4x7HrENuHXKxmhsqNJWIRD3LhIamFg7tBc=;
        b=sQbPRCHRqrLq8uQzrtSrkNtmd3eGdxl5ikMqo8z770FJRCKmPSx2P/EeBMAA/ByvWY
         DBhUZkZMrOzGIJSfHdrNrM84LADvCcmyBU71gGNPfpAgoge6LCOWpwca3UnUqXxf+sAx
         PGN6ejvs1fYjb+1+QGqBvKYlBrHoRDbsQ0H7RQs2kvH1WDV8BfQtmvkPB56dcEDYcY6w
         bBJ+BUQTc34loCC5IBmS1L8MBqMJfxWoorUm6T8+QzhdPaazzBNKrnF5JNZmLGUswcwO
         h3xX5+bhynwAB0mPeqKwVKK0XUNNnw2bhkdNXqxKTdhtLHfGpKl9Vg4/lIsYeOKfXeOi
         f00g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQxqsUrlp4x7HrENuHXKxmhsqNJWIRD3LhIamFg7tBc=;
        b=TkH0wlZHTEVJXn2NbtfbyQcmx0CYvsfQ6wIB6mqJeyO2BbEcYPappycBiYuavA7JB0
         lKRppXMa7a02lfZVXsUCaa1NMQ/SGQDkJHKqzZf2Hv2OuIFo1la8sOdd4j7wxDE05ywB
         fKSk5zawC4/8BSvfsBlacKzVIL3W/ys8vM8LJHPpY5oOQMR7NYXMUaVxnRUo2HKdsQyP
         5Z5EdYFnZwq4kKkAnZ74dSeOcQ7gum9+qYX4PwIpjSKPA+L/fYBrXfcwIedmYx3zf3Ds
         3TP6t6eacEQNg8T+r0oXNT5WskTz2lwYmpeN4fD0N+cR9sDooHgM1yye82icNns4hGWD
         pcFg==
X-Gm-Message-State: AOAM530N8GhtNOuytliYfNquMNBZ6stZhCOnZ/24AsK4p5Co2j8cy28n
        bIR4xM3IDoKmeY/BivsZm8QU7G88S6lQ4Q==
X-Google-Smtp-Source: ABdhPJz3aNDcy4JKZV1Cs99/WREN1HXxoa1Rmid7Rb6vruLILflyB0JKrRCplxUovprbgunel+vaAw==
X-Received: by 2002:aed:3904:: with SMTP id l4mr28701557qte.370.1595341383071;
        Tue, 21 Jul 2020 07:23:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n184sm2511341qkn.49.2020.07.21.07.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:23:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 13/23] btrfs: add the data transaction commit logic into may_commit_transaction
Date:   Tue, 21 Jul 2020 10:22:24 -0400
Message-Id: <20200721142234.2680-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200721142234.2680-1-josef@toxicpanda.com>
References: <20200721142234.2680-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Data space flushing currently unconditionally commits the transaction
twice in a row, and the last time it checks if there's enough pinned
extents to satisfy it's reservation before deciding to commit the
transaction for the 3rd and final time.

Encode this logic into may_commit_transaction().  In the next patch we
will pass in U64_MAX for bytes_needed the first two times, and the final
time we will pass in the actual bytes we need so the normal logic will
apply.

This patch exists soley to make the logical changes I will make to the
flushing state machine separate to make it easier to bisect any
performance related regressions.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 94da7b43e152..be0f117d4ccf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -579,21 +579,33 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
  * will return -ENOSPC.
  */
 static int may_commit_transaction(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info)
+				  struct btrfs_space_info *space_info,
+				  u64 bytes_needed)
 {
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
 	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
 	struct btrfs_trans_handle *trans;
-	u64 bytes_needed;
 	u64 reclaim_bytes = 0;
 	u64 cur_free_bytes = 0;
+	bool do_commit = false;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	if (trans)
 		return -EAGAIN;
 
+	/*
+	 * If we are data and have passed in U64_MAX we just want to
+	 * unconditionally commit the transaction to match the previous data
+	 * flushing behavior.
+	 */
+	if ((space_info->flags & BTRFS_BLOCK_GROUP_DATA) &&
+	   bytes_needed == U64_MAX) {
+		do_commit = true;
+		goto check_pinned;
+	}
+
 	spin_lock(&space_info->lock);
 	cur_free_bytes = btrfs_space_info_used(space_info, true);
 	if (cur_free_bytes < space_info->total_bytes)
@@ -607,7 +619,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : 0;
+	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
 
 	if (bytes_needed > cur_free_bytes)
 		bytes_needed -= cur_free_bytes;
@@ -618,6 +630,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	if (!bytes_needed)
 		return 0;
 
+check_pinned:
 	trans = btrfs_join_transaction(fs_info->extent_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -627,7 +640,8 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	 * we have block groups that are going to be freed, allowing us to
 	 * possibly do a chunk allocation the next loop through.
 	 */
-	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	if (do_commit ||
+	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
 	    __percpu_counter_compare(&space_info->total_bytes_pinned,
 				     bytes_needed,
 				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
@@ -635,7 +649,9 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 
 	/*
 	 * See if there is some space in the delayed insertion reservation for
-	 * this reservation.
+	 * this reservation.  If the space_info's don't match (like for DATA or
+	 * SYSTEM) then just enospc, reclaiming this space won't recover any
+	 * space to satisfy those reservations.
 	 */
 	if (space_info != delayed_rsv->space_info)
 		goto enospc;
@@ -743,7 +759,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		btrfs_wait_on_delayed_iputs(fs_info);
 		break;
 	case COMMIT_TRANS:
-		ret = may_commit_transaction(fs_info, space_info);
+		ret = may_commit_transaction(fs_info, space_info, num_bytes);
 		break;
 	default:
 		ret = -ENOSPC;
-- 
2.24.1

