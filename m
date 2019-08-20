Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF85B966F2
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2019 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfHTQ6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Aug 2019 12:58:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:39398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfHTQ6T (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Aug 2019 12:58:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0C82DAFA8
        for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2019 16:58:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6E7B0DA7DA; Tue, 20 Aug 2019 18:58:44 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: define separate btrfs_set/get_XX helpers
Date:   Tue, 20 Aug 2019 18:58:44 +0200
Message-Id: <ac61376f382c23b3df924927d4b2e7bfe959022c.1566320094.git.dsterba@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566320094.git.dsterba@suse.com>
References: <cover.1566320094.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are helpers for all type widths defined via macro and optionally
can use a token which is a cached pointer to avoid repeated mapping of
the extent buffer.

The token value is known at compile time, when it's valid it's always
address of a local variable, otherwise it's NULL passed by the
token-less helpers.

This can be utilized to remove some branching as the helpers are used
frequently.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h        | 15 ++++--------
 fs/btrfs/struct-funcs.c | 51 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index b161224b5a0b..74233b193e89 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1364,17 +1364,10 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 void btrfs_set_token_##bits(struct extent_buffer *eb, const void *ptr,	\
 			    unsigned long off, u##bits val,		\
 			    struct btrfs_map_token *token);		\
-static inline u##bits btrfs_get_##bits(const struct extent_buffer *eb,	\
-				       const void *ptr,			\
-				       unsigned long off)		\
-{									\
-	return btrfs_get_token_##bits(eb, ptr, off, NULL);		\
-}									\
-static inline void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,\
-				    unsigned long off, u##bits val)	\
-{									\
-       btrfs_set_token_##bits(eb, ptr, off, val, NULL);			\
-}
+u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
+			 const void *ptr, unsigned long off);		\
+void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
+		      unsigned long off, u##bits val);
 
 DECLARE_BTRFS_SETGET_BITS(8)
 DECLARE_BTRFS_SETGET_BITS(16)
diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 4c13b737f568..e63936e4c1e0 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -33,6 +33,8 @@ static inline void put_unaligned_le8(u8 val, void *p)
  *
  * The extent buffer api is used to do the page spanning work required to
  * have a metadata blocksize different from the page size.
+ *
+ * There are 2 variants defined, one with a token pointer and one without.
  */
 
 #define DEFINE_BTRFS_SETGET_BITS(bits)					\
@@ -75,6 +77,31 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 	}								\
 	return res;							\
 }									\
+u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
+			 const void *ptr, unsigned long off)		\
+{									\
+	unsigned long part_offset = (unsigned long)ptr;			\
+	unsigned long offset = part_offset + off;			\
+	void *p;							\
+	int err;							\
+	char *kaddr;							\
+	unsigned long map_start;					\
+	unsigned long map_len;						\
+	int size = sizeof(u##bits);					\
+	u##bits res;							\
+									\
+	err = map_private_extent_buffer(eb, offset, size,		\
+					&kaddr, &map_start, &map_len);	\
+	if (err) {							\
+		__le##bits leres;					\
+									\
+		read_extent_buffer(eb, &leres, offset, size);		\
+		return le##bits##_to_cpu(leres);			\
+	}								\
+	p = kaddr + part_offset - map_start;				\
+	res = get_unaligned_le##bits(p + off);				\
+	return res;							\
+}									\
 void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 			    const void *ptr, unsigned long off,		\
 			    u##bits val,				\
@@ -113,6 +140,30 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 		token->offset = map_start;				\
 		token->eb = eb;						\
 	}								\
+}									\
+void btrfs_set_##bits(struct extent_buffer *eb, void *ptr,		\
+		      unsigned long off, u##bits val)			\
+{									\
+	unsigned long part_offset = (unsigned long)ptr;			\
+	unsigned long offset = part_offset + off;			\
+	void *p;							\
+	int err;							\
+	char *kaddr;							\
+	unsigned long map_start;					\
+	unsigned long map_len;						\
+	int size = sizeof(u##bits);					\
+									\
+	err = map_private_extent_buffer(eb, offset, size,		\
+			&kaddr, &map_start, &map_len);			\
+	if (err) {							\
+		__le##bits val2;					\
+									\
+		val2 = cpu_to_le##bits(val);				\
+		write_extent_buffer(eb, &val2, offset, size);		\
+		return;							\
+	}								\
+	p = kaddr + part_offset - map_start;				\
+	put_unaligned_le##bits(val, p + off);				\
 }
 
 DEFINE_BTRFS_SETGET_BITS(8)
-- 
2.22.0

