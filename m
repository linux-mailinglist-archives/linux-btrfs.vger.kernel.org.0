Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB846259D1
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Nov 2022 12:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiKKLut (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Nov 2022 06:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiKKLuq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Nov 2022 06:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D631E18E09
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 03:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A455B82510
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE035C433D7
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Nov 2022 11:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668167445;
        bh=JusReSWcvkOYUus53mHMuwpZsNYSGvgLdCmpQMlwLfc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=EG5fizeXVL51kARtgEtUwRuArdkjfhsHIiZtBEWdZJ73FMlYIGARat2dd4f7Ci0IF
         gga8cCdOfkaNinAOTv7zABeRr3hevvgeZZJQwKR/l1BytIc9PLaGbPvfLf+fn+nKkA
         ekArKS8q9n/WrfxuCyZ06iYUX1K1RJ8BHP+LwIhsl184J8k/YjHmUjMtkQb84+wYvV
         msqRhVuuRts5zDWuHvUtCsBYt7XrAwt8x5St8SFgsO+TPPeSLpQp6255eyk91EDp0r
         eaP2Ak3nJ/s9cwyENfGdK/5ovcPTqLlHCcBjVxZon3ERvqENEHL6N88U/mThKaIhHG
         qZMpH0JkHNL8Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/9] btrfs: update stale comment for count_range_bits()
Date:   Fri, 11 Nov 2022 11:50:33 +0000
Message-Id: <a2bd00da6fc9622f2be97cdb88fc260bb50d00d5.1668166764.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1668166764.git.fdmanana@suse.com>
References: <cover.1668166764.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The comment for count_range_bits() mentions that the search is fast if we
are asking for a range with the EXTENT_DIRTY bit set. However that is no
longer true since we don't use that bit and the optimization for that was
removed in:

  commit 71528e9e16c7 ("btrfs: get rid of extent_io_tree::dirty_bytes")

So remove that part of the comment mentioning the no longer existing
optimized case, and, while at it, add proper documentation describing the
purpose, arguments and return value of the function.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 6b0d78df7eee..21fa15123af8 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1515,9 +1515,29 @@ void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 start,
 }
 
 /*
- * Count the number of bytes in the tree that have a given bit(s) set.  This
- * can be fairly slow, except for EXTENT_DIRTY which is cached.  The total
- * number found is returned.
+ * Count the number of bytes in the tree that have a given bit(s) set for a
+ * given range.
+ *
+ * @tree:         The io tree to search.
+ * @start:        The start offset of the range. This value is updated to the
+ *                offset of the first byte found with the given bit(s), so it
+ *                can end up being bigger than the initial value.
+ * @search_end:   The end offset (inclusive value) of the search range.
+ * @max_bytes:    The maximum byte count we are interested. The search stops
+ *                once it reaches this count.
+ * @bits:         The bits the range must have in order to be accounted for.
+ *                If multiple bits are set, then only subranges that have all
+ *                the bits set are accounted for.
+ * @contig:       Indicate if we should ignore holes in the range or not. If
+ *                this is true, then stop once we find a hole.
+ * @cached_state: A cached state to be used across multiple calls to this
+ *                function in order to speedup searches. Use NULL if this is
+ *                called only once or if each call does not start where the
+ *                previous one ended.
+ *
+ * Returns the total number of bytes found within the given range that have
+ * all given bits set. If the returned number of bytes is greater than zero
+ * then @start is updated with the offset of the first byte with the bits set.
  */
 u64 count_range_bits(struct extent_io_tree *tree,
 		     u64 *start, u64 search_end, u64 max_bytes,
-- 
2.35.1

