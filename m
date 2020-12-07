Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FD82D12EB
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgLGOAH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLGOAF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:05 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12223C061A52
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:16 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id u4so12484408qkk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LC9b9O/sOio0l1Yw+TXFj2SCmB30kfCgWdt89mNluaw=;
        b=dl4tBAswteidZ+Q9RbhgTHgad4zrAqZHSXxfZzsLC79+m4buV+JEBMWXhmp4wPkXDP
         pfBpjhDpC/Fyd9SdsKfdRqOSAwAL7TL2JYgv0yYGQhQot3mkz8JyyLcNZmivYFQqbLPh
         y6bi31AV/YxKvrsWNM0oKqnyN/2bt6has/3YgWPfnpLpPMkrhT0RqhDQKD0pnfpq4yxb
         /lJWxwUeY0kqZGBk+2jGzbnFmN5Q+9W2f9DEteObN+RCLKrzBI3j0mBWw+s12iMpSXMy
         whKZcT6lkryV2oaXO9ytm/RlUE7e4xBnEHBnlu2DFBYQNtwAHWci/V9zYz5HSiXxzKUC
         6NnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC9b9O/sOio0l1Yw+TXFj2SCmB30kfCgWdt89mNluaw=;
        b=BrB/O57VzrY3FlO++EdzNF4xevz1UWEP33VYnVqrReEb2lICOZwi+YLTw1UL1EZ7As
         n2ts+8YnB97ryx//Y7i6mIPmJa+5dUMfdID+UKQuLkMXLln6qlo5qojE5odvzemITllo
         SpB9B6OmRYrkBAv+N3Vb9CQtYOHQ6FnkUu2TaFE+PJSYu0WGuQ0lQs4pdG0GbFv33TRD
         zD0o8JM3vFo6pWY/A3bg7VmQ9sMx16kiLgAgRfOHLvPUS9/ATWhK3UhrqxCBLSMh5Ii0
         TDhPX8UmRF+TIjX5SBh7rmdAiZEd0LQIX627D0I9bElpnzaMmoGvKrQ/eJVNtSFZaxW7
         LOtQ==
X-Gm-Message-State: AOAM5318KZX5LJh+evImMGysqT4MD7oKObjQt0S0UY6IE8HepbIEkyZD
        mXce8FZSyybpyMfYd5omr7c2bXEez4RiRcAE
X-Google-Smtp-Source: ABdhPJyMFyL/jOklXdWuzdqhX3IU8G8IC0siV4CudjI5XBEd3zrVelF/7ke0y3qRM9nI+ox+7y1+eQ==
X-Received: by 2002:a37:9205:: with SMTP id u5mr25007836qkd.345.1607349554964;
        Mon, 07 Dec 2020 05:59:14 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y56sm12754475qth.54.2020.12.07.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:14 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 46/52] btrfs: handle extent corruption with select_one_root properly
Date:   Mon,  7 Dec 2020 08:57:38 -0500
Message-Id: <11cf745ab13ca9e787d706c96032d4ace706af1c.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
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
 fs/btrfs/relocation.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 02760544cba1..511cb7c31328 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2193,7 +2193,17 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
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
+		if (!root) {
+			ASSERT(0);
+			return ERR_PTR(-EUCLEAN);
+		}
 
 		/* No other choice for non-shareable tree */
 		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
@@ -2591,8 +2601,12 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

