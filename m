Return-Path: <linux-btrfs+bounces-14732-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B914ADD5D6
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33EC4400085
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 16:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B02EE260;
	Tue, 17 Jun 2025 16:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhTpaMK6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F92F3639
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176795; cv=none; b=ISMo0naTW2JokQS/cvKnYUsi8jjKdHEK6eJmcqxCNpOzEahmf1tjR7nk1bdaHPN9JoVMrxYrB+TWOrejjufXH1F75dDCX8VZyLqSbEZA5uUB1mzmEFQ2n/rnO7fYo30FyFMJyvEkHgTFEBMCdW/9Y0ZnpeG3r1O4kzIrNLMTnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176795; c=relaxed/simple;
	bh=MszGsIcsIQct+dunysEiEbp184/0v0AbJsuiwbdYcm4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QYfXlwnSHeofoHhEDgRHRRdNw9BffRi6iv4CFXP3P5fYQibWRu5LPQOOyrXmMmTbGpkjmSRxrYxF5FMs/ldrqRTNtxIGppwk73TAqWkTpJKLOCLHA6pXIqxs9LPcK/Gpb04OVcWPukPFQKEwpWqSkcTD3JQMKVm7/A8I3DU36hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhTpaMK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2FAC4CEE7
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750176794;
	bh=MszGsIcsIQct+dunysEiEbp184/0v0AbJsuiwbdYcm4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OhTpaMK6miqRGJPUlhEwjJBxydwfZBI/1a64hNWuxu2Faa5D3IwFR34e9slCFal12
	 o8RXkFzTaXIyicyzq2NdUMqhlqxC0UtBBM/qfs3mSg8EzPIt/lYo7LVK/PnUAcwU08
	 SOnlo0K7vaTbvQyDhCAOlpX0r3PjWyRU36zysu8RkBDUS7uM2OSqtsPkDSlIEK5M1+
	 ALe+OZffOn6b1x4A7AMoh7hDlsgvhpgoAfGH3xIXtz88c61ruZBWho5YbHOtDNhR7N
	 81dqqS19xgZRp8R6f0h/ZfaD0mw10A7yAORpUh4PdIVv14ZUt150781l6XtAjle4AF
	 oMnr/E+eyb+Lw==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/16] btrfs: make extent_buffer_test_bit() return a boolean instead
Date: Tue, 17 Jun 2025 17:12:58 +0100
Message-ID: <3b31cb90b9170b14931c0f4500069eb6e5709096.1750075579.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1750075579.git.fdmanana@suse.com>
References: <cover.1750075579.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

All the callers want is to determine if a bit is set and all of them call
the function and do a double negation (!!) on its result to get a boolean.
So change it to return a boolean and simplify callers.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent_io.c             |  4 ++--
 fs/btrfs/extent_io.h             |  4 ++--
 fs/btrfs/free-space-tree.c       |  2 +-
 fs/btrfs/tests/extent-io-tests.c | 14 +++++++-------
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e9ba80a56172..c7811fe493f3 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4108,8 +4108,8 @@ static inline void eb_bitmap_offset(const struct extent_buffer *eb,
  * @start:  offset of the bitmap item in the extent buffer
  * @nr:     bit number to test
  */
-int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
-			   unsigned long nr)
+bool extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
+			    unsigned long nr)
 {
 	unsigned long i;
 	size_t offset;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 65bb87f1dce6..61130786b9a3 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -345,8 +345,8 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 			   unsigned long len);
 void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long len);
-int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
-			   unsigned long pos);
+bool extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
+			    unsigned long pos);
 void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
 			      unsigned long pos, unsigned long len);
 void extent_buffer_bitmap_clear(const struct extent_buffer *eb,
diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index 29fada10158c..b24c23312892 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -532,7 +532,7 @@ int free_space_test_bit(struct btrfs_block_group *block_group,
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
 	i = div_u64(offset - found_start,
 		    block_group->fs_info->sectorsize);
-	return !!extent_buffer_test_bit(leaf, ptr, i);
+	return extent_buffer_test_bit(leaf, ptr, i);
 }
 
 static void free_space_set_bits(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index 00da54f0164c..d2a6f769fd76 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -343,11 +343,11 @@ static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb)
 	unsigned long i;
 
 	for (i = 0; i < eb->len * BITS_PER_BYTE; i++) {
-		int bit, bit1;
+		bool bit_set, bit1_set;
 
-		bit = !!test_bit(i, bitmap);
-		bit1 = !!extent_buffer_test_bit(eb, 0, i);
-		if (bit1 != bit) {
+		bit_set = test_bit(i, bitmap);
+		bit1_set = extent_buffer_test_bit(eb, 0, i);
+		if (bit1_set != bit_set) {
 			u8 has;
 			u8 expect;
 
@@ -360,9 +360,9 @@ static int check_eb_bitmap(unsigned long *bitmap, struct extent_buffer *eb)
 			return -EINVAL;
 		}
 
-		bit1 = !!extent_buffer_test_bit(eb, i / BITS_PER_BYTE,
-						i % BITS_PER_BYTE);
-		if (bit1 != bit) {
+		bit1_set = extent_buffer_test_bit(eb, i / BITS_PER_BYTE,
+						  i % BITS_PER_BYTE);
+		if (bit1_set != bit_set) {
 			u8 has;
 			u8 expect;
 
-- 
2.47.2


