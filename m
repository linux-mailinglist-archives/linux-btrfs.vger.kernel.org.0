Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F273414F4D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgAaWgj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39199 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgAaWgi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:38 -0500
Received: by mail-qt1-f193.google.com with SMTP id c5so6699734qtj.6
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ccL/mgGwlka9YTOV7kQZS4bJ9ygzaqfarB8fdvzP3+E=;
        b=acVDBCgTDWzGnWjEPBn0k+esz6SA5w14d4JsjjTfCGW3flZUVMI3OGE+9AybS516F3
         FXmzN9E46DA88RW1ELUrrnd1DaW/cqX2MvqUnvlsLu1vTLRLT8ArmAlh0EhTVwRyeT7c
         8xyYguq3Ml686UyAPcjWdXqsdixw+lN+cr3tsbGqacz2Whv5AfYz6+BctqFHfUc+ZM9k
         j1hIDR38VykrSjyAETHLbzLsgdS7qbNhB2HJ3lsZ4jkhhEY8m1Jo3aa6IY34V6lg6fQA
         Oh2gQ9JbNMVqjPw8tX2AyYE7kuB08h4dX5ZhhSGENxJMtJy6YbUdoFEw+9nt+dR7dQO+
         BvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccL/mgGwlka9YTOV7kQZS4bJ9ygzaqfarB8fdvzP3+E=;
        b=tsxxLZXEVB5dYpD4Oji4YIGkfunD8GqiEmpPGQr+gnBqIvfllDAU7sjHyKLjQFeIF/
         Fdl2D/T3VxKU1cnxH5Sj6VI9ZtizNN/c9B/+etvPQO3IUMXjPotG/laVXDfVBdJgCwXU
         RhPPtcBSN8hyLcASiNTUIfVGed8INRfxvjhyAA44pWQp7BrqOPtItbJkdBlwIgRTyVRV
         5SC17t3PWUuZnBJjeGCTJvSxZ7uX2lj5D6uV2M0Xnwpdi+ouO/B3WKnTHDjc1jraboWy
         eIrp8wgSUvRNTPbyIslC9tlmbxO6JN+0s6/V75BUiMV8FfT3VBndad7prqLVjEwBxPmQ
         V/CA==
X-Gm-Message-State: APjAAAUawbMYZ7rQHQ+/ILzDdWanjhR5jDSzP7wBuqz0ezZsiBQRaKe9
        j97YoR5z1yvs1jkVVzp2se379b2X/RJdBQ==
X-Google-Smtp-Source: APXvYqzWIfDv4Wff2g/0CKA9ADma+fn17Nw+G825/wd0rwF7tAlayEHC2QJ77L1li5cUsWnqPzFJuQ==
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr13211550qtd.115.1580510197251;
        Fri, 31 Jan 2020 14:36:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s20sm5224907qkj.100.2020.01.31.14.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/23] btrfs: add the data transaction commit logic into may_commit_transaction
Date:   Fri, 31 Jan 2020 17:36:02 -0500
Message-Id: <20200131223613.490779-13-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
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

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 955f59f4b1d0..9f8ef2a09ad9 100644
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

