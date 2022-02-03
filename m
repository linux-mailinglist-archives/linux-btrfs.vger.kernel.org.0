Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C214A89FB
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Feb 2022 18:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352836AbiBCR1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 12:27:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47494 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352827AbiBCR1M (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Feb 2022 12:27:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1EB0A21128;
        Thu,  3 Feb 2022 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643909232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zl3dv1TdXq/P6G0My53EEBJ+1sI2Ri+GwbUucpcecB0=;
        b=pZqbIYrb/vxGfpzij5qVRk0p9wOh9ltRKyby9hMntj5OA+0Va1qOFXNgngLzjvnMEPZJu6
        jnXt4qb33Tg2KU+yvDjJCJUtWI0JHDSTXgJK9Mp43E7gApdAr2Ob595EXUPryDe29FRcnT
        w4kmwi0C4Cke5QZMvrGVk2iWeL8Ctag=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 192A1A3B85;
        Thu,  3 Feb 2022 17:27:12 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 18A09DA781; Thu,  3 Feb 2022 18:26:27 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/5] btrfs: factor out reporting when check_setget_bounds fails
Date:   Thu,  3 Feb 2022 18:26:27 +0100
Message-Id: <aaaf44e09b94c78b9d208fc5503826ff8da47b4c.1643904960.git.dsterba@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643904960.git.dsterba@suse.com>
References: <cover.1643904960.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The eb bounds checks are supposed to almost never fail so the reporting
part can be moved away to a separate function and will be used to store
information about the failed checks. Add the inline keyword as a hint,
but according to the generated assembly it is already inlined.

The message level is set from warning to error as this should be
noticeable in the logs.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/struct-funcs.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
index 12455b2b41de..c97c69e29d64 100644
--- a/fs/btrfs/struct-funcs.c
+++ b/fs/btrfs/struct-funcs.c
@@ -7,16 +7,24 @@
 
 #include "ctree.h"
 
-static bool check_setget_bounds(const struct extent_buffer *eb,
-				const void *ptr, unsigned off, int size)
+static void report_setget_bounds(const struct extent_buffer *eb,
+				 const void *ptr, unsigned off, int size)
 {
 	const unsigned long member_offset = (unsigned long)ptr + off;
 
-	if (unlikely(member_offset + size > eb->len)) {
-		btrfs_warn(eb->fs_info,
+	btrfs_err_rl(eb->fs_info,
 		"bad eb member %s: ptr 0x%lx start %llu member offset %lu size %d",
-			(member_offset > eb->len ? "start" : "end"),
-			(unsigned long)ptr, eb->start, member_offset, size);
+		(member_offset > eb->len ? "start" : "end"),
+		(unsigned long)ptr, eb->start, member_offset, size);
+}
+
+static inline bool check_setget_bounds(const struct extent_buffer *eb,
+				       const void *ptr, unsigned off, int size)
+{
+	const unsigned long member_offset = (unsigned long)ptr + off;
+
+	if (unlikely(member_offset + size > eb->len)) {
+		report_setget_bounds(eb, ptr, off, size);
 		return false;
 	}
 
-- 
2.34.1

