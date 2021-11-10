Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8782044CA6B
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 21:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhKJUSZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 15:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbhKJUSV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 15:18:21 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C9EC061764
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:33 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id 132so3653332qkj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 10 Nov 2021 12:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=4NDH1tuc2pvqldmE4sy7rWt9BZCp5dsON+4fNMVLQ3Y=;
        b=WrMr9+Hh8TOz87UnQpBAgjFhOz7Px2Bqy6AnpxsdKyL6O7pQVJcPo1PS5SnjhXragK
         KAcLpf5nGjoLI/+BzaU0xkhI+izIi/HWSOP7cd0z2VHHZmKHGugJ5DearSxuMWHMyQy0
         h8T81BGXockDwi8DArCujH1WmWTLv5FocLwhk7ta6XkWNYR0xo+3x6eNGuVG+GPdx0kh
         WyNQhZOPLfplkBrtnd/oLsigRVSA4W7WcH+7JDhhMIiHmdefl67WaYXvy/z0M7OdDC7i
         No5ytkSsRCVHD2fvljm7V0nPVdsJSHh0i64yDEUsjKi+fcV7Pts+yNkVYK1Sx9r0giK6
         ACUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4NDH1tuc2pvqldmE4sy7rWt9BZCp5dsON+4fNMVLQ3Y=;
        b=6T6tuSHIrpvrOJ4YpJvhpBAedKUQF80uJdyFLE770i5HJZWD2wXZX9NBNBGyCBn1+s
         YupNfETYTUNTEHK600CzxbhNSpusStHVYLAfc0xiPY3fCqNq4j6cVBWx5B/JfDmy4FjC
         W65uqJH3EFXNNTPRbkmRyC+/KL+KYPKfGeWS98LpOyyTAH2LFNrSq35vySk/dyOB8Ctc
         uAvk6E4Jvdz87gD7jChSAQFDvndsIix6WKeQ+nL5v9i7PcIJ4aL+AUcZlK+1m4ogiB2q
         SQn9QrnDHRONi1jgS4dGG53uQnokISDBKajX6AbY5/UQft9RBS7/Olv+GKJPYiJzDW1k
         F7Vw==
X-Gm-Message-State: AOAM5336eeIqZUnZqSU11VPLbb9c7pgCqhX21saCVHARGAclSKV6Rnqs
        V491tuCF/sT6uO+pJrzeswERdfXB7nOFaQ==
X-Google-Smtp-Source: ABdhPJy1RO9jLZEnqhMLjPe7yaHY01qxJuPhMZXamp6DpxixVBQT7mYwCqMyYA9YkPsjLyyogiLKYQ==
X-Received: by 2002:a05:620a:407:: with SMTP id 7mr1762132qkp.506.1636575332669;
        Wed, 10 Nov 2021 12:15:32 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p18sm449001qtk.76.2021.11.10.12.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 12:15:31 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 29/30] btrfs-progs: mkfs: create the global root's
Date:   Wed, 10 Nov 2021 15:14:41 -0500
Message-Id: <dc65e92db91bcdf238b17e53d3efdb8ec21a493e.1636575147.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636575146.git.josef@toxicpanda.com>
References: <cover.1636575146.git.josef@toxicpanda.com>
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

