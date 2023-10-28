Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CDF7DA44A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Oct 2023 02:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbjJ1AOZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Oct 2023 20:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjJ1AOZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Oct 2023 20:14:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68173B0
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Oct 2023 17:14:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 18C8D1F8B2
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 00:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1698452060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=LwW2ORwD9U3H72h+NjMA4Rr6Q6E7aN9W4THd9aeUric=;
        b=oKPrpdXnTlXVMBDgDJozLCBmGmwVOCxr/tUuqlAvbQj6M7kXglW4I16QRtNq4rteLQmKP3
        buTvUwf5fklC1LUdJcAIcxChWinJblYqtNnNeri29tpWOI5FNMvQXRxQMJnQmW7YyxQpC2
        U7LvX7qLKP74VCkeK26qYJ8c/Vs9ktY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE66A1351D
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 00:14:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VQR1GlpSPGVQZQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Oct 2023 00:14:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: remove unused functions
Date:   Sat, 28 Oct 2023 10:43:59 +1030
Message-ID: <d4d0bb2c6fb0ad0a3666e9e0a78e432634f58a0d.1698452036.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When compiling with clang 16.0.6, there are the following unused
functions get reported.

- memmove_leaf_data()
- copy_leaf_data()
- memmove_leaf_items()
- copy_leaf_items()
  Those are replaced by memmove/memcopy_extent_buffer().
  Thus they can be removed safely.

- btrfs_inode_combine_flags()
  This is only utilized by kernel for vfs inode structure, meanwhile
  it's totally unused in progs as we don't have inode structure at all.
  Thus it can be removed safely.

- LOADU64() from blake2b-avx2.c
  This is only utilized by the fallback implementation of
  DECLARE_MESSAGE_WORD().
  We can move it it just before the fallback implementation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 crypto/blake2b-avx2.c        | 13 +++---
 kernel-shared/ctree.c        | 85 ------------------------------------
 kernel-shared/tree-checker.c | 12 -----
 3 files changed, 7 insertions(+), 103 deletions(-)

diff --git a/crypto/blake2b-avx2.c b/crypto/blake2b-avx2.c
index 6c35427a5173..9fb1e146f2b9 100644
--- a/crypto/blake2b-avx2.c
+++ b/crypto/blake2b-avx2.c
@@ -41,12 +41,6 @@
 #define LOADU(p)  _mm256_loadu_si256( (__m256i *)(p) )
 #define STOREU(p,r) _mm256_storeu_si256((__m256i *)(p), r)
 
-static BLAKE2_INLINE uint64_t LOADU64(void const * p) {
-  uint64_t v;
-  memcpy(&v, p, sizeof v);
-  return v;
-}
-
 #define ROTATE16 _mm256_setr_epi8( 2, 3, 4, 5, 6, 7, 0, 1, 10, 11, 12, 13, 14, 15, 8, 9, \
                                    2, 3, 4, 5, 6, 7, 0, 1, 10, 11, 12, 13, 14, 15, 8, 9 )
 
@@ -186,6 +180,13 @@ ALIGN(64) static const uint32_t indices[12][16] = {
   const __m256i m7 = _mm256_broadcastsi128_si256(LOADU128((m) + 112)); \
   __m256i t0, t1;
 #else
+
+static BLAKE2_INLINE uint64_t LOADU64(void const * p) {
+  uint64_t v;
+  memcpy(&v, p, sizeof v);
+  return v;
+}
+
 #define DECLARE_MESSAGE_WORDS(m)           \
   const uint64_t  m0 = LOADU64((m) +   0); \
   const uint64_t  m1 = LOADU64((m) +   8); \
diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
index 6bf9233b7358..4ee70facf894 100644
--- a/kernel-shared/ctree.c
+++ b/kernel-shared/ctree.c
@@ -66,91 +66,6 @@ static unsigned int leaf_data_end(const struct extent_buffer *leaf)
 	return btrfs_item_offset(leaf, nr - 1);
 }
 
