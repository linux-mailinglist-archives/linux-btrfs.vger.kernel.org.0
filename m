Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219B31C9C26
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgEGUUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:56440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGUUw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 525E7AE96;
        Thu,  7 May 2020 20:20:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 020E3DA732; Thu,  7 May 2020 22:20:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 15/19] btrfs: optimize split page read in btrfs_get_##bits
Date:   Thu,  7 May 2020 22:20:02 +0200
Message-Id: <b051dbd526f4298d8f8eb04cb30556def1ad00d0.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper read_extent_buffer is called to do read of the data spanning
two extent buffer pages. As the size is known, we can do the read
directly in two steps.  This removes one function call and compiler can
optimize memcpy as the sizes are known at compile time.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 0b23aa0a32d5..46a7269bee07 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -90,17 +90,20 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 {									\
 	const unsigned long member_offset = (unsigned long)ptr + off;	\
 	const unsigned long oip = offset_in_page(member_offset);	\
+	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
+	char *kaddr = page_address(eb->pages[idx]);			\
 	const int size = sizeof(u##bits);				\
-	__le##bits leres;						\
+	const int part = PAGE_SIZE - oip;				\
+	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (oip + size <= PAGE_SIZE) {					\
-		const unsigned long idx = member_offset >> PAGE_SHIFT;	\
-		const char *kaddr = page_address(eb->pages[idx]);	\
+	if (oip + size <= PAGE_SIZE)					\
 		return get_unaligned_le##bits(kaddr + oip);		\
-	}								\
-	read_extent_buffer(eb, &leres, member_offset, size);		\
-	return le##bits##_to_cpu(leres);				\
+									\
+	memcpy(lebytes, kaddr + oip, part);				\
+	kaddr = page_address(eb->pages[idx + 1]);			\
+	memcpy(lebytes + part, kaddr, size - part);			\
+	return get_unaligned_le##bits(lebytes);				\
 }									\
 void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    const void *ptr, unsigned long off,		\
-- 
2.25.0

