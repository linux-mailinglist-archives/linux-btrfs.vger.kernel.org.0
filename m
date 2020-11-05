Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341A72A8280
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgKEPpc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731411AbgKEPpc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:32 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51E9C0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:31 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id y197so1549417qkb.7
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/pQ83jMqyExu1vuMaQ7BI+S8JsgILIuorI4aY8Tj194=;
        b=CNjElhbeL67szvYqkv2RZI6cAUdFP4jORpsiBsnSI8iO0GBuKeAOIkr7DbiTuLudX4
         7Mlt9+8vH7yh3OXVa64pTRRilwvqJMNR+JrHOCqtVUhee+N4qaUB8hlq7PH4sNUKHsmi
         hcUX/TNLCgPoFZBhEa6G970GLhO36j8ArM0n+mVsuXmVMXlx2/QwHN879VcIavWEm5Qq
         2RgueqJ6lMigju0BT8DaH4As2iFf9NmbYwSt0n1f2kIl5hFbQ6x4DD1ULhYmEre3Ng3F
         DSM2BI1Vu12/W+KRjKARGF8OznmpPN5DPlPJr3FSy3eQsF5TJl6kZduxJkRlGyJ96hir
         DGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pQ83jMqyExu1vuMaQ7BI+S8JsgILIuorI4aY8Tj194=;
        b=QKA8+eKiIEw+vhX39HtE/SN07HDwyzR/a94lXwxkRnZp91tGWZ8Oc+9kqomsuAsolC
         Agaej1UINDTMACJMqQ4SA1aC/Um+K4HrTwfqjL04Q+Jq/PTVt+KYBrsK7XB5+BmhcDE6
         yNBqb4EWi3ddfAqKp1ZzejKDEMyyzpwPOoK6zQqnE/R3tvaiK1QkGIQrddBkMFRIHy9T
         41Ml4DtArm9YbDLtL1UuIL3OJCqcaBNJZuYv5IAdDZfiVVuXNA+ysR3scd2TF75RmHAN
         Yr6Z1jFjfVjKiYFCqv+ol9an0lF547D4oJUQnUHB6DpZB/1NOjSvIZhCRtX9gcsM7eML
         wfQw==
X-Gm-Message-State: AOAM531H0OxZQ4Pa4FLV25LCqdWzZtYLGqOQNVusCU3OD19KtEEM9b0m
        dkE1J56ytPXiew5ZYYGUWnvIBGJ4wSD8D5Qr
X-Google-Smtp-Source: ABdhPJwUuk/r3to/tuPiJkBHsc5RRoxxaoqP6mk7gnxMIVFwPF8LINBAG1LbQGFvSXXLcDOoC+HFSA==
X-Received: by 2002:a37:aa93:: with SMTP id t141mr2578070qke.400.1604591130703;
        Thu, 05 Nov 2020 07:45:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id a25sm1253639qko.17.2020.11.05.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:30 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/14] btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
Date:   Thu,  5 Nov 2020 10:45:11 -0500
Message-Id: <bd9bfdf69f8a03c17b35e0142e693c4bb08a03bd.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not need to call read_tree_block() here, simply use the
btrfs_read_node_slot helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0e2dd7cf87f6..d327b5b4f1cd 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1415,10 +1415,8 @@ static noinline_for_stack
 int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
 			 int *level)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *eb = NULL;
 	int i;
-	u64 bytenr;
 	u64 ptr_gen = 0;
 	u64 last_snapshot;
 	u32 nritems;
@@ -1426,8 +1424,6 @@ int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
 	last_snapshot = btrfs_root_last_snapshot(&root->root_item);
 
 	for (i = *level; i > 0; i--) {
-		struct btrfs_key first_key;
-
 		eb = path->nodes[i];
 		nritems = btrfs_header_nritems(eb);
 		while (path->slots[i] < nritems) {
@@ -1447,16 +1443,9 @@ int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
 			return 0;
 		}
 
-		bytenr = btrfs_node_blockptr(eb, path->slots[i]);
-		btrfs_node_key_to_cpu(eb, &first_key, path->slots[i]);
-		eb = read_tree_block(fs_info, bytenr, ptr_gen, i - 1,
-				     &first_key);
-		if (IS_ERR(eb)) {
+		eb = btrfs_read_node_slot(eb, path->slots[i]);
+		if (IS_ERR(eb))
 			return PTR_ERR(eb);
-		} else if (!extent_buffer_uptodate(eb)) {
-			free_extent_buffer(eb);
-			return -EIO;
-		}
 		BUG_ON(btrfs_header_level(eb) != i - 1);
 		path->nodes[i - 1] = eb;
 		path->slots[i - 1] = 0;
-- 
2.26.2

