Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3E8706152
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjEQHg7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjEQHgY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:36:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684855B5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 00:36:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B6978228CD
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684308968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pr7fTcIopwFahE9smHdJfRG2vpk6pQLIeViYTMv3ihI=;
        b=euTuhw0nvsoI0nXcTaOUPMB4FhXzEAIptteD6YFdteuSe6qHHdnwfcW2aoF/FzVW9O18y8
        o521h2uGUlGc2T8l9pBdlNmQAPclWV9Iuf2YGO0TJzSLGMIA0laV+dTgGLEtVqrCcQwuIr
        7cylMh2qglkFfDLvOsytU/npXua+wlo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3A8613358
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UP/iLOeDZGQkEQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:07 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs-progs: tune: add the ability to migrate the temporary csum items to regular csum items
Date:   Wed, 17 May 2023 15:35:41 +0800
Message-Id: <4ae50da7c1c0a990e83f07de68417726da8e5312.1684308139.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684308139.git.wqu@suse.com>
References: <cover.1684308139.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

At this stage, the csum tree should only contain the temporary csum
items (CSUM_CHANGE, EXTENT_CSUM, logical), and no more old csum items.

Now we can convert those temporary csum items back to regular csum items
by changing their key objectids back to EXTENT_CSUM.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index 61368ddf34b9..167760536336 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -388,6 +388,89 @@ static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+static int change_csum_objectids(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key last_key;
+	u64 super_flags;
+	int ret = 0;
+
+	last_key.objectid = BTRFS_CSUM_CHANGE_OBJECTID;
+	last_key.type = BTRFS_EXTENT_CSUM_KEY;
+	last_key.offset = (u64)-1;
+
+	trans = btrfs_start_transaction(csum_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction to change csum objectids: %m");
+		return ret;
+	}
+	while (true) {
+		struct btrfs_key found_key;
+		int nr;
+
+		ret = btrfs_search_slot(trans, csum_root, &last_key, &path, 0, 1);
+		if (ret < 0)
+			goto out;
+		assert(ret > 0);
+
+		nr = btrfs_header_nritems(path.nodes[0]);
+		/* No item left (empty csum tree), exit. */
+		if (!nr)
+			goto out;
+		/* No more temporary csum items, all converted, exit. */
+		if (path.slots[0] == 0)
+			goto out;
+
+		/* All csum items should be new csums. */
+		btrfs_item_key_to_cpu(path.nodes[0], &found_key, 0);
+		assert(found_key.objectid == BTRFS_CSUM_CHANGE_OBJECTID);
+
+		/*
+		 * Start changing the objectids, since EXTENT_CSUM (-10) is
+		 * larger than CSUM_CHANGE (-13), we always change from the tail.
+		 */
+		for (int i = nr - 1; i >= 0; i--) {
+			btrfs_item_key_to_cpu(path.nodes[0], &found_key, i);
+			found_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+			path.slots[0] = i;
+			ret = btrfs_set_item_key_safe(csum_root, &path, &found_key);
+			if (ret < 0) {
+				errno = -ret;
+				error("failed to set item key for data csum at logical %llu: %m",
+				      found_key.offset);
+				goto out;
+			}
+		}
+		btrfs_release_path(&path);
+	}
+out:
+	btrfs_release_path(&path);
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+
+	/*
+	 * All data csum items has been changed to the new type, we can clear
+	 * the superblock flag for data csum change, and go to the metadata csum
+	 * change phase.
+	 */
+	super_flags = btrfs_super_flags(fs_info->super_copy);
+	super_flags &= ~BTRFS_SUPER_FLAG_CHANGING_DATA_CSUM;
+	super_flags |= BTRFS_SUPER_FLAG_CHANGING_META_CSUM;
+	btrfs_set_super_flags(fs_info->super_copy, super_flags);
+	ret = btrfs_commit_transaction(trans, csum_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction after changing data csum objectids: %m");
+	}
+	return ret;
+}
+
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	int ret;
@@ -417,6 +500,9 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 		return ret;
 
 	/* Phase 3, change the new csum key objectid */
+	ret = change_csum_objectids(fs_info);
+	if (ret < 0)
+		return ret;
 
 	/*
 	 * Phase 4, change the csums for metadata.
-- 
2.40.1

