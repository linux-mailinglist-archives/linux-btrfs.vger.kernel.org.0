Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57B01FD4A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgFQSf0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jun 2020 14:35:26 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:57719 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726926AbgFQSfZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jun 2020 14:35:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0EF875802B9;
        Wed, 17 Jun 2020 14:35:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 Jun 2020 14:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=from
        :to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=c9ejsyKsfrN6f
        QpfAmb05Wa/yYbJ/4EDU4nZTRn2rVA=; b=eU8yC61npkXTvTjAQ6f1UWd/KXhbU
        fEe5uisrNbtEzVB0xztxYkXMBeOWHfrKgFHwn9tJx4s4BRWKLFhBP4L+uOQzSuZz
        L/2Id5BVpXn3+veuqSwVQ98eoRkWGLXjJV9JRfVRhqWjXWMP9xAM6n8EceVaTNxH
        VgOswRYWTw/c0C8ZzJGj2DtNMxx/p8JCP3dHt36V6/b2j6D2Mu6YqZmZw18IOyxS
        R/2JmaDd/zYb4A4alcG6z0Qx4Whrtisv3yl2ILvMmvnEwE26ayR/m/0neOKaPkPF
        jC2Q7VJmg6NVGzV9264acFFwPsiroRagZEhrPccBe4HjVb2um4vHxKwbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=c9ejsyKsfrN6fQpfAmb05Wa/yYbJ/4EDU4nZTRn2rVA=; b=p1K2GG0m
        j7FXyWaFzQ/GBqOXRmLlVoHcKWynvXfPkPPHJWoGZw166iMz77yp/qV4zgM61h5X
        jl+2esESVWs4YQxPXCBd+2E8sfZ1fWj3RIL25pX8nG2p0sahcsbG4rMKl0xeLUK5
        2bcnJSdOwMpP+GlptDgrTvs8TAeoWmK0rMdYRlkEpj5Cd5d6XyvKrkR+lqSBAsYn
        SM2HS4gSr3qt8c4LnJjBP26N/ZQ3PXv/QVrVxnyRSZGy6cTPZ4CZ0CUgQFhsStUE
        8zwj+9Im0fTvInm4q2rX0zkGMh2mHjfjAUgWhtPptQossTukLb0Z4XQa9iOpHPjR
        CQUpBkAMDgZAsw==
X-ME-Sender: <xms:a2LqXqYqUH4LJ_YMc5dfcLK7J5thoGZK71JKOc6KNH5dNisZwOOPHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejvddguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    eiueffuedvieeujefhheeigfekvedujeejjeffvedvhedtudefiefhkeegueehleenucfk
    phepudeifedruddugedrudefvddrfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:a2LqXtZocVvdiRfGCrpUgPwdm64T4Oo7rRymG0vHdsYEkqoBui4SRQ>
    <xmx:a2LqXk8_IgRX62TdIKfv7_ADHuO5YtSUUIavj9k6BeV1fLyO7eQRQw>
    <xmx:a2LqXspaLasyA5YI27E-kgMJlN-qgSsBk2sYRWuLopFVxx316x4csw>
    <xmx:a2LqXs3mFjRevPdUdKtWuY13k7KtZSRKme1mISqQyfuB3QgJW37f2vF6HoM>
