Return-Path: <linux-btrfs+bounces-19521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11825CA3A4B
	for <lists+linux-btrfs@lfdr.de>; Thu, 04 Dec 2025 13:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2D7B30350C5
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Dec 2025 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579D33F8C9;
	Thu,  4 Dec 2025 12:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Pc/x6SCg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D5337B8D
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Dec 2025 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764852227; cv=none; b=jgSi0z+1vfgd4iuyyBfP4uXTIcHjRum/6at9nDD447pzaAGu2vLSiclpbSDQ9d45JYqJvfdgCC0iAHIEbIhPDWUyUj68fo71dYJgvXMm2gXnlHPe0HhmkqGaqMOowhmat3JKhIkT2rQVhBshDjayC7Sa/OpyPWQ6WUzHQ8XgGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764852227; c=relaxed/simple;
	bh=vHZli5k8opk+Rp1ezJFmDLW6JS6Bk8KduusccA7zaQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWMhWlfnNgQC4+GUJ2yLtv8pTtTvaUkbTchCZ22Bsssyh4/oCzLkrC1hPm0lfVLOI3T5HHHZVuWHD9YFd7Il9AqSMxVBP0aDm9yTlGWvpB1d5EfwZfdEx/YfCsz+bhik+Xcq3hZC338Qofe6zCWQRFDjc7QajcFnQKUzVw3RNWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Pc/x6SCg; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764852225; x=1796388225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHZli5k8opk+Rp1ezJFmDLW6JS6Bk8KduusccA7zaQ0=;
  b=Pc/x6SCgodvMEiqEndZZ1jTKr6awtNH6x3fBWjGSiK6QC8zWkG5u7NRw
   NXix/0oseoHR+P6sgzV1vF+r53sPM01QfxLbcr4/4vHx4RhmUvBXlmMR0
   QvznHRtrYcpyW1Hp5NgDfaEr3wclEsiB9ANqq/fLc9ZxJuk/dsDOckoqv
   BfyngcLC0gi1xMzwTtS4czdbBt9AaKnY5nnBp5lzdCz6DHXIzkMWEbYeD
   ZzmbsnyLthOJDlSPj7SVGXTtxWcNM1z99lPAgAxU/JtLEAda0K8EftuvP
   ve0f6J7ti3Wka5urvmWwT6XqO+lwppOy9nhdhnqu9MuqdaR436L+SgaG+
   g==;
X-CSE-ConnectionGUID: YDRX703qTCOXGKsJsNCm2w==
X-CSE-MsgGUID: /EFQyhRQRVSrI1sne0A6SQ==
X-IronPort-AV: E=Sophos;i="6.20,248,1758556800"; 
   d="scan'208";a="137266129"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2025 20:42:39 +0800
IronPort-SDR: 693181bf_s5MOHnuI0bnFOXBqsfdNpaE4tnWTTHRs+TNgld55f8DfLWK
 2UuDAP7ilWh5M5cuj7oVKlFyZOAlaSyCYzf3E8A==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Dec 2025 04:42:39 -0800
WDCIronportException: Internal
Received: from unknown (HELO neo.wdc.com) ([10.224.28.106])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2025 04:42:37 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 2/5] btrfs: move btrfs_bio::csum_search_commit_root into flags
Date: Thu,  4 Dec 2025 13:42:24 +0100
Message-ID: <20251204124227.431678-3-johannes.thumshirn@wdc.com>
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

Remove struct btrfs_bio's csum_search_commit_root field and move it as a
flag into the newly introduced flags member of struct btrfs_bio.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c         | 5 ++++-
 fs/btrfs/bio.h         | 6 ++++--
 fs/btrfs/compression.c | 4 +++-
 fs/btrfs/extent_io.c   | 7 ++++---
 fs/btrfs/file-item.c   | 4 ++--
 5 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 33149f07e62d..2a9ab1275b7d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -97,7 +97,10 @@ static struct btrfs_bio *btrfs_split_bio(struct btrfs_fs_info *fs_info,
 		bbio->orig_logical = orig_bbio->orig_logical;
 		orig_bbio->orig_logical += map_length;
 	}
-	bbio->csum_search_commit_root = orig_bbio->csum_search_commit_root;
+
+	if (orig_bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
+		bbio->flags |= BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
+
 	atomic_inc(&orig_bbio->pending_ios);
 	return bbio;
 }
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index d6da9ed08bfa..18d7d441c1ec 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -20,6 +20,9 @@ struct btrfs_inode;
 
 typedef void (*btrfs_bio_end_io_t)(struct btrfs_bio *bbio);
 
+/* Use the commit root to look up csums (data read bio only). */
+#define BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT	(1 << 0)
+
 /*
  * Highlevel btrfs I/O structure.  It is allocated by btrfs_bio_alloc and
  * passed to btrfs_submit_bbio() for mapping to the physical devices.
@@ -80,8 +83,7 @@ struct btrfs_bio {
 	/* Save the first error status of split bio. */
 	blk_status_t status;
 
-	/* Use the commit root to look up csums (data read bio only). */
-	bool csum_search_commit_root;
+	unsigned int flags;
 
 	/*
 	 * Since scrub will reuse btree inode, we need this flag to distinguish
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 913fddce356a..1823262fabbd 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -603,7 +603,9 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb->compressed_len = compressed_len;
 	cb->compress_type = btrfs_extent_map_compression(em);
 	cb->orig_bbio = bbio;
-	cb->bbio.csum_search_commit_root = bbio->csum_search_commit_root;
+
+	if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
+		cb->bbio.flags |= BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
 
 	btrfs_free_extent_map(em);
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 2d32dfc34ae3..d321f6897388 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -166,9 +166,10 @@ static void bio_set_csum_search_commit_root(struct btrfs_bio_ctrl *bio_ctrl)
 	if (!(btrfs_op(&bbio->bio) == BTRFS_MAP_READ && is_data_inode(bbio->inode)))
 		return;
 
-	bio_ctrl->bbio->csum_search_commit_root =
-		(bio_ctrl->generation &&
-		 bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root->fs_info));
+
+	if (bio_ctrl->generation &&
+	    bio_ctrl->generation < btrfs_get_fs_generation(bbio->inode->root->fs_info))
+		bbio->flags |= BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT;
 }
 
 static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 14e5257f0f04..823c063bb4b7 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -422,7 +422,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 	 * while we are not holding the commit_root_sem, and we get csums
 	 * from across transactions.
 	 */
-	if (bbio->csum_search_commit_root) {
+	if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT) {
 		path->search_commit_root = true;
 		path->skip_locking = true;
 		down_read(&fs_info->commit_root_sem);
@@ -473,7 +473,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
 		bio_offset += count * sectorsize;
 	}
 
-	if (bbio->csum_search_commit_root)
+	if (bbio->flags & BTRFS_BIO_CSUM_SEARCH_COMMIT_ROOT)
 		up_read(&fs_info->commit_root_sem);
 	return ret;
 }
-- 
2.52.0


