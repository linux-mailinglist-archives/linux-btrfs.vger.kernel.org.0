Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9B92DC43E
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgLPQ2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgLPQ2t (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:28:49 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EFCC0619E0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:28:00 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id u5so10081370qkf.0
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=89BqtHxNiNTkmRvwCnTOM7oyBg+jooBmj6s+FRkuRHI=;
        b=1NWh0cEL5/4iGJ8Q3EiYeVBoM6h3SYnwRG2ktITexgNEKIuL57jYJ1mhnfoeyvJ3mu
         HJ0wF9FlOKZuf+HE0VjMqHATB9qWl6zanYneb7xokSwH0F8ZBZzu/xuHwy5nUHv4hPwI
         Yb2IfKkjPN/PUsf5UsMx2DK157juCBMje6iEcFJXzbPiJm+PaBMV3MoUtEJEJa7s96Bo
         pD77q0Pr2kZalJlb+wFTgieqVZq4U8n5nAU9TI+igylw3M9Dzj9J9pU6/86HdbcqdBEn
         Uq08+F5idTZAYS6d48y6ZOC8onQ9TlSsSzNd3wIoLCs8iyaOho/PMiF/3n7Jk9jpRjto
         Isjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89BqtHxNiNTkmRvwCnTOM7oyBg+jooBmj6s+FRkuRHI=;
        b=ICbCbJ3b51/n3RG6KFylUFlKZjwSJpF8G0M1pI89avVuuLr+27vFEAr1U0lSUZXY9B
         VayAHaoPIkwhBdzRMtc777MIN4JYyIpUwYwWEb2rBES2xifVhRf+YJeak0JmhMxcrduP
         3nRzruw6hcRcB5A4hWikDrxqNdrDJAK2zv76z7OZId1Erb/72ldDxXZRYOLI8xx2NOww
         0FhHEz/5JW2nyQwlMmyR1+XRnR6ZUZmDjosU4S8c79pBK8QXzgenTO68y605RqQuhyuP
         fLpGINTObzuOAPIxkeotUjyKabQgjFq59U8ibeVMg4DI63iAQ03gJmhYyXfgJ7yBki09
         PPug==
X-Gm-Message-State: AOAM532IvYo/Eu3KYufyrMHfWDl9bcL3wehg8ft+Mv7AG+9Nlb6mCXjW
        75AUM2Qx7sivEw25VO/35nHOdkfpxf78tfCi
X-Google-Smtp-Source: ABdhPJyn0utmCQMfrfT6k5wnFz6IKTwI+G9L/9PdWQFyq6fhE1TASwlUQacbvAMt37XL5qtAUtXp0g==
X-Received: by 2002:a37:9687:: with SMTP id y129mr42324420qkd.104.1608136079012;
        Wed, 16 Dec 2020 08:27:59 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x2sm1188435qtw.3.2020.12.16.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:27:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v7 36/38] btrfs: handle extent corruption with select_one_root properly
Date:   Wed, 16 Dec 2020 11:26:52 -0500
Message-Id: <438040a2d88f949f782f0a2f7e3460e1f98abc8e.1608135849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608135849.git.josef@toxicpanda.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
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
index 56f1fce7c746..3f71fbb5ea18 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2209,7 +2209,17 @@ struct btrfs_root *select_one_root(struct btrfs_backref_node *node)
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
@@ -2599,8 +2609,12 @@ static int relocate_tree_block(struct btrfs_trans_handle *trans,
 
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

