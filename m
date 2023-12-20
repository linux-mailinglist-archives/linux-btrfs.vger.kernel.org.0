Return-Path: <linux-btrfs+bounces-1070-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 742418194FB
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 01:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FF6287C04
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Dec 2023 00:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798F7B65E;
	Wed, 20 Dec 2023 00:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S+5E8WoT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q1cMXTfV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61258BF3
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED2F81F7F1
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703031032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7EgUh3/FfASxy7ffgHlIzKv5PodR2qlzfeNLzOLGkQ=;
	b=S+5E8WoTQFoWdug1tsekYAMGFZTS/6PugRG2FcceENMlnFMpRz4biBgmB5Jp2JiF7h8S3s
	cfvOt4VHPDeXBP+ATJBJhwt5vZbiaOYQ5e47h4LX5x4mrSLIXs+zgHnO2pGmIW8CsbmD/S
	42NwTOdXjN22/hFPKhSfN77M6y6pCvo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703031031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7EgUh3/FfASxy7ffgHlIzKv5PodR2qlzfeNLzOLGkQ=;
	b=q1cMXTfVVK9zwVTWKbrhWM2Zsspf+pavhXuLYe0ldE7EloefArMoZmvZznIBwXHNoNYwX9
	70qqn2E+nDyYOZLdgSSbXHgfIWW0rMeIpiEBxyfN9MHnLtMYVCKRlES8L3UfcNy2arm4yH
	V/aUfnGKu6RfuvBxHPzJewXDPcmC0/4=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AFA60139F9
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wBCGEvYwgmU5dQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Dec 2023 00:10:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 2/2] btrfs: sysfs: use kstrtoull_suffix() to replace memparse()
Date: Wed, 20 Dec 2023 10:40:01 +1030
Message-ID: <7e485fb6cafa66c5b9bb01970c152a499b3a7650.1703030510.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1703030510.git.wqu@suse.com>
References: <cover.1703030510.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.90
X-Spamd-Result: default: False [1.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_NONE(0.00)[];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: *
X-Spam-Flag: NO

Since memparse() itself can not handle overflow at all, use
kstrtoull_suffix() to be extra safe.

This would introduce behavior changes to the following sysfs interfaces:

- /sys/fs/btrfs/<uuid>/allocation/(data|metadata|system)/chunk_size

- /sys/fs/btrfs/<uuid>/devinfo/<devid>/scrub_speed_max

The behavior changes would include:

- More overflow detection

- No support for "E" suffix anymore

- More strict tailing character requirement
  Now the only allowed tailing character is newline.
  Other characters including space are no longer supported.

  Although for regular "echo NUMBER >" usage it should be totally fine.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- None
---
 fs/btrfs/sysfs.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 84c05246ffd8..089c3fc123fe 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -760,7 +760,7 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 {
 	struct btrfs_space_info *space_info = to_space_info(kobj);
 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
-	char *retptr;
+	int ret;
 	u64 val;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -776,11 +776,9 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -EPERM;
 
-	val = memparse(buf, &retptr);
-	/* There could be trailing '\n', also catch any typos after the value */
-	retptr = skip_spaces(retptr);
-	if (*retptr != 0 || val == 0)
-		return -EINVAL;
+	ret = kstrtoull_suffix(buf, 0, &val, KSTRTOULL_SUFFIX_DEFAULT);
+	if (ret < 0)
+		return ret;
 
 	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
 
@@ -1779,14 +1777,12 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 {
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
-	char *endptr;
 	unsigned long long limit;
+	int ret;
 
-	limit = memparse(buf, &endptr);
-	/* There could be trailing '\n', also catch any typos after the value. */
-	endptr = skip_spaces(endptr);
-	if (*endptr != 0)
-		return -EINVAL;
+	ret = kstrtoull_suffix(buf, 0, &limit, KSTRTOULL_SUFFIX_DEFAULT);
+	if (ret < 0)
+		return ret;
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }
-- 
2.43.0


