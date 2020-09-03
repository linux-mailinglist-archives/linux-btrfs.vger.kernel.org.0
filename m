Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9A425C8A1
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Sep 2020 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgICSTc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Sep 2020 14:19:32 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50011 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgICSTb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Sep 2020 14:19:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A511AD22;
        Thu,  3 Sep 2020 14:19:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 03 Sep 2020 14:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=ysnh6GiDoiBl5
        qLDV7EDnwP4Ks6I99YVhLaan64PSZk=; b=buYWv7Idwm8JgrxHe3MTw8zQxoIIA
        dZj9X6eWWHRCl/BNDIMaZbStVoMMvlA24hq2x9QBPfeHKQ9jHhlxtN9gqd/4bbQT
        YiqfX20dkMlxOfaPEJRPdr/NVG7z3BJ3XW/wYbPIAE1JMJviHl9FRAzz+TbrH8fv
        V/QI7x9hSU+3YyLUFRzeKOvWvWA1yoOkTZPVnr1X7DK4r6IOLi+54HMYg1s9q9Y0
        6LccdlWdtEMMWsv+3iRMZfBMWDgd+McR1HuKHagu1KEVx9KSsRdGcaAmElhg6XY+
        4tJDx66dNH0SlnTUIEDcU63KGBNPSr8e7zOFX0TjiNL5otS4phUD6eA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=ysnh6GiDoiBl5qLDV7EDnwP4Ks6I99YVhLaan64PSZk=; b=MgYx+r7v
        9js7D44lgtGBXlcHPyyvrSJZ6m/r824iVWBauRQOau+LWWuszK00whi92p0Eh0M9
        7R7AkUJkPNU6dXbwP7n77qmFgS6ZST5fs1EAEYzhEFVxVv5JEiuBq4iVzhiBEYZz
        eBWRp1Mt6yEldRVa2VJqpglGXg+Qp2IWA56BR0S2Ar2II/GyPHpdccGjhzdgeJ4u
        MD2U/PA04+m6m9GP1SJBsLy4lgS2n9cTBoCG0UDnuv77J5l9LQQqg1/RqAMAk4Rw
        GB0lE5+khK5yOyC8zrBLxD9XS3PCnfTjRIJIPLBf1FObProeOEI/qeq5RsEM3gav
        yubtnH7H2uX9Pg==
X-ME-Sender: <xms:sTNRX1Ips48NEpRi60Db9krN1Rb6OHQIqU2N3osoVCN2oXuMG9awdw>
    <xme:sTNRXxJg9qFsiquU2Dd1U36Qktug2NqJwFGLqtzw5Cs8yZLOJDZfPaQxNxDg25tK_
    qvgVzFV5M8QdbQmPlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudeguddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:sTNRX9trL3ScPAhl7qA1vvQS4kpcPMuI5VlWcUwdFPMRQ9zrlyT3Dw>
    <xmx:sTNRX2Ya36_Qcp_FpwewdTm4wk5xzGpuUVYHcW8-5-z4ELBhTfAEZg>
    <xmx:sTNRX8alAVqbWFTcTKDV0XAPEVdNgcZXtdPPjKB9s7onGiUk9ACSLA>
    <xmx:sjNRX3zMPIM_B46QTVRpq0584wtDaOJJCDBTJUlSoKtfv2K0UP-HbA>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 022D33280066;
        Thu,  3 Sep 2020 14:19:29 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Boris Burkov <boris@bur.io>
Subject: [PATCH v2] btrfs-progs: support free space tree in mkfs
Date:   Thu,  3 Sep 2020 11:19:23 -0700
Message-Id: <cf7462fe8c14448703d845d235dce7aca1faf795.1599157021.git.boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200902204453.GN28318@twin.jikos.cz>
References: <20200902204453.GN28318@twin.jikos.cz>
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
- add mkfs test
- add documentation
- add safe version and sysfs file to feature struct

 Documentation/mkfs.btrfs.asciidoc            |  6 ++++++
 common/fsfeatures.c                          | 10 ++++++++--
 common/fsfeatures.h                          |  3 ++-
 kernel-shared/disk-io.c                      |  5 +++++
 kernel-shared/free-space-tree.c              |  1 +
 mkfs/main.c                                  |  8 ++++++++
 tests/mkfs-tests/023-free-space-tree/test.sh | 21 ++++++++++++++++++++
 7 files changed, 51 insertions(+), 3 deletions(-)
 create mode 100755 tests/mkfs-tests/023-free-space-tree/test.sh

diff --git a/Documentation/mkfs.btrfs.asciidoc b/Documentation/mkfs.btrfs.asciidoc
index 630f575c..8f1e1429 100644
--- a/Documentation/mkfs.btrfs.asciidoc
+++ b/Documentation/mkfs.btrfs.asciidoc
@@ -257,6 +257,12 @@ permanent, this does not replace mount options.
 Enable quota support (qgroups). The qgroup accounting will be consistent,
 can be used together with '--rootdir'.  See also `btrfs-quota`(8).
 
+*free_space_tree*::
+(kernel support since 3.4)
++
+Enable the free space tree (mount option space_cache=v2) for persisting the
+free space cache.
+
 BLOCK GROUPS, CHUNKS, RAID
 --------------------------
 
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 48ab37ca..6c391806 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -104,9 +104,15 @@ static const struct btrfs_feature mkfs_features[] = {
 };
 
 static const struct btrfs_feature runtime_features[] = {
-	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA, NULL,
-		VERSION_TO_STRING2(3, 4), NULL, 0, NULL, 0,
+	{ "quota", BTRFS_RUNTIME_FEATURE_QUOTA,
+		"free_space_tree",
+		VERSION_TO_STRING2(3, 4),
+		VERSION_TO_STRING2(4, 9),
+		NULL, 0,
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
 
diff --git a/tests/mkfs-tests/023-free-space-tree/test.sh b/tests/mkfs-tests/023-free-space-tree/test.sh
new file mode 100755
index 00000000..1b40325a
--- /dev/null
+++ b/tests/mkfs-tests/023-free-space-tree/test.sh
@@ -0,0 +1,21 @@
+#!/bin/bash
+# Check if mkfs supports the runtime feature free_space_tree
+
+source "$TEST_TOP/common"
+
+check_prereq mkfs.btrfs
+check_prereq btrfs
+
+setup_root_helper
+
+setup_loopdevs 4
+prepare_loopdevs
+dev1=${loopdevs[1]}
+
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f -R free-space-tree "$dev1"
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1" | grep -q FREE_SPACE_TREE || _fail "free space tree not created"
+run_check_stdout $SUDO_HELPER "$TOP/btrfs" inspect-internal dump-super "$dev1" | grep -q FREE_SPACE_TREE_VALID || _fail "free space tree not valid"
+
+cleanup_loopdevs
+
+exit 0
-- 
2.24.1

