Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5172CDD95
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502107AbgLCSZh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502068AbgLCSZX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:23 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F3C09425E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:24:23 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id ek7so1435642qvb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LC9b9O/sOio0l1Yw+TXFj2SCmB30kfCgWdt89mNluaw=;
        b=S6zum/F8Ygh9Nsyejy69FQGcg9yBOWJeXMiSPp8/aUQaUzRq6izvbLiE4Ecd7iQwbe
         UEcvfCi6rDPd6KfXHa68HWGoJji9kh2zgCTjb51IbhMIomCWg3Bwoc4j49cWtF5/Kdv6
         r2K1OY1uRy2zJnRlnRvy8ptH2v8gBwql2G8YGIJoS9rPDLwjkteM/bvRIEC7k/vagset
         kEgYIeWUaA1FBd5Y//jvASkMEF48AjMZUZC0I56mH7nHrNDji6n+XgrSfYcLeG/tCJF9
         MYr+A+OGXbzcvMQvdbIYFlNuqLVUO2Aob1GBOdl9AJ8MvHN1/uSCVXPurBq6GRtgEoj/
         nU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LC9b9O/sOio0l1Yw+TXFj2SCmB30kfCgWdt89mNluaw=;
        b=Jshyz+7W9zab2A1PDqJYT1KjUH5BKfUDb19La0HhSVLpuqrIsh+1nerrldF3z6Z9k8
         B8zUTPy8+chFbI4jcncu4EzoW7yczB9JxoRbXHlk8hpDUxdvjz6+9BaP6ntdy1CN058J
         9QOBA+Hr+ZACpD+vfnA2gO7VKCJm50DGQZfb0c8QqJq9HMuwLJSzVCRPxLWhrF79QnSf
         wrxvpfQs7dHhyDd6uEw/u3C4B9VivjmPxCgFrjkUUrqGOPt2BaM6TvapESfv3O1ZjpHL
         /nn+TYmNaw9wNTq1JH5pJSR3acEy76w75bnYHRSuJO5iUIhX3k04kFnXrV2MF2rO99xM
         Qw8Q==
X-Gm-Message-State: AOAM532Epz2uY6nBqNwrqPdqS3zGH4u/Ce/E9uq5PD753rGR5kQ1ijsh
        MuDxQowxySEKsnbfAYFehkxotL8lPRF117vE
X-Google-Smtp-Source: ABdhPJyWztT/VL31SBXUACRhoVt0G5jGfHUzJ3msafCiZlQEUxtKvvGlfrK6RvAgkbWsAwGDKGHEtA==
X-Received: by 2002:ad4:4ea2:: with SMTP id ed2mr266727qvb.59.1607019862888;
        Thu, 03 Dec 2020 10:24:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j13sm2214617qtc.81.2020.12.03.10.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:24:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 47/53] btrfs: handle extent corruption with select_one_root properly
Date:   Thu,  3 Dec 2020 13:22:53 -0500
Message-Id: <ef9bc6020a7807fc54111070b9417fe5d8925aff.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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

