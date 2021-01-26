Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3A3057DA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S314411AbhAZXHk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:07:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbhAZVZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:22 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DB5C0613D6
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:42 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id r77so17310461qka.12
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iW7DhuFJx0V8J8vOpBoVQWyxyUFyaiMjJ4pJfRHC7B4=;
        b=W1v3LPTSYSgK4t+TYgYFZMwZvPff0rJXNbDlfMPD7eUSruGUuZWXYWptUN+ZlhzQFP
         1mLG4LcXb5uVx2xwfddRTiPi5SQ+voQ0YvMgvQQ4CjRZIs+1eCwE4gNJZfBDqn90V4Q3
         9r4eSY5DutC38uHhBMamh7jjWHiyIcMF6hbiiMv3vilcHD+wlPsOTJPEvnwBY2onw8Y1
         tog8CLu98V6j4dcBPReiMbyxEWgB75GxXYT6VOncb2z3BDo+PQedV3gmqvnqdDaJoV23
         ZIa0AfvWBYIcEfD7N8tyKllxg2Feiu7AQVd3YUMVFCEoKFbeFh1VSPent8z6yLVIjFRi
         KM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iW7DhuFJx0V8J8vOpBoVQWyxyUFyaiMjJ4pJfRHC7B4=;
        b=Wldsz6oGz2sktMH0knV9eiXlTqie3vBVCcFtTV5Vxx/3qS/WiTpI60BAZC6fq2Qx5B
         aEtbfTylHDuhZCpyaeNwitT/AbE7PBTHJxMY6HcTz8UrVZZ9wDRqn0hdMMe6cgS/BShB
         7uP9shIY4DtD8K27Qyz9KmiyP96ekf727ZA7qENCM2MgYfxAuFGcKxBhaC+oJe2ND4XB
         4SkmzrQdUkqfiYKbqXk2/fvAjvoLfNjs1ifOohOjcw1d1eeEfSdtAnZpAgVDNo7bbjdv
         cqM4dC9amlCTm0L3Ku+449soZ/0lt/POESiEXFaHzo3pbMFE7oShEoLgG+YO5NUIraB/
         RZcA==
X-Gm-Message-State: AOAM530SAqpmLdUGamRmM8R2CQ7YaAyGnM8jnrbSRYCOVqEfqNV/yWMu
        G2LkzxG782/biG+kLzPgIfS4NN89nUxZ3KU5
X-Google-Smtp-Source: ABdhPJyGhi2py4oAMzjxDUR4EN3kMMzfbDFhXAMFOJ63FOk0qbv9vm2Lmgrn0udJsFZ28VFrb813Aw==
X-Received: by 2002:a05:620a:62b:: with SMTP id 11mr7595562qkv.229.1611696281526;
        Tue, 26 Jan 2021 13:24:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d3sm15076514qka.36.2021.01.26.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 02/12] btrfs: add a trace point for reserve tickets
Date:   Tue, 26 Jan 2021 16:24:26 -0500
Message-Id: <e31c93cf5e5e062ff1fd703f01746830436e8e72.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        | 12 +++++++++++-
 include/trace/events/btrfs.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 975bb109e8b9..af6ab30e36e7 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1220,6 +1220,8 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
  * @fs_info:    the filesystem
  * @space_info: space info for the reservation
  * @ticket:     ticket for the reservation
+ * @start_ns:	timestamp when the reservation started
+ * @orig_bytes:	amount of bytes originally reserved
  * @flush:      how much we can flush
  *
  * This does the work of figuring out how to flush for the ticket, waiting for
@@ -1228,6 +1230,7 @@ static void wait_reserve_ticket(struct btrfs_fs_info *fs_info,
 static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 				 struct btrfs_space_info *space_info,
 				 struct reserve_ticket *ticket,
+				 u64 start_ns, u64 orig_bytes,
 				 enum btrfs_reserve_flush_enum flush)
 {
 	int ret;
@@ -1283,6 +1286,8 @@ static int handle_reserve_ticket(struct btrfs_fs_info *fs_info,
 	 * space wasn't reserved at all).
 	 */
 	ASSERT(!(ticket->bytes == 0 && ticket->error));
+	trace_btrfs_reserve_ticket(fs_info, space_info->flags, orig_bytes,
+				   start_ns, flush, ticket->error);
 	return ret;
 }
 
@@ -1317,6 +1322,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 {
 	struct work_struct *async_work;
 	struct reserve_ticket ticket;
+	u64 start_ns = 0;
 	u64 used;
 	int ret = 0;
 	bool pending_tickets;
@@ -1369,6 +1375,9 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 		space_info->reclaim_size += ticket.bytes;
 		init_waitqueue_head(&ticket.wait);
 		ticket.steal = (flush == BTRFS_RESERVE_FLUSH_ALL_STEAL);
+		if (trace_btrfs_reserve_ticket_enabled())
+			start_ns = ktime_get_ns();
+
 		if (flush == BTRFS_RESERVE_FLUSH_ALL ||
 		    flush == BTRFS_RESERVE_FLUSH_ALL_STEAL ||
 		    flush == BTRFS_RESERVE_FLUSH_DATA) {
@@ -1405,7 +1414,8 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	if (!ret || flush == BTRFS_RESERVE_NO_FLUSH)
 		return ret;
 
-	return handle_reserve_ticket(fs_info, space_info, &ticket, flush);
+	return handle_reserve_ticket(fs_info, space_info, &ticket, start_ns,
+				     orig_bytes, flush);
 }
 
 /**
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index b9896fc06160..b0ea2a108be3 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2026,6 +2026,35 @@ TRACE_EVENT(btrfs_convert_extent_bit,
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

