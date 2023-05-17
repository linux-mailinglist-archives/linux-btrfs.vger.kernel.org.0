Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC376706150
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjEQHgz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjEQHgU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 03:36:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16AAE52
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 00:36:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 82370203FF
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684308967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khM5rjNMvZXQdcEyD6GtQ5FUuN2k5B41GbOI6BglZCs=;
        b=GgUx+XOya2+eQoCrIQU8e1mq3S6pPaKaiSqN8SFVkYFFb30w2FNmWoowrWc6b+TToqdESC
        EHqL+y8lIF8Y0QPTEwlTgBLO5Ayr0bbF12acObzfLANXL65SVnJzEmsigbiYHxF231OsID
        os/4IBDVoipMhQ2or+xlvSYhOtUKYkw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BDA1B13358
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IHDhH+aDZGQkEQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 07:36:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs-progs: tune: add the ability to delete old data csums
Date:   Wed, 17 May 2023 15:35:40 +0800
Message-Id: <7a6073cbd38c1cc09adb904c7ba73a7d89407fc9.1684308139.git.wqu@suse.com>
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

The new helper function, delete_old_data_csums(), would delete the old
data csums while keep the new one untouched.

Since the new data csums have a key objectid (-13) smaller than the
old data csums (-10), we can safely delete from the tail of the btree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index a30d142c1600..61368ddf34b9 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -326,6 +326,68 @@ out:
 	return ret;
 }
 
+static int delete_old_data_csums(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
+	struct btrfs_trans_handle *trans;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key last_key;
+	int ret;
+
+	last_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
+	last_key.type = BTRFS_EXTENT_CSUM_KEY;
+	last_key.offset = (u64)-1;
+
+	trans = btrfs_start_transaction(csum_root, 1);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start transaction to delete old data csums: %m");
+		return ret;
+	}
+	while (true) {
+		int start_slot;
+		int nr;
+
+		ret = btrfs_search_slot(trans, csum_root, &last_key, &path, -1, 1);
+
+		nr = btrfs_header_nritems(path.nodes[0]);
+		/* No item left (empty csum tree), exit. */
+		if (!nr)
+			break;
+		for (start_slot = 0; start_slot < nr; start_slot++) {
+			struct btrfs_key found_key;
+
+			btrfs_item_key_to_cpu(path.nodes[0], &found_key, start_slot);
+			/* Break from the for loop, we found the first old csum. */
+			if (found_key.objectid == BTRFS_EXTENT_CSUM_OBJECTID)
+				break;
+		}
+		/* No more old csum item detected, exit. */
+		if (start_slot == nr)
+			break;
+
+		/* Delete items starting from @start_slot to the end. */
+		ret = btrfs_del_items(trans, csum_root, &path, start_slot,
+				      nr - start_slot);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to delete items: %m");
+			break;
+		}
+		btrfs_release_path(&path);
+	}
+	btrfs_release_path(&path);
+	if (ret < 0)
+		btrfs_abort_transaction(trans, ret);
+	ret = btrfs_commit_transaction(trans, csum_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction after deleting the old data csums: %m");
+	}
+	return ret;
+}
+
 int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 {
 	int ret;
@@ -350,6 +412,9 @@ int btrfs_change_csum_type(struct btrfs_fs_info *fs_info, u16 new_csum_type)
 	}
 
 	/* Phase 2, delete the old data csums. */
+	ret = delete_old_data_csums(fs_info);
+	if (ret < 0)
+		return ret;
 
 	/* Phase 3, change the new csum key objectid */
 
-- 
2.40.1

