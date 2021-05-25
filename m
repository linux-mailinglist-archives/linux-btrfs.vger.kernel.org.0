Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C5539072F
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbhEYRMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:34366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mhXIqSUTbbvpcDB8JsvWBlk0Yj9L8UxmpxRUa4AsVGQ=;
        b=MLLX9Xx6kuveAhoyjpR2FUjqSR9UAYq6yMyDAAs8gO3qbnzmtZeBt4X29BtP6++XcGowsm
        1UroTlUT4ymB4iqCzZVLrGOzYn1abwNafBda7pzEI7bk3Qt06iYnYoiGfNES0+V/W7hDC0
        C2cykAbPc/0P1vZAAYADH1wz7wD7XRI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B71EAEEB;
        Tue, 25 May 2021 17:11:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id EF5E7DA70B; Tue, 25 May 2021 19:08:43 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 9/9] btrfs: clean up header members offsets in write helpers
Date:   Tue, 25 May 2021 19:08:43 +0200
Message-Id: <3a6ce6b310ecb2021a1ffea01fb08f48663d1a00.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Move header offsetof() to the expression that calculates the address so
it's part of get_eb_offset_in_page where the 2nd parameter is the member
offset.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2b250c610562..2e924f60ea6f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6519,9 +6519,10 @@ void write_extent_buffer_chunk_tree_uuid(const struct extent_buffer *eb,
 	char *kaddr;
 
 	assert_eb_page_uptodate(eb, eb->pages[0]);
-	kaddr = page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
-	memcpy(kaddr + offsetof(struct btrfs_header, chunk_tree_uuid), srcv,
-			BTRFS_FSID_SIZE);
+	kaddr = page_address(eb->pages[0]) +
+		get_eb_offset_in_page(eb, offsetof(struct btrfs_header,
+						   chunk_tree_uuid));
+	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
 }
 
 void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
@@ -6529,9 +6530,9 @@ void write_extent_buffer_fsid(const struct extent_buffer *eb, const void *srcv)
 	char *kaddr;
 
 	assert_eb_page_uptodate(eb, eb->pages[0]);
-	kaddr = page_address(eb->pages[0]) + get_eb_offset_in_page(eb, 0);
-	memcpy(kaddr + offsetof(struct btrfs_header, fsid), srcv,
-			BTRFS_FSID_SIZE);
+	kaddr = page_address(eb->pages[0]) +
+		get_eb_offset_in_page(eb, offsetof(struct btrfs_header, fsid));
+	memcpy(kaddr, srcv, BTRFS_FSID_SIZE);
 }
 
 void write_extent_buffer(const struct extent_buffer *eb, const void *srcv,
-- 
2.29.2

