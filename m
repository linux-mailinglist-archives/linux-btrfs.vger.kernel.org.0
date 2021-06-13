Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFD73A58C9
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhFMNmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55418 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhFMNmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A33B41FD2D;
        Sun, 13 Jun 2021 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khznnwgj7wHuTmt9TmWpJgaRjU/UBMcYdj9n6fBdBQQ=;
        b=m4Bm7cFUdEv9SOORiUGt6cXlxqnrH6ysL9Tyym5fX0zKesDgxJdapyZOOFooEiWpR5y/8Q
        gq0oB0ItWQKD/FJ4KK/dvA5thNFQGyrF6O4TStH3nkDqI8601wFYxlvaq9d+SbV40DFS2u
        lOzu3bierOrKLXbTgd5xpB/vagiTayQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khznnwgj7wHuTmt9TmWpJgaRjU/UBMcYdj9n6fBdBQQ=;
        b=bJNl6F3vtOAc/m4/XlMAaXjDzy8qpZIaL7dO4IzxVo/vm25JHaKRLKIR8P11c3JQqYIEhj
        g5aekyEW9tVI58DA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 46134118DD;
        Sun, 13 Jun 2021 13:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khznnwgj7wHuTmt9TmWpJgaRjU/UBMcYdj9n6fBdBQQ=;
        b=m4Bm7cFUdEv9SOORiUGt6cXlxqnrH6ysL9Tyym5fX0zKesDgxJdapyZOOFooEiWpR5y/8Q
        gq0oB0ItWQKD/FJ4KK/dvA5thNFQGyrF6O4TStH3nkDqI8601wFYxlvaq9d+SbV40DFS2u
        lOzu3bierOrKLXbTgd5xpB/vagiTayQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591642;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khznnwgj7wHuTmt9TmWpJgaRjU/UBMcYdj9n6fBdBQQ=;
        b=bJNl6F3vtOAc/m4/XlMAaXjDzy8qpZIaL7dO4IzxVo/vm25JHaKRLKIR8P11c3JQqYIEhj
        g5aekyEW9tVI58DA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id jsxaB9oKxmBtJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:42 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 14/31] btrfs: end EXTENT_MAP_INLINE writeback early
Date:   Sun, 13 Jun 2021 08:39:42 -0500
Message-Id: <6a5603135d159456d68a566900306cb86b5bbcb1.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

writes to inline extent maps are finished immediately and does
not go through the entire writeback cycle of creation or submission of
bios.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/inode.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b8fcf9102eb2..0601cf375b9c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8346,7 +8346,22 @@ static int btrfs_map_blocks(struct iomap_writepage_ctx *wpc,
 		return ret;
 
 	/* TODO: handle compressed extents */
-	return btrfs_set_iomap(inode, offset, end - offset, &wpc->iomap);
+	ret = btrfs_set_iomap(inode, offset, end - offset, &wpc->iomap);
+	if (ret < 0) {
+		__endio_write_update_ordered(BTRFS_I(inode), start, end, false);
+		return ret;
+	}
+
+	if (wpc->iomap.type == IOMAP_INLINE) {
+		/*
+		 * In case of EXTENT_MAP_INLINE, call endio function
+		 * and reset type to IOMAP_HOLE, so iomap code does not
+		 * perform any action
+		 */
+		__endio_write_update_ordered(BTRFS_I(inode), start, end, true);
+		wpc->iomap.type = IOMAP_HOLE;
+	}
+	return 0;
 }
 
 static void btrfs_writepage_endio(struct bio *bio)
-- 
2.31.1

