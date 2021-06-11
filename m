Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC753A4296
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 15:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFKNCk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Jun 2021 09:02:40 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35832 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhFKNCk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Jun 2021 09:02:40 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF0BA21A5C;
        Fri, 11 Jun 2021 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623416441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vGvvMlqm/wJTQ5T307nwHOvP4DfaAqkVOVBdx+bn2V4=;
        b=M144cHXfv06RX8lTR6aLPFgRxPfIfMo902GEzSlwQ3aXLPYFAdK3tD4BGhTiUTWDpqeFHG
        eHl9scwC4SuNz4ShBDQkfxJdzRREvO4HFscG/fYqP+hnUDOVW6Ms5dqoPk/89JXH3SFkX7
        lWYRuiKA/W4yyQQdy0STcR3Kt37VZ4k=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id DD620A3BCB;
        Fri, 11 Jun 2021 13:00:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v2 1/9] btrfs: remove a dead comment for btrfs_decompress_bio()
Date:   Fri, 11 Jun 2021 21:00:25 +0800
Message-Id: <20210611130033.329908-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611130033.329908-1-wqu@suse.com>
References: <20210611130033.329908-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since commit 8140dc30a432 ("btrfs: btrfs_decompress_bio() could accept
compressed_bio instead"), btrfs_decompress_bio() accepts
"struct compressed_bio" other than open-coded parameter list.

Thus the comments for the parameter list is no longer needed.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
---
 fs/btrfs/compression.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 35ca49893803..9a023ae0f98b 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1212,20 +1212,6 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
 	return ret;
 }
 
-/*
- * pages_in is an array of pages with compressed data.
- *
- * disk_start is the starting logical offset of this array in the file
- *
- * orig_bio contains the pages from the file that we want to decompress into
- *
- * srclen is the number of bytes in pages_in
- *
- * The basic idea is that we have a bio that was created by readpages.
- * The pages in the bio are for the uncompressed data, and they may not
- * be contiguous.  They all correspond to the range of bytes covered by
- * the compressed extent.
- */
 static int btrfs_decompress_bio(struct compressed_bio *cb)
 {
 	struct list_head *workspace;
-- 
2.32.0

