Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 457A0151E2F
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBDQU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:27 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45910 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbgBDQU1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so14707888qte.12
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bOMriISNtn7Nfgh+pmHYFzgwkGJzoHX5p33VWdymsT4=;
        b=kfwNDBo8Q5KwypHLzGLeGVhxcGwlBngKJumIi2lkWq6uUDsyrzjfUOrqLnhTx2UAx1
         2xre/BPufatp2Q5QLILDJm4UA6+82JjttUcDHX29kfB7cJ8ZHYZZjS2Ni431efwqKOlU
         pUIVOEldircEvrJ2BjeNktzHR9lmxTUxtmtjCNRLII9Vkd8adqxd1quuqKRse1vXDWmd
         5TfGX5oNb/cnavx5aSuF8lz0ouRBFYT1I5XBMuG5C2rQ+5+NBAiEoCpmHYo9uZPy/0yi
         jWm13gfgPJUJA1X+ohUcaeKVROo2afzyfO/L0EZqgzQ8H1ZThlIZEPiuUZ5F/vWVICWC
         H2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bOMriISNtn7Nfgh+pmHYFzgwkGJzoHX5p33VWdymsT4=;
        b=cLkP/pmTTDH4kEI8bxtGn6E3fxu33wGQngUBZ/vQh4IeL365Jc4DNb6Vqo4bvyEHP4
         ASEy/w74MJPYo2sNpT9EIrOa7VXuyEOphkRBfUDo5Y6B/Qv/dCN+DHthUbOmV6sDSkKT
         Kyz2Zst3/L0U2YfGIkJWqabcjrUcmQruChEmc87zht9EM3IAk5HDUqN5rjAZxEP6ozSu
         NOwpU9TBuhuH1vU+byfdc4qAaU0IOG4DXUi6svTYF29OU5ZF2NXeVlVg4S+mZVHNHO/Y
         Z6V9irowlIqWvfPCW4YNiEo6O4sjrkOEZnChjROVwyDXE59Sbb7+fEp0I1sz/BncHXxC
         /+jg==
X-Gm-Message-State: APjAAAXJihPsj1eLD4l8fp830fWhhjWMsL8tsIw76Zm8tfWjFMJShJj2
        2ah854UHnkevnEStq+wf68Nj+ZzUaCB9Nw==
X-Google-Smtp-Source: APXvYqz/ZlY8DyfLvuLYQv90Nh88RoHZ4kSBh38kAe/GdpE+YOroJCSMC0pJtHFKCFt30/RHPW0mQw==
X-Received: by 2002:ac8:5358:: with SMTP id d24mr28986918qto.161.1580833225418;
        Tue, 04 Feb 2020 08:20:25 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 124sm11242488qko.11.2020.02.04.08.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 19/23] btrfs: don't force commit if we are data
Date:   Tue,  4 Feb 2020 11:19:47 -0500
Message-Id: <20200204161951.764935-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We used to unconditionally commit the transaction at least 2 times and
then on the 3rd try check against pinned space to make sure committing
the transaction was worth the effort.  This is overkill, we know nobody
is going to steal our reservation, and if we can't make our reservation
with the pinned amount simply bail out.

This also cleans up the passing of bytes_needed to
may_commit_transaction, as that was the thing we added into place in
order to accomplish this behavior.  We no longer need it so remove that
mess.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Tested-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 8c5543328ec4..abd6f35d8fd0 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -412,32 +412,20 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
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
-	bool do_commit = false;
 
 	trans = (struct btrfs_trans_handle *)current->journal_info;
 	if (trans)
 		return -EAGAIN;
 
-	/*
-	 * If we are data and have passed in U64_MAX we just want to
-	 * unconditionally commit the transaction to match the previous data
-	 * flushing behavior.
-	 */
-	if ((space_info->flags & BTRFS_BLOCK_GROUP_DATA) &&
-	   bytes_needed == U64_MAX) {
-		do_commit = true;
-		goto check_pinned;
-	}
-
 	spin_lock(&space_info->lock);
 	cur_free_bytes = btrfs_space_info_used(space_info, true);
 	if (cur_free_bytes < space_info->total_bytes)
@@ -451,7 +439,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
+	bytes_needed = (ticket) ? ticket->bytes : 0;
 
 	if (bytes_needed > cur_free_bytes)
 		bytes_needed -= cur_free_bytes;
@@ -462,7 +450,6 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	if (!bytes_needed)
 		return 0;
 
-check_pinned:
 	trans = btrfs_join_transaction(fs_info->extent_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -472,8 +459,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	 * we have block groups that are going to be freed, allowing us to
 	 * possibly do a chunk allocation the next loop through.
 	 */
-	if (do_commit ||
-	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
 	    __percpu_counter_compare(&space_info->total_bytes_pinned,
 				     bytes_needed,
 				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
@@ -584,7 +570,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

