Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD85453490
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 15:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbhKPOs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 09:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237744AbhKPOsS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 09:48:18 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38892C061764
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 06:45:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id bu11so13963606qvb.0
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Nov 2021 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Sm0tYuI0lOyk/DSIwt5nlq49Rt3//bn0UdNQje0toj0=;
        b=JNSl45AlvBwoy2/FLMRtV74oy8MVRQvzUnQFUMC545y2HFoGkmXsdeQx9ahAMAj0wd
         pKtEaoH0BJSo1doQ52xTtj4zKaeF6j/N9BAWIJphFSyCqbbdFGg69rrX3PHrUfC6ArET
         SmWslsG10+RSEZLcKh6rjIdPPa4oRrl3umIetTTGIxyGOjI7dJ1sEgZKuEapOXCStKKy
         7/e0LhV2PssJZCI39RIq+u4BI01rmC6ZnWXcA034QOHvRYRvPLDX12lNUaCcrdxt+xM5
         06A0fVC298/Np/0SFDUvJB+G7vkOy3fKGkHgPbNM4Rk+dn7Th8fnuyE8uAIspJisbTN/
         rsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sm0tYuI0lOyk/DSIwt5nlq49Rt3//bn0UdNQje0toj0=;
        b=nmMHXXVd3X9ASDzpII58SK15w+II9r/+vqHQzPjykYF8W7U0im80ZkjFa97t9LnIHO
         9V3cRLwTFG6re5pm5ZxGDCSVMWIdpyW56x/1vCyTPMVmxbdP+ccQ4inf+/aeW9x2MjvG
         zeE24MwhP2DjDoHjzHia0dGpxGWu0GZeukfrv+RB/YUq5Z9frBpAArtKqJvIXNapvfBO
         Kg53wLo67W8p0zY530NSRkHCoXeDjMDg9lDXuhZ2QXMZBX9H2kffmvxgEeJJR3tXu9mC
         cyl8x5NssX5JqLE6b/RqYWQDAmjUXWILVK6lPqSPEGsSQDesjqR/vgH5UEZZTuhAJXec
         W9QA==
X-Gm-Message-State: AOAM532JGhuIeUpneSknnOqW8zBaGU0TTU+xfMyVzRhp6t3QP+OKhf2y
        O11mArGeHopD0G/Ow6EFT2Iy9U09YywEHg==
X-Google-Smtp-Source: ABdhPJykF8SNreO/qxZinynlP97308+J68umNWcULNmcf29a2SeV7r7C+vnrqrX5DtmyT1RiMCNThw==
X-Received: by 2002:a05:6214:509a:: with SMTP id kk26mr46526849qvb.43.1637073918055;
        Tue, 16 Nov 2021 06:45:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h68sm8500459qkf.126.2021.11.16.06.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 06:45:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com, dsterba@suse.cz
Subject: [PATCH v3] btrfs-progs: mkfs: create the global root's
Date:   Tue, 16 Nov 2021 09:45:16 -0500
Message-Id: <3413edb7e30f27c2b90fec76f2ef1f2e6c751dd4.1637073844.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20211115205107.GO28560@twin.jikos.cz>
References: <20211115205107.GO28560@twin.jikos.cz>
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
v2->v3:
- Added the EXPERIMENTAL block around --num-global-roots.

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

