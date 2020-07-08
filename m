Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519AF2189BA
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jul 2020 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbgGHOBH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jul 2020 10:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgGHOBH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jul 2020 10:01:07 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1285C061A0B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jul 2020 07:01:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id di5so15546468qvb.11
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jul 2020 07:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=453v9VzQmoK5i/nqibBwzH7YHdJp2eB/54xxH6Xi1B8=;
        b=gX4fb3wXzNkwkyhXjnt/yWfDUws9AfhEVY3PvZybJ5xLBziW14TZURkzqmRae9oAdj
         RtUc15uDvdBE+831QfrGhAhd2/F0aR24HoHqyJPOaJnDabJ2mBxGOJywSfkgtAMqRWIo
         sp8eWl0iNmBuIv/hPEGfxg8GVJv1Y5wFXdiPr49Nw2BPg/KgSSIRCpcw+apBNpbYO1es
         LSUhM6VykKlnve9KcnljAS5ReT5KBDLwn/FFIeQL8vKI2/BPFFfM3MWr0Bw16rM0T0Dr
         wxmRvQoezt7n+2M94KrSD+ztsKQm4j4yWkGicHPe92OCRA5pMnrBppBDsmJD5C7z3BtY
         Fpvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=453v9VzQmoK5i/nqibBwzH7YHdJp2eB/54xxH6Xi1B8=;
        b=rjljbqG/bJSrZn0SNFR5W4uv5ac8y0F5CF7gr3upBpKs8VVQcwjGlG2RBcxj3YDr9y
         sgYgnowIW7tsZ5jtG9CvmyHEtk9ghJsMh6L2pSHzI+XfoUoorfNL+qoiTy7s8dBXWlrQ
         qt7mvpBRWtNi9Kd//eRH90vM97VD9LmZZnWyI41w4M2VtnOE9bgKoJtevn623Idg5Zpr
         MmzonEVJGAXaeeVWgAVOtk2NobcLWL2yLfrVIklqHW6KtoaXPUkvz/hVbIIL2YG9ZXDb
         OFcBZinr8bcU3ZyElhf11ipGCWICXPFu4eD3lXKwLx5R24DQ0UGvB3UE0pPaqSf46gN0
         PWFQ==
X-Gm-Message-State: AOAM533+NUhfs+uu14PJNhKiCAN/OP8v3SiJR4rSakKLoXOJT3QBHqeo
        fsGsLyLpjeX/ScmCAQ5i0xWT6v05oXI7aw==
X-Google-Smtp-Source: ABdhPJxHmIDxhirbr5MGH60Q6/Dui+B4IfTefnxShB8zpmktIp15JcxEM8t7GfB4PzL7oYX2mORzlA==
X-Received: by 2002:ad4:504a:: with SMTP id m10mr45148897qvq.172.1594216865494;
        Wed, 08 Jul 2020 07:01:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t9sm28151467qke.68.2020.07.08.07.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 07:01:04 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/23] btrfs: add a comment explaining the data flush steps
Date:   Wed,  8 Jul 2020 10:00:13 -0400
Message-Id: <20200708140013.56994-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200708140013.56994-1-josef@toxicpanda.com>
References: <20200708140013.56994-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The data flushing steps are not obvious to people other than myself and
Chris.  Write a giant comment explaining the reasoning behind each flush
step for data as well as why it is in that particular order.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 47 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 680218a7b0e5..ba2bb47cbb18 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -998,6 +998,53 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 	} while (flush_state <= COMMIT_TRANS);
 }
 
+/*
+ * FLUSH_DELALLOC_WAIT:
+ *   Space is free'd from flushing delalloc in one of two ways.
+ *
+ *   1) compression is on and we allocate less space than we reserved.
+ *   2) We are overwriting existing space.
+ *
+ *   For #1 that extra space is reclaimed as soon as the delalloc pages are
+ *   cow'ed, by way of btrfs_add_reserved_bytes() which adds the actual extent
+ *   length to ->bytes_reserved, and subtracts the reserved space from
+ *   ->bytes_may_use.
+ *
+ *   For #2 this is trickier.  Once the ordered extent runs we will drop the
+ *   extent in the range we are overwriting, which creates a delayed ref for
+ *   that freed extent.  This however is not reclaimed until the transaction
+ *   commits, thus the next stages.
+ *
+ * RUN_DELAYED_IPUTS
+ *   If we are freeing inodes, we want to make sure all delayed iputs have
+ *   completed, because they could have been on an inode with i_nlink == 0, and
+ *   thus have been trunated and free'd up space.  But again this space is not
+ *   immediately re-usable, it comes in the form of a delayed ref, which must be
+ *   run and then the transaction must be committed.
+ *
+ * FLUSH_DELAYED_REFS
+ *   The above two cases generate delayed refs that will affect
+ *   ->total_bytes_pinned.  However this counter can be inconsistent with
+ *   reality if there are outstanding delayed refs.  This is because we adjust
+ *   the counter based soley on the current set of delayed refs and disregard
+ *   any on-disk state which might include more refs.  So for example, if we
+ *   have an extent with 2 references, but we only drop 1, we'll see that there
+ *   is a negative delayed ref count for the extent and assume that the space
+ *   will be free'd, and thus increase ->total_bytes_pinned.
+ *
+ *   Running the delayed refs gives us the actual real view of what will be
+ *   freed at the transaction commit time.  This stage will not actually free
+ *   space for us, it just makes sure that may_commit_transaction() has all of
+ *   the information it needs to make the right decision.
+ *
+ * COMMIT_TRANS
+ *   This is where we reclaim all of the pinned space generated by the previous
+ *   two stages.  We will not commit the transaction if we don't think we're
+ *   likely to satisfy our request, which means if our current free space +
+ *   total_bytes_pinned < reservation we will not commit.  This is why the
+ *   previous states are actually important, to make sure we know for sure
+ *   whether committing the transaction will allow us to make progress.
+ */
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
-- 
2.24.1

