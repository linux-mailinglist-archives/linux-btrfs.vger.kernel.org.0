Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5400113ACF
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 05:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbfLEE3g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Dec 2019 23:29:36 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40581 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfLEE3g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Dec 2019 23:29:36 -0500
Received: by mail-lj1-f193.google.com with SMTP id s22so1876803ljs.7
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Dec 2019 20:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fEkU+lExaC8aMF1om9LYbS9c3bG5vp2JC6PTWezjjGo=;
        b=R8DjRi52qQ6und8wkAeshRBm9UnEh6JkA5XzMawm27NrHuqC7yEV1YXgCWi2l/hvip
         Y+YwT/qkh86dOSzJg8UgOmbXLz0loP6lFrc42MQ1dkzEfmX4y3WBwhgNqK5AHupa4NCA
         Wgo/nHSdL1zuJIesSd5t+xS2Zi87MpKvLlBmmefKmzCoNnlJqZQFLWk93qJXY3iVrp+c
         VOxXVUQKO84cS9IBUxS/ZFeaFxNMJh6ezGycEg/HHp/dsPI4sb4vyINwwiN+MxAb08vt
         dw3KwxoLLcviEsLpS7Bvam/P0jOMW+2QzNQHIg02vxmQK1GscxG97QY9hoPNGzkYgVxG
         OV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fEkU+lExaC8aMF1om9LYbS9c3bG5vp2JC6PTWezjjGo=;
        b=IvrLfcid5YdFUUeM67qHw2RClTFCDYIo2ZczR+BVSOufZdJs+QmS74VY1XMRsYFhmD
         /rvaEQH3+gnsivPIkvBbad91xblmNmgE7AUJUetglMW4/sM00ct/UqTRaEdRuCUEGzee
         z09jEcgsqbhRlSeGvaNeSZUvqJmXouVIkHjED3RSoU4+BVibHynOL7OgwHMC5Qp4N1G3
         MCmJ/jnwPvMSx6iR2wyqQ1G2xNWWt7MvFGH1MjPaPZIF4MWkSRF6Id9jW1uv3t2A+MU4
         2pU+Ye17YgMtXlP1GbuwWM6oFxhrKgjg44wp0zhoxR+Yu2MGL9euoLTwQE73nlXhoLYD
         1nfg==
X-Gm-Message-State: APjAAAXxFhIh18tEXmGLNE0gdZNRvt212XESjTYcj7Z3Dd4giNWBp4KP
        QWqOmX2Yng4cSAYJbGwjxIv/vpBFHNo=
X-Google-Smtp-Source: APXvYqzftnHPnlXmL85e+Ic++jjL5n/erFtMU2n2aTHtThMXQQnjsQiKz5fPJ1yOEngBMsUU0WAbdA==
X-Received: by 2002:a2e:7d0c:: with SMTP id y12mr4088519ljc.39.1575520173629;
        Wed, 04 Dec 2019 20:29:33 -0800 (PST)
Received: from p.lan (95.246.92.34.bc.googleusercontent.com. [34.92.246.95])
        by smtp.gmail.com with ESMTPSA id c23sm4170865ljj.78.2019.12.04.20.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 20:29:33 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>
Subject: [PATCH 02/10] btrfs-progs: block_group: add rb tree related memebers
Date:   Thu,  5 Dec 2019 12:29:13 +0800
Message-Id: <20191205042921.25316-3-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191205042921.25316-1-Damenly_Su@gmx.com>
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Su Yue <Damenly_Su@gmx.com>

To convert from existed extent_cache to plain rb_tree, add
btrfs_block_group_cache::cache_node and btrfs_fs_info::block_group_
cache_tree.

Signed-off-by: Su Yue <Damenly_Su@gmx.com>
---
 ctree.h   | 21 ++++++++++++---------
 disk-io.c |  2 ++
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/ctree.h b/ctree.h
index 3e50d0863bde..f3f5f52f2559 100644
--- a/ctree.h
+++ b/ctree.h
@@ -1107,16 +1107,18 @@ struct btrfs_block_group_cache {
 	int cached;
 	int ro;
 	/*
-         * If the free space extent count exceeds this number, convert the block
-         * group to bitmaps.
-         */
-        u32 bitmap_high_thresh;
-        /*
-         * If the free space extent count drops below this number, convert the
-         * block group back to extents.
-         */
-        u32 bitmap_low_thresh;
+	 * If the free space extent count exceeds this number, convert the block
+	 * group to bitmaps.
+	 */
+	u32 bitmap_high_thresh;
+	/*
+	 * If the free space extent count drops below this number, convert the
+	 * block group back to extents.
+	 */
+	u32 bitmap_low_thresh;
 
+	/* Block group cache stuff */
+	struct rb_node cache_node;
 };
 
 struct btrfs_device;
@@ -1146,6 +1148,7 @@ struct btrfs_fs_info {
 	struct extent_io_tree extent_ins;
 	struct extent_io_tree *excluded_extents;
 
+	struct rb_root block_group_cache_tree;
 	/* logical->physical extent mapping */
 	struct btrfs_mapping_tree mapping_tree;
 
diff --git a/disk-io.c b/disk-io.c
index 659f8b93a7ca..b7ae72a99f59 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -797,6 +797,8 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr)
 	extent_io_tree_init(&fs_info->block_group_cache);
 	extent_io_tree_init(&fs_info->pinned_extents);
 	extent_io_tree_init(&fs_info->extent_ins);
+
+	fs_info->block_group_cache_tree = RB_ROOT;
 	fs_info->excluded_extents = NULL;
 
 	fs_info->fs_root_tree = RB_ROOT;
-- 
2.21.0 (Apple Git-122)

