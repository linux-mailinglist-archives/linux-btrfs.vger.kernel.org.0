Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38774D0A7E
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245681AbiCGWF3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245738AbiCGWF0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:05:26 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330B4475C
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:04:31 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id q4so13229857qki.11
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3AcOH5zLlrirpAcpg8AlHL4acJt/P/tCfUu8R16Jvqk=;
        b=fr4bwpllEIuucq2zvIQZd1TSFxK24jSy9bwxBrTxa+vvkYGSeOk39yeau9yBD6ia6n
         lDGCTVveT+uBxI5D5IC1cbrveRPi0o6OPaQMuVOuW6KRyR6aGDWyBf6+F3QChPIC6NLy
         rRi4gYZofd3+h0bei4EufnBN56xjJ0G4SFVNVRZeqUD9i6fWGzXpWtk0Lhe0FwY4wPGU
         +SadVdAQapAXXo6g+mrISfkfd5xwOXjaxJEsdCOyZhufdeNTCea9VoYuJyBa5ppi0voL
         DDG7JT/EDDP+W+sYH6B9uhxTaevCobRDqfhdfMdkkAXH4vVP48gpMc/0K3hWWlBrsf/5
         szHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3AcOH5zLlrirpAcpg8AlHL4acJt/P/tCfUu8R16Jvqk=;
        b=0ebleeDUkQZ1hPi+LhM/J0yenwL8iEwCV4PGTpbpw2lVftEqaDHjQ3IZpYP0tKvTfb
         cTNjThDBJmfEAKxrg1KmMIDfMxKd5MwTuqlhhoqYYwF6L7+OKv8jI2SkBd4tc2J9zp/F
         TiFZUVUnTOODPTit1JMRKFuAuMnhustaV7E375UkTJhZiUpjHPBC/P9O/MK59YYGfrt4
         xvOkf3RzZd1WaF/UI/hEE715mI87zDlAYNcsKkUgba3MDeVail9aGqFzuJo11NJjN+j6
         gMW4lnrDvlf7q4VHX4pH/bp8cLtCVoqXEBZDuIpIesm73nc+v0HaFr7TonP2Wi4AumuB
         plPg==
X-Gm-Message-State: AOAM532hPf4rH7nrP1wJPmr6P5zQAO/0iE4D1ZsVCZV7EH2Q0uNE9X1+
        +W90iUMROxQ5Nc3fFGtAT4rK1wwxi2AFcy4t
X-Google-Smtp-Source: ABdhPJxxirYJj8UaehzxdfCgxGPK3+6wyCvnDLyrQusr6EWzFbnXSE/N7/TmMDuPHqgN8R8S55ZIWw==
X-Received: by 2002:a05:620a:4725:b0:67a:ee5a:c830 with SMTP id bs37-20020a05620a472500b0067aee5ac830mr8149669qkb.717.1646690670063;
        Mon, 07 Mar 2022 14:04:30 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b002e02be9c0easm8936734qts.69.2022.03.07.14.04.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:04:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/6] btrfs: read the nr_global_roots from the super block
Date:   Mon,  7 Mar 2022 17:04:22 -0500
Message-Id: <9ad0cd61f4bf4d4d31a9b780a658b3364cb1da87.1646690556.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646690555.git.josef@toxicpanda.com>
References: <cover.1646690555.git.josef@toxicpanda.com>
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

Originally I was deriving the number of global roots from the largest
offset of the extent root we found in the tree_root.  However this could
result in shenanigans with fuzzing, so instead store this in our
super block as the source of truth, and then check the offset of the
root items to make sure they're sane wrt our global root count.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   |  6 +++++-
 fs/btrfs/disk-io.c | 23 ++++++++++++-----------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4db17bd05a21..aaa8451ef8be 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -277,6 +277,8 @@ struct btrfs_super_block {
 	/* the UUID written into btree blocks */
 	u8 metadata_uuid[BTRFS_FSID_SIZE];
 
+	__le64 nr_global_roots;
+
 	/* Extent tree v2 */
 	__le64 block_group_root;
 	__le64 block_group_root_generation;
@@ -284,7 +286,7 @@ struct btrfs_super_block {
 
 	/* future expansion */
 	u8 reserved8[7];
-	__le64 reserved[25];
+	__le64 reserved[24];
 	u8 sys_chunk_array[BTRFS_SYSTEM_CHUNK_ARRAY_SIZE];
 	struct btrfs_root_backup super_roots[BTRFS_NUM_BACKUP_ROOTS];
 
@@ -2513,6 +2515,8 @@ BTRFS_SETGET_STACK_FUNCS(super_block_group_root_generation,
 			 block_group_root_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_block_group_root_level, struct btrfs_super_block,
 			 block_group_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_nr_global_roots, struct btrfs_super_block,
+			 nr_global_roots, 64);
 
 int btrfs_super_csum_size(const struct btrfs_super_block *s);
 const char *btrfs_super_csum_name(u16 csum_type);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 09693ab4fde0..aeefc4e2e71a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2583,7 +2583,6 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 {
 	struct btrfs_fs_info *fs_info = tree_root->fs_info;
 	struct btrfs_root *root;
-	u64 max_global_id = 0;
 	int ret;
 	struct btrfs_key key = {
 		.objectid = objectid,
@@ -2617,14 +2616,15 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		if (key.objectid != objectid)
 			break;
-		btrfs_release_path(path);
 
-		/*
-		 * Just worry about this for extent tree, it'll be the same for
-		 * everybody.
-		 */
-		if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
-			max_global_id = max(max_global_id, key.offset);
+		if (key.offset >= fs_info->nr_global_roots) {
+			btrfs_err(fs_info, "invalid global root [%llu, %llu]\n",
+				  key.objectid, key.offset);
+			ret = -EUCLEAN;
+			break;
+		}
+
+		btrfs_release_path(path);
 
 		found = true;
 		root = read_tree_root_path(tree_root, path, &key);
@@ -2643,9 +2643,6 @@ static int load_global_roots_objectid(struct btrfs_root *tree_root,
 	}
 	btrfs_release_path(path);
 
-	if (objectid == BTRFS_EXTENT_TREE_OBJECTID)
-		fs_info->nr_global_roots = max_global_id + 1;
-
 	if (!found || ret) {
 		if (objectid == BTRFS_CSUM_TREE_OBJECTID)
 			set_bit(BTRFS_FS_STATE_NO_CSUMS, &fs_info->fs_state);
@@ -3242,6 +3239,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
 	fs_info->sectorsize = 4096;
 	fs_info->sectorsize_bits = ilog2(4096);
 	fs_info->stripesize = 4096;
+	fs_info->nr_global_roots = 1;
 
 	spin_lock_init(&fs_info->swapfile_pins_lock);
 	fs_info->swapfile_pins = RB_ROOT;
@@ -3598,6 +3596,9 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 	fs_info->csums_per_leaf = BTRFS_MAX_ITEM_SIZE(fs_info) / fs_info->csum_size;
 	fs_info->stripesize = stripesize;
 
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		fs_info->nr_global_roots = btrfs_super_nr_global_roots(disk_super);
+
 	ret = btrfs_parse_options(fs_info, options, sb->s_flags);
 	if (ret) {
 		err = ret;
-- 
2.26.3

