Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E503C123070
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfLQPgu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:36:50 -0500
Received: from mail-qk1-f179.google.com ([209.85.222.179]:37347 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfLQPgu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:36:50 -0500
Received: by mail-qk1-f179.google.com with SMTP id 21so5849009qky.4
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sIkaHJ5188XjF7UhYf4jTNIcOUG/UXpuayeJR6uBMl4=;
        b=TUdCtHgMvUWcjw8VmXHvBqezXNwtGiM5oMQGXHr7JCSW+TYxMDQajttTkXF130bRpI
         T98HQlOBvPLDBjC/IzXyh+wluhis2ka3681LKaqug8J8xKET2XhctaVLPt4J9PcZ6nc4
         58FPv5Mgi8gq0ffNuikLY+faFKMjCnYsWO322JF4pGc3hct67vzaSEnGkEIRVZntQMuS
         mZHNpM9Is7LZv+KduLRAylHPKyibuR9NtJ5wvzDeJhl28pdDwHMq2MqgG90lE/xj1l9b
         p2Ox7b9EUTrrGN6kZyidPA8evgMWSu4n5i3NyinNvBNVh2epsNco5zboBOhHGlxp9FqW
         PXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIkaHJ5188XjF7UhYf4jTNIcOUG/UXpuayeJR6uBMl4=;
        b=djX0T8FF5x69Re8L+3UIemskhaaCaRQADTg7nImHKsyYVleSidJewuGcX+9oCAZA9O
         t44uGb5Bj9ePf5i6c9QtfAtpi7x4mc4pyCxpguWd5UmEnFPUAkVX1ShQI2pZIAkpE3y1
         9vKVM0KEUxlm6sf6kpwdbG5zrx3tPWZRzvcHuZe4ZoquD9Msm0DsR80lKSpSzNDXsWG8
         j6ugyXplGMaT606+THzEoLOknUIn+hsah8A9xsA53AeHBgQyaC2KRiuPOWpv5E26s3km
         zO8/X52VJbuIAkDnrb7SjZbBm6D0fpchN7F2YS0lxDb09negro1oZF9+nSn8cDerGNXs
         U+tA==
X-Gm-Message-State: APjAAAVY5Yk/igCNGfLLgY7nQt7b0fH5Ma5p7N55XyzQOHlCZZftGZCK
        FjfBCOzr0OWWCafwktLqIBHhV1rYjcsGUw==
X-Google-Smtp-Source: APXvYqw6Elb589Ga1h/SRKWU8BbwDKQcyqSgbL95Fss6potd09P/4Y018+UuiXutyTdm9n5I+uZiig==
X-Received: by 2002:a37:7881:: with SMTP id t123mr5617604qkc.155.1576597009138;
        Tue, 17 Dec 2019 07:36:49 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u24sm7258879qkm.40.2019.12.17.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:36:48 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/45] btrfs: kill btrfs_read_fs_root
Date:   Tue, 17 Dec 2019 10:35:56 -0500
Message-Id: <20191217153635.44733-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217153635.44733-1-josef@toxicpanda.com>
References: <20191217153635.44733-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All helpers should either be using btrfs_get_fs_root() or
btrfs_read_tree_root().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 13 +------------
 fs/btrfs/disk-io.h |  2 --
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2b91c40df27a..e3957d6b6bab 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1439,17 +1439,6 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
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
@@ -1570,7 +1559,7 @@ struct btrfs_root *btrfs_get_fs_root(struct btrfs_fs_info *fs_info,
 		return root;
 	}
 
-	root = btrfs_read_fs_root(fs_info->tree_root, location);
+	root = btrfs_read_tree_root(fs_info->tree_root, location);
 	if (IS_ERR(root))
 		return root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index cb12dd4825da..614802bd709d 100644
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
2.23.0

