Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3416435E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  5 Dec 2022 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiLEUl5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Dec 2022 15:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiLEUlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Dec 2022 15:41:51 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B772A734
        for <linux-btrfs@vger.kernel.org>; Mon,  5 Dec 2022 12:41:50 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id c2so5998616qko.1
        for <linux-btrfs@vger.kernel.org>; Mon, 05 Dec 2022 12:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8VfLpZB9cGA/qEWlRIso23LHMX6KwWY1y1m+TVnefy4=;
        b=rgjQqS2CzlHSzVJ5nepCppzSMJ71ehfz040twMp83FSWQYAwOhQ0Nj1Ai1nYpwSkUy
         BQrpw/svEUEgGhMoIV3fjL0RM3/smNKX1IJf8Wt+pN5mgwkxTDvdOW8WSbXeGHUynDvv
         fYoE5WPjL41vFycs1xIjXTLWsQm+F7JKzu6UvrW/IlOZ6TcScGzU5rcqgGuMBNGTKpSa
         5kCHhQFlMrQDTVZhDOoSsf7mfbWYteYtRmU0aiP/ZYzCrIcrXhfIGK8NS3s4Tf3iRzF+
         a+CQ3V0PJcP/yY/v7+UTn6a5N11cWKqiui8EXtJHnshOsiZ6zT9DDTuV2KROo+Idaxgt
         vhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8VfLpZB9cGA/qEWlRIso23LHMX6KwWY1y1m+TVnefy4=;
        b=kOQ5xVG6NGwC/LVzdkvzuRKSprmlp2uj3qd37qea5+cR2Bpm0iSF0MhtkTjJ5dTGVl
         q2C4RRcyohVtGvcDki/6Y42uujVHWxxmD8UuvMYqhtOW/ji09IWDwjV1lHUNfosB/+Ij
         qgE6jxd5QwbX0sj8przUsa9D/SG6DwG6VuXe9zrxm2HZB1upLZLmac8FS6RszMum5ayS
         lsVo+7AyrkADc9fSMW2ejUiE+iwXH5IsIgQmhb2bDmA+WduXJkmqFSMW9iExnVWnDC1f
         rn2MMr/eL4hjLFt9EOuysXWGNnT67FMlM4z6U0AlTBWDhCklvkuielrm500gs+f1NeQH
         Sm7g==
X-Gm-Message-State: ANoB5pmBKK/hqjWrwLe9R8vXOZcU7SSIe7fweXSXeNGyG6MwsQkhcUSi
        Ajo/3Nl5KxMTCjUH+VlnP3sJwm1RL/R+RNjo
X-Google-Smtp-Source: AA0mqf4SmaDb4lO387aYWe0rXBTNfpvXxRKEku7j/uEo21rIs5ehQeoIBUyCuQnFX3p9liUSA2Ycxg==
X-Received: by 2002:a05:620a:14b8:b0:6ce:401d:f55d with SMTP id x24-20020a05620a14b800b006ce401df55dmr73961285qkj.538.1670272909589;
        Mon, 05 Dec 2022 12:41:49 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id u17-20020a05620a455100b006fa22f0494bsm13273594qkp.117.2022.12.05.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:41:49 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: remove level argument from btrfs_set_block_flags
Date:   Mon,  5 Dec 2022 15:41:47 -0500
Message-Id: <720307086390595732e0265afc5ffb2da80f632f.1670272901.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We just pass in btrfs_header_level(eb) for the level, and we're passing
in the eb already, so simply get the level from the eb inside of
btrfs_set_block_flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c       | 5 +----
 fs/btrfs/extent-tree.c | 7 +++----
 fs/btrfs/extent-tree.h | 2 +-
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7e756b44771b..5476d90a76ce 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -442,10 +442,7 @@ static noinline int update_ref_for_cow(struct btrfs_trans_handle *trans,
 				return ret;
 		}
 		if (new_flags != 0) {
-			int level = btrfs_header_level(buf);
-
-			ret = btrfs_set_disk_extent_flags(trans, buf,
-							  new_flags, level);
+			ret = btrfs_set_disk_extent_flags(trans, buf, new_flags);
 			if (ret)
 				return ret;
 		}
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b037107678c8..876bea67f9a1 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2175,10 +2175,10 @@ int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
 }
 
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				struct extent_buffer *eb, u64 flags,
-				int level)
+				struct extent_buffer *eb, u64 flags)
 {
 	struct btrfs_delayed_extent_op *extent_op;
+	int level = btrfs_header_level(eb);
 	int ret;
 
 	extent_op = btrfs_alloc_delayed_extent_op();
@@ -5195,8 +5195,7 @@ static noinline int walk_down_proc(struct btrfs_trans_handle *trans,
 		BUG_ON(ret); /* -ENOMEM */
 		ret = btrfs_dec_ref(trans, root, eb, 0);
 		BUG_ON(ret); /* -ENOMEM */
-		ret = btrfs_set_disk_extent_flags(trans, eb, flag,
-						  btrfs_header_level(eb));
+		ret = btrfs_set_disk_extent_flags(trans, eb, flag);
 		BUG_ON(ret); /* -ENOMEM */
 		wc->flags[level] |= flag;
 	}
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index ae5425253603..d8f738771b29 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -60,7 +60,7 @@ int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		  struct extent_buffer *buf, int full_backref);
 int btrfs_set_disk_extent_flags(struct btrfs_trans_handle *trans,
-				struct extent_buffer *eb, u64 flags, int level);
+				struct extent_buffer *eb, u64 flags);
 int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref);
 
 int btrfs_free_reserved_extent(struct btrfs_fs_info *fs_info,
-- 
2.26.3

