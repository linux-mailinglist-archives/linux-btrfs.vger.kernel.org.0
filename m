Return-Path: <linux-btrfs+bounces-2004-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEA3845797
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836721C23321
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802585B69C;
	Thu,  1 Feb 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfQNtAH5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165DF5B684;
	Thu,  1 Feb 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790259; cv=none; b=KsQdVS8KZcfaQ19WospgyvBRNuHeqdAPD9/TVzD4rZxNisJeE5jy94l80JAKFTq+NIcYvkj78t/8rt7B0rxCcx1Q2iVJth+gBPR+2dtJE3mEyFcTCF1ELfy318ARyhTBsHTA7l5C2SM3KICqiJx2oOrq68d4Wdy7jQq6gVCxyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790259; c=relaxed/simple;
	bh=RG5js9dP2LCkjaHuyMBPje0qS5gbpb/z4Xt4qb6+buc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TVBQ2eEQMOIYf2se0GSZ0rqsebFWki1tjXqzPDB47kxd7pwuXnbyKJayqQH+rGEpoWmHgqCfVhGKz8eoSBsVAGZxd8Syy3pTMIhrySb5Ms4RVfpi2DQkUEEfn0U6vPL7WEYtnxbydESh0RANsu7OzvupXJ3Io1/J18T3eMahvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfQNtAH5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790259; x=1738326259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RG5js9dP2LCkjaHuyMBPje0qS5gbpb/z4Xt4qb6+buc=;
  b=kfQNtAH5AMw9xGfjPfZ0KH50NgPXskegm9fzJJG23uCElH7QjA5Q5GmS
   IeV2mCcmvVY6GWbGT/da8p3bRPPcI0KEvLfsDicQOD+MA2juibk4XFEsC
   zO4NJDqVEEuPNaOf28G9ZA3dnVaz8jS2GtebHZJmEqcGr96o6Ebt+6EJR
   5SmlKBz8KmC6mu9ZfBn9riUI4sDVtBv7kH4jOh3ezMLFwHO7gdg34tx6H
   0FIeQrhjXOUqARLIRA4YhwI81aoLjciAq19nAQ9+tljfNcEAHGoXs7KYO
   1PA7/DqQaNCmqOQK0tAm1z5JIuMJYDaqtQJw9WEtXz+1npZFeTrACkAFq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747058"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747058"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499114"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:13 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 09/21] fs/ntfs3: add prefix to bitmap_size() and use BITS_TO_U64()
Date: Thu,  1 Feb 2024 13:22:04 +0100
Message-ID: <20240201122216.2634007-10-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bitmap_size() is a pretty generic name and one may want to use it for
a generic bitmap API function. At the same time, its logic is
NTFS-specific, as it aligns to the sizeof(u64), not the sizeof(long)
(although it uses ideologically right ALIGN() instead of division).
Add the prefix 'ntfs3_' used for that FS (not just 'ntfs_' to not mix
it with the legacy module) and use generic BITS_TO_U64() while at it.

Suggested-by: Yury Norov <yury.norov@gmail.com> # BITS_TO_U64()
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 fs/ntfs3/ntfs_fs.h |  4 ++--
 fs/ntfs3/bitmap.c  |  4 ++--
 fs/ntfs3/fsntfs.c  |  2 +-
 fs/ntfs3/index.c   | 11 ++++++-----
 fs/ntfs3/super.c   |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f6706143d14b..16b84d605cd2 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -961,9 +961,9 @@ static inline bool run_is_empty(struct runs_tree *run)
 }
 
 /* NTFS uses quad aligned bitmaps. */
-static inline size_t bitmap_size(size_t bits)
+static inline size_t ntfs3_bitmap_size(size_t bits)
 {
-	return ALIGN((bits + 7) >> 3, 8);
+	return BITS_TO_U64(bits) * sizeof(u64);
 }
 
 #define _100ns2seconds 10000000
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 63f14a0232f6..a19a73ed630b 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -654,7 +654,7 @@ int wnd_init(struct wnd_bitmap *wnd, struct super_block *sb, size_t nbits)
 	wnd->total_zeroes = nbits;
 	wnd->extent_max = MINUS_ONE_T;
 	wnd->zone_bit = wnd->zone_end = 0;
-	wnd->nwnd = bytes_to_block(sb, bitmap_size(nbits));
+	wnd->nwnd = bytes_to_block(sb, ntfs3_bitmap_size(nbits));
 	wnd->bits_last = nbits & (wbits - 1);
 	if (!wnd->bits_last)
 		wnd->bits_last = wbits;
@@ -1347,7 +1347,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
 		return -EINVAL;
 
 	/* Align to 8 byte boundary. */
-	new_wnd = bytes_to_block(sb, bitmap_size(new_bits));
+	new_wnd = bytes_to_block(sb, ntfs3_bitmap_size(new_bits));
 	new_last = new_bits & (wbits - 1);
 	if (!new_last)
 		new_last = wbits;
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index fbfe21dbb425..e18de9c4c2fa 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -522,7 +522,7 @@ static int ntfs_extend_mft(struct ntfs_sb_info *sbi)
 	ni->mi.dirty = true;
 
 	/* Step 2: Resize $MFT::BITMAP. */
-	new_bitmap_bytes = bitmap_size(new_mft_total);
+	new_bitmap_bytes = ntfs3_bitmap_size(new_mft_total);
 
 	err = attr_set_size(ni, ATTR_BITMAP, NULL, 0, &sbi->mft.bitmap.run,
 			    new_bitmap_bytes, &new_bitmap_bytes, true, NULL);
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a..e0cef8f4e414 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1456,8 +1456,8 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 
 	alloc->nres.valid_size = alloc->nres.data_size = cpu_to_le64(data_size);
 
-	err = ni_insert_resident(ni, bitmap_size(1), ATTR_BITMAP, in->name,
-				 in->name_len, &bitmap, NULL, NULL);
+	err = ni_insert_resident(ni, ntfs3_bitmap_size(1), ATTR_BITMAP,
+				 in->name, in->name_len, &bitmap, NULL, NULL);
 	if (err)
 		goto out2;
 
@@ -1518,8 +1518,9 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (bmp) {
 		/* Increase bitmap. */
 		err = attr_set_size(ni, ATTR_BITMAP, in->name, in->name_len,
-				    &indx->bitmap_run, bitmap_size(bit + 1),
-				    NULL, true, NULL);
+				    &indx->bitmap_run,
+				    ntfs3_bitmap_size(bit + 1), NULL, true,
+				    NULL);
 		if (err)
 			goto out1;
 	}
@@ -2092,7 +2093,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (in->name == I30_NAME)
 		ni->vfs_inode.i_size = new_data;
 
-	bpb = bitmap_size(bit);
+	bpb = ntfs3_bitmap_size(bit);
 	if (bpb * 8 == nbits)
 		return 0;
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9153dffde950..0248db1e5c01 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1331,7 +1331,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Check bitmap boundary. */
 	tt = sbi->used.bitmap.nbits;
-	if (inode->i_size < bitmap_size(tt)) {
+	if (inode->i_size < ntfs3_bitmap_size(tt)) {
 		ntfs_err(sb, "$Bitmap is corrupted.");
 		err = -EINVAL;
 		goto put_inode_out;
-- 
2.43.0


