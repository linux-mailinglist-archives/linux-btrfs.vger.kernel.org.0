Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632E7517DA0
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiECGyU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiECGx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E28315832
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:25 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6131D210E4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZbGW9K/p2Vc8WMs2dxy79g/NrW/eTai0TSGqnMkpIE=;
        b=kuOjzs7CpGQ1S2RFFzOdCx67SqpOuoSnUeNsTdElWdg6JpqlYqXYW2x9UKE4tZJZMf//fk
        oO/wmgozIuunjXeLbMK0KD06Y8mwnOV6JvGJ+sAAo+7DDHsxxKwBxO5Y4MI7p1r2i5H4cj
        ZWezYlgGKKQJXNT/5mWnmynBEP4zrpY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBE8C13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CCTuJq/QcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 09/13] btrfs: handle RAID56 read repair differently
Date:   Tue,  3 May 2022 14:49:53 +0800
Message-Id: <80006286af884f8aec7e53f6a0c87b9f968ef920.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <cover.1651559986.git.wqu@suse.com>
References: <cover.1651559986.git.wqu@suse.com>
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

Our current read repair facility does its work completely relying on
mirror number.
And for repaired sector, it will write the correct data back to the bad
mirror.

This works great for mirror based profiles, but for RAID56 it's a
different story.

Partial write in btrfs raid56 will lead to unconditional RMW, completely
ignoring the mirror number (which is to indicate the corrupted data
stripe number).

This will cause us to read back the corrupted data on-disk, and result
further corruption.

To address it, we introduce btrfs_read_repair_ctrl::is_raid56, and for
RAID56 read-repair, we fallback to the tried-and-tree
btrfs_repair_io_failure().

That function handles RAID56 by using MAP_READ for btrfs_map_block() and
directly write the correct data back to disk, avoiding the RMW problem.

Unfortunately we lose the asynchronous bio assembly/submission, but it
should still be more or less acceptable considering RAID56 is really an
odd ball here.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/read-repair.c | 26 ++++++++++++++++++++++++++
 fs/btrfs/read-repair.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/fs/btrfs/read-repair.c b/fs/btrfs/read-repair.c
index aecdc4ee54ba..e1b11990a480 100644
--- a/fs/btrfs/read-repair.c
+++ b/fs/btrfs/read-repair.c
@@ -55,6 +55,8 @@ void btrfs_read_repair_add_sector(struct inode *inode,
 		ASSERT(ctrl->init_mirror);
 		ctrl->num_copies = btrfs_num_copies(fs_info, ctrl->logical,
 						    sectorsize);
+		ctrl->is_raid56 = btrfs_is_parity_mirror(fs_info,
+						ctrl->logical, sectorsize);
 		init_waitqueue_head(&ctrl->io_wait);
 		atomic_set(&ctrl->io_bytes, 0);
 		/*
@@ -153,6 +155,30 @@ static void read_repair_bio_add_sector(struct btrfs_read_repair_ctrl *ctrl,
 	if (opf == REQ_OP_WRITE) {
 		if (btrfs_repair_one_zone(fs_info, ctrl->logical))
 			return;
+
+		/*
+		 * For RAID56, we can not just write the bad data back, as
+		 * any write will trigger RMW and read back the corrrupted
+		 * on-disk stripe, causing further damage.
+		 * So here we do special repair for raid56.
+		 *
+		 * And unfortunately, this repair is very low level and not
+		 * compatible with the rest of the mirror based repair.
+		 * So it's still done in synchronous mode using
+		 * btrfs_repair_io_failure().
+		 */
+		if (ctrl->is_raid56) {
+			const u64 logical = ctrl->logical +
+					(sector_nr << fs_info->sectorsize_bits);
+			const u64 file_offset = ctrl->file_offset +
+					(sector_nr << fs_info->sectorsize_bits);
+
+			btrfs_repair_io_failure(fs_info,
+					btrfs_ino(BTRFS_I(ctrl->inode)),
+					file_offset, fs_info->sectorsize,
+					logical, page, pgoff, mirror);
+			return;
+		}
 	}
 
 	/* Check if the sector can be added to the last bio */
diff --git a/fs/btrfs/read-repair.h b/fs/btrfs/read-repair.h
index 3e1430489f89..6cc816e2ce4a 100644
--- a/fs/btrfs/read-repair.h
+++ b/fs/btrfs/read-repair.h
@@ -42,6 +42,8 @@ struct btrfs_read_repair_ctrl {
 	 * at bio allocation time.
 	 */
 	bool error;
+
+	bool is_raid56;
 };
 
 int btrfs_read_repair_alloc_bitmaps(struct btrfs_fs_info *fs_info,
-- 
2.36.0

