Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A83A58C7
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhFMNmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55402 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:39 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B85861FD2D;
        Sun, 13 Jun 2021 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmnkcrX6Ieqz0c3J0QPXJe4jqVvUe93ZisuNxNlg03o=;
        b=CnjQ4PPHK8Pdhe2XjcJjgzXS3H3Iwm/jJdKy4SYRIIxngFqRTqeKUiQUfKBiLjmTztna8v
        xxYE0GPmMrO0s4KspNgjliGVZiWIGq0nLO2sBx/31khgQTZ4xpkmQPqV93C2dI11TWgcc9
        qTTcSg1RmorI4cEmTK6hwF+kns2eanc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmnkcrX6Ieqz0c3J0QPXJe4jqVvUe93ZisuNxNlg03o=;
        b=lx4WnwyrkYm1IL4VY2KiOFy4e5Jf99x93Q9hnuiYg6YbPcNrztQQ4GSTffoiNczSuUKtVq
        c+zRLt9LCH2nZ/Bw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 5AFE9118DD;
        Sun, 13 Jun 2021 13:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmnkcrX6Ieqz0c3J0QPXJe4jqVvUe93ZisuNxNlg03o=;
        b=CnjQ4PPHK8Pdhe2XjcJjgzXS3H3Iwm/jJdKy4SYRIIxngFqRTqeKUiQUfKBiLjmTztna8v
        xxYE0GPmMrO0s4KspNgjliGVZiWIGq0nLO2sBx/31khgQTZ4xpkmQPqV93C2dI11TWgcc9
        qTTcSg1RmorI4cEmTK6hwF+kns2eanc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kmnkcrX6Ieqz0c3J0QPXJe4jqVvUe93ZisuNxNlg03o=;
        b=lx4WnwyrkYm1IL4VY2KiOFy4e5Jf99x93Q9hnuiYg6YbPcNrztQQ4GSTffoiNczSuUKtVq
        c+zRLt9LCH2nZ/Bw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id mjIbCtUKxmBoJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:37 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 12/31] btrfs: endio sequence for writepage
Date:   Sun, 13 Jun 2021 08:39:40 -0500
Message-Id: <fa30cefa3bf19ab60864f60799e36aae63041e87.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Perform extent housekeeping after completion of bio. This calls
iomap_writepage_end_bio() to perform end of write sequence for
the pages.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 87d0730f59d8..b8fcf9102eb2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8349,6 +8349,23 @@ static int btrfs_map_blocks(struct iomap_writepage_ctx *wpc,
 	return btrfs_set_iomap(inode, offset, end - offset, &wpc->iomap);
 }
 
+static void btrfs_writepage_endio(struct bio *bio)
+{
+	int error = blk_status_to_errno(bio->bi_status);
+	struct iomap_ioend *ioend = bio->bi_private;
+	struct btrfs_inode *inode = BTRFS_I(ioend->io_inode);
+	struct btrfs_fs_info *fs_info = btrfs_sb(ioend->io_inode->i_sb);
+	struct btrfs_ordered_extent *ordered = NULL;
+
+	if (!btrfs_dec_test_ordered_pending(inode, &ordered, ioend->io_offset,
+					    ioend->io_size, !error))
+		return;
+
+	btrfs_init_work(&ordered->work, finish_ordered_fn, NULL, NULL);
+	btrfs_queue_work(fs_info->endio_write_workers, &ordered->work);
+	iomap_writepage_end_bio(bio);
+}
+
 static void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
 {
 	struct bio_vec *bvec;
@@ -8358,6 +8375,7 @@ static void btrfs_buffered_submit_io(struct inode *inode, struct bio *bio)
 		bio_for_each_segment_all(bvec, bio, iter_all)
 			set_page_extent_mapped(bvec->bv_page);
 
+	bio->bi_end_io = btrfs_writepage_endio;
 	if (is_data_inode(inode))
 		btrfs_submit_data_bio(inode, bio, 0, 0);
 	else
-- 
2.31.1

