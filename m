Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BBB62A100
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbiKOSCE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKOSBO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:01:14 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7AC62C7
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:01:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1CE291F8E0;
        Tue, 15 Nov 2022 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1668535272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wqci/3B1Q9K7U2AZI/lsbKOytc6jr8mWCM1rkUcjzog=;
        b=pn1Uugat2MHvpf88oPhgR1/gkLBRO+QvRnz3K68jlLlbAIxE4NnlDNjs1N/9F7C836X0hV
        877G01mVVlgouj0Jvb1QCQjf1Df/SOWw6U8pbl04ilzIcmdQeisWjJj0mt47luztmxcDeA
        fGmeeHmnVcXiuPUJ7yQ6CFpddwh8hqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1668535272;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wqci/3B1Q9K7U2AZI/lsbKOytc6jr8mWCM1rkUcjzog=;
        b=DcYhfbhBDo9Vghc+FjBAoZJ0tAYYezxdIGi/CXSVoxACSXQuIPc7iSdu/wRs7QLamJHxca
        GTfD/L2XoQPsUBCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C4CFE13A91;
        Tue, 15 Nov 2022 18:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id p8kTKOfTc2PVZAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Tue, 15 Nov 2022 18:01:11 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 16/16] btrfs: btree_writepages lock extents before pages
Date:   Tue, 15 Nov 2022 12:00:34 -0600
Message-Id: <994c7a74720e3c8589263095704dc7f87cfdb3e7.1668530684.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1668530684.git.rgoldwyn@suse.com>
References: <cover.1668530684.git.rgoldwyn@suse.com>
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

Lock extents before pages while performing btree_writepages().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/disk-io.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8ac9612f8f27..b7e7c4c9d404 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -858,8 +858,25 @@ static int btree_migrate_folio(struct address_space *mapping,
 static int btree_writepages(struct address_space *mapping,
 			    struct writeback_control *wbc)
 {
+	u64 start, end;
+	struct btrfs_inode *inode = BTRFS_I(mapping->host);
+        struct extent_state *cached = NULL;
 	struct btrfs_fs_info *fs_info;
 	int ret;
+	u64 isize = round_up(i_size_read(&inode->vfs_inode), PAGE_SIZE) - 1;
+
+	if (wbc->range_cyclic) {
+		start = mapping->writeback_index << PAGE_SHIFT;
+		end = isize;
+	} else {
+		start = round_down(wbc->range_start, PAGE_SIZE);
+		end = round_up(wbc->range_end, PAGE_SIZE) - 1;
+		end = min(isize, end);
+	}
+
+	if (start >= end)
+		return 0;
+
 
 	if (wbc->sync_mode == WB_SYNC_NONE) {
 
@@ -874,7 +891,12 @@ static int btree_writepages(struct address_space *mapping,
 		if (ret < 0)
 			return 0;
 	}
-	return btree_write_cache_pages(mapping, wbc);
+
+	lock_extent(&inode->io_tree, start, end, &cached);
+	ret = btree_write_cache_pages(mapping, wbc);
+	unlock_extent(&inode->io_tree, start, end, &cached);
+
+	return ret;
 }
 
 static bool btree_release_folio(struct folio *folio, gfp_t gfp_flags)
-- 
2.35.3

