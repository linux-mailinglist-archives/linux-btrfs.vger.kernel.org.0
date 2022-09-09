Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556BE5B3911
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiIINfI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiIINfH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 09:35:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D133D857DA
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 06:35:04 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id cr9so1225261qtb.13
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=FBn2U9jWo2jaFJphHr+eiwdYYA5FOAGidiLl0GHP2CE=;
        b=RkjDAVDMsoBBGkRM44/GTFoF0Ik9wm7zntGtmAu9uubv8UP3H4iTs5JUu9CmJDlwqA
         +qz/kMX0T94quhWWVdk4Qlg4S0e5vzQQZyify1QtmDfhc/DW9zRVH82volcnm4Cgmswr
         CmijLKw9zo6wAijwDtdNy7p3VxFuXGidV3fKMxHy9sAKpm6LA55pEoinuNxegclMoN2L
         sR7NGy0xXvSAnrBjHm8X2y4NRKBSkQipu33iSAkIdSSP9bztwJLlldRcIE+ZmNoHyfqD
         8C1oj+aW2F/CKM/UpU0pZcaETNwLF+5fSl7vw/qoVl9D8QGD62iukMK3Q92xE6QaWX88
         heqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=FBn2U9jWo2jaFJphHr+eiwdYYA5FOAGidiLl0GHP2CE=;
        b=htkgAyPREwWyT6nAP8cCF+7fTbpf5koHHibZK/Oqz0V2hEiqg95icv+m/kFm2EzjHH
         6AurfVdIyMaaihdvpvJiTRm5dZqzl4bJgzpV2UEgpN/+PCkAZXASKrLMFmMPzzshqURR
         ROxNzpq3J0CcbG/0emWmRQAOcBKW9LtqBEEninoJ8y2tQ2DCSGF7vnMcXp57kqe4dk1H
         EmnQtOKVJWA+yvWtHLGQNlHrS9o7x7YauSsdg9bzA8rQFSGP1v+iei7RYSc+T454Yc6T
         fBHbZvL6Qe2hFWp1yKX75kv5BatahJ4S0nQXWyKPmLlp7a5fRGwKjFfgwkVtt6gJA8J9
         TeBg==
X-Gm-Message-State: ACgBeo3/XAgGvzyGTl5V1qu9fs1Ur/rOWJr8pdsVystoLs6w8pVj4eF0
        lzPyQWICdfa7LucG+VezX3yrpAOMweXYfg==
X-Google-Smtp-Source: AA6agR7DImDNo3IHdRLabFlg2BzjfKsGgK6/qhvH+QgdUxF4qKGKXHPDFzvh3JuvMDTrYfaMB9k7tg==
X-Received: by 2002:ac8:5a81:0:b0:342:fad3:b79e with SMTP id c1-20020ac85a81000000b00342fad3b79emr12602209qtc.77.1662730503025;
        Fri, 09 Sep 2022 06:35:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d11-20020ac847cb000000b003447c4f5aa5sm408735qtr.24.2022.09.09.06.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:35:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
Date:   Fri,  9 Sep 2022 09:35:01 -0400
Message-Id: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Inside of FB, as well as some user reports, we've had a consistent
problem of occasional ENOSPC transaction aborts.  Inside FB we were
seeing ~100-200 ENOSPC aborts per day in the fleet, which is a really
low occurrence rate given the size of our fleet, but it's not nothing.

There are two causes of this particular problem.

First is delayed allocation.  The reservation system for delalloc
assumes that contiguous dirty ranges will result in 1 file extent item.
However if there is memory pressure that results in fragmented writeout,
or there is fragmentation in the block groups, this won't necessarily be
true.  Consider the case where we do a single 256MiB write to a file and
then close it.  We will have 1 reservation for the inode update, the
reservations for the checksum updates, and 1 reservation for the file
extent item.  At some point later we decide to write this entire range
out, but we're so fragmented that we break this into 100 different file
extents.  Since we've already closed the file and are no longer writing
to it there's nothing to trigger a refill of the delalloc block rsv to
satisfy the 99 new file extent reservations we need.  At this point we
exhaust our delalloc reservation, and we begin to steal from the global
reserve.  If you have enough of these cases going in parallel you can
easily exhaust the global reserve, get an ENOSPC at
btrfs_alloc_tree_block() time, and then abort the transaction.

The other case is the delayed refs reserve.  The delayed refs reserve
updates its size based on outstanding delayed refs and dirty block
groups.  However we only refill this block reserve when returning
excess reservations and when we call btrfs_start_transaction(root, X).
We will reserve 2*X credits at transaction start time, and fill in X
into the delayed refs reserve to make sure it stays topped off.
Generally this works well, but clearly has downsides.  If we do a
particularly delayed ref heavy operation we may never catch up in our
reservations.  Additionally running delayed refs generates more delayed
refs, and at that point we may be committing the transaction and have no
way to trigger a refill of our delayed refs rsv.  Then a similar thing
occurs with the delalloc reserve.

