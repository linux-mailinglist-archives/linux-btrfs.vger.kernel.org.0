Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46DA63A58BD
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhFMNmR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:17 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34502 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNmQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:16 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F3E2621973;
        Sun, 13 Jun 2021 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSEaLkVpkKswEMClQZajPDa8Ztrho6+KzaxTdXhJHkc=;
        b=12erQFm2dI14QpGCBFVVW6Q+OiVgDww8lx7D/HMzcjH52ob/mO9ds+ywEBVKLadZ4I+rb+
        VHL+fKIlvpwnODaApNzwAq3nudLxqf9dYQeVH59JSrdvDoY3xFNDqNgxJBtCzE75MZQSgC
        z6oYUTswLodupEtQ7sNq0B6QEiaFUu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSEaLkVpkKswEMClQZajPDa8Ztrho6+KzaxTdXhJHkc=;
        b=SR52TwsqXC1ucvVp4SpcvGamM7kbRp1xM69nQOuMmXgJ7VugjQY3Dp1jKDgKpLFVDSwJQu
        JUnH9iOFzocjboDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9D421118DD;
        Sun, 13 Jun 2021 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSEaLkVpkKswEMClQZajPDa8Ztrho6+KzaxTdXhJHkc=;
        b=12erQFm2dI14QpGCBFVVW6Q+OiVgDww8lx7D/HMzcjH52ob/mO9ds+ywEBVKLadZ4I+rb+
        VHL+fKIlvpwnODaApNzwAq3nudLxqf9dYQeVH59JSrdvDoY3xFNDqNgxJBtCzE75MZQSgC
        z6oYUTswLodupEtQ7sNq0B6QEiaFUu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591614;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mSEaLkVpkKswEMClQZajPDa8Ztrho6+KzaxTdXhJHkc=;
        b=SR52TwsqXC1ucvVp4SpcvGamM7kbRp1xM69nQOuMmXgJ7VugjQY3Dp1jKDgKpLFVDSwJQu
        JUnH9iOFzocjboDw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 0XYyGr4KxmAzJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:14 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 02/31] iomap: Add submit_io to writepage_ops
Date:   Sun, 13 Jun 2021 08:39:30 -0500
Message-Id: <999c273a4d4fd73ecd9fe80a20e7008eb1124b35.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Filesystems such as btrfs need to perform pre and post bio operations
such as csum calculations, device mapping etc.

Add a submit_io() function to writepage_ops so filesystems can control
how the bio is submitted.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/iomap/buffered-io.c | 11 ++++++++++-
 include/linux/iomap.h  |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d30683734d01..b6fd6d6118a6 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1209,7 +1209,11 @@ iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
 		return error;
 	}
 
-	submit_bio(ioend->io_bio);
+	if (wpc->ops->submit_io)
+		wpc->ops->submit_io(ioend->io_inode, ioend->io_bio);
+	else
+		submit_bio(ioend->io_bio);
+
 	return 0;
 }
 
@@ -1305,8 +1309,13 @@ iomap_add_to_ioend(struct inode *inode, loff_t offset, struct page *page,
 
 	if (!merged) {
 		if (bio_full(wpc->ioend->io_bio, len)) {
+			struct bio *bio = wpc->ioend->io_bio;
 			wpc->ioend->io_bio =
 				iomap_chain_bio(wpc->ioend->io_bio);
+			if (wpc->ops->submit_io)
+				wpc->ops->submit_io(inode, bio);
+			else
+				submit_bio(bio);
 		}
 		bio_add_page(wpc->ioend->io_bio, page, len, poff);
 	}
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index c87d0cb0de6d..689d799b1915 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -223,6 +223,12 @@ struct iomap_writeback_ops {
 	 * we failed to submit any I/O.
 	 */
 	void (*discard_page)(struct page *page, loff_t fileoff);
+
+	/*
+	 * Optional, allows the filesystem to perform a custom submission of
+	 * bio, such as csum calculations or multi-device bio split
+	 */
+	void (*submit_io)(struct inode *inode, struct bio *bio);
 };
 
 struct iomap_writepage_ctx {
-- 
2.31.1

