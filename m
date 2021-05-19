Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA1389284
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 May 2021 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbhESP1s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 May 2021 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbhESP1s (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 May 2021 11:27:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227AFC06175F
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 08:26:28 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id 1so10420468qtb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 May 2021 08:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb/eRjQaPjbdBpaNWq59IkJEfVXKuCgkvd0C+qTcx8w=;
        b=GvDWfXvwCEdcSHWDEF6xamxTAjFGhyvIIG25s85bGHFUGzsQaSpVb5hIsaKrLKCbOL
         nPsOj9dE2d8KuWpNgA2+0l3zPLXyKk1MhMeZ/UgYg+4H1foZoqcsrGbFtVahhAtQiOQz
         EVoz8NIajqQBG1NOa4AibykB3jKNKV10K40o6G4yDzUrqK3rhFSpzQURYG/CsaMdPhST
         4uu5xK7MUtkUjQQoU5ENKuU9DlNPGvvMzRQ4Fqhs8l48jWfo+W+dNpDlzkOnIclh+ewW
         chwmBw0iEANWRERXek5qXHjxwaGcLxYN2OSk59h/DRtF4T0MJ6fDKZnhb6aN7g1OgUBS
         k8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb/eRjQaPjbdBpaNWq59IkJEfVXKuCgkvd0C+qTcx8w=;
        b=gG6L64sZa/UaTaLTCr4ML80MXTOD5axcOT082P7t7ue0zisCU0Js1OHO+4EknHx0op
         k31uyW+adph+LnlntfQ9xyj0rjjIPWeF6w5k+Xw66m8169xnCzP17Yo/v2vhZrjDMrCp
         uhV0tmwlxh6VIOPd3k5/KmQColcon0pQ9iIZ8kSMX/NmZr8+jJwrfAQZZX9B09Ir8cQS
         tLuOjnMiHMJntraIKmMfOZgagENThQtHOH+PMQtecYFa9Uhcn6lEK6ui05KWoTKTdFBV
         icHiYS2nruWMlzj8AKfVGAOITqxgrjMlzT8ElUDkVh6Jm9BI3+2RXixDLj4Hk2SGuWg+
         T1iA==
X-Gm-Message-State: AOAM532YWxAiAnrNeeyoDj4gtOXEK2WzKGYIrZrwzukAXqbDc7DND/XA
        4p/XEd/tqwF37XItO5L+XhQpIz7Yki5JCw==
X-Google-Smtp-Source: ABdhPJwbAmlLSXaADudCuBvXbC/OfVMfkL6c4DEUp4Ug8u3uAJDwwZ2kG0Mm34NBebkx0tnzpCPaZQ==
X-Received: by 2002:ac8:b8c:: with SMTP id h12mr11602810qti.171.1621437986813;
        Wed, 19 May 2021 08:26:26 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 64sm2203460qtc.95.2021.05.19.08.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:26:26 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: check error value from btrfs_update_inode in tree log
Date:   Wed, 19 May 2021 11:26:25 -0400
Message-Id: <2661a4cc24936c9cc24836999c479e39f0db2402.1621437971.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Error injection testing uncovered a case where we ended up with invalid
link counts on an inode.  This happened because we failed to notice an
error when updating the inode while replaying the tree log, and
committed the transaction with an invalid file system.  Fix this by
checking the return value of btrfs_update_inode.  This resolved the link
count errors I was seeing, and we already properly handle passing up the
error values in these paths.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-log.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 326be57f2828..4dc74949040d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -1574,7 +1574,9 @@ static noinline int add_inode_ref(struct btrfs_trans_handle *trans,
 			if (ret)
 				goto out;
 
-			btrfs_update_inode(trans, root, BTRFS_I(inode));
+			ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+			if (ret)
+				goto out;
 		}
 
 		ref_ptr = (unsigned long)(ref_ptr + ref_struct_size) + namelen;
@@ -1749,7 +1751,9 @@ static noinline int fixup_inode_link_count(struct btrfs_trans_handle *trans,
 
 	if (nlink != inode->i_nlink) {
 		set_nlink(inode, nlink);
-		btrfs_update_inode(trans, root, BTRFS_I(inode));
+		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
+		if (ret)
+			goto out;
 	}
 	BTRFS_I(inode)->index_cnt = (u64)-1;
 
-- 
2.26.3

