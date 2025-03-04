Return-Path: <linux-btrfs+bounces-12001-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470CA4E9A6
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 18:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D3081897219
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Mar 2025 17:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7BC29CB5B;
	Tue,  4 Mar 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fBrecMJf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fBrecMJf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E7429617E
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Mar 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108534; cv=none; b=I8FA6hf9lUILYK+Ji0fJNT17kf1HCg3EufpaiZAgPUVvnYKyeHY20elIuGlM7Kvpe0kWagj+JMy+NLc8jfSEoYkoSkBaxw4DC7l7lVQYea6ICKYgwVXMLrsM/AOnwfzKRYTSSP1LhY0ToVknR6MG7ZnReSTRRi/IFPChiSOIZmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108534; c=relaxed/simple;
	bh=hW1SLqOd+1NDjRlqGdiw+vFxE/87tHWD+9J2QeAHR/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ruwwh6CARPHyhi9RVHsSQ+xngj9ONE6BQY3Zq7l0x0zSsF7N/Ah3jV0pBsH56V2nbsd0hgRo8us0O7FXDQGcBSD0RFYc7Ez0TlGq64u1X765ZYGji4bveyb6CZPOmjvbqnkZLlKRDoSFGEWd12U6vVKMpKs9J796IJtKrVFXxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fBrecMJf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fBrecMJf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4A00421199;
	Tue,  4 Mar 2025 17:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741108530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C7Fyus2sr8XupmFfh56BYZJnTAQEk5IuQrN1D4yR20U=;
	b=fBrecMJfUcs+WOPcKajrxHgF7swk90fhDiR8XdJRjH5+y+D3wAWBgzIIttZE2vPjc+Bjki
	Xe0US0jpSdnoEfW0qEogLVRuW+/kD7DzS7DyPHh8zC5whjSJjcBBaCnUAq6thUBT9ERzBk
	FzfihUBNe56JTxLO25MbYZ/mifpq1Dw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741108530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=C7Fyus2sr8XupmFfh56BYZJnTAQEk5IuQrN1D4yR20U=;
	b=fBrecMJfUcs+WOPcKajrxHgF7swk90fhDiR8XdJRjH5+y+D3wAWBgzIIttZE2vPjc+Bjki
	Xe0US0jpSdnoEfW0qEogLVRuW+/kD7DzS7DyPHh8zC5whjSJjcBBaCnUAq6thUBT9ERzBk
	FzfihUBNe56JTxLO25MbYZ/mifpq1Dw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D05113967;
	Tue,  4 Mar 2025 17:15:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qq/eCTI1x2f6ZwAAD6G6ig
	(envelope-from <neelx@suse.com>); Tue, 04 Mar 2025 17:15:30 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] btrfs/defrag: implement compression levels
Date: Tue,  4 Mar 2025 18:14:00 +0100
Message-ID: <20250304171403.571335-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
 fs/btrfs/btrfs_inode.h     |  2 ++
 fs/btrfs/defrag.c          | 22 +++++++++++++++++-----
 fs/btrfs/fs.h              |  2 +-
 fs/btrfs/inode.c           | 10 +++++++---
 include/uapi/linux/btrfs.h | 10 +++++++++-
 5 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index aa1f55cd81b79..5ee9da0054a74 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -145,6 +145,7 @@ struct btrfs_inode {
 	 * different from prop_compress and takes precedence if set.
 	 */
 	u8 defrag_compress;
+	s8 defrag_compress_level;
 
 	/*
 	 * Lock for counters and all fields used to determine if the inode is in
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae9539482..03a0287a78ea0 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -1363,6 +1363,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	u64 last_byte;
 	bool do_compress = (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
 	int compress_type = BTRFS_COMPRESS_ZLIB;
+	int compress_level = 0;
 	int ret = 0;
 	u32 extent_thresh = range->extent_thresh;
 	pgoff_t start_index;
@@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		return -EINVAL;
 
 	if (do_compress) {
-		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
-			return -EINVAL;
-		if (range->compress_type)
-			compress_type = range->compress_type;
+		if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
+			if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
+				return -EINVAL;
+			if (range->compress.type) {
+				compress_type = range->compress.type;
+				compress_level= range->compress.level;
+			}
+		} else {
+			if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
+				return -EINVAL;
+			if (range->compress_type)
+				compress_type = range->compress_type;
+		}
 	}
 
 	if (extent_thresh == 0)
@@ -1430,8 +1440,10 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			btrfs_inode_unlock(BTRFS_I(inode), 0);
 			break;
 		}
-		if (do_compress)
+		if (do_compress) {
 			BTRFS_I(inode)->defrag_compress = compress_type;
+			BTRFS_I(inode)->defrag_compress_level = compress_level;
+		}
 		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
 				cluster_end + 1 - cur, extent_thresh,
 				newer_than, do_compress, &sectors_defragged,
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index be6d5a24bd4e6..2dae7ffd37133 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -485,7 +485,7 @@ struct btrfs_fs_info {
 	u64 last_trans_log_full_commit;
 	unsigned long long mount_opt;
 
-	unsigned long compress_type:4;
+	int compress_type;
 	int compress_level;
 	u32 commit_interval;
 	/*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fa04b027d53ac..156a9d4603391 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -925,6 +925,7 @@ static void compress_file_range(struct btrfs_work *work)
 	unsigned int poff;
 	int i;
 	int compress_type = fs_info->compress_type;
+	int compress_level= fs_info->compress_level;
 
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
@@ -1007,13 +1008,15 @@ static void compress_file_range(struct btrfs_work *work)
 		goto cleanup_and_bail_uncompressed;
 	}
 
-	if (inode->defrag_compress)
+	if (inode->defrag_compress) {
 		compress_type = inode->defrag_compress;
-	else if (inode->prop_compress)
+		compress_level= inode->defrag_compress_level;
+	} else if (inode->prop_compress) {
 		compress_type = inode->prop_compress;
+	}
 
 	/* Compression level is applied here. */
-	ret = btrfs_compress_folios(compress_type, fs_info->compress_level,
+	ret = btrfs_compress_folios(compress_type, compress_level,
 				    mapping, start, folios, &nr_folios, &total_in,
 				    &total_compressed);
 	if (ret)
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index d3b222d7af240..3540d33d6f50c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -615,7 +615,9 @@ struct btrfs_ioctl_clone_range_args {
  */
 #define BTRFS_DEFRAG_RANGE_COMPRESS 1
 #define BTRFS_DEFRAG_RANGE_START_IO 2
+#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
 #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
+					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
 					 BTRFS_DEFRAG_RANGE_START_IO)
 
 struct btrfs_ioctl_defrag_range_args {
@@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
 	 * for this defrag operation.  If unspecified, zlib will
 	 * be used
 	 */
-	__u32 compress_type;
+	union {
+		__u32 compress_type;
+		struct {
+			__u8 type;
+			__s8 level;
+		} compress;
+	};
 
 	/* spare for later */
 	__u32 unused[4];
-- 
2.47.2


