Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859943F8C64
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbhHZQni (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 12:43:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:38066 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbhHZQni (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 12:43:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A8FD1FE58;
        Thu, 26 Aug 2021 16:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629996170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FTX6rOZiHdjmW9PHEniM14du06Yr497KPhWbg+ti1hM=;
        b=groNP+iRPKfNx3BqF5OXEO1sSz8s8R03tjzGSwbbWplxF4HGxwwXNc7rSqhSW+QiNzlxEP
        hd58ddOKLDTLCEEI+ycvbx7Whv3rBwsXlpjqrKpafXezPSITeyN0233i/MPOQsFhHbeZ16
        tDl5kBbQhbLk0ZP7eo0NfAzpyjQNa3I=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBCD113B20;
        Thu, 26 Aug 2021 16:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cOt2HojEJ2EVIQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 26 Aug 2021 16:42:48 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 2/8] btrfs: block-group: use btrfs_for_each_slot in find_first_block_group
Date:   Thu, 26 Aug 2021 13:40:48 -0300
Message-Id: <20210826164054.14993-3-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826164054.14993-1-mpdesouza@suse.com>
References: <20210826164054.14993-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function can be simplified by using the iterator like macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/block-group.c | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 1f8b06afbd03..0d999a3bfc84 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1654,38 +1654,15 @@ static int find_first_block_group(struct btrfs_fs_info *fs_info,
 				  struct btrfs_path *path,
 				  struct btrfs_key *key)
 {
-	struct btrfs_root *root = fs_info->extent_root;
-	int ret;
 	struct btrfs_key found_key;
-	struct extent_buffer *leaf;
-	int slot;
-
-	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	while (1) {
-		slot = path->slots[0];
-		leaf = path->nodes[0];
-		if (slot >= btrfs_header_nritems(leaf)) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret == 0)
-				continue;
-			if (ret < 0)
-				goto out;
-			break;
-		}
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
+	int ret;
 
+	btrfs_for_each_slot(fs_info->extent_root, key, &found_key, path, ret) {
 		if (found_key.objectid >= key->objectid &&
-		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			ret = read_bg_from_eb(fs_info, &found_key, path);
-			break;
-		}
-
-		path->slots[0]++;
+		    found_key.type == BTRFS_BLOCK_GROUP_ITEM_KEY)
+			return read_bg_from_eb(fs_info, &found_key, path);
 	}
-out:
+
 	return ret;
 }
 
-- 
2.31.1

