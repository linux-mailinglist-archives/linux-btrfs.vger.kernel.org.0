Return-Path: <linux-btrfs+bounces-14705-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C8EADC182
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 07:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFE41891645
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Jun 2025 05:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3723B63F;
	Tue, 17 Jun 2025 05:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R1dy20NG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R1dy20NG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F19723B634
	for <linux-btrfs@vger.kernel.org>; Tue, 17 Jun 2025 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750137629; cv=none; b=eRa/41kQRNIetrVsDJIaQWh0LaC/P10oVR1+72nqhimpkJQTzC+hRSZJF6KNmkNARzmtNf6eKahU9/865jDKcnaBxz3oGbAf/V5E/Jg1KpU5axh/EEnTzqIGOyFpA9am7zlTEXdVVNp0dWsfuIOyXabyFjOr2Jsfs/w4+9vbZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750137629; c=relaxed/simple;
	bh=9lfw7hJ+pK1bJHky9wdY+OFj1rseW5qGiK+2SQFINKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ep9OjVP9Dr69I4pwYibz8+7cfPwptnZS5Tcx4JP+l4gPjOSR6eV0QryPFsZkoCBuW0nDeaxP4H2XM2W5EpxEe0x+wcjlOMFpQceWuq2Ojt+zkPeULLZDEDwS6ZhHaFwrq2ZxHb3GgTOP2npOIMB4FGlgDyuqHNmMsgkIYybuCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R1dy20NG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R1dy20NG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9E252115A;
	Tue, 17 Jun 2025 05:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4jSXUa/moTOL/8iQQgvtPZVzl355Etn7QNYiWqiGCc=;
	b=R1dy20NGFGxuKYqtDgO0pBYdY6Zxvu0YWr/X0i/SvX1YABU+KQr5lB669EE2jI0CUhTntp
	AI38j2STbKQNieX+qfDijlkuPIfBLAPzpB2EmhZQpy8QQ+RWalcZxi1OIq+okWx9QlVL4f
	5NQzZyGAHDhvO3wmQum5x7/HsQPBRrI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750137610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4jSXUa/moTOL/8iQQgvtPZVzl355Etn7QNYiWqiGCc=;
	b=R1dy20NGFGxuKYqtDgO0pBYdY6Zxvu0YWr/X0i/SvX1YABU+KQr5lB669EE2jI0CUhTntp
	AI38j2STbKQNieX+qfDijlkuPIfBLAPzpB2EmhZQpy8QQ+RWalcZxi1OIq+okWx9QlVL4f
	5NQzZyGAHDhvO3wmQum5x7/HsQPBRrI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E06F139E2;
	Tue, 17 Jun 2025 05:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OFUYFAn7UGgePwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 17 Jun 2025 05:20:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 6/6] btrfs: use the super_block as holder when mounting file systems
Date: Tue, 17 Jun 2025 14:49:39 +0930
Message-ID: <8f16de6ed794f843c7059a8514958db2763352ea.1750137547.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750137547.git.wqu@suse.com>
References: <cover.1750137547.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

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
index 36c9df82efdf..82ce0625b2f0 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1905,7 +1905,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		 */
 		ASSERT(fc->s_fs_info == NULL);
 
-		ret = btrfs_open_devices(fs_devices, mode, &btrfs_fs_type);
+		ret = btrfs_open_devices(fs_devices, mode, sb);
 		mutex_unlock(&uuid_mutex);
 		if (ret < 0) {
 			deactivate_locked_super(sb);
@@ -1918,7 +1918,6 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 		bdev = fs_devices->latest_dev->bdev;
 		snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
 		shrinker_debugfs_rename(sb->s_shrink, "sb-btrfs:%s", sb->s_id);
-		btrfs_sb(sb)->bdev_holder = &btrfs_fs_type;
 		ret = btrfs_fill_super(sb, fs_devices);
 		if (ret) {
 			deactivate_locked_super(sb);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3e701790dde9..c0e34a717f37 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2705,7 +2705,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					fs_info->bdev_holder, NULL);
+					   fs_info->sb, NULL);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
@@ -7174,7 +7174,7 @@ static struct btrfs_fs_devices *open_seed_devices(struct btrfs_fs_info *fs_info,
 	if (IS_ERR(fs_devices))
 		return fs_devices;
 
-	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->bdev_holder);
+	ret = open_fs_devices(fs_devices, BLK_OPEN_READ, fs_info->sb);
 	if (ret) {
 		free_fs_devices(fs_devices);
 		return ERR_PTR(ret);
-- 
2.49.0


