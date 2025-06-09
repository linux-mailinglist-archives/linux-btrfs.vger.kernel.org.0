Return-Path: <linux-btrfs+bounces-14553-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7E8AD1841
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 07:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D46C1889CBD
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 05:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15722201266;
	Mon,  9 Jun 2025 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSYJA8/h";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSYJA8/h"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997AC19258E
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749446423; cv=none; b=MiX5Tsgi57WUhRgsyBW0U9Eed/QAPx/tGR9REG9nnu2941cUySpftaILi0RTa7tvpLT04jc7CyBkU+TJpTh+cRhEL279UYgFuPhDOUGnb7XOu6/L2X0pzvzr24C5O7IB9PkZ9t7s9Ts4SFBD3ijKIJSqc729SKuRpmqwxru/Djc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749446423; c=relaxed/simple;
	bh=/YrYQds7uJprdefRamu79NgWKqJuldIqqNObEYoAMuo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YIrh8DvyUkQpky5Uk4SymhyqkSJFfP31p72riN9cdNyf3c6/HqcPzlekp/nwEVbouty3Zz4FSz6bp1S9fMb07jJU2KeiTe/wV78QK7zgvWteFApbldeyajA7mGMUrUxJibYdAk/b2r4ZBA5zuHtXcn3u+OywrdUe77d8CO579hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iSYJA8/h; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iSYJA8/h; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8628F2118B
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8/Aqp6eRECMa5w3VWraUJpp81BIr8muVGdP16gI7rA=;
	b=iSYJA8/hdr1n5ZmzjS8ku73+1S/PUGzHM/cGzdRU3N3xKZbWka3kqaSmj1JqNfE7yKtTiY
	xxve0R6OG8B5mYbEfTuylT2OlhjUyCRS8f5KetOdvfSEZ4vUDG/tLJwIEClO35ryN10uCa
	ypRytBHN04/ck6n5iQaORhqssruGlKs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="iSYJA8/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749446413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8/Aqp6eRECMa5w3VWraUJpp81BIr8muVGdP16gI7rA=;
	b=iSYJA8/hdr1n5ZmzjS8ku73+1S/PUGzHM/cGzdRU3N3xKZbWka3kqaSmj1JqNfE7yKtTiY
	xxve0R6OG8B5mYbEfTuylT2OlhjUyCRS8f5KetOdvfSEZ4vUDG/tLJwIEClO35ryN10uCa
	ypRytBHN04/ck6n5iQaORhqssruGlKs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0D15137FE
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 05:20:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOF8IAxvRmjqVQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 09 Jun 2025 05:20:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: add a simple dead device detection mechanism
Date: Mon,  9 Jun 2025 14:49:50 +0930
Message-ID: <d1f020881e3b11e167df8487bfdabf9f61455c38.1749446257.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749446257.git.wqu@suse.com>
References: <cover.1749446257.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 8628F2118B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01

Currently btrfs always detect missing devices at mount time, and lacks a
way to detect a dead device at runtime.

This makes btrfs to treat intentionally or unintentionally removed
device as usual, making test case generic/730 to fail as btrfs still
return the cached data from page cache.
(The root cause is btrfs has no shutdown support for test cases
requiring shutdown)

Add a very basic and simple dead device detection mechanism for btrfs,
which includes:

- Output an info/warning message
  If the devices is not removed by surprise, the log level is info.

  The message will include the device id, device path.

- Mark that devices as missing and mark the fs degraded

- If the fs can not maintain RW operations, mark the fs as error
  So the fs is fully read-only, prevent further corruption.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |  5 +++++
 2 files changed, 53 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d7cfc883c834..f3b3bb652cfc 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -332,7 +332,52 @@ static int btrfs_bdev_unfreeze(struct block_device *bdev)
 	return ret;
 }
 
+static void btrfs_bdev_mark_dead(struct block_device *bdev, bool surprise)
+{
+	struct btrfs_fs_info *fs_info = get_bdev_fs_info(bdev);
+	struct btrfs_dev_lookup_args args = { .devt = bdev->bd_dev, };
+	struct btrfs_device *device;
+
+	if (!fs_info)
+		return;
+
+	mutex_lock(&fs_info->fs_devices->device_list_mutex);
+	device = btrfs_find_device(fs_info->fs_devices, &args);
+	if (unlikely(!device)) {
+		btrfs_crit(fs_info, "can't find a btrfs_device for %pg", bdev);
+		goto out;
+	}
+	if (surprise)
+		btrfs_warn_in_rcu(fs_info, "devid %llu device %pg path %s is dead",
+				  device->devid, device->bdev, btrfs_dev_name(device));
+	else
+		btrfs_info_in_rcu(fs_info, "devid %llu device %pg path %s is going to be removed",
+				  device->devid, device->bdev, btrfs_dev_name(device));
+	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	device->fs_devices->missing_devices++;
+	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+		list_del_init(&device->dev_alloc_list);
+		clear_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
+		device->fs_devices->rw_devices--;
+	}
+	/*
+	 * If we can no longer maintain the RW opeartions for the fs, mark the
+	 * fs error.
+	 */
+	if (!btrfs_check_rw_degradable(fs_info, device)) {
+		btrfs_handle_fs_error(fs_info, -EIO,
+			"btrfs can no longer maintain read-write due to missing device(s)");
+	} else  {
+		btrfs_set_opt(fs_info->mount_opt, DEGRADED);
+		btrfs_warn(fs_info, "filesystem degraded due to missing device(s)");
+	}
+out:
+	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
+	put_bdev_fs_info(fs_info);
+}
+
 const struct blk_holder_ops btrfs_bdev_ops = {
+	.mark_dead = btrfs_bdev_mark_dead,
 	.sync = btrfs_bdev_sync,
 	.freeze = btrfs_bdev_freeze,
 	.thaw = btrfs_bdev_unfreeze,
@@ -6874,6 +6919,9 @@ static bool dev_args_match_fs_devices(const struct btrfs_dev_lookup_args *args,
 static bool dev_args_match_device(const struct btrfs_dev_lookup_args *args,
 				  const struct btrfs_device *device)
 {
+	if (args->devt)
+		return device->devt == args->devt;
+
 	if (args->missing) {
 		if (test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state) &&
 		    !device->bdev)
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index b4b8adc80e52..e2c453e230a0 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -651,6 +651,11 @@ struct btrfs_balance_control {
  */
 struct btrfs_dev_lookup_args {
 	u64 devid;
+	/*
+	 * If @devt is set (non-zero), then other args will be ignored since the
+	 * non-zero dev_t can locate the device uniquely.
+	 */
+	dev_t devt;
 	u8 *uuid;
 	u8 *fsid;
 	bool missing;
-- 
2.49.0


