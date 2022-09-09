Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C125B41D0
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiIIVyX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbiIIVyV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:21 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39151079C8
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:20 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s22so2223103qkj.3
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=AK3479ESINHUUJLmgSIWNutZHl95zZZl3FXkX49uOvQ=;
        b=cZZK6lDBnjJpylNTMN3PvjatxG6lIO7PxGsqa/TQb49c5OYRCkuPnR26KFVIlqmTE7
         wGP98mHSJnrlX3SJxwqFG5DjOs6ZIjBJyP3/Ze6owfO/PySu4XDY3PtSV9oSFsVmbslJ
         9Vdl4RTurwhZMzrR1JHuCUdsMQq2yfSB9heB7hdkXwEPQ7yuPOwWThYfeiP5dFh2TEu4
         G/uDX+LDyqZVr3jm0d1HGuuiLaY6OGPYNCTFJiqiLVe0b0c4WCn+wRpnaC0Dp8xGOafv
         VRMRbpjQp1dAkMgWTqZ0URy0pPiHEg3JQbXDfVeESB7k8TSrLKftzJ6mTaPrAZTyAzwb
         VWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=AK3479ESINHUUJLmgSIWNutZHl95zZZl3FXkX49uOvQ=;
        b=w1kFgJb+ErV8EToYCV7fhoJS+yl1UPk0uBy+d8tGdetE9wTqAdB2Efs0jNah/HXEk6
         GpedaujneweEaIMTeJyMVUREk2QxbwGaEe4+6zJ+kEpCnLRmxEU8YiGs9pyMvRHOz93I
         N9WhFxRkFTKLykLj4mIrdfMzTSJqJz1PdkjofcQ7OvorfcHM5eNOCtfgF/rVOoVHFk1O
         +/bH7lTbpJ9oUNzyFoLlmyoGngFuefGEU2brMO8Vlk4wGu2ibShRQ8fjZSo4T/dGO6OS
         zXVcK8Mu2dpMPjIEkFavVVRu+WmNopajCezEynCAPXv7KExsdRTl5L1Ci5zJMcRgvqQD
         tV+Q==
X-Gm-Message-State: ACgBeo3GC4n5QMmq2vmH9L2mu80V8rXZUGwMZl9xggd2JRmlKNT628fI
        r1NGs7eLBmxcWFkHY0NIeuVdcpozMzGKXQ==
X-Google-Smtp-Source: AA6agR7VNf8z2HYdndNqifM69Vw3L0+YJwms8bPX+vto17vbPnsCpWJ153uY/i7dKjXy7Um2UPt6Eg==
X-Received: by 2002:a05:620a:8001:b0:6ba:be07:7187 with SMTP id ee1-20020a05620a800100b006babe077187mr11884429qkb.153.1662760460177;
        Fri, 09 Sep 2022 14:54:20 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 126-20020a370684000000b006be8713f742sm1422630qkg.38.2022.09.09.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:19 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 20/36] btrfs: use next_state instead of rb_next where we can
Date:   Fri,  9 Sep 2022 17:53:33 -0400
Message-Id: <f44ff9e82c87a7999c4d03b734f56b0e6d0622fd.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We can simplify a lot of these functions where we have to cycle through
extent_state's by simply using next_state() instead of rb_next().  In
many spots this allows us to do things like

while (state) {
	/* whatever */
	state = next_state(state);
}

instead of

while (1) {
	state = rb_entry(n, struct extent_state, rb_node);
	n = rb_next(n);
	if (!n)
		break;
}

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 57 +++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 4855fa5ab29e..f3034524acdf 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -752,12 +752,10 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 		 * our range starts
 		 */
 		node = tree_search(tree, start);
-process_node:
 		if (!node)
 			break;
-
 		state = rb_entry(node, struct extent_state, rb_node);
-
+process_node:
 		if (state->start > end)
 			goto out;
 
@@ -774,7 +772,7 @@ void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end, u32 bits)
 			break;
 
 		if (!cond_resched_lock(&tree->lock)) {
-			node = rb_next(node);
+			state = next_state(state);
 			goto process_node;
 		}
 	}
@@ -818,15 +816,13 @@ find_first_extent_bit_state(struct extent_io_tree *tree, u64 start, u32 bits)
 	node = tree_search(tree, start);
 	if (!node)
 		goto out;
+	state = rb_entry(node, struct extent_state, rb_node);
 
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (state->end >= start && (state->state & bits))
 			return state;
 
-		node = rb_next(node);
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	return NULL;
@@ -942,8 +938,8 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 		goto out;
 	}
 
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (found && (state->start != cur_start ||
 			      (state->state & EXTENT_BOUNDARY))) {
 			goto out;
@@ -961,12 +957,10 @@ bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
 		found = true;
 		*end = state->end;
 		cur_start = state->end + 1;
-		node = rb_next(node);
 		total_bytes += state->end - state->start + 1;
 		if (total_bytes >= max_bytes)
 			break;
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	spin_unlock(&tree->lock);
@@ -1519,18 +1513,15 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 	 * Find the longest stretch from start until an entry which has the
 	 * bits set
 	 */
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (state->end >= start && !(state->state & bits)) {
 			*end_ret = state->end;
 		} else {
 			*end_ret = state->start - 1;
 			break;
 		}
-
-		node = rb_next(node);
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	spin_unlock(&tree->lock);
@@ -1568,8 +1559,8 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	if (!node)
 		goto out;
 
-	while (1) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state) {
 		if (state->start > search_end)
 			break;
 		if (contig && found && state->start > last + 1)
@@ -1587,9 +1578,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		} else if (contig && found) {
 			break;
 		}
-		node = rb_next(node);
-		if (!node)
-			break;
+		state = next_state(state);
 	}
 out:
 	spin_unlock(&tree->lock);
@@ -1615,9 +1604,11 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		node = &cached->rb_node;
 	else
 		node = tree_search(tree, start);
-	while (node && start <= end) {
-		state = rb_entry(node, struct extent_state, rb_node);
+	if (!node)
+		goto out;
 
+	state = rb_entry(node, struct extent_state, rb_node);
+	while (state && start <= end) {
 		if (filled && state->start > start) {
 			bitset = 0;
 			break;
@@ -1641,13 +1632,13 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 		start = state->end + 1;
 		if (start > end)
 			break;
-		node = rb_next(node);
-		if (!node) {
-			if (filled)
-				bitset = 0;
-			break;
-		}
+		state = next_state(state);
 	}
+
+	/* We ran out of states and were still inside of our range. */
+	if (filled && !state)
+		bitset = 0;
+out:
 	spin_unlock(&tree->lock);
 	return bitset;
 }
-- 
2.26.3

