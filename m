Return-Path: <linux-btrfs+bounces-19522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29702CA3A57
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 13:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A9CB3085B33
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 12:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4D7340D92;
	Thu,  4 Dec 2025 12:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eXVk1mf/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6F2E8B8A
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 12:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852228; cv=none; b=WcrIePobMiW2HPEonOv/muWzzbz+izomRAoxoBGSK7o8Rc1J83fw0vasoRqOZJyCg2eWruQt3l1Af6AbB+/3FhflNr1JjSUkyE5xE0XK8L3r7GnAxRmRHQhVY5YrnUvjFL1D4UtV+rlmT2+mhVybkJlzAEShxd0xNY284dOsGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852228; c=relaxed/simple;
	bh=OSbgLz31oN5TflEqg63q+9Qwhs59gWZB9tkYc3qDPDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBbzPbKDxTLnI1r/B0ywNwJhFPH+obSHg3xPR8kAoBel5jw7ZzV9QATV5UYo5JPpXKJYmVS1yuXdkdv4Cpaflr/lwOoxujFcSNaV45N7wHZDXWCI8YJmMxvkU7ssr7/2nDvb9QZ7x6v/oqsvhOdivFSGI+scCRCp2mK5cH0OKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eXVk1mf/; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764852226; x=1796388226;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OSbgLz31oN5TflEqg63q+9Qwhs59gWZB9tkYc3qDPDY=;
  b=eXVk1mf/3xIYsJeUSAoCAJ2EOit5/yv/BO4RbG8lMBy8tKOLPhofTri2
   5dmv0RVvRvne0ZEUnbZb6jEEiO6PN+mPIim5p9DyhsrtY+LKD8DWR8P62
   e6iuOHMa7JEm++/DkyVmMRoHr/r2mZK4OAcdL2rR8KNcJC/oNDWPq37CW
   id3JF/h1l+MpyoIkgCx8aRoElZlxXxYkaq7iOYmOcJb96lCMC66um+Saz
   4nPvPxZX09rK1n7SxgaBaZ8tITYCqw3yQVSottP+E8uowf1UB1Y5R6wTa
   nMi9H8Fwe6FFXU2ClUkxk0wFiPijxzORxNIol2RPxcoeFaI3G12ksEjV8
   w==;
X-CSE-ConnectionGUID: gBpVQQ1HQ1O/MuBlaA4YBA==
X-CSE-MsgGUID: 4wBMNYJmQNuxXkaokAv7Iw==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137266133"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2025 20:42:41 +0800
IronPort-SDR: 693181c1_y/QsXIq2giVUwRz/vh1HkuA0sRxBYlxq7wGMD/0la/aZdst
 Dx2+3IUmPeL3ZPygo/47z/XYcPw/QLWAjOukEVw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 04:42:42 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2025 04:42:39 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 3/5] btrfs: move btrfs_bio::is_scrub into flags
Date: Thu,  4 Dec 2025 13:42:25 +0100
Message-ID: <20251204124227.431678-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove struct btrfs_bio's is_scrub field and move it as a flag into the
newly introduced flags member of struct btrfs_bio.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c   |  4 ++--
 fs/btrfs/bio.h   | 11 +++++------
 fs/btrfs/scrub.c |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2a9ab1275b7d..515b801a9c29 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -759,7 +759,7 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t status;
 	int ret;
 
-	if (bbio->is_scrub || btrfs_is_data_reloc_root(inode->root))
+	if (bbio->flags & BTRFS_BIO_IS_SCRUB || btrfs_is_data_reloc_root(inode->root))
 		smap.rst_search_commit_root = true;
 	else
 		smap.rst_search_commit_root = false;
@@ -1011,7 +1011,7 @@ void btrfs_submit_repair_write(struct btrfs_bio *bbio, int mirror_num, bool dev_
 	ASSERT(mirror_num > 0);
 	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
 	ASSERT(!is_data_inode(bbio->inode));
-	ASSERT(bbio->is_scrub);
+	ASSERT(bbio->flags & BTRFS_BIO_IS_SCRUB);
 
 	btrfs_bio_counter_inc_blocked(fs_info);
 	ret = btrfs_map_repair_block(fs_info, &smap, logical, length, mirror_num);
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 18d7d441c1ec..8183e57725e1 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -22,6 +22,11 @@ typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
 /* Use the commit root to look up csums (data read bio only). */
 #define BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT	(1 << 0)
+/*
+ * Since scrub will reuse btree inode, we need this flag to distinguish
+ * scrub bios.
+ */
+#define BTRFS_BIO_IS_SCRUB			(1 << 1)
 
 /*
  * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
@@ -85,12 +90,6 @@ struct btrfs_bio {
 
 	unsigned int flags;
 
-	/*
-	 * Since scrub will reuse btree inode, we need this flag to distinguish
-	 * scrub bios.
-	 */
-	bool is_scrub;
-
 	/* Whether the csum generation for data write is async. */
 	bool async_csum;
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 41ead4a929b0..349d0bd25c7d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -951,7 +951,7 @@ static struct btrfs_bio *alloc_scrub_bbio(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_bio *bbio = btrfs_bio_alloc(nr_vecs, opf, BTRFS_I(fs_info->btree_inode),
 						 logical, end_io, private);
-	bbio->is_scrub = true;
+	bbio->flags |= BTRFS_BIO_IS_SCRUB;
 	bbio->bio.bi_iter.bi_sector = logical >> SECTOR_SHIFT;
 	return bbio;
 }
-- 
2.52.0


