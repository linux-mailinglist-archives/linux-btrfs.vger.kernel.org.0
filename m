Return-Path: <linux-btrfs+bounces-15393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E90FAFEBFA
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 16:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 372361BC3D1E
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9E92E54B3;
	Wed,  9 Jul 2025 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hd0TRp8F";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hd0TRp8F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7A32749D1
	for <linux-btrfs@vger.kernel.org>; Wed,  9 Jul 2025 14:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752071364; cv=none; b=YvBfo0EbekVv7YOcvYuMWyW0iGARYoa8yHvGkamQZGY6dRfH1bERducqrNazwH3HQQLEEDB+8nyNHN4mNXydioD9edRVtPsJxvamsy1kwf+IYERP/4dyr06MparGjE9v4wEajfl3fhuU0mv0tyryMc5O6pLFaccK8v2zfLhpRBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752071364; c=relaxed/simple;
	bh=+7a+ykwWiMgh1GjJN2ufkO9PN+vkJRX7ky9SHQAMWWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWGywu6f0i2WHzU+85ACgy0Sx2ugftC68f/fRtTq7Q4fcd+o4SD1gU8xd8jjEhQbqvBNUs3qvOPjD6uT+KQ3fU7ObLpEPjbnE1x6GZ4VaQZ8QiriGGTXscVbAhr+BniSWEPw5LI1vJWolHG2g4IxTWxBNb39pbuSuEYPB1q/j4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hd0TRp8F; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hd0TRp8F; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 748431F385;
	Wed,  9 Jul 2025 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752071360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2PQqTmhdyGkGw/9szRUa0kCywZ4V1roBcCjP/D4Uiyk=;
	b=Hd0TRp8FF6xbHj4QTEnOk6CsEaHoDEHxo4CwJYstq1o8zDXDbEtzj+g+SVnvexq/IqY5zG
	XTPEYH+kmwubO1k1F68sGaRUz/ge/Z83X5ODxl92Vsyc/8k8dFtveAZz3rCeEw5eihDALu
	udCf5Rkaz/UdAxwRVsG+vOpYRzxjf0M=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hd0TRp8F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752071360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2PQqTmhdyGkGw/9szRUa0kCywZ4V1roBcCjP/D4Uiyk=;
	b=Hd0TRp8FF6xbHj4QTEnOk6CsEaHoDEHxo4CwJYstq1o8zDXDbEtzj+g+SVnvexq/IqY5zG
	XTPEYH+kmwubO1k1F68sGaRUz/ge/Z83X5ODxl92Vsyc/8k8dFtveAZz3rCeEw5eihDALu
	udCf5Rkaz/UdAxwRVsG+vOpYRzxjf0M=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D98213757;
	Wed,  9 Jul 2025 14:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EYi8GsB8bmgcbwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 09 Jul 2025 14:29:20 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: defrag: add flag to force no-compression
Date: Wed,  9 Jul 2025 16:29:17 +0200
Message-ID: <20250709142917.23293-1-dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 748431F385
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Currently the defrag ioctl cannot rewrite the extents without
compression. Add a new flag for that, as setting compression to 0 (or
"no compression") means to do no changes to compression so take what is
the current default, like mount options or properties.

The defrag setting overrides mount or properties. The compression
BTRFS_DEFRAG_DONT_COMPRESS is only used for in-memory operations and
does not need to have a fixed value.

Mount with zstd:9, copy test file from /usr/bin/ (about 260KB):

  $ mount -o compress=zstd:9 /dev/vda /mnt
  $ filefrag -vsb testfile
  filefrag: -b needs a blocksize option, assuming 1024-byte blocks.
  Filesystem type is: 9123683e
  File size of testfile is 297704 (292 blocks of 1024 bytes)
   ext:     logical_offset:        physical_offset: length:   expected: flags:
     0:        0..     127:      13312..     13439:    128:             encoded
     1:      128..     255:      13364..     13491:    128:      13440: encoded
     2:      256..     291:      13424..     13459:     36:      13492: last,encoded,eof
  testfile: 3 extents found

  $ compsize testfile
  Processed 1 file, 3 regular extents (3 refs), 0 inline, 1 fragments.
  Type       Perc     Disk Usage   Uncompressed Referenced
  TOTAL       42%      124K         292K         292K
  zstd        42%      124K         292K         292K

Defrag to uncompressed:

  $ btrfs fi defrag --nocomp testfile
  $ filefrag -vsb testfile
  filefrag: -b needs a blocksize option, assuming 1024-byte blocks.
  Filesystem type is: 9123683e
  File size of testfile is 297704 (292 blocks of 1024 bytes)
   ext:     logical_offset:        physical_offset: length:   expected: flags:
     0:        0..     291:     291840..    292131:    292:             last,eof
  testfile: 1 extent found

  $ compsize testfile
  Processed 1 file, 1 regular extents (1 refs), 0 inline, 1 fragments.
  Type       Perc     Disk Usage   Uncompressed Referenced
  TOTAL      100%      292K         292K         292K
  none       100%      292K         292K         292K

