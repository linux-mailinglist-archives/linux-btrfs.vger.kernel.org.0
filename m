Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAAD1C9C1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgEGUUc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 57A66AEA1;
        Thu,  7 May 2020 20:20:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id F2756DA732; Thu,  7 May 2020 22:19:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 06/19] btrfs: add separate bounds checker for set/get helpers
Date:   Thu,  7 May 2020 22:19:41 +0200
Message-Id: <dc6452dc6971a0d1064216d9d1ad9cfbe4f3521b.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bounds checking is now done in map_private_extent_buffer but that
will be removed in following patches and some sanity checks should still
be done.

There are two separate checks to see the kind of out of bounds access:
partial (start offset is in the buffer) or complete (both start and end
are out).

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index cef628a5a9e0..68c02997e60d 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -17,6 +17,27 @@ static inline void put_unaligned_le8(u8 val, void *p)
        *(u8 *)p = val;
 }
 
+static bool check_setget_bounds(const struct extent_buffer *eb,
+				const void *ptr, unsigned off, int size)
+{
+	const unsigned long member_offset = (unsigned long)ptr + off;
+
+	if (member_offset > eb->len) {
+		btrfs_warn(eb->fs_info,
+	"bad eb member start: ptr 0x%lx start %llu member offset %lu size %d",
+			(unsigned long)ptr, eb->start, member_offset, size);
+		return false;
+	}
+	if (member_offset + size > eb->len) {
+		btrfs_warn(eb->fs_info,
+	"bad eb member end: ptr 0x%lx start %llu member offset %lu size %d",
+			(unsigned long)ptr, eb->start, member_offset, size);
+		return false;
+	}
+
+	return true;
+}
+
 /*
  * this is some deeply nasty code.
  *
@@ -53,6 +74,7 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
+	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
 	if (token->offset <= offset &&					\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
@@ -87,6 +109,7 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	int size = sizeof(u##bits);					\
 	u##bits res;							\
 									\
+	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
 	err = map_private_extent_buffer(eb, offset, size,		\
 					&kaddr, &map_start, &map_len);	\
 	if (err) {							\
@@ -114,6 +137,7 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
+	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
 	if (token->offset <= offset &&					\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
@@ -147,6 +171,7 @@ void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
 	unsigned long map_len;						\
 	int size = sizeof(u##bits);					\
 									\
+	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
 	err = map_private_extent_buffer(eb, offset, size,		\
 			&kaddr, &map_start, &map_len);			\
 	if (err) {							\
-- 
2.25.0

