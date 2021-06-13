Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F473A58CD
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhFMNmy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55442 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:53 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C23FB1FD2D;
        Sun, 13 Jun 2021 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE0FtYlgl8ev2sxWtgXXJjO7FApdkFhMALSqMYUM8Iw=;
        b=hQm0YlmaWz49yU82yR3Qa22329SQLw/5zIWJ5ZaRlmRut5PCx71SOucrWMaixWlZLLpCuO
        rEGyOPtALT/gJd8WKMIfuLd5R5yo9RHyYpPsdwOYTUP0AKRzwYvvSZDtRkgM/L/D2T8bGl
        sPWGLjg8G37nzPRTydMf22y27XtxRds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE0FtYlgl8ev2sxWtgXXJjO7FApdkFhMALSqMYUM8Iw=;
        b=bg9C3zzv41253kqtp5b066vULdQ6b6g+24bUBH1++7bFBdbl/ZeE1LgH4c+ztVT/AltsK1
        5RkRgfAxd+uOpSBg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 6BB21118DD;
        Sun, 13 Jun 2021 13:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591651; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE0FtYlgl8ev2sxWtgXXJjO7FApdkFhMALSqMYUM8Iw=;
        b=hQm0YlmaWz49yU82yR3Qa22329SQLw/5zIWJ5ZaRlmRut5PCx71SOucrWMaixWlZLLpCuO
        rEGyOPtALT/gJd8WKMIfuLd5R5yo9RHyYpPsdwOYTUP0AKRzwYvvSZDtRkgM/L/D2T8bGl
        sPWGLjg8G37nzPRTydMf22y27XtxRds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591651;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZE0FtYlgl8ev2sxWtgXXJjO7FApdkFhMALSqMYUM8Iw=;
        b=bg9C3zzv41253kqtp5b066vULdQ6b6g+24bUBH1++7bFBdbl/ZeE1LgH4c+ztVT/AltsK1
        5RkRgfAxd+uOpSBg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id Xa0kEuMKxmCCJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:51 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 18/31] btrfs: Add btrfs_iomap_release()
Date:   Sun, 13 Jun 2021 08:39:46 -0500
Message-Id: <481e176481ae788109087bb0817ee7d589d933a9.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Function to release allocated btrfs_iomap resources.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a28435a6bb7e..3d4b8fde47f4 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1598,6 +1598,30 @@ void btrfs_em_to_iomap(struct inode *inode,
 	iomap->length = em->len - diff;
 }
 
+/*
+ * btrfs_iomap_release - release reservation passed as length and free
+ * the btrfs_iomap structure
+ */
+static void btrfs_iomap_release(struct inode *inode,
+		loff_t pos, size_t length, struct btrfs_iomap *bi)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+	if (length) {
+		if (bi->metadata_only) {
+			btrfs_delalloc_release_metadata(BTRFS_I(inode),
+					length, true);
+		} else {
+			btrfs_delalloc_release_space(BTRFS_I(inode),
+					bi->data_reserved,
+					round_down(pos, fs_info->sectorsize),
+					length, true);
+		}
+	}
+	extent_changeset_free(bi->data_reserved);
+	kfree(bi);
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
@@ -1817,24 +1841,14 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 
 	kfree(pages);
 
-	if (release_bytes) {
-		if (only_release_metadata) {
-			btrfs_check_nocow_unlock(BTRFS_I(inode));
-			btrfs_delalloc_release_metadata(BTRFS_I(inode),
-					release_bytes, true);
-		} else {
-			btrfs_delalloc_release_space(BTRFS_I(inode),
-					data_reserved,
-					round_down(pos, fs_info->sectorsize),
-					release_bytes, true);
-		}
-	}
-
-	extent_changeset_free(data_reserved);
 	if (num_written > 0) {
 		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
 		iocb->ki_pos += num_written;
 	}
+
+	if (release_bytes && bi->metadata_only)
+		btrfs_check_nocow_unlock(BTRFS_I(inode));
+	btrfs_iomap_release(inode, pos, release_bytes, bi);
 out:
 	kfree(bi);
 	btrfs_inode_unlock(inode, ilock_flags);
-- 
2.31.1

