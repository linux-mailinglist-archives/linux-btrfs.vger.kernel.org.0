Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D86611536E
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFOpx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:45:53 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:33976 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFOpx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:45:53 -0500
Received: by mail-qv1-f42.google.com with SMTP id o18so2735726qvf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sIkaHJ5188XjF7UhYf4jTNIcOUG/UXpuayeJR6uBMl4=;
        b=faOe63U7E4UdN69JQJ0Hs1GxNbW47TBskkgMQp3bAcsZAB+LPn7L3y7aeWzXz/J5+R
         2ZUN2969AxWkmPYScekLPpIPUETzTgNxLHhsj5VxR9kia3yHRGGYaFx/yodJXmjYq0pX
         23eWIhvu+ioeAKNuJZ041GlVAGpwuefTQswXGxb2YyA9peARjAAQbHVDejBsUly/LDb/
         COjy8gCmuDdJoCxLko/vhO9ERtdZizpAvVmHyK2qO7y/EPBvM77CQTBcg0ek24sy/te0
         9wXCoNBFItjt7BPBDqUrgycRGvs2Y9AZ3tu5wf4wvU812mh+qo3zztHNNdPwFN5KVr+0
         GPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIkaHJ5188XjF7UhYf4jTNIcOUG/UXpuayeJR6uBMl4=;
        b=Yvo/VMqTAhekSAMYMRKWNyo7YggoXuPhLiCxpvIZ6dmHhW+TV/ghgafsOMx0KqmVZD
         HQBE70xvxhB50pvpe5Tif9EiLcAcIpUVwhvNalsAFlFXroS+PzY7l2aRQAP4rST19tkv
         ZcNWXgT0YJ1eTIGVDsgkdoRWiZcEOo2y+0vihH6Hsob/1zL364Duh5hi4g6aXygdXWrd
         KXepdi6r8DaWfcthlluuWynbjJidbc10RL6eTLP2SNeGo5z9NgtPogYochYAm3gwShIc
         h5dbwNzKQ5a8AgAwj6tDIosxkjDGs7vMFCJdVNjn9q95wuQAovFSBCgaCfoOq9Gke7UH
         2NOg==
X-Gm-Message-State: APjAAAU3THE/PQizuRsKxKvmJJzZU3Ka3q+tYDEngE6xtilWwaoj9HH3
        SaWC0gK479KxZMhbnYTl+Cot097EeZGCgg==
X-Google-Smtp-Source: APXvYqz0/tgUMd9eLtZN9P5HPmAu/YkSC81ycI9/ooCm2WTSgdLIvZ0iZM6pxxEhCf8BsCtfJts+GA==
X-Received: by 2002:a0c:aacc:: with SMTP id g12mr13013566qvb.217.1575643551836;
        Fri, 06 Dec 2019 06:45:51 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 206sm5927195qkf.132.2019.12.06.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:45:51 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 06/44] btrfs: kill btrfs_read_fs_root
Date:   Fri,  6 Dec 2019 09:45:00 -0500
Message-Id: <20191206144538.168112-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206144538.168112-1-josef@toxicpanda.com>
References: <20191206144538.168112-1-josef@toxicpanda.com>
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

