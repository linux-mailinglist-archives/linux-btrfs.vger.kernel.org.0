Return-Path: <linux-btrfs+bounces-20221-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 652A6D00FD0
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 05:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98DE630155EC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 04:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1387229994B;
	Thu,  8 Jan 2026 04:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UuzUsWSg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UuzUsWSg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5736299920
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847364; cv=none; b=rUq4ydEIKreJyBcKhq37J9KYdESVJfaFbAU9ZtL6fp0BfL1a76q4DLjGsujjEqhX4m+xEKWpUXSxi6eUb2TNzUMYRvoOzv/d56tNpDyR1n/T2iXe+AuZYt2HfScuxxgbcyxDP75T8wG2ZOOCtUzpBjAP8VYQ8NScOiAt7uc9n54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847364; c=relaxed/simple;
	bh=54BOUxIKunuNGWHAAOk8Eos3NvQUAwQAGy9o2cdUu0E=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tE9SMGtpIV9aZaKlswzZP163IrM5c1FXFHmPNJMN5XtP01KSyhHaIXnzz0X/3MseOcGEpuTSuWfjdj019v7qGeycnS2Py32fcWS1IoJ3CnSGhdEPQL5Um1DYH2195f7NSZ/TgzN/9FuzueMgc4XEE68WnM5XdJF+cwXrMH8hmEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UuzUsWSg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UuzUsWSg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F0995BCD9
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767847360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7mJRMOLtX18EWk8YS49OWBkJD7tyE4XebL5NGECLZ+0=;
	b=UuzUsWSgUgd0lgE6VL/0201zxONzKcH1rEiT3lR3kIwR/onbb0lKEyBdCGQbGKBJdc/LlB
	w/DeS+xMUKrXcKtEWkQObR9QhwQy/8Dm0K4/BPMnbu4AHRMaHMu+rES6flUuaEL6+VQk6Z
	Bxr0FQXPWMizc6w1SHHjks2B6t//juE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1767847360; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=7mJRMOLtX18EWk8YS49OWBkJD7tyE4XebL5NGECLZ+0=;
	b=UuzUsWSgUgd0lgE6VL/0201zxONzKcH1rEiT3lR3kIwR/onbb0lKEyBdCGQbGKBJdc/LlB
	w/DeS+xMUKrXcKtEWkQObR9QhwQy/8Dm0K4/BPMnbu4AHRMaHMu+rES6flUuaEL6+VQk6Z
	Bxr0FQXPWMizc6w1SHHjks2B6t//juE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47D043EA63
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 04:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ih2KAr81X2mwDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 08 Jan 2026 04:42:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: use device_discard_blocks() to replace prepare_discard_device()
Date: Thu,  8 Jan 2026 15:12:17 +1030
Message-ID: <284c38aeccd4abefa2349d2bab1cefb09e89b5bd.1767847334.git.wqu@suse.com>
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
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	NEURAL_HAM_SHORT(-0.08)[-0.409];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

The helper device_discard_blocks() is more generic, meanwhile
prepare_discard_device() is only utilized once to output a message.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/device-utils.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 9dfc50211955..e60196ec8e8b 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -80,29 +80,6 @@ int device_discard_blocks(int fd, u64 start, u64 len)
 	return 0;
 }
 
-static void prepare_discard_device(const char *filename, int fd, u64 byte_count, unsigned opflags)
-{
-	u64 cur = 0;
-
-	while (cur < byte_count) {
-		/* 1G granularity */
-		u64 chunk_size = (cur == 0) ? SZ_1M : min_t(u64, byte_count - cur, SZ_1G);
-		int ret;
-
-		ret = discard_range(fd, cur, chunk_size);
-		if (ret)
-			return;
-		/*
-		 * The first range discarded successfully, meaning the device supports
-		 * discard.
-		 */
-		if (opflags & PREP_DEVICE_VERBOSE && cur == 0)
-			printf("Performing full device TRIM %s (%s) ...\n",
-			       filename, pretty_size(byte_count));
-		cur += chunk_size;
-	}
-}
-
 /*
  * Write zeros to the given range [start, start + len)
  */
@@ -293,8 +270,16 @@ int btrfs_prepare_device(int fd, const char *file, u64 *byte_count_ret,
 		goto err;
 	}
 
-	if (!(opflags & PREP_DEVICE_ZONED) && (opflags & PREP_DEVICE_DISCARD))
-		prepare_discard_device(file, fd, byte_count, opflags);
+	if (!(opflags & PREP_DEVICE_ZONED) && (opflags & PREP_DEVICE_DISCARD)) {
+		ret = device_discard_blocks(fd, 0, byte_count);
+		if (ret < 0) {
+			errno = -ret;
+			warning("failed to discard device '%s': %m", file);
+		} else {
+			printf("Performing full device TRIM %s (%s) ...\n",
+			       file, pretty_size(byte_count));
+		}
+	}
 
 	ret = btrfs_wipe_existing_sb(fd, zinfo);
 	if (ret < 0) {
-- 
2.52.0


