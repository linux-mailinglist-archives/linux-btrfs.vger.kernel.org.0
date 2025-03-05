Return-Path: <linux-btrfs+bounces-12019-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DEA4FC5F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A1C1895053
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E78B209F25;
	Wed,  5 Mar 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jSYiRK2p";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jSYiRK2p"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D4E2066F6
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170781; cv=none; b=AFbIkm+EPLjGYhXMCiz62UfPnnkjjmDAbusGwbg7F4I/L2pSm8qLALU+DqdqKovDxwQ+R3C5G1YE0h08J+NFEX6K6GmSpBlLxTo6azJCWDyZ0n8rrGTbtdh9DftdlGqUZjTLqcRWeMK9vQPJGefDKaa0fXXvtnvblrfT8uHMuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170781; c=relaxed/simple;
	bh=OcBfiFtEmuwPQex58NJW4jRnkP45vg2KP4vgvR1qYRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGlkfYKKVO5h0cvrJPH70Wd5ahTa3AFPUVtUKjLrhFiAiyowDrYUYw7aYfCuVphL2KAGOb7/PcljcNOa8iDWlKFE4bgXFjvz5lKubqyKPs4T6igYps4j8NvgC59fXFxshdT0x96eHW40WtU6gYH9cEOw+H3CQn1c7YQxGbUMmqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jSYiRK2p; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jSYiRK2p; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B689621170;
	Wed,  5 Mar 2025 10:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741170776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMjPiq/fOLYpxw8Rc5BlOAt66Zz15s8Qdw1LiisGZns=;
	b=jSYiRK2px6oh+HiyfgPsPIJOEvfoyo1RReryIoE+ej9tNvfWQsazBF0i1EDzW9jYCNsvpw
	X8dtQkeiZd1pqBokQCAfCvRiCwMHmiA4eTWasJZTGIJ8zvg2AW6aheU6rM6vFGvNaUXJqi
	0k8vEL+sbZFDY4qpRH8dLqth2HuKwS0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741170776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HMjPiq/fOLYpxw8Rc5BlOAt66Zz15s8Qdw1LiisGZns=;
	b=jSYiRK2px6oh+HiyfgPsPIJOEvfoyo1RReryIoE+ej9tNvfWQsazBF0i1EDzW9jYCNsvpw
	X8dtQkeiZd1pqBokQCAfCvRiCwMHmiA4eTWasJZTGIJ8zvg2AW6aheU6rM6vFGvNaUXJqi
	0k8vEL+sbZFDY4qpRH8dLqth2HuKwS0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A60B13939;
	Wed,  5 Mar 2025 10:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l9AWJVgoyGdtAgAAD6G6ig
	(envelope-from <neelx@suse.com>); Wed, 05 Mar 2025 10:32:56 +0000
From: Daniel Vacek <neelx@suse.com>
To: Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>
Cc: Daniel Vacek <neelx@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] btrfs/defrag: implement compression levels
Date: Wed,  5 Mar 2025 11:32:34 +0100
Message-ID: <20250305103235.719210-1-neelx@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -6.80
X-Spam-Flag: NO

The zstd and zlib compression types support setting compression levels.
Enhance the defrag interface to specify the levels as well.

Signed-off-by: Daniel Vacek <neelx@suse.com>
Reviewed-by: Qu Wenruo <wqu@suse.com>
---
v2: Fixed the commit message and added an explicit level range check.

 fs/btrfs/btrfs_inode.h     |  1 +
 fs/btrfs/compression.c     |  2 +-
 fs/btrfs/compression.h     |  1 +
 fs/btrfs/defrag.c          | 24 +++++++++++++++++++-----
 fs/btrfs/fs.h              |  2 +-
 fs/btrfs/inode.c           |  9 ++++++---
 include/uapi/linux/btrfs.h | 10 +++++++++-
 7 files changed, 38 insertions(+), 11 deletions(-)

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
index 6d073e69af4e3..7106d19ee7bac 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -968,7 +968,7 @@ static void put_workspace(int type, struct list_head *ws)
  * Adjust @level according to the limits of the compression algorithm or
  * fallback to default
  */
-static int btrfs_compress_set_level(unsigned int type, int level)
+int btrfs_compress_set_level(unsigned int type, int level)
 {
 	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
 
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 933178f03d8f8..125509605f847 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -83,6 +83,7 @@ static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
 int __init btrfs_init_compress(void);
 void __cold btrfs_exit_compress(void);
 
+int btrfs_compress_set_level(unsigned int type, int level);
 int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
 			  u64 start, struct folio **folios, unsigned long *out_folios,
 			 unsigned long *total_in, unsigned long *total_out);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae9539482..3e9e2345a5683 100644
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
+				compress_type = range->compress.type;
+				compress_level= range->compress.level;
+				compress_level= btrfs_compress_set_level(compress_type,
+									 compress_level);
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
index fa04b027d53ac..d26c005bf091a 100644
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


