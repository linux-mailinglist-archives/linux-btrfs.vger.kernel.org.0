Return-Path: <linux-btrfs+bounces-7226-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5829544EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 10:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AD8284E88
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 08:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD913C699;
	Fri, 16 Aug 2024 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MWJ2SNf2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MWJ2SNf2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73A127E3A
	for <linux-btrfs@vger.kernel.org>; Fri, 16 Aug 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723798717; cv=none; b=dJuuLt/6raQh4jMIGMIGDPY8M6ON5Xb5BiMeDtO8mO+lzdAlRvpJqc8DzZ0+rco0Yr2NMx/wAK2mTgHRv2s94abtGcDfTIHrJfCtCHz5OPDUq9ghD/eYNL1gM5QSPo12GAxqAyihbc9t38/heVAeRlBG8kzR4QhFd2xbPgYIfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723798717; c=relaxed/simple;
	bh=78dZ4OOye8ocBlsYQh75ACZELIzq+PyRC1z0dsnr/p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JNQyAKGXJ7wSHk3NGNrF896iKF7mTALFtPUJH+C2r7tDKYuHcgIsAaBUsEA6d2DD1f+kP901EHsGmU8nZqH1B80P6JCHIPqxh3AV5xzc0xIUfjl+3X/idUaJ3ajxB02D19qVqZJoMoRoJ9l3jN/Gnwwm1LG9WKZdmLcWFtDV16k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MWJ2SNf2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MWJ2SNf2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E2042221A;
	Fri, 16 Aug 2024 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723798713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IoRUJvRApyCgO2XvCnA1yPYk5tZ3aA0WtT2QCrUk4oo=;
	b=MWJ2SNf2I9dUWgtPS4xcF7EgRJRZGm+7sFmGvJkg7PAodvrmDKbF9GRG4U0irsLRjS1E8F
	eFig5tDdxJtjH7kvd5vPRhfQ5DNAqb5OBssTsRsFAPjvhKJQiJUjvFoTITRJVNOhFi7XTO
	PhI2C0/I7ZdHi460c3XLoFidjxoftqg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723798713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IoRUJvRApyCgO2XvCnA1yPYk5tZ3aA0WtT2QCrUk4oo=;
	b=MWJ2SNf2I9dUWgtPS4xcF7EgRJRZGm+7sFmGvJkg7PAodvrmDKbF9GRG4U0irsLRjS1E8F
	eFig5tDdxJtjH7kvd5vPRhfQ5DNAqb5OBssTsRsFAPjvhKJQiJUjvFoTITRJVNOhFi7XTO
	PhI2C0/I7ZdHi460c3XLoFidjxoftqg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C441113A2F;
	Fri, 16 Aug 2024 08:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 63ugH7cUv2YQJwAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 16 Aug 2024 08:58:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Ivan Shapovalov <intelfx@intelfx.name>,
	=?UTF-8?q?Jannik=20Gl=C3=BCckert?= <jannik.glueckert@gmail.com>
Subject: [PATCH RFC] btrfs: only run extent map shrinker inside cleaner kthread
Date: Fri, 16 Aug 2024 18:28:09 +0930
Message-ID: <b5f8d32e8b4fb1bfb3a88f5373530980f1d2f523.1723798569.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[intelfx.name,gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo]

There are still reports about extent map shrinker is causing high CPU
usage.

It turns out that the call backs can be very frequent, even inside
kswapd (and we can have multiple kswapd if the system have several
nodes).

For the only other fs implementing the reclaim callbacks, XFS does it
very differently by ensure the following conditions:

- Make sure there is only one reclaim work queued

- Add a delay before queuing the reclaim workload
  The default delay is 18s (60% of xfs_syncd_centisecs)

In btrfs, there is already a context which is very similar to the XFS
condition: cleaner kthread.

There is only one cleaner kthread for the fs, and it's waken periodically
(the same time interval as commit interval, which is 30s by default).

So it's much better to run the extent map shrinker inside cleaner
kthread.

And make the free_cached_objects() callback to only record the latest
number to free.

