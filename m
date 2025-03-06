Return-Path: <linux-btrfs+bounces-12053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C83C0A54BD0
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE4416B10B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E0E20E707;
	Thu,  6 Mar 2025 13:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c3uyANqh";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c3uyANqh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92820E31B
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 13:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266959; cv=none; b=jSuzOVy/p1eVdmxiiMA77sfwfpt81j+n52KUqcHWUMAs/LwMy7/uhyWkjWSw9PBbyrxI36oWX6x6r4pEiR6t/q+dHd7I8CncBfHJ3qigaNVmaDbRJgwBhYrEz+hiS10LFEE/Vz6DE4z4rE1XEbZTZruWiLm9bhasLex5zrFwryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266959; c=relaxed/simple;
	bh=b/nTQuiJ6tkcqrMX2q2IHWkXdEKyOiHz3z9XcPTi/Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWZz1jx1HPepAskpsW58ITAaDm/LIjevN5Hpcd2vvWhBhNqeX+mkoPXugsPYqm+zbuFX1nBeBVN42ubY6lXSOOpvkSmzgIvTcECYVYMAv0yntmYBCwRMTeSevC1ukReJnvq+N0/i7CdLKKiZbqU5TZ5byNe/t11ivp3g5Im8N7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c3uyANqh; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c3uyANqh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 617E621197;
	Thu,  6 Mar 2025 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741266955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEUHzZZSoKo1XGYHNRligw25cwzSd1/JmpfQQQIdeXs=;
	b=c3uyANqhdeAMMWETFjjVtK5rBflMcYDOChewz6TK7D0pr4i8/ZA1th/kU3+Digvhu7Jn3s
	zWILBU5Euc6NzdYVHDl74x8oUFbPxRKeruXbiv4uwCIxaJaaxCBvykFRPE9vCJ+Nn+Xymo
	xKpEPIqF96DIVAoF1G69wjqM4SsHIHc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=c3uyANqh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741266955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QEUHzZZSoKo1XGYHNRligw25cwzSd1/JmpfQQQIdeXs=;
	b=c3uyANqhdeAMMWETFjjVtK5rBflMcYDOChewz6TK7D0pr4i8/ZA1th/kU3+Digvhu7Jn3s
	zWILBU5Euc6NzdYVHDl74x8oUFbPxRKeruXbiv4uwCIxaJaaxCBvykFRPE9vCJ+Nn+Xymo
	xKpEPIqF96DIVAoF1G69wjqM4SsHIHc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4093113A61;
	Thu,  6 Mar 2025 13:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QoLyDgugyWfLYgAAD6G6ig
	(envelope-from <neelx@suse.com>); Thu, 06 Mar 2025 13:15:55 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] btrfs/defrag: implement compression levels
Date: Thu,  6 Mar 2025 14:15:35 +0100
Message-ID: <20250306131537.972377-1-neelx@suse.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250304171403.571335-1-neelx@suse.com>
References: <20250304171403.571335-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 617E621197
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The zstd and zlib compression types support setting compression levels.
Enhance the defrag interface to specify the levels as well.

Signed-off-by: Daniel Vacek <neelx@suse.com>
---
v3: Validate the level instead of clamping and fix the comment of the
    btrfs_ioctl_defrag_range_args structure.

v2: Fixed the commit message and added an explicit level range clamping.

 fs/btrfs/btrfs_inode.h     |  1 +
 fs/btrfs/compression.c     | 10 ++++++++++
 fs/btrfs/compression.h     |  1 +
 fs/btrfs/defrag.c          | 24 +++++++++++++++++++-----
 fs/btrfs/fs.h              |  2 +-
 fs/btrfs/inode.c           |  9 ++++++---
 include/uapi/linux/btrfs.h | 16 +++++++++++++---
 7 files changed, 51 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index aa1f55cd81b79..238e4a08a52ae 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -145,6 +145,7 @@ struct btrfs_inode {
 	 * different from prop_compress and takes precedence if set.
 	 */
 	u8 defrag_compress;
+	s8 defrag_compress_level;
 
 	/*
 	 * Lock for counters and all fields used to determine if the inode is in
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6d073e69af4e3..4191e9efc6951 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -980,6 +980,16 @@ static int btrfs_compress_set_level(unsigned int type, int level)
 	return level;
 }
 
+/*
+ * Check whether the @level is within the valid range for the given type.
+ */
+bool btrfs_compress_level_valid(unsigned int type, int level)
+{
+	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
+
+	return ops->min_level <= level && level <= ops->max_level;
+}
+
 /* Wrapper around find_get_page(), with extra error message. */
 int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
 				     struct folio **in_folio_ret)
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 933178f03d8f8..df198623cc084 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -83,6 +83,7 @@ static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
 int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
+bool btrfs_compress_level_valid(unsigned int type, int level);
 int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
 			  u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae9539482..513089b91b7b6 100644
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
@@ -1376,10 +1377,21 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
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
+				compress_type  = range->compress.type;
+				compress_level = range->compress.level;
+				if (!btrfs_compress_level_valid(compress_type, compress_level))
+					return -EINVAL;
+			}
+		} else {
+			if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
+				return -EINVAL;
+			if (range->compress_type)
+				compress_type = range->compress_type;
+		}
 	}
 
 	if (extent_thresh == 0)
@@ -1430,8 +1442,10 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
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
index fa04b027d53ac..dd27992ecb431 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -925,6 +925,7 @@ static void compress_file_range(struct btrfs_work *work)
 	unsigned int poff;
 	int i;
 	int compress_type = fs_info->compress_type;
+	int compress_level = fs_info->compress_level;
 
 	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
 
@@ -1007,13 +1008,15 @@ static void compress_file_range(struct btrfs_work *work)
 		goto cleanup_and_bail_uncompressed;
 	}
 
-	if (inode->defrag_compress)
+	if (inode->defrag_compress) {
 		compress_type = inode->defrag_compress;
-	else if (inode->prop_compress)
+		compress_level = inode->defrag_compress_level;
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
index d3b222d7af240..dd02160015b2b 100644
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
@@ -640,10 +642,18 @@ struct btrfs_ioctl_defrag_range_args {
 
 	/*
 	 * which compression method to use if turning on compression
-	 * for this defrag operation.  If unspecified, zlib will
-	 * be used
+	 * for this defrag operation. If unspecified, zlib will be
+	 * used. If compression level is also being specified, set the
+	 * BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL flag and fill the compress
+	 * member structure instead of the compress_type field.
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


