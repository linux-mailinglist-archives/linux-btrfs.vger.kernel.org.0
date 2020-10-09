Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A8E2889C3
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbgJIN2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbgJIN2h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:37 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE021C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:36 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id 13so4721856qvc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/x3pvpis+2ALXcFAR7IF+wTWcLA0xu88xOUJr8tb810=;
        b=WcYrZmipXhK3Q195G7CL3/nHfJ3bOyNPd+8+runNJ+BBcTWucdKCIMYYPlGeyzZA28
         e3Z+yp2cJVvM03rxB8Q2SJYsccNPUJvhzXxwzzSnaylDa1T0FxEdFg9YFTIhL5IbYXDi
         k0U72gJTa6H/k+qo6ANORgYyMqkJJhq0eTf8z088Hq3IfJf2P9syPwKUIpt9yCiie53I
         54mPc4b130d3W+6+LSA1NyYO5xzjmIdPvhcg6Ywq5Iw9upsFlp/4cX6d0MW4HE0uspcG
         olHQYeZn65hxIflxrhE4Jn5EzA9hXxIdwkya1c5r73Gm+MJNNmOtN0edLuT4dKwQzHne
         u1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/x3pvpis+2ALXcFAR7IF+wTWcLA0xu88xOUJr8tb810=;
        b=PcxEWPiDwRJxo4a2Kf7qDb2CtyXkUvNeeiro5gBUAnckhRAegEDjcKrBM/ZWZ+lDtJ
         RxiA/yyDSvQTs9CjqUT4FMS3dhiw32qHt29oehz+Z4QpTJplefUwAUMzc/BwRDyNdoay
         R70MTysAIRzPSemKy9IriSReuTLc2zSyJjUEnN6s5JM/AAQpdGylOcMSuaoaMcPfPs0X
         RwgwbslCti+lGy5vq/IZNlU6PsBNB3fbUCsD11lgKOllsDi/Tx2k2MELLuSn6CTwwpN+
         QXhyPocLuPn7yIfQyPf1mT0RxprwGBZNIzLFy6hWMdGK+0UZ7Yc1lP2jYOm1dCyCXbZs
         BXqw==
X-Gm-Message-State: AOAM531fQffllgSlQDXxrxIE4xEZ1d85HZ8IwaS4aU4RW9ykgWxEMgxK
        nLl4TVetfmkTcmAj3bkquaJyBUS4+TLKjceq
X-Google-Smtp-Source: ABdhPJzyS7jrQITJAYj7tiENwM3a63pMKupwWQ4iBtucknPKt86CUJCv/Z3ylRjxgcmmMWNJf7yRgw==
X-Received: by 2002:a0c:a945:: with SMTP id z5mr12547087qva.55.1602250115451;
        Fri, 09 Oct 2020 06:28:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t3sm6160286qtq.24.2020.10.09.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 02/12] btrfs: add a trace point for reserve tickets
Date:   Fri,  9 Oct 2020 09:28:19 -0400
Message-Id: <a950d7af5cd8b905b951c83db0c144177235abbc.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
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
 fs/btrfs/space-info.c        | 10 +++++++++-
 include/trace/events/btrfs.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ba2b72409d46..ac7269cf1904 100644
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

