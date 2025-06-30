Return-Path: <linux-btrfs+bounces-15075-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD34CAED3D1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074C53B305D
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745131A9B53;
	Mon, 30 Jun 2025 05:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HrwHeCy/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HrwHeCy/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132C1D5CDE
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261384; cv=none; b=E4LH1qAbwz2Owk32GdWouX+xCCw1L9H+Yj8NyEEFR+lgp9abQeTbZ65i4rF4txZxo8EzYKf2V+npmWGkO3xsUfhy5Iawhx+TTAawGn/HJGfGfVKt2Tgs0rKm5MDTwS7+K+Or5p/yKoV5x+wqtIFB3n/3qD9K23vIYtLFunzcdiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261384; c=relaxed/simple;
	bh=CaltupJqoHdWeBFdJWZQqK4/MyfkLN2JpxDqpGS8sGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=on/reDpywCyioYw6HAKGX2JZ/k841Lf04w2s0YwQ0tX2FvGsXjezLWliHKxkstqLvcBfkyuxJuUE7JHcSz4cqyFLzMICZkHmvl1Y2jAuuZXKjsjOD44uYp2AAtlGCuE1m82hyP8k5h95WvUhRRJErgipORh3HtvDWGoFfZruYgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HrwHeCy/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HrwHeCy/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18C8621161;
	Mon, 30 Jun 2025 05:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN6EQV/esiBlao2ILv/BoJ01mq1VFShO7VV8/ABGkDg=;
	b=HrwHeCy/4Q9V40GFExHhux/ISPC0YFyXBpakdlUIBDHzSciq+Fr8I4WRPnZemqtibuje38
	UwGVQ4Q+ykzb1sBKjkNW3AsxiPkwrjT476wyW/I9t2/9B1Do46ere6vByN8K6ZhvUx9cUo
	IImb6zTpBbTBiA3DrEOyarfprqAiuzA=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zN6EQV/esiBlao2ILv/BoJ01mq1VFShO7VV8/ABGkDg=;
	b=HrwHeCy/4Q9V40GFExHhux/ISPC0YFyXBpakdlUIBDHzSciq+Fr8I4WRPnZemqtibuje38
	UwGVQ4Q+ykzb1sBKjkNW3AsxiPkwrjT476wyW/I9t2/9B1Do46ere6vByN8K6ZhvUx9cUo
	IImb6zTpBbTBiA3DrEOyarfprqAiuzA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0575139D4;
	Mon, 30 Jun 2025 05:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OAZvILwgYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 30 Jun 2025 05:29:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 1/8] btrfs: always open the device read-only in btrfs_scan_one_device
Date: Mon, 30 Jun 2025 14:59:05 +0930
Message-ID: <42e8aad163560fe828473cdf34b9e6d3f4237f1e.1751261286.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751261286.git.wqu@suse.com>
References: <cover.1751261286.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.973];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.79

From: Christoph Hellwig <hch@lst.de>

btrfs_scan_one_device opens the block device only to read the super
block.  Instead of passing a blk_mode_t argument to sometimes open
it for writing, just hard code BLK_OPEN_READ as it will never write
to the device or hand the block_device out to someone else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/super.c   | 9 ++++-----
 fs/btrfs/volumes.c | 4 ++--
 fs/btrfs/volumes.h | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2d0d8c6e77b4..b9e08a59da4e 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -364,10 +364,9 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		break;
 	case Opt_device: {
 		struct btrfs_device *device;
-		blk_mode_t mode = btrfs_open_mode(fc);
 
 		mutex_lock(&uuid_mutex);
-		device = btrfs_scan_one_device(param->string, mode, false);
+		device = btrfs_scan_one_device(param->string, false);
 		mutex_unlock(&uuid_mutex);
 		if (IS_ERR(device))
 			return PTR_ERR(device);
@@ -1855,7 +1854,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
 	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
 	 * either a valid device or an error.
 	 */
-	device = btrfs_scan_one_device(fc->source, mode, true);
+	device = btrfs_scan_one_device(fc->source, true);
 	ASSERT(device != NULL);
 	if (IS_ERR(device)) {
 		mutex_unlock(&uuid_mutex);
@@ -2233,7 +2232,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		ret = PTR_ERR_OR_ZERO(device);
 		mutex_unlock(&uuid_mutex);
 		break;
@@ -2251,7 +2250,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		 * Scanning outside of mount can return NULL which would turn
 		 * into 0 error code.
 		 */
-		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
+		device = btrfs_scan_one_device(vol->name, false);
 		if (IS_ERR_OR_NULL(device)) {
 			mutex_unlock(&uuid_mutex);
 			if (IS_ERR(device))
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index c99aec904e16..bb63729770d9 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1441,7 +1441,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
  * the device or return an error. Multi-device and seeding devices are registered
  * in both cases.
  */
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev)
 {
 	struct btrfs_super_block *disk_super;
@@ -1462,7 +1462,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	 * values temporarily, as the device paths of the fsid are the only
 	 * required information for assembling the volume.
 	 */
-	bdev_file = bdev_file_open_by_path(path, flags, NULL, NULL);
+	bdev_file = bdev_file_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
 	if (IS_ERR(bdev_file))
 		return ERR_CAST(bdev_file);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6d8b1f38e3ee..afa71d315c46 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -719,7 +719,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
 void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
 int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
-struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
+struct btrfs_device *btrfs_scan_one_device(const char *path,
 					   bool mount_arg_dev);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
-- 
2.50.0


