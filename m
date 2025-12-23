Return-Path: <linux-btrfs+bounces-19984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F722CD8673
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 08:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC41F3015142
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Dec 2025 07:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83394301704;
	Tue, 23 Dec 2025 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="q8gJIS0L";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="K4o7tNBB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3343288522
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Dec 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766475618; cv=none; b=PbKcAvP2ZrXDNJey0vxs2Kj0leCpSFiTB5RpWli93WM99VEx0IG8SAcq5G4q+SlkzXpHyuWEmqiVMaYbhNKs9L/GZt3oKRpP1Ig+nTiRDxLrGQC4EqdJeWhLd2eYbSINAhybjmiQpeZC8wUIDAzgeQe/A3WEop8v7u8xbpgza/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766475618; c=relaxed/simple;
	bh=L5CByaYXJWONGE9+sxwtNikIVQtw/OGu1T5LuXrHYIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hbew0xImlHfFDZkCqCCgSW3mAfMVYKB8wPEfjivWuV0iTdp+swUrZEtOQonGFz5jTzP+/j1M3yUbr66xKxScU9zNkJLVJzH55G6h+MCQfyQfPCvJyeEkPhxtuaD3pX6VDI0LJeVM+YUqm609Tx5K/YsGB1w1VrPGWVCsCNS8dB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=q8gJIS0L; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=K4o7tNBB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C9B2F33684;
	Tue, 23 Dec 2025 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766475614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q9iYhaWiB2zQF0AW7VsiZ5vDEdP8y+1uhNi6vq9cEnc=;
	b=q8gJIS0LQJmwUKQXJzJjhxizHkSzvkdX3eZukNdyjOrZZoKBeHhOtGD5u+CRsPLGGoOVjp
	nFzsYhDGFxFiHGJ7jHAXzmT5IXNOntuiP7SOsNgK09WkwiNjztq4A4EAF1MwAUQ0WoGduO
	vi4wrVrUqTMnXfoIcrBegWM74p3sWqs=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=K4o7tNBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766475613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=q9iYhaWiB2zQF0AW7VsiZ5vDEdP8y+1uhNi6vq9cEnc=;
	b=K4o7tNBB3JcWKNVtOWdlYeKfCR2UZ7m4glG/dxYbTpSuOCbvK6OqAkzUjdMXg89QGzoOPm
	1nbtzsgMPazN2ZBuHocNsiDVrQH/Exo8s8NMCHDwa0NSStH+qxBoJ70KuOb+V0vJmZXtNi
	NnzoP9Ip2IThb9PDSCP9dsEsmTj7hCQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C34843EA63;
	Tue, 23 Dec 2025 07:40:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uC4yH1xHSmmDJgAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 23 Dec 2025 07:40:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/131: remove deprecated v1 space cache tests
Date: Tue, 23 Dec 2025 18:09:39 +1030
Message-ID: <20251223073939.128157-1-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: C9B2F33684
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

Since upstream kernel commit 1e7bec1f7d65 ("btrfs: emit a warning about
space cache v1 being deprecated"), v1 space cache is deprecated and
we're considering to remove the support soon.

This means soon v1 space cache mount option will no longer be accepted,
and the test case will fail due to such change.

Update the test case to remove all v1 cache usage, so we only support
two cache modes, either nospace_cache or space_cache=v2.

This also allows bs < ps btrfs to be tested for this test case which has
no v1 space cache from day 1.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/131     | 34 ++++++++++------------------------
 tests/btrfs/131.out |  7 ++-----
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/tests/btrfs/131 b/tests/btrfs/131
index b4756a5f..d2b4b91d 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -14,21 +14,15 @@ _begin_fstest auto quick
 _require_scratch
 _require_btrfs_command inspect-internal dump-super
 _require_btrfs_fs_feature free_space_tree
-# Zoned btrfs does not support space_cache(v1)
-_require_non_zoned_device "${SCRATCH_DEV}"
 # Block group tree does not support space_cache(v1)
 _require_btrfs_no_block_group_tree
 
-_scratch_mkfs >/dev/null 2>&1
-[ "$(_get_page_size)" -gt "$(_scratch_btrfs_sectorsize)" ] && \
-	_notrun "cannot run with subpage sectorsize"
-
-mkfs_v1()
+mkfs_nocache()
 {
 	_scratch_mkfs >/dev/null 2>&1
 	# Future proof against btrfs-progs making space_cache=v2 filesystems by
 	# default.
-	_scratch_mount -o clear_cache,space_cache=v1
+	_scratch_mount -o clear_cache,nospace_cache
 	_scratch_unmount
 }
 
@@ -54,41 +48,39 @@ check_fst_compat()
 export MOUNT_OPTIONS=""
 
 # When the free space tree is not enabled:
-# -o space_cache=v1: keep using the old free space cache
+# -o nospace_cache: keep no space cache
 # -o space_cache=v2: enable the free space tree
 # -o clear_cache,space_cache=v2: clear the free space cache and enable the free space tree
 # We don't check the no options case or plain space_cache as that will change
 # in the future to turn on space_cache=v2.
 
-mkfs_v1
-echo "Using free space cache"
-_scratch_mount -o space_cache=v1
+mkfs_nocache
+echo "Using no space cache"
+_scratch_mount -o nospace_cache
 check_fst_compat
 _scratch_unmount
 
-mkfs_v1
+mkfs_nocache
 echo "Enabling free space tree"
 _scratch_mount -o space_cache=v2
 check_fst_compat
 _scratch_unmount
 
-mkfs_v1
-echo "Disabling free space cache and enabling free space tree"
+mkfs_nocache
+echo "Clearing free space cache and enabling free space tree"
 _scratch_mount -o clear_cache,space_cache=v2
 check_fst_compat
 _scratch_unmount
 
 # When the free space tree is enabled:
-# -o nospace_cache, -o space_cache=v1: error
+# -o nospace_cache: error
 # no options, -o space_cache=v2: keep using the free space tree
 # -o clear_cache, -o clear_cache,space_cache=v2: clear and recreate the free space tree
 # -o clear_cache,nospace_cache: clear the free space tree
-# -o clear_cache,space_cache=v1: clear the free space tree, enable the free space cache
 
 mkfs_v2
 echo "Trying to mount without free space tree"
 _try_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
-_try_scratch_mount -o space_cache=v1 >/dev/null 2>&1 || echo "mount failed"
 
 mkfs_v2
 echo "Mounting existing free space tree"
@@ -115,12 +107,6 @@ _scratch_mount -o clear_cache,nospace_cache
 check_fst_compat
 _scratch_unmount
 
-mkfs_v2
-echo "Reverting to free space cache"
-_scratch_mount -o clear_cache,space_cache=v1
-check_fst_compat
-_scratch_unmount
-
 # success, all done
 status=0
 exit
diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
index aaa4a70a..97769dc7 100644
--- a/tests/btrfs/131.out
+++ b/tests/btrfs/131.out
@@ -1,13 +1,12 @@
 QA output created by 131
-Using free space cache
+Using no space cache
 free space tree is disabled
 Enabling free space tree
 free space tree is enabled
-Disabling free space cache and enabling free space tree
+Clearing free space cache and enabling free space tree
 free space tree is enabled
 Trying to mount without free space tree
 mount failed
-mount failed
 Mounting existing free space tree
 free space tree is enabled
 free space tree is enabled
@@ -16,5 +15,3 @@ free space tree is enabled
 free space tree is enabled
 Disabling free space tree
 free space tree is disabled
-Reverting to free space cache
-free space tree is disabled
-- 
2.51.2


