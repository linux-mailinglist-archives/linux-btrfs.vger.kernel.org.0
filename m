Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06CA2D12E7
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Dec 2020 15:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgLGOAF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Dec 2020 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgLGOAD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Dec 2020 09:00:03 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A96C094256
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Dec 2020 05:59:10 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id y15so1814052qtv.5
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Dec 2020 05:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VtoHf3L4vkokxUxrJ85QLQy4x/t7HOVGr2Oo/WULWZo=;
        b=K5Ph/tXbtaCZqbXoTOY3ir4APnsJQHDhT8bygziA6TugIHjYOxMJLQttJvQIHCxdRc
         6mSSPMjvFgwGWTEuI55UCy66a2R13+k2CfJHzZGb1bMJf0SkCOnR9wA8ZbZCrJCpA+78
         m0fax/BESyWYQm3R1Q2UY8RHrcdlFPLvmajHR12QwqAHWF6KWPg6JZ9tQZkFCCnlc203
         Z0QhkuMF9vu0KeaLug+/JU7Yk4apwVwf72bKPs0Ay4bdvY9FXjcel39jWaT3HoE2w1Ic
         7VIhxXwzT/RCF9zX14/okIwjdCwYBVVabFNWY5vDoEfIkYIsSE3HydF5BYK7s5396/K+
         wAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VtoHf3L4vkokxUxrJ85QLQy4x/t7HOVGr2Oo/WULWZo=;
        b=QgYTzxYjJ9b9kknI4N8/irgsQn/xQD5LJA//AfEhRVJL/7p0QZb1A4vplaMa2kfJOg
         Og3kgWDyu9Qs5DXqOYeh/KJGcsbxqxPeGZGqbJlvg6LLCRkE/J/J+3OKXw8rXowCpAdo
         JTGKdCI9dw4QgatvXILs5CEHO7OsID0ct6aUumQu9lKGmggVNoPTZ/JBXNTLyYEQ3wWi
         cMsHX83w+oZb80j4G6Korm+OgDHhlHeUoIPWycvgUJS2vb1bbdCFcuyRzfEf69aV5d7E
         U1T47SJw8FYm1ibLvbABd8mrJl5fbb/8Spt2X9a13jCJV9SCoEbMdqu69nnT9T0AGbIe
         qS9Q==
X-Gm-Message-State: AOAM5334iqXtQMC5UY1rz+vJMJWlfC4nytOw53QB+xq0mOAZzvEksbtL
        R4Irjp7SrLJuLgdxYEyssYXApGAMUBcZehoH
X-Google-Smtp-Source: ABdhPJyYZLS59NB2+fnpiRzey0ai8qYLKh5LCU+Ig4Jk0ks5WXM+w8qMxnxrCRUKtI6PVjvwIa3LFw==
X-Received: by 2002:ac8:4e87:: with SMTP id 7mr24055969qtp.310.1607349549556;
        Mon, 07 Dec 2020 05:59:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r14sm11671444qtu.25.2020.12.07.05.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 05:59:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 43/52] btrfs: do proper error handling in create_reloc_inode
Date:   Mon,  7 Dec 2020 08:57:35 -0500
Message-Id: <4cda23044ad985171779b582f89bb08415da8380.1607349282.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607349281.git.josef@toxicpanda.com>
References: <cover.1607349281.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We already handle some errors in this function, and the callers do the
correct error handling, so clean up the rest of the function to do the
appropriate error handling.

There's a little extra work that needs to be done here, as we create the
inode item before we create the orphan item.  We could potentially add
the orphan item, but if we failed to create the inode item we would have
to abort the transaction.  Instead add a helper to delete the inode item
we created in the case that we're unable to look up the inode (this
would likely be caused by an ENOMEM), which if it succeeds means we can
avoid a transaction abort in this particular error case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5227b4f7d115..05b42a559da3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3601,6 +3601,35 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+static void delete_orphan_inode(struct btrfs_trans_handle *trans,
+				struct btrfs_root *root, u64 objectid)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	int ret = 0;
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	key.objectid = objectid;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
+	if (ret) {
+		if (ret > 0)
+			ret = -ENOENT;
+		goto out;
+	}
+	ret = btrfs_del_item(trans, root, path);
+out:
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+	btrfs_free_path(path);
+}
+
 /*
  * helper to create inode for data relocation.
  * the inode is in data relocation tree and its link count is 0
@@ -3627,10 +3656,16 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 		goto out;
 
 	err = __insert_orphan_inode(trans, root, objectid);
-	BUG_ON(err);
+	if (err)
+		goto out;
 
 	inode = btrfs_iget(fs_info->sb, objectid, root);
-	BUG_ON(IS_ERR(inode));
+	if (IS_ERR(inode)) {
+		delete_orphan_inode(trans, root, objectid);
+		err = PTR_ERR(inode);
+		inode = NULL;
+		goto out;
+	}
 	BTRFS_I(inode)->index_cnt = group->start;
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
-- 
2.26.2

