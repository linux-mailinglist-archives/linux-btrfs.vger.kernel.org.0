Return-Path: <linux-btrfs+bounces-20220-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207CD00F54
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 05:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EB5A301D623
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 04:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41786279346;
	Thu,  8 Jan 2026 04:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="evefiRR/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="evefiRR/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B7A257828
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767845511; cv=none; b=Xb9Ma5kP9NNDZIICveka3N2f202J6Ubt5b5FhJWx4NAWd7NzN1a5x5UJSxOkXaHIW2f7D0yOIlbWRLBJ3URBf1CJXBUCvGj0v0n9zbNdJ199eiUuWlduY0DdYPnAk2LovEXjnj8D2YY/HZcIvdNXn15N1KY+HK6zrJrI65UdTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767845511; c=relaxed/simple;
	bh=Ioa1qQqb+PxS7HYNKEHASc9HraUQei3tKYbP1f/Q94c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Qialit5xvMO6stPOinwlG0f57uJKb7HHkF9DQeSMXj9RT8IL1/OkvxLnsT7EMLmIRz9+TLZdH86Du4zuCWlsqYE9E+/iiF4TVFmnBjnPw06IoJs4bUVL6vYtaC97YMzPxA2swZuqqEhjjXu+D/c5ADDFdxBFxPdBapocOlJvqgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=evefiRR/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=evefiRR/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB7E033681
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767845505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dyQWEWzhcZjjX3xp/Nospd5S2SdICYP2cM79CiS1vls=;
	b=evefiRR/yZQBAmYLruECqbcf21VxtwnlghrwgzH1DpRqO9/Cncd7ZFlC1DfHLWLB6Ii0zb
	kbIze1AtHD8Uja/sSQe8KE412MfQkWM3ryOl7WiOPQkcOReQDvvb/CPJ8/iSZXl/+fnUXb
	ydNWOGxyCVJOclWybDp51P1MqDqvXZ4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767845505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=dyQWEWzhcZjjX3xp/Nospd5S2SdICYP2cM79CiS1vls=;
	b=evefiRR/yZQBAmYLruECqbcf21VxtwnlghrwgzH1DpRqO9/Cncd7ZFlC1DfHLWLB6Ii0zb
	kbIze1AtHD8Uja/sSQe8KE412MfQkWM3ryOl7WiOPQkcOReQDvvb/CPJ8/iSZXl/+fnUXb
	ydNWOGxyCVJOclWybDp51P1MqDqvXZ4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EDBE3EA63
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:11:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AnNMDIAuX2mkZgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 04:11:44 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove offload csum mode
Date: Thu,  8 Jan 2026 14:41:26 +1030
Message-ID: <318d41265ab70ffc1220355b3396209d12b23373.1767845479.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.68
X-Spam-Level: 
X-Spamd-Result: default: False [-2.68 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.390];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]

The offload csum mode is introduced to allow developers to compare the
performance of generating checksum for data writes at different timings:

- During btrfs_submit_chunk()
  This is the most common one, if any of the following condition is met
  we go this path:

  * The csum is fast
    For now it's CRC32C and xxhash.

  * It's a synchronous write

  * Zoned

- Delay the checksum generation to a workqueue

However since commit dd57c78aec39 ("btrfs: introduce
btrfs_bio::async_csum") we no longer need to bother any of them.

As if it's an experimental build, async checksum generation at the
background will be faster anyway.

And if not an experimental build, we won't even have the offload csum
mode support.

Considering the async csum will be the new default, let's remove the
offload csum mode code.

There will be no impact to end users, and offload csum mode is still
under experimental features.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c     |  5 -----
 fs/btrfs/sysfs.c   | 44 --------------------------------------------
 fs/btrfs/volumes.h |  3 ---
 3 files changed, 52 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a12446aa0fbf..d46f39996469 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -665,11 +665,6 @@ static bool should_async_write(struct btrfs_bio *bbio)
 	bool auto_csum_mode = true;
 
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
-	struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
-	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
-
-	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_ON)
-		return true;
 	/*
 	 * Write bios will calculate checksum and submit bio at the same time.
 	 * Unless explicitly required don't offload serial csum calculate and bio
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index f0974f4c0ae4..ebd6d1d6778b 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1538,47 +1538,6 @@ static ssize_t btrfs_bg_reclaim_threshold_store(struct kobject *kobj,
 BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
 	      btrfs_bg_reclaim_threshold_store);
 
-#ifdef CONFIG_BTRFS_EXPERIMENTAL
-static ssize_t btrfs_offload_csum_show(struct kobject *kobj,
-				       struct kobj_attribute *a, char *buf)
-{
-	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
-
-	switch (READ_ONCE(fs_devices->offload_csum_mode)) {
-	case BTRFS_OFFLOAD_CSUM_AUTO:
-		return sysfs_emit(buf, "auto\n");
-	case BTRFS_OFFLOAD_CSUM_FORCE_ON:
-		return sysfs_emit(buf, "1\n");
-	case BTRFS_OFFLOAD_CSUM_FORCE_OFF:
-		return sysfs_emit(buf, "0\n");
-	default:
-		WARN_ON(1);
-		return -EINVAL;
-	}
-}
-
-static ssize_t btrfs_offload_csum_store(struct kobject *kobj,
-					struct kobj_attribute *a, const char *buf,
-					size_t len)
-{
-	struct btrfs_fs_devices *fs_devices = to_fs_devs(kobj);
-	int ret;
-	bool val;
-
-	ret = kstrtobool(buf, &val);
-	if (ret == 0)
-		WRITE_ONCE(fs_devices->offload_csum_mode,
-			   val ? BTRFS_OFFLOAD_CSUM_FORCE_ON : BTRFS_OFFLOAD_CSUM_FORCE_OFF);
-	else if (ret == -EINVAL && sysfs_streq(buf, "auto"))
-		WRITE_ONCE(fs_devices->offload_csum_mode, BTRFS_OFFLOAD_CSUM_AUTO);
-	else
-		return -EINVAL;
-
-	return len;
-}
-BTRFS_ATTR_RW(, offload_csum, btrfs_offload_csum_show, btrfs_offload_csum_store);
-#endif
-
 /*
  * Per-filesystem information and stats.
  *
@@ -1598,9 +1557,6 @@ static const struct attribute *btrfs_attrs[] = {
 	BTRFS_ATTR_PTR(, bg_reclaim_threshold),
 	BTRFS_ATTR_PTR(, commit_stats),
 	BTRFS_ATTR_PTR(, temp_fsid),
-#ifdef CONFIG_BTRFS_EXPERIMENTAL
-	BTRFS_ATTR_PTR(, offload_csum),
-#endif
 	NULL,
 };
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 34b854c1a303..96422c04a69e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -463,9 +463,6 @@ struct btrfs_fs_devices {
 
 	/* Device to be used for reading in case of RAID1. */
 	u64 read_devid;
-
-	/* Checksum mode - offload it or do it synchronously. */
-	enum btrfs_offload_csum_mode offload_csum_mode;
 #endif
 };
 
-- 
2.52.0


