Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A684B2B1017
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgKLVUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgKLVUj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:39 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0ACC0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:39 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id r12so3550717qvq.13
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LrggY1187JXd0E8oYLPjGhpLXAyWfupuGRWXOgn3Mbg=;
        b=AIdJvToMBPtDtvasujXm7AtF9AYKrHM5JsqJCVZ7xEXv8Cyl8mdrrMZ/stLwICO57D
         aJc0Mwq8Vz0OlzS0b10rYA+ZItODEde7p6Rgu6hlK+rJNBX+FKqAKKC5QXyEbxKzH+zQ
         E7AoRG5h104dpyt6T8rHCC6qttJ/z5pgiqHMvWqyKxhu5SYadT9gQ7piixyrXzNwgvee
         Jsnj4o8QaDWJ84aRY2GTAaPiIcd+GJOYwBMofFedW7Xyb3fITWbSrUydlPkeef/Vn/hv
         WRtPyi6RYUPPLc7VkrSeF+EnvJchzg1GSqLx1oQa3ZpHSsINlf0zedw22TYVeQkHX/7s
         JZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LrggY1187JXd0E8oYLPjGhpLXAyWfupuGRWXOgn3Mbg=;
        b=naeC/KgxDaSF+vNnHhcJajjJlgHbAcQi8dCXnxIrAlFVl0K/RKbZFdKpzp71ptaJ4D
         cUemgj/N4aYXCCz7tuni72mX1IX9rQYRcpGm/zD/Vn7LTd/SdEGlKe9TcZOEBOhr2QRe
         qQCt3LfUx488PrlU5tkfars3SPDMzA71t9ia4Vazk9dLuHwZ4ffFAOLGHsmfh16aDzdw
         N+dxs07vGQ4vnShptFgVxkAoBO6t0LifhCwpht76lCOUH7MSsusXO+Z0siiUcbSc8rP1
         XRvKV1133lcFrPb5aOaYh9H4lDd/yk+xjtc6ue+P1UtwrdadQ46rDSolVLUleA6cFec9
         Bvlw==
X-Gm-Message-State: AOAM532iC1OCfrj3zi1rN/YlmugS1GE+hX9rTim7w+OV99ZFe2/8BjT0
        iucTzVoYiFFiKwN/DV6aoQlbH78xW5prcQ==
X-Google-Smtp-Source: ABdhPJxEB2sQLDFLb17n3Rj8tcjJYleCKfU0oLSg4Nw13vBRWikIj/VI5YijkSPztUyBWqTbumnHNQ==
X-Received: by 2002:a0c:80e1:: with SMTP id 88mr1500888qvb.10.1605216037834;
        Thu, 12 Nov 2020 13:20:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j16sm5652822qkg.26.2020.11.12.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 40/42] btrfs: handle extent corruption with select_one_root properly
Date:   Thu, 12 Nov 2020 16:19:07 -0500
Message-Id: <b97129230426ea611096b752872f8ea869590d5a.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In corruption cases we could have paths from a block up to no root at
all, and thus we'll BUG_ON(!root) in select_one_root.  Handle this by
adding an ASSERT() for developers, and returning an error for normal
users.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 32e523361240..4648675980b9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2224,7 +2224,16 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 		cond_resched();
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
-		BUG_ON(!root);
+
+		/*
+		 * This can occur if we have incomplete extent refs leading all
+		 * the way up a particular path, in this case return -EUCLEAN.
+		 * However leave as an ASSERT() for developers, because it could
+		 * indicate a bug in the backref code.
+		 */
+		ASSERT(root);
+		if (!root)
+			return ERR_PTR(-EUCLEAN);
 
 		/* No other choice for non-shareable tree */
 		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
@@ -2642,8 +2651,12 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	BUG_ON(node->processed);
 	root = select_one_root(node);
-	if (root == ERR_PTR(-ENOENT)) {
-		update_processed_blocks(rc, node);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		if (ret == -ENOENT) {
+			ret = 0;
+			update_processed_blocks(rc, node);
+		}
 		goto out;
 	}
 
-- 
2.26.2

