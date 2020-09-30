Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493A127F2DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730192AbgI3UB1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgI3UB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77585C0613D0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s131so2830068qke.0
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=a9UMpjwI4HuIx3RvUsop419NZCAPJSancsKhYDDGXQs=;
        b=gTAiiukRS+Z23QeqKeR+Rb9HWolOyqe53F+XXcXy4dsyUxQQEnxsxhdnqb6DpN+pYQ
         dCImM7/JbDXIZFm49ZWH2R87jhcIWoUMxUCajP0TqkK0keU0yZM90mv4QRexhOEN3l/t
         w+NpYPg7ZA8ri+8mC4Ts5+jduXXfiITpr0Kbn890mPl8iPJMp7zWOvyRQc0rFQ1CUalA
         e+gWhqC4zwAsPv8kQFAfQ8sEnXXiZ2GcfTWBKuFfVHnvsvm64S3lK5KtMIOyhEHqcmpc
         iZ8X4o6iD+PGKbS1cCzCpVrUGD5XXYxBIZjSPgLIrxhPOYBNIm6ZteqWumeyAAuJSDvm
         86fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9UMpjwI4HuIx3RvUsop419NZCAPJSancsKhYDDGXQs=;
        b=hKe3I6R3YXozSBqCLPnJDhUgQVNU0Ke0N/cAjoaRgvx9knymmTRGglzDjBKBEjUEnd
         caO7jLZbYmV/guj6FckpU6qZtNwgOceRqdrtweze/eOiDyD3L1f8NWkPi4fIxkhju1og
         jvZVUzDlXNceMlfPHxmnd7fgrxEIBLH3HFUh6doBldk0S+mPLbkS6qHIyyiRiMRhyiIJ
         Rkns1VSNn3vVnliKf5rx13w2+wnZyPgq4NA1WuoMWpy9Xrkuiwyre7klWxjXyijhB1IM
         k4QPSc3xD7E6iXije7esUp+d6dQbS4pYJfpnjurYWw0FvUO2L/6IsHVvcP+ZHKjEvChl
         hq8g==
X-Gm-Message-State: AOAM530x/OWfu13lLUxT7dk4lEE75fAYTc6vVL/4sObUPqeSL4CuxChO
        aNwvuj3uinpeBIQmYsdj6GhfHhDTqHfoR5++
X-Google-Smtp-Source: ABdhPJzOQUMgAh0iGwzDW7gHMnPkw8nsR+rhpx9dHdXqOH309EM5VaiNsCJTu8vAG50K4Jwfd2FEMQ==
X-Received: by 2002:a37:b8c2:: with SMTP id i185mr4186114qkf.87.1601496084136;
        Wed, 30 Sep 2020 13:01:24 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u23sm3619918qka.43.2020.09.30.13.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/9] btrfs: add a trace point for reserve tickets
Date:   Wed, 30 Sep 2020 16:01:01 -0400
Message-Id: <35017faea237f88452785b208e4fe36002b46fc9.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging a ENOSPC related performance problem I needed to see the
time difference between start and end of a reserve ticket, so add a
tracepoint where we add the ticket, and where we end the ticket.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        |  3 +++
 include/trace/events/btrfs.h | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 64099565ab8f..40726c8888f7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1279,6 +1279,7 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	 * space wasn't reserved at all).
 	 */
 	ASSERT(!(ticket->bytes == 0 && ticket->error));
+	trace_btrfs_end_reserve_ticket(fs_info, ticket->error);
 	return ret;
 }
 
@@ -1380,6 +1381,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 			list_add_tail(&ticket.list,
 				      &space_info->priority_tickets);
 		}
+		trace_btrfs_add_reserve_ticket(fs_info, space_info->flags,
+					       flush, orig_bytes);
 	} else if (!ret && space_info->flags & BTRFS_BLOCK_GROUP_METADATA) {
 		used += orig_bytes;
 		/*
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ecd24c719de4..68d1622623c7 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2025,6 +2025,46 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
 
+TRACE_EVENT(btrfs_add_reserve_ticket,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, int flush,
+		 u64 bytes),
+
+	TP_ARGS(fs_info, flags, flush, bytes),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	flags	)
+		__field(	int,	flush	)
+		__field(	u64,	bytes	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->flags	= flags;
+		__entry->flush	= flush;
+		__entry->bytes	= bytes;
+	),
+
+	TP_printk_btrfs("flags=%s flush=%s bytes=%llu",
+			__print_symbolic(__entry->flush, FLUSH_ACTIONS),
+			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
+			__entry->bytes)
+);
+
+TRACE_EVENT(btrfs_end_reserve_ticket,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, int error),
+
+	TP_ARGS(fs_info, error),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	int,	error	)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->error	= error;
+	),
+
+	TP_printk_btrfs("error=%d", __entry->error)
+);
+
 DECLARE_EVENT_CLASS(btrfs_sleep_tree_lock,
 	TP_PROTO(const struct extent_buffer *eb, u64 start_ns),
 
-- 
2.26.2

