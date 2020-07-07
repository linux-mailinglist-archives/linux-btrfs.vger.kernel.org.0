Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082042172BE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgGGPn2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPn1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:27 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E417C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:27 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h18so19017604qvl.3
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zlHWUUd+eF/vwrtsTrHXFQe7nd+UYBasDoIwJfuWDlw=;
        b=CsAeHVMImhm2IVUfHkxxfh5pJLKoJq8cRpc0fiySnfXdnYow9KBCLRqTtsZHuldopT
         8ZkdDG5urptTV4a6LXrvy0KLaFxBz1Crm91SwJUl3kNFN/4aHCWVU5TTnAoD316kkXeJ
         nGkl89IVjjK7LAtL3Yb/gYmHx47N8Q5lb0ODMd57qHX5+nW7wy+I4Iz9VFDC+EQ/Ab7q
         Rblw2FT+Y8BQ7YbLOIKgbzFpw2vH2OTcMkppFlEHB7yM2/4TF76RK8awB/bizCTgKr/p
         R3Vub/nyb9S3mL0IRIgxuEMgHlBs89tFXdQCnWkwExzKjC/w3/K/iSfDRivgpSE6RfNW
         1+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zlHWUUd+eF/vwrtsTrHXFQe7nd+UYBasDoIwJfuWDlw=;
        b=ij2ohLC/QRTDmSXurbiwbPvMRkpzNywKHq//UssJEf0LAyFndd0gdnnjIwmlvacSa3
         IVK267YUdF+Sk6O+5+4g9bxhuXdRbLOwEcqBvCLcQcMuiQeGB0742U/XI/LPoThsirkV
         bAamP5yhnu2LN+0GVIPx4zEQkriwiv+y/pH8cG+lKMgadOb5Fg6J8qzg+0GEiVKCYxwR
         OpLQz14YmfGUDcWeyblIPePklvaNyowzauWL97bKfUHZG1gFD8a1xTmJFP3IZUTs8iMH
         tCQ42RuiJfDEufTxsqmXRxeTbsgQFpv/JMSNBEGOUBxviPgaTJYaWK1CmCa7JT3BbpLs
         Ahcw==
X-Gm-Message-State: AOAM532g/XYbshIO/wqidy24zx9q7V6GHqdAUIXz1yGh3UFCVS4JqVSb
        tVuU7wEbS0w7fTGcq85qWhG1Q+lvJ7ww9w==
X-Google-Smtp-Source: ABdhPJy1extF9AAPx9+kLFDZmHsUo6vIFax3fouLGwUNhGls70xneGbAF71hEaNjNYM9wPy61e2CRw==
X-Received: by 2002:a0c:f214:: with SMTP id h20mr51611381qvk.131.1594136606434;
        Tue, 07 Jul 2020 08:43:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h16sm22303850qkl.96.2020.07.07.08.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 19/23] btrfs: don't force commit if we are data
Date:   Tue,  7 Jul 2020 11:42:42 -0400
Message-Id: <20200707154246.52844-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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
index 59d0ad1736e8..8df0110bd97a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -579,8 +579,7 @@ static void shrink_delalloc(struct btrfs_fs_info *fs_info,
  * will return -ENOSPC.
  */
 static int may_commit_transaction(struct btrfs_fs_info *fs_info,
-				  struct btrfs_space_info *space_info,
-				  u64 bytes_needed)
+				  struct btrfs_space_info *space_info)
 {
 	struct reserve_ticket *ticket = NULL;
 	struct btrfs_block_rsv *delayed_rsv = &fs_info->delayed_block_rsv;
@@ -588,24 +587,13 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_rsv *trans_rsv = &fs_info->trans_block_rsv;
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
@@ -619,7 +607,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	else if (!list_empty(&space_info->tickets))
 		ticket = list_first_entry(&space_info->tickets,
 					  struct reserve_ticket, list);
-	bytes_needed = (ticket) ? ticket->bytes : bytes_needed;
+	bytes_needed = (ticket) ? ticket->bytes : 0;
 
 	if (bytes_needed > cur_free_bytes)
 		bytes_needed -= cur_free_bytes;
@@ -630,7 +618,6 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	if (!bytes_needed)
 		return 0;
 
-check_pinned:
 	trans = btrfs_join_transaction(fs_info->extent_root);
 	if (IS_ERR(trans))
 		return PTR_ERR(trans);
@@ -640,8 +627,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
 	 * we have block groups that are going to be freed, allowing us to
 	 * possibly do a chunk allocation the next loop through.
 	 */
-	if (do_commit ||
-	    test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
+	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &trans->transaction->flags) ||
 	    __percpu_counter_compare(&space_info->total_bytes_pinned,
 				     bytes_needed,
 				     BTRFS_TOTAL_BYTES_PINNED_BATCH) >= 0)
@@ -759,7 +745,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

