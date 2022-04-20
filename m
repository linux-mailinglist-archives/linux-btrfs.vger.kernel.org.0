Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B94C507D8C
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 02:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358568AbiDTAXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 20:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358546AbiDTAXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 20:23:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1912C651
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Apr 2022 17:20:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 595902129B
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650414026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=76zArNk0Hh3+dkZn4yZvnkAUYIzy6QEUs/N2zaaysz8=;
        b=qYA3hiOpXELozKI2o15FR4ghljHA+lCxma1SdMIEm8C8ATKEs+FTWWfLmyRtyI0wDSPXJv
        2dMeZK7s+eQ0TB2z779Mi5lm/+VIijGyPnWSrsflygDDo7uQTZz6dGKq8sXv+D1t3sR3pz
        wvYLn1Ni5CnFb273gG4rsRu2OvbVVNg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9DA6F139BE
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SKuKGMlRX2KvZAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 00:20:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 07/10] btrfs-progs: mkfs/sprout: introduce helper to force allocating a chunk
Date:   Wed, 20 Apr 2022 08:19:56 +0800
Message-Id: <81ddaed32542e58aaa9c338e91438cf2926add19.1650413308.git.wqu@suse.com>
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

The new helper, sprout_alloc_one_chunk(), will force allocating a chunk,
mostly using the profile from the seed device.

With the delayed chunk allocation, we really only need to grab the
target profile, and call btrfs_alloc_chunk() followed by
btrfs_make_block_group().

For mixed block group, we need btrfs_space_info to determine if a
profile needs extra types, so here we expoert btrfs_find_space_info().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h       |  2 ++
 kernel-shared/extent-tree.c | 16 ++++++++--------
 mkfs/sprout.c               | 38 +++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 68943ff294cc..99ed81a9790a 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -2614,6 +2614,8 @@ u64 btrfs_name_hash(const char *name, int len);
 u64 btrfs_extref_hash(u64 parent_objectid, const char *name, int len);
 
 /* extent-tree.c */
+struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+					       u64 flags);
 int btrfs_reserve_extent(struct btrfs_trans_handle *trans,
 			 struct btrfs_root *root,
 			 u64 num_bytes, u64 empty_size,
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index da801b1d9926..63ace7cea681 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1592,8 +1592,8 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
-static struct btrfs_space_info *__find_space_info(struct btrfs_fs_info *info,
-						  u64 flags)
+struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
+					       u64 flags)
 {
 	struct btrfs_space_info *found;
 
@@ -1617,7 +1617,7 @@ static int free_space_info(struct btrfs_fs_info *fs_info, u64 flags,
 	if (bytes_used)
 		return -ENOTEMPTY;
 
-	found = __find_space_info(fs_info, flags);
+	found = btrfs_find_space_info(fs_info, flags);
 	if (!found)
 		return -ENOENT;
 	if (found->total_bytes < total_bytes) {
@@ -1638,7 +1638,7 @@ int update_space_info(struct btrfs_fs_info *info, u64 flags,
 {
 	struct btrfs_space_info *found;
 
-	found = __find_space_info(info, flags);
+	found = btrfs_find_space_info(info, flags);
 	if (found) {
 		found->total_bytes += total_bytes;
 		found->bytes_used += bytes_used;
@@ -1694,7 +1694,7 @@ static int do_chunk_alloc(struct btrfs_trans_handle *trans,
 	u64 num_bytes;
 	int ret;
 
-	space_info = __find_space_info(fs_info, flags);
+	space_info = btrfs_find_space_info(fs_info, flags);
 	if (!space_info) {
 		ret = update_space_info(fs_info, flags, 0, 0, &space_info);
 		BUG_ON(ret);
@@ -2381,7 +2381,7 @@ static int alloc_reserved_tree_block(struct btrfs_trans_handle *trans,
 	u64 start, end;
 	int ret;
 
-	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	ASSERT(sinfo);
 
 	ins.objectid = node->bytenr;
@@ -2478,7 +2478,7 @@ static int alloc_tree_block(struct btrfs_trans_handle *trans,
 	if (!extent_op)
 		return -ENOMEM;
 
-	sinfo = __find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	sinfo = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
 	if (!sinfo) {
 		error("Corrupted fs, no valid METADATA block group found");
 		return -EUCLEAN;
@@ -3657,7 +3657,7 @@ int cleanup_ref_head(struct btrfs_trans_handle *trans,
 		if (!head->is_data) {
 			struct btrfs_space_info *sinfo;
 
-			sinfo = __find_space_info(trans->fs_info,
+			sinfo = btrfs_find_space_info(trans->fs_info,
 					BTRFS_BLOCK_GROUP_METADATA);
 			ASSERT(sinfo);
 			sinfo->bytes_reserved -= head->num_bytes;
diff --git a/mkfs/sprout.c b/mkfs/sprout.c
index 5977a73644f5..66119bbe975f 100644
--- a/mkfs/sprout.c
+++ b/mkfs/sprout.c
@@ -149,3 +149,41 @@ static int update_seed_dev_geneartion(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static int sprout_alloc_one_chunk(struct btrfs_trans_handle *trans, u64 type)
+{
+	struct btrfs_fs_info *fs_info = trans->fs_info;
+	struct btrfs_space_info *space_info;
+	u64 chunk_start;
+	u64 chunk_size;
+	u64 chunk_flags;
+	int ret;
+
+	space_info = btrfs_find_space_info(fs_info, type);
+	if (!space_info)
+		return -ENOENT;
+
+	if (type & BTRFS_BLOCK_GROUP_METADATA)
+		chunk_flags = fs_info->avail_metadata_alloc_bits &
+			      fs_info->metadata_alloc_profile;
+	if (type & BTRFS_BLOCK_GROUP_SYSTEM)
+		chunk_flags = fs_info->avail_system_alloc_bits &
+			      fs_info->system_alloc_profile;
+	if (type & BTRFS_BLOCK_GROUP_DATA)
+		chunk_flags = fs_info->avail_data_alloc_bits &
+			      fs_info->data_alloc_profile;
+	/* This is for mixed profile */
+	chunk_flags |= space_info->flags;
+
+	ret = btrfs_alloc_chunk(trans, fs_info, &chunk_start, &chunk_size,
+				chunk_flags);
+	if (ret < 0)
+		goto error;
+	ret = btrfs_make_block_group(trans, fs_info, 0, chunk_flags,
+				     chunk_start, chunk_size);
+	if (ret < 0)
+		goto error;
+	return ret;
+error:
+	btrfs_abort_transaction(trans, ret);
+	return ret;
+}
-- 
2.35.1

