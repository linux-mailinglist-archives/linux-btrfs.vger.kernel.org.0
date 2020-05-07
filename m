Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548581C9C1A
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgEGUUa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:56192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0CE59AE96;
        Thu,  7 May 2020 20:20:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A357DDA732; Thu,  7 May 2020 22:19:39 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 05/19] btrfs: preset set/get token with first page and drop condition
Date:   Thu,  7 May 2020 22:19:39 +0200
Message-Id: <9c4e4d9f5ba0d6bd0d01282c1132a4a624d938eb.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

All the set/get helpers first check if the token contains a cached
address. After first use the address is always valid, but the extra
check is done for each call.

The token initialization can optimistically set it to the first extent
buffer page, that we know always exists. Then the condition in all
btrfs_token_*/btrfs_set_token_* can be simplified by removing the
address check from the condition, but for development the assertion
still makes sure it's valid.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h        | 3 ++-
 fs/btrfs/struct-funcs.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 054ddb5d2425..fbe2f9fa9f3e 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1352,7 +1352,8 @@ static inline void btrfs_init_map_token(struct btrfs_map_token *token,
 					struct extent_buffer *eb)
 {
 	token->eb = eb;
-	token->kaddr = NULL;
+	token->kaddr = page_address(eb->pages[0]);
+	token->offset = 0;
 }
 
 /* some macros to generate set/get functions for the struct fields.  This
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index cebd0b5e4f37..cef628a5a9e0 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -52,8 +52,8 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 	u##bits res;							\
 									\
 	ASSERT(token);							\
-									\
-	if (token->kaddr && token->offset <= offset &&			\
+	ASSERT(token->kaddr);						\
+	if (token->offset <= offset &&					\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
 		p = kaddr + part_offset - token->offset;		\
@@ -113,8 +113,8 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 	int size = sizeof(u##bits);					\
 									\
 	ASSERT(token);							\
-									\
-	if (token->kaddr && token->offset <= offset &&			\
+	ASSERT(token->kaddr);						\
+	if (token->offset <= offset &&					\
 	   (token->offset + PAGE_SIZE >= offset + size)) {	\
 		kaddr = token->kaddr;					\
 		p = kaddr + part_offset - token->offset;		\
-- 
2.25.0

