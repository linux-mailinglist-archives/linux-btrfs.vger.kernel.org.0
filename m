Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4972CDD70
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 19:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501997AbgLCSY5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 13:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2501981AbgLCSY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 13:24:56 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A63C09424E
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Dec 2020 10:23:47 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id y11so1417607qvu.10
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Dec 2020 10:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yQW5HdN7qO3+mPtg3gOgxaceIpJN+421WcNEAltwLCs=;
        b=fAsqEjhAWXel+zfkGaS/FkkAB28G+FMgsEe64Z3LJAohYMyEHsOB2q7rzZYZPXp2eX
         TzM4x6bA9MdY7Hy5RcXcvsL63hXR9ZVi7eHej3vALDzB0R3FYOkoV5cI53uLhVo+n6Ly
         uiCuQpUHprBF+PltJFHxuEKgTgDiNJK9Ed9K3bcwdwEXw0gU/KQ3yu2icFLPa1B+EkZd
         pPcqQKN1oESVoI52UiV+1P/7myMzt3YpU8MmwxgpmJPhuIJD5UiMBJV6hTLIE1nbK2XJ
         BRbsEFek8i4E61jVL855qfa4mjehfpjNoy7c1uBlD5c2C/pkmbhmh2D0YyS4WrF7496T
         eOZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQW5HdN7qO3+mPtg3gOgxaceIpJN+421WcNEAltwLCs=;
        b=b4XYkF171Fq4ka6YPb12T5Xk83/upt7Qw+WqHrBYrGVqZygxdzF6gv6sXG64cpIal4
         1JefBpVp1BvJevEQusb27BLvhR3fK4jn7bLt5TOYdY9Hiu+BEJD3yxELYacoX5aPlTli
         2rkBRpeuC06TEfB7nQAPeM+qPC6+yWuYfjg0N7ptpPsjahkKabcUDOw9VhpQqITg0YT6
         Vy2YoMqJ5/EovnTeKCIPdZ473BdWarBnlr92mxGuR0NZp/CHWYEVHsbK8q4JC4ntFgX9
         H+mVzrBo0TbEjZB1ZAWa3YKBGYodSG5XBkzDvwrIm8NHuS0gZIARLuUHcNQoo1BNUAkE
         gF6Q==
X-Gm-Message-State: AOAM532xP6lu4ZZHqH1O8FsQGDgUKI+L7eR6qWbBBQ2XiLHCESdnDe2J
        8V4qxAMrBNecnFvhvXfbCrcjAdr/pqSgfz1y
X-Google-Smtp-Source: ABdhPJz+PK1/KTEeLOBUS8LYhP/WTTTRuugcv2e/dpPRqFoHgTzcfd6tM4tNLC/UIlnGfEqakpqNBA==
X-Received: by 2002:a0c:c30d:: with SMTP id f13mr301427qvi.29.1607019826568;
        Thu, 03 Dec 2020 10:23:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o9sm2021498qte.35.2020.12.03.10.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 10:23:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 26/53] btrfs: handle record_root_in_trans failure in btrfs_record_root_in_trans
Date:   Thu,  3 Dec 2020 13:22:32 -0500
Message-Id: <a7e7d0380bacc8a61b70273c1e352d461cc4b098.1607019557.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607019557.git.josef@toxicpanda.com>
References: <cover.1607019557.git.josef@toxicpanda.com>
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
index db676d99b098..087d919de9fb 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -480,6 +480,7 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret;
 
 	if (!test_bit(BTRFS_ROOT_SHAREABLE, &root->state))
 		return 0;
@@ -494,10 +495,10 @@ int btrfs_record_root_in_trans(struct btrfs_trans_handle *trans,
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

