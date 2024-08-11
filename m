Return-Path: <linux-btrfs+bounces-7107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4959594E3DE
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2024 01:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DE91F21305
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FFC167DB7;
	Sun, 11 Aug 2024 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SCWHHWd5";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SCWHHWd5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD871547D6
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 23:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723419361; cv=none; b=fQNMUaNiPdmZzcJYSR5dIbAKiSQc9kx8WlqmedVrGa2Ch6DghkvmgUQkv9qnwQJBE8CFO3TzMPB5RYIBFQKDGV7VQ8qRXRL3Xl93MST6XtEIGcuRVyBiAjgWBw+NgYtPFPqOxcNIbaZq4RELh7I2BzcrJ8piwh9gkTNv8DGiLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723419361; c=relaxed/simple;
	bh=8CfocXQ0CArsPO3l6XiL/PiiViEKHpKrS5JC4sVGcYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIQUkcVtIDZQlC9qDoKNTfl64U7MS/KO6gRdh2KNINhNN2INhxEUwOnr1OchT0Q+1wgnVRhWwMh5NCQ0VZiqoSqo9syREGQ4IJv71ymp7SFa34G6ywGFm2sW1mEDBvZcRUfte9rWFJkZOSS1/5Ofdhy8mRRs22A85qww5/IbR6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SCWHHWd5; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SCWHHWd5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6933B2241C;
	Sun, 11 Aug 2024 23:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723419357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MY2vdinZQLPTQUHDlK7JNARh+y71D1VouXrosgSmIL0=;
	b=SCWHHWd5sGOxUf/CwSVuDfO+BChqvMJaBrz5i2ZHRdXO5SmNY+D5jjNg11CyO/W61OMKyt
	SmInQ44ca0SQ003/MPnwxuEGVe+ugYc5q8X4lmXO3so34HqhS/qatDnyZpC8Wvg7LFAr4t
	BBGKuMkwljgnx1TQOScswblT1M6niC8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723419357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=MY2vdinZQLPTQUHDlK7JNARh+y71D1VouXrosgSmIL0=;
	b=SCWHHWd5sGOxUf/CwSVuDfO+BChqvMJaBrz5i2ZHRdXO5SmNY+D5jjNg11CyO/W61OMKyt
	SmInQ44ca0SQ003/MPnwxuEGVe+ugYc5q8X4lmXO3so34HqhS/qatDnyZpC8Wvg7LFAr4t
	BBGKuMkwljgnx1TQOScswblT1M6niC8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4867113704;
	Sun, 11 Aug 2024 23:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id clq4ANxKuWZJHQAAD6G6ig
	(envelope-from <wqu@suse.com>); Sun, 11 Aug 2024 23:35:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Kota <nospam@kota.moe>
Subject: [PATCH] btrfs: tree-checker: reject BTRFS_FT_UNKNOWN dir type
Date: Mon, 12 Aug 2024 09:05:34 +0930
Message-ID: <f8cf038608f5da4a94d95f435cc24065afb2c21f.1723419296.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[REPORT]
There is a bug report that kernel is rejecting a mismatching inode mode
and its dir item:

[ 1881.553937] BTRFS critical (device dm-0): inode mode mismatch with
dir: inode mode=040700 btrfs type=2 dir type=0

[CAUSE]
It looks like the inode mode is correct, while the dir item type
0 is BTRFS_FT_UNKNOWN, which should not be generated by btrfs at all.

This may be caused by a memory bit flip.

[ENHACENMENT]
Although tree-checker is not able to do any cross-leaf verification, for
this particular case we can at least reject any dir type with
BTRFS_FT_UNKNOWN.

So here we enhance the dir type check from [0, BTRFS_FT_MAX), to (0,
BTRFS_FT_MAX).
Although the existing corruption can not be fixed just by such enhanced
checking, it should prevent the same 0x2->0x0 bitflip for dir type to
reach disk in the future.

Reported-by: Kota <nospam@kota.moe>
Link: https://lore.kernel.org/linux-btrfs/CACsxjPYnQF9ZF-0OhH16dAx50=BXXOcP74MxBc3BG+xae4vTTw@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 3e8fbedfe04d..634d69964fe4 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -569,9 +569,10 @@ static int check_dir_item(struct extent_buffer *leaf,
 
 		/* dir type check */
 		dir_type = btrfs_dir_ftype(leaf, di);
-		if (unlikely(dir_type >= BTRFS_FT_MAX)) {
+		if (unlikely(dir_type <= BTRFS_FT_UNKNOWN ||
+			     dir_type >= BTRFS_FT_MAX)) {
 			dir_item_err(leaf, slot,
-			"invalid dir item type, have %u expect [0, %u)",
+			"invalid dir item type, have %u expect (0, %u)",
 				dir_type, BTRFS_FT_MAX);
 			return -EUCLEAN;
 		}
-- 
2.45.2


