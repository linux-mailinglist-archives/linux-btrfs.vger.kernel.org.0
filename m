Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A00A5C2DB0
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Oct 2019 09:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfJAGxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Oct 2019 02:53:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45334 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAGxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Oct 2019 02:53:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so7207584pfb.12
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Sep 2019 23:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UFA7UcSmWxP1iu4wssbL3TRNJUhqfXY+xFvv9teYss8=;
        b=ax4sJXP6s3jCoZ8QGbNwKo59lBd9A2VK+/fD2idOTRtrMhsuUNCvwz0xiXdlRJXEn2
         QGQE310fEhcIVUPlSCmQBSoy/r63Rzopc7bvIZLn92tAeltktfsUdrIKafB4N28Lh9iN
         CtcdTFRP0Gnu8V0lW2HfY8FaaedCqQEiwD//mDV/a7BxQ1/Gshm+J4qIPBkgO3yP6oM5
         h0R4cSdVxDZe/PCRl+6PWrZ3P/x6NfW0rqqD0KbSAhyCAsaaHb9Kqfvx/P66ubVvQznL
         BorwyvKpkxfqMAzpKIjUxTsXk4+sYABBJ37O93uqxFAMi6eqLnvY8lv2eeXZI7DtGT4B
         IFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UFA7UcSmWxP1iu4wssbL3TRNJUhqfXY+xFvv9teYss8=;
        b=mcHU8t0Zm3SrPzoS4EVDOOS2hI2NG9oihl2Zrq4tuNJ9qW5ZXmEVU6v/KnfCVfPhzJ
         LZ8BaEZflsQT5yjPO+pQpZbMJjqwd/DWdaafUobIIG1rZqKt0IGMZjfbf4LBsKVQmn2G
         x7HPNgnOqBSiWrzBcP78+ddsgoxf+amCSb5k2jmxAih1UQWl02wHre65iIWTMJJPjJka
         g6pBquu+4ul8FjaVqhsDiH7cV5UyB5RehZ+tCSWCfVJdxvYvvSU3+T2fpG1BcZA9yGdn
         nj9izuPmCXbzjNAPw9xpmuUjS01WKJ/uOT3VwPaimmZa3dYYwFuGtbi2HGoL0LOSPb7I
         DtLQ==
X-Gm-Message-State: APjAAAX4tpSURI7IgCVp1s9Xo/eEq9QZRAF7PWFE/wTZngA9uKuTf7p2
        XQpODk7cx2s2hqM+Hh/aeYE=
X-Google-Smtp-Source: APXvYqyWQcqAtWBQcPADZV4Jetm7JnvZp67hPqTzFdtbzXnMRwMJIYzk9CRV5PwEcilubOVxwt8qoQ==
X-Received: by 2002:a63:f342:: with SMTP id t2mr27713998pgj.194.1569912817177;
        Mon, 30 Sep 2019 23:53:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:16a7:e082:2043:a667:769:f528])
        by smtp.gmail.com with ESMTPSA id o60sm1948229pje.21.2019.09.30.23.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 23:53:36 -0700 (PDT)
From:   Aliasgar Surti <aliasgar.surti500@gmail.com>
X-Google-Original-From: Aliasgar Surti
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
Cc:     Aliasgar Surti <aliasgar.surti500@gmail.com>
Subject: [PATCH v3] btrfs: removed unused return variable
Date:   Tue,  1 Oct 2019 12:23:20 +0530
Message-Id: <1569912800-9381-1-git-send-email-aliasgar.surti500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Aliasgar Surti <aliasgar.surti500@gmail.com>

Removed unused return variable and replaced it with returning
the value directly. Also removed the unnecessary forward declaration.

Signed-off-by: Aliasgar Surti <aliasgar.surti500@gmail.com>
---
v2: Made btrfs_destroy_delayed_refs() as void and removed its declaration
v3: Reverted back the change where the function was made void from int
---
 fs/btrfs/disk-io.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 044981c..e381368 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -52,8 +52,6 @@
 static const struct extent_io_ops btree_extent_io_ops;
 static void end_workqueue_fn(struct btrfs_work *work);
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root);
-static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
-				      struct btrfs_fs_info *fs_info);
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root);
 static int btrfs_destroy_marked_extents(struct btrfs_fs_info *fs_info,
 					struct extent_io_tree *dirty_pages,
@@ -4255,7 +4253,6 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	struct rb_node *node;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_delayed_ref_node *ref;
-	int ret = 0;
 
 	delayed_refs = &trans->delayed_refs;
 
@@ -4263,7 +4260,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	if (atomic_read(&delayed_refs->num_entries) == 0) {
 		spin_unlock(&delayed_refs->lock);
 		btrfs_info(fs_info, "delayed_refs has NO entry");
-		return ret;
+		return 0;
 	}
 
 	while ((node = rb_first_cached(&delayed_refs->href_root)) != NULL) {
@@ -4306,8 +4303,7 @@ static int btrfs_destroy_delayed_refs(struct btrfs_transaction *trans,
 	}
 
 	spin_unlock(&delayed_refs->lock);
-
-	return ret;
+	return 0;
 }
 
 static void btrfs_destroy_delalloc_inodes(struct btrfs_root *root)
-- 
2.7.4

