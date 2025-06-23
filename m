Return-Path: <linux-btrfs+bounces-14861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE68AAE3D3D
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 12:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B199516950F
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 10:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34F6136988;
	Mon, 23 Jun 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rkr8EEYe";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="rkr8EEYe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566A2192E3
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675645; cv=none; b=Ncd1GM3Mr9nLb89BxJkHWRk8IWLvfz8X0LAk59H3p2qUlItuN+AFtgshoJdRDN9CnCN6NIC4tjlF3g9va5q8cgei5AkOymHpTOS8zhMB9NbbWjZ+e+PL9vQeYeMtxqbtFfVyxCD5ecoXh3Jsk5ZdaB6/qsEELfCe2I1v8Y4eOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675645; c=relaxed/simple;
	bh=StuSd1FIsn1fBr6nGm8S1WHL7svukOv5nRI1JPBPgNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phCqKTmlqZTnXaS7ivI7PNuQhhuKcbmhYaAjF2L02Kt96MVNKKu/g6QXZYYxowFP8/BJ8S2PlL/Vf9TdW+ARueFjz+1Z0oHOtQZfjSMU00uojBVB3eDxgKI8iEdByoRWmtFlBtIlQXYpyWJ8R2QPHnGFl0HFyjWvHVLGXFOvrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rkr8EEYe; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=rkr8EEYe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3EC441F444;
	Mon, 23 Jun 2025 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNNvWJ5heX9tb68PxZg7w36Ewu7DHrqFm1m676mhZz4=;
	b=rkr8EEYe2jY/kccx1sGCgX3Ww+x4xdMd/DwJ1yFP5Mqc4jWVc/ugUR0xcnUKkyNqiBliwY
	BgCaMnVvMEe8sesczTI3vDVAqF6mEGRT5AHsfuI/O1XF02BDcgS1djcSE7SD0RCMdUgncv
	UdWxjnELMoDpytYnumLbvh6izcGS8n8=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750675626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNNvWJ5heX9tb68PxZg7w36Ewu7DHrqFm1m676mhZz4=;
	b=rkr8EEYe2jY/kccx1sGCgX3Ww+x4xdMd/DwJ1yFP5Mqc4jWVc/ugUR0xcnUKkyNqiBliwY
	BgCaMnVvMEe8sesczTI3vDVAqF6mEGRT5AHsfuI/O1XF02BDcgS1djcSE7SD0RCMdUgncv
	UdWxjnELMoDpytYnumLbvh6izcGS8n8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B2A213485;
	Mon, 23 Jun 2025 10:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uPsvMKgwWWgeJAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 23 Jun 2025 10:47:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v4 7/8] btrfs: use the super_block as holder when mounting file systems
Date: Mon, 23 Jun 2025 20:16:51 +0930
Message-ID: <cccfc0d1f0508230028947d5ed1e81542ffdbbea.1750674924.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750674924.git.wqu@suse.com>
References: <cover.1750674924.git.wqu@suse.com>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

From: Christoph Hellwig <hch@lst.de>

The file system type is not a very useful holder as it doesn't allow us
to go back to the actual file system instance.  Pass the super_block
instead which is useful when passed back to the file system driver.

This matches what is done for all other block device based file systems,
and allows us to remove btrfs_fs_info::bdev_holder completely.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 fs/btrfs/fs.h          | 2 --
 fs/btrfs/super.c       | 3 +--
 fs/btrfs/volumes.c     | 4 ++--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 6576867cc1e9..c23847de4e99 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					   fs_info->sb, NULL);
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
index b430631da647..5a07330fb3a6 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1920,7 +1920,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 
 		mutex_lock(&uuid_mutex);
 		btrfs_fs_devices_dec_holding(fs_devices);
-		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		ret = btrfs_open_devices(fs_devices, mode, sb);
 		mutex_unlock(&uuid_mutex);
 		if (ret < 0) {
 			deactivate_locked_super(sb);
@@ -1933,7 +1933,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		bdev = fs_devices->latest_dev->bdev;
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices);
 		if (ret) {
 			deactivate_locked_super(sb);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index f02551f65366..8c91511ed433 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2706,7 +2706,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					   fs_info->sb, NULL);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
@@ -7175,7 +7175,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
+	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->sb);
 	if (ret) {
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
-- 
2.49.0


