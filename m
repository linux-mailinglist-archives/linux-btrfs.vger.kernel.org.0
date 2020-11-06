Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762A82A9F0E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgKFV1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgKFV1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:42 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D53EC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:41 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id s14so2452330qkg.11
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/xPqdmywdSw+4/hmcBlHBvh9fxTE50s2dEB3HEMBmeY=;
        b=ANhhyft9h/m8mzfktzAPruvdM4MO2gyZnB19edRrfGxHhFiCtf0EXUj2nxe4F8d2dE
         8guwMhwKMmVCx0962gL5rXuHH6stkp+5QoO2bMGBGbEObSNYK8+Wgdh3908Jlye7cJD+
         oZA7BwgSwHjnOOzU76Ttd2HCTZ5KqtRmQYik7lzdXhUbqYwsalJ+ZJUWLrKLipBvropl
         kPhTTUTv2/gdo5NWYRvs1wvFl2a9/zZGVnKAzm9qqeHIAuPYA4ZQLzleU1rLkHa45PzW
         DooE2yLwvH0+XmPaNyY26srRnp0qVucWHRwhHyNC6FUK1JY/LQ/yM75Tnm897FpGuCtx
         2y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/xPqdmywdSw+4/hmcBlHBvh9fxTE50s2dEB3HEMBmeY=;
        b=f/yHKcfT4g338T62H/grAKaRafeeDhGKnqwfoZwuVGZiI+zXhxB5jkINXsBryMQ1vT
         nOs4UhbZQVB1UONaUa9t7UMAF1t79IVowUjWrh/c7RGHxGmOQZpYZZXvaJ/BvNYOJvFy
         k9fs3Y1pC/BsG6fizzPMQbOgZkZfbnDku1fJ3UfAxgzcIGF+tXMEH9JoXAS6cL6kstBp
         LiqUXklLW2k+XwSlu6b4G5BGWTQFecVg6/OaJHxfQBn9GEmxvbjTXs90OTUQVbiOK6Ir
         Im57tgpfck4M1U7Y+d8YYcCzIDKGT+jMKqHqRE5QZKdbk7Dy1+ObM3KtpmJ7IV+9P0fR
         jDOA==
X-Gm-Message-State: AOAM5305sOtMkzbQPmEk+6KQS4lVRYqvBhTSG7yPsmeaaMurtH1AiMSr
        1aEXhkBR/qA4fB3Ni0ElV7ZS9zo9x6PJaQfK
X-Google-Smtp-Source: ABdhPJyMQs5tXe3zpUckhLJbXKY2toZjKwND5d4wx2t2l9Q3xjuduEztYdIWcqVg+3BQDYJyQeRdgw==
X-Received: by 2002:a37:7345:: with SMTP id o66mr3707092qkc.222.1604698060493;
        Fri, 06 Nov 2020 13:27:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d73sm1438094qkb.8.2020.11.06.13.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/8] btrfs: cleanup the locking in btrfs_next_old_leaf
Date:   Fri,  6 Nov 2020 16:27:29 -0500
Message-Id: <74fe63263c2d9e7ffd6c0cef2a2f9ce893989638.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are carrying around this next_rw_lock from when we would do spinning
vs blocking read locks.  Now that we have the rwsem locking we can
simply use the read lock flag unconditionally and the read lock helpers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d2d5854d51a7..3a01e6e048c0 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -5327,7 +5327,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 	struct btrfs_key key;
 	u32 nritems;
 	int ret;
-	int next_rw_lock = 0;
 
 	nritems = btrfs_header_nritems(path->nodes[0]);
 	if (nritems == 0)
@@ -5337,7 +5336,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 again:
 	level = 1;
 	next = NULL;
-	next_rw_lock = 0;
 	btrfs_release_path(path);
 
 	path->keep_locks = 1;
@@ -5401,12 +5399,11 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		}
 
 		if (next) {
-			btrfs_tree_unlock_rw(next, next_rw_lock);
+			btrfs_tree_read_unlock(next);
 			free_extent_buffer(next);
 		}
 
 		next = c;
-		next_rw_lock = path->locks[level];
 		ret = read_block_for_search(root, path, &next, level,
 					    slot, &key);
 		if (ret == -EAGAIN)
@@ -5437,7 +5434,6 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 						       BTRFS_NESTING_RIGHT,
 						       path->recurse);
 			}
-			next_rw_lock = BTRFS_READ_LOCK;
 		}
 		break;
 	}
@@ -5446,13 +5442,13 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 		level--;
 		c = path->nodes[level];
 		if (path->locks[level])
-			btrfs_tree_unlock_rw(c, path->locks[level]);
+			btrfs_tree_read_unlock(c);
 
 		free_extent_buffer(c);
 		path->nodes[level] = next;
 		path->slots[level] = 0;
 		if (!path->skip_locking)
-			path->locks[level] = next_rw_lock;
+			path->locks[level] = BTRFS_READ_LOCK;
 		if (!level)
 			break;
 
@@ -5466,11 +5462,9 @@ int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			goto done;
 		}
 
-		if (!path->skip_locking) {
+		if (!path->skip_locking)
 			__btrfs_tree_read_lock(next, BTRFS_NESTING_RIGHT,
 					       path->recurse);
-			next_rw_lock = BTRFS_READ_LOCK;
-		}
 	}
 	ret = 0;
 done:
-- 
2.26.2

