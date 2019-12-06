Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3990211536A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLFOpq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:46 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41157 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id v2so7332029qtv.8
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=99YzAon65ySDW6BX2ck3WJGLqSl97Oa341j+3cGFBLM=;
        b=i6PqTQnJnpviviP7ZMO7+MbqA+Ex80oXmuwItzY8DLULqCHM8ziKGfexSm9Qqo1zCS
         a2MEhKYVd+C8recd7ThVFFNzSso8gY2P+km2aebouQP24fqdN+qeCn2ChvbHuj22+Dv6
         qmYibm8XzlEntb02Z9CS+6Ua8fiZU9RleFvpssE7xZ42KWwUkuDqjtz8Pc3Qb78ZkWQ5
         njGCqrs7WOMWbIENzw5J1l/x09Q3oBNHrJcDIRZzOly0KcD3CwCWqV8p5k6HwNYXP+B4
         yU8x0GuSZ+ieTfc2KjdZHceo7wTzWuXypTJkVb4BQrBnZzMWSOPQhi73jjg/J6nRZMI3
         TxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99YzAon65ySDW6BX2ck3WJGLqSl97Oa341j+3cGFBLM=;
        b=e5xMTGJEvh0pPh95hNegFVVdfYihtIQ+lh5k3CPuPw2X/9K96U78DI8LghHg80fwfX
         Mg8tVgIPtpNY24QHJc+2xs9VHcMwjpfXZOH+SpWqpUsY4fcETDwzhvZ6cFaYF+fSrXS9
         EfQN3rBEnAGrlFn9qWqAg7zcNzIOrQe9hOzdEP2fs38KjO2tsWMey1uYj29VqcnjwVGU
         wm8O78YdcaVE18/IJdpWJ8o8U769lv6NN3DOQQw8nQwTbAxRVeRCTyHOLJd7wovoINlG
         J9RvGTcAVeXK7OwxeF4H3sL1siW/arrXv6a92YowvwqOh7+0ME6ivEvDExeFZ46EHWmv
         O+lQ==
X-Gm-Message-State: APjAAAXnqcfHhhq09vWJrXfQMKvQD6Gcl0iEBxeA41CGuZ5qcImXw1a3
        4926ld9j2Io7AWiTflW5qneRZ4mzMes7Lg==
X-Google-Smtp-Source: APXvYqxHkpYXU8eZxXxpQyXeVLPE1mi9btZyPwSG51nAop0PYkAstFMa3ISdwz+j/31UlyhuTynbhw==
X-Received: by 2002:ac8:65ce:: with SMTP id t14mr12928995qto.72.1575643545031;
        Fri, 06 Dec 2019 06:45:45 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x6sm5982869qkh.20.2019.12.06.06.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:44 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/44] btrfs: move fs root init stuff into btrfs_init_fs_root
Date:   Fri,  6 Dec 2019 09:44:56 -0500
Message-Id: <20191206144538.168112-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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

