Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F15151156
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 21:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgBCUuS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 15:50:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42949 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgBCUuQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 15:50:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so15655293qke.9
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 12:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UY9pDsiEJ4ecLTN/VAYgCrnEerX5SYgUHWiAKxRIWxY=;
        b=y4DDuVDVFmdc+hHdSTXYRc7Ws0Px0VCbTXRjXBKWRdODMtWgZy9umNa2a3i+ERPJqR
         qs/DrSNANpD2AZDVw+k5Pw7NKqoOXHxQ1ZjawuMjcZlXSihK105YVUzGm2hZw2/BA83A
         7hKN+lZwtpg/7akqokdk+u8SScHGfiuUtzqRTxcI3xYoqlC2kkXjShAEj1+wtOfOFqij
         dfgiuHoykxcXnGYXZbXIWvU683qCWZl8RPlCBk9EGoY+uRUhgr3UDryE6iExEeVtnOzv
         JZ8mMiCPyqO7dda51qJmJ/u9V5RRSLvhKFIFC4NaT4dWBxxyveXPEKqoQaW9Ejft5M/j
         K0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UY9pDsiEJ4ecLTN/VAYgCrnEerX5SYgUHWiAKxRIWxY=;
        b=mKp+PmC86dsmNcNJAQuMi3Eg1A0Obh7P6j3cmV4g025rXbM9uPKtqmlLYpz19gsqKN
         +mLhLpSldFbiKfNZCLBeU0HxFATCGUN4Av85n4tbcBWNRG6ARPYcOZtKthPPLZdt0JAe
         1rmB7izHEuUst9ZRyisWnfYj8II0AikInsjT6r+XXCq4sTTChcvNCEUopl5wkkeuFkbs
         fGjLPFIHwcJibjBkvV5s/o74aZr3697UnsfKCqGi+ooRcbKAHFTvIMLHPGNaFkhH+2Hx
         IrvEfvUQIrRpexn6chtX8UdHj7p9Ef9QGlkg6+EJaTsE10ftc5d/TYN5PW0LRX7OpajZ
         Onlw==
X-Gm-Message-State: APjAAAUdOkqcXwteMFFav0KsaukfnHuuPSgdIWc9XFF8/1djZdUWJFmd
        lJdBHNhiigKQGHYlsKZjpFKpmo245UneiQ==
X-Google-Smtp-Source: APXvYqxQdlTAxF/VvHwUXEke51v/aouXoTai0P08R3MKmfTRl7CF/xGRs6grM/mNex1a3vE+wyCAtA==
X-Received: by 2002:a37:a8c1:: with SMTP id r184mr25045009qke.151.1580763015497;
        Mon, 03 Feb 2020 12:50:15 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id a145sm9965639qkg.128.2020.02.03.12.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 12:50:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 13/24] btrfs: add the data transaction commit logic into may_commit_transaction
Date:   Mon,  3 Feb 2020 15:49:40 -0500
Message-Id: <20200203204951.517751-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200203204951.517751-1-josef@toxicpanda.com>
References: <20200203204951.517751-1-josef@toxicpanda.com>
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

