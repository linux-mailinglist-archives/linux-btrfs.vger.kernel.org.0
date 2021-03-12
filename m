Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCF233985B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 21:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhCLU0r (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Mar 2021 15:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhCLU0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Mar 2021 15:26:31 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DEDC061574
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:31 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g24so4840308qts.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Mar 2021 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=8xGJ7vSM3h7aAdeJgmEsDdtP0hVwe6Q/BUIZgMIk9Qo=;
        b=IDjZCgjdAOAw/JbBozoQvvMv9wydcsDwwGaZJkN5J6BsLZJ/oFeW4Ja4VqyvfrVsKh
         lpyzJ+hsLw/gjz60XzxrZ3X1AZyMMUzgMVXwa0ig7sGTsI/v6Xl3fptLRxQScvOTLXkL
         hbzWcItEmfvex78CbL+ykB7gAxwHPzX4JQiUEul/COdiYeJe1ymilwC7aFg5A1UYZatT
         Ns9EF9FwcCY9sFoaazWGERVWoc/Mj+CcYz/aN5JfdXg+UlkrDaYSumMBWM07PTadrDcd
         ZxcwTeJ/JlSpjdHMIJ4nqqjmJIV2mH2hazcfs3B8Tedb+7KfaJzHYISnKHiFFG9ldolD
         lmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8xGJ7vSM3h7aAdeJgmEsDdtP0hVwe6Q/BUIZgMIk9Qo=;
        b=kqPiq6MhVbHKZBeNOeVjRYQnjrVVGAgbQMFRd0woCBqka4gqAg7murohFtm7R1ODBT
         kfYfI310SKvYM9sJ5M74EfvBIZprY6BOyhhhQ85ub68q0jv4FQ15BGNwvUOwxoyzgcQu
         8VuW/s6ciQJQBAN/p5phuqZLWbxjR0igKIP8AMpVjM9VNUwbdUpY5dH8iND7LjaO0LaV
         h9IT6Ue1bZfL8VfVDeSiGghRPaZ5kk0WC4xEcncccLHwuAarzLnYwenOpg9Nu4IMrJ/A
         X1JvWqatDjb6D3y8bNq6/LhJpJ13eKQ3+n4V0YUejuv552WmXxGxvLpFXLfobajzXUaM
         Cc8w==
X-Gm-Message-State: AOAM533l+h4bLPhC1ELQniveXkF4wx7OyIWmVZ3CT6VfhlnDitQt4dzB
        acCCEh6RsJDbFy5h5RMIx2lbYBvhkz8SavWO
X-Google-Smtp-Source: ABdhPJyWif4jh5JHBGSaJdWG1plVw58/w4if/fPxJBk8YCPIGPLf8HN3Gqp+nz1L2CilHaTozdqVWw==
X-Received: by 2002:a05:622a:34f:: with SMTP id r15mr13460197qtw.107.1615580790209;
        Fri, 12 Mar 2021 12:26:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id k4sm5204014qke.13.2021.03.12.12.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:26:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v8 35/39] btrfs: do not panic in __add_reloc_root
Date:   Fri, 12 Mar 2021 15:25:30 -0500
Message-Id: <a337ff56171781425fcadc9ac17c8c14203e6589.1615580595.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1615580595.git.josef@toxicpanda.com>
References: <cover.1615580595.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we have a duplicate entry for a reloc root then we could have fs
corruption that resulted in a double allocation.  Since this shouldn't
happen unless there is corruption, add an ASSERT(ret != -EEXIST) to all
of the callers of __add_reloc_root() to catch any logic mistakes for
developers, otherwise normal error handling will happen for normal
users.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 2fc04f96294e..857da684d415 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -638,9 +638,10 @@ static int __must_check __add_reloc_root(struct btrfs_root *root)
 				   node->bytenr, &node->rb_node);
 	spin_unlock(&rc->reloc_root_tree.lock);
 	if (rb_node) {
-		btrfs_panic(fs_info, -EEXIST,
+		btrfs_err(fs_info,
 			    "Duplicate root found for start=%llu while inserting into relocation tree",
 			    node->bytenr);
+		return -EEXIST;
 	}
 
 	list_add_tail(&root->root_list, &rc->reloc_roots);
@@ -882,6 +883,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
+	ASSERT(ret != -EEXIST);
 	if (ret) {
 		btrfs_put_root(reloc_root);
 		return ret;
@@ -4054,6 +4056,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		}
 
 		err = __add_reloc_root(reloc_root);
+		ASSERT(err != -EEXIST);
 		if (err) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
@@ -4274,6 +4277,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
 		return PTR_ERR(reloc_root);
 
 	ret = __add_reloc_root(reloc_root);
+	ASSERT(ret != -EEXIST);
 	if (ret) {
 		btrfs_put_root(reloc_root);
 		return ret;
-- 
2.26.2

