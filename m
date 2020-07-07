Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C99542172C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Jul 2020 17:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgGGPnf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Jul 2020 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgGGPne (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Jul 2020 11:43:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE07C061755
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Jul 2020 08:43:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c139so38488270qkg.12
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Jul 2020 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K7w32C9kwC8lzUHZISfRCie38Nyemq4QdTj1Gte1J8M=;
        b=Rm1BDpDmvVnUvbwEKDKw4qwxQqwpHK7Pe+zhgUpR7zVvdZ+OSR2e9sjpsTFzx02pas
         hsvNX2yYircw5tVQXxJCSsSkWmkDKtc+hDZacPJyeGN3mp20RGdOCYW78OXxumEAn/RJ
         45c1V0hP/8LtS5bOHCSZ26g5MFkSS2cXSQFQ3d18OA6vB5Ql53PHTuU1AROBOXmKxwqK
         5pqQSvnVNHYr19w2G+KSQ88wQ+W0+BMfNvZrVXUJamBJgnZih8Q0d1GrQiQeJu46JYy4
         OE9rG4m+78lqrvhYVH5genn/BIvjZ5oLcpBkq/QB0y5j1ru3Kt9A4XEqneQjZJHR9QrY
         LhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7w32C9kwC8lzUHZISfRCie38Nyemq4QdTj1Gte1J8M=;
        b=MvaHfYriz2Jn7bRv/xgtrMjZlAfR/O9whr7v3y15NOCkesJHAZDI90oNSKSl0NwKcb
         WvJ0OB9dvgSAz1TGgASIHodZ6ZfZSpKCimMrjgbJs6jvc1hv7bk0L+SIG71WPk3GjcbM
         HrROOlPJyn3IB3zztZE0se+sOvl7DD1IM1bXXl5QvNsQw5keaqYNrM0PY2hTz5MdWuF3
         mblez7C0l0b1jSkQr1s/3odhJ+gxKDJXn0BAc2HTWfjd+Xmdv8YltLAl99vc/sKhl3XA
         Z+fjssmmKTzFx63hurygl77dIKK+agXLZJonICJzmsv/kIp+8QfKdA8kYs3d7U45Z0uo
         n/cw==
X-Gm-Message-State: AOAM5305mn6KIhQhQdsZwxSc6JsxV+vi/wlEov8xM636QSgnxPx6wCs0
        doeTh0Tl53BNuMD6VgLTeRObQnpXeIoPbw==
X-Google-Smtp-Source: ABdhPJzJbt4+1bE2ixy54tcUtjSUk/nOQAjFYKreDNCqwB/as+OiZJqf+3BTStvZjMKyMX/zljFwuw==
X-Received: by 2002:a37:a4d0:: with SMTP id n199mr35672090qke.476.1594136613486;
        Tue, 07 Jul 2020 08:43:33 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 73sm24809116qkk.38.2020.07.07.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:43:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/23] btrfs: add a comment explaining the data flush steps
Date:   Tue,  7 Jul 2020 11:42:46 -0400
Message-Id: <20200707154246.52844-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200707154246.52844-1-josef@toxicpanda.com>
References: <20200707154246.52844-1-josef@toxicpanda.com>
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
index bc99864c30d9..7fa7f580b4cc 100644
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

