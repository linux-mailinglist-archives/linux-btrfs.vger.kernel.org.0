Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF525AB946
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiIBURI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiIBUQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:16:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E395F47F0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:16:51 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id l5so2361515qtv.4
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=dUXE5TkD0jgwoYKPSa779n8L9NLTD8kdB5l3Ups44Iw=;
        b=vbHKC6pyIm3wxNVIl269q/OkII95u9g8h5J+Uo5WdyYjnkGQ2va1bzqMFtHQdeDmsg
         a1xJ5ti+mVcP08lBnBoOt6V7kJir5tG3EQ/7Mx2VQcMHDIKf8jzrlCvs6dB/CF8+PBfm
         zvpmcEwQX7Z/XaSlGBQXphwX6smInq6Q4eS7YL5F671LHWWV8h4ZpgDJ8Y615rNQLOPc
         w557AEl8wRRwe06y9rIrX50XpcpgaWEJuzOF9IsU41Qdq6yDDTcF61ZCsHsmIHcW4hSu
         uyo53FmACqDVkO/JkzW01uzVoftuG4q5zOquyxPZ1QpwgdR+uFIoMrFnDc4xHUP/N8mz
         Yvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dUXE5TkD0jgwoYKPSa779n8L9NLTD8kdB5l3Ups44Iw=;
        b=K2yfGcO9JARAQOK8uj2uQrFSCz902z4pmcpnGs+dHOiMsn8VgrSJHTK5+vUNjNytBf
         8wjLqPPtPbkm0aIrERY5Yd4BngUJfo8Q/LgwPty1xMy7coVV+7sFLZY7rxo/GOesTO40
         f5sw3H4APvDelkFj2q/6eUAGghiWhjEwlFH8g9xu4FAMajrOmr/NAU4I/zQVI9Z7BMhw
         bF+jFO//fXBxMMXaf5jdNwj3cyIQn6RxvePGgyDULW9q9iZd8tnfkCKN+9h/zxOJTduG
         tLGaO9K5tHAqBiw2viw9qliaQm2HceeF/YnTstRHFC3eljSJune4QTcDp8Gfe0b2iaBb
         hKXw==
X-Gm-Message-State: ACgBeo1TsWReUjU9A6zX0eW+r/G6Ig3yNEW7DqmMVMT6g3TXmuBZ01Vr
        0ewvcY0oZ3J7Q3QeYPhmhqfnKwyRNky6Pw==
X-Google-Smtp-Source: AA6agR7Bn5aFXe3DRcaowoa3isYmfqqkF2LcgDM0Ni0lAwqYWVGyo1fUR6Mc08W2NvUrkLGM1IlIUg==
X-Received: by 2002:a05:622a:148f:b0:344:53fa:18c6 with SMTP id t15-20020a05622a148f00b0034453fa18c6mr30571912qtx.555.1662149809466;
        Fri, 02 Sep 2022 13:16:49 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g19-20020ac84813000000b003051ea4e7f6sm1491782qtq.48.2022.09.02.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:16:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/31] btrfs: separate out the eb and extent state leak helpers
Date:   Fri,  2 Sep 2022 16:16:11 -0400
Message-Id: <f92bf38f02453170acc20f0dc8ef16a224ab478b.1662149276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662149276.git.josef@toxicpanda.com>
References: <cover.1662149276.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently we have the add/del functions generic so that we can use them
for both extent buffers and extent states.  We want to separate this
code however, so separate these helpers into per-object helpers in
anticipation of the split.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 58 +++++++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d95f0779676b..27f412a3c668 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -43,25 +43,42 @@ static inline bool extent_state_in_tree(const struct extent_state *state)
 static LIST_HEAD(states);
 static DEFINE_SPINLOCK(leak_lock);
 
