Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC1419DC9
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 20:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbhI0SG5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhI0SG4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 14:06:56 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85590C061575
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r1so17441448qta.12
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QtogRrVq3vXzSD+4o74FGhm0GYNF2lRVr3ezibxXP90=;
        b=FihfNDmCmYoG4++vjKTuaCG4nDuVy+zx1s9a+boG3wni0IEOSf9F4/Ql4yGea3L0kb
         3+4hwdGXepgUEswj6Gg/3mZB1ML3T7bgCg82ZXqlX/WyDFVlXj+TB74pityB9jrHiu5q
         Z7f8BaxYbIkjOSHyS4cQ1zwEK+10BRnkoW77f8BD3oshx+IGp2hF0JyzhV2DO+c1tmYh
         EWD4R9U+P0G8hH5LQSpDyJdVnODoAzdPdPzGcXzOpFMoh7WsRSXD8pGOCo85BZ40Ywjg
         gjLJmEC2DZSaX7saLZptbq84Uf7CjJ3tfoenvzgJ9u5PgeU6IiSlsRV/JBc/6LXXpBzY
         R7ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QtogRrVq3vXzSD+4o74FGhm0GYNF2lRVr3ezibxXP90=;
        b=ttfAWaTlIt5zcji2uU7U6bRrfEeY4xz2KUZLOxWJdp4hE1KMnJS01H2S4F4HPMWd3d
         u1QYHqo3XwElX2P7eDVuf5B8QXfv8vwP0UkzKDoqWyB4jYdeLo04sCrbWjWpEOIXEO7F
         UOdd4zkIEOcwP2KYLsaIhfAu7MQX42U2EMI68blnSLlpmVdB8qO125ygE81qbritTjBi
         CifIybnvT4GUwOQJ29Z2RxA2EHV3H12iujTbIEpNoh6xQkMp+d51Pi/5iMv+Qa7RKjhS
         aVH5IEr79/RgAdWzNkAnt/OsaH1RYWjAGR1r7fTFPpD10mXC1sreJBz92niSQkiQnmLa
         c/FQ==
X-Gm-Message-State: AOAM532wkrRSTERYlyABAou5QSgVvnlQc/F0pytgF7X6EHEppcCE+e77
        2vNz8a8+4024t67IDAMWYD9rI9zLqOjnyA==
X-Google-Smtp-Source: ABdhPJyrfBKjHjnC0/2egPihqzm9AgrE4calOz6TjTuLdoPEojtVR0RElW8+E4RGilyHFL76F0w7jw==
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr1244630qtj.68.1632765917442;
        Mon, 27 Sep 2021 11:05:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x9sm7861780qkm.102.2021.09.27.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:05:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 1/5] btrfs: change handle_fs_error in recover_log_trees to aborts
Date:   Mon, 27 Sep 2021 14:05:10 -0400
Message-Id: <5c30fe9cce106cf33e5d0b3ce74ff628a90724c3.1632765815.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1632765815.git.josef@toxicpanda.com>
References: <cover.1632765815.git.josef@toxicpanda.com>
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
 fs/btrfs/tree-log.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 30590ddd69ac..e0c2d4c7f939 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6527,8 +6527,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		ret = btrfs_search_slot(NULL, log_root_tree, &key, path, 0, 0);
 
 		if (ret < 0) {
-			btrfs_handle_fs_error(fs_info, ret,
-				    "Couldn't find tree log root.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 		if (ret > 0) {
@@ -6545,8 +6544,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		log = btrfs_read_tree_root(log_root_tree, &found_key);
 		if (IS_ERR(log)) {
 			ret = PTR_ERR(log);
-			btrfs_handle_fs_error(fs_info, ret,
-				    "Couldn't read tree log root.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 
@@ -6574,8 +6572,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 
 			if (!ret)
 				goto next;
-			btrfs_handle_fs_error(fs_info, ret,
-				"Couldn't read target root for tree log recovery.");
+			btrfs_abort_transaction(trans, ret);
 			goto error;
 		}
 
@@ -6583,14 +6580,15 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
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
@@ -6607,6 +6605,8 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 			 * could only happen during mount.
 			 */
 			ret = btrfs_init_root_free_objectid(root);
+			if (ret)
+				btrfs_abort_transaction(trans, ret);
 		}
 
 		wc.replay_dest->log_root = NULL;
-- 
2.26.3

