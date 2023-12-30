Return-Path: <linux-btrfs+bounces-1170-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E9820920
	for <lists+linux-btrfs@lfdr.de>; Sun, 31 Dec 2023 00:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF061C2176E
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Dec 2023 23:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9064CEAFF;
	Sat, 30 Dec 2023 23:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMnurQQW";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oMnurQQW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91CBDDBB;
	Sat, 30 Dec 2023 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9227C21C43;
	Sat, 30 Dec 2023 23:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703979438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x9+qx0Vam+hBoH/Vae64avJPlCg+C72fwM9Qw7ouSy4=;
	b=oMnurQQWPaS+Iip6WA+5u6bf1AUvHUltxwrIElgCFfv1bpdhWn4fd7yvm0Ushqj4N7shMv
	W+1mocDCWygLcr1Ap726O/HE7lhhG842w/utCm6QKj2bGKekmdKykhGeH/CeveIPkdZpW7
	hX3UQ3bKfxaGd+bgv9EDmf5fBB2xVfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1703979438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=x9+qx0Vam+hBoH/Vae64avJPlCg+C72fwM9Qw7ouSy4=;
	b=oMnurQQWPaS+Iip6WA+5u6bf1AUvHUltxwrIElgCFfv1bpdhWn4fd7yvm0Ushqj4N7shMv
	W+1mocDCWygLcr1Ap726O/HE7lhhG842w/utCm6QKj2bGKekmdKykhGeH/CeveIPkdZpW7
	hX3UQ3bKfxaGd+bgv9EDmf5fBB2xVfQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08D3513782;
	Sat, 30 Dec 2023 23:37:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ynSwJaypkGU7RQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 30 Dec 2023 23:37:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs: remove test case btrfs/131
Date: Sun, 31 Dec 2023 10:06:57 +1030
Message-ID: <f09fb4edd69cf42fbb816e806384f79340e9d2b4.1703979415.git.wqu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oMnurQQW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MID_CONTAINS_FROM(1.00)[];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 9227C21C43
X-Spam-Flag: NO

Test case btrfs/131 is a quick tests for v1/v2 free space related
behavior, including the mount time conversion and disabling of v2 space
cache.

However there are two problems, mostly related to the v2 cache clearing.

- There are some features with hard dependency on v2 free space cache
  Including:
  * block-group-tree
  * extent-tree-v2
  * subpage support

  Note those features may even not support clearing v2 cache.

- The v1 free space cache is going to be deprecated
  Since v5.15 the default mkfs is already going v2 cache instead.
  It won't be long before we mark v1 cache deprecated and force to
  go v2 cache.

This makes the test case to fail unnecessarily, the false failure would
only grow with new features relying on v2 cache.

So here let's removing the test case completely.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/131     | 124 --------------------------------------------
 tests/btrfs/131.out |  20 -------
 2 files changed, 144 deletions(-)
 delete mode 100755 tests/btrfs/131
 delete mode 100644 tests/btrfs/131.out

diff --git a/tests/btrfs/131 b/tests/btrfs/131
deleted file mode 100755
index 1e072b285ecf..000000000000
--- a/tests/btrfs/131
+++ /dev/null
@@ -1,124 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2016 Facebook.  All Rights Reserved.
-#
-# FS QA Test 131
-#
-# Test free space tree mount options.
-#
-. ./common/preamble
-_begin_fstest auto quick
-
-# Import common functions.
-. ./common/filter
-
-# real QA test starts here
-
-_supported_fs btrfs
-_require_scratch
-_require_btrfs_command inspect-internal dump-super
-_require_btrfs_fs_feature free_space_tree
-# Zoned btrfs does not support space_cache(v1)
-_require_non_zoned_device "${SCRATCH_DEV}"
-
-mkfs_v1()
-{
-	_scratch_mkfs >/dev/null 2>&1
-	# Future proof against btrfs-progs making space_cache=v2 filesystems by
-	# default.
-	_scratch_mount -o clear_cache,space_cache=v1
-	_scratch_unmount
-}
-
-mkfs_v2()
-{
-	_scratch_mkfs >/dev/null 2>&1
-	_scratch_mount -o space_cache=v2
-	_scratch_unmount
-}
-
-check_fst_compat()
-{
-	compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV" | \
-		     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
-	if ((compat_ro & 0x1)); then
-		echo "free space tree is enabled"
-	else
-		echo "free space tree is disabled"
-	fi
-}
-
-# Mount options might interfere.
-export MOUNT_OPTIONS=""
-
-# When the free space tree is not enabled:
-# -o space_cache=v1: keep using the old free space cache
-# -o space_cache=v2: enable the free space tree
-# -o clear_cache,space_cache=v2: clear the free space cache and enable the free space tree
-# We don't check the no options case or plain space_cache as that will change
-# in the future to turn on space_cache=v2.
-
-mkfs_v1
-echo "Using free space cache"
-_scratch_mount -o space_cache=v1
-check_fst_compat
-_scratch_unmount
-
-mkfs_v1
-echo "Enabling free space tree"
-_scratch_mount -o space_cache=v2
-check_fst_compat
-_scratch_unmount
-
-mkfs_v1
-echo "Disabling free space cache and enabling free space tree"
-_scratch_mount -o clear_cache,space_cache=v2
-check_fst_compat
-_scratch_unmount
-
-# When the free space tree is enabled:
-# -o nospace_cache, -o space_cache=v1: error
-# no options, -o space_cache=v2: keep using the free space tree
-# -o clear_cache, -o clear_cache,space_cache=v2: clear and recreate the free space tree
-# -o clear_cache,nospace_cache: clear the free space tree
-# -o clear_cache,space_cache=v1: clear the free space tree, enable the free space cache
-
-mkfs_v2
-echo "Trying to mount without free space tree"
-_try_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
-_try_scratch_mount -o space_cache=v1 >/dev/null 2>&1 || echo "mount failed"
-
-mkfs_v2
-echo "Mounting existing free space tree"
-_scratch_mount
-check_fst_compat
-_scratch_unmount
-_scratch_mount -o space_cache=v2
-check_fst_compat
-_scratch_unmount
-
-mkfs_v2
-echo "Recreating free space tree"
-_scratch_mount -o clear_cache,space_cache=v2
-check_fst_compat
-_scratch_unmount
-mkfs_v2
-_scratch_mount -o clear_cache
-check_fst_compat
-_scratch_unmount
-
-mkfs_v2
-echo "Disabling free space tree"
-_scratch_mount -o clear_cache,nospace_cache
-check_fst_compat
-_scratch_unmount
-
-mkfs_v2
-echo "Reverting to free space cache"
-_scratch_mount -o clear_cache,space_cache=v1
-check_fst_compat
-_scratch_unmount
-
-# success, all done
-status=0
-exit
diff --git a/tests/btrfs/131.out b/tests/btrfs/131.out
deleted file mode 100644
index aaa4a70a34c3..000000000000
--- a/tests/btrfs/131.out
+++ /dev/null
@@ -1,20 +0,0 @@
-QA output created by 131
-Using free space cache
-free space tree is disabled
-Enabling free space tree
-free space tree is enabled
-Disabling free space cache and enabling free space tree
-free space tree is enabled
-Trying to mount without free space tree
-mount failed
-mount failed
-Mounting existing free space tree
-free space tree is enabled
-free space tree is enabled
-Recreating free space tree
-free space tree is enabled
-free space tree is enabled
-Disabling free space tree
-free space tree is disabled
-Reverting to free space cache
-free space tree is disabled
-- 
2.43.0


