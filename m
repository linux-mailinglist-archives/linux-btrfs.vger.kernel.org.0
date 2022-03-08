Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1995D4D255D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 02:13:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiCIBOI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Mar 2022 20:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiCIBNU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Mar 2022 20:13:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A038B9A
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 16:56:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 488B7210F9;
        Tue,  8 Mar 2022 23:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646782722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=ILM6Ao8q5/eS6VIlMyHIoCmk8xg7ez51+9IGdQueAnk=;
        b=oAtRHpUoJJoZmsPmYZdIfHKrBlbB0vKPLe+GwRC29b/lNMkef/6yRrZ6hVS2ZQdvDdJq5a
        mpAMD0bTvwdFtp8gGV7M5ZpGUlggojU07a3QhY7QZcvJctVQQWVAgYNLammJTFr96FQOTO
        qU+sfptLcllTFMtwndAf53FnaE+8Vg8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6755613CFC;
        Tue,  8 Mar 2022 23:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id odAGDAHpJ2KQXQAAMHmgww
        (envelope-from <wqu@suse.com>); Tue, 08 Mar 2022 23:38:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Subject: [PATCH] btrfs: don't let new writes to trigger autodefrag on the same inode
Date:   Wed,  9 Mar 2022 07:38:23 +0800
Message-Id: <318a1bcdabdd1218d631ddb1a6fe1b9ca3b6b529.1646782687.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

[BUG]
Even with v5.16.12, there are still users reporting excessive IO caused
by autodefrag.

With extra trace events, it shows autodefrag is triggered for the same
inode again and again, not respecting the default commit interval:
(process name, CPU info, UUID are removed)

 5093.162849: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421337 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5096.558521: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421338 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5098.222259: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421338 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5098.544354: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421339 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5099.551326: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421339 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5101.066516: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421340 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5101.410834: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421340 flags=0x0 compress=0 max_sectors_to_defrag=1024
 5102.177464: defrag_file_start: root=259 ino=410492 start=0 len=599138304 extent_thresh=65536 newer_than=421340 flags=0x0 compress=0 max_sectors_to_defrag=1024

[CAUSE]
The offending file is a baloo database used by KDE, which is under
consistent writeback since it monitor all the file updates.

And since it's a database, a lot of small writes are triggered very
frequently.

This means, we got a lot btrfs_add_inode_defrag() called, maybe even
before the current autodefrag has finished.

And consider btrfs_run_defrag_inodes() will exhaust all inode_defrag,
this means after inode 410492 being defragged, it immediately get
re-queued again.

This caused autodefrag to scan the inode again and again, wasting tons
of IO.

[FIX]
Instead of exhausting fs_info->defrag_inodes in
btrfs_run_defrag_inodes(), which can get new inode_defrag during current
run, we just swap fs_info->defrag_inodes with a local rb_root.

So btrfs_run_defrag_inodes() will only exhaust all inode_defrag, without
being interrupted by new writes.

Reported-by: Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Issue: 423
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9f455c96c974..6f52b452e8b8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -187,7 +187,7 @@ int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
  * the next one.
  */
 static struct inode_defrag *
-btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
+btrfs_pick_defrag_inode(struct rb_root *defrag_inodes, u64 root, u64 ino)
 {
 	struct inode_defrag *entry = NULL;
 	struct inode_defrag tmp;
@@ -198,8 +198,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
 	tmp.ino = ino;
 	tmp.root = root;
 
-	spin_lock(&fs_info->defrag_inodes_lock);
-	p = fs_info->defrag_inodes.rb_node;
+	p = defrag_inodes->rb_node;
 	while (p) {
 		parent = p;
 		entry = rb_entry(parent, struct inode_defrag, rb_node);
@@ -222,8 +221,7 @@ btrfs_pick_defrag_inode(struct btrfs_fs_info *fs_info, u64 root, u64 ino)
 	}
 out:
 	if (entry)
-		rb_erase(parent, &fs_info->defrag_inodes);
-	spin_unlock(&fs_info->defrag_inodes_lock);
+		rb_erase(parent, defrag_inodes);
 	return entry;
 }
 
@@ -313,10 +311,20 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 {
 	struct inode_defrag *defrag;
+	struct rb_root defrag_inodes;
 	u64 first_ino = 0;
 	u64 root_objectid = 0;
 
 	atomic_inc(&fs_info->defrag_running);
+	spin_lock(&fs_info->defrag_inodes_lock);
+	/*
+	 * Swap the rb tree, so during autodefrag we won't run autodefrag
+	 * on the same inode due to the new writes.
+	 */
+	defrag_inodes.rb_node = fs_info->defrag_inodes.rb_node;
+	fs_info->defrag_inodes.rb_node = NULL;
+	spin_unlock(&fs_info->defrag_inodes_lock);
+
 	while (1) {
 		/* Pause the auto defragger. */
 		if (test_bit(BTRFS_FS_STATE_REMOUNTING,
@@ -327,7 +335,7 @@ int btrfs_run_defrag_inodes(struct btrfs_fs_info *fs_info)
 			break;
 
 		/* find an inode to defrag */
-		defrag = btrfs_pick_defrag_inode(fs_info, root_objectid,
+		defrag = btrfs_pick_defrag_inode(&defrag_inodes, root_objectid,
 						 first_ino);
 		if (!defrag) {
 			if (root_objectid || first_ino) {
-- 
2.35.1

