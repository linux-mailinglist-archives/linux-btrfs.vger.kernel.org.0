Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8454C2189B6
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgGHOA7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGHOA6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:00:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD800C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:00:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e11so41615775qkm.3
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JvyDgN6grpnYsv6EV70BSXlJ3Z3zZRzxM5sfFDQKHac=;
        b=17zYMwTnSdK+orznCF1jojxVmUebaK7FyWO6Vl9k5zVK96o5OArnGNS8ifYvesNSSq
         /jsO9NUQPd3qgmURC1FN0zPGt0/WS1IY92BjSacEhjmRVeGVu3yphJ5hQwMln1HO+b3S
         6sXCKVehWQDs67ueHjtbMMGBhe9muFFwoBjj0S1rB6Mgv2lNKnFyoGgSSxx8CbjBhb2p
         PfaFBi3J7Tz0TlL0Vi4TBgh6l8h315TLLrAc5IH3duyCk+URAndhfWLTF3ZfKzKKSK74
         vkidBjGhqytYqFbbVtxm9ae3aQswMFxYwPUioJLUXtuLn0mkPSM0w67/1HqjVATB4KO1
         2yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JvyDgN6grpnYsv6EV70BSXlJ3Z3zZRzxM5sfFDQKHac=;
        b=ZeDccOW2CZqj61IP1tbcDIxTRQH+Jz0457XLjy7/Hng23su335B85XRMzPQXdPiJRI
         67UwG0d8F9Nnj0tyiGX3Ki0+4wkQrI9demwBiLTirTawAJIGxokJcA24U4KDghs9+H/m
         UdLvxxpWEtgb2APADFiIltd1zTdY3H2jlt6p92YBoTOa+1nZMk1zB//mHUS4bERJlM6E
         k79emupTzYOb8JjJ/tUcoOkl6hzhD8FfUAqtIubs946sU9i2nX4El2ewwO5gtYJTpGu2
         rRn9o3UeF7EehRJVT7HWDISEMLmTPQOwxzzpYjIuy4j6g1D5daDUKkGKYGQVVDbjDnj3
         kXhw==
X-Gm-Message-State: AOAM530Jqn6w6jlHvIUGgaPauB8YO7nceRnUPO84y3HBR3QmxOWpe0vi
        D9CWF/RG+s7k1Y/ZUnKhZ6rocOrSTDP9Xg==
X-Google-Smtp-Source: ABdhPJz36cwYVGlff7zZEp/3YrXAizIAa2nCaWZn4wHmzIRbX3hVDNo5/pVvpO2X5h28Na6y3Us+SA==
X-Received: by 2002:a05:620a:992:: with SMTP id x18mr55593945qkx.273.1594216857537;
        Wed, 08 Jul 2020 07:00:57 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m26sm30020897qtc.83.2020.07.08.07.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:00:56 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 19/23] btrfs: don't force commit if we are data
Date:   Wed,  8 Jul 2020 10:00:09 -0400
Message-Id: <20200708140013.56994-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
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
index 5efb3eb9253d..5b46835766e3 100644
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

