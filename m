Return-Path: <linux-btrfs+bounces-734-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E926807F30
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 04:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 670601C211F4
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Dec 2023 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750FF5670;
	Thu,  7 Dec 2023 03:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J8OvY/Fy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C951D69
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Dec 2023 19:36:34 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69EA421D2C;
	Thu,  7 Dec 2023 03:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701920192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wDcu2oKvUy6ufKnqVTyWQyhx2Gx4alhrMuxQSmwJ5mg=;
	b=J8OvY/FyTCLJ4n7wp6WLcmBDi94c7fq79KdzC26+k+gxJe+uGPx/0cqbtGoGbcjvZcAuQn
	wQSLhR/7SdKKBdaY1TOtks8CpuXOMbshyJ9pXW6B8yM6mMKxp/GZnPJdnTkqnBg4P2Xs+t
	gz/IY0Y3Wm+vE9SDQupkQyCMbsYyLHE=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CF3B8139E3;
	Thu,  7 Dec 2023 03:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KDfpGr49cWU8bwAAn2gu4w
	(envelope-from <wqu@suse.com>); Thu, 07 Dec 2023 03:36:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.com>
Subject: [PATCH] btrfs: get rid of memparse() for sysfs operations
Date: Thu,  7 Dec 2023 14:06:11 +1030
Message-ID: <69524a828a08d8d88face116ea7563fd34275815.1701920169.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 10.00
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [10.00 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

[CONFUSION]
Btrfs is using memparse() for the following sysfs interfaces:

- /sys/fs/btrfs/<uuid>/devinfo/<devid>/scrub_speed_max
- /sys/fs/btrfs/<uuid>/allocation/<type>/chunk_size

Thus we can echo some seemingly valid values into them (using
scrub_speed_max as an example):

 # echo 25e > scrub_speed_max
 # cat scrub_speed_max
 10376293541461622784

This can cause several confusion:

- The end user may just want to type "0x25e"
- Even if it's treated as decimal "25" and E (exabyte), the result is
  not correct
  25 exabyte should be 28147497671065600, as 25 with 2 ** 10 would lead
  to something ends with "00" in decimal (25 * 4 = 100).

[CAUSE]
Above "25e" is valid because memparse() handles the extra suffix and do
proper base conversion.

"25e" has no "0x" or "0" prefix, thus it's treated as decimal, and only
"25" is the valid part. Then it goes with number detection, but the
final "e" is treated as invalid since the base is 10.

Then we do the extra left shift based on the suffix.

There are several problem in memparse itself:

- No overflow check
  The usage of simple_strtoull() lacks the overflow check, thus it's
  already discouraged to use.

- The suffix "E" (exabyte) can be easily confused with 0xe.

[FIX]
For btrfs sysfs interface, we don't accept extra suffix, except the
mentioned two entries.

Furthermore since we don't do pretty size output, and considering the
sysfs interfaces are mostly for script or other tools, there is no need
to accept extra suffix either.

So here we can just replace the memparse() to kstrou64() instead, and
reject the above "25e" example.

Reported-by: David Disseldorp <ddiss@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/sysfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e6b51fb3ddc1..051642177982 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -760,8 +760,8 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 {
 	struct btrfs_space_info *space_info = to_space_info(kobj);
 	struct btrfs_fs_info *fs_info = to_fs_info(get_btrfs_kobj(kobj));
-	char *retptr;
 	u64 val;
+	int ret;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -776,11 +776,9 @@ static ssize_t btrfs_chunk_size_store(struct kobject *kobj,
 	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
 		return -EPERM;
 
-	val = memparse(buf, &retptr);
-	/* There could be trailing '\n', also catch any typos after the value */
-	retptr = skip_spaces(retptr);
-	if (*retptr != 0 || val == 0)
-		return -EINVAL;
+	ret = kstrtou64(buf, 0, &val);
+	if (ret < 0)
+		return ret;
 
 	val = min(val, BTRFS_MAX_DATA_CHUNK_SIZE);
 
@@ -1779,10 +1777,12 @@ static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
 {
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
-	char *endptr;
-	unsigned long long limit;
+	u64 limit;
+	int ret;
 
-	limit = memparse(buf, &endptr);
+	ret = kstrtou64(buf, 0, &limit);
+	if (ret < 0)
+		return ret;
 	WRITE_ONCE(device->scrub_speed_max, limit);
 	return len;
 }
-- 
2.43.0


