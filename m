Return-Path: <linux-btrfs+bounces-16919-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D3B841F5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 12:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 087257ACBE3
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C882E5B19;
	Thu, 18 Sep 2025 10:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pW9Musbv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pW9Musbv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D032E1F03
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 10:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758191574; cv=none; b=uz3slc1PXk+ThVSo4qRTkIYwCw6Dsrq6zOpH91jUn0LWsIVCBznBHxXnaQbj2cKx5XrG4dg07jZMCWzVNAd138Bg4l0533phSTGu8hLWvFm7f7sFQksIoxGDZ45Z7u/iwBYbHZYzyetjPMwKUhfjK4suFd1cwraTftKGgtERuj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758191574; c=relaxed/simple;
	bh=kX8t7uvBUcmAS0p2fCmycLmHr50WHYRwBtymn7wuDKA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RVcSEWgaGw7y6IfSwEvfZkjGqo4yjNJJ1LDKRJLATnLPvHNkOhzPLLOpwzmVpVvDt5H5WW6IFtFrq9THxrSqcJsm9X/6Ir14jkQjT4yixzNShtEcNOhbRI33/X7jXjyTZnPibZAEXWbIo9YioEg0ej8s4lPJhfcaZ+ZjwsGvdsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pW9Musbv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pW9Musbv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5566333864;
	Thu, 18 Sep 2025 10:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758191569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6gFwhABI7Rpc/1PTUTu9+GLBvZdl+23FmBmMPlYecVs=;
	b=pW9MusbvvsnKmXZM/qieQoOxfGtaZNcT8DxxQ3cRm4R54SmQCX1SSUQCoa/tGAlAkcE52f
	w1VSiFOrCKhX4ccV6ZzwOSQzgjBlm+K3CbJr6E4tSWEOvOUe+CY8x1mckIeePVG+0JFffO
	nzcLF2howVTYG2Ktl2diRjK9iecUeaU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=pW9Musbv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1758191569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6gFwhABI7Rpc/1PTUTu9+GLBvZdl+23FmBmMPlYecVs=;
	b=pW9MusbvvsnKmXZM/qieQoOxfGtaZNcT8DxxQ3cRm4R54SmQCX1SSUQCoa/tGAlAkcE52f
	w1VSiFOrCKhX4ccV6ZzwOSQzgjBlm+K3CbJr6E4tSWEOvOUe+CY8x1mckIeePVG+0JFffO
	nzcLF2howVTYG2Ktl2diRjK9iecUeaU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55C5C13A39;
	Thu, 18 Sep 2025 10:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N9RKBtDfy2iebwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 18 Sep 2025 10:32:48 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH v2] btrfs: reject fs block size larger than 4K
Date: Thu, 18 Sep 2025 20:02:26 +0930
Message-ID: <20250918103226.99091-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5566333864
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

[BUG]
When running the experimental block size > page support, the test case
btrfs/192 fails with the following error:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
    --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
    +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
    @@ -1,2 +1,2 @@
     QA output created by 192
    -Silence is golden
    +ERROR: illegal nodesize 4096 (smaller than 8192)
    ...
    (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)

Please note that, btrfs bs > ps is still under development.
This is only an early run to expose false alerts.

[CAUSE]
The test case explicitly requires 4K nodesize to bump up tree size.

However if we use fs block size larger than 4K, the node size 4K will be
smaller than a block, causing mkfs failure, as block size is the minimal
unit for both data and metadata, thus node size smaller than block size
is illege.

[FIX]
Before calling mkfs on the log-writes dm device, do a simple mkfs and
mount of the scratch device, to verify the block size.

If the block size is larger than 4k, skip the test case.

And since we're here, remove the out-of-date page size check, as btrfs
has subpage block size support for a while.
Instead use a more accurate supported sector size check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Add the commit message on why we can remove the page size check

- Use _scratch_btrfs_sectorsize() so we do not need to mount/unmount
  scratch device

- Add the missing _require_btrfs_support_sectorsize call
---
 tests/btrfs/192 | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/btrfs/192 b/tests/btrfs/192
index 0a8ab2c1..a9a43cfe 100755
--- a/tests/btrfs/192
+++ b/tests/btrfs/192
@@ -33,10 +33,15 @@ _require_btrfs_mkfs_feature "no-holes"
 _require_log_writes
 _require_scratch
 _require_attrs
+_require_btrfs_support_sectorsize 4096
 
-# We require a 4K nodesize to ensure the test isn't too slow
-if [ $(_get_page_size) -ne 4096 ]; then
-	_notrun "This test doesn't support non-4K page size yet"
+_scratch_mkfs > /dev/null
+blksz=$(_scratch_btrfs_sectorsize $SCRATCH_MNT)
+
+# We need 4K nodesize, and if block size is larger than that mkfs will
+# fail. So reject any block size larger than 4K.
+if [ $blksz -gt 4096 ]; then
+	_notrun "This test requires block size 4096, has $blksz"
 fi
 
 runtime=30
-- 
2.51.0


