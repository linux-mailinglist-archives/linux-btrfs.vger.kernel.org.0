Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0CC3A58C4
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbhFMNme (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34540 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNmc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:32 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A029D21972;
        Sun, 13 Jun 2021 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l64Lba1V7WJAKv4Fw6fS8eIAElGUf9K5xGDxUIIzbaw=;
        b=drwsgh2tG3v7xmZEcAq33z4zpoQCLhYO3Vuuq+UY/wIGEWN5jkTpZnCy3UvP++blTbj8+D
        P65wEuu3t+5cyQeaPAq1IjUlQmZGp4YqNfviBt2sdq+jm+gbDziXCVtfZaxuklyUVWv49Q
        WsvQbGLmSM8D25vuo/GxTjCWb6dbP1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l64Lba1V7WJAKv4Fw6fS8eIAElGUf9K5xGDxUIIzbaw=;
        b=Yo2U5qaoQWNQ60+Zyl5MV6J5+rlmm1/NOYZ5EH7J/n9a44Hof/0sLdy43qMkZfJ3P46QOb
        NHTWnp7kXeNvLpAA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4A64A118DD;
        Sun, 13 Jun 2021 13:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l64Lba1V7WJAKv4Fw6fS8eIAElGUf9K5xGDxUIIzbaw=;
        b=drwsgh2tG3v7xmZEcAq33z4zpoQCLhYO3Vuuq+UY/wIGEWN5jkTpZnCy3UvP++blTbj8+D
        P65wEuu3t+5cyQeaPAq1IjUlQmZGp4YqNfviBt2sdq+jm+gbDziXCVtfZaxuklyUVWv49Q
        WsvQbGLmSM8D25vuo/GxTjCWb6dbP1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591630;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l64Lba1V7WJAKv4Fw6fS8eIAElGUf9K5xGDxUIIzbaw=;
        b=Yo2U5qaoQWNQ60+Zyl5MV6J5+rlmm1/NOYZ5EH7J/n9a44Hof/0sLdy43qMkZfJ3P46QOb
        NHTWnp7kXeNvLpAA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 5A1ABs4KxmBcJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:30 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 09/31] btrfs: Don't process pages if locked_page is NULL
Date:   Sun, 13 Jun 2021 08:39:37 -0500
Message-Id: <4d69749390822e1241158412dd5c94d70dfab7a0.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is an ugly hack so we don't process pages since all page processing
is performed in iomap.

Ideally, we would want to change this to remove locked_page argument
from the run_delalloc_range()->cow_file_range() calls.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/extent_io.c | 3 +++
 fs/btrfs/inode.c     | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 75ad809e8c86..71a59fbeffe1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2101,6 +2101,9 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
 {
 	clear_extent_bit(&inode->io_tree, start, end, clear_bits, 1, 0, NULL);
 
+	if (!locked_page)
+		return;
+
 	__process_pages_contig(inode->vfs_inode.i_mapping, locked_page,
 			       start, end, page_ops, NULL);
 }
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7761a60788d0..5491d0e5600f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1112,7 +1112,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			 * can't use page_started to determine if it's an
 			 * inline extent or a compressed extent.
 			 */
-			unlock_page(locked_page);
+			if (locked_page)
+				unlock_page(locked_page);
 			goto out;
 		} else if (ret < 0) {
 			goto out_unlock;
-- 
2.31.1

