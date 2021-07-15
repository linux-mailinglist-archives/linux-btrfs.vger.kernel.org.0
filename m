Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B990C3C95E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 04:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhGOCbp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 22:31:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38450 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhGOCbp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 22:31:45 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 40A461FDD1;
        Thu, 15 Jul 2021 02:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626316132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=qIktaj1ItGrv2blTUJsJigYC2MQ0MACgLxfrAOlHMCc=;
        b=MFStZ+mRuFjGdechcxtgTCiw9Y6vwy10/70HJIjPLJ7ZXXA/caVT8nx4Zf9dXOL5py8y+p
        A0hI8swUDJnxbuldtoolRbAfrrB89LT40bifI5xCTJjIEfCfJqLnX2pUU/U80A3Yqkch1Z
        H2+8KCkRmKP+1eCkJBVqLkMYU978GLE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E921F13AA3;
        Thu, 15 Jul 2021 02:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 5fr7KGKd72CgEwAAGKfGzw
        (envelope-from <wqu@suse.com>); Thu, 15 Jul 2021 02:28:50 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH v2] btrfs: rescue: allow ibadroots to skip bad extent tree when reading block group items
Date:   Thu, 15 Jul 2021 10:28:48 +0800
Message-Id: <20210715022848.139009-1-wqu@suse.com>
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
---
 fs/btrfs/block-group.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5bd76a45037e..240e6ec8bc31 100644
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
@@ -2212,6 +2217,13 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
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

