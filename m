Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD82148927
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jan 2020 15:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbgAXOdT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jan 2020 09:33:19 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41081 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404149AbgAXOdS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jan 2020 09:33:18 -0500
Received: by mail-qk1-f194.google.com with SMTP id s187so2177417qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jan 2020 06:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bBQsI2DUZx2jdfhj90EcjcKWVKcdaVjG+fSjba7mD6A=;
        b=ZT1IMsnlqyTcBNM+HGFRfZ32+p5ia5FbueY16axy2IPf7lPH1CaexBrvTxWcCkeVYe
         AfCF27wb5UpxQIKz7ojXgMBPaYnWXqDbQaDSr3uVTAignDtDAvGQeVV9ySgUgKn2t+od
         KwM4KxhoWeKdY/SlwGbf2STWHcv0aNWP05HQvYhUQIhaBjQDsuJlYP2zcCw/R68nnV2F
         RLwPY6QpBTdfddir3ET1G3BCE2jMoWoq14fP+jMMmjAn/zhttuA93PkGblCY2lRf6q8+
         u3vpuNAqDX6twCeuwD1ZPb/Nqh/atSbAACTmZ3I5wo4VhsETGe908hyZ7Mwd6LQHHV6o
         O0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bBQsI2DUZx2jdfhj90EcjcKWVKcdaVjG+fSjba7mD6A=;
        b=qNwpCetqGicuxqLOYlmoCQDHcngw4tePC4wrrqo97fnRnis0EZQPlrE8BDZgzH1FLO
         VSCfiSefHWs9SfulDo9qSpTs52Nxz0Me6O7k99uF80EJ3wfdLpxWrZLb1BxkKu7fA18r
         oox5dnvPwtl2V0hjVDgpv2MrFk0DJkXs+H1ejn7kLBIlApYixfvTFPcyKlB2yEfbUeiz
         B7JKXxzhK3L8D5qMdStUHhlliKBTKLXqfe0HL5eniVCzLHAmA+kNzv4hnVrSH0HtAA9x
         toLOHpNUrzM0kXKBe/mA6ie5CBraNrcVpcFuO7zwE2ARIwP1qYLHakVOp9SpY0huYpdV
         ckhA==
X-Gm-Message-State: APjAAAUeoBlIp7qtSMSV+2Nzz8LGGrzRREXS0KPpdYtvd9KAOCe4HMl3
        SqUvmoDCZa1r18vBRRiWapL1gHLHKASOlw==
X-Google-Smtp-Source: APXvYqxGqDQmSNYXUDBjPFjOQwB3QJle7Wg3y8aDbkI3tLeE6ahz7fdg6ZkBgA9rCD81WZ1YxjAkpg==
X-Received: by 2002:a37:a558:: with SMTP id o85mr2882301qke.435.1579876397246;
        Fri, 24 Jan 2020 06:33:17 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id y27sm3416717qta.50.2020.01.24.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:33:16 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/44] btrfs: make the fs root init functions static
Date:   Fri, 24 Jan 2020 09:32:25 -0500
Message-Id: <20200124143301.2186319-9-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124143301.2186319-1-josef@toxicpanda.com>
References: <20200124143301.2186319-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that the orphan cleanup stuff doesn't use this directly we can just
make them static.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

