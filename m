Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF6D783981
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Aug 2023 07:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjHVFu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Aug 2023 01:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbjHVFu6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Aug 2023 01:50:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE6D7
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Aug 2023 22:50:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 78A5522C44
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692683455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=SLrYbNAul9y/yFD2HpJeKL3IUGvWukmW4FTpxibhVlo=;
        b=l6U8kJ8TzdevGo5AAmgbqa/FLD2xTtQW3C1VXzIdAGPyyn5pY0MMKaT6gCcqCz2Rmn6z20
        16XFk5R1vTHlZnf6SQM2IFojKvPZcspTOVQW3bcFN7DWbZsG/61uNu621tLXHzfh1iSNsb
        UDcwRGKl7kJUfLM/Ei2lSoyfI7yJuF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF92D13251
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 05:50:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gc9IJr5M5GQdNAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Aug 2023 05:50:54 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix a compiling error if DEBUG is defined
Date:   Tue, 22 Aug 2023 13:50:51 +0800
Message-ID: <14ea9aa0a4d5ac8f2c817978e9fff6ded8777ef9.1692683147.git.wqu@suse.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
After commit 72a69cd03082 ("btrfs: subpage: pack all subpage bitmaps
into a larger bitmap"), the DEBUG section of btree_dirty_folio() would
no longer compile.

[CAUSE]
If DEBUG is defined, we would do extra checks for btree_dirty_folio(),
mostly to make sure the range we marked dirty has an extent buffer and
that extent buffer is dirty.

For subpage, we need to iterate through all the extent buffers covered
by that page range, and make sure they all matches the criteria.

However commit 72a69cd03082 ("btrfs: subpage: pack all subpage bitmaps
into a larger bitmap") changes how we store the bitmap, we pack all the
16 bits bitmaps into a larger bitmap, which would save some space.

This means we no longer have btrfs_subpage::dirty_bitmap, instead the
dirty bitmap is starting at btrfs_subpage_info::dirty_offset, and has a
length of btrfs_subpage_info::bitmap_nr_bits.

[FIX]
Although I'm not sure if it still makes sense to maintain such code, at
least let it compile.

This patch would let us test the bits one by one through the bitmaps.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0a96ea8c1d3a..6599c5a206e9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -520,6 +520,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		struct folio *folio)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(mapping->host->i_sb);
+	struct btrfs_subpage_info *spi = fs_info->subpage_info;
 	struct btrfs_subpage *subpage;
 	struct extent_buffer *eb;
 	int cur_bit = 0;
@@ -533,18 +534,18 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		btrfs_assert_tree_write_locked(eb);
 		return filemap_dirty_folio(mapping, folio);
 	}
+
+	ASSERT(spi);
 	subpage = folio_get_private(folio);
 
-	ASSERT(subpage->dirty_bitmap);
-	while (cur_bit < BTRFS_SUBPAGE_BITMAP_SIZE) {
+	for (cur_bit = spi->dirty_offset;
+	     cur_bit < spi->dirty_offset + spi->bitmap_nr_bits; cur_bit++) {
 		unsigned long flags;
 		u64 cur;
-		u16 tmp = (1 << cur_bit);
 
 		spin_lock_irqsave(&subpage->lock, flags);
-		if (!(tmp & subpage->dirty_bitmap)) {
+		if (!test_bit(cur_bit, subpage->bitmaps)) {
 			spin_unlock_irqrestore(&subpage->lock, flags);
-			cur_bit++;
 			continue;
 		}
 		spin_unlock_irqrestore(&subpage->lock, flags);
@@ -557,7 +558,7 @@ static bool btree_dirty_folio(struct address_space *mapping,
 		btrfs_assert_tree_write_locked(eb);
 		free_extent_buffer(eb);
 
-		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits);
+		cur_bit += (fs_info->nodesize >> fs_info->sectorsize_bits) - 1;
 	}
 	return filemap_dirty_folio(mapping, folio);
 }
-- 
2.41.0

