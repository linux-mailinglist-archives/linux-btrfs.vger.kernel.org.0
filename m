Return-Path: <linux-btrfs+bounces-14567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E501FAD24C5
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 19:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80D133AF143
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842FC21CC5A;
	Mon,  9 Jun 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hZmJebev";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hZmJebev"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF1A21C160
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749488995; cv=none; b=bRFeEjNb2tU0NORAzJcmhaX7jsy45snWV9DDPOHhuFBM0eQTLcQIWK7KOcKUEqrITO5EkezadkSnFoOsl0i+diMXlb6LAVDs9zApduEdgs8+n8lQtOJ6ZNWnXmXtcFR8Gss0qyDAmnDottldaLgZ3FmhheO6KgDFY/PakOXjQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749488995; c=relaxed/simple;
	bh=hXDca40U2YKyYtZYyCNFzcFtNqo82bNw3fPe8WPXGYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z8V/dGsnY6i81RnrEcL9VOd7U9ZLs9+dSYmcwQ9+Cb1VUXb4C6k57b/pgt+p2bO78jgLppHY9p7PCcEfplv9NZCVcuC78lZTf1Nee5p485ehqgsDmS2olFjqHVKzyEztBDgpZduaxl5anF6zyLAyLFZYFBVNJbAZkxtlNCBde/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hZmJebev; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hZmJebev; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C6B8A211C9;
	Mon,  9 Jun 2025 17:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6jwkEG1E2EahuV4ZMurCsAZwrPcP9Qrq1Hvj3kreJ8=;
	b=hZmJebevsYdDgYxtz6MPIT9YF0py7HX27jDOijEo46NyfzxsKgYetffjGtApinL8RnQhn3
	IKph5A8kePHGBruFpq26vuZwYPHP9LeCmklquyEXbYkumWv/H3CPWVwiGBaT7otebkxV8X
	8zrSDgO6zv9AtZkRsFkzHa1YfoKFe44=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749488987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x6jwkEG1E2EahuV4ZMurCsAZwrPcP9Qrq1Hvj3kreJ8=;
	b=hZmJebevsYdDgYxtz6MPIT9YF0py7HX27jDOijEo46NyfzxsKgYetffjGtApinL8RnQhn3
	IKph5A8kePHGBruFpq26vuZwYPHP9LeCmklquyEXbYkumWv/H3CPWVwiGBaT7otebkxV8X
	8zrSDgO6zv9AtZkRsFkzHa1YfoKFe44=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF707137FE;
	Mon,  9 Jun 2025 17:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EHy7LlsVR2iWHAAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 09 Jun 2025 17:09:47 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 06/11] btrfs: switch RCU helper versions to btrfs_warn()
