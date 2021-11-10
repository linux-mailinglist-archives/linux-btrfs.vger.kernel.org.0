Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE38944CA65
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhKJUST (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbhKJUSM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:12 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A3C061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:23 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id s9so2621797qvk.12
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=SKGRoZVyRIhIFS9j5yih7mnRt9o7yGL40NFu4E9zMZ8=;
        b=b5RmU1ZEMmfBp0/FXC+NREO0+Z9nWWCQ50h3iOiNBgttc9H1SwLYSDlwZSbNRxf8ez
         dCCWW7WoGy/XaWQFS6HLewUqCSkQyISV+M/f3PBm2BYsnub8OCpw8qtRaepYwqqLvHYv
         dKOtXOP75t1EgF2+6qJcExF78e/NeHj0vXcg+B+t1+c1WZJ1TwVhhBOX7DXfHQjYJOyk
         U0vA3EdWv0hw0KBhRYkWZuVEHNPEHznWijMkvtbb3dKHVC0xJD8OJLV8Vu82lrkZqTA6
         LS3klhguDtDNyb6Vj8kRG6JeQnIPBWQrlNayEWdYV1OCMLhROmAAIZ9Wj5Vy6uft2NhK
         ddoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SKGRoZVyRIhIFS9j5yih7mnRt9o7yGL40NFu4E9zMZ8=;
        b=C2yst83CeMCv33YmksVxd6133C8Fe/VEa6X9mpaSzOzFHg5r5LL+zQHOcDQKGlWAmC
         ipn+Oc2lFoZn8+mMlPFimL9Sou/BpucGkUWlM/FX+gljmycimlJxQKavrMFoVb2NF5gl
         VXJ/ZqpfoIq8SNUfbFy42pFzuQPk+8xUS9LckgEnDt7JdT9Os5bOPGKOH67mfO2jjSAN
         FkMkRNficjx8Bx3PmKTdGmJ7GQJxTet0dWJVVrpcKCVsn1k2qtzmKRLNhmqV0s1CJluJ
         /Xq6dIIJmSKtDfG96NYo37prq1AC5/oIoZ/tavZDp3Qus9+lnUbl9gx6m1Vz46NlJnXS
         V2Rg==
X-Gm-Message-State: AOAM533sw3GC97QZZ4vRLS6jLRWim5AzloYKyHxBbGZpNTE3gMfTVabC
        dxi0HZW5mqizZAto9tK5A43zo8rukhDWgg==
X-Google-Smtp-Source: ABdhPJzzEr9rzK9OlIchu0kEwbGHhS2e0DWOScb9fUgjFvhGl6/Rk8ozQ09qAwsL9d11v1Rc/OOw2Q==
X-Received: by 2002:ad4:5f88:: with SMTP id jp8mr1320444qvb.57.1636575322920;
        Wed, 10 Nov 2021 12:15:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w9sm495296qkp.12.2021.11.10.12.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 23/30] btrfs-progs: load the number of global roots into the fs_info
Date:   Wed, 10 Nov 2021 15:14:35 -0500
Message-Id: <41917010546bdd5fa0ff84a0cbf0947d14818967.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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
index 9295cb5c..de868085 100644
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
@@ -1596,6 +1634,10 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
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

