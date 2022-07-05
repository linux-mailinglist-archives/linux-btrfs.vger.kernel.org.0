Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD994566442
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiGEHiY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiGEHiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D21F13D27
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 09FB31F9D2
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UF4M/ialQLAparItA3vyL4bhn/IZHkuq62XubNTGG0=;
        b=gmp+Rhr/H9Z7KRRahVgMsHqJgOYWuPb/QJUbPTN50v8OZIbxg8yufN4iXMBT7x+in/F0gr
        oWx8ME+QyN8Z/wcUAgRvY82bIGtr73+vlfBuradfwLRkO9Eb3kAjvDyTF4m2/v9FSjALFa
        9qNTskGqMJXLTWyZ5abiyxXCvE8sW2M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6284A1339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mGPGC2Xqw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/8] btrfs-progs: introduce the experimental compat RO flag, WRITE_INTENT_BITMAP
Date:   Tue,  5 Jul 2022 15:37:45 +0800
Message-Id: <bea38e431c2919264d5ce0170e293a74a05154f6.1657006141.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657006141.git.wqu@suse.com>
References: <cover.1657006141.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new compat RO flag will only be enabled through experimental
features.

Since this feature has no real code implementation yet, only the
following code changes are added:

- New super block check
  To ensure WRITE_INTENT_BITMAP is enabled along with
  EXTRA_SUPER_RESERVED

- New compat RO flag readable string output

- New mkfs runtime features

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c        | 11 +++++++++++
 common/fsfeatures.h        |  1 +
 kernel-shared/ctree.h      | 15 +++++++++++++++
 kernel-shared/disk-io.c    |  9 +++++++++
 kernel-shared/print-tree.c |  1 +
 mkfs/common.c              |  9 +++++++++
 mkfs/main.c                |  5 +++++
 7 files changed, 51 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 057519c50c54..63258262437d 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -181,6 +181,17 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_NULL(default),
 		.desc		= "extra super block reserved space for each device"
 	},
+#if EXPERIMENTAL
+	{
+		.name		= "write-intent-bitmap",
+		.flag		= BTRFS_RUNTIME_FEATURE_WRITE_INTENT_BITMAP,
+		.sysfs_name = "write_intent_bitmap",
+		VERSION_NULL(compat),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "write intent bitmap"
+	},
+#endif
 	/* Keep this one last */
 	{
 		.name = "list-all",
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 565873ec0e4f..c48aa5d05ac0 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -46,6 +46,7 @@
 #define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
 #define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
 #define BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED (1ULL << 2)
+#define BTRFS_RUNTIME_FEATURE_WRITE_INTENT_BITMAP  (1ULL << 3)
 
 void btrfs_list_all_fs_features(u64 mask_disallowed);
 void btrfs_list_all_runtime_features(u64 mask_disallowed);
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 0b4a8d60ceb4..c746c0d3ab89 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -502,6 +502,13 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
  */
 #define BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED	(1ULL << 3)
 
+/*
+ * Allow btrfs to have per-device write-intent bitmap.
+ * Will be utilized to close the RAID56 write-hole (by forced scrub for dirty
+ * partial written stripes at mount time).
+ */
+#define BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP	(1ULL << 4)
+
 #define BTRFS_FEATURE_INCOMPAT_MIXED_BACKREF	(1ULL << 0)
 #define BTRFS_FEATURE_INCOMPAT_DEFAULT_SUBVOL	(1ULL << 1)
 #define BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS	(1ULL << 2)
@@ -524,6 +531,13 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 
 #define BTRFS_FEATURE_COMPAT_SUPP		0ULL
 
+#if EXPERIMENTAL
+#define BTRFS_FEATURE_COMPAT_RO_SUPP			\
+	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
+	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |\
+	 BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED |	\
+	 BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP)
+#else
 /*
  * The FREE_SPACE_TREE and FREE_SPACE_TREE_VALID compat_ro bits must not be
  * added here until read-write support for the free space tree is implemented in
@@ -533,6 +547,7 @@ BUILD_ASSERT(sizeof(struct btrfs_super_block) == BTRFS_SUPER_INFO_SIZE);
 	(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |	\
 	 BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID |\
 	 BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)
+#endif
 
 #if EXPERIMENTAL
 #define BTRFS_FEATURE_INCOMPAT_SUPP			\
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index bf3ea5e63165..843fe0e73940 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1848,6 +1848,15 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		}
 	}
 
+	if (btrfs_super_compat_ro_flags(sb) &
+	    BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP &&
+	    !(btrfs_super_compat_ro_flags(sb) &
+	      BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED)) {
+		error(
+"write intent bitmap feature enabled without extra super reserved feature");
+		goto error_out;
+	}
+
 	if (btrfs_super_compat_ro_flags(sb) &
 	    BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED &&
 	    btrfs_super_reserved_bytes(sb) < BTRFS_BLOCK_RESERVED_1M_FOR_SUPER) {
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 918ebe02144a..55875a7bc2d3 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1669,6 +1669,7 @@ static struct readable_flag_entry compat_ro_flags_array[] = {
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE),
 	DEF_COMPAT_RO_FLAG_ENTRY(FREE_SPACE_TREE_VALID),
 	DEF_COMPAT_RO_FLAG_ENTRY(EXTRA_SUPER_RESERVED),
+	DEF_COMPAT_RO_FLAG_ENTRY(WRITE_INTENT_BITMAP),
 };
 static const int compat_ro_flags_num = sizeof(compat_ro_flags_array) /
 				       sizeof(struct readable_flag_entry);
diff --git a/mkfs/common.c b/mkfs/common.c
index f3c00f08826d..98da10718e7b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -316,6 +316,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
 	bool extra_super_reserved = !!(cfg->runtime_features &
 				 BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED);
+	bool write_intent_bitmap = !!(cfg->runtime_features &
+				 BTRFS_RUNTIME_FEATURE_WRITE_INTENT_BITMAP);
 
 	/* Don't include the free space tree in the blocks to process. */
 	if (!free_space_tree)
@@ -657,6 +659,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		btrfs_set_super_reserved_bytes(&super, system_group_offset);
 	}
 
+	if (write_intent_bitmap) {
+		u64 ro_flags = btrfs_super_compat_ro_flags(&super) |
+			       BTRFS_FEATURE_COMPAT_RO_WRITE_INTENT_BITMAP;
+
+		btrfs_set_super_compat_ro_flags(&super, ro_flags);
+	}
+
 	if (extent_tree_v2) {
 		ret = create_block_group_tree(fd, cfg, buf,
 					      system_group_offset,
diff --git a/mkfs/main.c b/mkfs/main.c
index 4ccf4e161d06..049d6f1dae2a 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1248,6 +1248,11 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		error("extra-super-reserved runtime feature conflicts with zoned devices");
 		exit(1);
 	}
+
+	/* Write intent bitmap must has extra reserved space. */
+	if (runtime_features & BTRFS_RUNTIME_FEATURE_WRITE_INTENT_BITMAP)
+		runtime_features |= BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED;
+
 	/*
 	* Set default profiles according to number of added devices.
 	* For mixed groups defaults are single/single.
-- 
2.36.1