Generally speaking we well over-reserve in all of our block rsvs.  If we
reserve 1 credit we're usually reserving around 264k of space, but we'll
often not use any of that reservation, or use a few blocks of that
reservation.  We can be reasonably sure that as long as you were able to
reserve space up front for your operation you'll be able to find space
on disk for that reservation.

So introduce a new flushing state, BTRFS_RESERVE_FLUSH_EMERGENCY.  This
gets used in the case that we've exhausted our reserve and the global
reserve.  It simply forces a reservation if we have enough actual space
on disk to make the reservation, which is almost always the case.  This
keeps us from hitting ENOSPC aborts in these odd occurrences where we've
not kept up with the delayed work.

Fixing this in a complete way is going to be relatively complicated and
time consuming.  This patch is what I discussed with Filipe earlier this
year, and what I put into our kernels inside FB.  With this patch we're
down to 1-2 ENOSPC aborts per week, which is a significant reduction.
This is a decent stop gap until we can work out a more wholistic
solution to these two corner cases.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c  | 12 ++++++++++++
 fs/btrfs/ctree.h      | 18 ++++++++++++++++++
 fs/btrfs/space-info.c | 27 ++++++++++++++++++++++++++-
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index ec96285357e0..89e3e7d1bff6 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -552,5 +552,17 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct btrfs_trans_handle *trans,
 		if (!ret)
 			return global_rsv;
 	}
+
+	/*
+	 * All hope is lost, but of course our reservations are overly
+	 * pessimistic, so instead of possibly having an ENOSPC abort here, try
+	 * one last time to force a reservation if there's enough actual space
+	 * on disk to make the reservation.
+	 */
+	ret = btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
+					   BTRFS_RESERVE_FLUSH_EMERGENCY);
+	if (!ret)
+		return block_rsv;
+
 	return ERR_PTR(ret);
 }
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0108585d838d..f221b3cb718d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2986,6 +2986,24 @@ enum btrfs_reserve_flush_enum {
 	 * Can be interrupted by a fatal signal.
 	 */
 	BTRFS_RESERVE_FLUSH_ALL_STEAL,
+
+	/*
+	 * This is for btrfs_use_block_rsv only.  We have exhausted our block
+	 * rsv and our global block rsv.  This can happen for things like
+	 * delalloc where we are overwriting a lot of extents with a single
+	 * extent and didn't reserve enough space.  Alternatively it can happen
+	 * with delalloc where we reserve 1 extents worth for a large extent but
+	 * fragmentation leads to multiple extents being created.  This will
+	 * give us the reservation in the case of
+	 *
+	 * if (num_bytes < (space_info->total_bytes -
+	 *		    btrfs_space_info_used(space_info, false))
+	 *
+	 * Which ignores bytes_may_use.  This is potentially dangerous, but our
+	 * reservation system is generally pessimistic so is able to absorb this
+	 * style of mistake.
+	 */
+	BTRFS_RESERVE_FLUSH_EMERGENCY,
 };
 
 enum btrfs_flush_state {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2e06b7c422c7..a0abc6dd01c2 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1583,6 +1583,16 @@ static inline bool can_steal(enum btrfs_reserve_flush_enum flush)
 		flush == BTRFS_RESERVE_FLUSH_EVICT);
 }
 
+/*
+ * NO_FLUSH and FLUSH_EMERGENCY don't want to create a ticket, they just want to
+ * fail as quickly as possible.
+ */
+static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
+{
+	return (flush != BTRFS_RESERVE_NO_FLUSH &&
+		flush != BTRFS_RESERVE_FLUSH_EMERGENCY);
+}
+
 /**
  * Try to reserve bytes from the block_rsv's space
  *
@@ -1644,6 +1654,21 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		ret = 0;
 	}
 
+	/*
+	 * Things are dire, we need to make a reservation so we don't abort.  We
+	 * will let this reservation go through as long as we have actual space
+	 * left to allocate for the block.
+	 */
+	if (ret && unlikely(flush == BTRFS_RESERVE_FLUSH_EMERGENCY)) {
+		used = btrfs_space_info_used(space_info, false);
+		if (used + orig_bytes <=
+		    writable_total_bytes(fs_info, space_info)) {
+			btrfs_space_info_update_bytes_may_use(fs_info, space_info,
+							      orig_bytes);
+			ret = 0;
+		}
+	}
+
 	/*
 	 * If we couldn't make a reservation then setup our reservation ticket
 	 * and kick the async worker if it's not already running.
@@ -1651,7 +1676,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	 * If we are a priority flusher then we just need to add our ticket to
 	 * the list and we will do our own flushing further down.
 	 */
-	if (ret && flush != BTRFS_RESERVE_NO_FLUSH) {
+	if (ret && can_ticket(flush)) {
 		ticket.bytes = orig_bytes;
 		ticket.error = 0;
 		space_info->reclaim_size += ticket.bytes;
-- 
2.26.3

