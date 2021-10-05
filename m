Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C8442321F
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbhJEUhX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 16:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhJEUhW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 16:37:22 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFBC061749
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Oct 2021 13:35:31 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id q125so250748qkd.12
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Oct 2021 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/BrKgLK8wOn0hJtu/faEZP/OgK8xISsX40TWC2B9UaI=;
        b=JA9osPw7U4exjWQkq+dS9De9LQeDGc9pxwn8aEKafpBWXhQxKeaxQUvj52sE6Q28xf
         yoerDr1h9/0SA4Mle1YYs2st+xFZZMa/yauTpuNAJWOsDy39p9zWk5Z/Ee66oD82GQUm
         LpsnBCAbc9aMRkFVXX7+ri5XMcQWE5ji1QtOO+RZgQcXIDl4EkrodBBD33TVMFDdyYji
         /7NR+ATK8CM3Lv4BoKJpLDkHJWAO1J4CPDext0eSPM5405QXyAwevqpFwZjWT+OzH7fS
         RnHMaghDMEF0piRlsstZMVltmr1nHQHbjFErU9ne8GE+6U3d+7hO6+U2WTcWxvVywLOw
         lgng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/BrKgLK8wOn0hJtu/faEZP/OgK8xISsX40TWC2B9UaI=;
        b=LAl9bjIaAOfpQtMrAYXUllHLgf8BKla63bFqDP/l7GeNRZN3Q16eutiCe+H0IbQYO5
         5RDGosaZQpyojJ/soyZ0q5V9gn65DKet50XjR52VUrYxVh6kef/8Gner5Nxy6NlvITcy
         fOLXO3DOQI+eegPrA9qdj6n/sqZ5efsoe2YyaWJbyj+BnwRexnwA1k7We1/rYr+AT46t
         DwdAGFEtOFgNSXrSm60N5gfewTXQxasxdZO+rHpW2ljmagHYRSE4K+n9zPRyclVW2LTc
         6OiAexLhUaJjBphtUNE2dSxkc1YFeLV000PdY3/Gw3bxyFy2VMLLz6zl5dUKTuPbPGha
         ylFQ==
X-Gm-Message-State: AOAM531JNBFl76kQj147yvwITccevXlmbaxsCqHm1AaXNRIGs294olRI
        nB9o/RF9XpAdbUjpy4CMqdhJqL9zColThQ==
X-Google-Smtp-Source: ABdhPJzU8vMNanLUXDfvCs/jEQYWYn88qWxALYWCbsMWk8O9CQYyFmnrAThGBCeeXDu0tYuZJBtjnQ==
X-Received: by 2002:a37:b1c1:: with SMTP id a184mr16570577qkf.177.1633466130360;
        Tue, 05 Oct 2021 13:35:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p1sm10139075qkm.85.2021.10.05.13.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 13:35:29 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 1/5] btrfs: change handle_fs_error in recover_log_trees to aborts
Date:   Tue,  5 Oct 2021 16:35:23 -0400
Message-Id: <a6731fa8b656e59f6799445b28764bb6a07d35e5.1633465964.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1633465964.git.josef@toxicpanda.com>
References: <cover.1633465964.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

During inspection of the return path for replay I noticed that we don't
actually abort the transaction if we get a failure during replay.  This
isn't a problem necessarily, as we properly return the error and will
fail to mount.  However we still leave this dangling transaction that
could conceivably be committed without thinking there was an error.
We were using btrfs_handle_fs_error() here, but that pre-dates the
transaction abort code.  Simply replace the btrfs_handle_fs_error()
calls with transaction aborts, so we still know where exactly things
went wrong, and add a few in some other un-handled error cases.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index b765ca7536fe..7a7fe0d74c35 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6531,8 +6531,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 	ret = walk_log_tree(trans, log_root_tree, &wc);
 	if (ret) {
-		btrfs_handle_fs_error(fs_info, ret,
-			"Failed to pin buffers while recovering log root tree.");
+		btrfs_abort_transaction(trans, ret);
 		goto error;
 	}
 
@@ -6545,8 +6544,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
 
 		if (ret < 0) {
-			btrfs_handle_fs_error(fs_info, ret,
-				    "Couldn't find tree log root.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 		if (ret > 0) {
@@ -6563,8 +6561,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		log = btrfs_read_tree_root(log_root_tree, &found_key);
 		if (IS_ERR(log)) {
 			ret = PTR_ERR(log);
-			btrfs_handle_fs_error(fs_info, ret,
-				    "Couldn't read tree log root.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 
@@ -6592,8 +6589,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 			if (!ret)
 				goto next;
-			btrfs_handle_fs_error(fs_info, ret,
-				"Couldn't read target root for tree log recovery.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 
@@ -6601,14 +6597,15 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		ret = btrfs_record_root_in_trans(trans, wc.replay_dest);
 		if (ret)
 			/* The loop needs to continue due to the root refs */
-			btrfs_handle_fs_error(fs_info, ret,
-				"failed to record the log root in transaction");
+			btrfs_abort_transaction(trans, ret);
 		else
 			ret = walk_log_tree(trans, log, &wc);
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
 			ret = fixup_inode_link_counts(trans, wc.replay_dest,
 						      path);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 
 		if (!ret && wc.stage == LOG_WALK_REPLAY_ALL) {
@@ -6625,6 +6622,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * could only happen during mount.
 			 */
 			ret = btrfs_init_root_free_objectid(root);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 
 		wc.replay_dest->log_root = NULL;
-- 
2.26.3

