Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E79269DD9
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 07:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgIOFfr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 01:35:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42970 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgIOFfr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 01:35:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B51BDAEA2
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 05:36:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/19] btrfs: remove the open-code to read disk-key
Date:   Tue, 15 Sep 2020 13:35:17 +0800
Message-Id: <20200915053532.63279-5-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915053532.63279-1-wqu@suse.com>
References: <20200915053532.63279-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

generic_bin_search() distinguishes between reading a key which doesn't
cross a page and one which does. However this distinction is not
necessary since read_extent_buffer handles both cases transparently.

Just use read_extent_buffer to streamline the code.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ctree.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index cd1cd673bc0b..e204e1320745 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -1697,7 +1697,6 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 	}
 
 	while (low < high) {
-		unsigned long oip;
 		unsigned long offset;
 		struct btrfs_disk_key *tmp;
 		struct btrfs_disk_key unaligned;
@@ -1705,17 +1704,9 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 
 		mid = (low + high) / 2;
 		offset = p + mid * item_size;
-		oip = offset_in_page(offset);
 
-		if (oip + key_size <= PAGE_SIZE) {
-			const unsigned long idx = offset >> PAGE_SHIFT;
-			char *kaddr = page_address(eb->pages[idx]);
-
-			tmp = (struct btrfs_disk_key *)(kaddr + oip);
-		} else {
-			read_extent_buffer(eb, &unaligned, offset, key_size);
-			tmp = &unaligned;
-		}
+		read_extent_buffer(eb, &unaligned, offset, key_size);
+		tmp = &unaligned;
 
 		ret = comp_keys(tmp, key);
 
-- 
2.28.0

