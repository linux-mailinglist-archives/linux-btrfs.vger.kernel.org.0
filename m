Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344215AB941
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Sep 2022 22:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiIBURd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Sep 2022 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiIBUR1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Sep 2022 16:17:27 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F156CD8B3B
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Sep 2022 13:17:26 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g14so2336345qto.11
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Sep 2022 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=JTRNybFsiSQz3Xr2wvZbMDEPaSj35+GSU75Uv10Ntmw=;
        b=wUA2jDe22lNShmZlZg3kfPfb9i0dIkr7wHcTyKaAUUT5cMlbyYbQ1gUDApetZxBG90
         5lO+Yp6zhBMju5JmQ6wX0DYTqkX0nC8fBRd9jDajpkRdyct3NWv807/vL53+Z3LYBH3p
         4bX9SGlKTw77v/FfYmujjInUljRDPfe84iqWTxVAvCpZv0fFj1GBOPfWbvcVZofIzfDJ
         FRXvSiSf2D38vSe+uXdjFagp+eMHLAOGvWM91dUV3hz42wZIf6JxJVEt5ZivJBx7r9cc
         DyAoAu4F0Z0Lxmc8++Zf3MfIDjA+uqouXW72VDNt5dEelsXvaRwE89GzCNfqHbmjkEbT
         ZvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JTRNybFsiSQz3Xr2wvZbMDEPaSj35+GSU75Uv10Ntmw=;
        b=ugBopT0reCm1QzVO9xJb8azGDLKHs2JtiJrUmWLreloYjO98ntQJG8TtKdB8Tx1qDt
         8HrDkGGjqENF7xg7bDH/B5W/2nLvRnWdQ/GXAKLnhxgEwzYCFsoXrYBDmDqyVBMcQWIA
         3HjP6eyScvlSSPIRzdqa1vYFbOqgNzgaH2OOZXw6n4zh9eCayEccBrlK72vxVr4B+ULz
         BucxwGW6HbNFfOjbCXQ8KCvpiXg+l1YYpQhhYr5ZHIaXeRKhnxtAEjjNo31JsRUt033H
         ZcFPYUPNlMv9IwfeEVSevDOwYj3x+IoO0u5ZlO/EfkzLY/IVxsrnH5mgWwvd+C7XktVN
         EiOQ==
X-Gm-Message-State: ACgBeo3tAp7ePBELy2CZmY7kRk1RtlbYGkiGRv56j1GiK3ZzBEVO9eMv
        3WxxSSqYS9ZIdi9M+n1mvxcQinv093aDzQ==
X-Google-Smtp-Source: AA6agR5wPXRt6FC4SAPw2M3fT/fLRqnwTB/wgEQdU0ScLbgjulWD7L9ufwqTzcMk6sWMw+bTB/C1Ng==
X-Received: by 2002:ac8:5f8f:0:b0:342:fb0c:77d0 with SMTP id j15-20020ac85f8f000000b00342fb0c77d0mr29560350qta.93.1662149845624;
        Fri, 02 Sep 2022 13:17:25 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i11-20020a05620a150b00b006af08c26774sm1980300qkk.47.2022.09.02.13.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:17:25 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 27/31] btrfs: get rid of ->dirty_bytes
Date:   Fri,  2 Sep 2022 16:16:32 -0400
Message-Id: <9e5e464b37fbc7973534375ff18b0fae9bf0365e.1662149276.git.josef@toxicpanda.com>
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

This was used as an optimization for count_range_bits(EXTENT_DIRTY), but
we no longer do that, thus nothing actually uses the ->dirty_bytes
counter in the extent_io_tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 17 +----------------
 fs/btrfs/extent-io-tree.h |  1 -
 2 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 4fd0cac6564a..b4e70d4f243b 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -91,7 +91,6 @@ void extent_io_tree_init(struct btrfs_fs_info *fs_info,
 {
 	tree->fs_info = fs_info;
 	tree->state = RB_ROOT;
-	tree->dirty_bytes = 0;
 	spin_lock_init(&tree->lock);
 	tree->private_data = private_data;
 	tree->owner = owner;
@@ -486,12 +485,6 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if ((bits_to_clear & EXTENT_DIRTY) && (state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		WARN_ON(range > tree->dirty_bytes);
-		tree->dirty_bytes -= range;
-	}
-
 	if (tree->private_data && is_data_inode(tree->private_data))
 		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
 
@@ -756,10 +749,6 @@ static void set_state_bits(struct extent_io_tree *tree,
 	if (tree->private_data && is_data_inode(tree->private_data))
 		btrfs_set_delalloc_extent(tree->private_data, state, bits);
 
-	if ((bits_to_set & EXTENT_DIRTY) && !(state->state & EXTENT_DIRTY)) {
-		u64 range = state->end - state->start + 1;
-		tree->dirty_bytes += range;
-	}
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
 	BUG_ON(ret < 0);
 	state->state |= bits_to_set;
@@ -1538,10 +1527,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		return 0;
 
 	spin_lock(&tree->lock);
-	if (cur_start == 0 && bits == EXTENT_DIRTY) {
-		total_bytes = tree->dirty_bytes;
-		goto out;
-	}
+
 	/*
 	 * this search will find all the extents that end after
 	 * our range starts.
@@ -1567,7 +1553,6 @@ u64 count_range_bits(struct extent_io_tree *tree,
 		}
 		state = next_state(state);
 	}
-out:
 	spin_unlock(&tree->lock);
 	return total_bytes;
 }
diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 37543fb713bd..94574062eabe 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -69,7 +69,6 @@ struct extent_io_tree {
 	struct rb_root state;
 	struct btrfs_fs_info *fs_info;
 	void *private_data;
-	u64 dirty_bytes;
 
 	/* Who owns this io tree, should be one of IO_TREE_* */
 	u8 owner;
-- 
2.26.3

