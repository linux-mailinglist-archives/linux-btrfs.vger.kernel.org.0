Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A918A70EFA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbjEXHl4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbjEXHlz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2B49D
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95C351F8B3
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KESw63R7fH6sI9QpjFhSs5hImiXiJGJh+S1Z4Brh5uc=;
        b=cHYuZ6EAZZk3RzR3Es8Z824Mrw4ThwZSF+lXGxg5YNVkLYg44jZxpuoG/oMnfackd1pjtV
        RHjXCjaWWYskbQlyYswA30xWFTVmzTmHdUUXVY4njg/cQSwU2pA66/IZLIfN0ua/9eEWvU
        DkT35q5GLs5rPK+r6wizxzvpr7W6UGA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EBEDB13425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +LApLb6/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs-progs: tune: implement resume support for csum tree without any new csum item
Date:   Wed, 24 May 2023 15:41:26 +0800
Message-Id: <c1a3ec5ade9bd3429a0988985cb29db76fe628dc.1684913599.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684913599.git.wqu@suse.com>
References: <cover.1684913599.git.wqu@suse.com>
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

There are two possible situations where there is no new csum items at
all:

- We just inserted csum change item
  This means all csums are really old csum type, and we can start
  the conversion from the beginning, only need to skip the csum change
  item insert.

- We finished data csum conversion but not yet started metadata
  conversion
  This means all csums are already new csum type, and we can resume
  by starting changing metadata csums.

To distinguish the two cases, we need to read the first sector, and
verify the data content against both csum types.

If the csum matches with old csum type, we resume from generating new
data csum.
If the csum matches with new csum type, we resume from rewriting
metadata csum.
If the csum doesn't match either csum type, we have some big problems
then.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 105 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 102 insertions(+), 3 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index b95a4117b59b..05bddaa48d27 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -115,7 +115,8 @@ static int get_last_csum_bytenr(struct btrfs_fs_info *fs_info, u64 *result)
 
 static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 				       u64 logical, void *data_buf,
-				       const void *old_csums)
+				       const void *old_csums, u16 old_csum_type,
+				       bool output_error)
 {
 	const u32 sectorsize = fs_info->sectorsize;
 	int num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
@@ -138,7 +139,7 @@ static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 		if (memcmp(csum_has, old_csums, fs_info->csum_size) == 0) {
 			found_good = true;
 			break;
-		} else {
+		} else if (output_error){
 			char found[BTRFS_CSUM_STRING_LEN];
 			char want[BTRFS_CSUM_STRING_LEN];
 
@@ -168,7 +169,8 @@ static int generate_new_csum_range(struct btrfs_trans_handle *trans,
 
 	for (u64 cur = logical; cur < logical + length; cur += sectorsize) {
 		ret = read_verify_one_data_sector(fs_info, cur, buf, old_csums +
-				(cur - logical) / sectorsize * fs_info->csum_size);
+				(cur - logical) / sectorsize * fs_info->csum_size,
+				fs_info->csum_type, true);
 
 		if (ret < 0) {
 			error("failed to recover a good copy for data at logical %llu",
@@ -532,8 +534,20 @@ static int change_meta_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
 	struct btrfs_path path = { 0 };
 	struct btrfs_key key;
+	u64 super_flags;
 	int ret;
 
+	/* Re-set the super flags, this is for resume cases. */
+	super_flags = btrfs_super_flags(fs_info->super_copy);
+	super_flags &= ~BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM;
+	super_flags |= BTRFS_SUPER_FLAG_CHANGING_META_CSUM;
+	btrfs_set_super_flags(fs_info->super_copy, super_flags);
+	ret = write_all_supers(fs_info);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to update super flags: %m");
+	}
+
 	/*
 	 * Disable metadata csum checks first, as we may hit tree blocks with
 	 * either old or new csums.
@@ -728,6 +742,63 @@ static int get_csum_items_range(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
+/*
+ * Verify one data sector to determine which csum type matches the csum.
+ *
+ * Return >0 if the current csum type doesn't pass the check (including csum
+ * item too small compared to csum type).
+ * Return 0 if the current csum type passes the check.
+ * Return <0 for other errors.
+ */
+static int determine_csum_type(struct btrfs_fs_info *fs_info, u64 logical,
+			       u16 csum_type)
+{
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, logical);
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	u16 csum_size = btrfs_csum_type_size(csum_type);
+	u8 csum_expected[BTRFS_CSUM_SIZE];
+	void *buf;
+	int ret;
+
+	key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	key.type = BTRFS_EXTENT_CSUM_KEY;
+	key.offset = logical;
+
+	ret = btrfs_search_slot(NULL, csum_root, &key, &path, 0, 0);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to search csum tree: %m");
+		btrfs_release_path(&path);
+		return ret;
+	}
+
+	/*
+	 * The csum item size is smaller than expected csum size, no
+	 * more need to check.
+	 */
+	if (btrfs_item_size(path.nodes[0], path.slots[0]) < csum_size) {
+		btrfs_release_path(&path);
+		return 1;
+	}
+	read_extent_buffer(path.nodes[0], csum_expected,
+			   btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
+			   csum_size);
+	btrfs_release_path(&path);
+
+	buf = malloc(fs_info->sectorsize);
+	if (!buf)
+		return -ENOMEM;
+	ret = read_verify_one_data_sector(fs_info, logical, buf, csum_expected,
+					  csum_type, false);
+	if (ret < 0)
+		ret = 1;
+	free(buf);
+	return ret;
+}
+
 static int resume_data_csum_change(struct btrfs_fs_info *fs_info,
 				   u16 new_csum_type)
 {
@@ -757,6 +828,33 @@ static int resume_data_csum_change(struct btrfs_fs_info *fs_info,
 	if (ret == 0)
 		new_csum_found = true;
 
+	/*
+	 * Only old csums exists. This can be one of the two cases:
+	 * - Only the csum change item inserted, no new csum generated.
+	 * - All data csum is converted to the new type.
+	 *
+	 * Here we need to check if the csum item is in old or new type.
+	 */
+	if (old_csum_found && !new_csum_found) {
+		ret = determine_csum_type(fs_info, old_csum_first, fs_info->csum_type);
+		if (ret == 0) {
+			/* All old data csums, restart generation. */
+			resume_start = 0;
+			goto new_data_csums;
+		}
+		ret = determine_csum_type(fs_info, old_csum_first, new_csum_type);
+		if (ret == 0) {
+			/*
+			 * All new data csums, just go metadata csum change, which
+			 * would drop the CHANGING_DATA_CSUM flag for us.
+			 */
+			goto new_meta_csum;
+		}
+		error("The data checksum for logical %llu doesn't match either old or new csum type, unable to resume",
+			old_csum_first);
+		return -EUCLEAN;
+	}
+
 	/*
 	 * Both old and new csum exist, and new csum is only a subset of the
 	 * old ones.
@@ -787,6 +885,7 @@ new_data_csums:
 	ret = change_csum_objectids(fs_info);
 	if (ret < 0)
 		return ret;
+new_meta_csum:
 	ret = change_meta_csums(fs_info, new_csum_type);
 	return ret;
 }
-- 
2.40.1

