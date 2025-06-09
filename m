Return-Path: <linux-btrfs+bounces-14569-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB48AD24CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 751417A88A9
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAD321CFFD;
	Mon,  9 Jun 2025 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q8R+tH7M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q8R+tH7M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E16F21C9ED
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749489002; cv=none; b=iM4ZEPlVb1l0rU4qb47mhaNh5Noz+PG3uoTgdczBTbXag9t0OoL+7RfK0tztU94K3yPtqMVS/yv6Tt5gkQoAP/j1JApvW/EDSsP/oq7gA/yo0XzmTCWWyTGHFurRIJu/tZvjOM3xWlABqBGiwJ+bswIPdwImVJq1vgmpUyNXWIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749489002; c=relaxed/simple;
	bh=ZbiR3Wi2mtflKMi6Gv+lD0gLwLFVLeFcjjZyEMq9JwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGFkY3iwfzvL0eyb0KZ7jGepniClcS6R3fsc6kP1KG/yMeXaCqR8R625a9doGL66jwNdYuAhnFbdLcESdvDqMKXOZJDZ1vaD0oqqU4zwZCKqwsPG+/+U/eZFtFj7cftoajFTTHrdbmwuaBN45E15UdjmXOXHD/wvajph8J8+9pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q8R+tH7M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q8R+tH7M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2343D21195;
	Mon,  9 Jun 2025 17:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXWASSh7hqy37JMGr6UO8Y4NC0NT41bELiYlQouDFZc=;
	b=q8R+tH7MY8lmy7DNmsPvT+GE2M/2fny/ovXF0JmtqBZIN4yVDiPAJjaGPkF/s9/bRNzIzO
	T3MK1GT0geV4gkWAzNByFrgFuLuv7Th+xNmYxeYbMifjjAOtbhmMdqxxEeuJO+j9Cs5iVg
	ZD1egT7iRyki7UCJMGqazHsXcTihCHQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488994; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XXWASSh7hqy37JMGr6UO8Y4NC0NT41bELiYlQouDFZc=;
	b=q8R+tH7MY8lmy7DNmsPvT+GE2M/2fny/ovXF0JmtqBZIN4yVDiPAJjaGPkF/s9/bRNzIzO
	T3MK1GT0geV4gkWAzNByFrgFuLuv7Th+xNmYxeYbMifjjAOtbhmMdqxxEeuJO+j9Cs5iVg
	ZD1egT7iRyki7UCJMGqazHsXcTihCHQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10586137FE;
	Mon,  9 Jun 2025 17:09:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cs36A2IVR2ieHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:54 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 07/11] btrfs: switch RCU helper versions to btrfs_info()
Date: Mon,  9 Jun 2025 19:09:27 +0200
Message-ID: <e3cb2c14bb7753bc946c8b0b3d141b1ed9ad54ab.1749488829.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749488829.git.dsterba@suse.com>
References: <cover.1749488829.git.dsterba@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 

The RCU protection is now done in the plain helpers, we can remove the
"_in_rcu" and "_rl_in_rcu".

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/bio.c         |  2 +-
 fs/btrfs/dev-replace.c | 10 +++++-----
 fs/btrfs/ioctl.c       |  2 +-
 fs/btrfs/messages.h    |  4 ----
 fs/btrfs/volumes.c     |  4 ++--
 fs/btrfs/zoned.c       |  2 +-
 6 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 00d274ed2b1fa2..aa970fd41c4b78 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -839,7 +839,7 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 		goto out_bio_uninit;
 	}
 