-static inline void btrfs_leak_debug_add(spinlock_t *lock,
-					struct list_head *new,
-					struct list_head *head)
+static inline void btrfs_leak_debug_add_eb(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	list_add(&eb->leak_list, &fs_info->allocated_ebs);
+	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
+}
+
+static inline void btrfs_leak_debug_add_state(struct extent_state *state)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(lock, flags);
-	list_add(new, head);
-	spin_unlock_irqrestore(lock, flags);
+	spin_lock_irqsave(&leak_lock, flags);
+	list_add(&state->leak_list, &states);
+	spin_unlock_irqrestore(&leak_lock, flags);
+}
+
+static inline void btrfs_leak_debug_del_eb(struct extent_buffer *eb)
+{
+	struct btrfs_fs_info *fs_info = eb->fs_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fs_info->eb_leak_lock, flags);
+	list_del(&eb->leak_list);
+	spin_unlock_irqrestore(&fs_info->eb_leak_lock, flags);
 }
 
-static inline void btrfs_leak_debug_del(spinlock_t *lock,
-					struct list_head *entry)
+static inline void btrfs_leak_debug_del_state(struct extent_state *state)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(lock, flags);
-	list_del(entry);
-	spin_unlock_irqrestore(lock, flags);
+	spin_lock_irqsave(&leak_lock, flags);
+	list_del(&state->leak_list);
+	spin_unlock_irqrestore(&leak_lock, flags);
 }
 
 void btrfs_extent_buffer_leak_debug_check(struct btrfs_fs_info *fs_info)
@@ -125,9 +142,11 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 	}
 }
 #else
-#define btrfs_leak_debug_add(lock, new, head)	do {} while (0)
-#define btrfs_leak_debug_del(lock, entry)	do {} while (0)
-#define btrfs_extent_state_leak_debug_check()	do {} while (0)
+#define btrfs_leak_debug_add_eb(eb)			do {} while (0)
+#define btrfs_leak_debug_add_state(state)		do {} while (0)
+#define btrfs_leak_debug_del_eb(eb)			do {} while (0)
+#define btrfs_leak_debug_del_state(state)		do {} while (0)
+#define btrfs_extent_state_leak_debug_check()		do {} while (0)
 #define btrfs_debug_check_extent_io_range(c, s, e)	do {} while (0)
 #endif
 
@@ -334,7 +353,7 @@ static struct extent_state *alloc_extent_state(gfp_t mask)
 		return state;
 	state->state = 0;
 	RB_CLEAR_NODE(&state->rb_node);
-	btrfs_leak_debug_add(&leak_lock, &state->leak_list, &states);
+	btrfs_leak_debug_add_state(state);
 	refcount_set(&state->refs, 1);
 	init_waitqueue_head(&state->wq);
 	trace_alloc_extent_state(state, mask, _RET_IP_);
@@ -347,7 +366,7 @@ void free_extent_state(struct extent_state *state)
 		return;
 	if (refcount_dec_and_test(&state->refs)) {
 		WARN_ON(extent_state_in_tree(state));
-		btrfs_leak_debug_del(&leak_lock, &state->leak_list);
+		btrfs_leak_debug_del_state(state);
 		trace_free_extent_state(state, _RET_IP_);
 		kmem_cache_free(extent_state_cache, state);
 	}
@@ -5713,7 +5732,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 {
 	btrfs_release_extent_buffer_pages(eb);
-	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
+	btrfs_leak_debug_del_eb(eb);
 	__free_extent_buffer(eb);
 }
 
@@ -5730,8 +5749,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->bflags = 0;
 	init_rwsem(&eb->lock);
 
-	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
-			     &fs_info->allocated_ebs);
+	btrfs_leak_debug_add_eb(eb);
 	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
@@ -6199,7 +6217,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 			spin_unlock(&eb->refs_lock);
 		}
 
-		btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
+		btrfs_leak_debug_del_eb(eb);
 		/* Should be safe to release our pages at this point */
 		btrfs_release_extent_buffer_pages(eb);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.26.3

