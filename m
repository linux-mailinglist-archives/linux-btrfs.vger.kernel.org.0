Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC261C9C16
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 22:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgEGUUT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 May 2020 16:20:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:56128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgEGUUT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 7 May 2020 16:20:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E8937AC6C;
        Thu,  7 May 2020 20:20:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8E13DDA732; Thu,  7 May 2020 22:19:29 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 01/19] btrfs: use the token::eb for all set/get helpers
Date:   Thu,  7 May 2020 22:19:29 +0200
Message-Id: <497d0a07704cdb36c1d2711ff9506225f1874671.1588853772.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1588853772.git.dsterba@suse.com>
References: <cover.1588853772.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The token stores a copy of the extent buffer pointer but does not make
any use of it besides sanity checks. We can use it and drop the eb
parameter from several functions, this patch only switches the use
inside the set/get helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 73f7987143df..7928d310f698 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -62,12 +62,12 @@ u##bits btrfs_get_token_##bits(const struct extent_buffer *eb,		\
 		res = get_unaligned_le##bits(p + off);			\
 		return res;						\
 	}								\
-	err = map_private_extent_buffer(eb, offset, size,		\
+	err = map_private_extent_buffer(token->eb, offset, size,	\
 					&kaddr, &map_start, &map_len);	\
 	if (err) {							\
 		__le##bits leres;					\
 									\
-		read_extent_buffer(eb, &leres, offset, size);		\
+		read_extent_buffer(token->eb, &leres, offset, size);	\
 		return le##bits##_to_cpu(leres);			\
 	}								\
 	p = kaddr + part_offset - map_start;				\
@@ -125,13 +125,13 @@ void btrfs_set_token_##bits(struct extent_buffer *eb,			\
 		put_unaligned_le##bits(val, p + off);			\
 		return;							\
 	}								\
-	err = map_private_extent_buffer(eb, offset, size,		\
+	err = map_private_extent_buffer(token->eb, offset, size,	\
 			&kaddr, &map_start, &map_len);			\
 	if (err) {							\
 		__le##bits val2;					\
 									\
 		val2 = cpu_to_le##bits(val);				\
-		write_extent_buffer(eb, &val2, offset, size);		\
+		write_extent_buffer(token->eb, &val2, offset, size);	\
 		return;							\
 	}								\
 	p = kaddr + part_offset - map_start;				\
-- 
2.25.0

