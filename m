Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C232566440
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Jul 2022 09:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiGEHjv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Jul 2022 03:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiGEHjr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Jul 2022 03:39:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B3713D32
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 00:39:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 11FDD2249A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1657006785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5wAnly9u644AH7ceVSil7I+2Qawrhzn3ZbpqBQwYEQ8=;
        b=Zn5H/dujVErqCZjJWJXCgpWgHnvoaP/g4Yy0aCGhgeoTFBCg1DscKd2DjoW05YQ/3wS7ps
        TnY65XMF5TgybgiOOQ7L56zEBnpYAT3xwVxAPV86zhtdcUJ0drAmrhwMaPAKf8ls9zRdlA
        CqM1zBL4QwJPhcQJLET979hMEv6I4ZI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E65951339A
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Jul 2022 07:39:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aDLLK7/qw2L6OwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 05 Jul 2022 07:39:43 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 11/11] btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
Date:   Tue,  5 Jul 2022 15:39:13 +0800
Message-Id: <9a9ffca76a342d2277059b71c2e23b879d31e608.1657004556.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1657004556.git.wqu@suse.com>
References: <cover.1657004556.git.wqu@suse.com>
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

To properly cleanup the bitmaps, we need to scrub the logical ranges in
the bitmaps.

Unfortunately there is no such convient interface at all (scrub only
works at device offset for now).

So just introduce a place holder to warn and clear the bitmap.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c      |  7 +++++++
 fs/btrfs/write-intent.c | 35 +++++++++++++++++++++++++++++++++++
 fs/btrfs/write-intent.h | 10 ++++++++++
 3 files changed, 52 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index bd30decd38e4..ccc136023303 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3705,6 +3705,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 			  ret);
 		goto fail_block_groups;
 	}
+
+	ret = btrfs_write_intent_recover(fs_info);
+	if (ret < 0) {
+		btrfs_err(fs_info, "failed to recover write-intent bitmap: %d",
+			  ret);
+		goto fail_block_groups;
+	}
 	ret = btrfs_recover_balance(fs_info);
 	if (ret) {
 		btrfs_err(fs_info, "failed to recover balance: %d", ret);
diff --git a/fs/btrfs/write-intent.c b/fs/btrfs/write-intent.c
index c8bee0f89fc9..529690fdfb0c 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -763,6 +763,41 @@ void btrfs_write_intent_clear_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 }
 
+int btrfs_write_intent_recover(struct btrfs_fs_info *fs_info)
+{
+	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
+	struct write_intent_super *wis;
+	int ret = 0;
+
+	if (!btrfs_fs_compat_ro(fs_info, WRITE_INTENT_BITMAP))
+		return ret;
+
+	ASSERT(ctrl);
+	wis = page_address(ctrl->page);
+
+	if (wi_super_nr_entries(wis) != 0) {
+		int i;
+
+		btrfs_warn(fs_info, "dirty write intent bitmap found:");
+		for (i = 0; i < wi_super_nr_entries(wis); i++) {
+			struct write_intent_entry *entry =
+				write_intent_entry_nr(ctrl, i);
+
+			btrfs_warn(fs_info,
+				"  entry=%u bytenr=%llu bitmap=0x%016llx\n", i,
+				   wi_entry_bytenr(entry),
+				   wi_entry_raw_bitmap(entry));
+		}
+		/* For now, we just clear the whole bitmap. */
+		memzero_page(ctrl->page, sizeof(struct write_intent_super),
+			     WRITE_INTENT_BITMAPS_SIZE -
+			     sizeof(struct write_intent_super));
+		wi_set_super_nr_entries(wis, 0);
+		ret = write_intent_writeback(fs_info);
+	}
+	return ret;
+}
+
 int btrfs_write_intent_writeback(struct btrfs_fs_info *fs_info, u64 event)
 {
 	struct write_intent_ctrl *ctrl = fs_info->wi_ctrl;
diff --git a/fs/btrfs/write-intent.h b/fs/btrfs/write-intent.h
index 7c0ea3545e89..eafbd3e80c54 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -215,6 +215,8 @@ WRITE_INTENT_SETGET_FUNCS(super_blocksize, struct write_intent_super,
 WRITE_INTENT_SETGET_FUNCS(super_csum_type, struct write_intent_super,
 			  csum_type, 16);
 WRITE_INTENT_SETGET_FUNCS(entry_bytenr, struct write_intent_entry, bytenr, 64);
+WRITE_INTENT_SETGET_FUNCS(entry_raw_bitmap, struct write_intent_entry,
+			  bitmap, 64);
 
 static inline u32 write_intent_entry_size(struct write_intent_ctrl *ctrl)
 {
@@ -275,4 +277,12 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
  */
 void btrfs_write_intent_clear_dirty(struct btrfs_fs_info *fs_info, u64 logical,
 				    u32 len);
+
+/*
+ * Rebuild the range in the write-intent bitmaps.
+ *
+ * Currently not working, it will just output a warning and clear the bitmap.
+ */
+int btrfs_write_intent_recover(struct btrfs_fs_info *fs_info);
+
 #endif
-- 
2.36.1

