Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3961412CB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 22:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgAQV0O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 16:26:14 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39344 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQV0O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 16:26:14 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so11374280qvk.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 13:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Y4R9rmJXTT7cwohKAVvF/8eoKZiVBpMg25xl4LibPc=;
        b=J0a64YV83t8uBAE0/cBW1DJWrEyfurrKIb1dGAWqjKa+sv01qqt9pypfcnil8Ml840
         dK/bYp4cMZ7F36hLRga4XRQexPXP2vXVXuzSOg7We/s5uu3MW/ILxOOJ4rPKA4Qvgzvg
         rLL+6EFDZIuQopt0K9WR/dR3Fz235nojObK6DXPKD66QYkQ62F7901bDz0cqEaIlTwc/
         C7piRMxbvcRlcwvtSpaQMuqJn/pBghT95Q1T0JtNDE1x2yGDEDoEKa+IhBo6IVhC6K0w
         lpeKJzuDAFGsK90AhO/P10/CxZa3RFDjwLtI7NEUQGLzl6Jce8k7FVGBdK2YVXajIlQw
         9mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Y4R9rmJXTT7cwohKAVvF/8eoKZiVBpMg25xl4LibPc=;
        b=g4ThbIWKeFGz0JMrtp3VptyUEtvXiWkaKUTFcQpV3B5lJMapEwdaWt8c1RyjH/iTL6
         82a8+jtUVKmvs0QvuadOeG0g8ZU5p3dQPStGDMNHjqxSwO6iQq6KqMxJWkVmZTKvpYLL
         LbwOpdb2NL/HL8GPUjemz9Ap0l9F3c7czv8+dmQCNvyAsS/Dm19ng85M1zJxuqcHk3bW
         9KxXHwKg2+GYuV8RNkm3877kVNEFe6UgO4TmfA3C/5GsJRqKG+xjbxA9k0V9+wWSGsNK
         TsUVbs1qcG1CoqaEKlcWkQpufAGy4ScaT7qqdoo9AZ7HctlYOaEYclmouWhvn+hkPhDi
         sefg==
X-Gm-Message-State: APjAAAUQK0ir6NS7T4i9G3YHHFoJW2L+gzAzMAhBp9cNodXiW3nO7gMO
        K3pq3K0hO718PADTmBBuiUKllwyCLL9wTQ==
X-Google-Smtp-Source: APXvYqw4f6aWSwBKJDu0ROcgKQGP6xcP/ZJkhjhPiolnt26RoY62T8/QtC3aMKEHNwdiZ86v2IO++Q==
X-Received: by 2002:a0c:c18f:: with SMTP id n15mr9622095qvh.35.1579296372496;
        Fri, 17 Jan 2020 13:26:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q35sm13785630qta.19.2020.01.17.13.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:26:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/43] btrfs: export and use btrfs_read_tree_root
Date:   Fri, 17 Jan 2020 16:25:23 -0500
Message-Id: <20200117212602.6737-5-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117212602.6737-1-josef@toxicpanda.com>
References: <20200117212602.6737-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

log-tree uses btrfs_read_fs_root to load its log, but this just calls
btrfs_read_tree_root.  We don't save the log roots in our root cache, so
just export this helper and use it in the logging code.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c  | 4 ++--
 fs/btrfs/disk-io.h  | 2 ++
 fs/btrfs/tree-log.c | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 2d378aafb70b..136a4d9d5fed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1384,8 +1384,8 @@ int btrfs_add_log_tree(struct btrfs_trans_handle *trans,
 	return 0;
 }
 
-static struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
-					       struct btrfs_key *key)
+struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
+					struct btrfs_key *key)
 {
 	struct btrfs_root *root;
 	struct btrfs_fs_info *fs_info = tree_root->fs_info;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index 8c2d6cf1ce59..158fec0eeef2 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -58,6 +58,8 @@ struct buffer_head *btrfs_read_dev_super(struct block_device *bdev);
 int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 			struct buffer_head **bh_ret);
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
+struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
+					struct btrfs_key *key);
 struct btrfs_root *btrfs_read_fs_root(struct btrfs_root *tree_root,
 				      struct btrfs_key *location);
 int btrfs_init_fs_root(struct btrfs_root *root);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index a2bae5c230e1..e6e4b00cb46c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6101,7 +6101,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
 		if (found_key.objectid != BTRFS_TREE_LOG_OBJECTID)
 			break;
 
-		log = btrfs_read_fs_root(log_root_tree, &found_key);
+		log = btrfs_read_tree_root(log_root_tree, &found_key);
 		if (IS_ERR(log)) {
 			ret = PTR_ERR(log);
 			btrfs_handle_fs_error(fs_info, ret,
-- 
2.24.1

