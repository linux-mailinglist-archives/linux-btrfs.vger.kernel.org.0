Return-Path: <linux-btrfs+bounces-10545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A183A9F6207
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B096D168266
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA5E19D09C;
	Wed, 18 Dec 2024 09:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DWTmA0aE";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="DWTmA0aE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8119CC3D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514940; cv=none; b=gfqbuInZD673IqYJ6XBOCEQEfHHNqcWTb0I6Br7yehDkJFpKYuqNozywVekLhTbbEy9bPnSLBA/0BBN9QKC9UwoiQqsw8j7ox9harTpud0XZAwGOnrSf/z8bQPtNCGPfBalCst/BJ5FkygxC0mXm8DzuLLV0II8PJq4GL6D0yTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514940; c=relaxed/simple;
	bh=2bRYtWpYVMEDhJ5w0op9w1AI31z+hcs0P3Fq/PruFVE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OS0nBWxxgwsEXqd5Q6NIV11KxkfBj0uxxXM6DFQeaRMd6/2dDSNuOhrcgULLZL+i3lA3bbupu9uJKHlKhBN4YULGAq828ICkPmvsDp6Vabzv5mm9mhsoiGN3G0/D9U3A4kr2pL1fhIEEbOayTV+kG9TdKw4nVvEHyXtPrxUE4u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DWTmA0aE; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=DWTmA0aE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 145A02115F
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvLlTMcqwB5VyTOe4ov2s4BVV1z0//ravBaqD0TF1U0=;
	b=DWTmA0aE3ukmV9+RMofL00SCYqSPdPvKEWyBvtwTPrAso0ofe4xqf/eimZ0lYz3uhL5AyM
	/YfICvkEpn8xY41m10XUW0RnUOxHO5BjR2Jz/y0psC5uJZzEzfMRLypZK3CZn9Ygj2meJC
	AyJ8b9IGjANQ9KFTdKwH+JIoW2DBK0I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yvLlTMcqwB5VyTOe4ov2s4BVV1z0//ravBaqD0TF1U0=;
	b=DWTmA0aE3ukmV9+RMofL00SCYqSPdPvKEWyBvtwTPrAso0ofe4xqf/eimZ0lYz3uhL5AyM
	/YfICvkEpn8xY41m10XUW0RnUOxHO5BjR2Jz/y0psC5uJZzEzfMRLypZK3CZn9Ygj2meJC
	AyJ8b9IGjANQ9KFTdKwH+JIoW2DBK0I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41655132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wE8sAPeYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:15 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 17/18] btrfs: migrate btrfs_super_block::sectorsize to blocksize
Date: Wed, 18 Dec 2024 20:11:33 +1030
Message-ID: <ab8cdd215939cf260ac831f367735faebab42abc.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This is the rename of the on-disk format btrfs_super_block, which also
affects the accessors and a few callers.

To keep compatibility for old programs which may still access
btrfs_super_block::sectorsize, use a union so @blocksize and @sectorsize
can both access the same @blocksize value.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.h            |  4 ++--
 fs/btrfs/disk-io.c              |  4 ++--
 include/uapi/linux/btrfs_tree.h | 13 +++++++++++--
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index a796ec3fcb67..ecafbd6262cc 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -873,8 +873,8 @@ BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
 			 total_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(super_bytes_used, struct btrfs_super_block,
 			 bytes_used, 64);
-BTRFS_SETGET_STACK_FUNCS(super_sectorsize, struct btrfs_super_block,
-			 sectorsize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_blocksize, struct btrfs_super_block,
+			 blocksize, 32);
 BTRFS_SETGET_STACK_FUNCS(super_nodesize, struct btrfs_super_block,
 			 nodesize, 32);
 BTRFS_SETGET_STACK_FUNCS(super_stripesize, struct btrfs_super_block,
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index d3d2c9e2356a..9e6a1ea507d7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2341,7 +2341,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 			 const struct btrfs_super_block *sb, int mirror_num)
 {
 	u64 nodesize = btrfs_super_nodesize(sb);
-	u64 blocksize = btrfs_super_sectorsize(sb);
+	u64 blocksize = btrfs_super_blocksize(sb);
 	int ret = 0;
 	const bool ignore_flags = btrfs_test_opt(fs_info, IGNORESUPERFLAGS);
 
@@ -3310,7 +3310,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 
 	/* Set up fs_info before parsing mount options */
 	nodesize = btrfs_super_nodesize(disk_super);
-	blocksize = btrfs_super_sectorsize(disk_super);
+	blocksize = btrfs_super_blocksize(disk_super);
 	stripesize = blocksize;
 	fs_info->dirty_metadata_batch = nodesize * (1 + ilog2(nr_cpu_ids));
 	fs_info->delalloc_batch = blocksize * 512 * (1 + ilog2(nr_cpu_ids));
diff --git a/include/uapi/linux/btrfs_tree.h b/include/uapi/linux/btrfs_tree.h
index fc29d273845d..3fbefe00be4c 100644
--- a/include/uapi/linux/btrfs_tree.h
+++ b/include/uapi/linux/btrfs_tree.h
@@ -272,7 +272,7 @@
  * When a block group becomes very fragmented, we convert it to use bitmaps
  * instead of extents. A free space bitmap is keyed on
  * (start, FREE_SPACE_BITMAP, length); the corresponding item is a bitmap with
- * (length / sectorsize) bits.
+ * (length / blocksize) bits.
  */
 #define BTRFS_FREE_SPACE_BITMAP_KEY 200
 
@@ -690,7 +690,16 @@ struct btrfs_super_block {
 	__le64 bytes_used;
 	__le64 root_dir_objectid;
 	__le64 num_devices;
-	__le32 sectorsize;
+	union {
+		/*
+		 * The minimum data block size.
+		 *
+		 * Used to be called "sectorsize", but not recommended now.
+		 * Keep the old "sectorsize" just for old programs.
+		 */
+		__le32 blocksize;
+		__le32 sectorsize;
+	};
 	__le32 nodesize;
 	__le32 __unused_leafsize;
 	__le32 stripesize;
-- 
2.47.1


