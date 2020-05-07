Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9691E1C9C29
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgEGUVA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:21:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:56528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGUVA (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:21:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3ABABAE96;
        Thu,  7 May 2020 20:21:01 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DCFE8DA732; Thu,  7 May 2020 22:20:09 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 18/19] btrfs: optimize split page write in btrfs_set_token_##bits
Date:   Thu,  7 May 2020 22:20:09 +0200
Message-Id: <a07b15ea5e0b93f2117ffce2236740605c2c61cc.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The fallback path calls helper write_extent_buffer to do write of the
data spanning two extent buffer pages. As the size is known, we can do
the write directly in two steps.  This removes one function call and
compiler can optimize memcpy as the sizes are known at compile time. The
cached token address is set to the second page.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 7987d3910660..225ef6d7e949 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -115,7 +115,8 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	const unsigned long idx = member_offset >> PAGE_SHIFT;		\
 	const unsigned long oip = offset_in_page(member_offset);	\
 	const int size = sizeof(u##bits);				\
-	__le##bits leres;						\
+	u8 lebytes[sizeof(u##bits)];					\
+	const int part = PAGE_SIZE - oip;				\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
@@ -125,16 +126,17 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
 		return;							\
 	}								\
+	token->kaddr = page_address(token->eb->pages[idx]);		\
+	token->offset = idx << PAGE_SHIFT;				\
 	if (oip + size <= PAGE_SIZE) {					\
-		token->kaddr = page_address(token->eb->pages[idx]);	\
-		token->offset = idx << PAGE_SHIFT;			\
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
 		return;							\
 	}								\
+	put_unaligned_le##bits(val, lebytes);				\
+	memcpy(token->kaddr + oip, lebytes, part);			\
 	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
 	token->offset = (idx + 1) << PAGE_SHIFT;			\
-	leres = cpu_to_le##bits(val);					\
-	write_extent_buffer(token->eb, &leres, member_offset, size);	\
+	memcpy(token->kaddr, lebytes + part, size - part);		\
 }									\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
-- 
2.25.0

