Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1AA966F4
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfHTQ6V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:58:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:39422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfHTQ6V (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F12FAEE0
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:58:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C1BE5DA7DA; Tue, 20 Aug 2019 18:58:46 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: assume valid token for btrfs_set/get_token helpers
Date:   Tue, 20 Aug 2019 18:58:46 +0200
Message-Id: <f989bde01d1c6e37a31efce0f41450f12de95132.1566320094.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566320094.git.dsterba@suse.com>
References: <cover.1566320094.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we can safely assume that the token is always a valid pointer,
remove the branches that check that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index e63936e4c1e0..3a29b911d2e2 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -52,7 +52,9 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 	int size = sizeof(u##bits);					\
 	u##bits res;							\
 									\
-	if (token && token->kaddr && token->offset <= offset &&		\
+	ASSERT(token);							\
+									\
+	if (token->kaddr && token->offset <= offset &&			\
 	    token->eb == eb &&						\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
@@ -70,11 +72,9 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 	}								\
 	p = kaddr + part_offset - map_start;				\
 	res = get_unaligned_le##bits(p + off);				\
-	if (token) {							\
-		token->kaddr = kaddr;					\
-		token->offset = map_start;				\
-		token->eb = eb;						\
-	}								\
+	token->kaddr = kaddr;						\
+	token->offset = map_start;					\
+	token->eb = eb;							\
 	return res;							\
 }									\
 u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
@@ -116,7 +116,9 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 	unsigned long map_len;						\
 	int size = sizeof(u##bits);					\
 									\
-	if (token && token->kaddr && token->offset <= offset &&		\
+	ASSERT(token);							\
+									\
+	if (token->kaddr && token->offset <= offset &&			\
 	    token->eb == eb &&						\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
@@ -135,11 +137,9 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 	}								\
 	p = kaddr + part_offset - map_start;				\
 	put_unaligned_le##bits(val, p + off);				\
-	if (token) {							\
-		token->kaddr = kaddr;					\
-		token->offset = map_start;				\
-		token->eb = eb;						\
-	}								\
+	token->kaddr = kaddr;						\
+	token->offset = map_start;					\
+	token->eb = eb;							\
 }									\
 void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
 		      unsigned long off, u##bits val)			\
-- 
2.22.0