-	btrfs_info_rl_in_rcu(fs_info,
+	btrfs_info_rl(fs_info,
 		"read error corrected: ino %llu off %llu (dev %s sector %llu)",
 			     ino, start, btrfs_dev_name(smap.dev),
 			     smap.physical >> SECTOR_SHIFT);
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index f7f024a956cdda..bd276179918172 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -647,7 +647,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	dev_replace->srcdev = src_device;
 	dev_replace->tgtdev = tgt_device;
 
-	btrfs_info_in_rcu(fs_info,
+	btrfs_info(fs_info,
 		      "dev_replace from %s (devid %llu) to %s started",
 		      btrfs_dev_name(src_device),
 		      src_device->devid,
@@ -961,7 +961,7 @@ static int btrfs_dev_replace_finishing(struct btrfs_fs_info *fs_info,
 		return scrub_ret;
 	}
 
-	btrfs_info_in_rcu(fs_info,
+	btrfs_info(fs_info,
 			  "dev_replace from %s (devid %llu) to %s finished",
 			  btrfs_dev_name(src_device),
 			  src_device->devid,
@@ -1109,7 +1109,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 			 * btrfs_dev_replace_finishing() will handle the
 			 * cleanup part
 			 */
-			btrfs_info_in_rcu(fs_info,
+			btrfs_info(fs_info,
 				"dev_replace from %s (devid %llu) to %s canceled",
 				btrfs_dev_name(src_device), src_device->devid,
 				btrfs_dev_name(tgt_device));
@@ -1143,7 +1143,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
 		ret = btrfs_commit_transaction(trans);
 		WARN_ON(ret);
 
-		btrfs_info_in_rcu(fs_info,
+		btrfs_info(fs_info,
 		"suspended dev_replace from %s (devid %llu) to %s canceled",
 			btrfs_dev_name(src_device), src_device->devid,
 			btrfs_dev_name(tgt_device));
@@ -1247,7 +1247,7 @@ static int btrfs_dev_replace_kthread(void *data)
 
 	progress = btrfs_dev_replace_progress(fs_info);
 	progress = div_u64(progress, 10);
-	btrfs_info_in_rcu(fs_info,
+	btrfs_info(fs_info,
 		"continuing dev_replace from %s (devid %llu) to target %s @%u%%",
 		btrfs_dev_name(dev_replace->srcdev),
 		dev_replace->srcdev->devid,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7cc89f6f37ae2d..00047367655968 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1169,7 +1169,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	} /* equal, nothing need to do */
 
 	if (ret == 0 && new_size != old_size)
-		btrfs_info_in_rcu(fs_info,
+		btrfs_info(fs_info,
 			"resize device %s (devid %llu) from %llu to %llu",
 			btrfs_dev_name(device), device->devid,
 			old_size, new_size);
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index 0520081a66f0f6..9d5330ba02534f 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -54,16 +54,12 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  */
 #define btrfs_crit_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_info_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 /*
  * Wrappers that use a ratelimited printk in RCU
  */
 #define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
 /*
  * Wrappers that use a ratelimited printk
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 002f4505ef2e7e..134b7754347ef3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -951,7 +951,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 						  task_pid_nr(current));
 				return ERR_PTR(-EEXIST);
 			}
-			btrfs_info_in_rcu(NULL,
+			btrfs_info(NULL,
 	"devid %llu device path %s changed to %s scanned by %s (%d)",
 					  devid, btrfs_dev_name(device),
 					  path, current->comm,
@@ -7816,7 +7816,7 @@ static void btrfs_dev_stat_print_on_load(struct btrfs_device *dev)
 	if (i == BTRFS_DEV_STAT_VALUES_MAX)
 		return; /* all values == 0, suppress message */
 
-	btrfs_info_in_rcu(dev->fs_info,
+	btrfs_info(dev->fs_info,
 		"bdev %s errs: wr %u, rd %u, flush %u, corrupt %u, gen %u",
 	       btrfs_dev_name(dev),
 	       btrfs_dev_stat_read(dev, BTRFS_DEV_STAT_WRITE_ERRS),
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 9bacc8c32b40de..82ccd78745a3db 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -575,7 +575,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device, bool populate_cache)
 		emulated = "emulated ";
 	}
 
-	btrfs_info_in_rcu(fs_info,
+	btrfs_info(fs_info,
 		"%s block device %s, %u %szones of %llu bytes",
 		model, rcu_str_deref(device->name), zone_info->nr_zones,
 		emulated, zone_info->zone_size);
-- 
2.49.0


