Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93E75E56F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 02:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIVAHS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Sep 2022 20:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIVAHP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Sep 2022 20:07:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261CA3D70
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Sep 2022 17:07:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 768A21F90A
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663805233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T4vE4BE96XjUrmOovmSKqoiopkBs+6slwstscq9SOKc=;
        b=RNqp8ciU8vosLVB87uNvw8RzfZy4hktt9ESD9eO7PGJcRL/1lq5CLJaK3KNnJGWpSHNv13
        b11Sn1Koz0diqs1TrP8Ywu+Oshevv/pmnLFM/5UZ9orRByglHlkRywnCQkQEOjt9jiBAQv
        4+KUCQ/RGFWAIEyC1XBRak3+Qr7EtL8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0907139EF
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KMK3JjCnK2O1LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 00:07:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/16] btrfs: extract tree roots and zone info initialization into init/exit helpers
Date:   Thu, 22 Sep 2022 08:06:26 +0800
Message-Id: <75cfc046e94b166a46eab189c61912adadaddd3e.1663804335.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663804335.git.wqu@suse.com>
References: <cover.1663804335.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No functional change, but one special thing to notice:

- No need to cleanup zone info
  As we call btrfs_close_devices() at error path to cleanup all
  zone device info, thus we don't need to handle it at
  open_ctree_tree_roots_init().

  This is a break of the init/exit layer, but since devices info is
  not per-device, but shared for the whole btrfs module, such break
  should still be acceptable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 88 ++++++++++++++++++++++++++++------------------
 1 file changed, 53 insertions(+), 35 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 4fcdd15697d0..e03927cb00b8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3634,6 +3634,56 @@ static void open_ctree_chunk_tree_exit(struct btrfs_fs_info *fs_info)
 	btrfs_mapping_tree_free(&fs_info->mapping_tree);
 }
 
+static int open_ctree_tree_roots_init(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	ret = init_tree_roots(fs_info);
+	if (ret)
+		goto error;
+
+	/*
+	 * Get zone type information of zoned block devices. This will also
+	 * handle emulation of a zoned filesystem if a regular device has the
+	 * zoned incompat feature flag set.
+	 */
+	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
+	if (ret) {
+		btrfs_err(fs_info,
+			  "zoned: failed to read device zone info: %d",
+			  ret);
+		goto error;
+	}
+
+	/*
+	 * If we have a uuid root and we're not being told to rescan we need to
+	 * check the generation here so we can set the
+	 * BTRFS_FS_UPDATE_UUID_TREE_GEN bit.  Otherwise we could commit the
+	 * transaction during a balance or the log replay without updating the
+	 * uuid generation, and then if we crash we would rescan the uuid tree,
+	 * even though it was perfectly fine.
+	 */
+	if (fs_info->uuid_root && !btrfs_test_opt(fs_info, RESCAN_UUID_TREE) &&
+	    fs_info->generation ==
+	    btrfs_super_uuid_tree_generation(fs_info->super_copy))
+		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
+
+	return 0;
+
+error:
+	if (fs_info->data_reloc_root)
+		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
+	free_root_pointers(fs_info, true);
+	return ret;
+}
+
+static void open_ctree_tree_roots_exit(struct btrfs_fs_info *fs_info)
+{
+	if (fs_info->data_reloc_root)
+		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
+	free_root_pointers(fs_info, true);
+}
+
 struct init_sequence {
 	int (*init_func)(struct btrfs_fs_info *fs_info);
 	void (*exit_func)(struct btrfs_fs_info *fs_info);
@@ -3655,6 +3705,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_chunk_tree_init,
 		.exit_func = open_ctree_chunk_tree_exit,
+	}, {
+		.init_func = open_ctree_tree_roots_init,
+		.exit_func = open_ctree_tree_roots_exit,
 	}
 };
 
@@ -3680,36 +3733,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 		open_ctree_res[i] = true;
 	}
 
-	ret = init_tree_roots(fs_info);
-	if (ret)
-		goto fail_tree_roots;
-
-	/*
-	 * Get zone type information of zoned block devices. This will also
-	 * handle emulation of a zoned filesystem if a regular device has the
-	 * zoned incompat feature flag set.
-	 */
-	ret = btrfs_get_dev_zone_info_all_devices(fs_info);
-	if (ret) {
-		btrfs_err(fs_info,
-			  "zoned: failed to read device zone info: %d",
-			  ret);
-		goto fail_block_groups;
-	}
-
-	/*
-	 * If we have a uuid root and we're not being told to rescan we need to
-	 * check the generation here so we can set the
-	 * BTRFS_FS_UPDATE_UUID_TREE_GEN bit.  Otherwise we could commit the
-	 * transaction during a balance or the log replay without updating the
-	 * uuid generation, and then if we crash we would rescan the uuid tree,
-	 * even though it was perfectly fine.
-	 */
-	if (fs_info->uuid_root && !btrfs_test_opt(fs_info, RESCAN_UUID_TREE) &&
-	    fs_info->generation ==
-	    btrfs_super_uuid_tree_generation(fs_info->super_copy))
-		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
-
 	ret = btrfs_verify_dev_extents(fs_info);
 	if (ret) {
 		btrfs_err(fs_info,
@@ -3869,11 +3892,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
 fail_block_groups:
 	btrfs_put_block_group_cache(fs_info);
-
-fail_tree_roots:
-	if (fs_info->data_reloc_root)
-		btrfs_drop_and_free_fs_root(fs_info, fs_info->data_reloc_root);
-	free_root_pointers(fs_info, true);
 	btrfs_free_block_groups(fs_info);
 fail:
 	for (i = ARRAY_SIZE(open_ctree_seq) - 1; i >= 0; i--) {
-- 
2.37.3

