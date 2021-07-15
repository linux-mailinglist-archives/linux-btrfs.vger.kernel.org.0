Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4943C97F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 07:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhGOFDi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 01:03:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55930 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbhGOFDi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 01:03:38 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D35EE1FDDB;
        Thu, 15 Jul 2021 05:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626325240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=anBNRoYQFt3DcretCgK2o1I04NRrV44A6TS6MWin4F4=;
        b=F40scGcn1PV8MO0zoRvUmtaWBHQty8jPKiDGXjaN6NdDuRgcLoed+arBOt7Ql2HTtZkQ3R
        EOm6dTmcEL2OLaKfKEuQyZlnpBVqLWOMieA5sSf6p8Ss4n6keidU+Y6oCp4a8Hp5b3X4sy
        aMD/46//U4Kcn2bAOqUZMcxc7qtYE+o=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9201113AA4;
        Thu, 15 Jul 2021 05:00:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id qYd3FPfA72BBMgAAGKfGzw
        (envelope-from <wqu@suse.com>); Thu, 15 Jul 2021 05:00:39 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH v3] btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group items
Date:   Thu, 15 Jul 2021 13:00:36 +0800
Message-Id: <20210715050036.30369-1-wqu@suse.com>
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
---
 fs/btrfs/block-group.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5bd76a45037e..9bc68515bc4a 100644
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
@@ -2212,6 +2217,14 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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

