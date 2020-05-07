Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94B701C9C21
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgEGUUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:56322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728590AbgEGUUl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A7F0BAD2C;
        Thu,  7 May 2020 20:20:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 54C5FDA732; Thu,  7 May 2020 22:19:51 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 10/19] btrfs: speed up btrfs_set_token_##bits helpers
Date:   Thu,  7 May 2020 22:19:51 +0200
Message-Id: <fafa95a12439369c9e6b323f3c46bbfad9efac1c.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The set/get token helpers either use the cached address in the token or
unconditionally call map_private_extent_buffer to get the address of
page containing the requested offset plus the mapping start and length.
Depending on the return value, the fast path uses unaligned put to write
data within a page, or fall back to read_extent_buffer that can handle
reads spanning more pages.

This is all wasteful. We know the number of bytes to read, 1/2/4/8 and
can find out the page. Then simply check if it's contained or the
fallback is needed. The token address is updated to the page, or the on
the next index, expecting that the next write will use that.

This saves one function call to map_private_extent_buffer and several
unnecessary temporary variables.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index f8a0357d10fd..67dfd1287c3e 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -106,38 +106,30 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    const void *ptr, unsigned long off,		\
 			    u##bits val)				\
 {									\
-	unsigned long part_offset = (unsigned long)ptr;			\
-	unsigned long offset = part_offset + off;			\
-	void *p;							\
-	int err;							\
-	char *kaddr;							\
-	unsigned long map_start;					\
-	unsigned long map_len;						\
-	int size = sizeof(u##bits);					\
+	const unsigned long member_offset = (unsigned long)ptr + off;	\
+	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
+	const unsigned long oip = offset_in_page(member_offset);	\
+	const int size = sizeof(u##bits);				\
+	__le##bits leres;						\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
 	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
-	if (token->offset <= offset &&					\
-	   (token->offset + PAGE_SIZE >= offset + size)) {	\
-		kaddr = token->kaddr;					\
-		p = kaddr + part_offset - token->offset;		\
-		put_unaligned_le##bits(val, p + off);			\
+	if (token->offset <= member_offset &&				\
+	    member_offset + size <= token->offset + PAGE_SIZE) {	\
+		put_unaligned_le##bits(val, token->kaddr + oip);	\
 		return;							\
 	}								\
-	err = map_private_extent_buffer(token->eb, offset, size,	\
-			&kaddr, &map_start, &map_len);			\
-	if (err) {							\
-		__le##bits val2;					\
-									\
-		val2 = cpu_to_le##bits(val);				\
-		write_extent_buffer(token->eb, &val2, offset, size);	\
+	if (oip + size <= PAGE_SIZE) {					\
+		token->kaddr = page_address(token->eb->pages[idx]);	\
+		token->offset = idx << PAGE_SHIFT;			\
+		put_unaligned_le##bits(val, token->kaddr + oip);	\
 		return;							\
 	}								\
-	p = kaddr + part_offset - map_start;				\
-	put_unaligned_le##bits(val, p + off);				\
-	token->kaddr = kaddr;						\
-	token->offset = map_start;					\
+	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
+	token->offset = (idx + 1) << PAGE_SHIFT;			\
+	leres = cpu_to_le##bits(val);					\
+	write_extent_buffer(token->eb, &leres, member_offset, size);	\
 }									\
 void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
 		      unsigned long off, u##bits val)			\
-- 
2.25.0

