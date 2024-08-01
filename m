Return-Path: <linux-btrfs+bounces-6946-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E494440C
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 08:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7721E1C21EAF
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Aug 2024 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F80116C695;
	Thu,  1 Aug 2024 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R+ZNOxlT";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="R+ZNOxlT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D870F1917FE
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492794; cv=none; b=B0y8JLE1VNys+ePshvU5vcWuOqkMH14kcM9wOPiwAg4Ywba+mO2g1CdfxhCy9XwCkNKiDk1i0FBPhq5a8QqlD6/BN/nnFQZJiI+bBBrmgsFtTj0+xgBUd1Tu0zeeDVXutEsVsn69Hp29kglHjjro4nZTADM4IkT0gMk8VESt7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492794; c=relaxed/simple;
	bh=udE85QEdI72r7XQlktjzYAfiHHBlPAWtwlvWt91GnLU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inCMsjgYCyad6+H3YtVGyE38yK+qotfqKI1KF6mW291lpaTFvCL5FH4RCmkNjug9+FVlqFPHRiCOuVjM+HPqZXe0ondQuTAY4UebCvQPyN3cGAwrXkQGKE9Msof6/6WI0Ft6yYr0a9fXaB8mh4/fEKrvcp13c+OHK5p5uaDMwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R+ZNOxlT; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=R+ZNOxlT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 354D321A9F
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAnH2ob4npwMJrCgjkWyIatYCtHDMsplTrdFQVW1qPc=;
	b=R+ZNOxlTdbWnbfihTXv/1drgExG8NQ6A33XyzD7EVRFjIB8gv+WQTk82ZtrMg36b+Re0TF
	xwI5arm6zd46HoRzchunBYDRhUcEB3xE0d0V2bKtnGT8/LpguNnIPgL3ONY90fz8LaAtwR
	0sxRugM/ye1qHlYFd2uSASuc8WgHBZg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1722492791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YAnH2ob4npwMJrCgjkWyIatYCtHDMsplTrdFQVW1qPc=;
	b=R+ZNOxlTdbWnbfihTXv/1drgExG8NQ6A33XyzD7EVRFjIB8gv+WQTk82ZtrMg36b+Re0TF
	xwI5arm6zd46HoRzchunBYDRhUcEB3xE0d0V2bKtnGT8/LpguNnIPgL3ONY90fz8LaAtwR
	0sxRugM/ye1qHlYFd2uSASuc8WgHBZg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4EE3613946
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Aug 2024 06:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SNmzAnYnq2ZkaQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 01 Aug 2024 06:13:10 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs-progs: mkfs-tests: verify cross mount point behavior for rootdir
Date: Thu,  1 Aug 2024 15:42:40 +0930
Message-ID: <c8a14aa2b640d79fd60a14883a4f4c705292c1e6.1722492491.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722492491.git.wqu@suse.com>
References: <cover.1722492491.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [0.40 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: 0.40

The new test case creates a special layout like this:

rootdir/	(fs1 ino=256)
|- dir1/	(fs1 ino=257)
|  |- dir1/	(fs2 ino=257)
|  |- dir2/	(fs2 ino=258)
|  |- file1	(fs2 ino=259)
|  |- file2	(fs2 ino=260)
|- dir2/	(fs1 ino=258)
|- file1	(fs1 ino=259)
|- file2	(fs2 ino=259)

This layout intentionally creates inode number conflicts, which will
make the old "mkfs.btrfs --rootdir" to fail.
But newer reworked one will successfully handle them, just leave a test
case to avoid to hit the old bugs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 .../035-rootdir-cross-mount/test.sh           | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100755 tests/mkfs-tests/035-rootdir-cross-mount/test.sh

diff --git a/tests/mkfs-tests/035-rootdir-cross-mount/test.sh b/tests/mkfs-tests/035-rootdir-cross-mount/test.sh
new file mode 100755
index 000000000000..0215f7223356
--- /dev/null
+++ b/tests/mkfs-tests/035-rootdir-cross-mount/test.sh
@@ -0,0 +1,46 @@
+#!/bin/bash
+#
+# Test if "mkfs.btrfs --rootdir" would handle a rootdir with subdirectories
+# on another fs.
+
+source "$TEST_TOP/common" || exit
+
+setup_root_helper
+
+# Here we need 3 devices, one for the rootdir, one for a subdirectory of
+# rootdir. This is to ensure we have conflicting inode numbers among the
+# two filesystems.
+# The last device is the for the mkfs.
+setup_loopdevs 3
+prepare_loopdevs
+
+dev1=${loopdevs[1]}
+dev2=${loopdevs[2]}
+dev3=${loopdevs[3]}
+tmpdir=$(_mktemp_dir mkfs-rootdir-cross-mount)
+
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev1"
+run_check $SUDO_HELPER "$TOP/mkfs.btrfs" -f "$dev2"
+
+# Populate both fs with the same contents. So that we're ensured
+# to have conflicting inode numbers.
+for i in "$dev1" "$dev2"; do
+	run_check $SUDO_HELPER mount -t btrfs "$i" "$tmpdir"
+	mkdir "$tmpdir/dir1" "$tmpdir/dir2"
+	touch "$tmpdir/file1" "$tmpdir/file2"
+	run_check $SUDO_HELPER umount "$tmpdir"
+done
+
+
+run_check $SUDO_HELPER mount -t btrfs "$dev1" "$tmpdir"
+run_check $SUDO_HELPER mount -t btrfs "$dev2" "$tmpdir/dir1"
+
+# The old rootdir implementation relies on the st_ino from the host fs, but
+# doesn't do any cross-mount check, it would result conflicting inode numbers
+# and fail.
+run_check "$TOP/mkfs.btrfs" --rootdir "$tmpdir" -f "$dev3"
+run_check $SUDO_HELPER umount "$tmpdir/dir1"
+run_check $SUDO_HELPER umount "$tmpdir"
+run_check "$TOP/btrfs" check "$dev3"
+rm -rf -- "$tmpdir"
+cleanup_loopdevs
-- 
2.45.2


