Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6025A14F4DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jan 2020 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgAaWgv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jan 2020 17:36:51 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42064 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgAaWgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jan 2020 17:36:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id q15so8203544qke.9
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jan 2020 14:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PcYOcjsXO51RZRYs5Squ6ZI+EtuEXP9Zp6JzVyb12nY=;
        b=HimvHlFWZY4jdWz1y0G4WvBPQbX8lobyn8opMXcoumRwj3Hw1pz3o2Om1tFKhwIVHu
         F0L7dE0+4d1P0eVc9tZ/rH8ChxotFz+5/rwvH2GjSa6UOU8js0msLPUd9mFCM/IAp7PD
         CIRHv0rs/uW8HUZQPWtBQSL0cQWndkpXdCQdq7mQvLyXNNhskGnFSWTRJPGDyDRlZBKc
         acSrYll8bziCWZ5f1y3JtdpmHETfwsC8MIOjAlOM1HVSzOe4DXronpJ7HaSnrF9qIIc3
         3KziYfT2z1lrorcFqqbVXM2hg18aGNYzgSJ0eMA+d2ABQ/mBTa3FkLciHrv9WCRvSV3z
         VeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PcYOcjsXO51RZRYs5Squ6ZI+EtuEXP9Zp6JzVyb12nY=;
        b=gcIRGa+Kh/hAHe7TjMA5Ymt4V05P7ncKLtWXng81k7gBCsNAKeYZjuIzMdaJjfePuP
         2JxhZFFdpz42U8Q6zBxBMCnVxfUIhFbDTIyjMtZVUuJKrekA9i8gesAVYMmpB2OB3+6M
         DfWTqzR2CRwTapuOa7cvd1mMbD2dNqixGX7o8u4ATZ60uZFb/WCalcNkoDZBr9WunKht
         5/k16mlOE2CC7/8yuCnWRVeB59WSgB3WJea5yxXdSAUe+DfyVZ0wqEuWK5yyrmBSbl0J
         joxUSDQmb30PIBxGcX82SjhkT9E8LqBHBWOg2oTorsUZ+w1vYUylKxJ85r8qphCZdX+X
         VRaw==
X-Gm-Message-State: APjAAAUqK3Htkvq1uwxgPDTPtHrn2iem30w5PZ5AAP+VXWnvOfdd4D7i
        uzohtXCEzUqRjOgTrob8NLfybeWbgrmibw==
X-Google-Smtp-Source: APXvYqwEAozPpC6egCcVQyPja6igyGF965Lz8/9emTsSWipHu9VAnA+fK+skKmH+49Gd1DZGHUYvlw==
X-Received: by 2002:a05:620a:2218:: with SMTP id m24mr13292375qkh.442.1580510209247;
        Fri, 31 Jan 2020 14:36:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id b17sm294624qtr.36.2020.01.31.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 14:36:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 19/23] btrfs: don't pass bytes_needed to may_commit_transaction
Date:   Fri, 31 Jan 2020 17:36:09 -0500
Message-Id: <20200131223613.490779-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131223613.490779-1-josef@toxicpanda.com>
References: <20200131223613.490779-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This was put into place in order to mirror the way data flushing handled
committing the transaction.  Now that we do not loop on committing the
transaction simply force a transaction commit if we are data.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 3060754a3341..cef14a4d4167 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -412,14 +412,14 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
  * will return -ENOSPC.
  */
 static int may_commit_transaction(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info,
-				  u64 bytes_needed)
+				  struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
 	struct btrfs_block_rsv *delayed_refs_rsv = &fs_info->delayed_refs_rsv;
 	struct btrfs_trans_handle *trans;
 	u64 reclaim_bytes = 0;
+	u64 bytes_needed;
 	u64 cur_free_bytes = 0;
 	bool do_commit = false;
 
@@ -428,12 +428,10 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 		return -EAGAIN;
 
 	/*
-	 * If we are data and have passed in U64_MAX we just want to
-	 * unconditionally commit the transaction to match the previous data
-	 * flushing behavior.
+	 * If we are data just force the commit, we aren't likely to do this
+	 * over and over again.
 	 */
-	if ((space_info->flags & BTRFS_BLOCK_GROUP_DATA) &&
-	   bytes_needed == U64_MAX) {
+	if (space_info->flags & BTRFS_BLOCK_GROUP_DATA) {
 		do_commit = true;
 		goto check_pinned;
 	}
@@ -451,7 +449,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
+	bytes_needed = (ticket) ? ticket->bytes : 0;
 
 	if (bytes_needed > cur_free_bytes)
 		bytes_needed -= cur_free_bytes;
@@ -584,7 +582,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 		btrfs_wait_on_delayed_iputs(fs_info);
 		break;
 	case COMMIT_TRANS:
-		ret = may_commit_transaction(fs_info, space_info, num_bytes);
+		ret = may_commit_transaction(fs_info, space_info);
 		break;
 	default:
 		ret = -ENOSPC;
-- 
2.24.1

