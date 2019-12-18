Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5782123EC8
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 06:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfLRFS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 00:18:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47009 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFS6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 00:18:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id y14so528535pfm.13
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 21:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K/5Zlarazvm7rWxihrjM2Qo8yD9mwGdvuxH+eDY5RQU=;
        b=pehxWl8R/LZkQVPKgvK5hZiLg1h4pyP+jzc3HRyPCvQtXV5w0TL3kPhz/BfHdjBQ8R
         c3whRmCodfXmIS/kqsHZT2x1nCF8kb39Hyb4P8Pu+8OYV183uDjFk/dhTGcDxhWbyeCq
         9vo6pTj9cEdsENY+79V/sWD0ctDAQDKDiABmphklvyHQw/BUAnBO/ZhqPl90HD6q+Q2X
         W26GlPjSGEoZpf7q219OYFLnfVgC6BB1tQ3nu4H03/4qM35x2fdM28kdRIJ5/GZlm2gY
         gp8GlQWLjdpC7yi/5J2O5F89aOGPtfS5oLD/IGAt+/ABHb4nqxn8vdStfLNqxL5b+pe3
         c9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K/5Zlarazvm7rWxihrjM2Qo8yD9mwGdvuxH+eDY5RQU=;
        b=GJPVbPkC5yqzEQzMXcseZ6kHr2c7mobYziEgpKbaokKpf4Dt+nRhrkUMHrQZtshkq9
         1S2bOj4S/0NfKCzslZeGWIBOkzQ5fJ+jDuRfF/3MYVCRc5mz+aUJBx+GQCxkJ6B0QBmc
         TpdwgQ52ED2zvpbJo0LgEi71Xh1Ik6xk0Hg9MDu5EDcMXAslnDpRhgbSD26c9cbZcl7N
         5H8L9rvxk7QzJNTqNuKV938yZOJJt43wwSPvbG0/qrD/idPiDzxd41+qMEWIjpOy0rQ6
         9pbcGIXUBQKjqEvZj/WScKoOdkLX+lZUoSbf98+DuZMq4a3snc5P9Uig0o2/tXSfxoZL
         66dw==
X-Gm-Message-State: APjAAAUJhEGoW217JBX5O+LvYGqg/uQPtegIWBQN5Y1vDfIZtRzBFZJd
        x++dZYb0Mw7kqnd1pdEZKfhDKXlcmu8=
X-Google-Smtp-Source: APXvYqxD/R11ZL+4xNBYzNmL1Ym7TQrMPbG7K5DecjKzvANaZoUEkPYBqQiHWdcZOx/7XpAKDpRWBg==
X-Received: by 2002:a65:4587:: with SMTP id o7mr800173pgq.303.1576646337935;
        Tue, 17 Dec 2019 21:18:57 -0800 (PST)
Received: from p.lan (81.249.92.34.bc.googleusercontent.com. [34.92.249.81])
        by smtp.gmail.com with ESMTPSA id e2sm1014781pfh.84.2019.12.17.21.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:18:57 -0800 (PST)
From:   damenly.su@gmail.com
X-Google-Original-From: Damenly_Su@gmx.com
To:     linux-btrfs@vger.kernel.org
Cc:     Su Yue <Damenly_Su@gmx.com>, Qu Wenruo <wqu@suse.com>
Subject: [PATCH V2 02/10] btrfs-progs: block_group: add rb tree related memebers
Date:   Wed, 18 Dec 2019 13:18:41 +0800
Message-Id: <20191218051849.2587-3-Damenly_Su@gmx.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
In-Reply-To: <20191218051849.2587-1-Damenly_Su@gmx.com>
References: <20191218051849.2587-1-Damenly_Su@gmx.com>
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
Reviewed-by: Qu Wenruo <wqu@suse.com>
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
2.21.0 (Apple Git-122.2)

