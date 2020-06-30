Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C42520F69C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbgF3OAK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgF3OAI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:08 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8092C061755
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z2so15613680qts.5
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUVfzbZ8KXMiSzGE2ItvCM3pO93EvG2UsX28ywarkAg=;
        b=xTFD3PGdwva5ucXyvT5NLhs6s3c5VgIoW1KdccfMQwf0wdZR1JlCsbCP/tNAm589aC
         cEaYSESwKy9VrypwVZJPCh9QSv529hKLPaNyaCp8uHh+EZy7LqwJTwvfvh4Ko0ymGXOP
         vU2KpPwsP42tdOOTIHhxYqlJ2Vk5evU4KZlZU0fHauWDCSRcT5KZVHZriDGK1lVqWMob
         629+uoqWCIKYjyYDg+njUEpe7l2IdfMOAa+OTI10aP2zmfYq0rStWruhFEgSmiKGENEc
         ff30YdhzEBr/X8IMPqZXYQcp9e6BV6RuPaXvqrSJ4MF/K1+AKCpe9DIpQ47fPC6UhvaS
         zaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SUVfzbZ8KXMiSzGE2ItvCM3pO93EvG2UsX28ywarkAg=;
        b=NPdkp1fvtSCBMr5qP/A7a/IxHrb+iitNyykoN7Pn0HjC5kU49XPAJhBCwvL/DTu+QZ
         8WtE5GdEmBrnedREky4tmAOyOamFib80AB28q4zbWZzSL4rXl1Fk+A6EQkeUt/tIdiLY
         yW1IIhqvQZfPEqQtmqTPpVuh5K7Ec4AFgz2ClbUWRx+XegJ2l3Xn7psSZhJyup/aA1qW
         CtF/6Qfgw1kOj8BZxKwSb4JQmHvj186v5ohZ7aJ+FLmZgUGrk2Ov55U/1lNRskGcw2CX
         RimfndbK7YmrJ4fEH60u4IBxpEdcLLg1BjH8B8woXM+TTOjNW4asDamtTZV6H0COyzwg
         eogA==
X-Gm-Message-State: AOAM530CeGrSBi8/oDTHk6zRU3v4VpY+7rR2igr4oEOg+Z38C3RbTJ8m
        bn4YUHM2LpR1o7rVo3HDlQ4rd+VDKc71kQ==
X-Google-Smtp-Source: ABdhPJx6yhOIO0mLBEJ7Oh+aZ9I/7lJ1eQJFjwFLEU+ds4bdD1sUHr6yCUesRq1pFYFZ5mFjPR8kjg==
X-Received: by 2002:ac8:458b:: with SMTP id l11mr21316753qtn.111.1593525605818;
        Tue, 30 Jun 2020 07:00:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o12sm2877055qtl.48.2020.06.30.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 19/23] btrfs: don't force commit if we are data
Date:   Tue, 30 Jun 2020 09:59:17 -0400
Message-Id: <20200630135921.745612-20-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index c88a31210b9a..490dab7779e8 100644
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
@@ -757,7 +743,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
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