Compress again with LZO:

  $ btrfs fi defrag -clzo testfile
  $ filefrag -vsb testfile
  filefrag: -b needs a blocksize option, assuming 1024-byte blocks.
  Filesystem type is: 9123683e
  File size of testfile is 297704 (292 blocks of 1024 bytes)
   ext:     logical_offset:        physical_offset: length:   expected: flags:
     0:        0..     127:      13312..     13439:    128:             encoded
     1:      128..     255:      13392..     13519:    128:      13440: encoded
     2:      256..     291:      13480..     13515:     36:      13520: last,encoded,eof
  testfile: 3 extents found

  $ compsize testfile
  Processed 1 file, 3 regular extents (3 refs), 0 inline, 1 fragments.
  Type       Perc     Disk Usage   Uncompressed Referenced
  TOTAL       64%      188K         292K         292K
  lzo         64%      188K         292K         292K

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/compression.h     |  2 ++
 fs/btrfs/defrag.c          | 13 +++++++++----
 fs/btrfs/inode.c           | 11 +++++++----
 fs/btrfs/ioctl.c           | 10 ++++++++--
 include/uapi/linux/btrfs.h |  3 +++
 5 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 1df3c8dec40a..1b38e707bbd9 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -113,6 +113,8 @@ enum btrfs_compression_type {
 	BTRFS_COMPRESS_LZO   = 2,
 	BTRFS_COMPRESS_ZSTD  = 3,
 	BTRFS_NR_COMPRESS_TYPES = 4,
+
+	BTRFS_DEFRAG_DONT_COMPRESS,
 };
 
 struct workspace_manager {
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 701b6b51ea85..738179a5e170 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -947,7 +947,7 @@ struct defrag_target_range {
  * @extent_thresh: file extent size threshold, any extent size >= this value
  *		   will be ignored
  * @newer_than:    only defrag extents newer than this value
- * @do_compress:   whether the defrag is doing compression
+ * @do_compress:   whether the defrag is doing compression or no-compression
  *		   if true, @extent_thresh will be ignored and all regular
  *		   file extents meeting @newer_than will be targets.
  * @locked:	   if the range has already held extent lock
@@ -1364,6 +1364,7 @@ int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 	u64 cur;
 	u64 last_byte;
 	bool do_compress = (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
+	bool no_compress = (range->flags & BTRFS_DEFRAG_RANGE_NOCOMPRESS);
 	int compress_type = BTRFS_COMPRESS_ZLIB;
 	int compress_level = 0;
 	int ret = 0;
@@ -1394,6 +1395,9 @@ int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 			if (range->compress_type)
 				compress_type = range->compress_type;
 		}
+	} else if (range->flags & BTRFS_DEFRAG_RANGE_NOCOMPRESS) {
+		compress_type = BTRFS_DEFRAG_DONT_COMPRESS;
+		compress_level = 1;
 	}
 
 	if (extent_thresh == 0)
@@ -1444,13 +1448,14 @@ int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 			btrfs_inode_unlock(inode, 0);
 			break;
 		}
-		if (do_compress) {
+		if (do_compress || no_compress) {
 			inode->defrag_compress = compress_type;
 			inode->defrag_compress_level = compress_level;
 		}
 		ret = defrag_one_cluster(inode, ra, cur,
 				cluster_end + 1 - cur, extent_thresh,
-				newer_than, do_compress, &sectors_defragged,
+				newer_than, do_compress || no_compress,
+				&sectors_defragged,
 				max_to_defrag, &last_scanned);
 
 		if (sectors_defragged > prev_sectors_defragged)
@@ -1489,7 +1494,7 @@ int btrfs_defrag_file(struct btrfs_inode *inode, struct file_ra_state *ra,
 			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
 		ret = sectors_defragged;
 	}
-	if (do_compress) {
+	if (do_compress || no_compress) {
 		btrfs_inode_lock(inode, 0);
 		inode->defrag_compress = BTRFS_COMPRESS_NONE;
 		btrfs_inode_unlock(inode, 0);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7a2ea7d121f..73f4d8bd1cf8 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -781,12 +781,15 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 		return 0;
 	}
 
+	/* Defrag ioctl takes precedence over mount options and properties. */
+	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
+		return 0;
+	if (BTRFS_COMPRESS_NONE < inode->defrag_compress &&
+	    inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES)
+		return 1;
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
 		return 1;
-	/* defrag ioctl */
-	if (inode->defrag_compress)
-		return 1;
 	/* bad compression ratios */
 	if (inode->flags & BTRFS_INODE_NOCOMPRESS)
 		return 0;
@@ -942,7 +945,7 @@ static void compress_file_range(struct btrfs_work *work)
 		goto cleanup_and_bail_uncompressed;
 	}
 
-	if (inode->defrag_compress) {
+	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_COMPRESS_TYPES) {
 		compress_type = inode->defrag_compress;
 		compress_level = inode->defrag_compress_level;
 	} else if (inode->prop_compress) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 680c4e794e67..bf561be18885 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2554,8 +2554,14 @@ static int btrfs_ioctl_defrag(struct file *file, void __user *argp)
 				ret = -EOPNOTSUPP;
 				goto out;
 			}
-			/* compression requires us to start the IO */
-			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS)) {
+			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS) &&
+			    (range.flags & BTRFS_DEFRAG_RANGE_NOCOMPRESS)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			/* Compression or no-compression require to start the IO. */
+			if ((range.flags & BTRFS_DEFRAG_RANGE_COMPRESS) ||
+			    (range.flags & BTRFS_DEFRAG_RANGE_NOCOMPRESS)) {
 				range.flags |= BTRFS_DEFRAG_RANGE_START_IO;
 				range.extent_thresh = (u32)-1;
 			}
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index dd02160015b2..8e710bbb688e 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -616,8 +616,11 @@ struct btrfs_ioctl_clone_range_args {
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
 #define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
+/* Request no compression on the range (uncompress if necessary). */
+#define BTRFS_DEFRAG_RANGE_NOCOMPRESS	8
 #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
 					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
+					 BTRFS_DEFRAG_RANGE_NOCOMPRESS |	\
 					 BTRFS_DEFRAG_RANGE_START_IO)
 
 struct btrfs_ioctl_defrag_range_args {
-- 
2.49.0


