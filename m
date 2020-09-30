Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E046327F2E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Sep 2020 22:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730269AbgI3UBk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 30 Sep 2020 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbgI3UBk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:40 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC13C061755
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:39 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id n10so2330136qtv.3
        for <linux-btrfs@vger.kernel.org>; Wed, 30 Sep 2020 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Rw3qcFtK47GeVx2M3muGAclXk7czEHVxZ3CqRtIDA/o=;
        b=j2WJmPhqeK+V+ds7pm6idr09E2esDMRVZsa8VGHNPgKgcTaDzmMCqU1T48z3bhQ86m
         7cWMMAkUVBHFb0+HEbf0Ls2UQuty5bczOscL9iGIuVL7wJo7W3+89NjZUrJOWpU6+k5+
         uETus57YruuNRZST1B1MLuxBpqCjAqP5GGZe7AyzyIuDXUJGKv0WCjno3C5aloGHP4wc
         6D5qVXKPGkod1XPeN/YVibHlK8vBCIt+KMXO9P2g0VMKo0ZJc0NSKcjit/GuvzlgoG6E
         9HD99taIQKiz3cAIOYx2ImGXT1g1ziABllQ1qCvL962UWHJUoMuv5pvah763v66wDs5J
         GIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rw3qcFtK47GeVx2M3muGAclXk7czEHVxZ3CqRtIDA/o=;
        b=Y3mrXTTD99MF1PVFo40j/yS4Mem5xFaiiOGwlHS1hyzcrn/VWRYwphxzn/4wIygUm3
         xTiS58YupQlEcWy5elRvRRosF6vz9ng4Ei5ycxzBaqnJRL7yu6js8WjCMqMXW1znht9o
         FAdaof141nSAq48AJ8s5/3m80tZprcT4ULeu/0g+Quv5ltduZMADGlWdrJZ8VdHWzBfL
         Ksvu37ugGi04uJTzU2RvNoTjXxpp2Xvf9WW70B3omX0OTrgUEg/anqLCiuk6VK4NTcod
         kP4VJtPxT44QTi0aHk1usWqFK+AlNy1VYAEz4Yrf5/UYEfdcI8OcZ6BuVcVz3rTF600O
         GQwQ==
X-Gm-Message-State: AOAM532m1F4y4ftv3toEul0Z7SxNeZgyegHHY0XeF0Wn4qBP5OhN53ez
        wm8b5AbfIkCuqE40O+SM2MbvZcQog353pICz
X-Google-Smtp-Source: ABdhPJwaUyn9qlomuNFKVakfQlFTUtumq7gHUvyul+eOhyV05+9iIuWzQMeGHJhg1mj6Tw+00CesDA==
X-Received: by 2002:ac8:66da:: with SMTP id m26mr4146202qtp.111.1601496098505;
        Wed, 30 Sep 2020 13:01:38 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p205sm3209134qke.2.2020.09.30.13.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/9] btrfs: adjust the flush trace point to include the source
Date:   Wed, 30 Sep 2020 16:01:08 -0400
Message-Id: <f561822c1ce993a10fe67f348bf96950cd9e38aa.1601495426.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1601495426.git.josef@toxicpanda.com>
References: <cover.1601495426.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since we have normal ticketed flushing and preemptive flushing, adjust
the tracepoint so that we know the source of the flushing action to make
it easier to debug problems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c        | 20 ++++++++++++--------
 include/trace/events/btrfs.h | 10 ++++++----
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 5ecdd6c41a51..b9735e7de480 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -668,7 +668,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
  */
 static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       int state)
+		       int state, bool for_preempt)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_trans_handle *trans;
@@ -743,7 +743,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	}
 
 	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
-				ret);
+				ret, for_preempt);
 	return;
 }
 
@@ -943,7 +943,8 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 
 	flush_state = FLUSH_DELAYED_ITEMS_NR;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, flush_state);
+		flush_space(fs_info, space_info, to_reclaim, flush_state,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1099,7 +1100,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		to_reclaim >>= 2;
 		if (!to_reclaim)
 			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
-		flush_space(fs_info, space_info, to_reclaim, flush);
+		flush_space(fs_info, space_info, to_reclaim, flush, true);
 next:
 		cond_resched();
 		spin_lock(&space_info->lock);
@@ -1191,7 +1192,8 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	spin_unlock(&space_info->lock);
 
 	while (!space_info->full) {
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1204,7 +1206,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 
 	while (flush_state < ARRAY_SIZE(data_flush_states)) {
 		flush_space(fs_info, space_info, U64_MAX,
-			    data_flush_states[flush_state]);
+			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1277,7 +1279,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 	flush_state = 0;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
+		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
+			    false);
 		flush_state++;
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
@@ -1293,7 +1296,8 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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
index 68d1622623c7..c340bff65450 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1111,15 +1111,16 @@ TRACE_EVENT(btrfs_trigger_flush,
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
@@ -1127,15 +1128,16 @@ TRACE_EVENT(btrfs_flush_space,
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

