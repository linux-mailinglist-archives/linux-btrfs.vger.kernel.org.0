Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1493A3945
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jun 2021 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhFKBdS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 21:33:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60742 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbhFKBdR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 21:33:17 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BF45721992
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623375079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fZ7zTBHHX2XlqkHmVMSn212MQ0gpNtcCY4jlsET4QGQ=;
        b=cNMjurKbd0WjJvRcfcjTnednfdL2+HIBZetE5bU9eKTD8HngmyKsiakx75kuRiR5geaPPP
        D5w4yI90Dqko7mEEt7AGCeaodOLpakWxs37sNiFIJnqIvTVNLCAZ9BWtcE54SkH8FeSB30
        EF+yHuGNOOUtDRo1odJnwjwk1xZ5syI=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id BEB41A3B84
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Jun 2021 01:31:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/9] btrfs: remove a dead comment for btrfs_decompress_bio()
Date:   Fri, 11 Jun 2021 09:31:06 +0800
Message-Id: <20210611013114.57264-2-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611013114.57264-1-wqu@suse.com>
References: <20210611013114.57264-1-wqu@suse.com>
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
---
 fs/btrfs/compression.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 831e6ae92940..fc4f37adb7b7 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -1208,20 +1208,6 @@ int btrfs_compress_pages(unsigned int type_level, struct address_space *mapping,
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

