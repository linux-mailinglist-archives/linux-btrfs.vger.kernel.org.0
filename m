Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA732476275
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbhLOUAP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234118AbhLOUAP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:15 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1276C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:14 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id m192so21227796qke.2
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZzQyX1O4+i0YK8TYwov+OiFd5E7vIpk4yBgi6KZ1DSE=;
        b=bJunzqogCszmKQKRDHZlYHXvzTMUrkgfK5ZzywtFwHRzUgbZZ1cAqXP+J7iTNhgRob
         4YWpEVck+QasLHpvm6/BFEsLQ8EBPF/4x0E63P2/ojLLlACfQBrlJmAqgljQXDoR5Yir
         23i8CGdOXvpZJJjaneMi7aD3c+J8gIc68LYCFVl6ce9d3UhOp2bgDJDrUrwiopa8OlCO
         vGNsFE7mmztTszdAe2E7DrknKelNU6M9EAaDAas1AtCkvDF+L+Fru/MRz77SnUee1yjq
         0Ht70A3c9wPQsN11vFizsPRqwsCE4/rCMMkorRowZtGizU6QjWMtGO0JTm7x1kBDJHAx
         Bpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzQyX1O4+i0YK8TYwov+OiFd5E7vIpk4yBgi6KZ1DSE=;
        b=I5KCV5cumw0eIl6g0mfJmWVOG3rMjdxXTDWttCqONWC/fkcyRZ6VcCyStQ2runhwnt
         N0DlVHowxbZl1aJ5qcIy1SbkkdnSY24rHvSJgpvIeno6DKdxoLV5YFctULmdMmhASdFe
         duHB9QKothSnxs3oHE14boGEvY5rcIyY+GA6jgBoba/kUr9IkPG+BUXic5yjEfXmSaOY
         WlN1zsgKmr95xeJACEKB8bho9MNvnSZI/h0J7/ANtThtn6eE5oWkhaDQujZtrFGTDM89
         zu+xAoIe6wMwnxfqxdTcwWjtbZjO37jhenEol5Qk4nJxrFghjtLqTysipyq05kUGcFC5
         +RhA==
X-Gm-Message-State: AOAM530pQIzj3OnWd3v4xE0ZlR8oNZLhAnmh3MhoaTSSCjRVlaYuq8Gt
        h+eEds0IP9uY9QOa5XTFTEsYCqao1A3YBg==
X-Google-Smtp-Source: ABdhPJyoz+Azh6bltF30z+hPBIPrW//PJdQDo4GxWbFSVaJVG4nD5br4cfUQBaR0baNE3embwizY/Q==
X-Received: by 2002:a37:a617:: with SMTP id p23mr10002678qke.466.1639598413702;
        Wed, 15 Dec 2021 12:00:13 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s6sm1657077qko.43.2021.12.15.12.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 15/22] btrfs-progs: load the number of global roots into the fs_info
Date:   Wed, 15 Dec 2021 14:59:41 -0500
Message-Id: <99f0d7bfae36c86db3b063515dbfd1463f40274f.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We need to know how many global roots we have in order to round robin
assign block groups to their specific global root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/ctree.h   |  2 ++
 kernel-shared/disk-io.c | 42 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 944bec36..9530db8b 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1270,6 +1270,8 @@ struct btrfs_fs_info {
 	u16 csum_type;
 	u16 csum_size;
 
+	u64 num_global_roots;
+
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
 	 * if the mode is enabled
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index d6cc7fd3..3283120c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1450,6 +1450,44 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+static int btrfs_get_global_roots_count(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_key key = {
+		.objectid = BTRFS_EXTENT_TREE_OBJECTID,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = (u64)-1,
+	};
+	struct btrfs_path *path;
+	int ret;
+
+	if (!btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+	ret = btrfs_search_slot(NULL, fs_info->tree_root, &key, path, 0, 0);
+	if (ret < 0)
+		goto out;
+	if (ret == 0) {
+		ret = -EINVAL;
+		error("Found a corrupt root item looking for global roots count");
+		goto out;
+	}
+	ret = btrfs_previous_item(fs_info->tree_root, path, key.objectid,
+				  key.type);
+	if (ret) {
+		ret = -EINVAL;
+		error("Didn't find a extent root looking for global roots count");
+		goto out;
+	}
+	btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
+	fs_info->num_global_roots = key.offset + 1;
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
 static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *ocf)
 {
 	struct btrfs_fs_info *fs_info;
@@ -1598,6 +1636,10 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	    !fs_info->ignore_chunk_tree_error)
 		goto out_chunk;
 
+	ret = btrfs_get_global_roots_count(fs_info);
+	if (ret && !(flags & OPEN_CTREE_PARTIAL))
+		goto out_chunk;
+
 	return fs_info;
 
 out_chunk:
-- 
2.26.3