Date: Mon,  9 Jun 2025 19:09:26 +0200
Message-ID: <b8d2e12361b950b11533ba0e675ac0417a07b480.1749488829.git.dsterba@suse.com>
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
 fs/btrfs/dev-replace.c |  2 +-
 fs/btrfs/disk-io.c     |  2 +-
 fs/btrfs/extent-tree.c |  2 +-
 fs/btrfs/messages.h    |  4 ----
 fs/btrfs/scrub.c       |  8 ++++----
 fs/btrfs/volumes.c     | 10 +++++-----
 fs/btrfs/zoned.c       |  2 +-
 7 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 0e9acedd7bb467..f7f024a956cdda 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -600,7 +600,7 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		return PTR_ERR(src_device);
 
 	if (btrfs_pinned_by_swapfile(fs_info, src_device)) {
-		btrfs_warn_in_rcu(fs_info,
+		btrfs_warn(fs_info,
 	  "cannot replace device %s (devid %llu) due to active swapfile",
 			btrfs_dev_name(src_device), src_device->devid);
 		return -ETXTBSY;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f48f9d924a6216..2b5ec6d349356c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3695,7 +3695,7 @@ static void btrfs_end_super_write(struct bio *bio)
 
 	bio_for_each_folio_all(fi, bio) {
 		if (bio->bi_status) {
-			btrfs_warn_rl_in_rcu(device->fs_info,
+			btrfs_warn_rl(device->fs_info,
 				"lost super block write due to IO error on %s (%d)",
 				btrfs_dev_name(device),
 				blk_status_to_errno(bio->bi_status));
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 1c3bfb9ff025ef..013a095290bd65 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -6479,7 +6479,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed,
 		/* Check if there are any CHUNK_* bits left */
 		if (start > device->total_bytes) {
 			DEBUG_WARN();
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn(fs_info,
 "ignoring attempt to trim beyond device size: offset %llu length %llu device %s device size %llu",
 					  start, end - start + 1,
 					  btrfs_dev_name(device),
diff --git a/fs/btrfs/messages.h b/fs/btrfs/messages.h
index f9f68a2a769792..0520081a66f0f6 100644
--- a/fs/btrfs/messages.h
+++ b/fs/btrfs/messages.h
@@ -54,8 +54,6 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  */
 #define btrfs_crit_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_warn_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_in_rcu(fs_info, KERN_WARNING fmt, ##args)
 #define btrfs_info_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
@@ -64,8 +62,6 @@ void _btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ...);
  */
 #define btrfs_crit_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_CRIT fmt, ##args)
-#define btrfs_warn_rl_in_rcu(fs_info, fmt, args...) \
-	btrfs_printk_rl_in_rcu(fs_info, KERN_WARNING fmt, ##args)
 #define btrfs_info_rl_in_rcu(fs_info, fmt, args...) \
 	btrfs_printk_rl_in_rcu(fs_info, KERN_INFO fmt, ##args)
 
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 04c43f05afc9fa..6776e6ab8d1080 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -556,7 +556,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	 * hold all of the paths here
 	 */
 	for (i = 0; i < ipath->fspath->elem_cnt; ++i)
-		btrfs_warn_in_rcu(fs_info,
+		btrfs_warn(fs_info,
 "scrub: %s at logical %llu on dev %s, physical %llu root %llu inode %llu offset %llu length %u links %u (path: %s)",
 				  swarn->errstr, swarn->logical,
 				  btrfs_dev_name(swarn->dev),
@@ -570,7 +570,7 @@ static int scrub_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 	return 0;
 
 err:
-	btrfs_warn_in_rcu(fs_info,
+	btrfs_warn(fs_info,
 			  "scrub: %s at logical %llu on dev %s, physical %llu root %llu inode %llu offset %llu: path resolving failed with ret=%d",
 			  swarn->errstr, swarn->logical,
 			  btrfs_dev_name(swarn->dev),
@@ -596,7 +596,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 
 	/* Super block error, no need to search extent tree. */
 	if (is_super) {
-		btrfs_warn_in_rcu(fs_info, "scrub: %s on device %s, physical %llu",
+		btrfs_warn(fs_info, "scrub: %s on device %s, physical %llu",
 				  errstr, btrfs_dev_name(dev), physical);
 		return;
 	}
@@ -637,7 +637,7 @@ static void scrub_print_common_warning(const char *errstr, struct btrfs_device *
 			}
 			if (ret > 0)
 				break;
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn(fs_info,
 "scrub: %s at logical %llu on dev %s, physical %llu: metadata %s (level %d) in tree %llu",
 				errstr, swarn.logical, btrfs_dev_name(dev),
 				swarn.physical, (ref_level ? "node" : "leaf"),
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9c5625a06e0b12..002f4505ef2e7e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -944,7 +944,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
 		if (device->bdev) {
 			if (device->devt != path_devt) {
 				mutex_unlock(&fs_devices->device_list_mutex);
-				btrfs_warn_in_rcu(NULL,
+				btrfs_warn(NULL,
 	"duplicate device %s devid %llu generation %llu scanned by %s (%d)",
 						  path, devid, found_transid,
 						  current->comm,
@@ -2205,7 +2205,7 @@ int btrfs_rm_device(struct btrfs_fs_info *fs_info,
 	}
 
 	if (btrfs_pinned_by_swapfile(fs_info, device)) {
-		btrfs_warn_in_rcu(fs_info,
+		btrfs_warn(fs_info,
 		  "cannot remove device %s (devid %llu) due to active swapfile",
 				  btrfs_dev_name(device), device->devid);
 		return -ETXTBSY;
@@ -7708,7 +7708,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	ret = btrfs_search_slot(trans, dev_root, &key, path, -1, 1);
 	if (ret < 0) {
-		btrfs_warn_in_rcu(fs_info,
+		btrfs_warn(fs_info,
 			"error %d while searching for dev_stats item for device %s",
 				  ret, btrfs_dev_name(device));
 		goto out;
@@ -7719,7 +7719,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		/* need to delete old one and insert a new one */
 		ret = btrfs_del_item(trans, dev_root, path);
 		if (ret != 0) {
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn(fs_info,
 				"delete too small dev_stats item for device %s failed %d",
 					  btrfs_dev_name(device), ret);
 			goto out;
@@ -7733,7 +7733,7 @@ static int update_dev_stat_item(struct btrfs_trans_handle *trans,
 		ret = btrfs_insert_empty_item(trans, dev_root, path,
 					      &key, sizeof(*ptr));
 		if (ret < 0) {
-			btrfs_warn_in_rcu(fs_info,
+			btrfs_warn(fs_info,
 				"insert dev_stats item for device %s failed %d",
 				btrfs_dev_name(device), ret);
 			goto out;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 18848a9756d142..9bacc8c32b40de 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1182,7 +1182,7 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 			continue;
 
 		/* Free regions should be empty */
-		btrfs_warn_in_rcu(
+		btrfs_warn(
 			device->fs_info,
 		"zoned: resetting device %s (devid %llu) zone %llu for allocation",
 			rcu_str_deref(device->name), device->devid, pos >> shift);
-- 
2.49.0


