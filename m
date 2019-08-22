Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317EE99FB7
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Aug 2019 21:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390675AbfHVTTJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Aug 2019 15:19:09 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33752 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731916AbfHVTTJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Aug 2019 15:19:09 -0400
Received: by mail-yw1-f68.google.com with SMTP id e65so2866031ywh.0
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Aug 2019 12:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/82dJtG6j4UinFr+ajepKyt3y80xsdKCj96j2xkugQI=;
        b=QhnEBSR2h+TGx0xB9EybYkTl7kTxcoh8WuPPuu0pyq0gOUv9Q5f75asXyXSmZ3U4wm
         qC5lKs+jxs0qcWsJcgTm4ylnoLXJPmwIyRGVHtaYpiS0YAWYL8p+f2zj7fpBi9VuhtG7
         yyJj6B84seNTS4e+2RI5vTc5mcv1+5Gxn+REdSLF4fXdlK+3+mKpANMW1O3fXLN75GOR
         yZgY7PqbAMMlzc/zky15rhTRFpFYKcO6fM79f5ijYA15noUyE3idjRD6FmyaBJRkZ2iA
         7UM0aoE7l1y8n7uVrBR2RFicrd6LAbieus1jlZRKULBldUuuTEiLhYumvkHI6zPsY18G
         PGfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/82dJtG6j4UinFr+ajepKyt3y80xsdKCj96j2xkugQI=;
        b=O5HIiCNxQSe2r3+nQjaHXqAhRvSXjzqarXHFZE/bzsKPTQufNKz5QHxvWvGQgZ5M5f
         2qVF+cT1+PBvD+FY+c82QB6RP2c7ZuMI9cbvARI8tkwrpOtlsmomVcsBS0eUVgrda+ir
         C/UtzTK68JR4KGObx0LXQQrsHdJJY75/WydOcdEF97CcA/veeTMDFV042x9DrbLHTmVx
         At6ja0JvTTs9AbV5QfbN7VjX/quYpM1X6qq0h++QGL4sw2Ze9LJTnwhHW4yxJYUO3EjQ
         Ndt7yuydwrX58chZJ0enBqgg5inUK9A7P1OnV8ac3OuRbV05vR28qijgk92Eufv77L4W
         qUrQ==
X-Gm-Message-State: APjAAAViYe92huzQQwnoB4BFT/lKM9HIKEOiLGNnJitYK2h11B5f287u
        2UUplg7TTeS8qGzdhC8tVcVTJFkk2N1HhA==
X-Google-Smtp-Source: APXvYqz9+Ox3OkkfxkcOWB97Sj/DQ7vkeMM2ZipZRp8nZ5urOUWtzlrJtDp6QET3N/CbF3Ei1ZRLyA==
X-Received: by 2002:a81:1d84:: with SMTP id d126mr664003ywd.199.1566501548294;
        Thu, 22 Aug 2019 12:19:08 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d191sm278913ywh.12.2019.08.22.12.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 12:19:07 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: change the minimum global reserve size
Date:   Thu, 22 Aug 2019 15:19:00 -0400
Message-Id: <20190822191904.13939-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822191904.13939-1-josef@toxicpanda.com>
References: <20190822191904.13939-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It made sense to have the global reserve set at 16M in the past, but
since it is used less nowadays set the minimum size to the number of
items we'll need to update the main trees we update during a transaction
commit, plus some slop area so we can do unlinks if we need to.

In practice this doesn't affect normal file systems, but for xfstests
where we do things like fill up a fs and then rm * it can fall over in
weird ways.  This enables us for more sane behavior at extremely small
file system sizes.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 60f313888a7d..76be1d978c36 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -259,6 +259,7 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
 	u64 num_bytes;
+	unsigned min_items;
 
 	/*
 	 * The global block rsv is based on the size of the extent tree, the
@@ -268,7 +269,26 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 	num_bytes = btrfs_root_used(&fs_info->extent_root->root_item) +
 		btrfs_root_used(&fs_info->csum_root->root_item) +
 		btrfs_root_used(&fs_info->tree_root->root_item);
-	num_bytes = max_t(u64, num_bytes, SZ_16M);
+
+	/*
+	 * We at a minimum are going to modify the csum root, the tree root, and
+	 * the extent root.
+	 */
+	min_items = 3;
+
+	/*
+	 * But we also want to reserve enough space so we can do the fallback
+	 * global reserve for an unlink, which is an additional 5 items (see the
+	 * comment in __unlink_start_trans for what we're modifying.)
+	 *
+	 * But we also need space for the delayed ref updates from the unlink,
+	 * so its 10, 5 for the actual operation, and 5 for the delayed ref
+	 * updates.
+	 */
+	min_items += 10;
+
+	num_bytes = max_t(u64, num_bytes,
+			  btrfs_calc_insert_metadata_size(fs_info, min_items));
 
 	spin_lock(&sinfo->lock);
 	spin_lock(&block_rsv->lock);
-- 
2.21.0

