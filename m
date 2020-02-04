Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCB0D151E29
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBDQUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:17 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38099 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgBDQUR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:17 -0500
Received: by mail-qt1-f196.google.com with SMTP id c24so14763591qtp.5
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y29LwdcTu1+BKPR7jDshcPMs2ruzWr9msTLa56nhMLg=;
        b=XfNnPhDavm3GvcCMUCrvbJfSXwuOKIYgZ88ou9rjVzN4yqa2H/49dgaLvUPq4w9jyg
         iHiobaxOyBmJl+7V4svlnrWDm/bVXUxITLtkLum6bDYQdpHYDoYHV970Sofs0/BfnVMh
         oEMj0LvMFpdMWuGPdG3aFG8DBNB6dwqu9D5RIGs9aDfOxtjFoWDmz+5i5JqCp9Stf+3z
         uhgOL5ijS3IqhXCXj0FTKsxzok5heEgNay8szSpLYrG6psKycy5q/1Cd6zNWca4HKefB
         8dYKm7KnDZ/qYMdvHLbtrNp3QhdgKDUduJQisBIQJhdJ/zR+epfnpLSXacag/Mz1AaEJ
         oChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y29LwdcTu1+BKPR7jDshcPMs2ruzWr9msTLa56nhMLg=;
        b=M2OTi+tsdKS5ZWKUyhClboILtxI+MVOx4EzYMx/rsNapqzQ8775k8pyS21H9uuBVpH
         GTXw7AXEdzVwv0+yeozaatfkAQnVWLk6PJFUq3XooZMFhWH2N2dq9fp61FknZIPjuF/E
         VyAvQiuab3n2Tw9sfuvAFJPPwAcP+a0rGMNzzoQdZDf/1FJlN3mfPN/4A+gV37ghoAKH
         71WB7xZaBCqVzCbUkHWfGIHTS7YlZ53/pYKZMXXnmFmXlSTUVQphUlcbelsGCfS5Z5nB
         M5VXQhy7+FDBOIrMLBD32MZJ4+D0vBnAtuf4owWlOki4QWkKHOzG6dS9Ye5WVM8TClvW
         GEmQ==
X-Gm-Message-State: APjAAAWOI200F2g6uPgD4SD9BVVzKhM6qJPwqOH0V/MYUmsXHJbjSZoK
        v99ROrVGJYaGrcXKe1/A/GedWpLbA5dshA==
X-Google-Smtp-Source: APXvYqyHBdUGsIQGuwCJpVXdltmIBWoDdP6BoiM6BFuK6nbkTxc19NE8iEn2wJ/8ocxy+Qo8W2q8cQ==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr28971164qtd.74.1580833215590;
        Tue, 04 Feb 2020 08:20:15 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u21sm5524568qke.102.2020.02.04.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 13/23] btrfs: add the data transaction commit logic into may_commit_transaction
Date:   Tue,  4 Feb 2020 11:19:41 -0500
Message-Id: <20200204161951.764935-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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
 fs/btrfs/space-info.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index e348468489c7..ad203717269c 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -412,20 +412,32 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
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
@@ -439,7 +451,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : 0;
+	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
 
 	if (bytes_needed > cur_free_bytes)
 		bytes_needed -= cur_free_bytes;
@@ -450,6 +462,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	if (!bytes_needed)
 		return 0;
 
+check_pinned:
 	trans = btrfs_join_transaction(fs_info->extent_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -459,7 +472,8 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	 * we have block groups that are going to be freed, allowing us to
 	 * possibly do a chunk allocation the next loop through.
 	 */
-	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	if (do_commit ||
+	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
 	    __percpu_counter_compare(&space_info->total_bytes_pinned,
 				     bytes_needed,
 				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
@@ -570,7 +584,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

