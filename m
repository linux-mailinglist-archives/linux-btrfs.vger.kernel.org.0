Return-Path: <linux-btrfs+bounces-15079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF8CAED3D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 07:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0603B258B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 05:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C131DE4CD;
	Mon, 30 Jun 2025 05:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S+JFSuCJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S+JFSuCJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650521A23BD
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261399; cv=none; b=C5FsqPqEnklnkVDcrtWQaFFeGjz2ipQmzsEHOWBNIUqtpAPtz9TuYQQiqbgtd6ULIfWd0s7vD3GtnZI17sNzcpwatcJ1ksuT4i5F6PsJR7Ejd2Xas5CYDzMQr+Rz16irYZXmS8AOgZY7CgW+ORe+pxta0bl+Li8QafHBlA83fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261399; c=relaxed/simple;
	bh=eo+koqDKuEjcREiUqJESUWALOkgnsEh1LZ2Cak/GfjU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTOGbiqJVPrWmJa4F2yBODiCyv/7nkPpOLTCTro+VboYuubk6qWcPdLzhr8QzAPhqjprQ45RQwAM9PkTaGtF5mvX4jWcReWLKeGyy4HaGcgCb/dbrjJL6Pie32Ut1wB0JH/rBeK6/oT9K+l7kqVMZJ3Q3nAvzBeZpDBpUjaJ4dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S+JFSuCJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=S+JFSuCJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BE3B1F444
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLot+wHeHMAc4ibuIcvL9dO9IUpN/IhCT+4E8pgEmPM=;
	b=S+JFSuCJsMMGZPLwkYOKwKMVgscm78Qv2a3wAEqGJV8XSpSFxkPnavrompA0CCXG8VF/3/
	1eNGMd8r/FanZkVFIKNZM8e3aLN47swWOtkhVAa20R6wPtrg8Kwfp2Ia2+IQk/BNpvqpLk
	l18VYCCqW3IcSV6SCrJPGcrH+dY/9AI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=S+JFSuCJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751261384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lLot+wHeHMAc4ibuIcvL9dO9IUpN/IhCT+4E8pgEmPM=;
	b=S+JFSuCJsMMGZPLwkYOKwKMVgscm78Qv2a3wAEqGJV8XSpSFxkPnavrompA0CCXG8VF/3/
	1eNGMd8r/FanZkVFIKNZM8e3aLN47swWOtkhVAa20R6wPtrg8Kwfp2Ia2+IQk/BNpvqpLk
	l18VYCCqW3IcSV6SCrJPGcrH+dY/9AI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C337139D4
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2FBpDscgYmi4SAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 05:29:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v6 8/8] btrfs: use fs_holder_ops for all opened devices
Date: Mon, 30 Jun 2025 14:59:12 +0930
Message-ID: <0636b387718e5dbeb8a0a34ca2a06a3e98dd1255.1751261286.git.wqu@suse.com>
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
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4BE3B1F444
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Since we have btrfs_fs_info::sb (struct super_block) as our block device
holder, we can safely use fs_holder_ops for all of our block devices.

This enables freezing/thawing the btrfs from the underlying block
devices.

This may enhance hibernation/suspension support since previously
freezing/thawing a block device managed by btrfs won't do anything btrfs
specific, but only syncing the block device.

Thus before this change, freezing the underlying block devices won't
prevent future writes into the btrfs, thus may cause problems for
hibernation/suspension when btrfs is involved.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/dev-replace.c | 2 +-
 fs/btrfs/volumes.c     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index b828e4003552..4675bcd5f92e 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -250,7 +250,7 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	}
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					   fs_info->sb, NULL);
+					   fs_info->sb, &fs_holder_ops);
 	if (IS_ERR(bdev_file)) {
 		btrfs_err(fs_info, "target device %s is invalid!", device_path);
 		return PTR_ERR(bdev_file);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 869402eaa0bb..8ea1a69808a3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -475,7 +475,7 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 	struct block_device *bdev;
 	int ret;
 
-	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, NULL);
+	*bdev_file = bdev_file_open_by_path(device_path, flags, holder, &fs_holder_ops);
 
 	if (IS_ERR(*bdev_file)) {
 		ret = PTR_ERR(*bdev_file);
@@ -2707,7 +2707,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 		return -EROFS;
 
 	bdev_file = bdev_file_open_by_path(device_path, BLK_OPEN_WRITE,
-					   fs_info->sb, NULL);
+					   fs_info->sb, &fs_holder_ops);
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 
-- 
2.50.0


