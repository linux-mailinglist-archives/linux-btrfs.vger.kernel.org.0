Return-Path: <linux-btrfs+bounces-14520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E293ACFC4C
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 07:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC761189615A
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Jun 2025 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B41D5AC0;
	Fri,  6 Jun 2025 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XoE60Gp1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XoE60Gp1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314110E0
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749188866; cv=none; b=innjnEUDUSAjkcZJcTXlGdLz7+SErKbfRn67F3Xo1E13tddoNFIc8tW9E1i49DwC7cengrdxjn/a06dmjRXrfa1hU2Fw8KXBSr4Azi9tny2UTXh8nxVI+MfWeSSfMa+aOKMEmn9P9RyisBiij+EfucVnMEoEeRGCGcHm+WSm6pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749188866; c=relaxed/simple;
	bh=iLosmTGhN3tu+tBL+wXxxCRCz+5acr8gPY4tiKm9IUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkFmztYVnA8o8nDqAWFDz2DP4YCFFihGuH6lrXY2/5xPsVaHcXHKtV1B2eW0fhcED/K+smGO/cobaF/ytzvYou+MWj7YnUEcFiyGD7BC+6LG4L3v7GHhUdLValw952MIUF3wDXH60VcRYHL9Y6W1dPfytcT3hwcgtE+b2Vxg7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XoE60Gp1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XoE60Gp1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E785336BC
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749188856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceOnwKvRdddcgmVVkoGokp/1me+Ms2rC7tIzVFAxvaM=;
	b=XoE60Gp1ciICVT69mzbVXwr0BFvxKPo8InWe/uTMf9/VUnuf56WF8nNKJlzo2RtlQoiaGx
	qGtCfRkaBazU3tenn4PpKWZfBUBsJzP2tNBTuOIn3eRpMr4AzA8Slm7BPIbxS/WI0lJ87Z
	nJa/Y3o/VEj7SAOYvdpKk3IttUyGnzA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749188856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceOnwKvRdddcgmVVkoGokp/1me+Ms2rC7tIzVFAxvaM=;
	b=XoE60Gp1ciICVT69mzbVXwr0BFvxKPo8InWe/uTMf9/VUnuf56WF8nNKJlzo2RtlQoiaGx
	qGtCfRkaBazU3tenn4PpKWZfBUBsJzP2tNBTuOIn3eRpMr4AzA8Slm7BPIbxS/WI0lJ87Z
	nJa/Y3o/VEj7SAOYvdpKk3IttUyGnzA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6AF7D1336F
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Jun 2025 05:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WCONC/eAQmjsTwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 06 Jun 2025 05:47:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: use fs_info as the block device holder
Date: Fri,  6 Jun 2025 15:17:15 +0930
Message-ID: <23c84ea3b4c08ba01e8a189fed58a06a0760d018.1749188673.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749188673.git.wqu@suse.com>
References: <cover.1749188673.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

Currently btrfs uses "btrfs_fs_type" as the bdev holder for all opened
device, which means all btrfses shares the same holder value.

That's only fine when there is no blk_holder_ops provided, but we're
going to implement blk_holder_ops soon, so replace the "btrfs_fs_type"
holder usage, and replace it with a proper fs_info instead.

This means we can remove the btrfs_fs_info::bdev_holder completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 fs/btrfs/fs.h          | 2 --
 fs/btrfs/super.c       | 3 +--
 fs/btrfs/volumes.c     | 4 ++--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 2decb9fff445..cf63f4b29327 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					   fs_info, NULL);
 	if (IS_ERR(bdev_file)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev_file);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b239e4b8421c..d90304d4e32c 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -715,8 +715,6 @@ struct btrfs_fs_info {
 	u32 data_chunk_allocations;
 	u32 metadata_ratio;
 
-	void *bdev_holder;
-
 	/* Private scrub information */
 	struct mutex scrub_lock;
 	atomic_t scrubs_running;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2d0d8c6e77b4..c1efd20166cc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1865,7 +1865,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	fs_devices = device->fs_devices;
 	fs_info->fs_devices = fs_devices;
 
-	ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+	ret = btrfs_open_devices(fs_devices, mode, fs_info);
 	mutex_unlock(&uuid_mutex);
 	if (ret)
 		return ret;
@@ -1905,7 +1905,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	} else {
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices);
 		if (ret) {
 			deactivate_locked_super(sb);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1535a425e8f9..dae946ee6b07 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2705,7 +2705,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					   fs_info, NULL);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
@@ -7174,7 +7174,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
+	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info);
 	if (ret) {
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
-- 
2.49.0


