Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509044469E5
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Nov 2021 21:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbhKEUoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Nov 2021 16:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233663AbhKEUn7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Nov 2021 16:43:59 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B957C061205
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Nov 2021 13:41:19 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id v4so8306316qtw.8
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Nov 2021 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4NDH1tuc2pvqldmE4sy7rWt9BZCp5dsON+4fNMVLQ3Y=;
        b=m1QaAzYgnQ3xYPu9J4/KEv922sAn4FVhcv1U9rAGQl8jzzmdFL+5+Y9Fy229i/jzY/
         PbehpEmj6q8mOwp86Jcuihcuxg4u0NN8lAXMI+yHN/cJmrvSHNbQhn6j5SWkNunFbk3d
         2QcKkmXoyE74sPlM20T4KyWte0jl2djiJveeNGTyl4lCabXxaoCuTowTA814glzK96f9
         AEKrqr3K1z7baZrjV0zagef/5jEVwCNDt8+4qzQjfF43JxaveQ8YGKH95t6YjNhQaVcp
         mcCA3UAHUtzgiDMFPyfmymDZbd9uM3S8D404EEktCa8SU87K6mptg7UiYMhnwueesl0K
         RGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NDH1tuc2pvqldmE4sy7rWt9BZCp5dsON+4fNMVLQ3Y=;
        b=2Beb58SxAPH41eF8Cx58a+nS+Fl9Ac1mh7ScySWiDEJ96U3KecUPqHqIWfj+qh44PS
         2P2TgJT0Q+Y5pg9nAY5vMCiBAueUeaLhBKVKNMNRTtfRot0LxVIPjlcZCs4LHgZ6BfDc
         LHeUJYPd0g4YbCdPo5jjbdtgsJAisZ++UzKN/FNxbgQkBiUg2U7HvsFDD7Jahq/kQ888
         TND9De4GMAi9QzG+4rs6NNrh6QGFGxlzwrPSd1KqPU/C8WsXrWUaY5gjgsT1u6+YQ3T/
         MGDClJgZIY5BiwUMEdjklADoO+gU7LFnQj2Axd+Cxadr1HTb7Fr57CbyLyIMNK3QwmRU
         HIhA==
X-Gm-Message-State: AOAM533cg9W87Eu3W3ZLhcfU1S4FCoAN7aEkd2fZYaquD5ZVLtTt5qlt
        MJviSo7stc1851gRGYfQhrBNjwINWZ/Rlw==
X-Google-Smtp-Source: ABdhPJysB6oQu0u6UsHPUtN64Kaga0uy+RidSVwnFUjrBHUDypEy/IrUo9xY04eJW39qSSepoBNpfg==
X-Received: by 2002:a05:622a:90:: with SMTP id o16mr44715818qtw.84.1636144878069;
        Fri, 05 Nov 2021 13:41:18 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e12sm6162972qtj.13.2021.11.05.13.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 13:41:17 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 21/22] btrfs-progs: mkfs: create the global root's
Date:   Fri,  5 Nov 2021 16:40:47 -0400
Message-Id: <f4448aa8e35dcfb7fe699d03be564529451363b9.1636144276.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636144275.git.josef@toxicpanda.com>
References: <cover.1636144275.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have all of the supporting code, add the ability to create
all of the global roots for an extent tree v2 fs.  This will default to
nr_cpu's, but also allow the user to specify how many global roots they
would like.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index fd40c70e..8959fd8b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -810,6 +810,50 @@ out:
 	return ret;
 }
 
+static int create_global_root(struct btrfs_trans_handle *trans, u64 objectid,
+			      int root_id)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_root *root;
+	struct btrfs_key key = {
+		.objectid = objectid,
+		.type = BTRFS_ROOT_ITEM_KEY,
+		.offset = root_id,
+	};
+	int ret = 0;
+
+	root = btrfs_create_tree(trans, fs_info, &key);
+	if (IS_ERR(root)) {
+		ret = PTR_ERR(root);
+		goto out;
+	}
+	ret = btrfs_global_root_insert(fs_info, root);
+out:
+	if (ret)
+		btrfs_abort_transaction(trans, ret);
+	return ret;
+}
+
+static int create_global_roots(struct btrfs_trans_handle *trans,
+			       int nr_global_roots)
+{
+	int ret, i;
+
+	for (i = 1; i < nr_global_roots; i++) {
+		ret = create_global_root(trans, BTRFS_EXTENT_TREE_OBJECTID, i);
+		if (ret)
+			return ret;
+		ret = create_global_root(trans, BTRFS_CSUM_TREE_OBJECTID, i);
+		if (ret)
+			return ret;
+		ret = create_global_root(trans, BTRFS_FREE_SPACE_TREE_OBJECTID, i);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_fs_info *fs_info,
 			       u64 qgroupid)
@@ -966,13 +1010,18 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct btrfs_mkfs_config mkfs_cfg;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 	u64 system_group_size;
+	int nr_global_roots = sysconf(_SC_NPROCESSORS_ONLN);
 
 	crc32c_optimization_init();
 	btrfs_config_init();
 
 	while(1) {
 		int c;
-		enum { GETOPT_VAL_SHRINK = 257, GETOPT_VAL_CHECKSUM };
+		enum {
+			GETOPT_VAL_SHRINK = 257,
+			GETOPT_VAL_CHECKSUM,
+			GETOPT_VAL_GLOBAL_ROOTS,
+		};
 		static const struct option long_options[] = {
 			{ "byte-count", required_argument, NULL, 'b' },
 			{ "csum", required_argument, NULL,
@@ -996,6 +1045,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
+			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
 			{ NULL, 0, NULL, 0}
 		};
@@ -1100,6 +1150,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
+			case GETOPT_VAL_GLOBAL_ROOTS:
+				nr_global_roots = (int)arg_strtou64(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1239,6 +1292,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
 		features |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
 		runtime_features |= BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE;
+
+		if (!nr_global_roots) {
+			error("you must set a non-zero num-global-roots value");
+			exit(1);
+		}
 	}
 
 	if (zoned) {
@@ -1466,6 +1524,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if (features & BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2) {
+		ret = create_global_roots(trans, nr_global_roots);
+		if (ret) {
+			error("failed to create global roots: %d", ret);
+			goto error;
+		}
+	}
+
 	ret = make_root_dir(trans, root);
 	if (ret) {
 		error("failed to setup the root directory: %d", ret);
-- 
2.26.3

