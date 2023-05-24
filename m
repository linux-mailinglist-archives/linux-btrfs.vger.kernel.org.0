Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81E670EF9F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 09:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjEXHlz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239941AbjEXHlw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 03:41:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F7C91
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 00:41:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 830EF1F750
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684914109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KeMxxFOCh3GOlfHbl4lBa5S05J+OJFUUhMywAuDYrI8=;
        b=stqvbENROCyT2k7o3EhHhXP1SFCGd02SUWp60XW/rOl1WuABoBc/AkTzXUw+egLTxj37tS
        6d/0C/LMs9qYCvfD8114iW6EYwuRTWbeNpj+2OcdishnoNlhm6waHMAgH9d8ZvaLfQlPkW
        zxfTPWN6YUHUDjKorlpQ0SUM+7TL+7A=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DADDF13425
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kNQwKby/bWSiRQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 24 May 2023 07:41:48 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/7] btrfs-progs: tune: implement resume support for metadata checksum
Date:   Wed, 24 May 2023 15:41:24 +0800
Message-Id: <592baf7bd93e0fce6a30faa7a216f894c66aab09.1684913599.git.wqu@suse.com>
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

For interrupted metadata checksum change, we only need to call the same
change_meta_csums().

Since we don't have any record on the last converted metadata, thus we
have to go through all metadata anyway.
And the existing change_meta_csums() has already implemented the needed
checks to skip converted metadata.

Since we're here, also implement all the surrounding checks, like making
sure the new target csum type matches the interrupted one.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 88 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index b5efc3a8807f..7ae618a433cb 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -45,12 +45,7 @@ static int check_csum_change_requreiment(struct btrfs_fs_info *fs_info)
 		error("no csum change support for extent-tree-v2 feature yet.");
 		return -EOPNOTSUPP;
 	}
-	if (btrfs_super_flags(fs_info->super_copy) &
-	    (BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
-	     BTRFS_SUPER_FLAG_CHANGING_META_CSUM)) {
-		error("resume from half converted status is not yet supported");
-		return -EOPNOTSUPP;
-	}
+
 	key.objectid = BTRFS_BALANCE_OBJECTID;
 	key.type = BTRFS_TEMPORARY_ITEM_KEY;
 	key.offset = 0;
@@ -522,7 +517,7 @@ out:
 	return ret;
 }
 
-static int change_meta_csums(struct btrfs_fs_info *fs_info, u32 new_csum_type)
+static int change_meta_csums(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
 	struct btrfs_path path = { 0 };
@@ -640,6 +635,71 @@ out:
 	return ret;
 }
 
+static int resume_csum_change(struct btrfs_fs_info *fs_info, u16 new_csum_type)
+{
+	const u64 super_flags = btrfs_super_flags(fs_info->super_copy);
+	struct btrfs_root *tree_root = fs_info->tree_root;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	int ret;
+
+	if ((super_flags & (BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
+			    BTRFS_SUPER_FLAG_CHANGING_META_CSUM)) ==
+	    (BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
+	     BTRFS_SUPER_FLAG_CHANGING_META_CSUM)) {
+		error("Invalid super flags, only one bit of CHANGING_DATA_CSUM or CHANGING_META_CSUM can be set");
+		return -EUCLEAN;
+	}
+
+	key.objectid = BTRFS_CSUM_CHANGE_OBJECTID;
+	key.type = BTRFS_TEMPORARY_ITEM_KEY;
+	key.offset = (u64)-1;
+	ret = btrfs_search_slot(NULL, tree_root, &key, &path, 0, 0);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to locate the csum change item: %m");
+		return ret;
+	}
+	assert(ret > 0);
+	ret = btrfs_previous_item(tree_root, &path, BTRFS_CSUM_CHANGE_OBJECTID,
+				  BTRFS_TEMPORARY_ITEM_KEY);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to locate the csum change item: %m");
+		btrfs_release_path(&path);
+		return ret;
+	}
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	btrfs_release_path(&path);
+
+	if (new_csum_type != key.offset) {
+		ret = -EINVAL;
+		error("target csum type mismatch with interrupted csum type, has %s (%u) expect %s (%llu)",
+		      btrfs_super_csum_name(new_csum_type), new_csum_type,
+		      btrfs_super_csum_name(key.offset), key.offset);
+		return ret;
+	}
+
+	if (super_flags & BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM) {
+		error("resume on data checksum changing is not yet supported");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * For metadata resume, just call the same change_meta_csums(), as we
+	 * have no record on previous converted metadata, thus have to go
+	 * through all metadata anyway.
+	 */
+	ret = change_meta_csums(fs_info, new_csum_type);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to resume metadata csum change: %m");
+	}
+	return ret;
+}
+
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	u16 old_csum_type = fs_info->csum_type;
@@ -650,6 +710,20 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	if (ret < 0)
 		return ret;
 
+	if (btrfs_super_flags(fs_info->super_copy) &
+	    (BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM |
+	     BTRFS_SUPER_FLAG_CHANGING_META_CSUM)) {
+		ret = resume_csum_change(fs_info, new_csum_type);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to resume unfinished csum change: %m");
+			return ret;
+		}
+		printf("converted csum type from %s (%u) to %s (%u)\n",
+		       btrfs_super_csum_name(old_csum_type), old_csum_type,
+		       btrfs_super_csum_name(new_csum_type), new_csum_type);
+		return ret;
+	}
 	/*
 	 * Phase 1, generate new data csums.
 	 *
-- 
2.40.1

