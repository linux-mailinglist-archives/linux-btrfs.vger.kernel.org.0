Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D463A58C3
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhFMNma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55394 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbhFMNm3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:29 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1F45E1FD2D;
        Sun, 13 Jun 2021 13:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmYg5B27pnVNot470a/jdEU0j59AEPxgiFKN7pm7uuY=;
        b=bpF1tBVWBR2k3Qhg5ztrGbH7bXjj3YXfN3sBjXb7CIGqqKkC86G0yLQIU4zASnbwuAS9b5
        RH5jEWV5ov7IqRzMU+Sj0DAEO7WsZ+bnWbXTnh127Zfd136++Gn53Le222v/wJFgXVynae
        6BPeEqYyHoFMMCYBfmes0A60F4Bmoa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmYg5B27pnVNot470a/jdEU0j59AEPxgiFKN7pm7uuY=;
        b=nwHZZhuf0TNHGgA7BbQ23CZ8khLGj6iWqJpv2HebKNG7ko8B0KGASuOQzFJE5wFyfnTh24
        Bt2BbDesajHyn8Dg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id B6069118DD;
        Sun, 13 Jun 2021 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmYg5B27pnVNot470a/jdEU0j59AEPxgiFKN7pm7uuY=;
        b=bpF1tBVWBR2k3Qhg5ztrGbH7bXjj3YXfN3sBjXb7CIGqqKkC86G0yLQIU4zASnbwuAS9b5
        RH5jEWV5ov7IqRzMU+Sj0DAEO7WsZ+bnWbXTnh127Zfd136++Gn53Le222v/wJFgXVynae
        6BPeEqYyHoFMMCYBfmes0A60F4Bmoa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591628;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NmYg5B27pnVNot470a/jdEU0j59AEPxgiFKN7pm7uuY=;
        b=nwHZZhuf0TNHGgA7BbQ23CZ8khLGj6iWqJpv2HebKNG7ko8B0KGASuOQzFJE5wFyfnTh24
        Bt2BbDesajHyn8Dg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 39o6IcsKxmBQJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:27 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 08/31] btrfs: btrfs_em_to_iomap () to convert em to iomap
Date:   Sun, 13 Jun 2021 08:39:36 -0500
Message-Id: <87e85bcd1f50533b3a18c09cff5bd88cc3c6f923.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623567940.git.rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

btrfs_em_to_iomap() converts and extent map into passed argument struct
iomap. It makes sure the information is set close to sectorsize block.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  2 ++
 fs/btrfs/file.c  | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index c9256f862085..d4567c7a93cb 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3267,6 +3267,8 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
 int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 			   size_t *write_bytes);
 void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
+void btrfs_em_to_iomap(struct inode *inode, struct extent_map *em,
+		struct iomap *iomap, loff_t pos);
 
 /* tree-defrag.c */
 int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index e7d33c8177a0..cb9471e7224a 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1570,6 +1570,28 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 	return 0;
 }
 
+void btrfs_em_to_iomap(struct inode *inode,
+		struct extent_map *em, struct iomap *iomap,
+		loff_t sector_pos)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+	loff_t diff = sector_pos - em->start;
+
+	if (em->block_start == EXTENT_MAP_HOLE) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_HOLE;
+	} else if (em->block_start == EXTENT_MAP_INLINE) {
+		iomap->addr = IOMAP_NULL_ADDR;
+		iomap->type = IOMAP_INLINE;
+	} else {
+		iomap->addr = em->block_start + diff;
+		iomap->type = IOMAP_MAPPED;
+	}
+	iomap->offset = em->start + diff;
+	iomap->bdev = fs_info->fs_devices->latest_bdev;
+	iomap->length = em->len - diff;
+}
+
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 					       struct iov_iter *i)
 {
-- 
2.31.1

