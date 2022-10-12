Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CAE5FC2C4
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Oct 2022 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJLJNr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Oct 2022 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiJLJNk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Oct 2022 05:13:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD58FBBF1A
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 02:13:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55D7F21CEF
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665566017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oTL8HXaA6vHj82tB+MEQFt8FoXhZInkFFrZ/iuWohOU=;
        b=YMpMoTR7CcoiLr9AiqX1oveoqFDQ2Xy03MoT5iMgLfDY4Dc9vPhxSqVPfHGy2b+VAs1mLz
        7Px4uNTuRPLYycexUGC45DmD3ro+IMq7UvZNddqkTFALMMwWj3tU3hdt2yj3gJdReGxe+6
        egG4NCZxRtJGDSW+OJliXGxjAjhw4AY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A65E913A5C
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +F2IHECFRmPKcQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Oct 2022 09:13:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 08/15] btrfs: extract tree roots and zone info initialization into init/exit helpers
Date:   Wed, 12 Oct 2022 17:13:04 +0800
Message-Id: <989b25fdddb492c839f060c079f1669db57cb0a6.1665565866.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1665565866.git.wqu@suse.com>
References: <cover.1665565866.git.wqu@suse.com>
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
index 54c7a2d66322..cfed53675359 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3683,6 +3683,56 @@ static void open_ctree_chunk_tree_exit(struct btrfs_fs_info *fs_info)
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
@@ -3704,6 +3754,9 @@ static const struct init_sequence open_ctree_seq[] = {
 	}, {
 		.init_func = open_ctree_chunk_tree_init,
 		.exit_func = open_ctree_chunk_tree_exit,
+	}, {
+		.init_func = open_ctree_tree_roots_init,
+		.exit_func = open_ctree_tree_roots_exit,
 	}
 };
 
@@ -3729,36 +3782,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
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
@@ -3918,11 +3941,6 @@ int __cold open_ctree(struct super_block *sb, char *options)
 
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

