Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD02D2F9F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgLHQ0Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730485AbgLHQ0W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:26:22 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD90C0611CB
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:25:42 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id y15so4742948qtv.5
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BL08xEovqds+clZTIcSTxCiWrXZFm6JdXsxnv9ahPRM=;
        b=E+mM1spaPfgGBJdxaXqO9qYXaIe8g9SiKzU+6JJkTvp3zKhEKCfaqxRE2PTDdWTNMB
         T2AYFSHI4QK8YWCnbDohNvn/7298l2lV6t4eeVp3Q42bOkqXiEk4BWpX6w2me3b41ffy
         agChP+/IylZegfU/d9LYldau11dVCI+yI0+W2KeagAe7LzxEBUREa97mCCAhMJ71SsS4
         A5vdHPeuY5Y1iy3COI2rjUfV6AQXXImABEpnx4fnetrKNaZjlv6om86o6G+Cwno0PmwU
         D9EgvW9VpzyTBu63Ik1HzYyU3aApefhIJ2HCUZwdxHBVubMpFSrOe0qyPO400OB5xjW/
         IzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BL08xEovqds+clZTIcSTxCiWrXZFm6JdXsxnv9ahPRM=;
        b=OJgCSq8r+Ox8rIxT1mY7nUeLVjH2awOO5042j+BxQYuv44J+whFhmh9bS2aNpRrD2B
         iIoPo3wVsZrJSwB/Hm018ew3eJVnXxZL6C1qa3NAJI9kKpOvD++nCas46C9Xbni0xeS+
         rLmdKUoEhHzanb0n6kcWAhMhGhQhKfHVFexpTQNy7dVcAD9+6c5AeGjV5tks+Ds0beFU
         6KPIN7QxNWwbRb+iKWZHHXlW6Qcq2CouSSYStVAhk6NvmFodl6F4F0luIcLQXrhFnDSn
         5R5ILXYNuJPvEpM+rrMiTtgjl2EZPApMfCVEt92HF7IPF9boSoIjpO54nNk77inf4vd3
         A33A==
X-Gm-Message-State: AOAM533fkyP2sepxLq9fRLHxT8cScPycuC8awmiXjcNYWnFHf+Y2NFbi
        yLe9WeoI4r/cGhg2DQEfThwfbfmFnpMbcK22
X-Google-Smtp-Source: ABdhPJzeArBPSFRrImTt5lqQboOX8AN2BEQBXgaYiJjiTOmMaABKv013OdnSj/ovio3G+RKck3N5Xw==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr30748384qtb.80.1607444741571;
        Tue, 08 Dec 2020 08:25:41 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z20sm15207660qtb.31.2020.12.08.08.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:25:40 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v6 46/52] btrfs: handle extent corruption with select_one_root properly
Date:   Tue,  8 Dec 2020 11:23:53 -0500
Message-Id: <95f9219dcb2a42c448fc5ff4badeac6d6f8fa61a.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
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
index b824ef069ac5..9a59adaf178c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2199,7 +2199,17 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
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
@@ -2589,8 +2599,12 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

