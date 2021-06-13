Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E053A58DA
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhFMNn0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:43:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55494 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbhFMNnZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:25 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B19CC1FD32;
        Sun, 13 Jun 2021 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGS+rAwO6W5XC4k4/elnYe/7UK77wwj8LLNNxM0l86c=;
        b=dznH0irWlm9RXBLlBfzTLHg8E0gbRbcnGAZq4gLpCsQs4hKa6Q3JMbtDclHveslfAgtTMm
        eH79FoX7qpI4xilhkwBrCIQa/ZDa2wx07p5j556U1HansQkh7YUdW+JBOwwuXE3CGiNJ2l
        Dc5O92qtiZGJ/pAB4KMbjWRdgjIU3lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGS+rAwO6W5XC4k4/elnYe/7UK77wwj8LLNNxM0l86c=;
        b=ctKZR8q0fCGOy69SQGNK4URuxxCBgTSq8sZLiIlhjzep456JrnatZQEd6Rhh1I93KshE8q
        +jR4c1Fsmyuzl0AQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 55395118DD;
        Sun, 13 Jun 2021 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGS+rAwO6W5XC4k4/elnYe/7UK77wwj8LLNNxM0l86c=;
        b=dznH0irWlm9RXBLlBfzTLHg8E0gbRbcnGAZq4gLpCsQs4hKa6Q3JMbtDclHveslfAgtTMm
        eH79FoX7qpI4xilhkwBrCIQa/ZDa2wx07p5j556U1HansQkh7YUdW+JBOwwuXE3CGiNJ2l
        Dc5O92qtiZGJ/pAB4KMbjWRdgjIU3lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DGS+rAwO6W5XC4k4/elnYe/7UK77wwj8LLNNxM0l86c=;
        b=ctKZR8q0fCGOy69SQGNK4URuxxCBgTSq8sZLiIlhjzep456JrnatZQEd6Rhh1I93KshE8q
        +jR4c1Fsmyuzl0AQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id E5ChCAMLxmC/JAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:41:23 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 31/31] btrfs: Switch to iomap_readpage() and iomap_readahead()
Date:   Sun, 13 Jun 2021 08:39:59 -0500
Message-Id: <92c58a2ffd31c6538fe3b1a50d5c38556631cbae.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Use iomap readpage and readahead sequences.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1ca83c11e8b9..56d9cbeb151d 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8320,18 +8320,8 @@ const struct iomap_ops btrfs_buffered_read_iomap_ops = {
 
 int btrfs_readpage(struct file *file, struct page *page)
 {
-	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
-	u64 start = page_offset(page);
-	u64 end = start + PAGE_SIZE - 1;
-	struct btrfs_bio_ctrl bio_ctrl = { 0 };
-	int ret;
-
-	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);
-
-	ret = btrfs_do_readpage(page, NULL, &bio_ctrl, 0, NULL);
-	if (bio_ctrl.bio)
-		ret = submit_one_bio(bio_ctrl.bio, 0, bio_ctrl.bio_flags);
-	return ret;
+	return iomap_readpage(page, &btrfs_buffered_read_iomap_ops,
+				&btrfs_iomap_readpage_ops);
 }
 
 static int find_delalloc_range(struct inode *inode, u64 *start, u64 *end)
@@ -8492,7 +8482,8 @@ static int btrfs_writepages(struct address_space *mapping,
 
 static void btrfs_readahead(struct readahead_control *rac)
 {
-	extent_readahead(rac);
+	iomap_readahead(rac, &btrfs_buffered_read_iomap_ops,
+			&btrfs_iomap_readpage_ops);
 }
 
 static int __btrfs_releasepage(struct page *page, gfp_t gfp_flags)
-- 
2.31.1

