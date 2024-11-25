Return-Path: <linux-btrfs+bounces-9898-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C09D8BFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 19:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9263DB2990B
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Nov 2024 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66D81B85C2;
	Mon, 25 Nov 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lm5hCIWl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Lm5hCIWl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B5EED6;
	Mon, 25 Nov 2024 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732558066; cv=none; b=a1YGPXK6+jR4l3t/4u3fBr0LrEn5+1PstKFzS+c+xc9JvsWMBsPWrQQh2mssyjRYYSPMyREJr7OIrzBgrt44eLiz1Y6HeYtOQbLcRybn80NY0kMebD1006izKgx50D+TIt46W/N3+ELROQgUg9sS1FqlpaRqaAoIh7lfExW4UUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732558066; c=relaxed/simple;
	bh=rUJc1scvscabRcabzHlWzPwh9sItoh/3T+/nlO9OKdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eU28oS89IZWG02/oeLPR1xFCVvyVTaAu+C5ZwcKdxtMtoksu0TxCKr8vSx8J+Si8fHUhyZ/4aCyeiDFqyONO/ZrrprgpEs7dm8PEDqHw2g/eq+s/A5CUE1ltcnPdSZssbihPYuypsdJZkly5ezA4Ql0GSxskMe1TG8pqS/wk1ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lm5hCIWl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Lm5hCIWl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE276211A2;
	Mon, 25 Nov 2024 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732558062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2ka3y3jjmpMpbxEAuYX3uPV3eRi/oqaBpNwRVds09mA=;
	b=Lm5hCIWl6V12hn3XxAerI/JE/qGMyi55LUZ7SRfBEulxGR+JXaaZSBFBwCiMzqE98tGADA
	cyGXXiFiI8ysKRjI0jkos3Rn3IxE7YzS2gjGQQw8JVI9tdymbrGS/9sEAUX0cErFeD0LdA
	WDSQ5Gd/7qywapTJDE+HXKU2iFlE0oE=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732558062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=2ka3y3jjmpMpbxEAuYX3uPV3eRi/oqaBpNwRVds09mA=;
	b=Lm5hCIWl6V12hn3XxAerI/JE/qGMyi55LUZ7SRfBEulxGR+JXaaZSBFBwCiMzqE98tGADA
	cyGXXiFiI8ysKRjI0jkos3Rn3IxE7YzS2gjGQQw8JVI9tdymbrGS/9sEAUX0cErFeD0LdA
	WDSQ5Gd/7qywapTJDE+HXKU2iFlE0oE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B764B13890;
	Mon, 25 Nov 2024 18:07:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PXrZLO68RGfDEgAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 25 Nov 2024 18:07:42 +0000
From: David Sterba <dsterba@suse.com>
To: stable@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org,
	git@atemu.net,
	Luca Stefani <luca.stefani.ge1@gmail.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.6.x] btrfs: add cancellation points to trim loops
Date: Mon, 25 Nov 2024 19:07:28 +0100
Message-ID: <20241125180729.13148-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.com:email,suse.com:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,atemu.net,gmail.com,suse.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

From: Luca Stefani <luca.stefani.ge1@gmail.com>

There are reports that system cannot suspend due to running trim because
the task responsible for trimming the device isn't able to finish in
time, especially since we have a free extent discarding phase, which can
trim a lot of unallocated space. There are no limits on the trim size
(unlike the block group part).

Since trime isn't a critical call it can be interrupted at any time,
in such cases we stop the trim, report the amount of discarded bytes and
return an error.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c      | 7 ++++++-
 fs/btrfs/free-space-cache.c | 4 ++--
 fs/btrfs/free-space-cache.h | 7 +++++++
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b3680e1c7054..599407120513 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1319,6 +1319,11 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 		start += bytes_to_discard;
 		bytes_left -= bytes_to_discard;
 		*discarded_bytes += bytes_to_discard;
+
+		if (btrfs_trim_interrupted()) {
+			ret = -ERESTARTSYS;
+			break;
+		}
 	}
 
 	return ret;
@@ -6094,7 +6099,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 3bcf4a30cad7..9a6ec9344c3e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -3808,7 +3808,7 @@ static int trim_no_bitmap(struct btrfs_block_group *block_group,
 		if (async && *total_trimmed)
 			break;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			ret = -ERESTARTSYS;
 			break;
 		}
@@ -3999,7 +3999,7 @@ static int trim_bitmaps(struct btrfs_block_group *block_group,
 		}
 		block_group->discard_cursor = start;
 
-		if (fatal_signal_pending(current)) {
+		if (btrfs_trim_interrupted()) {
 			if (start != offset)
 				reset_trimming_bitmap(ctl, offset);
 			ret = -ERESTARTSYS;
diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
index 33b4da3271b1..bd80c7b2af96 100644
--- a/fs/btrfs/free-space-cache.h
+++ b/fs/btrfs/free-space-cache.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_FREE_SPACE_CACHE_H
 #define BTRFS_FREE_SPACE_CACHE_H
 
+#include <linux/freezer.h>
+
 /*
  * This is the trim state of an extent or bitmap.
  *
@@ -43,6 +45,11 @@ static inline bool btrfs_free_space_trimming_bitmap(
 	return (info->trim_state == BTRFS_TRIM_STATE_TRIMMING);
 }
 
+static inline bool btrfs_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 /*
  * Deltas are an effective way to populate global statistics.  Give macro names
  * to make it clear what we're doing.  An example is discard_extents in
-- 
2.45.0


