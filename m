Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5A1412D4
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAQV0b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33424 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0b (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:31 -0500
Received: by mail-qk1-f194.google.com with SMTP id d71so24191130qkc.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HKt/gyH0Knlxys+g/v0pjWvfo/9TSnmMRROcvEGAxbM=;
        b=14qDreLYG+Iwi5LVEEcNrCBnehZX1Fd42CviMZSqs3zXj1cKJP9M2DSaPrkaf7M+ec
         HPlNrIyWFJPj+9ItmRo3+mwSORd8HKwvmZ+TnUyz8sknLYyyaYK4G4JUd96NkI+3njkc
         ZCzstGQ+HZAECcq4GR/OCpWqwvE+Iw4sWymfZEAcwF3rwfYm4W0s+lKOE36kCGl3Czey
         FLE3sbkIqj4s65TNMqeFRc93V3+4bs7d/qPzkZq6YCFlBgdbiVrUL1SAo5AdOrv9nL+j
         fWACRdJFkT5JI3jYKRulECbHizkxYxz5IjmP0tLuT6ZgC3MT7cH8nKtG+W42/TrLoCaP
         cA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKt/gyH0Knlxys+g/v0pjWvfo/9TSnmMRROcvEGAxbM=;
        b=WrHTqAJVlJ3AxGpKan4sku/DOcqH5NZLVc9yv5X7NhhIsBcVgBq/GP+R9i+7xSZfYd
         pHnt3NYZ4Gzkd+RO6FrkaqjYZNksa5QBp7d+V02V+jFPo9/huJtOkJhiNy5VqKOcXYIT
         IWpXZsiDRhPQ3JwhWghC7HOY+aB43wf++j/7rGYb/aMsCiBZ5cCKlmyONE0ihgjb9ZUR
         b61bUhDSUvCmAvHJ3VkxH4eoghvr35hZy2knimveuaJHYd0lb8m8d+LJKSmSX7WyyAeV
         5duoSMBgKPqyrNL7qhigJh0Pf4kkrZNnr/Sr2E+DZhHoqoh86GoaPX13+g7C040r0V+f
         PGgA==
X-Gm-Message-State: APjAAAViZreOcZbunZ4cErsM0n5ebtYbUmSl9wL2JWm4VKVCEjiMiozE
        gcPUADQ1Bcp1CGKw7SI7ricvk2oRds0bdQ==
X-Google-Smtp-Source: APXvYqyaKWPBn31yLp/84f0lI2xYmL+M39+2tVhZyHiJxZb/e/3LSafqMjOuvUs0Mv9KRe2WCNwE7w==
X-Received: by 2002:ae9:e41a:: with SMTP id q26mr40274533qkc.288.1579296390111;
        Fri, 17 Jan 2020 13:26:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id k9sm13584342qtq.75.2020.01.17.13.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 13/43] btrfs: hold a ref on the root in __btrfs_run_defrag_inode
Date:   Fri, 17 Jan 2020 16:25:32 -0500
Message-Id: <20200117212602.6737-14-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We are looking up an arbitrary inode, we need to hold a ref on the root
while we're doing this.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 565ae8404e1c..3abc7986052b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -292,11 +292,16 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 		ret = PTR_ERR(inode_root);
 		goto cleanup;
 	}
+	if (!btrfs_grab_fs_root(inode_root)) {
+		ret = -ENOENT;
+		goto cleanup;
+	}
 
 	key.objectid = defrag->ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
 	inode = btrfs_iget(fs_info->sb, &key, inode_root);
+	btrfs_put_fs_root(inode_root);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
 		goto cleanup;
-- 
2.24.1

