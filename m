Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB03B947C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 18:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbhGAQFr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 12:05:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36274 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhGAQFq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jul 2021 12:05:46 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C95AC204E0;
        Thu,  1 Jul 2021 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1625155394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=cknwxC+2rToQKr7WlVpmQ6yUjgcpsnHSU9T8pS1+Knc=;
        b=WYwPD9J75trYTR52GiGmt1VrZpl5ljRPDRhm3pTcwow6OYHA9w1l5g2ObCAqqYop86CEMC
        9Wqb15xTWqUW9mw+UafAgUuqS7/KTUrPzreReRggayVcL+IeVnovSxb6hblgapOkLwhM5x
        nXtK5NHU0SVsNtPf7gUJwtqAdmboMcE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id C0356A3B87;
        Thu,  1 Jul 2021 16:03:14 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 34D95DA6FD; Thu,  1 Jul 2021 18:00:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH] btrfs: add special case to setget helpers for 64k pages
Date:   Thu,  1 Jul 2021 18:00:39 +0200
Message-Id: <20210701160039.12518-1-dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 64K pages the size of the extent_buffer::pages array is 1 and
compilation with -Warray-bounds warns due to

  kaddr = page_address(eb->pages[idx + 1]);

when reading byte range crossing page boundary.

This does never actually overflow the array because on 64K because all
the data fit in one page and bounds are checked by check_setget_bounds.

To fix the reported overflow and warning add a copy of the non-crossing
read/write code and put it behind a condition that's evaluated at
compile time. That way only one implementation remains due to dead code
elimination.

Link: https://lore.kernel.org/lkml/20210623083901.1d49d19d@canb.auug.org.au/
CC: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 66 +++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 8260f8bb3ff0..51204b280da8 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -73,14 +73,18 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	}								\
 	token->kaddr = page_address(token->eb->pages[idx]);		\
 	token->offset = idx << PAGE_SHIFT;				\
-	if (oip + size <= PAGE_SIZE)					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
 		return get_unaligned_le##bits(token->kaddr + oip);	\
+	} else {							\
+		if (oip + size <= PAGE_SIZE)				\
+			return get_unaligned_le##bits(token->kaddr + oip); \
 									\
-	memcpy(lebytes, token->kaddr + oip, part);			\
-	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
-	token->offset = (idx + 1) << PAGE_SHIFT;			\
-	memcpy(lebytes + part, token->kaddr, size - part);		\
-	return get_unaligned_le##bits(lebytes);				\
+		memcpy(lebytes, token->kaddr + oip, part);		\
+		token->kaddr = page_address(token->eb->pages[idx + 1]);	\
+		token->offset = (idx + 1) << PAGE_SHIFT;		\
+		memcpy(lebytes + part, token->kaddr, size - part);	\
+		return get_unaligned_le##bits(lebytes);			\
+	}								\
 }									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 			 const void *ptr, unsigned long off)		\
@@ -94,13 +98,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (oip + size <= PAGE_SIZE)					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
 		return get_unaligned_le##bits(kaddr + oip);		\
+	} else {							\
+		if (oip + size <= PAGE_SIZE)				\
+			return get_unaligned_le##bits(kaddr + oip);	\
 									\
-	memcpy(lebytes, kaddr + oip, part);				\
-	kaddr = page_address(eb->pages[idx + 1]);			\
-	memcpy(lebytes + part, kaddr, size - part);			\
-	return get_unaligned_le##bits(lebytes);				\
+		memcpy(lebytes, kaddr + oip, part);			\
+		kaddr = page_address(eb->pages[idx + 1]);		\
+		memcpy(lebytes + part, kaddr, size - part);		\
+		return get_unaligned_le##bits(lebytes);			\
+	}								\
 }									\
 void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 			    const void *ptr, unsigned long off,		\
@@ -124,15 +132,19 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	}								\
 	token->kaddr = page_address(token->eb->pages[idx]);		\
 	token->offset = idx << PAGE_SHIFT;				\
-	if (oip + size <= PAGE_SIZE) {					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
-		return;							\
+	} else {							\
+		if (oip + size <= PAGE_SIZE) {				\
+			put_unaligned_le##bits(val, token->kaddr + oip); \
+			return;						\
+		}							\
+		put_unaligned_le##bits(val, lebytes);			\
+		memcpy(token->kaddr + oip, lebytes, part);		\
+		token->kaddr = page_address(token->eb->pages[idx + 1]);	\
+		token->offset = (idx + 1) << PAGE_SHIFT;		\
+		memcpy(token->kaddr, lebytes + part, size - part);	\
 	}								\
-	put_unaligned_le##bits(val, lebytes);				\
-	memcpy(token->kaddr + oip, lebytes, part);			\
-	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
-	token->offset = (idx + 1) << PAGE_SHIFT;			\
-	memcpy(token->kaddr, lebytes + part, size - part);		\
 }									\
 void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 		      unsigned long off, u##bits val)			\
@@ -146,15 +158,19 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
 	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
-	if (oip + size <= PAGE_SIZE) {					\
+	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
 		put_unaligned_le##bits(val, kaddr + oip);		\
-		return;							\
-	}								\
+	} else {							\
+		if (oip + size <= PAGE_SIZE) {				\
+			put_unaligned_le##bits(val, kaddr + oip);	\
+			return;						\
+		}							\
 									\
-	put_unaligned_le##bits(val, lebytes);				\
-	memcpy(kaddr + oip, lebytes, part);				\
-	kaddr = page_address(eb->pages[idx + 1]);			\
-	memcpy(kaddr, lebytes + part, size - part);			\
+		put_unaligned_le##bits(val, lebytes);			\
+		memcpy(kaddr + oip, lebytes, part);			\
+		kaddr = page_address(eb->pages[idx + 1]);		\
+		memcpy(kaddr, lebytes + part, size - part);		\
+	}								\
 }
 
 DEFINE_BTRFS_SETGET_BITS(8)
-- 
2.31.1

