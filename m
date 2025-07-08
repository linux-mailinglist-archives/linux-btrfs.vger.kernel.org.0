Return-Path: <linux-btrfs+bounces-15318-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8568CAFC6AC
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 11:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CED07A17E1
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 09:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32522BF01F;
	Tue,  8 Jul 2025 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="IMbyJvgM";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BycSCwBc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394CF217F26
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 09:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965622; cv=none; b=rosuY73fP5DrvNbdkni/rbU/1CxJMTgoqwX74nqw7KelHzZaFuXPtyYV5QMdUQ34fcDkewkViolHGdX1E1LyU8XmPxwF8gZgUHM0QT6PU1CnKjJ/93YubUMve8FU6wNpU5AsVcwkHJsXtgng4ZNweDWbJJluj2iO+hVsFC0VWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965622; c=relaxed/simple;
	bh=YPPlbHkV5O6mbd2Lp8M+/9P+7ISrln89dNjgAFk1v18=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcBpfVSbdJG/h799OsxM2iG+nnAMWZWoJFaY3OVRMDsV+Qsjz6PFtyE3vhX/kkaaCoIBBj1/qm2ghPlsy72T8+dUFb+txKd57eaLuAm0rZGCpI9wzlX1eJxli879cIlRw4lK4We+963G8SZ4fDp7riIlALTkxjVha33+i5kp8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=IMbyJvgM; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BycSCwBc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED6BC1F45E
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751965613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VDAED4K6XfZOnPTIIve4aiVDxwTMyQyLoCFSdAlaBs=;
	b=IMbyJvgMKO0BckHcjIEW7m9CnZJAiZGOpxvMKxRNAGWZzP/RsaJ/VXNpi8SAg4N2GRIls/
	nzrONMUuDvDkMYoYIZgHzYMVtTw7Xy9ZrAeGRdtfj89xDjuLOkH8+PruIXO2jim9vfEyO+
	lvwyTr6/4jLZrzKLUZk9W9U58mtDyHc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=BycSCwBc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751965612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3VDAED4K6XfZOnPTIIve4aiVDxwTMyQyLoCFSdAlaBs=;
	b=BycSCwBcwny3eNvVAsjjivGlqv/thm00Sx2/F09amRIHklSLyBnvYm7enXUxBaUgj9OsQC
	3eXMIQPJ3rJo899BJZzd9Rsl5pwoUqjdsQdxNRHRoFth9QGNvNPfEoibW2LUVAZhXcM/wR
	wO00apSJmpepmY+w2QnQSzx7toUhxJA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3673013A68
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 09:06:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GKVnOqvfbGgiYwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 08 Jul 2025 09:06:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/2] btrfs: use bdev_rw_virt() to read and scratch the disk super block
Date: Tue,  8 Jul 2025 18:36:32 +0930
Message-ID: <4726b5e8f9eb9eb985afb3a34f9e76ab7eadd1ed.1751965333.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751965333.git.wqu@suse.com>
References: <cover.1751965333.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: ED6BC1F45E
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

Currently we're using the block device page cache to read and scratch
the super block.

This makes btrfs to poking into lower layer unnecessarily.

Change both btrfs_read_disk_super() and btrfs_scratch_superblock() to
kmalloc() + bdev_rw_virt() to do the read and write.

This allows btrfs_release_disk_super() to be a simple wrapper of
kfree().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 46 +++++++++++++++++++++-------------------------
 fs/btrfs/volumes.h |  5 ++++-
 2 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 31aecd291d6c..47f11e3c4a98 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1326,18 +1326,10 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 	return ret;
 }
 
-void btrfs_release_disk_super(struct btrfs_super_block *super)
-{
-	struct page *page = virt_to_page(super);
-
-	put_page(page);
-}
-
 struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 						int copy_num, bool drop_cache)
 {
 	struct btrfs_super_block *super;
-	struct page *page;
 	u64 bytenr, bytenr_orig;
 	struct address_space *mapping = bdev->bd_mapping;
 	int ret;
@@ -1362,14 +1354,19 @@ struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 		 * always read from the device.
 		 */
 		invalidate_inode_pages2_range(mapping, bytenr >> PAGE_SHIFT,
-				      (bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
+					(bytenr + BTRFS_SUPER_INFO_SIZE) >> PAGE_SHIFT);
 	}
 
-	page = read_cache_page_gfp(mapping, bytenr >> PAGE_SHIFT, GFP_NOFS);
-	if (IS_ERR(page))
-		return ERR_CAST(page);
+	super = kmalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+	if (!super)
+		return ERR_PTR(-ENOMEM);
+	ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super, BTRFS_SUPER_INFO_SIZE,
+			   REQ_OP_READ);
+	if (ret < 0) {
+		btrfs_release_disk_super(super);
+		return ERR_PTR(ret);
+	}
 
-	super = page_address(page);
 	if (btrfs_super_magic(super) != BTRFS_MAGIC ||
 	    btrfs_super_bytenr(super) != bytenr_orig) {
 		btrfs_release_disk_super(super);
@@ -2134,21 +2131,20 @@ static u64 btrfs_num_devices(struct btrfs_fs_info *fs_info)
 static void btrfs_scratch_superblock(struct btrfs_fs_info *fs_info,
 				     struct block_device *bdev, int copy_num)
 {
-	struct btrfs_super_block *disk_super;
-	const size_t len = sizeof(disk_super->magic);
+	struct btrfs_super_block *super;
 	const u64 bytenr = btrfs_sb_offset(copy_num);
 	int ret;
 
-	disk_super = btrfs_read_disk_super(bdev, copy_num, false);
-	if (IS_ERR(disk_super))
-		return;
-
-	memset(&disk_super->magic, 0, len);
-	folio_mark_dirty(virt_to_folio(disk_super));
-	btrfs_release_disk_super(disk_super);
-
-	ret = sync_blockdev_range(bdev, bytenr, bytenr + len - 1);
-	if (ret)
+	super = kzalloc(BTRFS_SUPER_INFO_SIZE, GFP_KERNEL);
+	if (!super) {
+		ret = -ENOMEM;
+		goto out;
+	}
+	ret = bdev_rw_virt(bdev, bytenr >> SECTOR_SHIFT, super,
+			   BTRFS_SUPER_INFO_SIZE, REQ_OP_WRITE);
+out:
+	btrfs_release_disk_super(super);
+	if (ret < 0)
 		btrfs_warn(fs_info, "error clearing superblock number %d (%d)",
 			copy_num, ret);
 }
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7395cb5e1238..d3b65f66a691 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -799,7 +799,10 @@ struct btrfs_chunk_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 void btrfs_remove_chunk_map(struct btrfs_fs_info *fs_info, struct btrfs_chunk_map *map);
 struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev,
 						int copy_num, bool drop_cache);
-void btrfs_release_disk_super(struct btrfs_super_block *super);
+static inline void btrfs_release_disk_super(struct btrfs_super_block *super)
+{
+	kfree(super);
+}
 
 static inline void btrfs_dev_stat_inc(struct btrfs_device *dev,
 				      int index)
-- 
2.50.0


