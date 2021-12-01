Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9659A465528
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbhLASVJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352201AbhLASVB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:21:01 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83CDC061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:39 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id v22so24960372qtx.8
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ZzQyX1O4+i0YK8TYwov+OiFd5E7vIpk4yBgi6KZ1DSE=;
        b=oSFR1B0PZ39WEVUrXrz+wk9H4XTgTzzKNQyWxGs+lm9Ro080LtOGkvEhOkv8kGxmr/
         ToFMrs+4LXoCa2qwqCzhCCFfGalJ48V+uKaiNTakLyTSgZH3chnINa4qWfVeC0HdBUSw
         ouzLimLCxCXE9+9ptQWp2t0Mx7o28prcH8N5QOf3id6T4uRplDg0756/0cYBrTbmpawh
         RptP97OhsG+HAhuMnuStUW2/D/+8MacpNiUbAg7YIDCoRxuHKi3tGFnemWUXlCbFX9WT
         GI/+GfxbhxB3dIwuloV/DNcuY5iYC9xyRc9UQQkA50C571XBDMoQj3dfWJn4n2F5gKr8
         jXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzQyX1O4+i0YK8TYwov+OiFd5E7vIpk4yBgi6KZ1DSE=;
        b=0caEbXiC10aWP6TM7wYrWIONfcxQdaKe5BXdy0tWSpXUCSuGp2xeWN+qKNvyduaLAn
         QRxy5+380qR45wfKMEkMMdiVWXvkn36trpA9+8fHQPr0djbaswd6VYUP9sbqbVuU+1LW
         Z+TF5zfM8Cbbgeibl5NFODg2ooEkHmpujojjwk4bONLkw2vNZlKtMsgxNMclnkXn2mFn
         ++dX5mDkyz5awStpKCwvo0wIyGsIdhaIwYosBzSF203ITTfHsVEVRVeclTs/hkYeudJI
         MllCzlW3ze26P50NRXzFG54brsMfe0I+LYCg4+siuPOiyaVepBscoZWzT3+pPfxgVEje
         3dpg==
X-Gm-Message-State: AOAM532SSwRmjPBvRmIbJMXX2pbFmnBpX7IvQ1Ifndos9y65nq4MMX7E
        dntrSkbEvNA1VD1KtxBlPtp85/yLDvF6OQ==
X-Google-Smtp-Source: ABdhPJxwvi7KiBlugEiKHElRQ1F5ZoZYFKvq4YiJUx3H1DrLJOIZ+yrWa3v5dKJQ+gLbseOCNOVdfw==
X-Received: by 2002:ac8:5a42:: with SMTP id o2mr8845466qta.400.1638382658900;
        Wed, 01 Dec 2021 10:17:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y15sm263999qko.74.2021.12.01.10.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 15/22] btrfs-progs: load the number of global roots into the fs_info
Date:   Wed,  1 Dec 2021 13:17:09 -0500
Message-Id: <821c6ec198d80991ca480cc7f628c0621ca2bf8e.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

