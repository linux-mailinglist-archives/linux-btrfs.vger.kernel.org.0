Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8692A8285
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbgKEPpm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbgKEPpl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:41 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD5C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:41 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id r8so1349173qtp.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Ush9D6UzumbS9+ZIsAZ0+0pD3WJGkWIILrWEWdQJ7oQ=;
        b=N+3b7yFvvx0jZvj5fLPzaQ1R5VHsck2zLOoJzIuxIXsLRwV9J3vp+XIPYfdL9Xu5f5
         FSTlrNIqQfjRwV7P2IDn7LczFKt+0fc5whOO3e5AgEpxoqZrypfXH6nwrHEXmWIn7yUR
         4bgZNxu3GHeSw2IezmW9RbAlMu6eERS0ZLisoyEHTpF5a8oIbzfBiw1sxO8FFXGa+3fK
         /7kjAAPoLQvZRc4RfYNDEEjjIWAqjSvS47cXpUnW6hghmgNKV7FYG0qZmQ2AJdsn8G+z
         yZeqtcfi2cSxBxbhC1mc4nBYPwpSXJymeJXckTRQLn2/0qqVVfEp9DMj4xfAG3Zf7kdn
         14ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ush9D6UzumbS9+ZIsAZ0+0pD3WJGkWIILrWEWdQJ7oQ=;
        b=qqBmt7/mPTrS3vBNdv6KjXB2BsZbFk72DHQEQAC76W62R6HwQqKEFk0+rFz6Y+jHYi
         ya+oMdzbvjBHldIsKGd3Kf40b26WF8Pt/LIqZe+UcXvLY2oNFdoRoOT43lal6PZ+5nq8
         0TsLps5MUurmvIAtoF5+rg8NxbApOWf+NP2mb5SKDb5QwZi5ASyPfiPd0JQllqcciT4m
         emF5/4OzMPIu2pniyyznY/aoWLaL6C0je3NR+V1qn+G/+YcoY69tOjsauO+MBDwWeEVI
         cua3ynSKNYQX/iBQF9r8Y0vNTV1JGHn4jG+7BNopuoXI0khjqv40qY0Tdz0CGKHX/DNH
         p68w==
X-Gm-Message-State: AOAM533/7w/6ialYTI7/ZxYC76oxGuFIlV2Wo708NhYnO7FqhbIIq0L6
        N+MipOKJxXaw2lUfCB53pRCDAUlltBtVxort
X-Google-Smtp-Source: ABdhPJwFvDLyWC4QznXQyoDWbgPTTpCZeE4qudcXuGCM6oonYZx1M9bAWn8+n1JaxwIiRWoNZTySEg==
X-Received: by 2002:ac8:64d:: with SMTP id e13mr2561064qth.23.1604591140259;
        Thu, 05 Nov 2020 07:45:40 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d48sm1172088qta.26.2020.11.05.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:39 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 09/14] btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
Date:   Thu,  5 Nov 2020 10:45:16 -0500
Message-Id: <5180b1583f4a9db07d8374026818d6a557f94768.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're open-coding btrfs_read_node_slot() here, replace with the helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/qgroup.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 21e42d8ec78e..8d112ff7b5ae 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2002,10 +2002,8 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 
 	/* Read the tree block if needed */
 	if (dst_path->nodes[cur_level] == NULL) {
-		struct btrfs_key first_key;
-		int parent_slot;
 		u64 child_gen;
-		u64 child_bytenr;
+		int parent_slot;
 
 		/*
 		 * dst_path->nodes[root_level] must be initialized before
@@ -2024,23 +2022,16 @@ static int qgroup_trace_new_subtree_blocks(struct btrfs_trans_handle* trans,
 		  */
 		eb = dst_path->nodes[cur_level + 1];
 		parent_slot = dst_path->slots[cur_level + 1];
-		child_bytenr = btrfs_node_blockptr(eb, parent_slot);
 		child_gen = btrfs_node_ptr_generation(eb, parent_slot);
-		btrfs_node_key_to_cpu(eb, &first_key, parent_slot);
 
 		/* This node is old, no need to trace */
 		if (child_gen < last_snapshot)
 			goto out;
 
-		eb = read_tree_block(fs_info, child_bytenr, child_gen,
-				     cur_level, &first_key);
+		eb = btrfs_read_node_slot(eb, parent_slot);
 		if (IS_ERR(eb)) {
 			ret = PTR_ERR(eb);
 			goto out;
-		} else if (!extent_buffer_uptodate(eb)) {
-			free_extent_buffer(eb);
-			ret = -EIO;
-			goto out;
 		}
 
 		dst_path->nodes[cur_level] = eb;
-- 
2.26.2

