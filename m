Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2775E39072C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 May 2021 19:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhEYRMp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 May 2021 13:12:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:34182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232224AbhEYRMo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 May 2021 13:12:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621962673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cnrQzS58CqZqHxfAmvMpfza0Vxpp0RXv6sNZ3Me8e5w=;
        b=Ugc1W3g9nOoK9fZwPRETP06lMIhYzaRU97QoWdcphl3CqLTVslaOZoEAQr5ojxbs+nnFlz
        0cVvhW1vL7khemv3gEbvIltT3UFbs4gwUXxXcWtSbqDyKyDi7dszQaIxS0LyHnpx4FtMxF
        Bta/Ftgtx13gRYAk0ldCeWo22l1GSTE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 77107AEEB;
        Tue, 25 May 2021 17:11:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 05CD9DA70B; Tue, 25 May 2021 19:08:37 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/9] btrfs: reduce compressed_bio members' types
Date:   Tue, 25 May 2021 19:08:36 +0200
Message-Id: <1a3c6cddd909d922948a22ac1f287293e0deb665.1621961965.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621961965.git.dsterba@suse.com>
References: <cover.1621961965.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Several members of compressed_bio are of type that's unnecessarily big
for the values that they'd hold:

- the size of the uncompressed and compressed data is 128K now, we can
  keep is as int
- same for number of pages
- the compress type fits to a byte
- the errors is 0/1

The size of the unpatched structure is 80 bytes with several holes.
Reordering nr_pages next to the pages the hole after pending_bios is
filled and the resulting size is 56 bytes. This keeps the csums array
aligned to 8 bytes, which is nice. Further size optimizations may be
possible but right now it looks good to me:

struct compressed_bio {
        refcount_t                 pending_bios;         /*     0     4 */
        unsigned int               nr_pages;             /*     4     4 */
        struct page * *            compressed_pages;     /*     8     8 */
        struct inode *             inode;                /*    16     8 */
        u64                        start;                /*    24     8 */
        unsigned int               len;                  /*    32     4 */
        unsigned int               compressed_len;       /*    36     4 */
        u8                         compress_type;        /*    40     1 */
        u8                         errors;               /*    41     1 */

        /* XXX 2 bytes hole, try to pack */

        int                        mirror_num;           /*    44     4 */
        struct bio *               orig_bio;             /*    48     8 */
        u8                         sums[];               /*    56     0 */

        /* size: 56, cachelines: 1, members: 12 */
        /* sum members: 54, holes: 1, sum holes: 2 */
        /* last cacheline: 56 bytes */
};

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.c |  2 +-
 fs/btrfs/compression.h | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 9a0c26e4e389..c006f5d81c2a 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -507,7 +507,7 @@ blk_status_t btrfs_submit_compressed_write(struct btrfs_inode *inode, u64 start,
 		}
 		if (bytes_left < PAGE_SIZE) {
 			btrfs_info(fs_info,
-					"bytes left %lu compress len %lu nr %lu",
+					"bytes left %lu compress len %u nr %u",
 			       bytes_left, cb->compressed_len, cb->nr_pages);
 		}
 		bytes_left -= PAGE_SIZE;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 8001b700ea3a..00d8439048c9 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -31,6 +31,9 @@ struct compressed_bio {
 	/* number of bios pending for this compressed extent */
 	refcount_t pending_bios;
 
+	/* Number of compressed pages in the array */
+	unsigned int nr_pages;
+
 	/* the pages with the compressed data on them */
 	struct page **compressed_pages;
 
@@ -40,20 +43,17 @@ struct compressed_bio {
 	/* starting offset in the inode for our pages */
 	u64 start;
 
-	/* number of bytes in the inode we're working on */
-	unsigned long len;
-
-	/* number of bytes on disk */
-	unsigned long compressed_len;
+	/* Number of bytes in the inode we're working on */
+	unsigned int len;
 
-	/* the compression algorithm for this bio */
-	int compress_type;
+	/* Number of bytes on disk */
+	unsigned int compressed_len;
 
-	/* number of compressed pages in the array */
-	unsigned long nr_pages;
+	/* The compression algorithm for this bio */
+	u8 compress_type;
 
 	/* IO errors */
-	int errors;
+	u8 errors;
 	int mirror_num;
 
 	/* for reads, this is the bio we are copying the data into */
-- 
2.29.2