Link: https://lore.kernel.org/linux-btrfs/3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name/
Link: https://lore.kernel.org/linux-btrfs/c30fd6b3-ca7a-4759-8a53-d42878bf84f7@gmail.com/
Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Reported-by: Jannik Glückert <jannik.glueckert@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I do not have an environment which can trigger the reclaim that
frequently, thus more tests would be appreciated.

If one wants to test, please use this branch:
https://github.com/adam900710/linux.git em_shrink_freq

And enable CONFIG_BTRFS_DEBUG (since the previous patch hides the
shrinker behind DEBUG builds).

---
 fs/btrfs/disk-io.c    |  3 +++
 fs/btrfs/extent_map.c |  3 ++-
 fs/btrfs/extent_map.h |  2 +-
 fs/btrfs/fs.h         |  1 +
 fs/btrfs/super.c      | 22 +++++++---------------
 5 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a6f5441e62d1..624dd7552e0f 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1542,6 +1542,9 @@ static int cleaner_kthread(void *arg)
 		 * space.
 		 */
 		btrfs_reclaim_bgs(fs_info);
+
+		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
+			btrfs_free_extent_maps(fs_info);
 sleep:
 		clear_and_wake_up_bit(BTRFS_FS_CLEANER_RUNNING, &fs_info->flags);
 		if (kthread_should_park())
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 25d191f1ac10..1491429f9386 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -1248,13 +1248,14 @@ static long btrfs_scan_root(struct btrfs_root *root, struct btrfs_em_shrink_ctx
 	return nr_dropped;
 }
 
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan)
+long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_em_shrink_ctx ctx;
 	u64 start_root_id;
 	u64 next_root_id;
 	bool cycled = false;
 	long nr_dropped = 0;
+	long nr_to_scan = READ_ONCE(fs_info->extent_map_shrinker_nr_to_scan);
 
 	ctx.scanned = 0;
 	ctx.nr_to_scan = nr_to_scan;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 5154a8f1d26c..070621b4467f 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -189,6 +189,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode,
 int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
 				   struct extent_map *new_em,
 				   bool modified);
-long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_scan);
+long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info);
 
 #endif
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3d6d4b503220..a594c8309693 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -636,6 +636,7 @@ struct btrfs_fs_info {
 	spinlock_t extent_map_shrinker_lock;
 	u64 extent_map_shrinker_last_root;
 	u64 extent_map_shrinker_last_ino;
+	long extent_map_shrinker_nr_to_scan;
 
 	/* Protected by 'trans_lock'. */
 	struct list_head dirty_cowonly_roots;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 98fa0f382480..5d9958063ddd 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2402,13 +2402,7 @@ static long btrfs_nr_cached_objects(struct super_block *sb, struct shrink_contro
 
 	trace_btrfs_extent_map_shrinker_count(fs_info, nr);
 
-	/*
-	 * Only report the real number for DEBUG builds, as there are reports of
-	 * serious performance degradation caused by too frequent shrinks.
-	 */
-	if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
-		return nr;
-	return 0;
+	return nr;
 }
 
 static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_control *sc)
@@ -2417,15 +2411,13 @@ static long btrfs_free_cached_objects(struct super_block *sb, struct shrink_cont
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
 
 	/*
-	 * We may be called from any task trying to allocate memory and we don't
-	 * want to slow it down with scanning and dropping extent maps. It would
-	 * also cause heavy lock contention if many tasks concurrently enter
-	 * here. Therefore only allow kswapd tasks to scan and drop extent maps.
+	 * Only record the latest nr_to_scan value. The real scan will happen
+	 * at cleaner kthread.
+	 * As free_cached_objects() can be triggered very frequently, it's
+	 * not practical to scan the whole fs to reclaim extent maps.
 	 */
-	if (!current_is_kswapd())
-		return 0;
-
-	return btrfs_free_extent_maps(fs_info, nr_to_scan);
+	WRITE_ONCE(fs_info->extent_map_shrinker_nr_to_scan, nr_to_scan);
+	return 0;
 }
 
 static const struct super_operations btrfs_super_ops = {
-- 
2.46.0


