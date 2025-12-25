Return-Path: <linux-btrfs+bounces-20007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81208CDE209
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 23:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1560300956D
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Dec 2025 22:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FE19992C;
	Thu, 25 Dec 2025 22:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BPz38EPR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Uc+q1+sh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EAE13D891
	for <linux-btrfs@vger.kernel.org>; Thu, 25 Dec 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766700992; cv=none; b=Gh5U6MOLwWFxRfd1jm848AVDldTRu+h/OxaxqZP8hcYUFr+zFhPGRXMXS55M+MXl22Om0ko+SEpYEknhJqAxEvtpf71R8Tf4/ANaj7EEKalk38uavHHbPkhBY9fQxR9i4w0sUqxiBUJy4PnHbDlgNU3Z4OzsQBYvqva4I6GwMpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766700992; c=relaxed/simple;
	bh=ov3mluCXKqtosyJEVlRl2VYn+0vFGNLSGfibG5pyo14=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7azZnEaOUxWHVyDqHq3j+4mjDt441x7sxN0SOkuvopjOhJ5+Iq7ibs7s1RT7FFFjDEZEUuABKTyU5OlS9n4RARQ4NPxxUmbs8C6zeHvagbwcfhs56+f56V+KJhkwCmPbcpXGvA7874+d1OukKpzVRiP9lZd0o7+B/s5BX9Ctxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BPz38EPR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Uc+q1+sh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB9EA5BD57;
	Thu, 25 Dec 2025 22:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766700984; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwaUsWrdJnjcJgzael7gqw68Jjzmrh5kDAHj5hjB6D4=;
	b=BPz38EPRp9e9jjMxHY0vGH+wrANfF8ICx5yVmjSVNq6Y3xghmrmyPxJCbreI5qHwZfWvf8
	DIA5wI/knlALrFLRcRG9vkYVOyOmFuUoL0geNqVIW5831npLH43zhSVxD0R6C4mOdvQR85
	nvG0+BJl1k6XkluVJQjLlMMYf0ZbJgA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Uc+q1+sh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1766700982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwaUsWrdJnjcJgzael7gqw68Jjzmrh5kDAHj5hjB6D4=;
	b=Uc+q1+shXmcNlgAqZe0CNDHgVXvy3uXzSm9KO+CCnIs/t3d+qhrE0m8EdNjC6NSx8nFitd
	DQ+5Qtro2gSRr5A3UJ0XIpHlOuINsMMZh2hrCNF3U8hHy+MiIPBc6L9qphHld6uipOnMq0
	16N8xSJFqXKBDz4HjfxFaSH6VPuad9E=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C62313EA63;
	Thu, 25 Dec 2025 22:16:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KKvEIbW3TWlCSgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 25 Dec 2025 22:16:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH 2/2] fstests: btrfs: add a new test case that is future-proof
Date: Fri, 26 Dec 2025 08:45:53 +1030
Message-ID: <20251225221553.19254-3-wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251225221553.19254-1-wqu@suse.com>
References: <20251225221553.19254-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: CB9EA5BD57
X-Spam-Flag: NO
X-Spam-Score: -4.01

Btrfs' v1 space cache is marked deprecated since commit 1e7bec1f7d65
("btrfs: emit a warning about space cache v1 being deprecated"), and
soon the v1 space cache mount option will be fully dropped.

Furthermore existing features like block-group-tree, zoned, and bs != ps
support are all rejecting v1 space cache or forcing the switch to v2
space cache.

The existing btrfs/131 is not going to handle the future well, and that
test case is mostly for LTS kernel testing now.

Add a new test case that is completely v1 cache free, so that it will
support the future where v1 cache is completely dropped, meanwhile still
keep the coverage for v2 cache and nospace_cache mount options.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/131     |   5 ++-
 tests/btrfs/340     | 103 ++++++++++++++++++++++++++++++++++++++++++++
 tests/btrfs/340.out |  15 +++++++
 3 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100755 tests/btrfs/340
 create mode 100644 tests/btrfs/340.out

diff --git a/tests/btrfs/131 b/tests/btrfs/131
index 026d11e6..b54b8326 100755
--- a/tests/btrfs/131
+++ b/tests/btrfs/131
@@ -4,7 +4,10 @@
 #
 # FS QA Test 131
 #
