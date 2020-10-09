Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FE02889CC
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Oct 2020 15:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388611AbgJIN25 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Oct 2020 09:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388573AbgJIN24 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Oct 2020 09:28:56 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D835C0613D6
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Oct 2020 06:28:55 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c23so7924053qtp.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Oct 2020 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C47/6Lu3kLBk7z18hoHpNXzwGHJ09XisxNmwegv3ccI=;
        b=QpW+yRpAJR60m8O5YO3fN7H+BejVIYfJG03BuWuOYTw8aWHMmIRsAiSCZ5JRBMMb2+
         ECuq21ftaHXIuM7xhwImGJJh9UveTAhkF9P2A+vqP+9XMA2GGWBW5oWspk0SInQrQXG0
         M0Pg+q3s0jmG3wncb2gQbcRN7K6vluPeO+NtcYHvOySfD7VfJ0nDrCblZXCO6JKym0rM
         ZH6lDzybqlVkHyr1mJMvlaa/DARKT1DcKzghlNZFgXqu0hJ4qVXw2NFG/++8k2SNnH1M
         e/BIwvD51TzvzP3Vy5lCH0UKJ/XZUUt/N8/Ej7H0kf+xkm7QA836ZmD9BakksqujaShK
         cFnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C47/6Lu3kLBk7z18hoHpNXzwGHJ09XisxNmwegv3ccI=;
        b=iTz1DBmzDEexx7Z5py8bRHR+V+St/3RQ+gEmnUvYS0x4k/WuC5d4wOa1XSH8QpiHS2
         lM/W7M5zKRtv1/erjOfmlmNhm4364cuiBtwp6Ufiik0S3DEJ/1rL5RMrNOVoJsSON8Ym
         7dhHEOekl6nkI4/idpjwac5DMpLT3/gK7sZcgE5rRMe9zJw9nq3bgYKtIeep6gCD2gdw
         n6GctJZU+7amgfj+0FNJuv4gShYVUiJ0eE1ENlt8UukaZlY1mIi5Mo6tSzZEsmedbRDD
         ZYfYZyeW3cCk4J0VrzSr4zEJ0pxs4V075vEkxYOoPJ2uqEsgcLaMxrsbBDNs6ETZDiFx
         l8qw==
X-Gm-Message-State: AOAM531WACnoQYfyqJ7UhhNzQUkTPkbjPBxIkWAMcZIiv2bvD8DvGFsI
        Qomyam1XVF3Vy6P4tNQBBGlDNfDb/r0Ban9J
X-Google-Smtp-Source: ABdhPJwNTnwKed59LbRjub5hXmoh8Htg6Q/pa32jy4+PCAowkDUV8Ex6Wlt9DBI9rpJMm9/Xh8EuTA==
X-Received: by 2002:ac8:5948:: with SMTP id 8mr13138469qtz.215.1602250133052;
        Fri, 09 Oct 2020 06:28:53 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r13sm6076138qtp.94.2020.10.09.06.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 06:28:52 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 11/12] btrfs: adjust the flush trace point to include the source
Date:   Fri,  9 Oct 2020 09:28:28 -0400
Message-Id: <cbc33fd7a2d39ca651ba1f1e44345663f5c369cc.1602249928.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602249928.git.josef@toxicpanda.com>
References: <cover.1602249928.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we have normal ticketed flushing and preemptive flushing, adjust
the tracepoint so that we know the source of the flushing action to make
it easier to debug problems.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        | 20 ++++++++++++--------
 include/trace/events/btrfs.h | 10 ++++++----
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5ee698c12a7b..30474fa30985 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -664,7 +664,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
  */
 static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       enum btrfs_flush_state state)
+		       enum btrfs_flush_state state, bool for_preempt)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_trans_handle *trans;
@@ -747,7 +747,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	}
 
 	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
-				ret);
+				ret, for_preempt);
 	return;
 }
 
@@ -973,7 +973,8 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 
 	flush_state = FLUSH_DELAYED_ITEMS_NR;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, flush_state);
+		flush_space(fs_info, space_info, to_reclaim, flush_state,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1109,7 +1110,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		to_reclaim >>= 2;
 		if (!to_reclaim)
 			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
-		flush_space(fs_info, space_info, to_reclaim, flush);
+		flush_space(fs_info, space_info, to_reclaim, flush, true);
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
@@ -1200,7 +1201,8 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	spin_unlock(&space_info->lock);
 
 	while (!space_info->full) {
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1213,7 +1215,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 
 	while (flush_state < ARRAY_SIZE(data_flush_states)) {
 		flush_space(fs_info, space_info, U64_MAX,
-			    data_flush_states[flush_state]);
+			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1286,7 +1288,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 	flush_state = 0;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
+		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
+			    false);
 		flush_state++;
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
@@ -1302,7 +1305,8 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
 					struct reserve_ticket *ticket)
 {
 	while (!space_info->full) {
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
+			    false);
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
 			spin_unlock(&space_info->lock);
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 0a3d35d952c4..6d93637bae02 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1112,15 +1112,16 @@ TRACE_EVENT(btrfs_trigger_flush,
 TRACE_EVENT(btrfs_flush_space,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 num_bytes,
-		 int state, int ret),
+		 int state, int ret, int for_preempt),
 
-	TP_ARGS(fs_info, flags, num_bytes, state, ret),
+	TP_ARGS(fs_info, flags, num_bytes, state, ret, for_preempt),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	flags			)
 		__field(	u64,	num_bytes		)
 		__field(	int,	state			)
 		__field(	int,	ret			)
+		__field(	int,	for_preempt		)
 	),
 
 	TP_fast_assign_btrfs(fs_info,
@@ -1128,15 +1129,16 @@ TRACE_EVENT(btrfs_flush_space,
 		__entry->num_bytes	=	num_bytes;
 		__entry->state		=	state;
 		__entry->ret		=	ret;
+		__entry->for_preempt	=	for_preempt;
 	),
 
-	TP_printk_btrfs("state=%d(%s) flags=%llu(%s) num_bytes=%llu ret=%d",
+	TP_printk_btrfs("state=%d(%s) flags=%llu(%s) num_bytes=%llu ret=%d for_preempt=%d",
 		  __entry->state,
 		  __print_symbolic(__entry->state, FLUSH_STATES),
 		  __entry->flags,
 		  __print_flags((unsigned long)__entry->flags, "|",
 				BTRFS_GROUP_FLAGS),
-		  __entry->num_bytes, __entry->ret)
+		  __entry->num_bytes, __entry->ret, __entry->for_preempt)
 );
 
 DECLARE_EVENT_CLASS(btrfs__reserved_extent,
-- 
2.26.2

