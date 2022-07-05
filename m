Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6C2566432
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiGEHiT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGEHiN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:38:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3A813D30
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:38:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E714D1F941
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t5/FeQTAhgoUAGGUGpRmsqGF+HQHFih7MBhbrbOLKh8=;
        b=eLro3KMkLxce7pBKXjB0uicnZp5uZgsALNLomrqt6J2hqaxhy/5TKsbb26GRWbIg1CNumG
        xu9E5R9xIVkdKSQZS8gqhlsLP1lxTTg4TtMasEungtEGhoVMvIwLRhGVhlyqaOtTLELRbQ
        6+zT/i12L6tOhkQzhi7kWN/YDwenKFw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BDA31339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cEZmBmHqw2JTOwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:38:09 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs-progs: mkfs: add support for extra-super-reserved runtime flag
Date:   Tue,  5 Jul 2022 15:37:41 +0800
Message-Id: <4513aea783b695eb55b238ffef4d348b1668dd37.1657006141.git.wqu@suse.com>
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

This allows mkfs to reserved extra 1MiB (2MiB in total).

The extra 1MiB should be large enough for either write-intent bitmap or
full journal.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c |  8 ++++++++
 common/fsfeatures.h |  1 +
 mkfs/common.c       | 16 ++++++++++++++++
 mkfs/main.c         |  9 +++++++++
 4 files changed, 34 insertions(+)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 23a92c21a2cc..057519c50c54 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -172,6 +172,14 @@ static const struct btrfs_feature runtime_features[] = {
 		VERSION_TO_STRING2(safe, 4,9),
 		VERSION_TO_STRING2(default, 5,15),
 		.desc		= "free space tree (space_cache=v2)"
+	}, {
+		.name		= "extra-super-reserved",
+		.flag		= BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED,
+		.sysfs_name = "extra_super_reserved",
+		VERSION_TO_STRING2(compat, 6,0),
+		VERSION_NULL(safe),
+		VERSION_NULL(default),
+		.desc		= "extra super block reserved space for each device"
 	},
 	/* Keep this one last */
 	{
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index 9e39c667b900..565873ec0e4f 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -45,6 +45,7 @@
 
 #define BTRFS_RUNTIME_FEATURE_QUOTA		(1ULL << 0)
 #define BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE	(1ULL << 1)
+#define BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED (1ULL << 2)
 
 void btrfs_list_all_fs_features(u64 mask_disallowed);
 void btrfs_list_all_runtime_features(u64 mask_disallowed);
diff --git a/mkfs/common.c b/mkfs/common.c
index 218854491c14..f3c00f08826d 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -314,6 +314,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
 	bool extent_tree_v2 = !!(cfg->features &
 				 BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2);
+	bool extra_super_reserved = !!(cfg->runtime_features &
+				 BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED);
 
 	/* Don't include the free space tree in the blocks to process. */
 	if (!free_space_tree)
@@ -324,6 +326,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		blocks_nr = ARRAY_SIZE(extent_tree_v2_blocks);
 		add_block_group = false;
 	}
+	/*
+	 * The extra 1MiB should be enough for either write-intent bitmap or
+	 * future full journal.
+	 */
+	if (extra_super_reserved)
+		system_group_offset += SZ_1M;
 
 	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
 		system_group_offset = zoned_system_group_offset(cfg->zone_size);
@@ -641,6 +649,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			goto out;
 	}
 
+	if (extra_super_reserved) {
+		u64 ro_flags = btrfs_super_compat_ro_flags(&super) |
+			       BTRFS_FEATURE_COMPAT_RO_EXTRA_SUPER_RESERVED;
+
+		btrfs_set_super_compat_ro_flags(&super, ro_flags);
+		btrfs_set_super_reserved_bytes(&super, system_group_offset);
+	}
+
 	if (extent_tree_v2) {
 		ret = create_block_group_tree(fd, cfg, buf,
 					      system_group_offset,
diff --git a/mkfs/main.c b/mkfs/main.c
index 4e0a46a77aa5..4ccf4e161d06 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1239,6 +1239,15 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		features |= BTRFS_FEATURE_INCOMPAT_ZONED;
 	}
 
+	/*
+	 * Runtime extra-super-reserved feature conflicts with zoned support,
+	 * as it's for regular devices explicitly.
+	 */
+	if (zoned && (runtime_features &
+		      BTRFS_RUNTIME_FEATURE_EXTRA_SUPER_RESERVED)) {
+		error("extra-super-reserved runtime feature conflicts with zoned devices");
+		exit(1);
+	}
 	/*
 	* Set default profiles according to number of added devices.
 	* For mixed groups defaults are single/single.
-- 
2.36.1

