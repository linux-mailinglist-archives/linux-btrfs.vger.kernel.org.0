Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEFA1C9C22
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgEGUUo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:56340 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgEGUUo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04E5AAE0A;
        Thu,  7 May 2020 20:20:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A7EA1DA732; Thu,  7 May 2020 22:19:53 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 11/19] btrfs: speed up and simplify generic_bin_search
Date:   Thu,  7 May 2020 22:19:53 +0200
Message-Id: <32ed422c5c1fa2830c58a472222d3d09c49b7f60.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bin search jumps over the extent buffer item keys, comparing
directly the bytes if the key is in one page, or storing it in a
temporary buffer in case it spans two pages.

The mapping start and length are obtained from map_private_extent_buffer,
which is heavy weight compared to what we need. We know the key size and
can find out the eb page in a simple way.  For keys spanning two pages
the fallback read_extent_buffer is used.

The temporary variables are reduced and moved to the scope of use.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 6dbeb23c59ec..746dec22f250 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1668,15 +1668,8 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 {
 	int low = 0;
 	int high = max;
-	int mid;
 	int ret;
-	struct btrfs_disk_key *tmp = NULL;
-	struct btrfs_disk_key unaligned;
-	unsigned long offset;
-	char *kaddr = NULL;
-	unsigned long map_start = 0;
-	unsigned long map_len = 0;
-	int err;
+	const int key_size = sizeof(struct btrfs_disk_key);
 
 	if (low > high) {
 		btrfs_err(eb->fs_info,
@@ -1687,32 +1680,26 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 	}
 
 	while (low < high) {
+		unsigned long oip;
+		unsigned long offset;
+		struct btrfs_disk_key *tmp;
+		struct btrfs_disk_key unaligned;
+		int mid;
+
 		mid = (low + high) / 2;
 		offset = p + mid * item_size;
+		oip = offset_in_page(offset);
 
-		if (!kaddr || offset < map_start ||
-		    (offset + sizeof(struct btrfs_disk_key)) >
-		    map_start + map_len) {
-
-			err = map_private_extent_buffer(eb, offset,
-						sizeof(struct btrfs_disk_key),
-						&kaddr, &map_start, &map_len);
-
-			if (!err) {
-				tmp = (struct btrfs_disk_key *)(kaddr + offset -
-							map_start);
-			} else if (err == 1) {
-				read_extent_buffer(eb, &unaligned,
-						   offset, sizeof(unaligned));
-				tmp = &unaligned;
-			} else {
-				return err;
-			}
+		if (oip + key_size <= PAGE_SIZE) {
+			const unsigned long idx = offset >> PAGE_SHIFT;
+			char *kaddr = page_address(eb->pages[idx]);
 
+			tmp = (struct btrfs_disk_key *)(kaddr + oip);
 		} else {
-			tmp = (struct btrfs_disk_key *)(kaddr + offset -
-							map_start);
+			read_extent_buffer(eb, &unaligned, offset, key_size);
+			tmp = &unaligned;
 		}
+
 		ret = comp_keys(tmp, key);
 
 		if (ret < 0)
-- 
2.25.0

