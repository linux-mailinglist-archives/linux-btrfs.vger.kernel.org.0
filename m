Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEE014891F
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392759AbgAXOdK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:10 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:46390 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392752AbgAXOdI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:08 -0500
Received: by mail-qv1-f66.google.com with SMTP id u1so960405qvk.13
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gf4M2aChrlsQcpvrrq7JYDGrL1FKgNTCkzzAic53100=;
        b=At2FuIHj1QwgKLFOYqszDZ1y8Kqeuu7BCMulRO5sTA6Od5oY81rwuY65EBCNA5vgMv
         /1GxpxZLnkG7oTJncub6E8A1JNjH19MNXqSUOMzvNKkw6jG6pHq4p0j197bcDbbU+Ssk
         iOSxJfFvj8zb9qKzsm6GEN2VSvwA1U1t3Ix/iinQsd8NSBCy68uPc8q+Rw8HZI5qXsOR
         6DMyVK5OSBMH9eWvdK9QadltiI+zup23KcxB+z69C3pQGbgUUrDajETL8dVx0ET/cyQb
         iyqup8nGirYWePegI6N63dhryJ2U7jK/1i/fJt7tkfZOb/Ng4iS6GyxZrdJPOexxqrHO
         l7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gf4M2aChrlsQcpvrrq7JYDGrL1FKgNTCkzzAic53100=;
        b=PLCfLVadpB4LgZY2U4UY3UTliwJsVJICbEFlnKRcDG2P4Yig8Zx3eck/IhTmop+W5x
         b11FfOfmmiZf2+f9h8lOtl0wba1XpE60vbRbpcbanZBnmSO2S4vnEsu4452TmljBW+EF
         J8pr6FSYroXiY6l9j9zLVWzEvV+xB9shr4d0lGsjkIFHhmUE16XXyrT6kieyV9i7DMbf
         R1/EbMKQt3jFq5KIHcRVekmvRv+JwdDjhD9QR2An9xq6UU+nq8nRRQvQWUf78LRp/uTR
         v6QTeR7W30Z3wUs617jY1YGiM8nAJx9PpZC+H9O26IVa+jl2Q+ugSVXIv/YqYzbEy7ZC
         vrkA==
X-Gm-Message-State: APjAAAWdXKyZTV+U1hFeLNWduCafW9g2EgEosVOTQFcZYqGPYcKV1pVv
        I2vdatgmDG3pYYT3E/H+Bt9tPdXThD23pA==
X-Google-Smtp-Source: APXvYqw+JhEU4NQIEMLHz+F9cZ4x7yjzeht8mu5N6l87lfpJEdbD1bgKNGqpUORMEYRzGi00NuA+BA==
X-Received: by 2002:a0c:aee4:: with SMTP id n36mr3012216qvd.143.1579876387459;
        Fri, 24 Jan 2020 06:33:07 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g18sm3134392qki.13.2020.01.24.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:06 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 02/44] btrfs: move fs root init stuff into btrfs_init_fs_root
Date:   Fri, 24 Jan 2020 09:32:19 -0500
Message-Id: <20200124143301.2186319-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
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
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

