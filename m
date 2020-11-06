Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1342A9F10
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 22:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgKFV1p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 16:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgKFV1p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Nov 2020 16:27:45 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545D6C0613CF
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Nov 2020 13:27:45 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id t191so1277578qka.4
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Nov 2020 13:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sdumzIifAXaYPWzYWrgeekonCZUiyf4MiN4PXutdyKg=;
        b=MLsyCQwgJPGhQJKhd0VV9DZHvn/TeKDqzi4OZl0QgiOq9yP50AdTNnXpw9i5YI1cvi
         j3Tu0x9CWV4gE4hC2zVvhx7rPjzEiPZoDfh4qjamTZ5S0o0iy6ej85/kqfByO+8oJ6Cd
         V/pokCUYtDcCIFoSrZt1dw1ZbS0/OwoDzfKX8SIaIbc4Aab6vMIeTC2jasfLpmyVS6gs
         Sf7bGv2gT7bj3ZJ66YP2loE7RUepHV5sA+B18UStUSlDjUvXuY/8Pc7rOpz4DDMgJk4L
         lovyFgPLVXF/GxjXnOtXN+weTWR1LfOEGG3xtwY9MJsmFKNTt2ixg+w9jcD/+Jgb9/Eg
         0LoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdumzIifAXaYPWzYWrgeekonCZUiyf4MiN4PXutdyKg=;
        b=Gk37dSCU2JxGHdHmu0xwuDDOFxcwgwYlbW+0OZPagE55COHyGnscJ9sPkorj70OC8v
         j9jndeSFBDE8ymKTx4WeRq57bir4pHF3ke1NSII7wlpwJdi2810A+KPPcv8xLu1BIhG0
         YIb1s9M762PM75/uyKhwVf1nSPL/e4FlJZE77QzsrAbjqLWJiLFIxv2wgaWDDUAFaLZM
         sFgxRIggK9ms1oNtQI+Jhm7A4IvKzbwLeVoxYWJCYY2LRw12HgbRdf5T3qGgL4yGFPA/
         ZNdlbhhTMSPf+tRRFAMjiZhNNNvvOg4CJ3U24oWQgErhqbiUTxVY6CtsYROOT1E5t5xy
         rxJA==
X-Gm-Message-State: AOAM530l/dmQ0spudUeAWuXWL/NZ2uh+nUXWGvYZfjkIt2x1LLQ4FXhu
        VgE7W3kVG2nDRqOMEYPiepHepg1LbsP0NI0a
X-Google-Smtp-Source: ABdhPJyT/NQOjTg6h7vT/q6e3ZHiSq8MUTMfNF/1nvpuDkMJMwPpXJek2b0XQ1XDFOhZ9k2UXegr+A==
X-Received: by 2002:a37:4f45:: with SMTP id d66mr3674341qkb.396.1604698064283;
        Fri, 06 Nov 2020 13:27:44 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i192sm1102636qke.73.2020.11.06.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:27:43 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/8] btrfs: kill path->recurse
Date:   Fri,  6 Nov 2020 16:27:31 -0500
Message-Id: <589c1ff532c06d75b9c7c74d03c48467aef3e394.1604697895.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604697895.git.josef@toxicpanda.com>
References: <cover.1604697895.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With my async free space cache loading patches we no longer have a user
of path->recurse.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.c | 4 ++--
 fs/btrfs/ctree.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index dcd17f7167d1..cdd86ced917a 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2588,7 +2588,7 @@ static struct extent_buffer *btrfs_search_slot_get_root(struct btrfs_root *root,
 		 * We don't know the level of the root node until we actually
 		 * have it read locked
 		 */
-		b = __btrfs_read_lock_root_node(root, p->recurse);
+		b = __btrfs_read_lock_root_node(root, 0);
 		level = btrfs_header_level(b);
 		if (level > write_lock_level)
 			goto out;
@@ -2858,7 +2858,7 @@ int btrfs_search_slot(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 				p->locks[level] = BTRFS_WRITE_LOCK;
 			} else {
 				__btrfs_tree_read_lock(b, BTRFS_NESTING_NORMAL,
-						       p->recurse);
+						       0);
 				p->locks[level] = BTRFS_READ_LOCK;
 			}
 			p->nodes[level] = b;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index dc5d36aa4d28..4442e872d873 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -374,7 +374,6 @@ struct btrfs_path {
 	unsigned int search_commit_root:1;
 	unsigned int need_commit_sem:1;
 	unsigned int skip_release_on_error:1;
-	unsigned int recurse:1;
 };
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
-- 
2.26.2

