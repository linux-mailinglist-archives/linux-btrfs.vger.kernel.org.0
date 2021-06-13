Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7800A3A58C6
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbhFMNmh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34556 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhFMNmh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:37 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2E5C121972;
        Sun, 13 Jun 2021 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9FXmnKCi1B4iOtWVu8/g8/D4h2jusWPmEMhnU+OBdI=;
        b=jQ6+OXs4d+bm6BSXVoid6d2t0hA3pby/iprtwqvdGFTfF3mfgFK5jzvA/1Pt3/1uUiY75G
        USXjNNt5CvYHSWurfseD6NutdaMBPQb6p5WcpoNm2prr/1MPTf7poySSml1mnwvtJQj1MD
        XIKcZl2DjpGdERRLW8NdaLL7k9AGmBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9FXmnKCi1B4iOtWVu8/g8/D4h2jusWPmEMhnU+OBdI=;
        b=ycKMpAmgK1XKwjBr908UfGet7X0ReDDdj3QO593PSuUdGBu1L9+CmRrCLkVKeLkSu6JmeZ
        sgx8Ta04liPM7xAg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id C66ED118DD;
        Sun, 13 Jun 2021 13:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9FXmnKCi1B4iOtWVu8/g8/D4h2jusWPmEMhnU+OBdI=;
        b=jQ6+OXs4d+bm6BSXVoid6d2t0hA3pby/iprtwqvdGFTfF3mfgFK5jzvA/1Pt3/1uUiY75G
        USXjNNt5CvYHSWurfseD6NutdaMBPQb6p5WcpoNm2prr/1MPTf7poySSml1mnwvtJQj1MD
        XIKcZl2DjpGdERRLW8NdaLL7k9AGmBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9FXmnKCi1B4iOtWVu8/g8/D4h2jusWPmEMhnU+OBdI=;
        b=ycKMpAmgK1XKwjBr908UfGet7X0ReDDdj3QO593PSuUdGBu1L9+CmRrCLkVKeLkSu6JmeZ
        sgx8Ta04liPM7xAg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 15M5J9IKxmBgJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:34 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 11/31] btrfs: Use submit_io to submit btrfs writeback bios
Date:   Sun, 13 Jun 2021 08:39:39 -0500
Message-Id: <b281a2a58372728b86453a0cc6506d4bf5e68fa3.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The submit_io sequence calls set_page_extent_mapped() for data
inodes to make sure that page->private is set. Depending on
the type of inode: metadata or data, the respective submit_bio
function is called.

This will also be used for readpage() sequence.
---
 fs/btrfs/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eff4ec44fecd..87d0730f59d8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8349,11 +8349,26 @@ static int btrfs_map_blocks(struct iomap_writepage_ctx *wpc,
 	return btrfs_set_iomap(inode, offset, end - offset, &wpc->iomap);
 }
 
+static void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
+{
+	struct bio_vec *bvec;
+	struct bvec_iter_all iter_all;
+
+	if (is_data_inode(inode))
+		bio_for_each_segment_all(bvec, bio, iter_all)
+			set_page_extent_mapped(bvec->bv_page);
+
+	if (is_data_inode(inode))
+		btrfs_submit_data_bio(inode, bio, 0, 0);
+	else
+		btrfs_submit_metadata_bio(inode, bio, 0, 0);
+}
+
 static const struct iomap_writeback_ops btrfs_writeback_ops = {
 	.map_blocks             = btrfs_map_blocks,
+	.submit_io		= btrfs_buffered_submit_io,
 };
 
-
 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
-- 
2.31.1

