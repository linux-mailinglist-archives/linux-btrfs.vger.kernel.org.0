Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A033347710F
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 12:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233573AbhLPLsH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Dec 2021 06:48:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58562 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhLPLsA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Dec 2021 06:48:00 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4699D1F3A7
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639655279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EDmUtaxHi/vm+MDBGv5FdKNqDrNaZ+3blk/U4yZ5/zk=;
        b=VbxXtNKEc5MZSjmBmO2zY05NZbuSlYpGgoh4hzazPg3+CmhkFZOeUVSbthGBhUA5CxG9aH
        K4bnLNDTR0FmkldDSBtWQGiC3FrZdjh0sCb9zZCwu1qnGxlmvsodtpZqNr60XIVxAGIq0h
        1JLjkD/uDkxRJ0jk1squtp1LRiDqZ/k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82DFD13B4B
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6LQ4EW4nu2FvQwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Dec 2021 11:47:58 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: output more debug message for uncommitted transaction
Date:   Thu, 16 Dec 2021 19:47:36 +0800
Message-Id: <20211216114736.69757-3-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216114736.69757-1-wqu@suse.com>
References: <20211216114736.69757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The extra info like how many dirty bytes this uncommitted transaction
has can be very helpful.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 5c598e124c25..25e0248e3c55 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4491,6 +4491,47 @@ int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 	return btrfs_commit_transaction(trans);
 }
 
+static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_transaction *trans;
+	struct btrfs_transaction *tmp;
+	bool found = false;
+
+	if (likely(list_empty(&fs_info->trans_list)))
+		return;
+
+	/*
+	 * This function is only called at the very end of close_ctree(),
+	 * thus no other running transaction, no need to take trans_lock.
+	 */
+	list_for_each_entry_safe(trans, tmp, &fs_info->trans_list, list) {
+		struct extent_state *cached = NULL;
+		u64 dirty_bytes = 0;
+		u64 cur = 0;
+		u64 found_start;
+		u64 found_end;
+
+		found = true;
+		while (!find_first_extent_bit(&trans->dirty_pages, cur,
+			&found_start, &found_end, EXTENT_DIRTY, &cached)) {
+			dirty_bytes += found_end + 1 - found_start;
+			cur = found_end + 1;
+		}
+		btrfs_warn(fs_info,
+	"transaction %llu (with %llu dirty metadata bytes) is not committed",
+			   trans->transid, dirty_bytes);
+		btrfs_cleanup_one_transaction(trans, fs_info);
+
+		if (trans == fs_info->running_transaction)
+			fs_info->running_transaction = NULL;
+		list_del_init(&trans->list);
+
+		btrfs_put_transaction(trans);
+		trace_btrfs_transaction_commit(fs_info);
+	}
+	ASSERT(!found);
+}
+
 void __cold close_ctree(struct btrfs_fs_info *fs_info)
 {
 	int ret;
@@ -4599,7 +4640,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_info)
 	btrfs_stop_all_workers(fs_info);
 
 	/* We shouldn't have any transaction open at this point */
-	ASSERT(list_empty(&fs_info->trans_list));
+	warn_about_uncommitted_trans(fs_info);
 
 	clear_bit(BTRFS_FS_OPEN, &fs_info->flags);
 	free_root_pointers(fs_info, true);
-- 
2.34.1

