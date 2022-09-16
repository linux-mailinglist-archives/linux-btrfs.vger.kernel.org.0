Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B9A5BA77B
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Sep 2022 09:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiIPH3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 16 Sep 2022 03:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPH3D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 16 Sep 2022 03:29:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FEA1E1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 00:29:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 55AE7338C9
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1663313341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AOH2fBaZ+6tzzb0xAdGM4HUL1rwytjd9yoUjP3sySZ8=;
        b=pJIhh+PsvFkftIqETFaRUBuEOinY8fV8b5yP3cGJoSdR55MLC3PhvBhgXR7julj3Tqx5k3
        WPD2V4cWxQifUTORKXSe4gLOFYUH4h4gMD6bOpQWMLgLutXeHfTeRyrTaj/wG+t/NEV68H
        KSBPXySnu/fSPugjC08msnTk0P7QBKw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97BBB1332E
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gPsSF7wlJGMMKQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Sep 2022 07:29:00 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/5] btrfs: do not reset extent map members for inline extents read
Date:   Fri, 16 Sep 2022 15:28:37 +0800
Message-Id: <1847be6faa5536214bd951da8b89d57a2d3eb88f.1663312787.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663312786.git.wqu@suse.com>
References: <cover.1663312786.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently for inline extents read inside btrfs_get_extent(), we will
reset several extent map members:

- em->start

  Reset to extent_start, which is completely unnecessary.
  The extent_start and em->start should have already be zero, ensured by
  tree-checker already.

- em->len

  Reset the round_up(copy_size, fs_info->sectorsize), which is again
  unnecessary.

- em->orig_block_len

  Reset to em->len (sectorsize), while it is originally unset from
  btrfs_extent_item_to_extent_map().

  This makes no difference, as all extent map handling paths will
  ignore the orig_block_len if they found it's an inlined extent.

  Such inline extent orig_block_len ignoring examples can be found in
  btrfs_drop_extent_cache().

- em->orig_start

  Reset to em->start (0), while it is originally set to EXTENT_MAP_HOLE.

  This makes no difference either, as all extent map handling paths will
  ignore the em->orig_start if they found it's an inline extent.

Thus all these em members resetting are unnecessary.

Replace them with ASSERT()s checking the only two members (block_start
and length) that make sense.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5df5b0714d40..41562d9d2113 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7001,10 +7001,15 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 		copy_size = min_t(u64, PAGE_SIZE,
 				  btrfs_file_extent_ram_bytes(leaf, item));
-		em->start = extent_start;
-		em->len = ALIGN(copy_size, fs_info->sectorsize);
-		em->orig_block_len = em->len;
-		em->orig_start = em->start;
+
+		/*
+		 * btrfs_extent_item_to_extent_map() should have properly
+		 * initialized em members already.
+		 *
+		 * Other members are not utilized for inline extents.
+		 */
+		ASSERT(em->block_start == EXTENT_MAP_INLINE);
+		ASSERT(em->len = fs_info->sectorsize);
 
 		if (!PageUptodate(page)) {
 			if (btrfs_file_extent_compression(leaf, item) !=
-- 
2.37.3

