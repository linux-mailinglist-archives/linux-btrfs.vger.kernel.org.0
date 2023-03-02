Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AECA6A8BC1
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCBWZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCBWZp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 17:25:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FBF234DA
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 14:25:45 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B25692237D;
        Thu,  2 Mar 2023 22:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677795943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5Keo3uOIRWd2QQtlffm4dxJ8jVIoJZoS/Ta0DgpzJg=;
        b=BE5oABYEquxmDkr0yQ8U48f9+s6IRncMjy9iJFS+fZFfhVUkJna8uUnTtn/zIbde/NBpMR
        Vh5r0lftxTSdS2e2RFDNoZXmXZdfibvz9Q+hBoAhlOebB/gJn3YTYEdiV5Nq2obKzgyL+c
        EF0hibEgjx88dXYvzD+6AeESvNrS054=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677795943;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y5Keo3uOIRWd2QQtlffm4dxJ8jVIoJZoS/Ta0DgpzJg=;
        b=Np+/PPxeJOMp6kJtuDZpGAEoYqavu64Qs6pzZRU1mfa+yMuUNIax+wYqlg5e/YlxediFjV
        o8Yd43Yg1iN2HBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BA0B13349;
        Thu,  2 Mar 2023 22:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NE/dDWciAWTmSQAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Thu, 02 Mar 2023 22:25:43 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 17/21] btrfs: btree_writepages lock extents before pages
Date:   Thu,  2 Mar 2023 16:25:02 -0600
Message-Id: <409ec63c5aec1f140c60e6ae354f9461995a648f.1677793433.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677793433.git.rgoldwyn@suse.com>
References: <cover.1677793433.git.rgoldwyn@suse.com>
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

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Lock extents before pages while performing btree_writepages().

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/disk-io.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c2b954134851..5164bb9f6e2d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -725,8 +725,25 @@ static int btree_migrate_folio(struct address_space *mapping,
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
 
@@ -741,7 +758,12 @@ static int btree_writepages(struct address_space *mapping,
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
2.39.2

