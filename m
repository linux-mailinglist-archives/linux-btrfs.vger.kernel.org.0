Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FDB507D8D
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358539AbiDTAXL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358519AbiDTAXI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220EE2C64F
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D4F89210F1
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsrUhaL1i5mzCYPyhGR7/OZS0JyBtHTRjASqVozgGoo=;
        b=ng/m+yJahSJHTp+hH0pprje1l2Kkya9/EQSm7O10Xm2Gn16HPwxgKWinpHC70l+ROVXhqv
        aVGrWY5a0uaDbA+VaHEAPQP01FXhGxczS78S+88o8/G7PKgmYjMBlqo70XNTein9jVoYep
        ISQfh2tK8BgxyygOATpASt7WPbhPPzg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25151139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Hi/NsVRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:21 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 04/10] btrfs-progs: mkfs: avoid error out if some trees exist
Date:   Wed, 20 Apr 2022 08:19:53 +0800
Message-Id: <6cfa6781b8a287b1a485a89b597f359610ed8cd5.1650413308.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1650413308.git.wqu@suse.com>
References: <cover.1650413308.git.wqu@suse.com>
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

With the incoming seed sprout support at mkfs time, we can have quite
some trees already exist, those trees includes:

- data reloc tree
- uuid tree
- quota tree
- root dir

Handle the existing tress properly so we won't error out just because
the seed device already have the same tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/main.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 7b7793f8b996..ca035cbb27f7 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -712,6 +712,33 @@ static void update_chunk_allocation(struct btrfs_fs_info *fs_info,
 	}
 }
 
+/*
+ * Check if we already have an existing tree from seed device.
+ *
+ * Return >0 if we have seed device and already have the tree.
+ * Return 0 if we don't have seed device or the tree doesn't exist.
+ * Return <0 for error.
+ */
+static int check_seed_existing_tree(struct btrfs_fs_info *fs_info,
+				    struct btrfs_key *root_key)
+{
+	struct btrfs_path path;
+	int ret;
+
+	if (!fs_info->fs_devices->seed)
+		return 0;
+
+	btrfs_init_path(&path);
+	ret = btrfs_search_slot(NULL, fs_info->tree_root, root_key, &path, 0, 0);
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+
+	if (ret == 0)
+		return 1;
+	return 0;
+}
+
 static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -726,6 +753,12 @@ static int create_data_reloc_tree(struct btrfs_trans_handle *trans)
 	char *name = "..";
 	int ret;
 
+	ret = check_seed_existing_tree(fs_info, &key);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 0;
+
 	root = btrfs_create_tree(trans, fs_info, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
@@ -792,7 +825,12 @@ static int create_uuid_tree(struct btrfs_trans_handle *trans)
 	};
 	int ret = 0;
 
-	ASSERT(fs_info->uuid_root == NULL);
+	ret = check_seed_existing_tree(fs_info, &key);
+	if (ret < 0)
+		return ret;
+	if (ret > 0)
+		return 0;
+
 	root = btrfs_create_tree(trans, fs_info, &key);
 	if (IS_ERR(root)) {
 		ret = PTR_ERR(root);
@@ -896,7 +934,7 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_trans_handle *trans;
 	struct btrfs_qgroup_status_item *qsi;
-	struct btrfs_root *quota_root;
+	struct btrfs_root *quota_root = fs_info->quota_root;
 	struct btrfs_path path;
 	struct btrfs_key key;
 	int qgroup_repaired = 0;
@@ -909,6 +947,15 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 		error("failed to start transaction: %d (%m)", ret);
 		return ret;
 	}
+	key.objectid = BTRFS_QUOTA_TREE_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = 0;
+	ret = check_seed_existing_tree(fs_info, &key);
+	if (ret < 0)
+		goto fail;
+	if (ret > 0)
+		goto insert_status;
+
 	ret = btrfs_create_root(trans, fs_info, BTRFS_QUOTA_TREE_OBJECTID);
 	if (ret < 0) {
 		error("failed to create quota root: %d (%m)", ret);
@@ -927,6 +974,25 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 		error("failed to insert qgroup status item: %d (%m)", ret);
 		goto fail;
 	}
+	btrfs_release_path(&path);
+
+insert_status:
+	/*
+	 * We reach here either we're creating a new quota root, or using
+	 * the existing quota root from seed.
+	 * So here we intentionally do a search, other than reusing the
+	 * inserted item, to handle both cases well.
+	 */
+	key.objectid = 0;
+	key.type = BTRFS_QGROUP_STATUS_KEY;
+	key.offset = 0;
+	ret = btrfs_search_slot(trans, quota_root, &key, &path, 1, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		btrfs_release_path(&path);
+		goto fail;
+	}
 
 	qsi = btrfs_item_ptr(path.nodes[0], path.slots[0],
 			     struct btrfs_qgroup_status_item);
@@ -941,6 +1007,8 @@ static int setup_quota_root(struct btrfs_fs_info *fs_info)
 
 	/* Currently mkfs will only create one subvolume */
 	ret = insert_qgroup_items(trans, fs_info, BTRFS_FS_TREE_OBJECTID);
+	if (ret == -EEXIST)
+		ret = 0;
 	if (ret < 0) {
 		error("failed to insert qgroup items: %d (%m)", ret);
 		goto fail;
@@ -1554,6 +1622,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	}
 
 	ret = make_root_dir(trans, root);
+	if (ret == -EEXIST && root->fs_info->fs_devices->seed)
+		return 0;
 	if (ret) {
 		error("failed to setup the root directory: %d", ret);
 		goto error;
-- 
2.35.1

