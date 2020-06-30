Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C904D20F68F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgF3N74 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387687AbgF3N7y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 09:59:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0348C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:54 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id r22so18575767qke.13
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U1ZK2JnWt4MssSxX5c4s0HVBW4N4hDnot5PGEAT5Zkw=;
        b=F7COuy9++EDhtt9FL4oZuKVrANNiBfHhODtKeGtH0wNqlbZPOxmj9/Wdx/3urDAcxi
         cZPE9k0bCJnS0t0W5XRPoO9DV6sgj+29w0CP5p5cpvjf4AUMrFkNGw66+CZUBM5J+Bls
         73JucgbxKW67v5rOgUY3+TKnpnR8Ja0LFv5xiLPrRzrHBsK5zsmLoXBLyhuxcvsO8BLW
         xgHJOWDJYJN103W2PlyyD8xjLOnogGoUENGa6z3yPtfRwJPYCFoHathrWNjgg5wfT2as
         kDykIutzk6kZax645Z0AvrgxV7IwyVxCBJWF+S6GEkqLF4DkFuIOJPfGgoFulDwp3qUG
         MvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U1ZK2JnWt4MssSxX5c4s0HVBW4N4hDnot5PGEAT5Zkw=;
        b=D8P8m4UMMwFMGUzYNi97VScfOamkDBSjHL1GQYllsqE1+xH8AOecUVALxMWcEUeVx8
         bDcS6WrP/qR8JfCT7QWRcAArAYYjt/0HyMRHI4+l34wjcNrX1hJEDqJ7sP0EswhBUCNs
         v+jfkffmWr4GK3NFfBtzhKM37pqhqStGHGxApzfpAZmeH7gJGqOmLeDxgO+FGhVQwVUl
         zggsqpAmVF/GhT2Bs/bNlBoPH4YIc/F7DPWlWNdDSfjuf9iZxJQWcPnYQ20N3gATRB9W
         L5Rz03CbJbKzm/+mE1LDrXJtFrXMbWmiXtazQSo+9DRO3OuzPfdgFziOx+1XjuSng3Zb
         5R0Q==
X-Gm-Message-State: AOAM532yzK7SUT8y69bh7qSTI8SEuxTYu7u3xBCa82PJyBffcaZabBnY
        7/w6U5HqFVyFXbNw+W4/hvYaoN+cEQy5yA==
X-Google-Smtp-Source: ABdhPJwVOc0HINCp3DC+l4gRmoaDdoElB190AAT6LNNgEuWh+pST/AJpaF2rv4WixK84vyBdqkgOjw==
X-Received: by 2002:ae9:ef83:: with SMTP id d125mr19947017qkg.287.1593525593466;
        Tue, 30 Jun 2020 06:59:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t35sm3118863qth.79.2020.06.30.06.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:59:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 13/23] btrfs: add the data transaction commit logic into may_commit_transaction
Date:   Tue, 30 Jun 2020 09:59:11 -0400
Message-Id: <20200630135921.745612-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index e041b1d58e28..fb63ddc31540 100644
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
@@ -743,7 +757,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

