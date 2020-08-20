Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8C924C271
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Aug 2020 17:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbgHTPqs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Aug 2020 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbgHTPqf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Aug 2020 11:46:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AB0C061342
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t23so1509665qto.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Aug 2020 08:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=26LVHM657WspHmm+joVxq43rrC/e8jj0gG4dsGesC0k=;
        b=PIlqh6InLkNnzK0KAJ1OlFJ0+m0cq8cY54ewqyoNt+As4bMuUwL19PLqJLgiO0i5w4
         ZfnruPUkU1WhcXAXvtp/fSyVFMYfke1yfM569ypOEPrb90i43lA0SpAukA2h+qcg4AmM
         mWCrmTiH4esbBgfVrh5uMjy8zQQWVqYxr/VacIT5cVTUlVLDIib+QEHkGtdUHiz8zmoi
         nLx6ZAnwXmrSEpCRsKmQ4gPBrx27h7meRpkj2GqhisH7Tc4YCAWulFgLemkN6UID8w98
         /VeEuH1/u7TOaSqzhb1gUEfsa8xYlEi7675dGWsALmXV+fQLdc4CFsXe/627mVZAfL8k
         WglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26LVHM657WspHmm+joVxq43rrC/e8jj0gG4dsGesC0k=;
        b=c83DF9vYah4pboKfp1bx2z5fVwy0AMCdwMwVQS+Rdy4rWYwQ/qEe0Ucesm/ZqPJH4t
         HtfzeUPqRIsbjXR5B5ijxe+77u0XB1BiavuTHP/7rVRYsbGfr3CX+q+nI4Pgo/VepzYw
         cloyRNQg4eaiTrteJTN/i8O7/mbD7yITckg3sgtnoT5fpzPfdAmUWE6xPTD03YHaDU/r
         q3YkMi6yMb69g5DmpcSH8Hgq+qVREsn6nfF7lR4WnZ1xiiu5sm4v6OjsN2etoQP/9e9J
         +pcII/eZPmVrUCKp1608W/Hmhk4oFWFWAf2FEhlm1aH6KC+3Vy21aiEWnNw1C3Y3qQfW
         ho2Q==
X-Gm-Message-State: AOAM533MrfR8U6gQp7lQg5ZYf/4RK84Rj9jt+Qvl1qtBnrH2xvU1q0TM
        Ao9vTI+0MfqXYzj7cejrQHycaRdJ9xQniBZX
X-Google-Smtp-Source: ABdhPJyfsVVQd+v5gT9dHfPHeWZIoUqhSYaBiyA2crp6NB2qcmhB9m9LmwXbG2Es24jrLQFET1xe/w==
X-Received: by 2002:ac8:3894:: with SMTP id f20mr3233303qtc.243.1597938388363;
        Thu, 20 Aug 2020 08:46:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i14sm3244701qtq.33.2020.08.20.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:46:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/12] btrfs: introduce BTRFS_NESTING_SPLIT for split blocks
Date:   Thu, 20 Aug 2020 11:46:06 -0400
Message-Id: <873113d522b5b1183a4805e1140114b64174cf00.1597938191.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1597938190.git.josef@toxicpanda.com>
References: <cover.1597938190.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we are splitting a leaf/node, we could do something like the
following

lock(leaf)  BTRFS_NESTING_NORMAL
  lock(left) BTRFS_NESTING_LEFT + BTRFS_NESTING_COW
    push from leaf -> left
      reset path to point to left
        split left
          allocate new block, lock block BTRFS_NESTING_SPLIT

at the new block point we need to have a different nesting level,
because we have already used either BTRFS_NESTING_LEFT or
BTRFS_NESTING_RIGHT when pushing items from the original leaf into the
adjacent leaves.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c   | 4 ++--
 fs/btrfs/locking.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index ae5e3f1056d8..4b62acac31b6 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3473,7 +3473,7 @@ static noinline int split_node(struct btrfs_trans_handle *trans,
 	btrfs_node_key(c, &disk_key, mid);
 
 	split = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, level,
-					     c->start, 0, BTRFS_NESTING_NORMAL);
+					     c->start, 0, BTRFS_NESTING_SPLIT);
 	if (IS_ERR(split))
 		return PTR_ERR(split);
 
@@ -4250,7 +4250,7 @@ static noinline int split_leaf(struct btrfs_trans_handle *trans,
 		btrfs_item_key(l, &disk_key, mid);
 
 	right = alloc_tree_block_no_bg_flush(trans, root, 0, &disk_key, 0,
-					     l->start, 0, BTRFS_NESTING_NORMAL);
+					     l->start, 0, BTRFS_NESTING_SPLIT);
 	if (IS_ERR(right))
 		return PTR_ERR(right);
 
diff --git a/fs/btrfs/locking.h b/fs/btrfs/locking.h
index a88c6f59f616..3b5a948bf74f 100644
--- a/fs/btrfs/locking.h
+++ b/fs/btrfs/locking.h
@@ -47,6 +47,15 @@ enum btrfs_lock_nesting {
 	BTRFS_NESTING_LEFT_COW,
 	BTRFS_NESTING_RIGHT_COW,
 
+	/*
+	 * When splitting we may push nodes to the left or right, but still use
+	 * the subsequent nodes in our path, keeping our locks on those adjacent
+	 * blocks.  Thus when we go to allocate a new split block we've already
+	 * used up all of our available subclasses, so this subclass exists to
+	 * handle this case where we need to allocate a new split block.
+	 */
+	BTRFS_NESTING_SPLIT,
+
 	/*
 	 * We are limited to MAX_LOCKDEP_SUBLCLASSES number of subclasses, so
 	 * add this in here and add a static_assert to keep us from going over
-- 
2.24.1

