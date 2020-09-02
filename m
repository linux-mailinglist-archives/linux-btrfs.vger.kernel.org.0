Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C40125B418
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 20:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIBSvB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 14:51:01 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47695 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726426AbgIBSvA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 2 Sep 2020 14:51:00 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9E60AFC1;
        Wed,  2 Sep 2020 14:50:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 14:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=sKA6IaYL5BaUfqOwGKhRE11gHE
        8Yl6/OblkuLfh04PQ=; b=DCQdZPVMnm4peiN1GO+mE3fcsspcyLCg1uDTPxtj/p
        tZtQw14NWpadlvUF7e5t+F0aLbDHCB0pZHm6LYy1+MujIKoWbt6vyoFtGwojfVJJ
        JVt7xDk3ie4HYspykiegz5gNOhYKcqKxqJvu0I+tnVCArALirbA7HcT0R4qTFFoQ
        sp8VtmtAce8+1VtlBTAdU5n/YNGIc7mXvyalO1Floy4Bws3MJCwLNHiaahP4vkHf
        HQhLsUX0HlJwOLhLPgG29oZdvf2QVmqolZ83z2nLccFQSSwrx5j+LctL1KtxkiOp
        QSlO42YXFjHiNS16E8pHqRFlDIoevenmwLifW0y7UXmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sKA6IaYL5BaUfqOwG
        KhRE11gHE8Yl6/OblkuLfh04PQ=; b=qc9GQj7P8hVSp/nOO7BsICqj7VlfY3Z7e
        HfPuTJcVtVa2Ckh4hSj96GrYfdXhRSiwhovA5w0MjRC/Ncpx0O/WNx1MSABNBkHv
        ZK+5+IuOgRpS/qzapCOaU0p8h1whNXJIFWaevqdB9TyvQXbZVu26o6kzOj9chRmE
        KN5iA8vcHapwFaNNxybKQLU//gkek89Qi6RwuUAnhv/OUfo3e1VK2iGSQRc2jVLf
        t49xU82zbyOYliI5yHMnns9x9PLFp/TdLLmQFTBEjmMg+qZWYMCPFr9rOBo/mopo
        C15LRW38x93pvchcHZs3krkeF4qKmmBVUqarMA5EkxsZqBcU62cIQ==
X-ME-Sender: <xms:kulPX_jJ-g3215afep0EZS_PR8W-woemM1iPtwk_26KDOtjnuEqhCQ>
    <xme:kulPX8Dq0s1VHdo-G2AUSBB76_AMVfWtrqGdeP7ZA4hWqoDfChQLLThWCCHnWT3M2
    2yLEmaDs6hHLg3dZQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduie
    dtleeuieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:kulPX_HLFgJHLHgJ3f9qAvNSrW_onmA_BIo8Irhu1ao5nC-AJxwGTg>
    <xmx:kulPX8TH_qMCZUsskj6KAYjAxgcA0dLL8HuwxtOk8PTDg5_5Pvj_Gg>
    <xmx:kulPX8zq6BepRc0w4RCl7jmnYM3ERo3iwhDUdp8jCTmw-KCZulXuIw>
    <xmx:k-lPX496fxSSdKW0L9FIF80O9UOew4tEC-7_hcdbdWk9ygLKNs_kdg>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2E363328005D;
        Wed,  2 Sep 2020 14:50:56 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH] btrfs-progs: support free space tree in mkfs
Date:   Wed,  2 Sep 2020 11:50:49 -0700
Message-Id: <0366b5e12a7e6f95d9f274df52f32231dcbe8b05.1599072541.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add a runtime feature (-R) flag for the free space tree. A filesystem
that is mkfs'd with -R free-space-tree then mounted with no options has
the same contents as one mkfs'd without the option, then mounted with
'-o space_cache=v2'.

The only tricky thing is in exactly how to call the tree creation code.
Using btrfs_create_free_space_tree as is did not quite work, because an
extra reference to the eb (root->commit_root) is leaked, which mkfs
complains about with a warning. I opted to follow how the uuid tree is
created by adding it to the dirty roots list for cleanup by
commit_tree_roots in commit_transaction. As a result,
btrfs_create_free_space_tree no longer exactly matches the version in
the kernel sources.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 common/fsfeatures.c             | 3 +++
 common/fsfeatures.h             | 3 ++-
 kernel-shared/disk-io.c         | 5 +++++
 kernel-shared/free-space-tree.c | 1 +
 mkfs/main.c                     | 8 ++++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 48ab37ca..3bebc97f 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -107,6 +107,9 @@ static const struct btrfs_feature runtime_features[] = {
 	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA, NULL,
 		VERSION_TO_STRING2(3, 4), NULL, 0, NULL, 0,
 		"quota support (qgroups)" },
+	{ "free-space-tree", BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE, NULL,
+		VERSION_TO_STRING2(4, 5), NULL, 0, NULL, 0,
+		"free space tree (space_cache=v2)" },
 	/* Keep this one last */
 	{ "list-all", BTRFS_FEATURE_LIST_ALL, NULL }
 };
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 13141254..f76fc099 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -39,7 +39,8 @@
 
 #define BTRFS_FEATURE_LIST_ALL		(1ULL << 63)
 
-#define BTRFS_RUNTIME_FEATURE_QUOTA	(1ULL << 0)
+#define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
+#define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
 
 void btrfs_list_all_fs_features(u64 mask_disallowed);
 void btrfs_list_all_runtime_features(u64 mask_disallowed);
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 42f733e3..6f584986 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1003,10 +1003,15 @@ int btrfs_setup_all_roots(struct btrfs_fs_info *fs_info, u64 root_tree_bytenr,
 		ret = find_and_setup_root(root, fs_info, BTRFS_FREE_SPACE_TREE_OBJECTID,
 					  fs_info->free_space_root);
 		if (ret) {
+			free(fs_info->free_space_root);
+			fs_info->free_space_root = NULL;
 			printk("Couldn't read free space tree\n");
 			return -EIO;
 		}
 		fs_info->free_space_root->track_dirty = 1;
+	} else {
+		free(fs_info->free_space_root);
+		fs_info->free_space_root = NULL;
 	}
 
 	ret = find_and_setup_log_root(root, fs_info, sb);
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 3570a9ac..2edc7fc7 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -1433,6 +1433,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info)
 		goto abort;
 	}
 	fs_info->free_space_root = free_space_root;
+	add_root_to_dirty_list(free_space_root);
 
 	do {
 		block_group = btrfs_lookup_first_block_group(fs_info, start);
diff --git a/mkfs/main.c b/mkfs/main.c
index 18dc6f8e..3eb74821 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -34,6 +34,7 @@
 #include <blkid/blkid.h>
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/volumes.h"
 #include "kernel-shared/transaction.h"
 #include "common/utils.h"
@@ -1495,6 +1496,13 @@ raid_groups:
 			goto out;
 		}
 	}
+	if (runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE) {
+		ret = btrfs_create_free_space_tree(fs_info);
+		if (ret < 0) {
+			error("failed to create free space tree: %d (%m)", ret);
+			goto out;
+		}
+	}
 	if (verbose) {
 		char features_buf[64];
 
-- 
2.24.1

