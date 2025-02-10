Return-Path: <linux-btrfs+bounces-11360-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957E7A2EAEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 12:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426201883433
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 11:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85141DFE11;
	Mon, 10 Feb 2025 11:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3oOddQs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GYP4yQMG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="B3oOddQs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GYP4yQMG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362941DF735
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739186314; cv=none; b=cf+UtXqJMZptd1hfwgonvLL75Fyf6Esd437fdzo6BTTfNaLot0pRBKq93SI5FhbG7qG/GJIOBOD1YSuJAFjsRx3+XZ77AzI540dEbxqHmrTULnwJ2ejn1XbEvkyq5m5M6w/vslcf27Qoh1JIWVLQgKqRVRZssFRduiuCNCZNSus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739186314; c=relaxed/simple;
	bh=mAHjQiYxm8BPQAWoZ8d4fCwJGpFA0zAP+ytR55mCbjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goMspUkl8iUG8C+lvl2ZXiVRqJckcDE6KGcyMZK7MF8S3oVix5mck3o5Q66oCrv9UKwzCOsI1W3PmxkofyUN41HxeQAMTnro07TvAiMzKPkTnjzY1wDRN8Rw1t3a39QrBW55GygiiLi/SmXg/iKs/f140FvNAy7cUnLrGRvfcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3oOddQs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GYP4yQMG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=B3oOddQs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GYP4yQMG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 58A1D1F390;
	Mon, 10 Feb 2025 11:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739186311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3piFuFiRIngvqraizzFA9j08Z0HdUjDgUICuFRbQEaI=;
	b=B3oOddQsMmLP5K+gAcJeGYWHyZmpOWzSlT1q02Z7PhBeST+czTBYmk3mDBTh9NSq7SUdlP
	006D1+rwgTNAoI0WQjhCKUs2Qlau172iAkrGQdbAGJJIk0IqeN0WKukdmeZ9XO8DjwXIsN
	xMKV0nEo+HxkfYH4vfJQ6MoXu5T0ruI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739186311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3piFuFiRIngvqraizzFA9j08Z0HdUjDgUICuFRbQEaI=;
	b=GYP4yQMG3frhr6xyujMuaFOD5MBFwjm5kVhPoLCt3oKV9gXUADlhvy1hMhjxad/gtp4YKI
	2TYA6RrxtDrxSvCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739186311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3piFuFiRIngvqraizzFA9j08Z0HdUjDgUICuFRbQEaI=;
	b=B3oOddQsMmLP5K+gAcJeGYWHyZmpOWzSlT1q02Z7PhBeST+czTBYmk3mDBTh9NSq7SUdlP
	006D1+rwgTNAoI0WQjhCKUs2Qlau172iAkrGQdbAGJJIk0IqeN0WKukdmeZ9XO8DjwXIsN
	xMKV0nEo+HxkfYH4vfJQ6MoXu5T0ruI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739186311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3piFuFiRIngvqraizzFA9j08Z0HdUjDgUICuFRbQEaI=;
	b=GYP4yQMG3frhr6xyujMuaFOD5MBFwjm5kVhPoLCt3oKV9gXUADlhvy1hMhjxad/gtp4YKI
	2TYA6RrxtDrxSvCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30B5413A62;
	Mon, 10 Feb 2025 11:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hHp/NoXgqWc4XQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 10 Feb 2025 11:18:29 +0000
From: David Disseldorp <ddiss@suse.de>
To: linux-btrfs@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>
Subject: [PATCH] btrfs: fix btrfs_test_delayed_refs leak
Date: Mon, 10 Feb 2025 22:17:29 +1100
Message-ID: <20250210111728.32320-2-ddiss@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The btrfs_transaction struct leaks, which can cause sporadic xfstests
failures when kmemleak checking is enabled:

kmemleak: 5 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff88810fdc6c00 (size 512):
  comm "modprobe", pid 203, jiffies 4294892552
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 6736050f):
    __kmalloc_cache_noprof+0x133/0x2c0
    btrfs_test_delayed_refs+0x6f/0xbb0 [btrfs]
    btrfs_run_sanity_tests.cold+0x91/0xf9 [btrfs]
    0xffffffffa02fd055
    do_one_initcall+0x49/0x1c0
    do_init_module+0x5b/0x1f0
    init_module_from_file+0x70/0x90
    idempotent_init_module+0xe8/0x2c0
    __x64_sys_finit_module+0x6b/0xd0
    do_syscall_64+0x54/0x110
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The transaction struct was initially stack-allocated but switched to
heap following frame size compiler warnings.

Fixes: 2b34879d97e27 ("btrfs: selftests: add delayed ref self test cases")
Link: https://lore.kernel.org/all/20241206195100.GM31418@twin.jikos.cz/
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 fs/btrfs/tests/delayed-refs-tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/btrfs/tests/delayed-refs-tests.c b/fs/btrfs/tests/delayed-refs-tests.c
index 6558508c2ddf5..265370e79a546 100644
--- a/fs/btrfs/tests/delayed-refs-tests.c
+++ b/fs/btrfs/tests/delayed-refs-tests.c
@@ -1009,6 +1009,7 @@ int btrfs_test_delayed_refs(u32 sectorsize, u32 nodesize)
 	if (!ret)
 		ret = select_delayed_refs_test(&trans);
 
+	kfree(transaction);
 out_free_fs_info:
 	btrfs_free_dummy_fs_info(fs_info);
 	return ret;
-- 
2.43.0


