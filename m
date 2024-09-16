Return-Path: <linux-btrfs+bounces-8044-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C970A979DD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 11:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB221C22924
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 09:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666A1494DF;
	Mon, 16 Sep 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tmp6RPJ0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nPTKAIvU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065814831D
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477557; cv=none; b=NAj3Z97KtZvNNx7JDwbtcQ7StjxepYOOeSqIihx5v4I19MwTNl8/iZrzDm5cclYKv1+7dZRry5M2K3w5+yEXFGcygfuThV8/Semgke7ApAUPYcDQrNWfZTCvHaj4rVPTEU9K5NaorAyPFukxVihnrgmlILxbtozCin3VoxN1jfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477557; c=relaxed/simple;
	bh=E3lWSZFBBbtzM0U1e+t1FZJ5h20fXDtbHFAIePhWmrU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHk0KFwjzsO8eJCsbPyBvY/SV4NHpgWNGrXndd+fAWccJp3+C/C8LoZNpZdtzvMUDWE0Ce6zyRcgS8wynLeuc1k/1K4sSuhbue5RpSAOgY9n+YGxG7fclPOw/E6aXVTOyK0dHHOsv1ESmU+FzWgVJojhvwTcCFVlTXD/1nqmBRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tmp6RPJ0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nPTKAIvU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F214F21237
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726477554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmOnluFX0q21w8xRT/O+x624RIOYKt8M5RYl9vVt9mY=;
	b=tmp6RPJ0MLvhfCAYg8GgW11DOmGhjhDkEv8bhsi0powgxtKPOHSjC5/VmgOGz9GSRC0PP0
	le11q+Jy8K13clboHdYq4lef3w7LqeWfi42zLmZIMOzGztzN38/ZF3F/WAWxTo1iodF8CI
	Mc6X236GMi2ND/nf8qkxlBR3HdbP3cI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726477553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lmOnluFX0q21w8xRT/O+x624RIOYKt8M5RYl9vVt9mY=;
	b=nPTKAIvUKCL/7Ksu42JnBN78MUvAiRT3Gz9SAe41ZfKIe+xofYso/QK7qQo85kk3jODpSp
	f6nXjVY/eLtn6xwqMmoFv/ArWJG+S8kAAqBN8yFkSjU1uqseceyh7e/Hoi/kSijvThz2Fk
	ecEY/jX4HOnwZN8c/K4sjCdOyRb01QE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F657139CE
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mAZWAfH052bTSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:53 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: split out CONFIG_BTRFS_EXPERIMENTAL from CONFIG_BTRFS_DEBUG
Date: Mon, 16 Sep 2024 18:35:29 +0930
Message-ID: <dc5425aaed885ceb579ceb95d936c5fb0f5acd81.1726477365.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726477365.git.wqu@suse.com>
References: <cover.1726477365.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

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
- Send string v3

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Kconfig   | 9 +++++++++
 fs/btrfs/bio.c     | 2 +-
 fs/btrfs/fs.h      | 4 ++--
 fs/btrfs/send.h    | 2 +-
 fs/btrfs/super.c   | 6 +++---
 fs/btrfs/sysfs.c   | 4 ++--
 fs/btrfs/volumes.h | 4 ++--
 7 files changed, 20 insertions(+), 11 deletions(-)

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
index 98fa0f382480..e8a5bf4af918 100644
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
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 03926ad467c9..b843308e2bc6 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
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


