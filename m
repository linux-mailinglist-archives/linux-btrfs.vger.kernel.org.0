Return-Path: <linux-btrfs+bounces-14972-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB1CAE930B
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 01:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC5BE6A40C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 23:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37F2D3EDA;
	Wed, 25 Jun 2025 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kbfCIqYa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kbfCIqYa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2F28725E
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750895672; cv=none; b=qL9UoJeXREFs8QJSbCBjDwsGHQ7t4KDmnGfCJHCHVnJsz8vGZIbcHn7nh+oAz4VPcZ5gwoCsVV2IA5riE0oA8nCWAgEwGFIOgj+CP2IWgrkgO925G0F/JrO0cOkGqOtI7wtjO0h/TiBEV7ZHEGMr7uVcrRmttoBfkKJRkN28OLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750895672; c=relaxed/simple;
	bh=9IFOekyyrJAsQ83LLlEIUIiBhRL1t0U+yqG89JhuyJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qsCajrVbzWAluTazhfQOZJHy5HR32xwO+/W/FiwdzdUsmO828IAuC5pcDFMa53VM9lkZx0km+lV5A7hHvQqdQ0d+NCHZ08PUjdLtlWN06+lV6A6/UBF4ey2sKMB6axKB4tjTzvaWGdX7O8SjZ680W/rAyWSCwknwW74TocltF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kbfCIqYa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kbfCIqYa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96B091F74B;
	Wed, 25 Jun 2025 23:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OJDuOAucoGetuYe9by+q0ny/viGKwuWVtXz75n3hbE=;
	b=kbfCIqYawjeeHpZjBRGbuLf2tahsdvkpE79Yy7f8uo10ezr0oXcIlu786lR4jTOP/QWixd
	OwpeoqGtwMZrYK8fn4N56t9M+2rP7baCE/ouUz92yZaaMOJLSIiKhPzF+4PoUgNpHsxhmW
	MXjVIL7rWg2KdGXaJxAH7pRqbOubXFQ=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750895660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OJDuOAucoGetuYe9by+q0ny/viGKwuWVtXz75n3hbE=;
	b=kbfCIqYawjeeHpZjBRGbuLf2tahsdvkpE79Yy7f8uo10ezr0oXcIlu786lR4jTOP/QWixd
	OwpeoqGtwMZrYK8fn4N56t9M+2rP7baCE/ouUz92yZaaMOJLSIiKhPzF+4PoUgNpHsxhmW
	MXjVIL7rWg2KdGXaJxAH7pRqbOubXFQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA95B13301;
	Wed, 25 Jun 2025 23:54:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJfgJiqMXGjQMAAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 25 Jun 2025 23:54:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Subject: [PATCH 6/6] btrfs: implement remove_bdev super operation callback
Date: Thu, 26 Jun 2025 09:23:47 +0930
Message-ID: <86186e83b1b67d5767c0064b0dc638efc006d019.1750895337.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750895337.git.wqu@suse.com>
References: <cover.1750895337.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

For this callback, btrfs will:

- Go degraded if the fs can still maintain RW operations
  And of course mark the target device as missing.

- Shutdown if the fs can not maintain RW operations

I know the shutdown can be a little overkilled, if one has a RAID1
metadata and RAID0 data, in that case one can still read data with 50%
rate to got some good data.

But it can also be as bad as the only device went missing for a single
device btrfs.

So here we go safe other than sorry when handling missing device.

And the remove_bdev callback will be hidden behind experimental features
for now, the reasons are:

- There are not enough btrfs specific bdev removal test cases
  The existing test cases are all removing the only device, thus only
  exercises the shutdown branch.

- Not yet determined what's the expected behavior
  Although the current auto-degrade behavior is no worse than the old
  behavior, it may not always be what the end users want.

  Before there is a concrete solution, better hide the new feature
  from end users.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.c |  2 ++
 fs/btrfs/volumes.h |  5 +++++
 3 files changed, 62 insertions(+)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 5a07330fb3a6..3fba3d6309a2 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2412,6 +2412,58 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	return 0;
 }
 
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+static void btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev,
+			      bool surprise)
+{
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+	struct btrfs_device *device;
+	struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
+	bool can_rw;
+	int ret;
+
+	if (!surprise) {
+		ret = btrfs_sync_fs(sb, 1);
+		if (ret)
+			btrfs_warn(fs_info,
+			"filesystem failed to sync in preparation for device loss: %d",
+				   ret);
+	}
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
+	if (!device) {
+		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
+			   bdev);
+		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+		return;
+	}
+	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	device->fs_devices->missing_devices++;
+	if (test_and_clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+		list_del_init(&device->dev_alloc_list);
+		device->fs_devices->rw_devices--;
+	}
+	can_rw = btrfs_check_rw_degradable(fs_info, device);
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	/*
+	 * Now device is considered missing, btrfs_device_name() won't give a
+	 * meaningful result anymore.
+	 */
+	if (!can_rw) {
+		btrfs_warn(fs_info,
+		"btrfs device id %llu has gone missing, can not maintain read-write",
+			   device->devid);
+		btrfs_force_shutdown(fs_info);
+		return;
+	}
+	btrfs_warn(fs_info,
+		   "btrfs device id %llu has gone missing, continue as degraded",
+		   device->devid);
+	btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+}
+#endif
+
 static const struct super_operations btrfs_super_ops = {
 	.drop_inode	= btrfs_drop_inode,
 	.evict_inode	= btrfs_evict_inode,
@@ -2427,6 +2479,9 @@ static const struct super_operations btrfs_super_ops = {
 	.unfreeze_fs	= btrfs_unfreeze,
 	.nr_cached_objects = btrfs_nr_cached_objects,
 	.free_cached_objects = btrfs_free_cached_objects,
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	.remove_bdev	= btrfs_remove_bdev,
+#endif
 };
 
 static const struct file_operations btrfs_ctl_fops = {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8ea1a69808a3..8feac0129bdd 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6794,6 +6794,8 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 				  const struct btrfs_device *device)
 {
+	if (args->devt)
+		return device->devt == args->devt;
 	if (args->missing) {
 		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
 		    !device->bdev)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 6acb154ccf87..71e570f8337d 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -663,6 +663,11 @@ struct btrfs_dev_lookup_args {
 	u64 devid;
 	u8 *uuid;
 	u8 *fsid;
+	/*
+	 * If devt is specified, all other members will be ignored as it is
+	 * enough to uniquely locate a device.
+	 */
+	dev_t devt;
 	bool missing;
 };
 
-- 
2.49.0


