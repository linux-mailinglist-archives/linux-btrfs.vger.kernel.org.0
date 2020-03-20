Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30DDF18D71B
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Mar 2020 19:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCTSex (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Mar 2020 14:34:53 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46219 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgCTSev (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Mar 2020 14:34:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id f28so7883723qkk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 20 Mar 2020 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xsKC/anFkYuYOWA5UMR4laIRFLCLxyCZrlkzn2PCzQE=;
        b=U7wj3X9xvlNgKqxv2wWd13NyOHu3URh9vnuBMZz0+DSpmFpaR1fBzWtRmzX3RjD2M1
         Wx0OzPrC+5a/A5OwAe18cg0ARDcT68w3nykn7ex8oKxwRRLuV4YJ9IW+aqqxznw3ImCo
         pBwB+W8ZC/jW2HGfVgFXeF8YqrNoY6E3CK2LwE/UUwbW08Li0WxwxWbGvDzvqa+BlOjM
         7+lEd+ecfp6Hkqtu9b8Z9NFu6WTP1uWeQoQ9Ej5A8rj50/axkUeh71aooigj71klap3N
         RTgnAvknbJcaJdX7WP48qaQE8nP4ST6+5DMQvpKR1fRM7SZZhnrgs1y6d/XRCHuIATAO
         ysOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsKC/anFkYuYOWA5UMR4laIRFLCLxyCZrlkzn2PCzQE=;
        b=mHUdoFwVf23sm54AWe2yxDTQGFT2PN2NJPBBcUBYb3zoJHw9UAhy5XjDqsi9BLk2It
         9OcHHNZC0iOYvB1QDXNP4XyCgwLTT0fnAHrHmDFJKb/1MrlGXBV5sDQg4FgkpQ2zF9qA
         ga+vr23L1vKhdRJOeZZfY/lRNeltV1rClPtaamsW7UBeUVNgGZHj2Jtrx0LayIWYtDgN
         TebBRpuu7wF7J7VNW9ndNB3ShZVdi7NJ5a5esS472fcXKSYEedvri0RCFUWD8jiqBVPZ
         xjV5rhAPw+I/CalJRq6QJYJgDe1ql2mJ37HKkJGdK3N13jGvrPeQzDEcmvR8qqBfma5E
         A7Ng==
X-Gm-Message-State: ANhLgQ1fEbU5bS6DaX66prpGv8pqncj0ym5PhXi97lMp92c1YmEPocaK
        YzYdnOf2IFCdxUhFMS8vbx13HkiIATIIYg==
X-Google-Smtp-Source: ADFU+vtufuCYPbKvh8Pw/h8bneAh1p18wpKwHJEco0dtX5aiZkVWqm6zLlwS1dqFJjD6euWSt9G/nA==
X-Received: by 2002:a37:67c1:: with SMTP id b184mr9716372qkc.307.1584729289252;
        Fri, 20 Mar 2020 11:34:49 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id t123sm4761560qkc.81.2020.03.20.11.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 11:34:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: restart snapshot delete if we have to end the transaction
Date:   Fri, 20 Mar 2020 14:34:36 -0400
Message-Id: <20200320183436.16908-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200320183436.16908-1-josef@toxicpanda.com>
References: <20200320183436.16908-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is to fully fix the deadlock described in

btrfs: do not resolve backrefs for roots that are being deleted

Holding write locks on our deleted snapshot across trans handles will
just lead to sadness, and our backref lookup code is going to want to
still process dropped snapshots for things like qgroup accounting.

Fix this by simply dropping our path before we restart our transaction,
and picking back up from our drop_progress key.  This is less efficient
obviously, but it also doesn't deadlock, so it feels like a reasonable
trade off.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2925b3ad77a1..bfb413747283 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5257,6 +5257,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 	 * already dropped.
 	 */
 	set_bit(BTRFS_ROOT_DELETING, &root->state);
+again:
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_header_level(root->node);
 		path->nodes[level] = btrfs_lock_root_node(root);
@@ -5269,7 +5270,9 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 		btrfs_disk_key_to_cpu(&key, &root_item->drop_progress);
 		memcpy(&wc->update_progress, &key,
 		       sizeof(wc->update_progress));
+		memcpy(&wc->drop_progress, &key, sizeof(key));
 
+		wc->drop_level = root_item->drop_level;
 		level = root_item->drop_level;
 		BUG_ON(level == 0);
 		path->lowest_level = level;
@@ -5362,6 +5365,18 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 				goto out_end_trans;
 			}
 
+			/*
+			 * We used to keep the path open until we completed the
+			 * snapshot delete.  However this can deadlock with
+			 * things like backref walking that may want to resolve
+			 * references that still point to this deleted root.  We
+			 * already have the ability to restart snapshot
+			 * deletions on mount, so just clear our walk_control,
+			 * drop the path, and go to the beginning and re-lookup
+			 * our drop_progress key and continue from there.
+			 */
+			memset(wc, 0, sizeof(*wc));
+			btrfs_release_path(path);
 			btrfs_end_transaction_throttle(trans);
 			if (!for_reloc && btrfs_need_cleaner_sleep(fs_info)) {
 				btrfs_debug(fs_info,
@@ -5377,6 +5392,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 			}
 			if (block_rsv)
 				trans->block_rsv = block_rsv;
+			goto again;
 		}
 	}
 	btrfs_release_path(path);
-- 
2.24.1

