Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75776B558E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Sep 2019 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfIQSoD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Sep 2019 14:44:03 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43443 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfIQSoC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Sep 2019 14:44:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id h126so5103820qke.10
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Sep 2019 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MD6dLqCOt6gvNUDZYBcbdX7V6O6ilKUHTe5sTQPtsR8=;
        b=OnhWXRxjVRChoqTkYfiPR3qXdJugXG6zVhcx8zLKxWZCWDZQKvO8F0FI1qOf30JsDh
         dbct5UQ0bxeSI7rVbegWhLzOGKkUFVnmJk8e95pBSwkk22Ds9jTOUI1Pu5fAz0iD5meb
         x2n9G1gvKh285B+osp+bLK1iEeu/GdRxJAeuAZXAfbdo9mKLuOtYQGiyiiA8+y/mJz2Q
         uO9c9NcSt0HWoF30Qa4mldhh2XsoyKpkIvAiwcuk1AstVaSV5tczJ683c7Fi9a83EFQz
         dPctGs8jwNa6XmimgHaNQnOYOund6NV7vIe4fcX/mUGYlv/yK+7/9UuNqgktClqfFjIA
         kN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MD6dLqCOt6gvNUDZYBcbdX7V6O6ilKUHTe5sTQPtsR8=;
        b=snfnncTBF6FekonbhLam0XvpfJDEojL1zwwM5iWUFl2V2Fz4NGtisD7uB/PG57tkW6
         FWo/JCJOSxzqQMeQy5XWWrJSZuXIEdujA8JLkJyrcDUoqeeFUu47tJ1hsRwhB1Yr127a
         BtiRv9zuknq5RrbxxIhuFoKVh+iQavxCYCNQpYa+EXBBaWG3Pp/eNzzlasDivD/Oyx+D
         rF3jtHl4U8S714AntiVk+g+B/1zxaGmyhDgKqmJTIFt6ci1rGk+TlxXyVOiD18xHSPXE
         Z6jJwhhCdh/ReY75WMAPSiJsLn1hsB0qv6pKem+2EIdDJSr7CKxO54OD8dmiEp2qrz9B
         YDVA==
X-Gm-Message-State: APjAAAU3aff/qMgR+mn+rjKkgeDMIlUQHoCLRv0foGJ4RNTzS0VGOlz4
        j8Duwt+mNrNwzuIKgyzJ+GCYPJ6qZploQg==
X-Google-Smtp-Source: APXvYqzYfgSaEwyIIE+d90EwHifOIpuF+g6BoKnvi84GrleZbe5bwX7MTDLEWPV1Ly1fwbeMvOKwSQ==
X-Received: by 2002:ae9:d803:: with SMTP id u3mr5175247qkf.131.1568745839820;
        Tue, 17 Sep 2019 11:43:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id c126sm1608711qkd.13.2019.09.17.11.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 11:43:59 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/9] btrfs: separate out the extent buffer init code
Date:   Tue, 17 Sep 2019 14:43:41 -0400
Message-Id: <20190917184344.13155-8-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190917184344.13155-1-josef@toxicpanda.com>
References: <20190917184344.13155-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We want to move this into it's own file, so separate out the init/exit
code for setting up the extent_buffer cache.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 36 +++++++++++++++++++-----------------
 fs/btrfs/extent_io.h |  2 ++
 fs/btrfs/super.c     |  9 ++++++++-
 3 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d01d7575f0e9..db85c79e2f90 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -135,32 +135,30 @@ static int __must_check flush_write_bio(struct extent_page_data *epd)
 
 int __init extent_io_init(void)
 {
-	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
-			sizeof(struct extent_buffer), 0,
-			SLAB_MEM_SPREAD, NULL);
-	if (!extent_buffer_cache)
-		return -ENOMEM;
-
 	if (bioset_init(&btrfs_bioset, BIO_POOL_SIZE,
 			offsetof(struct btrfs_io_bio, bio),
 			BIOSET_NEED_BVECS))
-		goto free_buffer_cache;
+		return -ENOMEM;
 
-	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE))
-		goto free_bioset;
+	if (bioset_integrity_create(&btrfs_bioset, BIO_POOL_SIZE)) {
+		bioset_exit(&btrfs_bioset);
+		return -ENOMEM;
+	}
 
 	return 0;
+}
 
-free_bioset:
-	bioset_exit(&btrfs_bioset);
-
-free_buffer_cache:
-	kmem_cache_destroy(extent_buffer_cache);
-	extent_buffer_cache = NULL;
-	return -ENOMEM;
+int __init extent_buffer_init(void)
+{
+	extent_buffer_cache = kmem_cache_create("btrfs_extent_buffer",
+			sizeof(struct extent_buffer), 0,
+			SLAB_MEM_SPREAD, NULL);
+	if (!extent_buffer_cache)
+		return -ENOMEM;
+	return 0;
 }
 
-void __cold extent_io_exit(void)
+void __cold extent_buffer_exit(void)
 {
 	btrfs_extent_buffer_leak_debug_check();
 
@@ -170,6 +168,10 @@ void __cold extent_io_exit(void)
 	 */
 	rcu_barrier();
 	kmem_cache_destroy(extent_buffer_cache);
+}
+
+void __cold extent_io_exit(void)
+{
 	bioset_exit(&btrfs_bioset);
 }
 
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index e22045cef89b..e2246956e544 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -332,4 +332,6 @@ bool find_lock_delalloc_range(struct inode *inode,
 #endif
 struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
+int __init extent_buffer_init(void);
+void __cold extent_buffer_exit(void);
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 843015b9a11e..7207bb39f236 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2360,10 +2360,14 @@ static int __init init_btrfs_fs(void)
 	if (err)
 		goto free_cachep;
 
-	err = extent_state_cache_init();
+	err = extent_buffer_init();
 	if (err)
 		goto free_extent_io;
 
+	err = extent_state_cache_init();
+	if (err)
+		goto free_extent_buffer;
+
 	err = extent_map_init();
 	if (err)
 		goto free_extent_state_cache;
@@ -2428,6 +2432,8 @@ static int __init init_btrfs_fs(void)
 	extent_map_exit();
 free_extent_state_cache:
 	extent_state_cache_exit();
+free_extent_buffer:
+	extent_buffer_exit();
 free_extent_io:
 	extent_io_exit();
 free_cachep:
@@ -2449,6 +2455,7 @@ static void __exit exit_btrfs_fs(void)
 	ordered_data_exit();
 	extent_map_exit();
 	extent_state_cache_exit();
+	extent_buffer_exit();
 	extent_io_exit();
 	btrfs_interface_exit();
 	btrfs_end_io_wq_exit();
-- 
2.21.0

