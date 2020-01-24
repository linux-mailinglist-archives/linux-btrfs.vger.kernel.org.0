Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F98148925
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391744AbgAXOdR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:17 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:33589 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389147AbgAXOdP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:15 -0500
Received: by mail-qk1-f175.google.com with SMTP id h23so2224419qkh.0
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qq+HaOFw8uEZw7ZngYuiXmV1vIKHpMK4mZuBf1yE9OY=;
        b=JSwxiF+hCcznUVJ67MEJ/UXgAdkIJxpUltn6jLdfDiEWdKETID2yZd3pZQyTdEOwMP
         MQE5CnAzu3iTWOOAInVVHcrk/FAmP+uWXQc5VbZ42JBLZMXc3u/3SYPPwWCc2PIYVC0j
         CfhSzHYnJXUcy+jujnr7UusZwtjvY1iZ/PCCC/eUxxUbUsP8SxCU6w4fjKIwL0LFBNHn
         wMKOfsjEIiGdZA1E5poTNP7YdtsSZS02TLQGCcLpuTMOvboZ7ZD6+Ln/jRF5qrxQlUiN
         1mE4cyi9Sa2nOJqYau1v1omdOHvDKdG5oz2nAPtOYr+37QHwRCbhiYQCwP0ZPqUt9/iz
         eoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qq+HaOFw8uEZw7ZngYuiXmV1vIKHpMK4mZuBf1yE9OY=;
        b=a3ohnTQpa9aYnabAZI2yTZ1eKuJGHjY742skf6/VXf6wDFsWq0V/OkxNmxFTG2KYvj
         bkaVF4nZTXvSSbat68rVWWGuk5VTDgcwnKIAiWlQfCLM7vhUoRpJweE0Kl2uE7E9s3Qy
         ggUQ3lfqOwm+LCNMkM6epY3r5iLwk+loRT0jsoHyUBHJ0Fe3fDOcQg8tN5vrIX9aAJ8K
         G7AbC6bFBEsfUr8e2PphfvPFF753UNuGi9jTrt5CPlSTxykURkUSXLfyiTSPtCWfx9Ji
         uRVRcvn8/vGSCMEU6H5ZAg5jce2qQdwS1UVzR58jFCrO/9Lc40JpWYchMrvZNzaqyjBT
         rSWw==
X-Gm-Message-State: APjAAAX22jJhFlC0ooQKgCa7FRL6FwmhssHSDpeDU8NWojNn5hZO6IjB
        MMrpFmHYXR/uj8opv5gJD1jXaw==
X-Google-Smtp-Source: APXvYqwLOjBF1N7nol/llCowuwkjal0h+wuxa1KxC7AyAZ7sTfR8luHmn8UiZRJo/6iX6Yl9WLiAqQ==
X-Received: by 2002:a37:9f41:: with SMTP id i62mr2686957qke.272.1579876394014;
        Fri, 24 Jan 2020 06:33:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g18sm3134679qki.13.2020.01.24.06.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 06/44] btrfs: kill btrfs_read_fs_root
Date:   Fri, 24 Jan 2020 09:32:23 -0500
Message-Id: <20200124143301.2186319-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All helpers should either be using btrfs_get_fs_root() or
btrfs_read_tree_root().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 13 +------------
 fs/btrfs/disk-io.h |  2 --
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 136a4d9d5fed..99755d013dab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1437,17 +1437,6 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	goto out;
 }
 
-struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
-				      struct btrfs_key *location)
-{
-	struct btrfs_root *root;
-
-	root = btrfs_read_tree_root(tree_root, location);
-	if (IS_ERR(root))
-		return root;
-	return root;
-}
-
 int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
@@ -1568,7 +1557,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 		return root;
 	}
 
-	root = btrfs_read_fs_root(fs_info->tree_root, location);
+	root = btrfs_read_tree_root(fs_info->tree_root, location);
 	if (IS_ERR(root))
 		return root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 158fec0eeef2..4e43bd37f9c5 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -60,8 +60,6 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
-struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
-				      struct btrfs_key *location);
 int btrfs_init_fs_root(struct btrfs_root *root);
 struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_id);
-- 
2.24.1

