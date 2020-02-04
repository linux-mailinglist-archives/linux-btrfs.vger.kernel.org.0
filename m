Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503A9151E33
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgBDQUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 11:20:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37929 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgBDQUe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 11:20:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so1399446qki.5
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 08:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZZ4EgH8AoElxwWctYt/b20P8kj0O4Miqc6Uu91NKviQ=;
        b=tmN61EVt0ieOGFIN2lcIvF+shHYox9hP88bFsJ42ugpVEk0+5sIx4Pcr9AZSt1lhRA
         Cio8r4+MxKuvyMtK8J1r7zeNZ/4H6YduiQuiTxre2823OEJ6PnPtZzWp8TTdzR+hSOmM
         TEjK9uZ/6+hxWfNNCV9s4NPa1ffvDOFgj8ZWYEPauMRFFgl5BWSkyVPUMYezwOtpyqp2
         ksu6JkZjyngOGb2irg5n/4O7aKcQ7llKpSnQonTFsPUKpuaSSuP3l43fvtzinMIS3sG8
         lFLD+nakTxpTAfUJQHH0xlYsRV+36yP1oLxl+IjFBtMdiBZMeCrA72wEEeXb30BX86JG
         W3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ4EgH8AoElxwWctYt/b20P8kj0O4Miqc6Uu91NKviQ=;
        b=BdQVfbCwj5Far6tjMcD1kMWI22+oLEF3YGDa7jKfFB5oeVui68vKw+6lksvsiiZmpL
         dI3xkN6/EBRczeIVGDXbbeM/nk228SlAJ1ebW/xBaaYEeVofUIZnxAcCuUoGBeshzojn
         H8RSDrLPdQHKORoTKgYAmOPgJoUnM1Dm5Wj+cnhU/qSNaR2W7nNRH17W2fQwtJZks4et
         9XqdltIsh2p+hTXPSEnbhrkE/+8BSNPQ78RSqUaIyE9Ufg3UoIgYX3o2cgHcNI/0W4H4
         j3V98cbVdJhpx9Eu9Aok2BvprpgrxfSiLk05scQVOEGarwjyz0v45tgZdXhg/nnTPCRO
         5YMg==
X-Gm-Message-State: APjAAAX1FjgV+lyCFfHwDFCj3EPRy9RTPOKGXjCs7Gu2vlP9CDDjHhhE
        LPqg5TRx7tMgvlfnoIOyCU2KaXyfluleLw==
X-Google-Smtp-Source: APXvYqwTPSlSWHFB6jAtz6r3a3wuZQsI+BOwh/5HVj7qyahX2LccQcJDRVvGqWYalfYsWQ24T7eAIw==
X-Received: by 2002:a37:6457:: with SMTP id y84mr5537947qkb.254.1580833231821;
        Tue, 04 Feb 2020 08:20:31 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id o187sm11479499qkf.26.2020.02.04.08.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 08:20:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 23/23] btrfs: add a comment explaining the data flush steps
Date:   Tue,  4 Feb 2020 11:19:51 -0500
Message-Id: <20200204161951.764935-24-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204161951.764935-1-josef@toxicpanda.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
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
index 18a31d96bbbd..56425674e940 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -780,6 +780,53 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
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

