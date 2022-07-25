Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95EC57F911
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jul 2022 07:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbiGYFih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jul 2022 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiGYFid (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jul 2022 01:38:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB22FD3B
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Jul 2022 22:38:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4F8FB34968
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658727511; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JkKTzrIEYKqicgHa6U9PkAncDWAz4CjTiJDLEwTucY0=;
        b=VhVzNGl7zX3ORPFBgh82z1N3n7sHAzbP7LKS0bnKyzz0pQZmZbk9zGVLucesH7s4cpiGkj
        9OoE9Vb3nSStrzPu0KfcDd8PXcJzCaQh2I88cA6RN32n9BBvrjtCtPQf/el2c5gUdhFgNn
        A4oGKFWnTDyf2v05+wxHVeAIOsbqfY4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B86EE13A8D
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eNYHIlYs3mJOLAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jul 2022 05:38:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 12/14] btrfs: warn and clear bitmaps if there is dirty bitmap at mount time
Date:   Mon, 25 Jul 2022 13:38:00 +0800
Message-Id: <eb8490c67393058494aedc31e8af89cd1fe61fd9.1658726692.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <cover.1658726692.git.wqu@suse.com>
References: <cover.1658726692.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 fs/btrfs/write-intent.h |  8 ++++++++
 3 files changed, 50 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 89bf3b2693a5..d29fad12d459 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3729,6 +3729,13 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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
index 40d579574f3d..82228713e621 100644
--- a/fs/btrfs/write-intent.c
+++ b/fs/btrfs/write-intent.c
@@ -704,6 +704,41 @@ void btrfs_write_intent_clear_dirty(struct btrfs_fs_info *fs_info, u64 logical,
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
index 872a707ef67d..bb6e9b599373 100644
--- a/fs/btrfs/write-intent.h
+++ b/fs/btrfs/write-intent.h
@@ -292,4 +292,12 @@ void btrfs_write_intent_mark_dirty(struct btrfs_fs_info *fs_info, u64 logical,
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
2.37.0

