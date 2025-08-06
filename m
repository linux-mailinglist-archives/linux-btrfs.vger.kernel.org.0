Return-Path: <linux-btrfs+bounces-15902-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923DB1CF51
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 01:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5C18931AE
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Aug 2025 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C5026A088;
	Wed,  6 Aug 2025 23:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j1B29LA1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j1B29LA1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1D223301
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 23:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754522384; cv=none; b=IixFCD6R4MTeF9Dkh+aRcfzTw/cR39KUlBg3j4TtulpcF7uprRhaMs1eeAd5wQtctWH0cBFeZACdpehJlF1YvDmFDZqSEfsIfG3whi4EBGyF6R+vcznUo1YR9g6CX7QpL9AQqck5Rw9SrsHyeeameM5S3zUPPQzYEY6GCvRucRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754522384; c=relaxed/simple;
	bh=AP1XVujEm6qrupvzbU1EojcJTQYFL49aG0zygqiAMFc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iEFF2PaDyfVDbmFCnLBNyEHVY1KTaGnG1NjXh011NrwB/yLyLGGVDUV/PD3CNuzMTVElCzl+NtrbEwY4UHt+Kq/4zwfyPgxgCFK8ldGOwVOR3hloFO9tKE6sY4AvBInTnJiljJBPbNVPUe3l1cmuoBLuzq+A/83vA60/yo1lJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j1B29LA1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j1B29LA1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F9BF339ED
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 23:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754522379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jeAsS+13DlCcMEbxRgUUcJ6aAJqbLWWuYsFkOofwYC8=;
	b=j1B29LA1DsMgkwezxbGBoKzpjgca09YHK0db0WRDi/GtlGpSaG94uBeSysH0EaeiDJJLWo
	gKDL5hqX9i88B4fZsIOMALH2nu5HpZQF3PLA/wmOW1/apyIAfDEYbHla994f4DwX1XpdMP
	LsqKuo56CA4B0n6dJAamhvVO020sq/s=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1754522379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=jeAsS+13DlCcMEbxRgUUcJ6aAJqbLWWuYsFkOofwYC8=;
	b=j1B29LA1DsMgkwezxbGBoKzpjgca09YHK0db0WRDi/GtlGpSaG94uBeSysH0EaeiDJJLWo
	gKDL5hqX9i88B4fZsIOMALH2nu5HpZQF3PLA/wmOW1/apyIAfDEYbHla994f4DwX1XpdMP
	LsqKuo56CA4B0n6dJAamhvVO020sq/s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6BC13ABE
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Aug 2025 23:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id er5IGgrjk2hDGAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 06 Aug 2025 23:19:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: detect discard ability more correctly for btrfs_prepare_device()
Date: Thu,  7 Aug 2025 08:49:12 +0930
Message-ID: <fb9da17fe4943acda28cdacc690400cf5bc08e49.1754522337.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Instead of relying on sysfs interface which had some regression
reporting the discard support, let btrfs_prepare_device() to use the
discard_range() result to determine if we need to output the "Performing
full device TRIM" message.

This is done by checking if the first discard succeeded or not.
If the first discard call succeeded, then we know the device support
discard and should output the message.

And to reduce the initial delay before outputting the message (old/lower
end disks may take a long time even discarding 1 GiB), reduce the initial
discard range to 1MiB.

By this it's more reliable to detect discard support for
btrfs_prepare_device() and we can get rid of discard_supported(), and
the timing of the meessage should still be pretty much the same as the
original one, just with a small unobservable delay.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.c | 54 +++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 783d79555446..3f6510198a06 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -60,25 +60,6 @@ static int discard_range(int fd, u64 start, u64 len)
 	return 0;
 }
 
-static int discard_supported(const char *device)
-{
-	int ret;
-	char buf[128] = {};
-
-	ret = device_get_queue_param(device, "discard_granularity", buf, sizeof(buf));
-	if (ret == 0) {
-		pr_verbose(3, "cannot read discard_granularity for %s\n", device);
-		return 0;
-	} else {
-		if (atoi(buf) == 0) {
-			pr_verbose(3, "%s: discard_granularity %s", device, buf);
-			return 0;
-		}
-	}
-
-	return 1;
-}
-
 /*
  * Discard blocks in the given range in 1G chunks, the process is interruptible
  */
@@ -99,6 +80,29 @@ int device_discard_blocks(int fd, u64 start, u64 len)
 	return 0;
 }
 
+static void prepare_discard_device(const char *filename, int fd, u64 byte_count, unsigned opflags)
+{
+	u64 cur = 0;
+
+	while (cur < byte_count) {
+		/* 1G granularity */
+		u64 chunk_size = (cur == 0) ? SZ_1M : min_t(u64, byte_count - cur, SZ_1G);
+		int ret;
+
+		ret = discard_range(fd, cur, chunk_size);
+		if (ret)
+			return;
+		/*
+		 * The first range discarded successfully, meaning the device supports
+		 * discard.
+		 */
+		if (opflags & PREP_DEVICE_VERBOSE && cur == 0)
+			printf("Performing full device TRIM %s (%s) ...\n",
+			       filename, pretty_size(byte_count));
+		cur += chunk_size;
+	}
+}
+
 /*
  * Write zeros to the given range [start, start + len)
  */
@@ -273,17 +277,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 			}
 		}
 	} else if (opflags & PREP_DEVICE_DISCARD) {
-		/*
-		 * We intentionally ignore errors from the discard ioctl.  It
-		 * is not necessary for the mkfs functionality but just an
-		 * optimization.
-		 */
-		if (discard_supported(file)) {
-			if (opflags & PREP_DEVICE_VERBOSE)
-				printf("Performing full device TRIM %s (%s) ...\n",
-				       file, pretty_size(byte_count));
-			device_discard_blocks(fd, 0, byte_count);
-		}
+		prepare_discard_device(file, fd, byte_count, opflags);
 	}
 
 	ret = zero_dev_clamped(fd, zinfo, 0, ZERO_DEV_BYTES, byte_count);
-- 
2.50.1