-# Test free space tree mount options.
+# Test free space tree mount options, 3 options involved:
+# - No space cache
+# - Old (deprecated) v1 space cache
+# - New (default) v2 space cache
 #
 . ./common/preamble
 _begin_fstest auto quick
diff --git a/tests/btrfs/340 b/tests/btrfs/340
new file mode 100755
index 00000000..0d558422
--- /dev/null
+++ b/tests/btrfs/340
@@ -0,0 +1,103 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
+#
+# FS QA Test 340
+#
+# Test free space tree mount options, for newer kernels with only 2 options involed:
+# - No space cache
+# - New (default) v2 space cache
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_require_scratch
+_require_btrfs_command inspect-internal dump-super
+_require_btrfs_fs_feature free_space_tree
+
+# The block-group-tree feature relies on v2 cache, thus it doesn't support
+# "nospace_cache" mount option.
+_require_btrfs_no_block_group_tree
+
+mkfs_nocache()
+{
+	_scratch_mkfs >/dev/null 2>&1
+	_scratch_mount -o clear_cache,nospace_cache
+	_scratch_unmount
+}
+
+mkfs_v2()
+{
+	_scratch_mkfs >/dev/null 2>&1
+	_scratch_mount -o space_cache=v2
+	_scratch_unmount
+}
+
+check_fst_compat()
+{
+	compat_ro="$($BTRFS_UTIL_PROG inspect-internal dump-super "$SCRATCH_DEV" | \
+		     sed -rn 's/^compat_ro_flags\s+(.*)$/\1/p')"
+	if ((compat_ro & 0x1)); then
+		echo "free space tree is enabled"
+	else
+		echo "free space tree is disabled"
+	fi
+}
+
+# Mount options might interfere.
+export MOUNT_OPTIONS=""
+
+# When the free space tree is not enabled:
+# -o space_cache=v2: enable the free space tree
+# -o clear_cache,space_cache=v2: clear the old space cache and enable the free space tree
+# We don't check the no options case or plain space_cache as that will change
+# in the future to turn on space_cache=v2.
+
+mkfs_nocache
+echo "Using no space cache"
+_scratch_mount -o nospace_cache
+check_fst_compat
+_scratch_unmount
+
+mkfs_nocache
+echo "Enabling free space tree"
+_scratch_mount -o space_cache=v2
+check_fst_compat
+_scratch_unmount
+
+# When the free space tree is enabled:
+# -o nospace_cache: error
+# no options, -o space_cache=v2: keep using the free space tree
+# -o clear_cache, -o clear_cache,space_cache=v2: clear and recreate the free space tree
+# -o clear_cache,nospace_cache: clear the free space tree
+
+mkfs_v2
+echo "Trying to mount without free space tree"
+_try_scratch_mount -o nospace_cache >/dev/null 2>&1 || echo "mount failed"
+
+mkfs_v2
+echo "Mounting existing free space tree"
+_scratch_mount
+check_fst_compat
+_scratch_unmount
+_scratch_mount -o space_cache=v2
+check_fst_compat
+_scratch_unmount
+
+mkfs_v2
+echo "Recreating free space tree"
+_scratch_mount -o clear_cache,space_cache=v2
+check_fst_compat
+_scratch_unmount
+mkfs_v2
+_scratch_mount -o clear_cache
+check_fst_compat
+_scratch_unmount
+
+mkfs_v2
+echo "Disabling free space tree"
+_scratch_mount -o clear_cache,nospace_cache
+check_fst_compat
+_scratch_unmount
+
+_exit 0
diff --git a/tests/btrfs/340.out b/tests/btrfs/340.out
new file mode 100644
index 00000000..d8b99b3b
--- /dev/null
+++ b/tests/btrfs/340.out
@@ -0,0 +1,15 @@
+QA output created by 340
+Using no space cache
+free space tree is disabled
+Enabling free space tree
+free space tree is enabled
+Trying to mount without free space tree
+mount failed
+Mounting existing free space tree
+free space tree is enabled
+free space tree is enabled
+Recreating free space tree
+free space tree is enabled
+free space tree is enabled
+Disabling free space tree
+free space tree is disabled
-- 
2.51.2


