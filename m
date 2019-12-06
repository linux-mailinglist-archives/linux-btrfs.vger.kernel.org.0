Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5B115384
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfLFOqc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:46:32 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33805 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfLFOqb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:46:31 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so7388683qtz.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NGMNdlBlhbgE6R7u/eEFK0UZMFR6QY0Y1wGYhTUityU=;
        b=E4uyp+2FYrM+AYfN2BIhqM1lA6dA4XZvoVSmQsT45kScg+6j83dZgIPcjU3EGotgI9
         KF5WC2j9Ls8HgjwWC9wSkT2rhYVW4F32GD/TFqdDw752ZSoyOzk5m4L6mBKCx5nvpRKb
         dN+6xdiiDw8UmTOKo/m7P/pE4vXmw/qLz6IxOZGaPd1a9NIZzNWJkY4srrl4q3nJJrgO
         mMah0DD+FNLdcqyDDmJs+q0Ma3xsVtGP/HR39C/qRRGFio/FVmwItEUWviJrurV7eQXE
         lmLml8iY8yeB2/Mu+sNPUV9P+55n9KyTNB0lXGLTdtbcMJcbbjyX7SwT02lKsC3CLX3S
         o8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGMNdlBlhbgE6R7u/eEFK0UZMFR6QY0Y1wGYhTUityU=;
        b=ZWE/9VmvlVXrA4uvQ7seSrIFH5tavzez0wbWuypF65rnKOVG8J48q3dZPQHgs01HWk
         jdxf4PB6Qy7p9Vq92yQ6c/TNrcUH9EuVwsgw+DnLFGlnZUPGqX4KSZKZY6vTuKsQ92Um
         KEkw674yLk0PGO7l1ut1ug0xwdTYDxSjoITBiewlpYv8OnauT+Xv8IRQW8gUO2YgHmJL
         vAZI4ViMvzMVLKbKAhjfTkjQidZ2/v4J3scN8HJlCaZ585nvwf7C6iSZ/hJxAqTRZT7Z
         jhjPVTWep9xhuPhatKBpiYGvz6SnGCqo09GVfSSKI4ue9Ledw3mUKtFCcxzoO6cyfEAT
         8EyQ==
X-Gm-Message-State: APjAAAV8QMsj+xXskwgAmii0oGt1X1+9IYjLnZvHWxT2H5FrNKkUthnZ
        se1t2HsZ0uLlcS0gUZhhRB8AVQkiPJOwYw==
X-Google-Smtp-Source: APXvYqwOlSJ6AJg8NR/gZyhkRrsKatBRbqGa7nkkuTeydzo7Adxb7Whu9CmakVb3CLK3zCJIJnbjQA==
X-Received: by 2002:ac8:6718:: with SMTP id e24mr12903308qtp.265.1575643590057;
        Fri, 06 Dec 2019 06:46:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id s63sm5911106qkf.129.2019.12.06.06.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:46:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/44] btrfs: hold a ref on the root in create_reloc_inode
Date:   Fri,  6 Dec 2019 09:45:22 -0500
Message-Id: <20191206144538.168112-29-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We're creating a reloc inode in the data reloc tree, we need to hold a
ref on the root while we're doing that.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 3b419a4e4829..4e455703439b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4269,10 +4269,14 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 	root = read_fs_root(fs_info, BTRFS_DATA_RELOC_TREE_OBJECTID);
 	if (IS_ERR(root))
 		return ERR_CAST(root);
+	if (!btrfs_grab_fs_root(root))
+		return ERR_PTR(-ENOENT);
 
 	trans = btrfs_start_transaction(root, 6);
-	if (IS_ERR(trans))
+	if (IS_ERR(trans)) {
+		btrfs_put_fs_root(root);
 		return ERR_CAST(trans);
+	}
 
 	err = btrfs_find_free_objectid(root, &objectid);
 	if (err)
@@ -4290,6 +4294,7 @@ struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
 
 	err = btrfs_orphan_add(trans, BTRFS_I(inode));
 out:
+	btrfs_put_fs_root(root);
 	btrfs_end_transaction(trans);
 	btrfs_btree_balance_dirty(fs_info);
 	if (err) {
-- 
2.23.0

