Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819483057B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S316779AbhAZXJx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 18:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbhAZVZk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 16:25:40 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F33C061797
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:58 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h21so68043qvb.8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Jan 2021 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rjQecgHgtdUxZ+azGGUaKtZD7XOfgfncxf/IUGcvH6M=;
        b=T5oYTgTl5rE5Gfi7ToQkX0onE4L3+L7+GxLcGluPfNeZcrxkNyPA91r9ou5ULjkMXC
         6tzDRQgwfi/Y6lSosCWT+H9t9BaQl19CbEw8tofSxWx169VMtqOvDOjjC505ZFEyPkYG
         nqMR/fw6C8cE5AE71VV13DgGtm/ifLN1zLFr5q1rCrAr9MTkLs7rkhBxSlmbCgf96mCe
         Wmxcfyg1ExrClhe/rur2O9dYHAyeIXg6lxBtCpeYHPIPSUa30M76mKS7V/0XRSZoGCtx
         XITxVe1fLFYkaFgOctjAX9R4rQS0EzptTzw7hAfV6f4RjlxUVcYYUPGsdRENvavciiRS
         yHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjQecgHgtdUxZ+azGGUaKtZD7XOfgfncxf/IUGcvH6M=;
        b=ZOlhR0qR2JVqSxJ7QPdMj03YX0ReHeutNJAD+VcFxstws9GRDMsWMGS07zGSY7NBTh
         6U0Jyk1jEYHGqqIkrkI39DDD4EXhMysVSjmO9oHFfT7dkimJCGtcbLscv2yDpQNQKFoO
         opvt6TE0fSTw98vfvAfVX3fdOBhCgIEKYnkWPIg8kpMlEteBCwNi0yrum25+c1/E0gRH
         b1J9H2S5Z0TrZjgghw6n4JkAcWxZ/0pD/dNJm3J9tbljywsWZt18uc3JYFN+mmFv28FP
         Hqc2j4My14O2ijJsoGZLm8zeuY4vEz027FxYOZGSd9eKSBRQpmAuAm4uvFim7ZtN7WNR
         ZIrQ==
X-Gm-Message-State: AOAM532u0ZVcBHrcdvcRs0bWCze1Nff6T5JYdZNGh9n6SXOrkNpUK5Im
        7PrjGXjQZB4QI0juja47pRJodmLsrvITKgi1
X-Google-Smtp-Source: ABdhPJwatXk9FEYj1Akmq7h+9EoKuTqe3FLjhPol2uhjfDbNUW6bStTdDYxnZEgvDIinwExVe8fsrA==
X-Received: by 2002:a0c:bf12:: with SMTP id m18mr7613474qvi.40.1611696297608;
        Tue, 26 Jan 2021 13:24:57 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 199sm5173674qkm.126.2021.01.26.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 13:24:56 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 11/12] btrfs: adjust the flush trace point to include the source
Date:   Tue, 26 Jan 2021 16:24:35 -0500
Message-Id: <13bb6ffcc88892083a420d2212f77162f253721d.1611695838.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1611695838.git.josef@toxicpanda.com>
References: <cover.1611695838.git.josef@toxicpanda.com>
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
index 6afb9cac694a..48c2a4eae235 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -667,7 +667,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
  */
 static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       enum btrfs_flush_state state)
+		       enum btrfs_flush_state state, bool for_preempt)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_trans_handle *trans;
@@ -750,7 +750,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	}
 
 	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
-				ret);
+				ret, for_preempt);
 	return;
 }
 
@@ -989,7 +989,8 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 
 	flush_state = FLUSH_DELAYED_ITEMS_NR;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, flush_state);
+		flush_space(fs_info, space_info, to_reclaim, flush_state,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1125,7 +1126,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		to_reclaim >>= 2;
 		if (!to_reclaim)
 			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
-		flush_space(fs_info, space_info, to_reclaim, flush);
+		flush_space(fs_info, space_info, to_reclaim, flush, true);
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
@@ -1222,7 +1223,8 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	spin_unlock(&space_info->lock);
 
 	while (!space_info->full) {
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1235,7 +1237,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 
 	while (flush_state < ARRAY_SIZE(data_flush_states)) {
 		flush_space(fs_info, space_info, U64_MAX,
-			    data_flush_states[flush_state]);
+			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1308,7 +1310,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 	flush_state = 0;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
+		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
+			    false);
 		flush_state++;
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
@@ -1324,7 +1327,8 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
index 0cf02dfd4c01..74e5cc247b80 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1113,15 +1113,16 @@ TRACE_EVENT(btrfs_trigger_flush,
 TRACE_EVENT(btrfs_flush_space,
 
 	TP_PROTO(const struct btrfs_fs_info *fs_info, u64 flags, u64 num_bytes,
-		 int state, int ret),
+		 int state, int ret, bool for_preempt),
 
-	TP_ARGS(fs_info, flags, num_bytes, state, ret),
+	TP_ARGS(fs_info, flags, num_bytes, state, ret, for_preempt),
 
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,	flags			)
 		__field(	u64,	num_bytes		)
 		__field(	int,	state			)
 		__field(	int,	ret			)
+		__field(	bool,	for_preempt		)
 	),
 
 	TP_fast_assign_btrfs(fs_info,
@@ -1129,15 +1130,16 @@ TRACE_EVENT(btrfs_flush_space,
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

