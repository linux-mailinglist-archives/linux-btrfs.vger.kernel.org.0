Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E814C603F
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 01:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiB1AvH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 19:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiB1AvG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 19:51:06 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B00540A1D
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 16:50:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3746F218CE;
        Mon, 28 Feb 2022 00:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646009428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgnRmZ97myXG5YuGyPvhBiObSDv0yoz/8hl3GPMshpU=;
        b=nm9JbPQA48Os0gMoWz2Qtf939/GZWI3HfAB7dnVfCpQ0dAhri81tAoQSpKUhRZ3W6y7Z3e
        3DbANzbwy3nT1YI2/k4L40AY0d8Icr5SKRtMXe3HfyzPZMXjNeWljbGTeNtepQu8w+HzX+
        sybHEofTjXIgaYhE+qKvDZGHIszP9CQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 59CA9139BD;
        Mon, 28 Feb 2022 00:50:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gE/WCVMcHGJ3OwAAMHmgww
        (envelope-from <wqu@suse.com>); Mon, 28 Feb 2022 00:50:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?q?Luca=20B=C3=A9la=20Palkovics?= 
        <luca.bela.palkovics@gmail.com>
Subject: [PATCH 1/2] btrfs-progs: check: add check and repair ability for super num devs mismatch
Date:   Mon, 28 Feb 2022 08:50:07 +0800
Message-Id: <029df99dabfee5b8fc602bf284bb3ea364176418.1646009185.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1646009185.git.wqu@suse.com>
References: <cover.1646009185.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

[BUG]
There is a bug report of kernel rejecting fs which has a mismatch in
super num devices and num devices found in chunk tree.

But btrfs-check reports no problem about the fs.

[CAUSE]
We just didn't verify super num devices against the result found in
chunk tree.

[FIX]
Add such check and repair ability for btrfs-check.

The ability is mode independent.

Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        |  1 +
 check/mode-common.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 check/mode-common.h |  2 ++
 3 files changed, 91 insertions(+)

diff --git a/check/main.c b/check/main.c
index 8ccba4478de8..b29f6266b974 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9140,6 +9140,7 @@ static int do_check_chunks_and_extents(void)
 		if (ret > 0)
 			ret = 0;
 	}
+	ret = check_and_repair_super_num_devs(gfs_info);
 	return ret;
 }
 
diff --git a/check/mode-common.c b/check/mode-common.c
index c3d8bb45c6b6..a2c6c7732f4e 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -1583,3 +1583,91 @@ int fill_csum_tree(struct btrfs_trans_handle *trans, bool search_fs_tree)
 	}
 	return ret;
 }
+
+static int get_num_devs_in_chunk_tree(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *chunk_root = fs_info->chunk_root;
+	struct btrfs_path path = {0};
+	struct btrfs_key key = {0};
+	int found_devs = 0;
+	int ret;
+
+	ret = btrfs_search_slot(NULL, chunk_root, &key, &path, 0, 0);
+	if (ret < 0)
+		return ret;
+
+	/* We should be the first slot, and chunk tree should not be empty*/
+	ASSERT(path.slots[0] == 0 && btrfs_header_nritems(path.nodes[0]));
+
+	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+
+	while (key.objectid == BTRFS_DEV_ITEMS_OBJECTID &&
+	       key.type == BTRFS_DEV_ITEM_KEY) {
+		found_devs++;
+
+		ret = btrfs_next_item(chunk_root, &path);
+		if (ret < 0)
+			break;
+
+		/*
+		 * This should not happen, as we should have CHUNK items after
+		 * dev items, but since we're only to get the num devices,
+		 * no need to bother the problem.
+		 */
+		if (ret > 0) {
+			ret = 0;
+			break;
+		}
+		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
+	}
+	btrfs_release_path(&path);
+	if (ret < 0)
+		return ret;
+	return found_devs;
+}
+
+int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_trans_handle *trans;
+	int found_devs;
+	int ret;
+
+	ret = get_num_devs_in_chunk_tree(fs_info);
+	if (ret < 0)
+		return ret;
+
+	found_devs = ret;
+
+	if (found_devs == btrfs_super_num_devices(fs_info->super_copy))
+		return 0;
+
+	/* Now the found devs in chunk tree mismatch with super block*/
+	error("super num devices mismatch, have %llu expect %u",
+	      btrfs_super_num_devices(fs_info->super_copy),
+	      found_devs);
+
+	if (!repair)
+		return -EUCLEAN;
+
+	/*
+	 * Repair is pretty simple, just reset the super block value and
+	 * commit a new transaction.
+	 */
+	trans = btrfs_start_transaction(fs_info->tree_root, 0);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error("failed to start trans: %m");
+		return ret;
+	}
+	btrfs_set_super_num_devices(fs_info->super_copy, found_devs);
+	ret = btrfs_commit_transaction(trans, fs_info->tree_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit trans: %m");
+		btrfs_abort_transaction(trans, ret);
+		return ret;
+	}
+	printf("Successfully reset super num devices to %u\n", found_devs);
+	return 0;
+}
diff --git a/check/mode-common.h b/check/mode-common.h
index b5e6b727fe73..d5bab85a4f5e 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -201,4 +201,6 @@ int repair_dev_item_bytes_used(struct btrfs_fs_info *fs_info,
 
 int fill_csum_tree(struct btrfs_trans_handle *trans, bool search_fs_tree);
 
+int check_and_repair_super_num_devs(struct btrfs_fs_info *fs_info);
+
 #endif
-- 
2.35.1

