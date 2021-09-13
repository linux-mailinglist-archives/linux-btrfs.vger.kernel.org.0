Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF6408E11
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Sep 2021 15:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241630AbhIMNbT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 09:31:19 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50760 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbhIMNSt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 09:18:49 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B0191FFE2;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631539052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PGAKlYKQBSIV2Be40Q0/BEpWk7UWZDqtpcX5VnZGoaM=;
        b=qOxv1pMFVmlifBluKBYzMrEPu8zUizUUFGBwH5b/QwvMhqab4IMTO/9IKzgoQyuvyAr6n8
        Y/7xgDaRQTBXRoOguWjEd+OulliAOfAC+AFMVGPgIkL6pJdrU1D8qIUK7EZCiDg7vUCeBb
        nLh+XyUTxUrmJKINaGnsU5ptV6kMPqQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EE4913AB4;
        Mon, 13 Sep 2021 13:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0P8vFGxPP2FNOwAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 13 Sep 2021 13:17:32 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/8] btrfs-progs: check/original: Implement removing received data for RW subvols
Date:   Mon, 13 Sep 2021 16:17:27 +0300
Message-Id: <20210913131729.37897-7-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913131729.37897-1-nborisov@suse.com>
References: <20210913131729.37897-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Making a received subvolume RO should preclude doing an incremental send
of said subvolume since it can't be guaranteed that nothing changed in
the structure and this in turn has correctness implications for send.

There is a pending kernel change that implements this behavior and
ensures that in the future RO volumes which are switched to RW can't be
used for incremental send. However, old kernels won't have that patch
backported. To ensure there is a supported way for users to put their
subvolumes in sane state let's implement the same functionality in
progs.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check/main.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/check/main.c b/check/main.c
index 6369bdd90656..7a2296d00234 100644
--- a/check/main.c
+++ b/check/main.c
@@ -3544,6 +3544,7 @@ static int check_fs_root(struct btrfs_root *root,
 	int ret = 0;
 	int err = 0;
 	bool generation_err = false;
+	bool rw_received_err = false;
 	int wret;
 	int level;
 	u64 super_generation;
@@ -3658,6 +3659,46 @@ static int check_fs_root(struct btrfs_root *root,
 					sizeof(found_key)));
 	}
 
+	if (!((btrfs_root_flags(root_item) & BTRFS_ROOT_SUBVOL_RDONLY) ||
+			btrfs_is_empty_uuid(root_item->received_uuid))) {
+		error("Subvolume id: %llu is RW and has a received uuid",
+				root->root_key.objectid);
+		rw_received_err = true;
+		if (repair) {
+			struct btrfs_trans_handle *trans = btrfs_start_transaction(root, 2);
+			if (IS_ERR(trans))
+				return PTR_ERR(trans);
+
+			ret = btrfs_uuid_tree_remove(trans, root_item->received_uuid,
+					BTRFS_UUID_KEY_RECEIVED_SUBVOL, root->root_key.objectid);
+
+			if (ret && ret != -ENOENT) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+
+			memset(root_item->received_uuid, 0, BTRFS_UUID_SIZE);
+			btrfs_set_root_stransid(root_item, 0);
+			btrfs_set_root_rtransid(root_item, 0);
+			btrfs_set_stack_timespec_sec(&root_item->stime, 0);
+			btrfs_set_stack_timespec_nsec(&root_item->stime, 0);
+			btrfs_set_stack_timespec_sec(&root_item->rtime, 0);
+			btrfs_set_stack_timespec_nsec(&root_item->rtime, 0);
+
+			ret = btrfs_update_root(trans, gfs_info->tree_root, &root->root_key,
+					root_item);
+			if (ret < 0) {
+				btrfs_abort_transaction(trans, ret);
+				return ret;
+			}
+
+			btrfs_commit_transaction(trans, gfs_info->tree_root);
+			rw_received_err = false;
+			printf("Cleared received information for subvol: %llu\n",
+					root->root_key.objectid);
+		}
+	}
+
 	while (1) {
 		ctx.item_count++;
 		wret = walk_down_tree(root, &path, wc, &level, &nrefs);
@@ -3722,7 +3763,7 @@ static int check_fs_root(struct btrfs_root *root,
 
 	free_corrupt_blocks_tree(&corrupt_blocks);
 	gfs_info->corrupt_blocks = NULL;
-	if (!ret && generation_err)
+	if (!ret && (generation_err ||  rw_received_err))
 		ret = -1;
 	return ret;
 }
-- 
2.17.1

