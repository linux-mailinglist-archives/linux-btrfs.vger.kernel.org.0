Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C217B2B0FFC
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgKLVTt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgKLVTs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:19:48 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86BDC0617A7
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:48 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 199so6880645qkg.9
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=eiGulEGAE+lvo9sIxjRvEZaga+VGn3FPN/aQGZte/2o=;
        b=ZYklF5rFnNV4DIblPdGfsqggGfFY8taoPKCPQwZ9/XWZmxZFt6YyEyexoQaFP30zAO
         bsMV7N2w8uK2scycRVD4kwOA0jMM7NvnI/Tam5AEJB7xhs9fm4u92uOmNAZl+ASOTQsS
         3kARGX/JeiuXNbQOJffEXacQWISir/PzFajAHhq5aA0cISLPoAKhKLqK8RZero5H53qH
         eP3N3+S9N62wgr20eXUS1jiDOaC27yuuEph1We14t6va/pYpV4frblj8bL2tO9MuKlRx
         A1sGLkKlDh+TUqWKESp7X5R8MDGsimwYvfQrUdZiZKRDm6klVuLkYtTfg9tJSFW6N7iV
         iBHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiGulEGAE+lvo9sIxjRvEZaga+VGn3FPN/aQGZte/2o=;
        b=ceuo2gv3+lZIPN5id2Ckogpf1zHyGQUZn9ez0V7CthVf5W+jvYH3H+dg0r18W5F+3P
         hGyigBlQoqYfOMxc8M1JfgdFJcRNyq5ekTuPJN2FLj+bqS/XT+GDDy2brKqP26DVA6ZY
         +rXL7lY3A8CPnxQa4lm9oPsUGAzDDg05tc3GkxNfbXF0qPJbHBbuti9j8jtd00R/tOUi
         uVfmNJzRz3En1TvTbioXeJqQW2Cja6cgTveM8LJ0TasQw948LBklM9szpofxPx5hmaj2
         qHbGHpnpMbwswgNimBycfS21jtgDBnCkQcp6gkL/qW/tQUaZLfkTWdmmTo5dRKNQpqyI
         iGgg==
X-Gm-Message-State: AOAM533/G/ixTsSOLjJV9lq3RcNVLuB/9JEnPFnB1/HmcwrzrTl2l23a
        2CW9Jj/5HrfZB/ojzyeMz9kOMxFqd0RLnw==
X-Google-Smtp-Source: ABdhPJw+eEAEDfE3EB5N1hMGDxJTkIvRxyVxr1HJK8/c/tXWgVX0CfpXWVEo3HJYVyBnvQC0fTz6cg==
X-Received: by 2002:a37:7206:: with SMTP id n6mr1884983qkc.208.1605215987472;
        Thu, 12 Nov 2020 13:19:47 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm5482331qtp.66.2020.11.12.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:19:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 18/42] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Thu, 12 Nov 2020 16:18:45 -0500
Message-Id: <cdb90d4b1989b6d56025839b754969032dda0b87.1605215645.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

record_root_in_trans can fail currently, handle this failure properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/transaction.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 91be4a1a6bc8..f255274d4cb5 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -483,6 +483,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -497,10 +498,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 		return 0;
 
 	mutex_lock(&fs_info->reloc_mutex);
-	record_root_in_trans(trans, root, 0);
+	ret = record_root_in_trans(trans, root, 0);
 	mutex_unlock(&fs_info->reloc_mutex);
 
-	return 0;
+	return ret;
 }
 
 static inline int is_transaction_blocked(struct btrfs_transaction *trans)
-- 
2.26.2

