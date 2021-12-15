Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C2847627B
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhLOUAi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhLOUAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:00:23 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEF2C061747
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:23 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id t34so23059647qtc.7
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ULWo7dXnBz43mpsZKXK9aQnQ5yFxD5PDch6Mh7G+PY=;
        b=uiAuzhvkL8un13Y4YdfFFev8r7lKiOuBMkuh5arU97uPfTfraNPm3TwSZzFsOJEO7l
         UmGT4yLvbx+uTpayPE9TkaKKd31nhjSnbtThq+2HaHQUeLAkqE5CL5S+leW5BOUWgxVO
         xiv3lm28sUUezp4qODY32OjP0MSLYlVP5MvUqC9OR2SWcxf8IqYdP0GkxI7fh/ZEoXGO
         Y6/2/7Nibc2Prc0NsMxzv/NKl+4MYrMsPnsKYQVy/tgY5qUKkGvtDLuIkbJ2sIrdQyEw
         5mNZXVcsblQoyqCplAZNrNl2eGqlmB2lGc0dLWp8Qn2yFWKyE4GFBZnuSa7zQpe2eKTk
         awdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ULWo7dXnBz43mpsZKXK9aQnQ5yFxD5PDch6Mh7G+PY=;
        b=kCSUcx/iT7ElichblBCuzPaEW0P6xf2rMa+sIUVXhgBAjNqFK4LUL/sAta586wMZvp
         HcX8jkQk2Z2CQ1SPW6Z6ImT0GWpxbtQ7oPT21TuX6fJ9RyGpgxjqaHygKS2CjeZpAS4v
         ns9E0lQNQmFCs1zeN547YQU2d4pEMnfvXx/VT50BEbnl0Meb4wmYUUvV4+lrTJvZPyQ9
         uAKDUbepcrnJYnHPT8Yc5Ui/oi4JctTrYGzdsW3dohbnscv5wwY31J+MCtFcb4jJJFek
         bfJor8nYzz0EUKUHc1s2ytc86sELiB3TkI2nuA2KLYVzs02fj0Ln3vuAhjXSVXRKEZTG
         FB3g==
X-Gm-Message-State: AOAM533htt7c1iSESzM9NWTyFfhrXcMgORwclTsjwL+FlKwxlRfxtnvm
        B177RIDwLhc9yj9f7OYlWePDNtE/JlVcVA==
X-Google-Smtp-Source: ABdhPJzkHPz4kBjDVMxvLYuAuXfjEyNqJREmIe3JbVsKkTs3SNdlawCx8RIqtq8GJrQEpmuP3EVuqw==
X-Received: by 2002:a05:622a:11ce:: with SMTP id n14mr3421032qtk.432.1639598422068;
        Wed, 15 Dec 2021 12:00:22 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t18sm2220391qtw.64.2021.12.15.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:00:21 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 21/22] btrfs-progs: mkfs: create the global root's
Date:   Wed, 15 Dec 2021 14:59:47 -0500
Message-Id: <1c5aa46520695c8186ea92c1681b36ddd2b1dc8b.1639598278.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598278.git.josef@toxicpanda.com>
References: <cover.1639598278.git.josef@toxicpanda.com>
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
 mkfs/main.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 69 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index fd40c70e..beed511c 100644
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
@@ -996,6 +1045,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
+#if EXPERIMENTAL
+			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },
+#endif
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
 			{ NULL, 0, NULL, 0}
 		};
@@ -1100,6 +1152,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
+			case GETOPT_VAL_GLOBAL_ROOTS:
+				nr_global_roots = (int)arg_strtou64(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1239,6 +1294,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
@@ -1466,6 +1526,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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

