Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218E43CCD91
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 07:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhGSFqI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 01:46:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45520 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGSFqH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 01:46:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BAA38201CC;
        Mon, 19 Jul 2021 05:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626673387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=VMRBP2UOZDXPKqlnqYjvfP9VWhXF3h5KyW49LYR9L0o=;
        b=MAhS1QwG75R3HEPe8BNneUgirJrjVcF1OTAZ/DRjdM6ZxRODXwJ5v9c2Ftc2LtCME6MCGn
        3rZFkYvhryPJ/F1CetLWblglYxwhX4zbhLYKERHQi331JRLMKaZJnuQvd9C5XvuCKImNDd
        h9zSu6JREw9W04gbMzvtMmN3JWAj18k=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BDB1F1332A;
        Mon, 19 Jul 2021 05:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id P9DfH+oQ9WA+YwAAGKfGzw
        (envelope-from <wqu@suse.com>); Mon, 19 Jul 2021 05:43:06 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH v4] btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group items
Date:   Mon, 19 Jul 2021 13:43:04 +0800
Message-Id: <20210719054304.181509-1-wqu@suse.com>
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
Changelog:
v2:
- Don't try to fill with dummy block groups when we hit ENOMEM
v3:
- Remove a dead condition
  The empty fs_info->extent_root case has already been handled.
v4:
- Skip to next block group if we hit EEXIST when inserting the block
  group cache
---
 fs/btrfs/block-group.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5bd76a45037e..758ba856f8c6 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2105,11 +2105,22 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		bg->used = em->len;
 		bg->flags = map->type;
 		ret = btrfs_add_block_group_cache(fs_info, bg);
+		/*
+		 * We may have some valid block group cache added already, in
+		 * that case we skip to next bg.
+		 */
+		if (ret == -EEXIST) {
+			ret = 0;
+			btrfs_put_block_group(bg);
+			continue;
+		}
+
 		if (ret) {
 			btrfs_remove_free_space_cache(bg);
 			btrfs_put_block_group(bg);
 			break;
 		}
+
 		btrfs_update_space_info(fs_info, bg->flags, em->len, em->len,
 					0, 0, &space_info);
 		bg->space_info = space_info;
@@ -2212,6 +2223,14 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 	ret = check_chunk_block_group_mappings(info);
 error:
 	btrfs_free_path(path);
+	/*
+	 * We hit some error reading the extent tree, and have rescue=ibadroots
+	 * mount option.
+	 * Try to fill using dummy block groups so that the user can continue
+	 * to mount and grab their data.
+	 */
+	if (ret && btrfs_test_opt(info, IGNOREBADROOTS))
+		ret = fill_dummy_bgs(info);
 	return ret;
 }
 
-- 
2.32.0

