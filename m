Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444CF33985C
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhCLU0s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhCLU0e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:34 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E6C061761
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:34 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id f12so4836722qtq.4
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xkBjKSpFXs9JPkEZ9VDHRBUsRntp4Bg7JxsNWaxGThI=;
        b=v468QFzgk34CNkjYUcjyuEwEI2kZMLJvxEy5TfnwAwZOjZrUL873F3LMEVa5YpL2/U
         wLTo52hYeaoI28Q1tJts7mN/1VBM+gyB+RyR/KleOGQX1LHvcDPblb+0aCwVfA6/65Od
         oBFHXIaGhXS8yb2Xaa+0B/Vu34HPsDZwJDEliwkvn0mNpAOTbOyq3TVIzo5m9oYvZjVj
         gJVodpNFD0GRipkvrFL3wUFi51cafgJAGmlFQ5Uk85IqUkKiaj0TpxMYNEpELgSekTnN
         9mP2a2nNj1i99CWw+f2a/BQd39dt8oqFTdktrE0tq3chyU1ATCHjwsaCUnHEOVURGtcd
         IgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkBjKSpFXs9JPkEZ9VDHRBUsRntp4Bg7JxsNWaxGThI=;
        b=JLjvQ/Nx1/ijOcVFusYwdMPKKGRk3InlcY46n7WDPCAGu1KDbL1nlIyhcbgif9Az1k
         I0XonrbLFNA1Mjn7aoPzrbxu/Fe1zGp4V70IxeFhgb+yZdJc+uSK3jxQ/d077GhG/rJ8
         x0bqQSxPu/oxG7craBJJZmbrSdSpEPR5mhvumEzXR4/eHGMzRlmTZvWgWzcgUVw8I1uU
         lrL9CTbLGz8vz+PZMBMkUp+GI6zQBBvPP/D1u8MIcwQ6EkZcFfElvAevft0EakEh3FsM
         K+wy/rSjuq1UuC8fCR7JkrnwviLQLJCJzL31yCgiPTdG3qpmKuCAhMVnIjWdv6DEJgmr
         oq3g==
X-Gm-Message-State: AOAM531dNk5XnbAMRPfdwDLOpUnVlzr6ByTBx/sEG7b2mNgY/yPO9NZr
        7IVLT8+FfqF0LGUdvh+FeqXaTbYG9j1E/3an
X-Google-Smtp-Source: ABdhPJxNj8BK7ifaFNXeRW8fJp4tSWQdtgPUiV1Sd1uf2I+5GV507s8Ox35IOPgzK0/j9QJmETeG8w==
X-Received: by 2002:aed:2b43:: with SMTP id p61mr13065750qtd.46.1615580793057;
        Fri, 12 Mar 2021 12:26:33 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d68sm5137830qkf.93.2021.03.12.12.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:32 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 37/39] btrfs: handle extent corruption with select_one_root properly
Date:   Fri, 12 Mar 2021 15:25:32 -0500
Message-Id: <3c76eb6546378e5bd6b7e3bd96468350ea6fe278.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
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
index 8f7760f8fcc3..621c4284d158 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2209,7 +2209,13 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
 		cond_resched();
 		next = walk_up_backref(next, edges, &index);
 		root = next->root;
-		BUG_ON(!root);
+
+		/*
+		 * This can occur if we have incomplete extent refs leading all
+		 * the way up a particular path, in this case return -EUCLEAN.
+		 */
+		if (!root)
+			return ERR_PTR(-EUCLEAN);
 
 		/* No other choice for non-shareable tree */
 		if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
@@ -2599,8 +2605,15 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
 	BUG_ON(node->processed);
 	root = select_one_root(node);
-	if (root == ERR_PTR(-ENOENT)) {
-		update_processed_blocks(rc, node);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+
+		/* See explanation in select_one_root for the -EUCLEAN case. */
+		ASSERT(ret == -ENOENT);
+		if (ret == -ENOENT) {
+			ret = 0;
+			update_processed_blocks(rc, node);
+		}
 		goto out;
 	}
 
-- 
2.26.2

