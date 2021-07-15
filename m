Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDEC33C9591
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 03:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhGOB13 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 21:27:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58708 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhGOB13 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 21:27:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C145F1FDC4;
        Thu, 15 Jul 2021 01:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626312275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=MwoidasSAEwVw9+kJAMf/ozDatxLeZcNxWb1CADaA50=;
        b=PW8vN5qCmoaAeUwcOo7S4QsvenNDl7O3UFmJkiW9nXDiJ/H8hu8N9lrAXXGIz7TCLjzqHS
        G9zljzlKLlYo7rSU8+QJTU1+JpZKlgzVWt0kFOT5A6KQl1qDdR8AOlOHmhMf56nbI4WMen
        H/Dink2ETo7n/UPs/y56BlSE7fJBCNo=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 80A3E13AA0;
        Thu, 15 Jul 2021 01:24:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id eHSSEFKO72AeBgAAGKfGzw
        (envelope-from <wqu@suse.com>); Thu, 15 Jul 2021 01:24:34 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH] btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group items
Date:   Thu, 15 Jul 2021 09:24:30 +0800
Message-Id: <20210715012430.111567-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When extent tree gets corrupted, normally it's not extent tree root, but
one toasted tree leaf/node.

In that case, rescue=ibadroots mount option won't help as it can only
handle the extent tree root corruption.

This patch will enhance the behavior by:

- Allow fill_dummy_bgs() to ignore -EEXIST error

  This means we may have some block group items read from disk, but
  then hit some error halfway.

- Fallback to fill_dummy_bgs() if any error gets hit in
  btrfs_read_block_groups()

  Of course, this still needs rescue=ibadroots mount option.

With that, rescue=ibadroots can handle extent tree corruption more
gracefully and allow a better recover chance.

Reported-by: Zhenyu Wu <wuzy001@gmail.com>
Link: https://www.spinics.net/lists/linux-btrfs/msg114424.html
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5bd76a45037e..33086b882fe8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2105,11 +2105,16 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		bg->used = em->len;
 		bg->flags = map->type;
 		ret = btrfs_add_block_group_cache(fs_info, bg);
-		if (ret) {
+		/*
+		 * We may have some block groups filled already, thus ignore
+		 * the -EEXIST error.
+		 */
+		if (ret && ret != -EEXIST) {
 			btrfs_remove_free_space_cache(bg);
 			btrfs_put_block_group(bg);
 			break;
 		}
+		ret = 0;
 		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
 					0, 0, &space_info);
 		bg->space_info = space_info;
@@ -2139,8 +2144,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	key.offset = 0;
 	key.type = BTRFS_BLOCK_GROUP_ITEM_KEY;
 	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
+	if (!path) {
+		ret = -ENOMEM;
+		goto error;
+	}
 
 	cache_gen = btrfs_super_cache_generation(info->super_copy);
 	if (btrfs_test_opt(info, SPACE_CACHE) &&
@@ -2212,6 +2219,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
+	/*
+	 * Either we have no extent_root (already implies IGNOREBADROOTS), or
+	 * we hit error and have IGNOREBADROOTS, then we can try to use dummy
+	 * bgs.
+	 */
+	if (!info->extent_root || (ret && btrfs_test_opt(info, IGNOREBADROOTS)))
+		ret = fill_dummy_bgs(info);
 	return ret;
 }
 
-- 
2.32.0