-/*
- * Move data in a @leaf (using memmove, safe for overlapping ranges).
- *
- * @leaf:	leaf that we're doing a memmove on
- * @dst_offset:	item data offset we're moving to
- * @src_offset:	item data offset were' moving from
- * @len:	length of the data we're moving
- *
- * Wrapper around memmove_extent_buffer() that takes into account the header on
- * the leaf.  The btrfs_item offset's start directly after the header, so we
- * have to adjust any offsets to account for the header in the leaf.  This
- * handles that math to simplify the callers.
- */
-static inline void memmove_leaf_data(const struct extent_buffer *leaf,
-				     unsigned long dst_offset,
-				     unsigned long src_offset,
-				     unsigned long len)
-{
-	memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, 0) + dst_offset,
-			      btrfs_item_nr_offset(leaf, 0) + src_offset, len);
-}
-
-/*
- * Copy item data from @src into @dst at the given @offset.
- *
- * @dst:	destination leaf that we're copying into
- * @src:	source leaf that we're copying from
- * @dst_offset:	item data offset we're copying to
- * @src_offset:	item data offset were' copying from
- * @len:	length of the data we're copying
- *
- * Wrapper around copy_extent_buffer() that takes into account the header on
- * the leaf.  The btrfs_item offset's start directly after the header, so we
- * have to adjust any offsets to account for the header in the leaf.  This
- * handles that math to simplify the callers.
- */
-static inline void copy_leaf_data(const struct extent_buffer *dst,
-				  const struct extent_buffer *src,
-				  unsigned long dst_offset,
-				  unsigned long src_offset, unsigned long len)
-{
-	copy_extent_buffer(dst, src, btrfs_item_nr_offset(dst, 0) + dst_offset,
-			   btrfs_item_nr_offset(src, 0) + src_offset, len);
-}
-
-/*
- * Move items in a @leaf (using memmove).
- *
- * @dst:	destination leaf for the items
- * @dst_item:	the item nr we're copying into
- * @src_item:	the item nr we're copying from
- * @nr_items:	the number of items to copy
- *
- * Wrapper around memmove_extent_buffer() that does the math to get the
- * appropriate offsets into the leaf from the item numbers.
- */
-static inline void memmove_leaf_items(const struct extent_buffer *leaf,
-				      int dst_item, int src_item, int nr_items)
-{
-	memmove_extent_buffer(leaf, btrfs_item_nr_offset(leaf, dst_item),
-			      btrfs_item_nr_offset(leaf, src_item),
-			      nr_items * sizeof(struct btrfs_item));
-}
-
-/*
- * Copy items from @src into @dst at the given @offset.
- *
- * @dst:	destination leaf for the items
- * @src:	source leaf for the items
- * @dst_item:	the item nr we're copying into
- * @src_item:	the item nr we're copying from
- * @nr_items:	the number of items to copy
- *
- * Wrapper around copy_extent_buffer() that does the math to get the
- * appropriate offsets into the leaf from the item numbers.
- */
-static inline void copy_leaf_items(const struct extent_buffer *dst,
-				   const struct extent_buffer *src,
-				   int dst_item, int src_item, int nr_items)
-{
-	copy_extent_buffer(dst, src, btrfs_item_nr_offset(dst, dst_item),
-			      btrfs_item_nr_offset(src, src_item),
-			      nr_items * sizeof(struct btrfs_item));
-}
-
 int btrfs_super_csum_size(const struct btrfs_super_block *sb)
 {
 	const u16 csum_type = btrfs_super_csum_type(sb);
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 003156795a43..bf9b7924bf2a 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -37,18 +37,6 @@
 #include "kernel-shared/uapi/btrfs_tree.h"
 #include "common/internal.h"
 
-/*
- * btrfs_inode_item stores flags in a u64, btrfs_inode stores them in two
- * separate u32s. These two functions convert between the two representations.
- *
- * MODIFIED:
- *  - Declared these here since this is the only place they're used currently.
- */
-static inline u64 btrfs_inode_combine_flags(u32 flags, u32 ro_flags)
-{
-	return (flags | ((u64)ro_flags << 32));
-}
-
 static inline void btrfs_inode_split_flags(u64 inode_item_flags,
 					   u32 *flags, u32 *ro_flags)
 {
-- 
2.42.0

