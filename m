Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C1F20F6A1
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jun 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388515AbgF3OAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jun 2020 10:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388770AbgF3OAQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jun 2020 10:00:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9FC03E979
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:15 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q198so18639283qka.2
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jun 2020 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xHhyavkxTL8alcSYgeq4qkBfKvKJ2Z9T73hkmCD1E2U=;
        b=uwSQlrpdFZEwrENeLB+KSPz0ERVzjFsMM6F7o2b1wZlw+wr2ph9x2NASYd4wlnKCcw
         TWGOwIxsanEgWuRI5VsLYXSaW39Eh7mdwYdiS1kSQD9rYosS8Svs7uUhTRcGlseTUeFf
         GtJG36X/qmJICxU9lxv4UP5mFoqXjowuFXzNXX6HzxPmI3dnWpeXIu6CeIMx5vBH3xLH
         fOpVxKctcLKkUCOZVbCH/E7TSRgJ064BEWXIQlX0RPqFrHT2K25J19Hyr88MPIXmqtJe
         KzeM4klSSVzUZQ+WsuFNcn0mAkxh5nVm1r2937m6lQAeHSG5L10R6hPu9lF02/i2zObA
         L8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHhyavkxTL8alcSYgeq4qkBfKvKJ2Z9T73hkmCD1E2U=;
        b=j2RC3svGrhvCh7r5YdVlgUnmsQssu/KfQnN1z3t4xZ/H7yOUC7ttKVBQJDd5P83vat
         REa7v4MarbCJqJPfuci0mvyQSIMrt22bSED8FtYV5ocZX1CdtpN5T1FjmZC0C6p9b1ft
         zORY0KRt20JmnjyMl7N0CnwCPhT0By9hDz3+k8smRYxViSbCf/tHubPopBEzSMeRlRrs
         YH8aBwv7seF3tVB2q4MOoXRMled8IPNZC5HJyDNEEqqk6hFrTBhEfh0EAYXVYjhgHXM5
         AUMlmf3jiyxZC+bU/aNF5KJI8RjdxwgGNhW0pnam0deyA6dFOmAxhKopY466FYX0Zl6x
         hPUA==
X-Gm-Message-State: AOAM531CTMNh0qZOKMqQveScBfAKQzAjMbFAXQeJIXhD0yt5RRYVfskj
        4mv5D8Jzzp7i6c0BPp1k1HvrtJbPXSo54Q==
X-Google-Smtp-Source: ABdhPJwtzZ+ZAcOhtieMLVoS0MQ5ar3BmhYdUEhJEBxOqnDx0ESic0+ewHFefSU5XM7LLrK0x/CMlA==
X-Received: by 2002:a37:3d4:: with SMTP id 203mr18910194qkd.420.1593525614612;
        Tue, 30 Jun 2020 07:00:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h185sm3105057qkf.85.2020.06.30.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 07:00:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/23] btrfs: add a comment explaining the data flush steps
Date:   Tue, 30 Jun 2020 09:59:21 -0400
Message-Id: <20200630135921.745612-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200630135921.745612-1-josef@toxicpanda.com>
References: <20200630135921.745612-1-josef@toxicpanda.com>
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
index 0a2fdfaa9fe6..818f0a6caacd 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -996,6 +996,53 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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

