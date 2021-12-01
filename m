Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7A746552E
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 19:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352279AbhLASVR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 13:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352220AbhLASVJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 13:21:09 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5A6C061574
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 10:17:47 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id t11so24975531qtw.3
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2ULWo7dXnBz43mpsZKXK9aQnQ5yFxD5PDch6Mh7G+PY=;
        b=k/aUjhEttKPqZKEXDloh6GhpIOipm2G2wUUKpV3YQU/0Cy5ddRgPcrizehZp0P9S0H
         RaS2QWjuvfBCyR/TWUmVhbHaiY90lI0ipEj33MPB4BGqzjnD/xyX51zuYS8vNp73uB+b
         WJ89CZQUfhpZBwNcwcRn+k5M20CA9nxOFUku2q4ko/SSWmhSqDy4azu2aGtKFywmHK+c
         aF66PCFXt4+ZQgolnarK6889IRnrJId3hajw5dm2LfGItdh/hRV8XW3DtcmdMsiDjmpi
         3T891YfVTGU4/oVc3Z7Ct1Z9BB/Qpcl/M+6G9Uh4dLfR9BNuBu7apLVU2VD+9AcpuwYY
         HhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ULWo7dXnBz43mpsZKXK9aQnQ5yFxD5PDch6Mh7G+PY=;
        b=KhZjfpZ8C5J2080qBp1PYz2y/Mr6zSkEKVw9KF/C88kIM6u+IHi9FLikkuQX8c/EX9
         3yYMxwtm2VpXIKbh6heDqwKIVl9ePBT5bNFG2zM+wJRQzvrnQajLSsInqbEQXiUzCaxO
         C9T6+DdLpKCMjkinh3ECw8TJl5sLkop89Vjln6lj3+XGGUo2aDgj68jQlHFNL/ioAHr0
         ZB8XTmbOrsKFcRRg++LSjzv5ATxQFLD/J4btg8jWHiYOU5xEgb5Ry+VVoSqx1+EN0HKf
         m2oe/GrkHGb96EaGBzgO33FU09cwHkUwNIn8aQZ3Po6KBODXp+xtflGRuT9ApBV9s6wA
         QDxA==
X-Gm-Message-State: AOAM531Cc+Z8nCGCsy6cOil/FDPZzGLd//4cfKdWRPVIkt49VAnjahnG
        mmqkpcF9xg79g4a8xYofeD1TxkOry3R9iw==
X-Google-Smtp-Source: ABdhPJw/HrI62GOfRCn40/XZGP0FQr8v2833X9md2KvFaslqes32KmGpGsRMT5rNkpLECF/XxZCy5g==
X-Received: by 2002:a05:622a:1310:: with SMTP id v16mr8704395qtk.431.1638382666862;
        Wed, 01 Dec 2021 10:17:46 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s7sm294501qta.31.2021.12.01.10.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:17:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 21/22] btrfs-progs: mkfs: create the global root's
Date:   Wed,  1 Dec 2021 13:17:15 -0500
Message-Id: <72c58772a7cd5824430eb0a230388bf259e3940f.1638382588.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638382588.git.josef@toxicpanda.com>
References: <cover.1638382588.git.josef@toxicpanda.com>
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

