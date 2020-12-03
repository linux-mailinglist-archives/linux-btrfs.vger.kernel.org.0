Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798ED2CDD8C
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502078AbgLCSZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502049AbgLCSZR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:25:17 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BAFC094251
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:59 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id o1so2055300qtp.5
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KUMwtyvBJyOvxYGVZ896Bgl7sIns8gjAueMfjoGX5eg=;
        b=RUz2LvJNbQaDaVyjHnjPNGTRFpwgAwjwiCXLUAZp3k8oSmpOrDXPrXg+17dyRU/Z0S
         shvGfZiIMlhjNpUSy6NN3ZlF8giLwcXVqeRAHXd2ImxQEGJy2jjnyFmkn5ssD8VLu2+0
         HF+7EHj1qMWgD2rOlpl57afN3deOFNk8m1A6p1HMiasOYepElNlxWlqrsYnxXlKX2ADy
         PYJ85Pn8NOQ4QuIPdOjB94zYch3hNP/QrKLJXP70u8em446KAtQ66Bqlu/t659z6l6Az
         dYOQcQBqEMDY5hmr/08brjrHwQ+Zlo3WDguoKABDEQE8yaF0EYRVgAzYPBOcMziomPkY
         ZgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUMwtyvBJyOvxYGVZ896Bgl7sIns8gjAueMfjoGX5eg=;
        b=ai2Qi+b/hqxd7ubd+s4BFJJdSugwFUPvVpDCxFsD4tjHAmn7p6eRNB9n5BrHIIzhQe
         1G7skI+prwpKvLTSlsdvjrxSAEeH6/ldJFtBNC4HVAyQFKHCK2BWrL7cfBtO7DIMrr2V
         eK2w48LPIVQYgSq4v5W28t1Sy9po20DlBcYIoasG00YGG9iv06jBKpTX0gsAB7ZSJVKz
         egaBfah85FE1P+YmEEyvHkJVp5b8KCrfWNrIJhcUAN0adNo3EKsfosevTEID2ivkn3UL
         qQIW87eh86OcseI7nAqBygkG19h0ulALPoq6pnPwBgLbA/3xrv/D2vtE81LgkxD64dmT
         VENQ==
X-Gm-Message-State: AOAM530aX5FjVd8XNaNgVKBrlYDraG7/Zd9zGhbmuvpk9M53+4hhd+wX
        hHfssbFmGG/I/0bDxR7KRkNaErO3PZOvOdil
X-Google-Smtp-Source: ABdhPJzqTzG49VNafj454iUwjElZygobGWRLQYtXS0IyN/O8qMxp69PSxddfp2QXx1k76fJNNdBOvg==
X-Received: by 2002:ac8:2c62:: with SMTP id e31mr1905466qta.188.1607019838715;
        Thu, 03 Dec 2020 10:23:58 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b3sm2220314qkf.74.2020.12.03.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:58 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 33/53] btrfs: change insert_dirty_subvol to return errors
Date:   Thu,  3 Dec 2020 13:22:39 -0500
Message-Id: <4272c3aa86a6809529d9ef929050eebfac77cd58.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This will be able to return errors in the future, so change it to return
an error and handle the error appropriately.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5770f4212772..f41044d2b032 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1556,9 +1556,9 @@ static int find_next_key(struct btrfs_path *path, int level,
 /*
  * Insert current subvolume into reloc_control::dirty_subvol_roots
  */
-static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
-				struct reloc_control *rc,
-				struct btrfs_root *root)
+static int insert_dirty_subvol(struct btrfs_trans_handle *trans,
+			       struct reloc_control *rc,
+			       struct btrfs_root *root)
 {
 	struct btrfs_root *reloc_root = root->reloc_root;
 	struct btrfs_root_item *reloc_root_item;
@@ -1578,6 +1578,7 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 		btrfs_grab_root(root);
 		list_add_tail(&root->reloc_dirty_list, &rc->dirty_subvol_roots);
 	}
+	return 0;
 }
 
 static int clean_dirty_subvols(struct reloc_control *rc)
@@ -1779,8 +1780,11 @@ static noinline_for_stack int merge_reloc_root(struct reloc_control *rc,
 out:
 	btrfs_free_path(path);
 
-	if (ret == 0)
-		insert_dirty_subvol(trans, rc, root);
+	if (ret == 0) {
+		ret = insert_dirty_subvol(trans, rc, root);
+		if (ret)
+			btrfs_abort_transaction(trans, ret);
+	}
 
 	if (trans)
 		btrfs_end_transaction_throttle(trans);
-- 
2.26.2

