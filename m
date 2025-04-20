Return-Path: <linux-btrfs+bounces-13180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED480A94746
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 10:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B38169F09
	for <lists+linux-btrfs@lfdr.de>; Sun, 20 Apr 2025 08:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4241E411D;
	Sun, 20 Apr 2025 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X7fntLqk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X7fntLqk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2CF19D080
	for <linux-btrfs@vger.kernel.org>; Sun, 20 Apr 2025 08:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745138328; cv=none; b=Khhp4LG5AfJfoiSxw8Y7Qou05f5MNszz+SIgU/C25ROhMqKBT6jaF/FnmGZQbNmGbQy3EaAQd+wWfT8onKTj+GzlPC1NXNXl8//kmSTz/mTa+Ia72QIV/KVSha0Fwi2vvzE1WWun/V4Gv4GYJ6W9Iup548CuI914v1PlRGSyrYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745138328; c=relaxed/simple;
	bh=7SacXj0ppJHrd3JqbZ3wcg5uhpKyxM6dtqOh2hLXuKg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mW1Ed/WcB/9Fktv9tqXMrwLDslvKCfp/X24RQLSZCo+/MQGU6i8l65GKqaO0UkSuLV3QPZqCNYzsQcrE8/Oq2MUe/m52EaurFI4JGhQzq+ahjl3qD7d6Wyoh2WrO2A9yh5gbgegpiarUXNQ7CG5OUi2fIa9u0me3fWkHKTU3zh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X7fntLqk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X7fntLqk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7292F1F388;
	Sun, 20 Apr 2025 08:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745138324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wwIJfCHL2yx0A2NlFBraGo4Z2wQTFJNk1UyTGy00cU0=;
	b=X7fntLqklFcD63rAjyI6xOeIHsej8eSV5Xd1mehJEoR0pAkq/71FK9PmX3U66ic4X4i/gX
	gZxJyBjEtjD26NZ0QfAcoEzQ/2F4JECmhCHq5yHuzSeByEsv7N0UFgZjhFd9K5lrwypby1
	Lzm53/onn6RUSd78HRvvdFapRPWY+QA=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745138324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wwIJfCHL2yx0A2NlFBraGo4Z2wQTFJNk1UyTGy00cU0=;
	b=X7fntLqklFcD63rAjyI6xOeIHsej8eSV5Xd1mehJEoR0pAkq/71FK9PmX3U66ic4X4i/gX
	gZxJyBjEtjD26NZ0QfAcoEzQ/2F4JECmhCHq5yHuzSeByEsv7N0UFgZjhFd9K5lrwypby1
	Lzm53/onn6RUSd78HRvvdFapRPWY+QA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79235137CF;
	Sun, 20 Apr 2025 08:38:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lFJeD5OyBGgrIAAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 20 Apr 2025 08:38:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] fstests: btrfs/253: fix false alert due to _set_fs_sysfs_attr changes
Date: Sun, 20 Apr 2025 18:08:17 +0930
Message-ID: <20250420083817.231610-1-wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[FALSE FAILURE]
Test btrfs/253 now fails like the following:

btrfs/253 2s ... - output mismatch (see ~/xfstests/results//btrfs/253.out.bad)
    --- tests/btrfs/253.out	2022-05-11 11:25:30.753333331 +0930
    +++ ~/xfstests/results//btrfs/253.out.bad	2025-04-20 17:28:39.139180394 +0930
    @@ -5,6 +5,7 @@
     Calculate request size so last memory allocation cannot be completely fullfilled.
     Third allocation.
     Force allocation of system block type must fail.
    +./common/rc: line 5213: echo: write error: No space left on device
     Verify first allocation.
     Verify second allocation.
     Verify third allocation.
    ...
    (Run 'diff -u ~/xfstests/tests/btrfs/253.out ~/xfstests/results//btrfs/253.out.bad'  to see the entire diff)

[CAUSE]
Since commit 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr:
redirect errors to stdout") the function _set_fs_sysfs_attr() always
output everything into stdout, thus the stderr redirection makes no
sense anymore.

And the expected failure will cause output difference and fail the test.

[FIX]
Instead of the useless re-direct of stderr, save the stdout and check if
it contains the word "error" to determine if it failed.

Fixes: 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/253 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/253 b/tests/btrfs/253
index adbc6bfb..ad69dfe1 100755
--- a/tests/btrfs/253
+++ b/tests/btrfs/253
@@ -228,7 +228,12 @@ alloc_size "Data" FOURTH_DATA_SIZE_MB
 # Force chunk allocation of system block type must fail.
 #
 echo "Force allocation of system block type must fail."
-_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1 2>/dev/null
+output=$(_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1)
+
+if ! echo "$output" | grep -q "error" ; then
+	echo "Force allocation succeeded unexpectedly."
+	echo "$output" >> $seqres.full
+fi
 
 #
 # Verification of initial allocation.
-- 
2.47.1


