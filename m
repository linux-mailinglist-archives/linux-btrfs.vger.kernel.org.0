Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416345B41E1
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Sep 2022 23:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiIIVyw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Sep 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiIIVyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Sep 2022 17:54:46 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376892655C
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Sep 2022 14:54:45 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id b2so2199763qkh.12
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Sep 2022 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=6OwoWh+JnOQuT26jqTAkgxqtvtXcwjDBgHhYvJ6LX9E=;
        b=Kwb50TdzC5lIxSqqA1qiGRhYZ6t/Br8q3Z577h4rt3OURdE3IFfTqF/kX5z3oxeom6
         cf0rEY+6lIvipBd2ZJ0SleaOZIY0Ks3JkeHy2Kcs7nLRiEE3RiYq/Wf4I/b4XtK68D/4
         eueYApCQ3eX7m7zDVzt/6qYORexnmmnE7PCZontxd8GmnRNWfPZaJixLq/80G/u5c92Z
         3TYMWvat74O994i+KxVQ/MQfhei85PBZOxJcjNHAOXF8uscYV8Lx69F3tWC+1+hlQ0zb
         QlALdPVUvhM7VQIBZNvlLU4K3XuNBwDUOBDxLMh2fL/b8MM71MMaUXjaPdWfDJGRdLm0
         gXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6OwoWh+JnOQuT26jqTAkgxqtvtXcwjDBgHhYvJ6LX9E=;
        b=R1E53hd4UEuVUM/86TcAKu5Y+uYwifpKjV98tM0UA9ZDlm9cZIkirdXaX/5I6aR6hm
         AOirvMIgChhWoZtBlOsAG8JoXRAGTGh9KQAwBqX/25444aVU1rqxVuPdD4AtHDaA0ShX
         HIb+7DrkmuBc/ECK2/7/Qd8WewOxtzwxmhXyQt0qBVHgT1bYTf8pso0dQdv/a8aPW3Rh
         xSeItlab9mfLJRsd75gxYMQXH5vwrI4qlEy3y8Ocq8wEV0okRQXRaQk+Xw+wslTQAQYe
         y7ewjuRNMt/A31NHk5xIzRJt13PZVzjcsnaiVmE7sOXvr9znVuz5PD9OgVJyugV8tio5
         JeKQ==
X-Gm-Message-State: ACgBeo2rtRWctkaQ85XztOFE+OQJx2KiL98D5V7SwDAUGpwEJMAxFbXC
        0beQtHFv9m7zvMYM3ElkPkBnavWKJ7Lyyg==
X-Google-Smtp-Source: AA6agR7cTV+7zAGkjybf7fALFVyLKbjlo2QXgsFY4xLixvemCIrEsOY5ygqjaiLJJmmEpnyxnCe4+Q==
X-Received: by 2002:a05:620a:2408:b0:6c5:df5a:124 with SMTP id d8-20020a05620a240800b006c5df5a0124mr11862374qkn.753.1662760483992;
        Fri, 09 Sep 2022 14:54:43 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y12-20020a05620a44cc00b006b942f4ffe3sm1482215qkp.18.2022.09.09.14.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 14:54:43 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 36/36] btrfs: remove is_data_inode() checks in extent-io-tree.c
Date:   Fri,  9 Sep 2022 17:53:49 -0400
Message-Id: <ceca562bdf21779fa078899e62b903e0e5ee4b04.1662760286.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1662760286.git.josef@toxicpanda.com>
References: <cover.1662760286.git.josef@toxicpanda.com>
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

We're only init'ing extent_io_tree's with a private data if we're a
normal inode, so we don't need this extra check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-io-tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 482b6acc76a8..500ee1f12db6 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -60,7 +60,7 @@ static inline void __btrfs_debug_check_extent_io_range(const char *caller,
 	struct inode *inode = tree->private_data;
 	u64 isize;
 
-	if (!inode || !is_data_inode(inode))
+	if (!inode)
 		return;
 
 	isize = i_size_read(inode);
@@ -344,7 +344,7 @@ static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	other = prev_state(state);
 	if (other && other->end == state->start - 1 &&
 	    other->state == state->state) {
-		if (tree->private_data && is_data_inode(tree->private_data))
+		if (tree->private_data)
 			btrfs_merge_delalloc_extent(tree->private_data,
 						    state, other);
 		state->start = other->start;
@@ -355,7 +355,7 @@ static void merge_state(struct extent_io_tree *tree, struct extent_state *state)
 	other = next_state(state);
 	if (other && other->start == state->end + 1 &&
 	    other->state == state->state) {
-		if (tree->private_data && is_data_inode(tree->private_data))
+		if (tree->private_data)
 			btrfs_merge_delalloc_extent(tree->private_data, state,
 						    other);
 		state->end = other->end;
@@ -372,7 +372,7 @@ static void set_state_bits(struct extent_io_tree *tree,
 	u32 bits_to_set = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->private_data && is_data_inode(tree->private_data))
+	if (tree->private_data)
 		btrfs_set_delalloc_extent(tree->private_data, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_set, changeset, 1);
@@ -460,7 +460,7 @@ static int split_state(struct extent_io_tree *tree, struct extent_state *orig,
 	struct rb_node *parent = NULL;
 	struct rb_node **node;
 
-	if (tree->private_data && is_data_inode(tree->private_data))
+	if (tree->private_data)
 		btrfs_split_delalloc_extent(tree->private_data, orig, split);
 
 	prealloc->start = orig->start;
@@ -509,7 +509,7 @@ static struct extent_state *clear_state_bit(struct extent_io_tree *tree,
 	u32 bits_to_clear = bits & ~EXTENT_CTLBITS;
 	int ret;
 
-	if (tree->private_data && is_data_inode(tree->private_data))
+	if (tree->private_data)
 		btrfs_clear_delalloc_extent(tree->private_data, state, bits);
 
 	ret = add_extent_changeset(state, bits_to_clear, changeset, 0);
-- 
2.26.3

