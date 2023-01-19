Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C52E6745A8
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Jan 2023 23:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjASWOg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Jan 2023 17:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjASWNy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Jan 2023 17:13:54 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3D951B6
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:41 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id g10so2487645qvo.6
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Jan 2023 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJjFPZ3bVjCi1soL/NYCpPC55azD6NczF2opwl7HCRI=;
        b=KkCr3McdrfypZSZDebXvKzosbLHEwo040RQJhl6LjrR5z/tBQhFsDDsY60tn67ksMg
         J+i/p/OOOypE9E6Od7FXMiQO0CG+HZ3ciC+uXIzVoOKeX5fh7vc7M4jCg0YKkadbGM3X
         S79Eh2aFzR9BLU72+gPtIe9B69FnViPx7e2thSVw2L+ZDiYacENCPSY0q+aFHoXRi6ig
         7pzlSLSCxv7sCUb2ifR+m5ZTIA+xXD6iB9Q12PcE2r2nAGNtuxfYPOS5ECZmEls/+Jbl
         14q4cLQN/FrR/QKwK9QLguXtnpCjjLa3Hp4KTfuLs7khJU1JGaa7a7s5aBnceS6wd0hY
         UIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJjFPZ3bVjCi1soL/NYCpPC55azD6NczF2opwl7HCRI=;
        b=cHZynZ6A6UkSwcN83TZJV86zuOuhbJL7Zpk/UGCECIfJo+1MDP4mYzeeqSPx6FgV5I
         o5NLkSdm43ceVI9lL3EHQypUlpOz9aVE034i00BR9Oo2XduT5JZZMEQdsRsJnKn4DqR+
         xc6ZirB6hjP4S5iI+wIVR9eqOptitYYf+7/IDs9O6jC4ec1QAyjuougsbKin3ecdYnhb
         oGq4UllPfbX5GUNxtp5RyWC1tq0/knE7ZPdWXZkxx31P/jZ3RRFqMamILkdVxcME7mix
         zd+p8l7KZQyHZXR7T2u8oLe/wL5fWdoWvKTYA/Yody7Pc3IlbcY355Z6iZlrpdb7jUIZ
         UbOw==
X-Gm-Message-State: AFqh2kqkKOZUVW1jWKtVh18bM661eeVWEjarrVzYqRyKpHzHqA47pGw7
        oNpIcLAWrPpimLL3vu4qqhghUnYPTJpLqi1XN+0=
X-Google-Smtp-Source: AMrXdXvQ5VNvmxLCVY4K+0aJgdgiSaFdu18F56Jf5J81tBLJnqnrx4rq906kOBusF4ID6gVdj0z5AQ==
X-Received: by 2002:a05:6214:e8e:b0:4ed:fb72:9186 with SMTP id hf14-20020a0562140e8e00b004edfb729186mr27601353qvb.0.1674165219814;
        Thu, 19 Jan 2023 13:53:39 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s11-20020a05620a0bcb00b00704a9942708sm24879370qki.73.2023.01.19.13.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 13:53:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 9/9] btrfs: remove btrfs_wait_tree_block_writeback
Date:   Thu, 19 Jan 2023 16:53:25 -0500
Message-Id: <75b7365de4d9dbf20684aa110537c7eb8cf87436.1674164991.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1674164991.git.josef@toxicpanda.com>
References: <cover.1674164991.git.josef@toxicpanda.com>
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

This is used in the tree-log code and is a holdover from previous
iterations of extent buffer writeback.  We can simply use
wait_on_extent_buffer_writeback here, and remove
btrfs_wait_tree_block_writeback completely.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 15695f505f05..15f8130d812c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -278,12 +278,6 @@ void btrfs_end_log_trans(struct btrfs_root *root)
 	}
 }
 
-static void btrfs_wait_tree_block_writeback(struct extent_buffer *buf)
-{
-	filemap_fdatawait_range(buf->pages[0]->mapping,
-			        buf->start, buf->start + buf->len - 1);
-}
-
 /*
  * the walk control struct is used to pass state down the chain when
  * processing the log tree.  The stage field tells us which part
@@ -2637,7 +2631,7 @@ static noinline int walk_down_log_tree(struct btrfs_trans_handle *trans,
 
 				btrfs_tree_lock(next);
 				btrfs_clear_buffer_dirty(next);
-				btrfs_wait_tree_block_writeback(next);
+				wait_on_extent_buffer_writeback(next);
 				btrfs_tree_unlock(next);
 
 				if (trans) {
@@ -2706,7 +2700,7 @@ static noinline int walk_up_log_tree(struct btrfs_trans_handle *trans,
 
 				btrfs_tree_lock(next);
 				btrfs_clear_buffer_dirty(next);
-				btrfs_wait_tree_block_writeback(next);
+				wait_on_extent_buffer_writeback(next);
 				btrfs_tree_unlock(next);
 
 				if (trans) {
@@ -2787,7 +2781,7 @@ static int walk_log_tree(struct btrfs_trans_handle *trans,
 
 			btrfs_tree_lock(next);
 			btrfs_clear_buffer_dirty(next);
-			btrfs_wait_tree_block_writeback(next);
+			wait_on_extent_buffer_writeback(next);
 			btrfs_tree_unlock(next);
 
 			if (trans) {
-- 
2.26.3

