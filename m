Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DED3C1C9C1C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgEGUUf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 974A5AE0A;
        Thu,  7 May 2020 20:20:35 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 473C2DA732; Thu,  7 May 2020 22:19:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 07/19] btrfs: speed up btrfs_get_##bits helpers
Date:   Thu,  7 May 2020 22:19:44 +0200
Message-Id: <9834d603877a2e8f42fa3589fbc761e8e85e0234.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helpers unconditionally call map_private_extent_buffer to get the
address of page containing the requested offset plus the mapping start
and length. Depending on the return value, the fast path uses unaligned
read to get data within a page, or fall back to read_extent_buffer that
can handle reads spanning more pages.

This is all wasteful. We know the number of bytes to read, 1/2/4/8 and
can find out the page. Then simply check if it's contained or the
fallback is needed.

This saves one function call to map_private_extent_buffer and several
unnecessary temporary variables.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 68c02997e60d..e6d2bd019444 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -99,28 +99,19 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
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
+	const unsigned long oip = offset_in_page(member_offset);	\
+	const int size = sizeof(u##bits);				\
+	__le##bits leres;						\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	err = map_private_extent_buffer(eb, offset, size,		\
-					&kaddr, &map_start, &map_len);	\
-	if (err) {							\
-		__le##bits leres;					\
-									\
-		read_extent_buffer(eb, &leres, offset, size);		\
-		return le##bits##_to_cpu(leres);			\
+	if (oip + size <= PAGE_SIZE) {					\
+		const unsigned long idx = member_offset >> PAGE_SHIFT;	\
+		const char *kaddr = page_address(eb->pages[idx]);	\
+		return get_unaligned_le##bits(kaddr + oip);		\
 	}								\
-	p = kaddr + part_offset - map_start;				\
-	res = get_unaligned_le##bits(p + off);				\
-	return res;							\
+	read_extent_buffer(eb, &leres, member_offset, size);		\
+	return le##bits##_to_cpu(leres);				\
 }									\
 void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    const void *ptr, unsigned long off,		\
-- 
2.25.0