Received: from localhost (unknown [163.114.132.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA9E130618C1;
        Wed, 17 Jun 2020 14:35:21 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2 btrfs/for-next] btrfs: fix fatal extent_buffer readahead vs releasepage race
Date:   Wed, 17 Jun 2020 11:35:19 -0700
Message-Id: <20200617183519.152946-1-boris@bur.io>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <CAL3q7H4GqjcesWir69PULr4a9rSi2cVQ366y5bAEU23wS6xJkA@mail.gmail.com>
References: <CAL3q7H4GqjcesWir69PULr4a9rSi2cVQ366y5bAEU23wS6xJkA@mail.gmail.com>
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
    free_extent_buffer
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
incremented. All the codepaths that clear TREE_REF check for io, so they
would not be able to clear it after this point until the io is done.

stack trace, for reference:
[1417839.424739] ------------[ cut here ]------------
[1417839.435328] kernel BUG at fs/btrfs/extent_io.c:4841!
[1417839.447024] invalid opcode: 0000 [#1] SMP
[1417839.502972] RIP: 0010:btrfs_release_extent_buffer_pages+0x20/0x1f0
[1417839.517008] Code: ed e9 ...
[1417839.558895] RSP: 0018:ffffc90020bcf798 EFLAGS: 00010202
[1417839.570816] RAX: 0000000000000002 RBX: ffff888102d6def0 RCX:
0000000000000028
[1417839.586962] RDX: 0000000000000002 RSI: ffff8887f0296482 RDI:
ffff888102d6def0
[1417839.603108] RBP: ffff88885664a000 R08: 0000000000000046 R09:
0000000000000238
[1417839.619255] R10: 0000000000000028 R11: ffff88885664af68 R12:
0000000000000000
[1417839.635402] R13: 0000000000000000 R14: ffff88875f573ad0 R15:
ffff888797aafd90
[1417839.651549] FS:  00007f5a844fa700(0000) GS:ffff88885f680000(0000)
knlGS:0000000000000000
[1417839.669810] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[1417839.682887] CR2: 00007f7884541fe0 CR3: 000000049f609002 CR4:
00000000003606e0
[1417839.699037] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[1417839.715187] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[1417839.731320] Call Trace:
[1417839.737103]  release_extent_buffer+0x39/0x90
[1417839.746913]  read_block_for_search.isra.38+0x2a3/0x370
[1417839.758645]  btrfs_search_slot+0x260/0x9b0
[1417839.768054]  btrfs_lookup_file_extent+0x4a/0x70
[1417839.778427]  btrfs_get_extent+0x15f/0x830
[1417839.787665]  ? submit_extent_page+0xc4/0x1c0
[1417839.797474]  ? __do_readpage+0x299/0x7a0
[1417839.806515]  __do_readpage+0x33b/0x7a0
[1417839.815171]  ? btrfs_releasepage+0x70/0x70
[1417839.824597]  extent_readpages+0x28f/0x400
[1417839.833836]  read_pages+0x6a/0x1c0
[1417839.841729]  ? startup_64+0x2/0x30
[1417839.849624]  __do_page_cache_readahead+0x13c/0x1a0
[1417839.860590]  filemap_fault+0x6c7/0x990
[1417839.869252]  ? xas_load+0x8/0x80
[1417839.876756]  ? xas_find+0x150/0x190
[1417839.884839]  ? filemap_map_pages+0x295/0x3b0
[1417839.894652]  __do_fault+0x32/0x110
[1417839.902540]  __handle_mm_fault+0xacd/0x1000
[1417839.912156]  handle_mm_fault+0xaa/0x1c0
[1417839.921004]  __do_page_fault+0x242/0x4b0
[1417839.930044]  ? page_fault+0x8/0x30
[1417839.937933]  page_fault+0x1e/0x30
[1417839.945631] RIP: 0033:0x33c4bae
[1417839.952927] Code: Bad RIP value.
[1417839.960411] RSP: 002b:00007f5a844f7350 EFLAGS: 00010206
[1417839.972331] RAX: 000000000000006e RBX: 1614b3ff6a50398a RCX:
0000000000000000
[1417839.988477] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
0000000000000002
[1417840.004626] RBP: 00007f5a844f7420 R08: 000000000000006e R09:
00007f5a94aeccb8
[1417840.020784] R10: 00007f5a844f7350 R11: 0000000000000000 R12:
00007f5a94aecc79
[1417840.036932] R13: 00007f5a94aecc78 R14: 00007f5a94aecc90 R15:
00007f5a94aecc40

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/extent_io.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c59e07360083..95313bb7fe40 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5086,25 +5086,28 @@ struct extent_buffer *alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
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
+	 * conditions between the calls to check_buffer_tree_ref in those
+	 * codepaths and clearing TREE_REF in try_release_extent_buffer.
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
@@ -5555,6 +5558,11 @@ int read_extent_buffer_pages(struct extent_buffer *eb, int wait, int mirror_num)
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

