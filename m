Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1565A7077E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 May 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjERCLZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 22:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjERCLQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 22:11:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302FD3ABE
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 19:11:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C502E226B2
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684375871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NITmkOFquxmjy/UFc1LE/m3Hlpv+Mnkk6ileNvcmuU=;
        b=mAjbqYqFnEvUGbAyPXdabO/adqL1JS2QQ978eaF2xc6bHgRsMgDU0ZHjhJhgh4vdiWke7g
        AXX2chADu8nIj5801DKc2/XmKOaAhJqmzgbYv/sMKLlgsKi1/0rKXnPRDa1B2RO7ouo8Yi
        A36T6+O6xmwRUZRcIr8SmoEXgDkGzPI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12DBB1332D
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kMj2Mj6JZWRVJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 18 May 2023 02:11:10 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 7/7] btrfs-progs: tune: add the ability to change metadata csums
Date:   Thu, 18 May 2023 10:10:45 +0800
Message-Id: <a16e1c19a0355170841886e56766148e7a493c7d.1684375729.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684375729.git.wqu@suse.com>
References: <cover.1684375729.git.wqu@suse.com>
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

The csum change for metadata is like uuid-change, we go with in-place
csum update without any COW.

During the rewrite, we will manually check the csum (both old and new)
for each tree block.
And only rewrite the csum if the tree block matches its old csum.
(For tree block matches its new csum, we need to do nothing).

And when everything is done, just update the superblock to reflect the
csum type change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 143 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 1 deletion(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 167760536336..c8809300a143 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -471,8 +471,144 @@ out:
 	return ret;
 }
 
+static int rewrite_tree_block_csum(struct btrfs_fs_info *fs_info, u64 logical,
+				   u16 new_csum_type)
+{
+	struct extent_buffer *eb;
+	u8 result_old[BTRFS_CSUM_SIZE];
+	u8 result_new[BTRFS_CSUM_SIZE];
+	int ret;
+
+	eb = alloc_dummy_extent_buffer(fs_info, logical, fs_info->nodesize);
+	if (!eb)
+		return -ENOMEM;
+
+	ret = btrfs_read_extent_buffer(eb, 0, 0, NULL);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to read tree block at logical %llu: %m", logical);
+		goto out;
+	}
+
+	/* Verify the csum first. */
+	btrfs_csum_data(fs_info, fs_info->csum_type, (u8 *)eb->data + BTRFS_CSUM_SIZE,
+			result_old, fs_info->nodesize - BTRFS_CSUM_SIZE);
+	btrfs_csum_data(fs_info, new_csum_type, (u8 *)eb->data + BTRFS_CSUM_SIZE,
+			result_new, fs_info->nodesize - BTRFS_CSUM_SIZE);
+
+	/* Matches old csum, rewrite. */
+	if (memcmp_extent_buffer(eb, result_old, 0, fs_info->csum_size) == 0) {
+		write_extent_buffer(eb, result_new, 0,
+				    btrfs_csum_type_size(new_csum_type));
+		ret = write_data_to_disk(fs_info, eb->data, eb->start,
+					 fs_info->nodesize);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to write tree block at logical %llu: %m",
+			      logical);
+		}
+		goto out;
+	}
+
+	/* Already new csum. */
+	if (memcmp_extent_buffer(eb, result_new, 0, fs_info->csum_size) == 0)
+		goto out;
+
+	/* Csum doesn't match either old or new csum type, bad tree block. */
+	ret = -EIO;
+	error("tree block csum mismatch at logical %llu", logical);
+out:
+	free_extent_buffer(eb);
+	return ret;
+}
+
+static int change_meta_csums(struct btrfs_fs_info *fs_info, u32 new_csum_type)
+{
+	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	/*
+	 * Disable metadata csum checks first, as we may hit tree blocks with
+	 * either old or new csums.
+	 * We will manually check the meta csums here.
+	 */
+	fs_info->skip_csum_check = true;
+
+	key.objectid = 0;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, extent_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to get the first tree block of extent tree: %m");
+		return ret;
+	}
+	assert(ret > 0);
+	while (true) {
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+		if (key.type != BTRFS_EXTENT_ITEM_KEY &&
+		    key.type != BTRFS_METADATA_ITEM_KEY)
+			goto next;
+
+		if (key.type == BTRFS_EXTENT_ITEM_KEY) {
+			struct btrfs_extent_item *ei;
+			ei = btrfs_item_ptr(path.nodes[0], path.slots[0],
+					    struct btrfs_extent_item);
+			if (btrfs_extent_flags(path.nodes[0], ei) &
+			    BTRFS_EXTENT_FLAG_DATA)
+				goto next;
+		}
+		ret = rewrite_tree_block_csum(fs_info, key.objectid, new_csum_type);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to rewrite csum for tree block %llu: %m",
+			      key.offset);
+			goto out;
+		}
+next:
+		ret = btrfs_next_extent_item(extent_root, &path, U64_MAX);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to get next extent item: %m");
+		}
+		if (ret > 0) {
+			ret = 0;
+			goto out;
+		}
+	}
+out:
+	btrfs_release_path(&path);
+
+	/*
+	 * Finish the change by clearing the csum change flag and update the superblock
+	 * csum type.
+	 */
+	if (ret == 0) {
+		u64 super_flags = btrfs_super_flags(fs_info->super_copy);
+
+		btrfs_set_super_csum_type(fs_info->super_copy, new_csum_type);
+		super_flags &= ~(BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
+				 BTRFS_SUPER_FLAG_CHANGING_META_CSUM);
+		btrfs_set_super_flags(fs_info->super_copy, super_flags);
+
+		fs_info->csum_type = new_csum_type;
+		fs_info->csum_size = btrfs_csum_type_size(new_csum_type);
+
+		ret = write_all_supers(fs_info);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to write super blocks: %m");
+		}
+	}
+	return ret;
+}
+
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
+	u16 old_csum_type = fs_info->csum_type;
 	int ret;
 
 	/* Phase 0, check conflicting features. */
@@ -511,5 +647,10 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	 * like relocation in progs.
 	 * Thus we have to support reading a tree block with either csum.
 	 */
-	return -EOPNOTSUPP;
+	ret = change_meta_csums(fs_info, new_csum_type);
+	if (ret == 0)
+		printf("converted csum type from %s (%u) to %s (%u)\n",
+		       btrfs_super_csum_name(old_csum_type), old_csum_type,
+		       btrfs_super_csum_name(new_csum_type), new_csum_type);
+	return ret;
 }
-- 
2.40.1

