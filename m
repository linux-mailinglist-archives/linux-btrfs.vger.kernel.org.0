Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F444140B60
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgAQNsF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:05 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44227 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQNsF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:05 -0500
Received: by mail-qt1-f193.google.com with SMTP id w8so7369348qts.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6tD3SkNSKEEDG/aoBeQMkgM5wsm9ZuZ73HSUNDHrHH4=;
        b=CUkx1LrmxnbpTqriSQ6E59EJeMzip5RW1+/WOB+OGauFJDXi1WeTU5bqTBwtMbWC/n
         9SJKK6qWkwpeY9AXrxmwEISyj1+8CAhPPDiC9AAvhvdOlyYysQhEAwVH37q6GATK2AR5
         qbyGl9J425Dc2yCuov9qNCD7m2ly9bmh1z3Qdod8skAUS2LNHFwF0e7Ril2hn1DuVh9n
         j1nuExu3+BVScxVTtQU8mvHcd4C/4XW+haWLFYLCRCEx7xPNCDgC09xmeTp1Yc9HbGS5
         PqMaCaGenw6jKGdexk0VqZU2J9Gll0aNuw/CVyP7W4PZ3n7aFIuXsMqCQRcDEFhoMGor
         Dfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tD3SkNSKEEDG/aoBeQMkgM5wsm9ZuZ73HSUNDHrHH4=;
        b=H2IogROUBN7/3RhuxsZk7vZVabHxzcNwGkndQeJfHhptoh4n0DKda3xkD+Ehnx1N7e
         22PkHfDBP4s4ZhWrdZJag+tZiT4DJ8psJKfElXCt3n76ixmTbKABflpGyFs77MEJ7IVp
         uWvNOA15KHjO98/68SqaeSQvC0kzzsvK1ABDqYf5z/c+ujYGY4CPVQ+OzGS0ZDj0evvc
         rQlv7ZBxVxz4aVMkKjYwvaK9Pfu4rDltpcD27xWZk+g5+di1ZEO54FNhrOQT0Fmtf/jR
         9MB0E/YtvpA9xe6cUfS5jtIm6h1xp8eKmkWhm/zPontiSBxGbFgha8C01GDOQkPhu30Y
         /0+g==
X-Gm-Message-State: APjAAAXxQFjw7zRTejvyAMMEsToAhnXKsOoegcdhhUiaRa4vped2j9mR
        6RoqLIVDexUI5CX1Q+9N8XrkT7BJxU7naw==
X-Google-Smtp-Source: APXvYqxFmlpGwuHJCwdWZBxBZhUfJqCeqLPB467X2WHUy714p1gAuVy3unKOfKp0YcMAFVhH4eMryg==
X-Received: by 2002:ac8:21ec:: with SMTP id 41mr7771553qtz.242.1579268884042;
        Fri, 17 Jan 2020 05:48:04 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x19sm12949150qtm.47.2020.01.17.05.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/43] btrfs: move fs root init stuff into btrfs_init_fs_root
Date:   Fri, 17 Jan 2020 08:47:17 -0500
Message-Id: <20200117134758.41494-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
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
index 1dc33e95052b..2d378aafb70b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1445,12 +1445,6 @@ struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
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
 
@@ -1474,6 +1468,11 @@ int btrfs_init_fs_root(struct btrfs_root *root)
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
2.24.1

