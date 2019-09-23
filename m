Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D87BB631
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2019 16:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407232AbfIWOFj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Sep 2019 10:05:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44073 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404990AbfIWOFj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Sep 2019 10:05:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id u40so17223701qth.11
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Sep 2019 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=K0YalnG0E5I4get1BlAgkpKl+SqY9spy+u3J8J04ioE=;
        b=M/OERklgKKcDhYzuA7qXMz65Bx7jThEpvJDF5BoK2gX9zyPblYatOvQaM8pB/H/+NF
         S8f7JMwwLCm7TS3bEaqEgD0vO3x8crPKw/m3161YXdVgIfk2ZK1HlV1EEF8ThDMjVyJH
         jtWj93jjhUvVP3W+Wztp1jNtIZzMhuw61GDGJS1wmpPc5g1jSsAeYnEYT/ikYslMk3ou
         MvJ/mCWoYJJvk+rE9Ghoq0yAy8lrQ5qiu/eyA6QG36qvFCUc8QQtpLcpXQM1MZA/iMhb
         G3QVOx2kMerXv6SkZuc5ALygVA3b8PvNrJu9MnO5BIASBZJuljOLy7rFz3pmK3nTVsTG
         ubrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0YalnG0E5I4get1BlAgkpKl+SqY9spy+u3J8J04ioE=;
        b=ABV2GIRB01EG37s2WKPn/uLBBcP50DFzV2UR70xhCx3KuNo9oTJboo1ApyaaS3s02H
         KmkAc4jrOmgPPVakejYaunp30SfbypV4M65rFpo+0p/0V86sBJQ81DgoxzxgwlBZzqol
         NZn25mi4lpgjWhWdrC7LhL3lxitULq9S8t31XfUgCeO3MAhyW1uO8RjRbtfQI6dOPQ2y
         rimeT170hZYdp+DoxBgJxxUsfgiW2aInjV1Myph4HoaJnRMQkt94M/N8+U6gmB1sgSO7
         TqzGDV8GeOUdtCgaRUKNjwKNY6nImp1FRxU2cpokpuZabvyAmstgodwS0oEO/GBRXPIV
         3OwA==
X-Gm-Message-State: APjAAAXuI4gopwPEyGLTCtuIgRuzc8ckGKhbahZcRPBj8p9GLe0Tr6+I
        CY2n+eEni7CQuVgaYSP5hyK9uP4A6tr5aw==
X-Google-Smtp-Source: APXvYqy+20jeS3O7ETY8pR46RsCB7eblg6fUmTl6wBIYluEuVZ6x5cd7d/Orr9O+3HsRrnV1owKtwg==
X-Received: by 2002:aed:30ce:: with SMTP id 72mr53055qtf.27.1569247536432;
        Mon, 23 Sep 2019 07:05:36 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g194sm5638237qke.46.2019.09.23.07.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 07:05:35 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/9] btrfs: export find_delalloc_range
Date:   Mon, 23 Sep 2019 10:05:20 -0400
Message-Id: <20190923140525.14246-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190923140525.14246-1-josef@toxicpanda.com>
References: <20190923140525.14246-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This utilizes internal stuff to the extent_io_tree, so we need to export
it before we move it.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.h |  3 +++
 fs/btrfs/extent_io.c      | 10 +++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 6f53387445ca..02fbb0d4fa88 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -223,5 +223,8 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 				 u64 *start_ret, u64 *end_ret, unsigned bits);
 int extent_invalidatepage(struct extent_io_tree *tree,
 			  struct page *page, unsigned long offset);
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state);
 
 #endif /* BTRFS_EXTENT_IO_TREE_H */
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 577b920ed4b9..690e1ac0b54d 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1688,9 +1688,9 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
  *
  * true is returned if we find something, false if nothing was in the tree
  */
-static noinline bool find_delalloc_range(struct extent_io_tree *tree,
-					u64 *start, u64 *end, u64 max_bytes,
-					struct extent_state **cached_state)
+bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *start,
+			       u64 *end, u64 max_bytes,
+			       struct extent_state **cached_state)
 {
 	struct rb_node *node;
 	struct extent_state *state;
@@ -1808,8 +1808,8 @@ noinline_for_stack bool find_lock_delalloc_range(struct inode *inode,
 	/* step one, find a bunch of delalloc bytes starting at start */
 	delalloc_start = *start;
 	delalloc_end = 0;
-	found = find_delalloc_range(tree, &delalloc_start, &delalloc_end,
-				    max_bytes, &cached_state);
+	found = btrfs_find_delalloc_range(tree, &delalloc_start, &delalloc_end,
+					  max_bytes, &cached_state);
 	if (!found || delalloc_end <= *start) {
 		*start = delalloc_start;
 		*end = delalloc_end;
-- 
2.21.0

