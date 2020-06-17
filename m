Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71DBE1FD223
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgFQQ1y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 12:27:54 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:51167 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726931AbgFQQ1y (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 12:27:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 260DA5800D3;
        Wed, 17 Jun 2020 12:27:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 17 Jun 2020 12:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=M17MIDnAFlsLEa3IzG4rx4o/T0
        vnNtyT7dQsd2r58YY=; b=TD2isv/MlPxNLng35btIN1XX0cz2YSS2PPYC+EtkVN
        Y3me3ycuwQ5r7Qg9XKQlXuKfSnv++0/RNVeZ5+oBf3MUkmPp0hPoJ2TMZxt0f+NF
        3WQ0sIlwLIMUt/rCd12wtEu4uLet99C+Eq3VBT5dokyRdCrQqCtyaaD2KYipfjKM
        a9NmDtp+7dvhb2xbP2Jft+7KsTv14ciRGOI311OIG07VHzxZ3kUrezN6HDFRNod+
        8VwwTiF+Su30B0ORaPCsoLv/QTU1vCYdRrwS5oTQ5acpT03kRtwZHTWGQFrS06qA
        wYChN5+3g4Clf5cAH5Y2VXQKBZ8V6Oe8/HKsmbgWmvVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=M17MIDnAFlsLEa3Iz
        G4rx4o/T0vnNtyT7dQsd2r58YY=; b=HPPstBxkZFeI7QT7S7eSp4N7e39Eg9d7N
        0nI+wrwTSpAtY51JVpy9WDlCWbubtLm6VP3R92PAq9iXHuu7XeWDtc9MHAQuFKfy
        st40FSMaPQdftJopNbvYS3QCUhiRWIiSnMIHzrJ4zP5qCBWxFSmFCDypvVxDwY7A
        Pnh0twXb5DHNbmcS3fL7Bpo4xj7+O5M/KZrLSule5Bnyb3+jmjSWSutIkf3OvwzJ
        Ya+VCMZM2rji20+pnRv+0FlhOl/qR2aFOkYyXAqekf4myJVpudZue+qTJw2V5O7H
        xiThXaVr6nr1TqzwgzzSRvT0zKZ+biJjyuCONk4wlYKFBNjjj7Y1A==
X-ME-Sender: <xms:h0TqXtoOxmzA2-HpfjvdF98v3KeV4lKbyKdRt2-jtZYBTs6FKjvE1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepuehorhhishcu
    uehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpeduie
    dtleeuieejfeelffevleeifefgjeejieegkeduudetfeekffeftefhvdejveenucfkphep
    udeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:h0TqXvpKmkZqmuU91Si500HviJEwJkElX9Z-2SOPRqdPo62e65PMLg>
    <xmx:h0TqXqPg5pAmady-9XjYpi0stnWzYYkxWhMcTAlI9JsletMKcLmjag>
    <xmx:h0TqXo6DR9UB5Ns8CJMBzM7Web7qckyGR6LtiRpHCfodckGHeIbgtA>
    <xmx:h0TqXqkFiO0mjLIKzYZ7XpJkfjBjsusSqpNG02Zg_AkAB2gN-e9RtWrR9nQ>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id CBA2F3280059;
        Wed, 17 Jun 2020 12:27:50 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Boris Burkov <boris@bur.io>
Subject: [PATCH btrfs/for-next] btrfs: fix fatal extent_buffer readahead vs releasepage race
Date:   Wed, 17 Jun 2020 09:27:46 -0700
Message-Id: <20200617162746.3780660-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Under somewhat convoluted conditions, it is possible to attempt to
release an extent_buffer that is under io, which triggers a BUG_ON in
btrfs_release_extent_buffer_pages.

This relies on a few different factors. First, extent_buffer reads done
as readahead for searching use WAIT_NONE, so they free the local extent
buffer reference while the io is outstanding. However, they should still
be protected by TREE_REF. However, if the system is doing signficant
reclaim, and simultaneously heavily accessing the extent_buffers, it is
possible for releasepage to race with two concurrent readahead attempts
in a way that leaves TREE_REF unset when the readahead extent buffer is
released.

Essentially, if two tasks race to allocate a new extent_buffer, but the
winner who attempts the first io is rebuffed by a page being locked
(likely by the reclaim itself) then the loser will still go ahead with
issuing the readahead. The loser's call to find_extent_buffer must also
race with the reclaim task reading the extent_buffer's refcount as 1 in
a way that allows the reclaim to re-clear the TREE_REF checked by
find_extent_buffer.

The following represents an example execution demonstrating the race:

            CPU0                                                         CPU1                                           CPU2
reada_for_search                                            reada_for_search
  readahead_tree_block                                        readahead_tree_block
    find_create_tree_block                                      find_create_tree_block
      alloc_extent_buffer                                         alloc_extent_buffer
                                                                  find_extent_buffer // not found
                                                                  allocates eb
                                                                  lock pages
                                                                  associate pages to eb
                                                                  insert eb into radix tree
                                                                  set TREE_REF, refs == 2
                                                                  unlock pages
                                                              read_extent_buffer_pages // WAIT_NONE
                                                                not uptodate (brand new eb)
                                                                                                            lock_page
                                                                if !trylock_page
                                                                  goto unlock_exit // not an error
                                                              free_extent_buffer
                                                                release_extent_buffer
                                                                  atomic_dec_and_test refs to 1
        find_extent_buffer // found
                                                                                                            try_release_extent_buffer
                                                                                                              take refs_lock
                                                                                                              reads refs == 1; no io
          atomic_inc_not_zero refs to 2
          mark_buffer_accessed
            check_buffer_tree_ref
              // not STALE, won't take refs_lock
              refs == 2; TREE_REF set // no action
    read_extent_buffer_pages // WAIT_NONE
                                                                                                              clear TREE_REF
                                                                                                              release_extent_buffer
                                                                                                                atomic_dec_and_test refs to 1
                                                                                                                unlock_page
      still not uptodate (CPU1 read failed on trylock_page)
      locks pages
      set io_pages > 0
      submit io
      return
    release_extent_buffer
      dec refs to 0
      delete from radix tree
      btrfs_release_extent_buffer_pages
        BUG_ON(io_pages > 0)!!!

We observe this at a very low rate in production and were also able to
reproduce it in a test environment by introducing some spurious delays
and by introducing probabilistic trylock_page failures.

To fix it, we apply check_tree_ref at a point where it could not
possibly be unset by a competing task: after io_pages has been
incremented. There is no race in write_one_eb, that we know of, but for
consistency, apply it there too. All the codepaths that clear TREE_REF
check for io, so they would not be able to clear it after this point.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 45 ++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c59e07360083..f6758ebbb6a2 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3927,6 +3927,11 @@ static noinline_for_stack int write_one_eb(struct extent_buffer *eb,
 	clear_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags);
 	num_pages = num_extent_pages(eb);
 	atomic_set(&eb->io_pages, num_pages);
+	/*
+	 * It is possible for releasepage to clear the TREE_REF bit before we
+	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
+	 */
+	check_buffer_tree_ref(eb);
 
 	/* set btree blocks beyond nritems with 0 to avoid stale content. */
 	nritems = btrfs_header_nritems(eb);
@@ -5086,25 +5091,28 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 static void check_buffer_tree_ref(struct extent_buffer *eb)
 {
 	int refs;
-	/* the ref bit is tricky.  We have to make sure it is set
-	 * if we have the buffer dirty.   Otherwise the
-	 * code to free a buffer can end up dropping a dirty
-	 * page
+	/*
+	 * The TREE_REF bit is first set when the extent_buffer is added
+	 * to the radix tree. It is also reset, if unset, when a new reference
+	 * is created by find_extent_buffer.
 	 *
-	 * Once the ref bit is set, it won't go away while the
-	 * buffer is dirty or in writeback, and it also won't
-	 * go away while we have the reference count on the
-	 * eb bumped.
+	 * It is only cleared in two cases: freeing the last non-tree
+	 * reference to the extent_buffer when its STALE bit is set or
+	 * calling releasepage when the tree reference is the only reference.
 	 *
-	 * We can't just set the ref bit without bumping the
-	 * ref on the eb because free_extent_buffer might
-	 * see the ref bit and try to clear it.  If this happens
-	 * free_extent_buffer might end up dropping our original
-	 * ref by mistake and freeing the page before we are able
-	 * to add one more ref.
+	 * In both cases, care is taken to ensure that the extent_buffer's
+	 * pages are not under io. However, releasepage can be concurrently
+	 * called with creating new references, which is prone to race
+	 * conditions between the calls to check_tree_ref in those codepaths
+	 * and clearing TREE_REF in try_release_extent_buffer.
 	 *
-	 * So bump the ref count first, then set the bit.  If someone
-	 * beat us to it, drop the ref we added.
+	 * The actual lifetime of the extent_buffer in the radix tree is
+	 * adequately protected by the refcount, but the TREE_REF bit and
+	 * its corresponding reference are not. To protect against this
+	 * class of races, we call check_buffer_tree_ref from the codepaths
+	 * which trigger io after they set eb->io_pages. Note that once io is
+	 * initiated, TREE_REF can no longer be cleared, so that is the
+	 * moment at which any such race is best fixed.
 	 */
 	refs = atomic_read(&eb->refs);
 	if (refs >= 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
@@ -5555,6 +5563,11 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
 	clear_bit(EXTENT_BUFFER_READ_ERR, &eb->bflags);
 	eb->read_mirror = 0;
 	atomic_set(&eb->io_pages, num_reads);
+	/*
+	 * It is possible for releasepage to clear the TREE_REF bit before we
+	 * set io_pages. See check_buffer_tree_ref for a more detailed comment.
+	 */
+	check_buffer_tree_ref(eb);
 	for (i = 0; i < num_pages; i++) {
 		page = eb->pages[i];
 
-- 
2.24.1

