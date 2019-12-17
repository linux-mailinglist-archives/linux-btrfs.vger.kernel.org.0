Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6912306C
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfLQPgn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:43 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41314 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:43 -0500
Received: by mail-qv1-f66.google.com with SMTP id x1so3009749qvr.8
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=99YzAon65ySDW6BX2ck3WJGLqSl97Oa341j+3cGFBLM=;
        b=qztekvUU5WgI0l/vHQBeqzoShmz/aGiorZALJ35pUIFUBmmD+N0rZiegTbgbl+CApX
         1yZ6zDH6TAQGJ8xHhTx2ECoH68nIesnOJfCriQ9xQrJCJZ40eHuvsaJraYJtqBNkmd39
         d2Qj5LaBvz5EcBsrHulxyenr3sajTLGoywP1mYZ/XluFNREBLL3TWL/p7ilKDPjkqzP8
         LOB5ebMcJ64QvINEOcpn2ebHmIxpFP0kzw2l6qxUYkn4YZ6Dw3BIGsC+wnpXdEmzzqPp
         YMPpc8FhlvscNyLBMHh4mvjbyTOx9myTc5FAYR2ou/jTdVDxahcM3FNYlB9EnM+Vah1s
         FBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99YzAon65ySDW6BX2ck3WJGLqSl97Oa341j+3cGFBLM=;
        b=eDy6/oP8fYbIJlLWss0Cx+VQCArxrkGBzbm1ezhxeJxuKKI0PA7HV+Kgu73Ib4Qbxq
         JBlMQs2DPobpvkxJVTAMAn1xz0Yj6dh2x8zWOba4EGb10uvRjKEcf/QrhDHE1eC9k2aJ
         mGwuLL8Lotn5MRjfn9PO0ewVvliy0wtNieFe2llmTZql3Y9w9yAHwy3wQgRcBRYgA5VJ
         DuCEwdeiHZltdR4+Kq3KQTl7WMXszRxFePYoitDF9vtEf/tgdjsNk5XsyxWKDVjppNIu
         HfkqbdR2CpuLr9X9d7dRlGoB110TDVZCe4pRNaKEywUDPLJFRUYgG2EjVCSL70UU9Flj
         2o9g==
X-Gm-Message-State: APjAAAXmoUoHnn9dTxUp2wUC18puDJdIdT/TIbq0hYiNdlPmeylSOjAc
        Vi2wrpGLOHuZn9vuAKyJPwobCFKM8A4MkQ==
X-Google-Smtp-Source: APXvYqzbsyz0wc2+qH93pT6lFdwdl/7oJymFepGUlCO3oxvklAamWdymFq9ydqqIKtvalkocAPRTdA==
X-Received: by 2002:a05:6214:1150:: with SMTP id b16mr5214240qvt.71.1576597001999;
        Tue, 17 Dec 2019 07:36:41 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h1sm8433059qte.42.2019.12.17.07.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:41 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/45] btrfs: move fs root init stuff into btrfs_init_fs_root
Date:   Tue, 17 Dec 2019 10:35:52 -0500
Message-Id: <20191217153635.44733-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have a helper for reading fs roots that just reads the fs root off
the disk and then sets REF_COWS and init's the inheritable flags.  Move
this into btrfs_init_fs_root so we can later get rid of this helper and
consolidate all of the fs root reading into one helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ee0ddd4f45f0..c65825029553 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1447,12 +1447,6 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 	root = btrfs_read_tree_root(tree_root, location);
 	if (IS_ERR(root))
 		return root;
-
-	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
-		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
-		btrfs_check_and_init_root_item(&root->root_item);
-	}
-
 	return root;
 }
 
@@ -1476,6 +1470,11 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 	}
 	root->subv_writers = writers;
 
+	if (root->root_key.objectid != BTRFS_TREE_LOG_OBJECTID) {
+		set_bit(BTRFS_ROOT_REF_COWS, &root->state);
+		btrfs_check_and_init_root_item(&root->root_item);
+	}
+
 	btrfs_init_free_ino_ctl(root);
 	spin_lock_init(&root->ino_cache_lock);
 	init_waitqueue_head(&root->ino_cache_wait);
-- 
2.23.0

