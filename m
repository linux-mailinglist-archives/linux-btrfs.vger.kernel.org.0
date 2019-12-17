Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A6F12308E
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfLQPha (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:37:30 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:32811 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLQPh3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:37:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so6724778qkc.0
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NGMNdlBlhbgE6R7u/eEFK0UZMFR6QY0Y1wGYhTUityU=;
        b=pG4mOZdv6mGv5EVr1JtXINu/asD88+IGyCdYol1GuuMCInGPm4C1MD32snUTgxHRnD
         9m7EAI01Zb6lZoLyawdnjqNRbj56Lh8Dj9nwN+BW5vKb5nDBh4y1HaOIKfsq7u3tV9AT
         CvlMLoPaPGu2RkY/7+z1cAe3tX/JgQr5YAAhNtYwXDqW0NjMg1VXN64K2c8ZSPEOTDQ0
         1FbYLwMsblC0eH5JtVkKKM/xiyKN8+4vmgxaQRR8yFyN54H6VdkB7ydcw8ymRxDudWdr
         lSq6YVltvsdg0KAMTkGOUqTlhexuLLKhpzhlXem4ihdfUL+LkPgBDEgIc8uHM96ANSfc
         lllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NGMNdlBlhbgE6R7u/eEFK0UZMFR6QY0Y1wGYhTUityU=;
        b=Ye/WBYuah4OZj5OXce6Nhy2FDxHoews5PXL3ps9V+HyxMaEpDjgh9l9ZWfiwJhzJR1
         q0v80SlPpwAN7fH8Xcve4YRq+tUuVGImMn0cPD1/ZSb9qCodxHDroguZ2sDguuHIl40l
         dREguKuyaGvTaQgnxWxoEukI4z7rwnQeudbTpO+opOErM0wRui/jGKTysbzQ92nnD+9O
         IWdlKGOEfNt7QYdOqsVYavjvyUcVpKXUjNlqlzTEMTplAsF/lNWUHG1BZjvfcLOMMFq/
         BhAPfr4ZSmjmc9e1QwgzhaYzX/GrTUsNZoR/c+4vi53IfIrghc2T21FykQhHoVsUWw10
         X2sw==
X-Gm-Message-State: APjAAAXrerr7UWDTB0u1O5W+P/uT7D8OnTLGB8+gZCbcbz8QTbhApR36
        3QfwHaImjphK+wHjf4nPB7I02fDcLTWOew==
X-Google-Smtp-Source: APXvYqzofF/pdXZnTKcHojiwCCCisAwrKJqEQRSZcfT5/7JBd6gYJBKgfl+q1Yqoq6tZZ2ldaXOIkQ==
X-Received: by 2002:a37:6d47:: with SMTP id i68mr5747845qkc.228.1576597048553;
        Tue, 17 Dec 2019 07:37:28 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q35sm8334801qta.19.2019.12.17.07.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:37:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 28/45] btrfs: hold a ref on the root in create_reloc_inode
Date:   Tue, 17 Dec 2019 10:36:18 -0500
Message-Id: <20191217153635.44733-29-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
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

