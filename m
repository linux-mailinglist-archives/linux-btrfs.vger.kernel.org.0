Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4214D0AD6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbiCGWS6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343708AbiCGWS5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:18:57 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DB0443F2
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:18:02 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id t18so3677137qtw.3
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QEGGZK1+cxJioX8WrC4yhSCAAtDdBPhH1AZ0eY1rRxc=;
        b=wLOPSTvqHZsd62aRVmhMgGwA3u+6lJULEv+qu8cU0L7M0QRPB2MZwhhUYQTQQAxLGw
         wCCJYcoYTe/EgHvn1rA12c+hgzpwdyvdi6idEaDszq2R5Xh4/ndrjZFsLLYhCC207Oyl
         HNeumaN1zgmkMpWmQt3m94ARvauUBuu6AO83R46HWYvzozNG3nF0ZxnAqCs5vRJcatjP
         BbMUxbTlAwXrP6Tw8RR7n0H2ixJwMptceo2EqBT35ucjNLWpnY0AL7THo/1N5O6fdnD8
         /OLJ07vOt/xoXsPF/iY7fUT8Tjlu2QLBL9Mz7RmISEssym+CSNwLMA7qSJXxKdBV0/XQ
         r2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QEGGZK1+cxJioX8WrC4yhSCAAtDdBPhH1AZ0eY1rRxc=;
        b=ENsHrpakCmMss6fohBQ+Ehligvo1NeZAYwBAGMuYmIGlj9WjCbL6Gr9XqtZ8Nm6Nr/
         x8cM7s97wS0HkvWKjfTbRZAy5Z04W6Xk5DfYEixcTjXh8txCLoPVz7XcMtOm510pLXNp
         Kpa1HnZj/GkzLs3kHeHagEwOu/hQtkOPwhXz/5qhg/h2nJIK/DrLMAfdYiobGMsfj/A7
         BB7DnxKI4JwaFR3QlNBhccRj6zovLyzUGZHyATiDT0Xbiqw1HnfNxQOv/6OM4RhiJgzG
         i15IzmjVPQ2iovtVHX/GQgrH+cjD81/mt2ptZDFJUTEIgjNudVzvSEw+DsBtUQuMtzst
         qLKg==
X-Gm-Message-State: AOAM533WARjETuEzTBt03Ap63KdTfxK1u50Kaw+00WSzuRVi6gF+xoJg
        xV/u4CoNYzMqUJGyc1b37YXjKuCQUOPqBaVZ
X-Google-Smtp-Source: ABdhPJz7OXCfYI4ijKZfJDcrhx6UD0gsvovfV97Hzm1tVXo5dQAZFTeTbEmgg8ljQVsPVhST2dgvqw==
X-Received: by 2002:a05:622a:4ca:b0:2de:91c4:3d7c with SMTP id q10-20020a05622a04ca00b002de91c43d7cmr11413555qtx.618.1646691481874;
        Mon, 07 Mar 2022 14:18:01 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l19-20020a05622a051300b002dff3437923sm9234322qtx.11.2022.03.07.14.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:18:01 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 08/15] btrfs-progs: make __BTRFS_LEAF_DATA_SIZE handle extent tree v2
Date:   Mon,  7 Mar 2022 17:17:42 -0500
Message-Id: <88b0a009d897fb0961360fd2ac9e1cd094b187a8.1646691255.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691255.git.josef@toxicpanda.com>
References: <cover.1646691255.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a larger header we need __BTRFS_LEAF_DATA_SIZE to take
this into account if we have extent tree v2 set.  Add a bool to this
helper and adjust all of the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 convert/main.c          | 2 +-
 kernel-shared/ctree.h   | 4 +++-
 kernel-shared/disk-io.c | 9 +++++++--
 mkfs/main.c             | 8 +++++---
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index b72d1e51..52afd7ed 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1228,7 +1228,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	mkfs_cfg.sectorsize = blocksize;
 	mkfs_cfg.stripesize = blocksize;
 	mkfs_cfg.features = features;
-	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
+	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize, false);
 
 	printf("Create initial btrfs filesystem\n");
 	ret = make_convert_btrfs(fd, &mkfs_cfg, &cctx);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 7d4fd491..0ee5357a 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -367,8 +367,10 @@ struct btrfs_header_v2 {
 	__le64 snapshot_id;
 } __attribute__ ((__packed__));
 
-static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
+static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize, bool v2)
 {
+	if (v2)
+		return nodesize - sizeof(struct btrfs_header_v2);
 	return nodesize - sizeof(struct btrfs_header);
 }
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index bd316b46..3d99e7dd 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1642,15 +1642,20 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 	fs_info->csum_type = btrfs_super_csum_type(disk_super);
 	fs_info->csum_size = btrfs_super_csum_size(disk_super);
-	fs_info->leaf_data_size = __BTRFS_LEAF_DATA_SIZE(fs_info->nodesize);
 
 	ret = btrfs_check_fs_compatibility(fs_info->super_copy, flags);
 	if (ret)
 		goto out_devices;
 
-	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
+		fs_info->leaf_data_size =
+			__BTRFS_LEAF_DATA_SIZE(fs_info->nodesize, true);
 		fs_info->nr_global_roots =
 			btrfs_super_nr_global_roots(fs_info->super_copy);
+	} else {
+		fs_info->leaf_data_size =
+			__BTRFS_LEAF_DATA_SIZE(fs_info->nodesize, false);
+	}
 
 	/*
 	 * fs_info->zone_size (and zoned) are not known before reading the
diff --git a/mkfs/main.c b/mkfs/main.c
index 17b3efc1..995b0223 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1025,6 +1025,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 	u64 system_group_size;
 	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
+	bool extent_tree_v2 = false;
 
 	crc32c_optimization_init();
 	btrfs_config_init();
@@ -1195,6 +1196,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		print_usage(1);
 
 	zoned = !!(features & BTRFS_FEATURE_INCOMPAT_ZONED);
+	extent_tree_v2 = !!(features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 
 	if (source_dir_set && dev_cnt > 1) {
 		error("the option -r is limited to a single device");
@@ -1305,7 +1307,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	/* Extent tree v2 comes with a set of mandatory features. */
-	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+	if (extent_tree_v2) {
 		features |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
 		runtime_features |= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE;
 
@@ -1499,7 +1501,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.features = features;
 	mkfs_cfg.runtime_features = runtime_features;
 	mkfs_cfg.csum_type = csum_type;
-	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
+	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize, extent_tree_v2);
 	if (zoned)
 		mkfs_cfg.zone_size = zone_size(file);
 	else
@@ -1541,7 +1543,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
-	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+	if (extent_tree_v2) {
 		ret = create_global_roots(trans, nr_global_roots);
 		if (ret) {
 			error("failed to create global roots: %d", ret);
-- 
2.26.3

