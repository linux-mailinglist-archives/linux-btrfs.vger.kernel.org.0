Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065AB70CFD1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjEWAsa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 May 2023 20:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233996AbjEWAsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 May 2023 20:48:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8BD4C27
        for <linux-btrfs@vger.kernel.org>; Mon, 22 May 2023 17:37:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8C71D2236E
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684802252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwuyl+YlmnhMaiqB+9vXiDdlZbn3K3urnM4RhrzU64k=;
        b=Z8zzwXZy9ryhdIHd5ot+6kUZTlopPlpIQuZfhjr8ALeExmMcfSYI5lPDsdGisLFgdpnW7I
        jHHyfYfsfHt13x5k9HqFA5Tg2oJCwuHpHFYRtY0UM4D1D6KcDls8fl6hZyrUTTy/Sbzf/w
        Fb1Zi2mKd6XJH1TQN319jirisDTJt9M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E31C713588
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wJPvKssKbGTIIgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 00:37:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: tune: delete the csum change item after converting the fs
Date:   Tue, 23 May 2023 08:37:12 +0800
Message-Id: <bda7d23000be5d97a782e8c56c99ddb66ca7a2bb.1684802060.git.wqu@suse.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1684802060.git.wqu@suse.com>
References: <cover.1684802060.git.wqu@suse.com>
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

[BUG]
Doing the following csum change in a row, it would fail:

 # mkfs.btrfs -f --csum crc32c $dev
 # btrfstune --csum sha256 $dev
 # btrfstune --csum crc32c $dev
 # btrfstune --csum sha256 $dev
 WARNING: Experimental build with unstable or unfinished features
 WARNING: Switching checksums is experimental, do not use for valuable data!

 Proceed to switch checksums
 ERROR: failed to insert csum change item: File exists
 ERROR: failed to generate new data csums: File exists
 WARNING: reserved space leaked, flag=0x4 bytes_reserved=16384
 extent buffer leak: start 30572544 len 16384
 extent buffer leak: start 30441472 len 16384
 WARNING: dirty eb leak (aborted trans): start 30441472 len 16384

[CAUSE]
During every csum change operation, btrfstune would insert an temporaray
csum change item into root tree.

But unfortunately after the conversion btrfstune doesn't properly delete
the csum change item, result the following items in the root tree:

	item 10 key (CSUM_CHANGE TEMPORARY_ITEM 0) itemoff 13423 itemsize 0
		temporary item objectid CSUM_CHANGE offset 0
		target csum type crc32c (0)
	item 11 key (CSUM_CHANGE TEMPORARY_ITEM 2) itemoff 13423 itemsize 0
		temporary item objectid CSUM_CHANGE offset 2
		target csum type sha256 (2)

Thus at the last conversion try to go back to SHA256, we failed to
insert the same item, and caused the above error.

[FIX]
After finishing the metadata csum conversion, do a proper removal of the
csum item.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tune/change-csum.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/tune/change-csum.c b/tune/change-csum.c
index c8809300a143..b5efc3a8807f 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -583,10 +583,13 @@ out:
 	btrfs_release_path(&path);
 
 	/*
-	 * Finish the change by clearing the csum change flag and update the superblock
-	 * csum type.
+	 * Finish the change by clearing the csum change flag, update the superblock
+	 * csum type, and delete the csum change item in the fs with new csum type.
 	 */
 	if (ret == 0) {
+		struct btrfs_root *tree_root = fs_info->tree_root;
+		struct btrfs_trans_handle *trans;
+
 		u64 super_flags = btrfs_super_flags(fs_info->super_copy);
 
 		btrfs_set_super_csum_type(fs_info->super_copy, new_csum_type);
@@ -596,11 +599,42 @@ out:
 
 		fs_info->csum_type = new_csum_type;
 		fs_info->csum_size = btrfs_csum_type_size(new_csum_type);
+		fs_info->skip_csum_check = 0;
 
-		ret = write_all_supers(fs_info);
+		trans = btrfs_start_transaction(tree_root, 1);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			errno = -ret;
+			error("failed to start new transaction with new csum type: %m");
+			return ret;
+		}
+		key.objectid = BTRFS_CSUM_CHANGE_OBJECTID;
+		key.type = BTRFS_TEMPORARY_ITEM_KEY;
+		key.offset = new_csum_type;
+
+		ret = btrfs_search_slot(trans, tree_root, &key, &path, -1, 1);
+		if (ret > 0)
+			ret = -ENOENT;
 		if (ret < 0) {
 			errno = -ret;
-			error("failed to write super blocks: %m");
+			error("failed to locate the csum change item: %m");
+			btrfs_release_path(&path);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		ret = btrfs_del_item(trans, tree_root, &path);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to delete the csum change item: %m");
+			btrfs_release_path(&path);
+			btrfs_abort_transaction(trans, ret);
+			return ret;
+		}
+		btrfs_release_path(&path);
+		ret = btrfs_commit_transaction(trans, tree_root);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to finalize the csum change: %m");
 		}
 	}
 	return ret;
-- 
2.40.1

