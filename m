Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8F11230B4
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Dec 2019 16:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLQPoO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 10:44:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36255 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbfLQPoN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 10:44:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id q20so4380682qtp.3
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 07:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=kZZuE3dUXLA0QauXhepNqWc5nnwTNM04/zng1LgIsgc=;
        b=w22TNahk9f9M8sCzX2fEoMc18nS+CRHifd+XkYw+ZF8N/iwjwb2Q0SASUyWXwYs/yF
         K2yEtAIitDoYC8UWQOTQfQUbcf2xDk3gp1i6wMtuFwtMc3qmDXyhIMS1Hq6aMd6vyxFl
         1XtKYr/uUc3MfUX1tsWzXsGrdLEY8gz+tNCGMU2xB1jPbAeMTN1h0rIgzVanPY53EBVN
         xXuo7YweX79XtmbiXW8jTq6+dqab3V/FtM8L9O3RB519Ij7OhTQnkthGSwg/5oLI7f/1
         U+Osc0uCYd8xWkPLBAx7tQ/Q+5ldhd5mWrO/BmZOfYSoDMhrRk4FT4x6aqu+7UaY1FeC
         t/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZZuE3dUXLA0QauXhepNqWc5nnwTNM04/zng1LgIsgc=;
        b=bEdSPJ1r5OtIHLKGbXrNIDRnGEflY+ugnLx7XeTVCdh/kdUfbrAq3HHmfMxZ/GvWFj
         CVuTaUPPOsxsqs/nmuxWXGMJuwERVyPo54f0IfpFRThfzX6/zmGmg2KGltidN1XN9FoP
         s75cElxbwTXrsSn5CEMAvIqpUpT94jPXzXW5r3h7kK0d9epUaHAqOyNSVAc+rbao6M7c
         RpNjEP3Oirx+ZGFnAgbCMOiBgzRRXVcHHj0DKUTHSBdDrXpENj1ZOEKmcMeuvb7VX/W8
         y5y4dbxBsFcdxmnsksIBdlySCe+FRFRC2ooW+BSG/kGh+Ajj7HbQXFspZiqK7DonP+Ry
         QZCw==
X-Gm-Message-State: APjAAAUJGZSij9jLrcDWWxp55CcKFiG7icGDWzJb0cwWvlV2T/b1hp3D
        ZpSNU0c3S4J8NpYYno1+G0wFUq6ShWAorQ==
X-Google-Smtp-Source: APXvYqzFSXDn1jdxg+hgXtltmeTpi9ajfrPANaodXsemDV4+ssWFI9JyjrtxlM4EX6gU5RgV3Dxf+g==
X-Received: by 2002:ac8:4a85:: with SMTP id l5mr5086558qtq.64.1576597452623;
        Tue, 17 Dec 2019 07:44:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 201sm7212503qkf.10.2019.12.17.07.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:44:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/7] btrfs: make inodes hold a ref on their roots
Date:   Tue, 17 Dec 2019 10:44:00 -0500
Message-Id: <20191217154404.44831-4-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217154404.44831-1-josef@toxicpanda.com>
References: <20191217154404.44831-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we make sure all the inodes have refs on their root we don't have to
worry about the root disappearing while we have open inodes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/disk-io.c | 2 +-
 fs/btrfs/inode.c   | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c77a4da2a62e..cf242d3c1723 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2145,7 +2145,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs_info *fs_info)
 
 	BTRFS_I(inode)->io_tree.ops = &btree_extent_io_ops;
 
-	BTRFS_I(inode)->root = fs_info->tree_root;
+	BTRFS_I(inode)->root = btrfs_grab_root(fs_info->tree_root);
 	memset(&BTRFS_I(inode)->location, 0, sizeof(struct btrfs_key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 	btrfs_insert_inode_hash(inode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9a4bcbd9941c..f5664f02e702 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5761,7 +5761,8 @@ static int btrfs_init_locked_inode(struct inode *inode, void *p)
 	inode->i_ino = args->location->objectid;
 	memcpy(&BTRFS_I(inode)->location, args->location,
 	       sizeof(*args->location));
-	BTRFS_I(inode)->root = args->root;
+	BTRFS_I(inode)->root = btrfs_grab_root(args->root);
+	BUG_ON(args->root && !BTRFS_I(inode)->root);
 	return 0;
 }
 
@@ -5842,7 +5843,7 @@ static struct inode *new_simple_dir(struct super_block *s,
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	BTRFS_I(inode)->root = root;
+	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	memcpy(&BTRFS_I(inode)->location, key, sizeof(*key));
 	set_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags);
 
@@ -6406,7 +6407,7 @@ static struct inode *btrfs_new_inode(struct btrfs_trans_handle *trans,
 	 */
 	BTRFS_I(inode)->index_cnt = 2;
 	BTRFS_I(inode)->dir_index = *index;
-	BTRFS_I(inode)->root = root;
+	BTRFS_I(inode)->root = btrfs_grab_root(root);
 	BTRFS_I(inode)->generation = trans->transid;
 	inode->i_generation = BTRFS_I(inode)->generation;
 
@@ -9421,6 +9422,7 @@ void btrfs_destroy_inode(struct inode *inode)
 	btrfs_qgroup_check_reserved_leak(inode);
 	inode_tree_del(inode);
 	btrfs_drop_extent_cache(BTRFS_I(inode), 0, (u64)-1, 0);
+	btrfs_put_root(BTRFS_I(inode)->root);
 }
 
 int btrfs_drop_inode(struct inode *inode)
-- 
2.23.0

