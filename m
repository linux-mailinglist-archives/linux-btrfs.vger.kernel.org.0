Return-Path: <linux-btrfs+bounces-14764-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D296ADE99E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 13:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CD407A48EB
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Jun 2025 11:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE2B28BAA1;
	Wed, 18 Jun 2025 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kTRPiikX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kTRPiikX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A7B288503
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Jun 2025 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245001; cv=none; b=sr8BwTTAPSdZW/+IMsDHkSMplC4VWeFm2EC2X2pAQwwxCYT3Hr4gl7bq8pyuDkgpc+OClnTw0jTbqSizx7w4v5+wEOyD2Hh8kEXQL5ACP1ART9Mo9fn3fbl/++OzFz0e+YEwOPsu555J5wW3YyeJZjrMuY+pYpX8oN2x20qOKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245001; c=relaxed/simple;
	bh=BeWnXuqv5oQSSgNhLjT1bCufajKp88oLXc4DlsWODdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZbMKOKk+y31Lcd1lEror8TX0NCQoLiyr9j+WNLRe94+pdf+/cZ/ZN/eMQH5KiJP3AA5/gGBRUyJfH6ey9CMAanfr0ShTWifgVVEEsqJM+rJn7/1qBdzem7RV/qu4enqbQY9oSvPMMPVQAyvExvLYwLyxMtd3rfKKMDNSDAPkyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kTRPiikX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kTRPiikX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DE93C211EC;
	Wed, 18 Jun 2025 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750244993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYbXN1O7/k/RNBSQGUniRJCEvzCByG5Ir55H+U/9JrQ=;
	b=kTRPiikXOQiXu99rpqY8E8UTRVFo9Re+TOMAE3VFpHOBXXHpPsTAsTyae7cUYWnS9+Jyr1
	ilzJ/OInL1BfH55zmWJwD1YaE0ELYTRkJ8rzakoT5kOlwJM9YvUt5OfkdcmAU+1tRKYRlG
	tWYmqCsYK8UP/SQVCWR+YZEsKHEvQdM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1750244993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYbXN1O7/k/RNBSQGUniRJCEvzCByG5Ir55H+U/9JrQ=;
	b=kTRPiikXOQiXu99rpqY8E8UTRVFo9Re+TOMAE3VFpHOBXXHpPsTAsTyae7cUYWnS9+Jyr1
	ilzJ/OInL1BfH55zmWJwD1YaE0ELYTRkJ8rzakoT5kOlwJM9YvUt5OfkdcmAU+1tRKYRlG
	tWYmqCsYK8UP/SQVCWR+YZEsKHEvQdM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D781413A3F;
	Wed, 18 Jun 2025 11:09:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6rOaNIGeUmgDOQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Wed, 18 Jun 2025 11:09:53 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/3] btrfs: protect reading device name by RCU in update_dev_time()
Date: Wed, 18 Jun 2025 13:09:53 +0200
Message-ID: <d20c4cbf78b4af715b63bc5c8cea3ba0f4e7eae5.1750244832.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1750244832.git.dsterba@suse.com>
References: <cover.1750244832.git.dsterba@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The device time update is called from places where the device is still
connected to the lists and could be potentially used for printing the
name. Add RCU read protection around kern_path() that makes a copy of
the input path. Change the parameter to struct btrfs_device so the RCU
section can be minimal.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 134b7754347e..a5fbbd6bb1ed 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1992,12 +1992,14 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
  *
  * We don't care about errors here, this is just to be kind to userspace.
  */
-static void update_dev_time(const char *device_path)
+static void update_dev_time(const struct btrfs_device *device)
 {
 	struct path path;
 	int ret;
 
-	ret = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	rcu_read_lock();
+	ret = kern_path(rcu_dereference(device->name), LOOKUP_FOLLOW, &path);
+	rcu_read_unlock();
 	if (ret)
 		return;
 
@@ -2165,7 +2167,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device->name->str);
+	update_dev_time(device);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
@@ -2892,7 +2894,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_forget_devices(device->devt);
 
 	/* Update ctime/mtime for blkid or udev */
-	update_dev_time(device_path);
+	update_dev_time(device);
 
 	return ret;
 
-- 
2.47.1


