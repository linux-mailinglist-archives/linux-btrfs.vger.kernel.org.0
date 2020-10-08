Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4521B287D76
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Oct 2020 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730767AbgJHUtR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Oct 2020 16:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730765AbgJHUtQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Oct 2020 16:49:16 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C592C0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Oct 2020 13:49:16 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j3so3751346qvi.7
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Oct 2020 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kLZoYBEkTkdhWzTpj8OYyAbBB+9Bn+Xc6aKwXFI8Lx8=;
        b=rb5GkT83uGUmqpxaIKJYkDW15xlM7X2vnZeGUniBtzBsvK+zt+bKOMvtOKzcEIgR6j
         XpRc5+YfFh6hyg8POwm/wRYUhMyfWMZ8lU5+rtPjzWk7QR1uEnhvuQknIH9bv5pMhVtM
         +pbDWPdnzoAkMUktZYQ/tehiJcea8HQ1ma0+qWPeMbvOMsg43Iu6GeJPhQU9NXSw8GMv
         muUiSm6XYpkQqI2fxbWs8cwD9MKUp+FrmMnGyR/hOCs0CVfYVQooRzDDL6GtCPfjOuUW
         ZeMQoqLBThHJkzXe5bAbwmR22DwGKdem9REbzXd9bCaxAvF4e5xoNnH0goyIE97zeFUr
         T1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kLZoYBEkTkdhWzTpj8OYyAbBB+9Bn+Xc6aKwXFI8Lx8=;
        b=fe/xTn+1OHmyOzLHGRBiJ8fvEN5d6nomrCiT3PsovVCkbwJVPoe4RG72jFpxP81Ppi
         CGmJGNwmI3606xMqd4wlLXP+qG2zeqyqoF6EzHAAsCwjw9XQ5A7L8I6o69A46vnXv1ij
         us/jicn7K++tfmXx7WaaF2TT0gCopw4YKy018TsHLr0wHZ6ogFIXV1PsS7bzDiHiPfOg
         CLTt0yNnkgGvIIXXGRSOiK++V9nhm/ZZ0nQ+WaGdQAXUzJR+w6nVGq54P8RgKRTWET2c
         pbC0IqAxuhc3ZRxWNje4Rv5oRnPNVAXiF8UO/Vr88a/XMS90ea9d85CY03HO30IzINRy
         Qn3g==
X-Gm-Message-State: AOAM530tswY+B7RHupYumq3dwkVbscc9kRk/csLnCG1yNaw4Q+yhckIs
        Y1clCudnTR2yfzkiw2pifJykBXTygSoz0JKg
X-Google-Smtp-Source: ABdhPJxcjpImc0SC/iRrFBUkwVkhAFIGUl8UB4dMEI/S25jdrFJaZQ1ZE8XoSpAnXsGUCe5KT8SEjg==
X-Received: by 2002:a0c:b29e:: with SMTP id r30mr10196920qve.38.1602190155205;
        Thu, 08 Oct 2020 13:49:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e17sm4455514qte.11.2020.10.08.13.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 13:49:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 10/11] btrfs: adjust the flush trace point to include the source
Date:   Thu,  8 Oct 2020 16:48:54 -0400
Message-Id: <d5db18ce1f89370c5203c39a1f80c0e929fb49ea.1602189832.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1602189832.git.josef@toxicpanda.com>
References: <cover.1602189832.git.josef@toxicpanda.com>
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
index 71bebb60f0ce..c5fc90dd8378 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -669,7 +669,7 @@ static int may_commit_transaction(struct btrfs_fs_info *fs_info,
  */
 static void flush_space(struct btrfs_fs_info *fs_info,
 		       struct btrfs_space_info *space_info, u64 num_bytes,
-		       int state)
+		       int state, bool for_preempt)
 {
 	struct btrfs_root *root = fs_info->extent_root;
 	struct btrfs_trans_handle *trans;
@@ -752,7 +752,7 @@ static void flush_space(struct btrfs_fs_info *fs_info,
 	}
 
 	trace_btrfs_flush_space(fs_info, space_info->flags, num_bytes, state,
-				ret);
+				ret, for_preempt);
 	return;
 }
 
@@ -978,7 +978,8 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
 
 	flush_state = FLUSH_DELAYED_ITEMS_NR;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, flush_state);
+		flush_space(fs_info, space_info, to_reclaim, flush_state,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1114,7 +1115,7 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
 		to_reclaim >>= 2;
 		if (!to_reclaim)
 			to_reclaim = btrfs_calc_insert_metadata_size(fs_info, 1);
-		flush_space(fs_info, space_info, to_reclaim, flush);
+		flush_space(fs_info, space_info, to_reclaim, flush, true);
 		cond_resched();
 		spin_lock(&space_info->lock);
 	}
@@ -1205,7 +1206,8 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 	spin_unlock(&space_info->lock);
 
 	while (!space_info->full) {
-		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE);
+		flush_space(fs_info, space_info, U64_MAX, ALLOC_CHUNK_FORCE,
+			    false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1218,7 +1220,7 @@ static void btrfs_async_reclaim_data_space(struct work_struct *work)
 
 	while (flush_state < ARRAY_SIZE(data_flush_states)) {
 		flush_space(fs_info, space_info, U64_MAX,
-			    data_flush_states[flush_state]);
+			    data_flush_states[flush_state], false);
 		spin_lock(&space_info->lock);
 		if (list_empty(&space_info->tickets)) {
 			space_info->flush = 0;
@@ -1291,7 +1293,8 @@ static void priority_reclaim_metadata_space(struct btrfs_fs_info *fs_info,
 
 	flush_state = 0;
 	do {
-		flush_space(fs_info, space_info, to_reclaim, states[flush_state]);
+		flush_space(fs_info, space_info, to_reclaim, states[flush_state],
+			    false);
 		flush_state++;
 		spin_lock(&space_info->lock);
 		if (ticket->bytes == 0) {
@@ -1307,7 +1310,8 @@ static void priority_reclaim_data_space(struct btrfs_fs_info *fs_info,
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

