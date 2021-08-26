Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084C13F8C65
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Aug 2021 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243126AbhHZQnp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Aug 2021 12:43:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44424 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243106AbhHZQnk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Aug 2021 12:43:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7E4A22208;
        Thu, 26 Aug 2021 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629996171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GftHQWxHc4ds/QciPzY+ZRPsVwPWIqYIbzR01JMbmYY=;
        b=dOMUY66zK5vM5FE0Wq8TV+PuxlREKyqiRmKxJqPXFBAHePmfsrf4Kh6KIzDCEm0cl8l0QH
        k9gr7ieCpzeeaDeGelTQUpe4ekhtrpah0ExHhRrVDyeTwri4UjClFgkaK+X8Yiy2Kvshvp
        QInKuphOFKD7l+4HI/5oT6Oyq9cOMI8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEF0B13B20;
        Thu, 26 Aug 2021 16:42:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sA8sGYrEJ2EVIQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 26 Aug 2021 16:42:50 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 3/8] btrfs: dev-replace: Use btrfs_for_each_slot in mark_block_group_to_copy
Date:   Thu, 26 Aug 2021 13:40:49 -0300
Message-Id: <20210826164054.14993-4-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826164054.14993-1-mpdesouza@suse.com>
References: <20210826164054.14993-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function can be simplified by using the macro.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/dev-replace.c | 51 +++++++++---------------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index d029be40ea6f..6124f2e8e9f1 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -523,63 +523,34 @@ static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = 0;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-	if (ret < 0)
-		goto free_path;
-	if (ret > 0) {
-		if (path->slots[0] >=
-		    btrfs_header_nritems(path->nodes[0])) {
-			ret = btrfs_next_leaf(root, path);
-			if (ret < 0)
-				goto free_path;
-			if (ret > 0) {
-				ret = 0;
-				goto free_path;
-			}
-		} else {
-			ret = 0;
-		}
-	}
-
-	while (1) {
+	btrfs_for_each_slot(root, &key, &found_key, path, ret) {
 		struct extent_buffer *leaf = path->nodes[0];
-		int slot = path->slots[0];
-
-		btrfs_item_key_to_cpu(leaf, &found_key, slot);
-
-		if (found_key.objectid != src_dev->devid)
-			break;
 
-		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
+		if (found_key.objectid != src_dev->devid ||
+		    found_key.type != BTRFS_DEV_EXTENT_KEY ||
+		    found_key.offset < key.offset)
 			break;
 
-		if (found_key.offset < key.offset)
-			break;
-
-		dev_extent = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+		dev_extent = btrfs_item_ptr(leaf, path->slots[0],
+				struct btrfs_dev_extent);
 
 		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dev_extent);
 
 		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
 		if (!cache)
-			goto skip;
+			continue;
 
 		spin_lock(&cache->lock);
 		cache->to_copy = 1;
 		spin_unlock(&cache->lock);
 
 		btrfs_put_block_group(cache);
-
-skip:
-		ret = btrfs_next_item(root, path);
-		if (ret != 0) {
-			if (ret > 0)
-				ret = 0;
-			break;
-		}
 	}
 
-free_path:
+	/* Reset error if the key wasn't found. */
+	if (ret > 0)
+		ret = 0;
+
 	btrfs_free_path(path);
 unlock:
 	mutex_unlock(&fs_info->chunk_mutex);
-- 
2.31.1

