Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0E2140B67
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgAQNsQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:48:16 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39575 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbgAQNsQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:48:16 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so22691217qko.6
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9u6qpskOC0taJN3qwnyWq7XSFIsCi5A4bt7jQopBCno=;
        b=WH7KgV/XH6NLwaLqncJfHwFGj8jqrhAHptPcQrCKj3fSQh/JwsYu4Lm72Af0T9v3FJ
         /AdJlRaNWp39/JtBjIP/U/Zc9nKQzJwwwA3VhEVyM+SQswD2XMBpbgjCAXqYuzM33O1Q
         Z+cv/2W9v6AOOGIw8/r1VRSnEnGt9RCWI26dng64DVNwzSfGgDwa7BEV9nNshnkHovNK
         iCdMidMylNhcCBrAcJus6st5q9LHvz+MXA+vElrjJcOoh/OMn8rjq6V2TknDxItcx2AK
         Tv1JwgDY89oUy1GJz4v+eooFEl9AyA/CyiDO7YAYzY4+oAI+t/v7LZhqfU76y+WxNhfx
         C52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9u6qpskOC0taJN3qwnyWq7XSFIsCi5A4bt7jQopBCno=;
        b=aDUGrQYbVjkX5wGveuPurHQUMgKWb6FP8NJ7tWX7Am+92UHKJaE7EdeLqaEChs9E7t
         IGPRvs23c12uMuMV9sO5619q1BE7U578SOuMxHpsj2JKYoD6PDn91TaqTeyX43sBGjhy
         cgPItg6n6olM5KthjOP/mjFf2/RXm6NWur/iq0yG9crfR0JhYVrGJRokqQnI5Q6ZLAk5
         B4vTk+lWBLagBWdOfcZ3Q1SOeJydEVV71FVMxhgY3z4N1bSSkbfTqavYFRwqLJs/d3hc
         8Aco7T83XN+tlZFXdEBUVTecUcblYWmpE3+x5DOjAzQ/euB5t9tMV/dh38fMA6kyEAkh
         aBbw==
X-Gm-Message-State: APjAAAUSk7DonvO85K4RAYr9DEudLBpAOZ1PUGkV8NWDM6qEEy652OD7
        8Bd3nJ3gk/XgLD8Y/vcGKsoEFoiZS6ou6w==
X-Google-Smtp-Source: APXvYqy8v0t334kS9OoeZBUtMoGhKOIOQrNi4hV8H8J0ITI4NMtO1Y6Z81P1et9jKXAk0aHswIRmaQ==
X-Received: by 2002:a37:c244:: with SMTP id j4mr36535419qkm.433.1579268894512;
        Fri, 17 Jan 2020 05:48:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id f26sm12811298qtv.77.2020.01.17.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:48:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/43] btrfs: make the fs root init functions static
Date:   Fri, 17 Jan 2020 08:47:23 -0500
Message-Id: <20200117134758.41494-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117134758.41494-1-josef@toxicpanda.com>
References: <20200117134758.41494-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the orphan cleanup stuff doesn't use this directly we can just
make them static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 6 +++---
 fs/btrfs/disk-io.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d13791ccb4f6..f030ff87ed18 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1437,7 +1437,7 @@ struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 	goto out;
 }
 
-int btrfs_init_fs_root(struct btrfs_root *root)
+static int btrfs_init_fs_root(struct btrfs_root *root)
 {
 	int ret;
 	struct btrfs_subvolume_writers *writers;
@@ -1488,8 +1488,8 @@ int btrfs_init_fs_root(struct btrfs_root *root)
 	return ret;
 }
 
-struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_id)
+static struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
+					       u64 root_id)
 {
 	struct btrfs_root *root;
 
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index c2e765edf034..7aa1c7a3a115 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -60,9 +60,6 @@ int btrfs_read_dev_one_super(struct block_device *bdev, int copy_num,
 int btrfs_commit_super(struct btrfs_fs_info *fs_info);
 struct btrfs_root *btrfs_read_tree_root(struct btrfs_root *tree_root,
 					struct btrfs_key *key);
-int btrfs_init_fs_root(struct btrfs_root *root);
-struct btrfs_root *btrfs_lookup_fs_root(struct btrfs_fs_info *fs_info,
-					u64 root_id);
 int btrfs_insert_fs_root(struct btrfs_fs_info *fs_info,
 			 struct btrfs_root *root);
 void btrfs_free_fs_roots(struct btrfs_fs_info *fs_info);
-- 
2.24.1

