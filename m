Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22432CC73A
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Dec 2020 20:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgLBTxk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Dec 2020 14:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389855AbgLBTxi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Dec 2020 14:53:38 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C955FC061A47
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Dec 2020 11:52:42 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id b144so2443877qkc.13
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Dec 2020 11:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ypRVW90fQhKQFSnRgRMLz6HPjjcOrzK4ogUGXPlH9Ek=;
        b=eajXhA5+cHYDAUuqCTuAEuKIVRbNjqmNF09Vcxtj8FnqgfduwQI4lOM9yEcuDKX8Pq
         Kz4dZYklKbFIar0glZd9DJGqos7nPWagz/DYKe2fdFzOoPRz+WbqJvac1jQh92jVQUTw
         7qcyqgncfRizQqAqOtQTnAxIMwX3n91Sk4x2ACl6p72XngeoQZOVGFYOyzeZpz4oF1QT
         A+EsEQJC6T3gzoPT3zz6HJ0d2F3YQktr2yTVLeofTu5C5RoeNeYvj3FvjcAABtTiaLqC
         ACN4OpwmMfHAWR/fG3QDiI0/B94fDnpwt2Xco7AlfL2NNrk2oxVJ8Qbs5WsHMxYq33BU
         AP2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ypRVW90fQhKQFSnRgRMLz6HPjjcOrzK4ogUGXPlH9Ek=;
        b=oqxRO97wEhZig6FH+j0okE/fLBfFZ+/hrS+WJNI1nPRHhqV0IoMGpb3VuZ1r/db317
         4pG9xojdXj51vdTYwohdvyu1PAPSVlA2doDgkMuE9LyTyk3DcrCsDHabXLPYXJN4fyPo
         /oJ7l1hwdPs+8Vv+5koriBaG9U8S9DP/zJnKNX0zPheCdQ0VbPEL6OV6S5OCOQDRrMlL
         9piZIAHVb1FNGv8jZfJ5BBlF3DoV9syd16R0psfdejvRVx3NqgJUWgki9QLPeeCOdn93
         pSG7K7MJ7vtyjkxVo9VslRN+8eV3AthAd4qPvNM0rM0Ww5gQaOsmfcMEwovRFo+ooaF+
         i7bA==
X-Gm-Message-State: AOAM532OpQ/Pg8TL6KH3U44R9WX/7vLAazjwrK3tyUzSExjajWhlgpvu
        sCiGVn7DppiViJTIrRdKrI83wICo7wFJpw==
X-Google-Smtp-Source: ABdhPJxsLBjtMku42uDfdW7ypLtjomZb0bBUMLMpIvBbE1nW2520EkKmovUftjOrqZ013XrEkBGIEw==
X-Received: by 2002:a37:ac8:: with SMTP id 191mr4094788qkk.381.1606938761710;
        Wed, 02 Dec 2020 11:52:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t205sm3008134qke.35.2020.12.02.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 11:52:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 48/54] btrfs: handle extent corruption with select_one_root properly
Date:   Wed,  2 Dec 2020 14:51:06 -0500
Message-Id: <6570c4cd1433a02a9d84e6fcd93f9a971d7f42fd.1606938211.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1606938211.git.josef@toxicpanda.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
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
index d4656a8f507d..91479979d2a7 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2200,7 +2200,16 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
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
@@ -2598,8 +2607,12 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

