Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389306F2666
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjD2UU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjD2UUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:20:25 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F31FF5
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:24 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-54f8e823e47so16268987b3.2
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682799624; x=1685391624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y/QpagkIvkCEHFlz06VLWpboPR5ZjwVdSRT9NuDo2r8=;
        b=CEDb+cGt/q5gdIEALvyUAC9Bg4tnt10J+kLrgNtxZjFZ0oYP0fyr/sNJBP4SoQ0jFD
         YxTd66Lf+8p5XGZi6VxKkDRjf7NozD/BBJPDyGvz3K/mHR+pKJLr5rBrth+wAglzvEzE
         P8BZv8sB1WFYbHSsgNVTnyXXCigFRW0WcL+C7KTtEKytZbDDGRHZTa3RxwtuCYf19M2U
         R3IauSSe4TpeE/pvvyFTda6CGYv+9uLIkK0ldDJc6h4W2U5fjYeuZshFqLJ7U86IsYej
         hnHeGWgMWowmWkGmQczD3+5eariUpxX1x48O+Vjt9XrW1maaqMXcJ1UmepT+I5Ah1WGx
         H/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682799624; x=1685391624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y/QpagkIvkCEHFlz06VLWpboPR5ZjwVdSRT9NuDo2r8=;
        b=OlYqC7ec0lNd1ep6gm0hPyLmwHrkORzqeuEBYh0Dz7Yl3chmr2dK7CH/8EFJ6JxHGl
         b9NP63ZW2e3n5SCdd0O9opvdj0lrLfiK5xr3YA0OZYYwZZNwB6UW4+bDaGzXH05W1Aqe
         UL/OPbYXmqCqI/ZjNUnmoNSljjXTYH6ZZByToXU54L60bQiaYA+dFrK5YKOsYfdxBymQ
         xGNlsXcaA+krYhEmXhKIMJaJq98Edy4RZ2UivGd2c7SmPLduIB0p0cLTQGCuHWdrZPFm
         EHFGwYr6PL7kKxAzfAgaHOdK2TUgWrOVhGKjiwZNeBOMVoOO0q6nc6AyZ/J3i4WoXV9y
         2Kfg==
X-Gm-Message-State: AC+VfDyury8tNxoDAcsJ/RV5r4P4C6vJNn/vrBNwLoSpy7CZmkUEcWgH
        UK71wDIX3RkmlbjwWp3nKKRI0fm8CzHM01nOeQT5oA==
X-Google-Smtp-Source: ACHHUZ40M3zYrEka2aaDWmZbOVRecCJZi5e/oJZDjmo52PpYVcR4AcUe/KImCWxpV/Fm+T9qWWXsPA==
X-Received: by 2002:a81:ab4b:0:b0:559:e235:5f65 with SMTP id d11-20020a81ab4b000000b00559e2355f65mr2534090ywk.37.1682799624085;
        Sat, 29 Apr 2023 13:20:24 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t192-20020a8183c9000000b00552f3887d16sm6232314ywf.22.2023.04.29.13.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:20:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 17/26] btrfs-progs: make a local copy of btrfs_next_sibling_block in print-tree.c
Date:   Sat, 29 Apr 2023 16:19:48 -0400
Message-Id: <152afd02fc3c024248a6e4f31b63e5dab1129231.1682799405.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682799405.git.josef@toxicpanda.com>
References: <cover.1682799405.git.josef@toxicpanda.com>
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

We use this in print-tree to do BFS tree printing, but there are no
other users and it doesn't exist upstream.  Copy the current code and
clean it up so it can exist in print-tree.c and use the local copy
there.  This will allow us to remove the function call when ctree.c is
synced.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/print-tree.c | 53 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 9e9eb43a..5147f652 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1498,6 +1498,57 @@ out:
 	return ret;
 }
 
+/*
+ * Walk up the tree as far as necessary to find the next sibling tree block.
+ * More generic version of btrfs_next_leaf(), as it could find sibling nodes
+ * if @path->lowest_level is not 0.
+ *
+ * returns 0 if it found something or 1 if there are no greater leaves.
+ * returns < 0 on io errors.
+ */
+int next_sibling_tree_block(struct btrfs_fs_info *fs_info,
+			    struct btrfs_path *path)
+{
+	int slot;
+	int level = path->lowest_level + 1;
+	struct extent_buffer *c;
+	struct extent_buffer *next = NULL;
+
+	BUG_ON(path->lowest_level + 1 >= BTRFS_MAX_LEVEL);
+	do {
+		if (!path->nodes[level])
+			return 1;
+
+		slot = path->slots[level] + 1;
+		c = path->nodes[level];
+		if (slot >= btrfs_header_nritems(c)) {
+			level++;
+			if (level == BTRFS_MAX_LEVEL)
+				return 1;
+			continue;
+		}
+
+		next = btrfs_read_node_slot(c, slot);
+		if (!extent_buffer_uptodate(next))
+			return -EIO;
+		break;
+	} while (level < BTRFS_MAX_LEVEL);
+	path->slots[level] = slot;
+	while(1) {
+		level--;
+		c = path->nodes[level];
+		free_extent_buffer(c);
+		path->nodes[level] = next;
+		path->slots[level] = 0;
+		if (level == path->lowest_level)
+			break;
+		next = btrfs_read_node_slot(next, 0);
+		if (!extent_buffer_uptodate(next))
+			return -EIO;
+	}
+	return 0;
+}
+
 static void bfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 {
 	struct btrfs_fs_info *fs_info = root_eb->fs_info;
@@ -1528,7 +1579,7 @@ static void bfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 		/* Print all sibling tree blocks */
 		while (1) {
 			btrfs_print_tree(path.nodes[cur_level], mode);
-			ret = btrfs_next_sibling_tree_block(fs_info, &path);
+			ret = next_sibling_tree_block(fs_info, &path);
 			if (ret < 0)
 				goto out;
 			if (ret > 0) {
-- 
2.40.0

