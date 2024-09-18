Return-Path: <linux-btrfs+bounces-8103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C669B97B7BE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 08:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4694E1F22B29
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Sep 2024 06:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747E015572C;
	Wed, 18 Sep 2024 06:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="JIf3m6hL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bpOm0gih"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C244D108
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Sep 2024 06:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726640120; cv=none; b=jcOHxD3IK8+ZvA77cXEZ7Mjhu9fFablML8vrLMr2mvCdDOx5HdvgNFecc1GWrOj8xrdEidWpYdhLZHt98tWNEqwFwJ/1fimZ5O/M8sAQPRFBEVUPTHEYYP0hp0gJWyT73eXobrxPA/jc9xW/z62qrwH2gWqHjg+W2rGIZx2oeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726640120; c=relaxed/simple;
	bh=VhwQQViVDgcH3xJeSjroNyP+BaBVHx/2OZWuBY1P0G0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxOjRGHlda7RcIjoQDmfnHdGJ5KMsF/A/TzASyo/viERfXZg+JMcequu98o6b2KYewk8jx5/oLoRiejBUDDNgLzunFTmQhMzlB+AtGVwwMN3eb7Y5a+fi0ouVjxcAqkFgfeK9/bfMvnkgDH7ifqliDw+lMjQY/7NTUTBsObEmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=JIf3m6hL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bpOm0gih; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0C5552282A;
	Wed, 18 Sep 2024 06:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726640110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nVN4oIdPTn76X+1D9+pVUlh4Gu6RBp2EUsmwm1WgFsw=;
	b=JIf3m6hLKleLEjWuAxaw709m8B7xRATiG6o4JdQgcDQI0OpJrl7t5VcPkTJtwgGez/TzOG
	2d5RnPrFELA6mIkhB7GbqcrSHVj9hT4ZGMCYkbKaH9Aj4hk/HEe9bbSI3YKAkkUGq4lab8
	i4teJyYWXtBFUCLnfm2dNmkeOGm8ViQ=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bpOm0gih
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726640109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nVN4oIdPTn76X+1D9+pVUlh4Gu6RBp2EUsmwm1WgFsw=;
	b=bpOm0gihncpjFkcsi47y0r+43AGqiLEKijM4nqdyW4jyL/+WDBiW96VK1qXT3R8Iw6NiaO
	xKXOGR/TayrEZJjGWKjf5n0gXaQX8Wc9oSVoqAGrpaOEQP9YmQHjJbXwAijWYx472TX6RG
	faNmZVt9Wvl9viIROMizwB3zCZeMTZ4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08F9913A57;
	Wed, 18 Sep 2024 06:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p+kML+tv6mbnNQAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 18 Sep 2024 06:15:07 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG
Date: Wed, 18 Sep 2024 15:44:50 +0930
Message-ID: <97b513c38b3d6357b8e51b64c5e06a2a89015ab3.1726640060.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0C5552282A
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,wdc.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Currently CONFIG_BTRFS_EXPERIMENTAL is not only for the extra debugging
output, but also for experimental features.

This is not ideal to distinguish planned but not yet stable features
from those purely designed for debug.

This patch will split the following features into
CONFIG_BTRFS_EXPERIMENTAL:

- Extent map shrinker
  This seems to be the first one to exit experimental.

- Extent tree v2
  This seems to be the last one to graduate from experimental.

- Raid stripe tree
- Csum offload mode
- Send stream v3

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Fix the "string" -> "stream" error in the commit message
- Move extent_tree_v2 and raid_stripe_tree sysfs interfaces to
  CONFIG_BTRFS_EXPERIMENTAL
- Add experimental string to mod info
---
 fs/btrfs/Kconfig   | 9 +++++++++
 fs/btrfs/bio.c     | 2 +-
 fs/btrfs/fs.h      | 4 ++--
 fs/btrfs/send.h    | 2 +-
 fs/btrfs/super.c   | 9 ++++++---
 fs/btrfs/sysfs.c   | 8 ++++----
 fs/btrfs/volumes.h | 4 ++--
 7 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/Kconfig b/fs/btrfs/Kconfig
