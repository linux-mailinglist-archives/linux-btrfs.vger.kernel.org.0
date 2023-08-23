Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93989785AA1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbjHWOdd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbjHWOdb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:31 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A6CE71
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:28 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5925e580e87so8150717b3.1
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801208; x=1693406008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=haLw09pFHAY4XRAffxLzVGIkco3b9tDOk8bK//gatW0=;
        b=D/qLY+lH9hDFLZAIu/2K8MOpb9moerZiQQbC/VRg8UWXMXX2GHqRYnX4ODVQx/QCZ6
         1V+uhNtqr6vgdIUhThHJCLr13FisRxD1IJP01Hcpi1WAVQcSuG899Ndt8SD9orkccSed
         +PubCZXXN8FN8XcuOhQ3XRGvSlmgQ5QEGdqAiUZC+1YORCdaN352b6aHwZyYplLgI741
         3YajgV4B6iX4z5UvQ17NFK6tqm1QjEuKaxZJs0PozAZ1q0xp3TqudWuKOA0dPcQUClTe
         HzUs08rhy0s0fLPS39KUgriexpdQzVqahj4Mdh5ycCFltPEqIH+Y+u5ro+YrtkdTf5SH
         l5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801208; x=1693406008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=haLw09pFHAY4XRAffxLzVGIkco3b9tDOk8bK//gatW0=;
        b=QB6Th1W3UbDJVV9/0yZUxu9+XSSVGLwnQFKgYZ9Gxw3tyzwZkvglEP/92PCLPdFkDG
         OWLYwvGprom8nOrHy55C0U4/mjOQLwnMT1z0cegGqfWXSkZmDvX260bzEJS196uy6PLO
         Ef7E3jvcp1kiBnj/gcf4mqKL6ASMI4Q2lVddOPS6yoWwpuirq62KgbjikFfvKo/SxJfP
         Bz+w7QkQBBAGCZWeVfBUwhT6dPQ7T/yJOm2c0smfdY8i2BrjyASQ3n6JuroXb60vOx7x
         3xMbkVb5fhRTMnQoFgah6C+v6nyYEr9zQXEBoCnpgjRC9ffByDqxsHQLwp330kp/i8oV
         fjCA==
X-Gm-Message-State: AOJu0YxOM7a1AuymkdFhtunQg57x4Tv8sQ0sE319kR5L1HE378H6EGij
        xETzBa9QSBN0VRCADeLe8URRmQZZrAfZlKLc0Tk=
X-Google-Smtp-Source: AGHT+IFhaRbcWXMWKeOHlEIpQaZEwzorZ8NEuehYLRKiXZdc7FaL5CPviohvosxyE4khv715mA3GKg==
X-Received: by 2002:a81:5388:0:b0:577:1560:9e17 with SMTP id h130-20020a815388000000b0057715609e17mr11444370ywb.35.1692801207809;
        Wed, 23 Aug 2023 07:33:27 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id m185-20020a0dfcc2000000b00589b653b7adsm3379463ywf.136.2023.08.23.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:27 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 16/38] btrfs-progs: make a local copy of btrfs_next_sibling_block in print-tree.c
Date:   Wed, 23 Aug 2023 10:32:42 -0400
Message-ID: <f40179778e3d772f3c3ef1b33f59f86284e9d34a.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
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
index a32c9a2a..9796085d 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1505,6 +1505,57 @@ out:
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
+static int next_sibling_tree_block(struct btrfs_fs_info *fs_info,
+				   struct btrfs_path *path)
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
@@ -1535,7 +1586,7 @@ static void bfs_print_children(struct extent_buffer *root_eb, unsigned int mode)
 		/* Print all sibling tree blocks */
 		while (1) {
 			btrfs_print_tree(path.nodes[cur_level], mode);
-			ret = btrfs_next_sibling_tree_block(fs_info, &path);
+			ret = next_sibling_tree_block(fs_info, &path);
 			if (ret < 0)
 				goto out;
 			if (ret > 0) {
-- 
2.41.0

