Return-Path: <linux-btrfs+bounces-11827-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2132A4543C
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 05:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685FB188E804
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2025 04:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3F22676CF;
	Wed, 26 Feb 2025 03:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PoIHLQnz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="PoIHLQnz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70425E45B
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542392; cv=none; b=ZMAQJU/fYNJrT+NUf0DtsZC01o7LcVDjsaC0uh/P4AVmf7DFXoCl80jh45CDJ7U/UUyNBJPEvMALz9VVqrL6hJ7NtrQMuxKpDREgSb5gMPZRhmJ/G2yMUntqkus2QBfm2sd4IJBj/FtFFkEMFSV/uLl/CEeVz5gqUufTJbUq9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542392; c=relaxed/simple;
	bh=VYLMsW4P6QZFhOjBFaAmfZQYkZFX2ETKP+T8peQpTec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJiUeyD9vMTkXycdF6g6/e84pOek2Y3LuaseQvvOYkF8OkMFFPxRohFw3JVYuu0Y6TfvT/ImU8upUEzoINW+DnaDICoF0o8Fx6pIffX8dKGCzzx1S74zdzKHTUeNUwynDn8bdW0uT79p1T+vldzxB5XsZ42oCP/5S0ku5zuJXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PoIHLQnz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=PoIHLQnz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6615B2118D
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIWqjBAMNLIPH+IE1eUTGigYxJhJOm3Y9DLpS3NMzt4=;
	b=PoIHLQnzlaVCIMc4BrL4poUTBmxPQNi/lygQBr/Brr/22igXfj9t+y4KTkqXxuhuU+wTEe
	11mwfzTg+YcApBppItwYjNrKfb2yg84849TpQRMJkz1uzEhczqNVadY8tEBbiwGInev2i9
	QnlSSYO3NB06Za8GLmJWzltkBDrFTe0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=PoIHLQnz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740542384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIWqjBAMNLIPH+IE1eUTGigYxJhJOm3Y9DLpS3NMzt4=;
	b=PoIHLQnzlaVCIMc4BrL4poUTBmxPQNi/lygQBr/Brr/22igXfj9t+y4KTkqXxuhuU+wTEe
	11mwfzTg+YcApBppItwYjNrKfb2yg84849TpQRMJkz1uzEhczqNVadY8tEBbiwGInev2i9
	QnlSSYO3NB06Za8GLmJWzltkBDrFTe0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B76713404
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wNbKFq+RvmdOegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2025 03:59:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: support 2k block size
Date: Wed, 26 Feb 2025 14:29:16 +1030
Message-ID: <31a6625633a3a64b855d69ce5ade1466e516d0a4.1740542229.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740542229.git.wqu@suse.com>
References: <cover.1740542229.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6615B2118D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since btrfs only supports block size 4K and PAGE_SIZE, on x86_64 it
means we can not test subpage block size easily.

With the recent kernel change to support 2K block size for debug builds,
also add 2K block size support for btrfs-progs, so that we can do proper
subpage block size testing on x86_64, without acquiring an aarch64
machine.

There is a limit:

- No support for 2K node size
  The limit is from the initial mkfs tree root, which can only have
  a single leaf to contain all root items.
  But 2K leaf can not handle all the root items, thus we have to disable
  it.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c     | 11 ++++++++---
 kernel-shared/ctree.h   |  6 ++++++
 kernel-shared/disk-io.c | 11 ++++-------
 mkfs/main.c             |  7 -------
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 7aaddab6a192..398065dbea86 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -628,7 +628,8 @@ int btrfs_check_sectorsize(u32 sectorsize)
 		error("invalid sectorsize %u, must be power of 2", sectorsize);
 		return -EINVAL;
 	}
-	if (sectorsize < SZ_4K || sectorsize > SZ_64K) {
+	if (sectorsize < BTRFS_MIN_BLOCKSIZE ||
+	    sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		error("invalid sectorsize %u, expected range is [4K, 64K]",
 		      sectorsize);
 		return -EINVAL;
@@ -650,9 +651,13 @@ int btrfs_check_sectorsize(u32 sectorsize)
 int btrfs_check_nodesize(u32 nodesize, u32 sectorsize,
 			 struct btrfs_mkfs_features *features)
 {
-	if (nodesize < sectorsize) {
+	if (nodesize < sectorsize || nodesize < SZ_4K) {
+		/*
+		 * Although we support 2K block size, we can not support 2K
+		 * nodesize, as it's too small to contain all the needed root items.
+		 */
 		error("illegal nodesize %u (smaller than %u)",
-				nodesize, sectorsize);
+		      nodesize, max_t(u32, sectorsize, SZ_4K));
 		return -1;
 	} else if (nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		error("illegal nodesize %u (larger than %u)",
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 8c923be96705..c3d66c99c78d 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -63,6 +63,12 @@ static inline u32 __BTRFS_LEAF_DATA_SIZE(u32 nodesize)
 	return nodesize - sizeof(struct btrfs_header);
 }
 
+#if EXPERIMENTAL
+#define BTRFS_MIN_BLOCKSIZE	(SZ_2K)
+#else
+#define BTRFS_MIN_BLOCKSIZE	(SZ_4K)
+#endif
+
 #define BTRFS_LEAF_DATA_SIZE(fs_info) (fs_info->leaf_data_size)
 
 #define BTRFS_SUPER_INFO_OFFSET			(65536)
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index a4f91d10fa4e..b7d478007ae8 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1816,13 +1816,10 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		error("nodesize unaligned: %u", btrfs_super_nodesize(sb));
 		goto error_out;
 	}
-	if (btrfs_super_sectorsize(sb) < 4096) {
-		error("sectorsize too small: %u < 4096",
-			btrfs_super_sectorsize(sb));
-		goto error_out;
-	}
-	if (!IS_ALIGNED(btrfs_super_sectorsize(sb), 4096)) {
-		error("sectorsize unaligned: %u", btrfs_super_sectorsize(sb));
+	if (!is_power_of_2(btrfs_super_sectorsize(sb)) ||
+	    btrfs_super_sectorsize(sb) < BTRFS_MIN_BLOCKSIZE ||
+	    btrfs_super_sectorsize(sb) > BTRFS_MAX_METADATA_BLOCKSIZE) {
+		error("invalid sectorsize: %u", btrfs_super_sectorsize(sb));
 		goto error_out;
 	}
 	if (btrfs_super_total_bytes(sb) == 0) {
diff --git a/mkfs/main.c b/mkfs/main.c
index dc73de47a710..c7968540e8af 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1669,13 +1669,6 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	if (nodesize > sysconf(_SC_PAGE_SIZE))
 		features.incompat_flags |= BTRFS_FEATURE_INCOMPAT_BIG_METADATA;
 
-	if (sectorsize < sizeof(struct btrfs_super_block)) {
-		error("sectorsize smaller than superblock: %u < %zu",
-				sectorsize, sizeof(struct btrfs_super_block));
-		ret = 1;
-		goto error;
-	}
-
 	min_dev_size = btrfs_min_dev_size(nodesize, mixed,
 					  opt_zoned ? zone_size(file) : 0,
 					  metadata_profile, data_profile);
-- 
2.48.1


