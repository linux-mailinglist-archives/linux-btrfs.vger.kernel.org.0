Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18FB1412CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgAQV0S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:18 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:41219 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:17 -0500
Received: by mail-qk1-f177.google.com with SMTP id x129so24134698qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JbPADWcgzTRqN722WOf0d1fQvjrJwtL0qjrwv8US7iQ=;
        b=NSVnQMsJ/lHFQBdP1z2CaAVWa+yzI4dJAS++ik6wO2gTckKTHH6exp6sxYM/gRRJNr
         2gAPT4eHAM94YmNJB8eBKI76sEsb4mHpibUWzQ8TZ44IQRhbsi2dM69FPjGbnm/UW9iQ
         cTpJBPLpQtAqLrpnZvURaZay7IQckb/EF1oy3da8Dt6JQr0U2X0mSL4W222sWe7NXuKN
         dg44yA/AXu8R3bkLI1I5AQ1Oud75x+jsuaef+u8XHz1IX+mGBK74Yelx2XI8++0s2VY7
         W2H+Fd17SLwken3EQ1w6Gv9j9uAWqGKn0JyVOH1lyrFtmjjKzBLe4KxosQSwCmN0NYm3
         S9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JbPADWcgzTRqN722WOf0d1fQvjrJwtL0qjrwv8US7iQ=;
        b=prjx4dQkpegZ2aXoY4NyqMPtUX54n2hiMj9T9ELP5oLhs/Tw9mEWoufaQth/E6NK9b
         /+lMiSH7qRz2z+VKYAkbFaHkh2hc5mq5kTIcy44gZCkVKRhS/bD+W0LBck7Ewo8slFtj
         2eQCCvi8oErGpkccA+8W9CFIhl9V8qHXdk7PvmkZR41nVFPNJGSRA5Q23qEMHm25MExh
         3CQziRE53NWu4nt/lB6lfdSAjjciQN3vw9uZoj4JsXYtM8jsZcIwgls/3PjwpWd89eCf
         7cjmmAhGJZQMVzeizqK0fv/kOqGCe54TCuV9uD9IsEiv1M1R/7gve0Uu7pLvvKiR/G9F
         nhTw==
X-Gm-Message-State: APjAAAU3Bp2pVlAy5gVY9uYHmlFv+dHKKZ/i2kGH+6cr8sn4py0liQmy
        6vTxjZPpSEGUzSLPqkhFIkOseSVCn49Gcg==
X-Google-Smtp-Source: APXvYqz1AI1t/fzk/AAjLlpzGjyY3McqfwnelOZEB9znTHtBgg9RwHsjFvxxoIk0aEo72GsqOz2upQ==
X-Received: by 2002:a37:61cd:: with SMTP id v196mr40632617qkb.376.1579296375856;
        Fri, 17 Jan 2020 13:26:15 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id e2sm12104833qkb.112.2020.01.17.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:15 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/43] btrfs: kill btrfs_read_fs_root
Date:   Fri, 17 Jan 2020 16:25:25 -0500
Message-Id: <20200117212602.6737-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All helpers should either be using btrfs_get_fs_root() or
btrfs_read_tree_root().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 13 +------------
 fs/btrfs/disk-io.h |  2 --
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 136a4d9d5fed..99755d013dab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1437,17 +1437,6 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	goto out;
 }
 
-struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
-				      struct btrfs_key *location)
-{
-	struct btrfs_root *root;
-
-	root = btrfs_read_tree_root(tree_root, location);
-	if (IS_ERR(root))
-		return root;
-	return root;
-}
-
 int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
@@ -1568,7 +1557,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 		return root;
 	}
 
-	root = btrfs_read_fs_root(fs_info->tree_root, location);
+	root = btrfs_read_tree_root(fs_info->tree_root, location);
 	if (IS_ERR(root))
 		return root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 158fec0eeef2..4e43bd37f9c5 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -60,8 +60,6 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
-struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
-				      struct btrfs_key *location);
 int btrfs_init_fs_root(struct btrfs_root *root);
 struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_id);
-- 
2.24.1

