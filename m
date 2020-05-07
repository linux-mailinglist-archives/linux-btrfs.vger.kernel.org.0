Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC731C9C27
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgEGUU4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:56470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGUUz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AA65BAEA1;
        Thu,  7 May 2020 20:20:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4B0B3DA732; Thu,  7 May 2020 22:20:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 16/19] btrfs: optimize split page read in btrfs_get_token_##bits
Date:   Thu,  7 May 2020 22:20:05 +0200
Message-Id: <1237ad8249d4016f90b7aca807efb8887ef791f7.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fallback path calls helper read_extent_buffer to do read of the data
spanning two extent buffer pages. As the size is known, we can do the
read directly in two steps.  This removes one function call and compiler
can optimize memcpy as the sizes are known at compile time. The cached
token address is set to the second page.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 46a7269bee07..63cab91507f8 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -66,7 +66,8 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
 	const unsigned long oip = offset_in_page(member_offset);	\
 	const int size = sizeof(u##bits);				\
-	__le##bits leres;						\
+	u8 lebytes[sizeof(u##bits)];					\
+	const int part = PAGE_SIZE - oip;				\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
@@ -75,15 +76,16 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	    member_offset + size <= token->offset + PAGE_SIZE) {	\
 		return get_unaligned_le##bits(token->kaddr + oip);	\
 	}								\
-	if (oip + size <= PAGE_SIZE) {					\
-		token->kaddr = page_address(token->eb->pages[idx]);	\
-		token->offset = idx << PAGE_SHIFT;			\
+	token->kaddr = page_address(token->eb->pages[idx]);		\
+	token->offset = idx << PAGE_SHIFT;				\
+	if (oip + size <= PAGE_SIZE)					\
 		return get_unaligned_le##bits(token->kaddr + oip);	\
-	}								\
+									\
+	memcpy(lebytes, token->kaddr + oip, part);			\
 	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
 	token->offset = (idx + 1) << PAGE_SHIFT;			\
-	read_extent_buffer(token->eb, &leres, member_offset, size);	\
-	return le##bits##_to_cpu(leres);				\
+	memcpy(lebytes + part, token->kaddr, size - part);		\
+	return get_unaligned_le##bits(lebytes);				\
 }									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
-- 
2.25.0

