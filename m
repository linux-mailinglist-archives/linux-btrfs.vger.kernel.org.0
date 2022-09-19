Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E005BCE01
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Sep 2022 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiISOHA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Sep 2022 10:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiISOGz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Sep 2022 10:06:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDEB2E6AA
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 07:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43582B81BFA
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E6C43470
        for <linux-btrfs@vger.kernel.org>; Mon, 19 Sep 2022 14:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663596413;
        bh=oOMd3KmLAJ36CiE90qV3nn/xPTnzC3MC+xnhZSZHBjk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bbpT7+Ohph7n53ys+5dAX6iuUHFexeIMFrll1UX3AkRL3mzkP4JrJ5BfEC9fQILaY
         LTjYWn9vqJfZk5dOvTQ0lG1PLpEfNmu56QimsxB8seL3krOjaWwK/mJS3HQgxE0xCc
         pAhafpQzSfgY414hoMeX9/ZdEZlPMjCrpYvZAquaBZMTAFabdazX3dKseU45TfQ0m3
         uosPeqbH9yjf9zteHKeN1WSWWjv9ezc7G701aG0oAicHBXakqFVUF4s0/LmzsIu7au
         KMgLucGdWUqDG0wDeX1KW+PQIsuJqvxXLkRQJtW6XtqAGi4RMEi4jLtxd7Fqc1vVON
         ykALisRyBN9wQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 10/13] btrfs: remove unnecessary NULL pointer checks when searching extent maps
Date:   Mon, 19 Sep 2022 15:06:37 +0100
Message-Id: <28c638167c79d62903a2bfb411f63170aa90de5f.1663594828.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1663594828.git.fdmanana@suse.com>
References: <cover.1663594828.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The previous and next pointer arguments passed to __tree_search() are
never NULL as the only caller of this function, __lookup_extent_mapping(),
always passes the address of two on stack pointers. So remove the NULL
checks.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_map.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index f1616aa8d0f5..12538ff04525 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -163,24 +163,21 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 offset,
 			return n;
 	}
 
-	if (prev_ret) {
-		orig_prev = prev;
-		while (prev && offset >= extent_map_end(prev_entry)) {
-			prev = rb_next(prev);
-			prev_entry = rb_entry(prev, struct extent_map, rb_node);
-		}
-		*prev_ret = prev;
-		prev = orig_prev;
+	orig_prev = prev;
+	while (prev && offset >= extent_map_end(prev_entry)) {
+		prev = rb_next(prev);
+		prev_entry = rb_entry(prev, struct extent_map, rb_node);
 	}
+	*prev_ret = prev;
+	prev = orig_prev;
 
-	if (next_ret) {
+	prev_entry = rb_entry(prev, struct extent_map, rb_node);
+	while (prev && offset < prev_entry->start) {
+		prev = rb_prev(prev);
 		prev_entry = rb_entry(prev, struct extent_map, rb_node);
-		while (prev && offset < prev_entry->start) {
-			prev = rb_prev(prev);
-			prev_entry = rb_entry(prev, struct extent_map, rb_node);
-		}
-		*next_ret = prev;
 	}
+	*next_ret = prev;
+
 	return NULL;
 }
 
-- 
2.35.1

