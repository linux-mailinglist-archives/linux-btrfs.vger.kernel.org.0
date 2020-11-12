Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2212B1014
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Nov 2020 22:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgKLVUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Nov 2020 16:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgKLVUa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Nov 2020 16:20:30 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4887C0613D4
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:30 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id ek7so3573519qvb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Nov 2020 13:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=7h5C3WcS+ENP/pj9FkziLAm6MMLb0Ad6AlPXkClgw1c=;
        b=jbWXiy5nxlk5EPNiE0XILST2FFo3IwF5pUKqSFUq7zB8chlKBnoOEanLETBFpIsFzh
         cLk7aVmDorhKUyT1gDZ5fyXI1XynM6uUK2sPRHYlIu9fDQPNfefb0C4F3FgLIeZAz+O5
         HkkESmNiMru9yNzE4eN/aO55MOmWkDahNmmletts3jvhN+i14atzqhscm4kT5orkiV0g
         hRhysBh+8t97t/D/bW8v/XWGiwtUYmgAzV2oV9nPMnrTWiRZ8aSWC+35KjsaJxYoGOMc
         c6EdwiFh/KvV4m9kdKHO8N6+g77NJwXofbxyc4+t7mt9ooL5ZU3hFCHwQ9YkWg+FVvb3
         Q4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7h5C3WcS+ENP/pj9FkziLAm6MMLb0Ad6AlPXkClgw1c=;
        b=eqItc6NQ6YXWqkpYIlSyynliGFLc4gnOY4hVbWkTPNcMKZXjrhOC9249gJaTup245M
         I/1I8lyHxVAEvUo1KTzuaIDQ+/JkKllVwqOp6CAX0HXmv/8sMTDfbvqS0jJ91LyXmYVG
         IQey5EIXpuDjeHWf9tGo1q0RdRdc9DTkcmaiWhLVhvua9J4G/W9/AvRt0VxFUGbnKB0e
         Ijjnv2ovJ6ux2JmyS09myx9vAO0csPoVbwTY1D5X/t0FqWd8aQR7pxRniX4v0UXPyLH5
         ZnvXXZrNxmPc0tR38sjfvo9U59D883GfAvhs3P155RGcmVKkSPbuZQxmLS4D2AF8hIY9
         PB2w==
X-Gm-Message-State: AOAM530mJdsMYhYySr6rjD69RJKRPngd4tGbW9qTnQs41bHcNqOKWQbE
        0La5ubqDZDFU8Rr0L4UVWjmM3kQT9jUDbA==
X-Google-Smtp-Source: ABdhPJw+9xFYeZI30QJIlh426a3FLV1gK8BkscpozDqhGY9IrcNljkA4aAP+Y33YWNkoRgb6vZeOrQ==
X-Received: by 2002:a0c:e585:: with SMTP id t5mr1769046qvm.6.1605216029553;
        Thu, 12 Nov 2020 13:20:29 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v6sm5394525qkh.83.2020.11.12.13.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 13:20:28 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 36/42] btrfs: do proper error handling in create_reloc_inode
Date:   Thu, 12 Nov 2020 16:19:03 -0500
Message-Id: <3198e5e30c93a86a8d30697a6af29ddf6a2cb66e.1605215646.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605215645.git.josef@toxicpanda.com>
References: <cover.1605215645.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already handle some errors in this function, and the callers do the
correct error handling, so clean up the rest of the function to do the
appropriate error handling.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 80d5fea41791..c6619e54f424 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3628,10 +3628,15 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 		goto out;
 
 	err = __insert_orphan_inode(trans, root, objectid);
-	BUG_ON(err);
+	if (err)
+		goto out;
 
 	inode = btrfs_iget(fs_info->sb, objectid, root);
-	BUG_ON(IS_ERR(inode));
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto out;
+	}
 	BTRFS_I(inode)->index_cnt = group->start;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
-- 
2.26.2

