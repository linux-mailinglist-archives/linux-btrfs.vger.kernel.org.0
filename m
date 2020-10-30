Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEB32A0FDE
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgJ3VDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3VDQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:16 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D94DC0613CF
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:16 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m14so5124556qtc.12
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uS1AzD48zy+/eWvlXR0+OsODxNt6ULD82nvo8FQ7Lv8=;
        b=rTscMUjJ9mla5/IQgQfG+CzECUzxq9an/VJb0VYApBoChPvhil45yYI/C6LIIJ+Ij6
         y+ACUXYFRLQcR/igMGME6edJypF4+sjwCaJmD5r1CWV3R/Zo0mnGkffktGd59FC2UmhM
         zKXX1r7NR9n2DXr7dtVnO9HcO+LS1KPnd/Rqcpijf41ehXs8SCcX6IAFncCpy5TrhHDc
         pjBXn8d855T3E/TuHbwxMKv7I582vJK/nOtaDdT3LOrXNOt1qLR6VTPipEq7np4zIbdo
         5QExy+CvGLDf/V8Wl/YVsQxuj7L248zUKhUFEh9p8geNzcaOzbCqbnVTqCs1+KX8Oty0
         Xv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uS1AzD48zy+/eWvlXR0+OsODxNt6ULD82nvo8FQ7Lv8=;
        b=KLuWBTopTq0i7gpVSSHk/05WgO7aEkyb1nq4QMj0ipQBSvPEWxTzKEBM6a/5AyLBM3
         X51cxa8l3Jhyt4C1DTIqqeH+O8fWXuz0m7JsuINCa6yX7H/ZRJ54IqOCEZGP0SrqD715
         F9GlLdAT7eeCGpZ6Iv29oZpGHg7eV2POLLoWs7IvR17r46881t0OlX7bhcbwTZ5gLPCe
         2DFYbTThsnO5dqldqRsRDJ6IpJsakatCIuTT/u7e5GqW0nJEq0fcPQscBgCsZPNusblR
         LzS3d+O7Yis28nyzfyaPZGSIQJTU8/UvwSXT+im6D9cJD+UiwsjAh8qkL6piNEIsfXLu
         h0rA==
X-Gm-Message-State: AOAM532GjlOxv4nmVQe6YmEMmNOfId32HsMb2noYcRkYAAAiY+0+Kj6d
        9CCzJD75++2d/54lF+80L7f46TEaUEFNNeX5
X-Google-Smtp-Source: ABdhPJyTpBVKW1Hqzh7d78NuHZiiKqmXlkaMRx1su36mZpzAcvWfrzQfJkByfH4KMd0LQY9BOLlMZQ==
X-Received: by 2002:a05:622a:14f:: with SMTP id v15mr4177271qtw.245.1604091795514;
        Fri, 30 Oct 2020 14:03:15 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o5sm3431220qtt.3.2020.10.30.14.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 04/14] btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
Date:   Fri, 30 Oct 2020 17:02:56 -0400
Message-Id: <8c7e00e7c4aed3b97fc42b4c229c97760122685f.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We do not need to call read_tree_block() here, simply use the
btrfs_read_node_slot helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/relocation.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 50ca5a4f0a96..bf31b86945d5 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1418,10 +1418,8 @@ static noinline_for_stack
 int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
 			 int *level)
 {
-	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct extent_buffer *eb = NULL;
 	int i;
-	u64 bytenr;
 	u64 ptr_gen = 0;
 	u64 last_snapshot;
 	u32 nritems;
@@ -1429,8 +1427,6 @@ int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
 	last_snapshot = btrfs_root_last_snapshot(&root->root_item);
 
 	for (i = *level; i > 0; i--) {
-		struct btrfs_key first_key;
-
 		eb = path->nodes[i];
 		nritems = btrfs_header_nritems(eb);
 		while (path->slots[i] < nritems) {
@@ -1450,16 +1446,9 @@ int walk_down_reloc_tree(struct btrfs_root *root, struct btrfs_path *path,
 			return 0;
 		}
 
-		bytenr = btrfs_node_blockptr(eb, path->slots[i]);
-		btrfs_node_key_to_cpu(eb, &first_key, path->slots[i]);
-		eb = read_tree_block(fs_info, bytenr, ptr_gen, i - 1,
-				     &first_key);
-		if (IS_ERR(eb)) {
+		eb = btrfs_read_node_slot(eb, path->slots[i]);
+		if (IS_ERR(eb))
 			return PTR_ERR(eb);
-		} else if (!extent_buffer_uptodate(eb)) {
-			free_extent_buffer(eb);
-			return -EIO;
-		}
 		BUG_ON(btrfs_header_level(eb) != i - 1);
 		path->nodes[i - 1] = eb;
 		path->slots[i - 1] = 0;
-- 
2.26.2

