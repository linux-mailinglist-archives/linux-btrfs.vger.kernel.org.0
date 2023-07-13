Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520B27524EB
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGMORP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 10:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjGMORG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 10:17:06 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D630272E
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 07:17:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3D59822160;
        Thu, 13 Jul 2023 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689257822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3QRmsyzY1ZFGw/mUZfBH9BgMFPtmg7Hhs1qc7ZCvTyk=;
        b=fsestmmSW1MePKl3V42c6NZ+DC7SF7DyaET74AyczoHy2EkBao3A+qA25Sk+y/phiQvnY2
        Lliir9TUpGK4l+TFzTKMS02YqWDo+aHoYs8uyCLbt0AfpqSS4O3TcV8QceapGJVWwpCBUY
        RizkHZzM/++7WWO4lpYTPNBQIkVP17c=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2FCF32C142;
        Thu, 13 Jul 2023 14:17:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18B50DA85A; Thu, 13 Jul 2023 16:10:27 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use helper sizeof_field in struct accessors
Date:   Thu, 13 Jul 2023 16:10:26 +0200
Message-Id: <5922093fedaf0c9225188b3502b6bbc46f367930.1689257327.git.dsterba@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1689257327.git.dsterba@suse.com>
References: <cover.1689257327.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There's a helper for obtaining size of a struct member, we can use it
instead of open coding the pointer magic.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/accessors.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index ceadfc5d6c66..8cfc8214109c 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ACCESSORS_H
 #define BTRFS_ACCESSORS_H
 
+#include <linux/stddef.h>
+
 struct btrfs_map_token {
 	struct extent_buffer *eb;
 	char *kaddr;
@@ -34,13 +36,13 @@ static inline void put_unaligned_le8(u8 val, void *p)
 	read_extent_buffer(eb, (char *)(result),			\
 			   ((unsigned long)(ptr)) +			\
 			    offsetof(type, member),			\
-			   sizeof(((type *)0)->member)))
+			    sizeof_field(type, member)))
 
 #define write_eb_member(eb, ptr, type, member, result) (\
 	write_extent_buffer(eb, (char *)(result),			\
 			   ((unsigned long)(ptr)) +			\
 			    offsetof(type, member),			\
-			   sizeof(((type *)0)->member)))
+			    sizeof_field(type, member)))
 
 #define DECLARE_BTRFS_SETGET_BITS(bits)					\
 u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
@@ -62,25 +64,25 @@ DECLARE_BTRFS_SETGET_BITS(64)
 static inline u##bits btrfs_##name(const struct extent_buffer *eb,	\
 				   const type *s)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
 	return btrfs_get_##bits(eb, s, offsetof(type, member));		\
 }									\
 static inline void btrfs_set_##name(const struct extent_buffer *eb, type *s, \
 				    u##bits val)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
 	btrfs_set_##bits(eb, s, offsetof(type, member), val);		\
 }									\
 static inline u##bits btrfs_token_##name(struct btrfs_map_token *token,	\
 					 const type *s)			\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
 	return btrfs_get_token_##bits(token, s, offsetof(type, member));\
 }									\
 static inline void btrfs_set_token_##name(struct btrfs_map_token *token,\
 					  type *s, u##bits val)		\
 {									\
-	static_assert(sizeof(u##bits) == sizeof(((type *)0))->member);	\
+	static_assert(sizeof(u##bits) == sizeof_field(type, member));	\
 	btrfs_set_token_##bits(token, s, offsetof(type, member), val);	\
 }
 
@@ -111,17 +113,14 @@ static inline void btrfs_set_##name(type *s, u##bits val)		\
 static inline u64 btrfs_device_total_bytes(const struct extent_buffer *eb,
 					   struct btrfs_dev_item *s)
 {
-	static_assert(sizeof(u64) ==
-		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
-	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item,
-					    total_bytes));
+	static_assert(sizeof(u64) == sizeof_field(struct btrfs_dev_item, total_bytes));
+	return btrfs_get_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes));
 }
 static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 						struct btrfs_dev_item *s,
 						u64 val)
 {
-	static_assert(sizeof(u64) ==
-		      sizeof(((struct btrfs_dev_item *)0))->total_bytes);
+	static_assert(sizeof(u64) == sizeof_field(struct btrfs_dev_item, total_bytes));
 	WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
 }
-- 
2.40.0

