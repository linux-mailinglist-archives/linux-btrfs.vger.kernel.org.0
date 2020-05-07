Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D8D1C9C1F
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgEGUUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:56258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUh (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EBEE7AD2C;
        Thu,  7 May 2020 20:20:37 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 944D0DA732; Thu,  7 May 2020 22:19:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 08/19] btrfs: speed up btrfs_get_token_##bits helpers
Date:   Thu,  7 May 2020 22:19:46 +0200
Message-Id: <430a17cee835574132a49c60883b64fdf39875cc.1588853772.git.dsterba@suse.com>
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
Depending on the return value, the fast path uses unaligned read to get
data within a page, or fall back to read_extent_buffer that can handle
reads spanning more pages.

This is all wasteful. We know the number of bytes to read, 1/2/4/8 and
can find out the page. Then simply check if it's contained or the
fallback is needed. The token address is updated to the page, or the on
the next index, expecting that the next read will use that.

This saves one function call to map_private_extent_buffer and several
unnecessary temporary variables.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 43 +++++++++++++++--------------------------
 1 file changed, 16 insertions(+), 27 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index e6d2bd019444..e357e0bab397 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -62,39 +62,28 @@ static bool check_setget_bounds(const struct extent_buffer *eb,
 u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 			       const void *ptr, unsigned long off)	\
 {									\
-	unsigned long part_offset = (unsigned long)ptr;			\
-	unsigned long offset = part_offset + off;			\
-	void *p;							\
-	int err;							\
-	char *kaddr;							\
-	unsigned long map_start;					\
-	unsigned long map_len;						\
-	int size = sizeof(u##bits);					\
-	u##bits res;							\
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
-		res = get_unaligned_le##bits(p + off);			\
-		return res;						\
+	if (token->offset <= member_offset &&				\
+	    member_offset + size <= token->offset + PAGE_SIZE) {	\
+		return get_unaligned_le##bits(token->kaddr + oip);	\
 	}								\
-	err = map_private_extent_buffer(token->eb, offset, size,	\
-					&kaddr, &map_start, &map_len);	\
-	if (err) {							\
-		__le##bits leres;					\
-									\
-		read_extent_buffer(token->eb, &leres, offset, size);	\
-		return le##bits##_to_cpu(leres);			\
+	if (oip + size <= PAGE_SIZE) {					\
+		token->kaddr = page_address(token->eb->pages[idx]);	\
+		token->offset = idx << PAGE_SHIFT;			\
+		return get_unaligned_le##bits(token->kaddr + oip);	\
 	}								\
-	p = kaddr + part_offset - map_start;				\
-	res = get_unaligned_le##bits(p + off);				\
-	token->kaddr = kaddr;						\
-	token->offset = map_start;					\
-	return res;							\
+	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
+	token->offset = (idx + 1) << PAGE_SHIFT;			\
+	read_extent_buffer(token->eb, &leres, member_offset, size);	\
+	return le##bits##_to_cpu(leres);				\
 }									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
-- 
2.25.0

