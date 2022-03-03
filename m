Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9C4CC9F4
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 00:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiCCXUV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 18:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiCCXUS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 18:20:18 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739A314FFDA
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Mar 2022 15:19:32 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id a5so6043696pfv.9
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Mar 2022 15:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tT3zKHSOw+1OA9qq/fd1n42XgS5dcWFrdiK1St0Uoys=;
        b=xN6Z6jtSJLMar9tZjvRImESGFromc3TTxKNyrr0FiMkcKIlLVZHH14mOYmGopN/lGV
         cyywiEWljXxWAvKfdpLg7QKOVjCqIqWkttJLwVtFpZHizYk61sFNWnBUmXOmIYuQ3KSk
         Cn49lTW1bPgVdenf3eUNtz6wh931/Cu9OgZa8hOoZpr4Hu44aXx3c9PDA29ghJ5mIuR6
         0DxIZVU67FGyFBGMXoIv0ts7viC5nT3rsjwZp7f3YFKGZ6lcis9CWZjvVGztXhXpGEpc
         byKPQsVSwjzgMW/Ym0hmVeyJRocNh5hQY6nAlJYVEE3FUd6sSREmdbg2pS1tSprQlQ48
         p67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tT3zKHSOw+1OA9qq/fd1n42XgS5dcWFrdiK1St0Uoys=;
        b=rBL+vKHEYhe+kKzV9JppC0WaKF9qzAZ4CWLFxBswYEK3e15GDHic3k13p0kHBORusu
         RBnmlSYjQoBCmdcuPnb1zbbw2v+wTfcOEf2MUdtJEDVW/yOmmQTCu0Ukt0PTrEsY7co0
         ans75wf36RUaHUs/kzp+S5px3wjbIhqKTxXlNYXVdaUQ5dgPmxeRPutlodvnLOJhmy0x
         f+eNDNWZ6FIOyECpJ8w5yeas7Ll2TVqhPpdPxhjBQqgKE2liuervGr7GppkelBo9i98Y
         oG/t7TIXDoHFeK/D+LjJ9oY78qCgT1fx1rXqG0HEQ98Dcg+ECsKzo0IvHp8FBciKeaBC
         VUHA==
X-Gm-Message-State: AOAM530DTHVtSZ+GftggrAQ3w5K9/ZHv95PElMUzsGiBHr5bANO+lh1U
        ioQ2hu5DaCLYfHcyPqesYFrluMhzOWqZ3w==
X-Google-Smtp-Source: ABdhPJzpQvV8FdrwgOKMv/JfzLqlVKUp0NjVSRcJBwHvIxSpx4z6Jk72IQ3egsNC+CW6GPF7DSBxWQ==
X-Received: by 2002:a63:86c2:0:b0:37c:5844:a0e7 with SMTP id x185-20020a6386c2000000b0037c5844a0e7mr3911400pgd.306.1646349571386;
        Thu, 03 Mar 2022 15:19:31 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:76ce])
        by smtp.gmail.com with ESMTPSA id x7-20020a17090a1f8700b001bf1db72189sm1103507pja.23.2022.03.03.15.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 15:19:31 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com
Subject: [PATCH 11/12] btrfs: set inode flags earlier in btrfs_new_inode()
Date:   Thu,  3 Mar 2022 15:19:01 -0800
Message-Id: <185c84ec115df2b9dca9cb9523e9006d6e225e36.1646348486.git.osandov@fb.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646348486.git.osandov@fb.com>
References: <cover.1646348486.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

btrfs_new_inode() inherits the inode flags from the parent directory and
the mount options _after_ we fill the inode item. This works because all
of the callers of btrfs_new_inode() make further changes to the inode
and then call btrfs_update_inode(). It'd be better to fully initialize
the inode once to avoid the extra update, so as a first step, set the
inode flags _before_ filling the inode item.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/btrfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 289bb5176e09..c47bdada2440 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6161,6 +6161,16 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
+	btrfs_inherit_iflags(inode, dir);
+
+	if (S_ISREG(mode)) {
+		if (btrfs_test_opt(fs_info, NODATASUM))
+			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
+		if (btrfs_test_opt(fs_info, NODATACOW))
+			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
+				BTRFS_INODE_NODATASUM;
+	}
+
 	/*
 	 * We could have gotten an inode number from somebody who was fsynced
 	 * and then removed in this same transaction, so let's just set full
@@ -6236,16 +6246,6 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 	btrfs_free_path(path);
 
-	btrfs_inherit_iflags(inode, dir);
-
-	if (S_ISREG(mode)) {
-		if (btrfs_test_opt(fs_info, NODATASUM))
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATASUM;
-		if (btrfs_test_opt(fs_info, NODATACOW))
-			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
-				BTRFS_INODE_NODATASUM;
-	}
-
 	inode_tree_add(inode);
 
 	trace_btrfs_inode_new(inode);
-- 
2.35.1

