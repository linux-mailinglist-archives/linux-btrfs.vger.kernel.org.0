Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728624A89FE
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240782AbiBCR1U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:27:20 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47510 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241975AbiBCR1T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:27:19 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 87D4F21128;
        Thu,  3 Feb 2022 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643909238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BGqzze+e/tD+EJlxJr6vsI2GXArSu8b553HG/gVW3sQ=;
        b=bkWjrRApl5A6ZhEo8yLkNqBsO7a59qUOobKzy0ZwKPxZMf2gnOfxm2RxMTfumtIKdY5zfI
        p/zwc4tVL0jIDq5dm3T8/L036t66nIyzVOTz0aC5f5a4is8THJfb/HgkP1F4Ghtjvui77X
        QTJ/rxPXG2NCpVqt3xrtOE2wJ/hIIEs=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 83A6CA3B89;
        Thu,  3 Feb 2022 17:27:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 83AE3DA781; Thu,  3 Feb 2022 18:26:33 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/5] btrfs: move check_setget_bounds out of ASSERT
Date:   Thu,  3 Feb 2022 18:26:33 +0100
Message-Id: <dae7bf275f2719c7e79005dd34f9bc7d89d6dc6e.1643904960.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643904960.git.dsterba@suse.com>
References: <cover.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The bounds check should be done on all builds unconditionally. Now that
the whole checking and reporting machinery is done and optimized, the
impact should be minimal.  Assertion would normally fail, the helpers
will not try to access the memory and return, we can't do much else.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 28b9e62cdc86..1761111e8098 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -81,7 +81,8 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
-	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
+	if (check_setget_bounds(token->eb, ptr, off, size))		\
+		return 0;						\
 	if (token->offset <= member_offset &&				\
 	    member_offset + size <= token->offset + PAGE_SIZE) {	\
 		return get_unaligned_le##bits(token->kaddr + oip);	\
@@ -108,7 +109,8 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
 	const int part = PAGE_SIZE - oip;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
-	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
+	if (check_setget_bounds(eb, ptr, off, size))			\
+		return 0;						\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE)	\
 		return get_unaligned_le##bits(kaddr + oip);		\
 									\
@@ -131,7 +133,8 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
 									\
 	ASSERT(token);							\
 	ASSERT(token->kaddr);						\
-	ASSERT(check_setget_bounds(token->eb, ptr, off, size));		\
+	if (check_setget_bounds(token->eb, ptr, off, size))		\
+		return;							\
 	if (token->offset <= member_offset &&				\
 	    member_offset + size <= token->offset + PAGE_SIZE) {	\
 		put_unaligned_le##bits(val, token->kaddr + oip);	\
@@ -160,7 +163,8 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
 	const int part = PAGE_SIZE - oip;				\
 	u8 lebytes[sizeof(u##bits)];					\
 									\
-	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
+	if (check_setget_bounds(eb, ptr, off, size))			\
+		return;							\
 	if (INLINE_EXTENT_BUFFER_PAGES == 1 || oip + size <= PAGE_SIZE) { \
 		put_unaligned_le##bits(val, kaddr + oip);		\
 		return;							\
-- 
2.34.1

