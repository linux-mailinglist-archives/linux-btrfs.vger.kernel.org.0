Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B2B3BA0D3
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 15:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhGBNEl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 09:04:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47286 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhGBNEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 09:04:41 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA0121E76;
        Fri,  2 Jul 2021 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625230928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=UVO/7CoBdvjM84nh+SBpq9bVu5gGtrn5WsPZ4T9LE04=;
        b=Scf1olJjTLDUdqyybA2GMdI9vPl6l/g35K1MjkeZG3hnBJCAMelH02UoSq06gPE8fJ+qXQ
        A40z4R4KkSRJ5RWNfbWG05f+RDy7MAz+Ly129kxctb+0lAYufxJz+Gk6pecuzz+g8/8910
        Rs0bDF0hYPCkiGwbjc8bIsC39jfV/Do=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 41D5D11C84;
        Fri,  2 Jul 2021 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625230928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc;
        bh=UVO/7CoBdvjM84nh+SBpq9bVu5gGtrn5WsPZ4T9LE04=;
        b=Scf1olJjTLDUdqyybA2GMdI9vPl6l/g35K1MjkeZG3hnBJCAMelH02UoSq06gPE8fJ+qXQ
        A40z4R4KkSRJ5RWNfbWG05f+RDy7MAz+Ly129kxctb+0lAYufxJz+Gk6pecuzz+g8/8910
        Rs0bDF0hYPCkiGwbjc8bIsC39jfV/Do=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id t8fuDFAO32CtNAAALh3uQQ
        (envelope-from <nborisov@suse.com>); Fri, 02 Jul 2021 13:02:08 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Minor improvements to should_alloc_chunk
Date:   Fri,  2 Jul 2021 16:02:06 +0300
Message-Id: <20210702130206.30909-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since it's a predicate function make it explicitly return boolean. Also
the  'thresh' variable is only used when force is CHUNK_ALLOC_LIMITED so
reduce the scope of the variable as necessary. Finally, remove the + 2m
used in the final check. Given the granularity of btrfs' allocation I
doubt that the + 2m made a difference when making a decision whether to
allocate a chunk or not.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/block-group.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3eecbc2b3dae..613527733fb2 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3312,30 +3312,29 @@ static void force_metadata_allocation(struct btrfs_fs_info *info)
 	}
 }
 
-static int should_alloc_chunk(struct btrfs_fs_info *fs_info,
+static bool should_alloc_chunk(struct btrfs_fs_info *fs_info,
 			      struct btrfs_space_info *sinfo, int force)
 {
 	u64 bytes_used = btrfs_space_info_used(sinfo, false);
-	u64 thresh;
 
 	if (force == CHUNK_ALLOC_FORCE)
-		return 1;
+		return true;
 
 	/*
 	 * in limited mode, we want to have some free space up to
 	 * about 1% of the FS size.
 	 */
 	if (force == CHUNK_ALLOC_LIMITED) {
-		thresh = btrfs_super_total_bytes(fs_info->super_copy);
+		u64 thresh = btrfs_super_total_bytes(fs_info->super_copy);
 		thresh = max_t(u64, SZ_64M, div_factor_fine(thresh, 1));
 
 		if (sinfo->total_bytes - bytes_used < thresh)
-			return 1;
+			return true;
 	}
 
-	if (bytes_used + SZ_2M < div_factor(sinfo->total_bytes, 8))
-		return 0;
-	return 1;
+	if (bytes_used < div_factor(sinfo->total_bytes, 8))
+		return false;
+	return true;
 }
 
 int btrfs_force_chunk_alloc(struct btrfs_trans_handle *trans, u64 type)
-- 
2.17.1

