Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C64139072E
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbhEYRMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:34316 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMs (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fFZKX7rc0BlrDVypYq3Y5QmUbafuUwuzfO8YjcwO4w=;
        b=UOM/Z9xT1EYMyYJP1cIMUqvDQ4di4/liFLf+0u0uPCf3SFLwhGshR/b0pLqBnXSUPWWvJo
        I+DBexm7mMQpZzckLCAx6FTKFQim+Lil2CuqXcG3PIsO0pAYIoBpFwwAsU2mShonDicdtn
        HTRUCN8N+/oqThI58bhqf2LY1a2DmfM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0CDE7AF09;
        Tue, 25 May 2021 17:11:18 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9FE66DA70B; Tue, 25 May 2021 19:08:41 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 8/9] btrfs: simplify eb checksum verification in btrfs_validate_metadata_buffer
Date:   Tue, 25 May 2021 19:08:41 +0200
Message-Id: <6828072ccda5d55b9d130f48b750455ea728781b.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The verification copies the calculated checksum bytes to a temporary
buffer but this is not necessary. We can map the eb header on the first
page and use the checksum bytes directly.

This saves at least one function call and boundary checks so it could
lead to a minor performance improvement.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 6dc137684899..868e358f6923 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -584,6 +584,7 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 	const u32 csum_size = fs_info->csum_size;
 	u8 found_level;
 	u8 result[BTRFS_CSUM_SIZE];
+	const struct btrfs_header *header;
 	int ret = 0;
 
 	found_start = btrfs_header_bytenr(eb);
@@ -608,15 +609,14 @@ static int validate_extent_buffer(struct extent_buffer *eb)
 	}
 
 	csum_tree_block(eb, result);
+	header = page_address(eb->pages[0]) +
+		 get_eb_offset_in_page(eb, offsetof(struct btrfs_leaf, header));
 
-	if (memcmp_extent_buffer(eb, result, 0, csum_size)) {
-		u8 val[BTRFS_CSUM_SIZE] = { 0 };
-
-		read_extent_buffer(eb, &val, 0, csum_size);
+	if (memcmp(result, header->csum, csum_size) != 0) {
 		btrfs_warn_rl(fs_info,
 	"checksum verify failed on %llu wanted " CSUM_FMT " found " CSUM_FMT " level %d",
 			      eb->start,
-			      CSUM_FMT_VALUE(csum_size, val),
+			      CSUM_FMT_VALUE(csum_size, header->csum),
 			      CSUM_FMT_VALUE(csum_size, result),
 			      btrfs_header_level(eb));
 		ret = -EUCLEAN;
-- 
2.29.2

