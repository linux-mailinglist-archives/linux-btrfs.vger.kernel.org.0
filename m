Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E057C2B2056
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKMQYz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgKMQYy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:24:54 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE1DC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:54 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id z3so3449030qtw.9
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=iXryzmGUrdh14BWDSGzYKRKjyXJcrEbSXBrJjRJBHB0=;
        b=n5Mmrq7t6vO+lOvhYYKhL5UIBEEdgs6eN/y6q7qA0+/wgqXJivlPggkAZbqK/L5AJq
         wwOU7MZBxp5elK3OssRFVAqye4Kpw0zWCNQYZjItIGg7DgjoDwPdX1mKmPKhuiQI7C6C
         YlUZ17jkp/S+1DFFRzuDlIrddEd8L6XwN/eLX44PCMoPG4xDeiWJZ/YhZj96Pg2HO0uR
         6uC7ESzcsK++r4aG9p8qTmpRfqU0Ngsp4cw7XGkRU+jF//sVD5X5NHI87OKc0J0PgS7U
         sXYgBKBVeVqZVzMuQw31n1alPftSqgz8S06opotjGOyPM3YZNNn62moC60JA8Yj4vGiP
         boEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iXryzmGUrdh14BWDSGzYKRKjyXJcrEbSXBrJjRJBHB0=;
        b=mLwAFktDNA6oN66T5pfZIBI9neyRE0vGB45kLQlNGSYJ99M+80TRAFeubzGpA+CasG
         AlLwVuKFi5hsN9j0Bq7H5YX9E88xkbfz0K50GjfH4CxWhQFxwdpA+hzeR7MJgwziDTFU
         PdaGUAWGyEzzLAuIGDCUPtz+J3j6BrLcO5jc7rB1AFkSIr0CGVTKfHaHR9Ux0dJXrovU
         S5CK42b11z7wvbeyiyWwNMSJ34eQHgfDIN3x9sY7jU4kaWkDB6gWHiNTJKsW/KvYVRE2
         OQg34aZcaV1+XW9yGV8uCP9EgpkADRkgo/Tm+ZC3zUlb/77nltdcxOjeCRWHFlSTUAPi
         VjbA==
X-Gm-Message-State: AOAM533mFTL7blTKncJLlz7KoHYznGs8i/zrzS6WeUEOW3WnSLc0HEoj
        zoQPJYfd0VHmnfX0lD8MnQfyu8Zw9r/S9Q==
X-Google-Smtp-Source: ABdhPJxZSkd2LIL4scgwFFNQAoV/qCkYlhSUX/mTHL90WtlW8FndPhUOiqDYmh7t0VOy0yEquRPneQ==
X-Received: by 2002:ac8:4685:: with SMTP id g5mr2737199qto.173.1605284688899;
        Fri, 13 Nov 2020 08:24:48 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p187sm6744539qkf.70.2020.11.13.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:24:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 40/42] btrfs: handle extent corruption with select_one_root properly
Date:   Fri, 13 Nov 2020 11:23:30 -0500
Message-Id: <b3bfe194ee42e6e01cb7038eb0159902910a7ab4.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
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
index 9baff1a60ce3..12b4955f2ab2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2205,7 +2205,16 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
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
@@ -2613,8 +2622,12 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

