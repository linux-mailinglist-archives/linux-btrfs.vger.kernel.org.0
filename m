Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64B44D0AA5
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbiCGWMa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343627AbiCGWM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:12:27 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857781896
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:11:32 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id z66so13242234qke.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4dO7EOmI57n78hJcGv43Wo+wFMA9b1M/dha9Dawa7Mk=;
        b=EGQYsvShnoLDtADaM09SlL5ExX+kV44z0BjgZqBVwkE39VyQZdFp9XCEVgPQckQ0tD
         5S5ysLrGm2YCJr/gNwX1zuekcdtYMg0gOyOYRZ+F3E9liuMr5B5V5nxaNAYynuJ8Ogs5
         Ns87Gl3biOqJjgbxjjYb/hJhZxFw+PUhar0NWjSlQ6FCRsutha+vAbaGXCYCfDG5Yngn
         vQiosvgZ5FFk0GRSiT4orGMtSXqE9GKfUNbnsbzXW091IJKkAIMJsrFaU1IWOmapMyyH
         /Mw19m5ezdsof3Q8Ugus9o3NIH6z8kkQLN5vQpRhjjsKCZAOHV03+yWfqA4s1xlLDqni
         fThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4dO7EOmI57n78hJcGv43Wo+wFMA9b1M/dha9Dawa7Mk=;
        b=uBn1BoWTIjsbhZ9AdMi8E/97M65B+q/74U5QWsA7eBP/X3351ZLqJHrC4jJatxVw+l
         3sAl44iM+7nR50poEkMeSYYkYQuuKGENGn3191kDSgJXmKVwtdhvgUeSPNyFRYxnzMfO
         tOvu0rMiesGj+kqxnHH6ZTWvQ6LGdQ13BcWOI3nMatfgaikc8MPkkYzqI8uNhmkVgszE
         wC85XHmJDX5F189YkBQitAwpc1aN85MU7MOBmqQCFNpUGQKVykF5byE3kxNlOnk34TmI
         FKK8uf+r8JTP0CGd40b67LR8PGt7QLzEX7aRdjzfrp3c3aMdTnJLdbz7wQ0lnUj8p4V+
         b3xQ==
X-Gm-Message-State: AOAM533fiAOch857BO6nrx5e8dAJ+7EEpQYnMI+rTWlRoAIFXwaWvDoX
        3M0afXJlSa3b8l9bqvu3Q5YSbA2YoF2VT4cL
X-Google-Smtp-Source: ABdhPJxn6YNEj33yy0CBGH6BtqS1smKk9BI6h22LWV5qCwiwujXz1odzun1UrkDheJ2S8VaKQ8hsug==
X-Received: by 2002:a05:620a:f0f:b0:67b:f6e0:ac5f with SMTP id v15-20020a05620a0f0f00b0067bf6e0ac5fmr1618194qkl.650.1646691091563;
        Mon, 07 Mar 2022 14:11:31 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y17-20020a05622a121100b002e0702457b2sm135217qtx.20.2022.03.07.14.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:11:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 18/19] btrfs-progs: mkfs: create the global root's
Date:   Mon,  7 Mar 2022 17:11:03 -0500
Message-Id: <7cadc40e9f8510b8df5679e15881f2c0de70363a.1646690972.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690972.git.josef@toxicpanda.com>
References: <cover.1646690972.git.josef@toxicpanda.com>
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

Now that we have all of the supporting code, add the ability to create
all of the global roots for an extent tree v2 fs.  This will default to
nr_cpu's, but also allow the user to specify how many global roots they
would like.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 mkfs/main.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 19535604..a603ec58 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -810,6 +810,53 @@ out:
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
+	btrfs_set_super_nr_global_roots(trans->fs_info->super_copy,
+					nr_global_roots);
+
+	return 0;
+}
+
 static int insert_qgroup_items(struct btrfs_trans_handle *trans,
 			       struct btrfs_fs_info *fs_info,
 			       u64 qgroupid)
@@ -966,13 +1013,18 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
@@ -996,6 +1048,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ "quiet", 0, NULL, 'q' },
 			{ "verbose", 0, NULL, 'v' },
 			{ "shrink", no_argument, NULL, GETOPT_VAL_SHRINK },
+#if EXPERIMENTAL
+			{ "num-global-roots", required_argument, NULL, GETOPT_VAL_GLOBAL_ROOTS },
+#endif
 			{ "help", no_argument, NULL, GETOPT_VAL_HELP },
 			{ NULL, 0, NULL, 0}
 		};
@@ -1100,6 +1155,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
+			case GETOPT_VAL_GLOBAL_ROOTS:
+				nr_global_roots = (int)arg_strtou64(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1239,6 +1297,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
@@ -1467,6 +1530,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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