index 4fb925e8c981..ead317f1eeb8 100644
--- a/fs/btrfs/Kconfig
+++ b/fs/btrfs/Kconfig
@@ -78,6 +78,15 @@ config BTRFS_ASSERT
 
 	  If unsure, say N.
 
+config BTRFS_EXPERIMENTAL
+	bool "Btrfs experimental features"
+	depends on BTRFS_FS
+	help
+	  Enable experimental features.  These features may not be stable enough
+	  for end users.  This is meant for btrfs developers only.
+
+	  If unsure, say N.
+
 config BTRFS_FS_REF_VERIFY
 	bool "Btrfs with the ref verify tool compiled in"
 	depends on BTRFS_FS
diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ce13416bc10f..056f8a171bba 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -605,7 +605,7 @@ static bool should_async_write(struct btrfs_bio *bbio)
 {
 	bool auto_csum_mode = true;
 
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
 	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
 
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index cbfb225858a5..785ec15c1b84 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -263,10 +263,10 @@ enum {
 	 BTRFS_FEATURE_INCOMPAT_ZONED		|	\
 	 BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA)
 
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/*
 	 * Features under developmen like Extent tree v2 support is enabled
-	 * only under CONFIG_BTRFS_DEBUG.
+	 * only under CONFIG_BTRFS_EXPERIMENTAL
 	 */
 #define BTRFS_FEATURE_INCOMPAT_SUPP		\
 	(BTRFS_FEATURE_INCOMPAT_SUPP_STABLE |	\
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index b07f4aa66878..9309886c5ea1 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -16,7 +16,7 @@ struct btrfs_ioctl_send_args;
 
 #define BTRFS_SEND_STREAM_MAGIC "btrfs-stream"
 /* Conditional support for the upcoming protocol version. */
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 #define BTRFS_SEND_STREAM_VERSION 3
 #else
 #define BTRFS_SEND_STREAM_VERSION 2
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 98fa0f382480..7f86fb54981f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2403,10 +2403,10 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
 	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
 
 	/*
-	 * Only report the real number for DEBUG builds, as there are reports of
-	 * serious performance degradation caused by too frequent shrinks.
+	 * Only report the real number for EXPERIMENTAL builds, as there are
+	 * reports of serious performance degradation caused by too frequent shrinks.
 	 */
-	if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
+	if (IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL))
 		return nr;
 	return 0;
 }
@@ -2478,6 +2478,9 @@ static int __init btrfs_print_mod_info(void)
 #ifdef CONFIG_BTRFS_DEBUG
 			", debug=on"
 #endif
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+			", experimental=on"
+#endif
 #ifdef CONFIG_BTRFS_ASSERT
 			", assert=on"
 #endif
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 03926ad467c9..fdcbf650ac31 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -295,7 +295,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 /* Remove once support for extent tree v2 is feature complete */
 BTRFS_FEAT_ATTR_INCOMPAT(extent_tree_v2, EXTENT_TREE_V2);
 /* Remove once support for raid stripe tree is feature complete. */
@@ -329,7 +329,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_FEAT_ATTR_PTR(extent_tree_v2),
 	BTRFS_FEAT_ATTR_PTR(raid_stripe_tree),
 #endif
@@ -1390,7 +1390,7 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
 				       struct kobj_attribute *a, char *buf)
 {
@@ -1450,7 +1450,7 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	BTRFS_ATTR_PTR(, offload_csum),
 #endif
 	NULL,
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 03d2d60afe0c..c207c94a4a5e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -300,7 +300,7 @@ enum btrfs_read_policy {
 	BTRFS_NR_READ_POLICY,
 };
 
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 /*
  * Checksum mode - offload it to workqueues or do it synchronously in
  * btrfs_submit_chunk().
@@ -424,7 +424,7 @@ struct btrfs_fs_devices {
 	/* Policy used to read the mirrored stripes. */
 	enum btrfs_read_policy read_policy;
 
-#ifdef CONFIG_BTRFS_DEBUG
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
 	/* Checksum mode - offload it or do it synchronously. */
 	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
-- 
2.46.0


