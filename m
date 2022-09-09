Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CB5B41B8
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiIIVyC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiIIVyB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:01 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C76F651D
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:00 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r6so2344396qtx.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=uPVd2o0gf3rx81vKXT46VZaevTKGQr8nLf5qget5uVE=;
        b=I8CAiCVl6PhcgG3JtyfFMfUBNsZbLTFJzz+qL1tTuxJYyUWbXYwjcT6p2cy/pE5qtv
         mfR6+mJpgQ2wIBweOzXwXVuTKBAqqBQqIjYDQtkAvA8yg3lZYa+rNH/4GglB7l3W0euf
         vsKk2dgnD6ao3QKx4EZygH4A0H0HQxzV4OW78n2C7ZBawTW2JRo/uaK6oTBDLSdM6tVO
         2zegXn4MAchT4u6f1hr0XL39JXbC0jGSfYnbG3o9lfPOEHVe5OswRVhxYV2MDipL2+4c
         s8eCFpfQZX/0zWTZaYvEkohbTzJ9J/nuYvOUM/PY8w6cyaPOMWuglgJZLAfQ+U4X0bUC
         /QzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uPVd2o0gf3rx81vKXT46VZaevTKGQr8nLf5qget5uVE=;
        b=MjzlExZBTmfY6a52iRo8IvHwBZ/VWe+P79L3b98FnpRFRcokqq/hN5hEKtjZpio83H
         rU9LtSZFhinEk55mGAQRaemuMMHTlmPxPrNSsNPPQJzrxGPonilUeMAHoob99PAbkbWM
         o3yVCIv9/OXyq9aEUwmjKFS5WJZGLz2thsdkUjt64XRLfxjWVr2mJD+H01ISFxW9noW5
         UAD6qV4vaRBQX0W2h5c5EFQUDBZE+GFGy7Sfz3e1znojznZSwYX6LOooB8SWL99TgVbP
         dFrBROBlb0lEtUHi/WuS2V2yuWhlOODWuTnMMZF8ihNpirVIkC3PACqCxlWoON7nklz1
         IDXQ==
X-Gm-Message-State: ACgBeo2ROZ63tfasJn1yTK1I22HIBQ5LBw/x1gKxrIIl49tc/TJOmpHT
        pRBUb0LDImUI2PETVtXVnjaot/WSOpkYGA==
X-Google-Smtp-Source: AA6agR7KQ+b7AM5Gm2dF92LllSD7QHtOtf+YadYEsMRYdikp9CywaNUk9Hm9XuYj++JEQmLUKOWl/g==
X-Received: by 2002:ac8:5ac5:0:b0:343:6d5a:43d9 with SMTP id d5-20020ac85ac5000000b003436d5a43d9mr14494796qtd.10.1662760440016;
        Fri, 09 Sep 2022 14:54:00 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l18-20020ac848d2000000b00344f936bfc0sm1169934qtr.33.2022.09.09.14.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:53:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/36] btrfs: separate out the eb and extent state leak helpers
Date:   Fri,  9 Sep 2022 17:53:19 -0400
Message-Id: <7b6a38c92a390bf480e5718666608e4338e50ee9.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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
index 34b03bd2352e..35811d40e2f1 100644
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
@@ -5993,7 +6012,7 @@ static void btrfs_release_extent_buffer_pages(struct extent_buffer *eb)
 static inline void btrfs_release_extent_buffer(struct extent_buffer *eb)
 {
 	btrfs_release_extent_buffer_pages(eb);
-	btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
+	btrfs_leak_debug_del_eb(eb);
 	__free_extent_buffer(eb);
 }
 
@@ -6010,8 +6029,7 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 	eb->bflags = 0;
 	init_rwsem(&eb->lock);
 
-	btrfs_leak_debug_add(&fs_info->eb_leak_lock, &eb->leak_list,
-			     &fs_info->allocated_ebs);
+	btrfs_leak_debug_add_eb(eb);
 	INIT_LIST_HEAD(&eb->release_list);
 
 	spin_lock_init(&eb->refs_lock);
@@ -6479,7 +6497,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 			spin_unlock(&eb->refs_lock);
 		}
 
-		btrfs_leak_debug_del(&eb->fs_info->eb_leak_lock, &eb->leak_list);
+		btrfs_leak_debug_del_eb(eb);
 		/* Should be safe to release our pages at this point */
 		btrfs_release_extent_buffer_pages(eb);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
-- 
2.26.3

