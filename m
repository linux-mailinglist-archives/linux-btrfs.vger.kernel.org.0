Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACD44469DF
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhKEUnw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbhKEUnu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C3C061714
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id u7so8324947qtc.1
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v1VEdjxQzSY4ZUs/yFQe7Ds7wpaDkCuSP8xUp5cDKnw=;
        b=fa7t4j57tlqFEUQzsHSk/WE9sHuyPuMiOcIYwIxc6NuljQSJm+pVm13AIFRyXC2Bch
         JV5lKLn5FZbpkklgMvHBASQIvSh+bciNASyWiBO/SsgfB/DPQp/yyrrEsuOri897FntF
         xrmoGHb+vNicnIIvZrTW9J/ou4tbulg2Hv1Z78NMg9yM5kKv7xaqphAjLDRLIsqg3NE3
         ntlhsDBC2DWf5DcgzDW6GxrUWgPvRzjnVNYQ9B1uE2a9zRRG/bq3vgURcP347uZgNa1U
         JMi1ofNMQs7sOm9gUoILWLysoUSaFXrilwfbUNeXmDesMP0OnebfqyDwnw1BOMaeeGAE
         7eEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1VEdjxQzSY4ZUs/yFQe7Ds7wpaDkCuSP8xUp5cDKnw=;
        b=bAAPrblb0uYssuwK6bxN3t8r0mZKT7vv4rszZvWEsfo10HZ1UfzXLa2+ZHYa0N8BM1
         MBh+06fzj+L8hOjnjXT5NUh/cMug+iBRL1V0uXpoiGhS6sPYGzpYFKu5jLcUNmEJ6D2j
         hA3nnUUhUkycpMY5/ZNFseU4LKfjCHXAe7u+M/KJ16kx+eISUti1lbYGh6gg9d6ME+8E
         /erl7t+dot60z687v4dxwtu6rm0HQsTnfVMb9u5z6VlRpB1kLLvgWUqO2+KcKP8BewkU
         Cw5Me92z5DILXtncr6zch7pyPGc2Ar5GOGn5LdpknMbDm5WSxg03GDeuDIjcfMgafPZI
         tRsg==
X-Gm-Message-State: AOAM532+a11Dc//iFs0erzHtYe8RNBFLteIaDAD74nXIam1W2YloSs9D
        lE6MI8hxqp8FI9M+u7QbA2iirVCn/ebiYA==
X-Google-Smtp-Source: ABdhPJwhflzqtWx7yKWNXzTYVTGmHM34VA5FIDeys9zgtWn5Yey9pDCJsCnu/w36zFVLYQZMG3Tq3Q==
X-Received: by 2002:ac8:7746:: with SMTP id g6mr17369558qtu.23.1636144869730;
        Fri, 05 Nov 2021 13:41:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 17sm6412460qtw.16.2021.11.05.13.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:09 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 15/22] btrfs-progs: load the number of global roots into the fs_info
Date:   Fri,  5 Nov 2021 16:40:41 -0400
Message-Id: <0762dc7bd56880f6835b6059c49dc3b914f02cc1.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
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
index 27e31e03..c7346fee 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1262,6 +1262,8 @@ struct btrfs_fs_info {
 	u32 sectorsize;
 	u32 stripesize;
 
+	u64 num_global_roots;
+
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
 	 * if the mode is enabled
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 38741819..4c613b52 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1432,6 +1432,44 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
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
@@ -1578,6 +1616,10 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
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

