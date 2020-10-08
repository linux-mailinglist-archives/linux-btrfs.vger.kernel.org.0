Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42715287D6D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgJHUtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJHUtA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC0C0613D3
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:00 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id db4so3773425qvb.4
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U/O2Yi709tlVgsdsaEGe/gcGutS1xQQwBM7+WexgcZM=;
        b=Ab3KVyJWlucI/0teAQWYIr8MxdqmQACuAQYpSOA6fNJG92lg5zJC9/UAftmyCd6XnO
         b727a7+zp2B/UUJevVO9//wq5L1VavYs5o84QlcAMpI95jiRGIU/vF5K4R58cKx5iJaU
         pZl5p2u4PpdGCxDlVv7mTyGCnibsD8uRwCxDyEtCjuRTubJ8k9pCY63HWeZu9eW0x6PA
         IJJo+rd0Cq84kvmLn1OaWH+rog+DFzmAr69jNjDP/dzyl7D/Zisn0VOdHJQoY7d97Xe2
         cBo6A6j2+8J0BL/LWNlE1q5pgsP2CXCW3HuZhIu4K9jDLZ5uSIPHUR/wzD2mFziH26YY
         GKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/O2Yi709tlVgsdsaEGe/gcGutS1xQQwBM7+WexgcZM=;
        b=NOgOKCkodcphsDHw8KEdRPMYuClqd9SX8o4LGwRUZ0YXKC8XDtj+qh0CbW1x4ZBfEZ
         LZKcfAav4G1rYRsUROuC1tQVWYyV8M56cNXktwKjvWNNycXRZJFhBvUmqOvSgf4G535R
         Ps4pXwu4BfCnMtSxmyx9nujjswTc+S/xItU+NUi7AkEB/hifgO2ESueho3DaR32DMJ88
         kWmqBxLG1jCa7WzXKDIOhyObZC981oUk4CeBdxvoz+AU7lbpk5As2q1ipFjFLvS3Jz1L
         is8eW3HMI4nzl+Ld2VDETp8Hqaxf8AfDPbsmtO8t28WFDZQXPnpu8I0STmRzsdr4kqOq
         GEdQ==
X-Gm-Message-State: AOAM530J0393/kMTfLs1gML5ACFY7jN4hMd/jMWwrE4GK8q7j62uAZ6U
        gd+YG21U8Mu4MqqShGz1WqZsyaPzszozJ2bp
X-Google-Smtp-Source: ABdhPJzI+NCRkf8OZ5IAC6fbQWKCL4TWSD3eAUWJ34OcOTrN8gkhE/PKzOBAjBTPjL0KtjK1+KGNcQ==
X-Received: by 2002:a0c:a89a:: with SMTP id x26mr10160244qva.36.1602190139089;
        Thu, 08 Oct 2020 13:48:59 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d129sm4827266qkg.127.2020.10.08.13.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:48:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 01/11] btrfs: add a trace point for reserve tickets
Date:   Thu,  8 Oct 2020 16:48:45 -0400
Message-Id: <2c9e83b67b44db093fd8d854f484e478bc2abef6.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While debugging a ENOSPC related performance problem I needed to see the
time difference between start and end of a reserve ticket, so add a
trace point to report when we handle a reserve ticket.

I opted to spit out start_ns itself without calculating the difference
because there could be a gap between enabling the tracpoint and setting
start_ns.  Doing it this way allows us to filter on 0 start_ns so we
don't get bogus entries, and we can easily calculate the time difference
with bpftrace or something else.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        | 10 +++++++++-
 include/trace/events/btrfs.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 64099565ab8f..f1a525251c2a 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1224,6 +1224,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 				 struct btrfs_space_info *space_info,
 				 struct reserve_ticket *ticket,
+				 u64 start_ns, u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush)
 {
 	int ret;
@@ -1279,6 +1280,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	 * space wasn't reserved at all).
 	 */
 	ASSERT(!(ticket->bytes == 0 && ticket->error));
+	trace_btrfs_reserve_ticket(fs_info, space_info->flags, orig_bytes,
+				   start_ns, flush, ticket->error);
 	return ret;
 }
 
@@ -1312,6 +1315,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 {
 	struct work_struct *async_work;
 	struct reserve_ticket ticket;
+	u64 start_ns = 0;
 	u64 used;
 	int ret = 0;
 	bool pending_tickets;
@@ -1364,6 +1368,9 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		if (trace_btrfs_reserve_ticket_enabled())
+			start_ns = ktime_get_ns();
+
 		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
 		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
 		    flush == BTRFS_RESERVE_FLUSH_DATA) {
@@ -1400,7 +1407,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
 		return ret;
 
-	return handle_reserve_ticket(fs_info, space_info, &ticket, flush);
+	return handle_reserve_ticket(fs_info, space_info, &ticket, start_ns,
+				     orig_bytes, flush);
 }
 
 /**
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index ecd24c719de4..eb348656839f 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2025,6 +2025,35 @@ TRACE_EVENT(btrfs_convert_extent_bit,
 		  __print_flags(__entry->clear_bits, "|", EXTENT_FLAGS))
 );
 
+TRACE_EVENT(btrfs_reserve_ticket,
+	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 bytes,
+		 u64 start_ns, int flush, int error),
+
+	TP_ARGS(fs_info, flags, bytes, start_ns, flush, error),
+
+	TP_STRUCT__entry_btrfs(
+		__field(	u64,	flags		)
+		__field(	u64,	bytes		)
+		__field(	u64,	start_ns	)
+		__field(	int,	flush		)
+		__field(	int,	error		)
+	),
+
+	TP_fast_assign_btrfs(fs_info,
+		__entry->flags		= flags;
+		__entry->bytes		= bytes;
+		__entry->start_ns	= start_ns;
+		__entry->flush		= flush;
+		__entry->error		= error;
+	),
+
+	TP_printk_btrfs("flags=%s bytes=%llu start_ns=%llu flush=%s error=%d",
+			__print_flags(__entry->flags, "|", BTRFS_GROUP_FLAGS),
+			__entry->bytes, __entry->start_ns,
+			__print_symbolic(__entry->flush, FLUSH_ACTIONS),
+			__entry->error)
+);
+
 DECLARE_EVENT_CLASS(btrfs_sleep_tree_lock,
 	TP_PROTO(const struct extent_buffer *eb, u64 start_ns),
 
-- 
2.26.2

