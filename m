Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB37B3A58BC
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhFMNmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34492 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhFMNmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:15 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF54F21972;
        Sun, 13 Jun 2021 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kF9mUTKWAgird3A2WvETQdl4IQRcEa9mc2Hk3dPUiUc=;
        b=hs9/Iy46YvQMyuJcZnETN8CVdq1P4YXl1d6KRScezKajdV2+dIYBDs2Jpe4VRL2xp3orCr
        56Lu+DC0tr2hFasR7KDF9qgyyMaCfRyfFoSvbz9LxujfcPnKiMcjOoXE4iwhEN98ZyAaeG
        +bUV8d0drvCN/3bPnzCadnKRkI3C1ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kF9mUTKWAgird3A2WvETQdl4IQRcEa9mc2Hk3dPUiUc=;
        b=AC/6Co1bKEFys5YjlOORGZfXrF02CR8PZTJIT/yxf7Ju2cUeAvMGNNMNBVTONjhokdDOqt
        O/5LvDuOlKfy9mDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 8827D118DD;
        Sun, 13 Jun 2021 13:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kF9mUTKWAgird3A2WvETQdl4IQRcEa9mc2Hk3dPUiUc=;
        b=hs9/Iy46YvQMyuJcZnETN8CVdq1P4YXl1d6KRScezKajdV2+dIYBDs2Jpe4VRL2xp3orCr
        56Lu+DC0tr2hFasR7KDF9qgyyMaCfRyfFoSvbz9LxujfcPnKiMcjOoXE4iwhEN98ZyAaeG
        +bUV8d0drvCN/3bPnzCadnKRkI3C1ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591612;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kF9mUTKWAgird3A2WvETQdl4IQRcEa9mc2Hk3dPUiUc=;
        b=AC/6Co1bKEFys5YjlOORGZfXrF02CR8PZTJIT/yxf7Ju2cUeAvMGNNMNBVTONjhokdDOqt
        O/5LvDuOlKfy9mDQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id omzkGLwKxmAtJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:12 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 01/31] iomap: Check if blocksize == PAGE_SIZE in to_iomap_page()
Date:   Sun, 13 Jun 2021 08:39:29 -0500
Message-Id: <79781ca99470475ff33382e67571eeb914edac63.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs requires page->private set to get a callback to releasepage(). So,
for normal circumstances of blocksize==PAGE_SIZE, btrfs will have
page->private set to 1. In order to avoid a crash, check for the
blocksize==PAGE_SIZE in to_iomap_page().
---
 fs/iomap/buffered-io.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9023717c5188..d30683734d01 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -41,9 +41,11 @@ static inline struct iomap_page *to_iomap_page(struct page *page)
 	 */
 	VM_BUG_ON_PGFLAGS(PageTail(page), page);
 
-	if (page_has_private(page))
-		return (struct iomap_page *)page_private(page);
-	return NULL;
+	if (i_blocksize(page->mapping->host) == PAGE_SIZE)
+		return NULL;
+	if (!page_has_private(page))
+		return NULL;
+	return (struct iomap_page *)page_private(page);
 }
 
 static struct bio_set iomap_ioend_bioset;
@@ -163,7 +165,7 @@ iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len)
 	if (PageError(page))
 		return;
 
-	if (page_has_private(page))
+	if (i_blocksize(page->mapping->host) != PAGE_SIZE)
 		iomap_iop_set_range_uptodate(page, off, len);
 	else
 		SetPageUptodate(page);
-- 
2.31.1

