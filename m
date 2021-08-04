Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EAD3E083D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Aug 2021 20:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239034AbhHDStr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Aug 2021 14:49:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34838 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239068AbhHDStl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Aug 2021 14:49:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 57A0A201D1;
        Wed,  4 Aug 2021 18:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628102967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Abyxe4wqaqT6xb4U3N9vyf/f5jccB1N5t7XiBoKWyZw=;
        b=CARdX0rvPAR6b6DhX5P1Vu//V0IDZctAzso3FQmbEE+IGqUnxaeQ+nrLFaE7Vwamx+9EnJ
        ewsIV72bGcoDJxxWjL9xf85bDW11uEebyj/WBpWBcMZw1NBDFC30ogfGwfH5cZdxIV5V9K
        F6SFs6SCwBBDUbYWQwV9VwBi6nBjOyg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D78D13D24;
        Wed,  4 Aug 2021 18:49:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qHwIMjXhCmGFOQAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Wed, 04 Aug 2021 18:49:25 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 3/7] btrfs: zoned: Use btrfs_find_item in calculate_emulated_zone_size
Date:   Wed,  4 Aug 2021 15:48:50 -0300
Message-Id: <20210804184854.10696-4-mpdesouza@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210804184854.10696-1-mpdesouza@suse.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

calculate_emulated_zone_size can be simplified by using btrfs_find_item, which
executes btrfs_search_slot and calls btrfs_next_leaf if needed.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/zoned.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 47af1ab3bf12..d344baa26de0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -230,29 +230,20 @@ static int calculate_emulated_zone_size(struct btrfs_fs_info *fs_info)
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
 	struct btrfs_dev_extent *dext;
-	int ret = 0;
-
-	key.objectid = 1;
-	key.type = BTRFS_DEV_EXTENT_KEY;
-	key.offset = 0;
+	int ret;
 
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret = btrfs_find_item(root, path, 1, BTRFS_DEV_EXTENT_KEY, 0, &key);
 	if (ret < 0)
 		goto out;
 
-	if (path->slots[0] >= btrfs_header_nritems(path->nodes[0])) {
-		ret = btrfs_next_leaf(root, path);
-		if (ret < 0)
-			goto out;
-		/* No dev extents at all? Not good */
-		if (ret > 0) {
-			ret = -EUCLEAN;
-			goto out;
-		}
+	/* No dev extents at all? Not good */
+	else if (ret > 0) {
+		ret = -EUCLEAN;
+		goto out;
 	}
 
 	leaf = path->nodes[0];
-- 
2.31.1

