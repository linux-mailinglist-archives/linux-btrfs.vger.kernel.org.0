Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9681C9C28
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgEGUU5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgEGUU5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E1E74AE0A;
        Thu,  7 May 2020 20:20:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 92105DA732; Thu,  7 May 2020 22:20:07 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 17/19] btrfs: optimize split page write in btrfs_set_##bits
Date:   Thu,  7 May 2020 22:20:07 +0200
Message-Id: <d2b64677b512a5d4f43f5c612270ddfdbc93fd52.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The helper write_extent_buffer is called to do write of the data
spanning two extent buffer pages. As the size is known, we can do the
write directly in two steps.  This removes one function call and
compiler can optimize memcpy as the sizes are known at compile time.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 63cab91507f8..7987d3910660 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -141,18 +141,22 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
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
 	if (oip + size <= PAGE_SIZE) {					\
-		const unsigned long idx = member_offset >> PAGE_SHIFT;	\
-		char *kaddr = page_address(eb->pages[idx]);		\
 		put_unaligned_le##bits(val, kaddr + oip);		\
 		return;							\
 	}								\
-	leres = cpu_to_le##bits(val);					\
-	write_extent_buffer(eb, &leres, member_offset, size);		\
+									\
+	put_unaligned_le##bits(val, lebytes);				\
+	memcpy(kaddr + oip, lebytes, part);				\
+	kaddr = page_address(eb->pages[idx + 1]);			\
+	memcpy(kaddr, lebytes + part, size - part);			\
 }
 
 DEFINE_BTRFS_SETGET_BITS(8)
-- 
2.25.0

