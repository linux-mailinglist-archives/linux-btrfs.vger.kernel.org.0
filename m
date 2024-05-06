Return-Path: <linux-btrfs+bounces-4769-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 079538BC9DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221C01C2145A
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88ACA1422A5;
	Mon,  6 May 2024 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YE2awZ49";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="YE2awZ49"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D614198A
	for <linux-btrfs@vger.kernel.org>; Mon,  6 May 2024 08:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985210; cv=none; b=W0t5SpGIBo1dd5mhsHOgWO5P6u/SGs1gYL8rxhenRZ88eeoNHvFn6RtZQxSuxNdNziJM1j5L+cdwbVrCYiMzM40spkeuLscITIrLKEifDOWzgEvZVwPC+sUGpzMMczo1H7iddgcx/CR9UG40C4Bj2+ifiqYLLNcAsRAdDkDG5DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985210; c=relaxed/simple;
	bh=d5qoNo627rLeEMCRQ4cC4volZpXFXkogo3PABABLp8o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=esQUNQiuu+LhrYZzpQQJ0GWvplhydoRFapkbk76jMHoiN2sQAlvGErTXk7nrp3uHX2vRcpAQhVDBUdgxmSO28aYCb/uk/ZHDvd7Yf+A8/PkwR+rsKs0oZSQWaK2Jc+/UkauNBpEDzfqMP4vhP2LH2VmoE7A3+foltIFZi7daYGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YE2awZ49; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=YE2awZ49; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3981F38090;
	Mon,  6 May 2024 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714985207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Arcnhcch/fCLbGmmur/JznAU1Y91bYBWyW9fn0P7z9I=;
	b=YE2awZ49Kq2xW68BJLlTPEX0S7z4kP9Ez/7IQGqkdQiWP0ZVbXJ/aY02t1fTTWUsOATUNt
	GFJkjkIpNT65zAqPWNy8kSWibKYemav786MsLlyMbsiPLFL1VX7aUpedvxa6O2QjtrJM9r
	8fpXDJdknAFwfCP7kzaj1z/7mr3hDZ8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=YE2awZ49
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714985207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Arcnhcch/fCLbGmmur/JznAU1Y91bYBWyW9fn0P7z9I=;
	b=YE2awZ49Kq2xW68BJLlTPEX0S7z4kP9Ez/7IQGqkdQiWP0ZVbXJ/aY02t1fTTWUsOATUNt
	GFJkjkIpNT65zAqPWNy8kSWibKYemav786MsLlyMbsiPLFL1VX7aUpedvxa6O2QjtrJM9r
	8fpXDJdknAFwfCP7kzaj1z/7mr3hDZ8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E96E21386E;
	Mon,  6 May 2024 08:46:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uGiPKPWYOGbkcwAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 06 May 2024 08:46:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Jiri Belka <jiri.belka@suse.com>
Subject: [PATCH] btrfs-progs: mkfs: skip failed mount check
Date: Mon,  6 May 2024 18:16:27 +0930
Message-ID: <18c376d5ab4aa2c2088a0e204d14bb5331fe052f.1714985184.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:url,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3981F38090
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

[BUG]
There is a bug report that, with very weird mount status, there can be
some mount source which can not be accessed:

  /hana/shared/QD2/global/hdb/security/ssfs secfs2 500G 57G 444G 12% /hana/shared/QD2/global/hdb/security/ssfs

Strace shows we can not access the above mount source:

 131065 stat("/hana/shared/QD2/global/hdb/security/ssfs", 0x7ffed17b8e20) = -1 EACCES (Permission denied)

And lead to failed mount check:

 131065 write(2, "ERROR: ", 7)      = 7
 131065 write(2, "cannot check mount status of /de"..., 56) = 56
 131065 write(2, "\n", 1)        = 1

[CAUSE]
The mounted check is based on libblid, which gives the mount source, and
for non-btrfs mounts, we call path_is_reg_or_block_device() to check if
we even need to continue checking.

But in above case, the mount source is secfs2, and we can not access the
source.

So we error out causing the check_mounted() to return error.

[FIX]
There is never any guarantee we can access the mount source, but on the
other hand, I do not want to ignore all access failure for the mount
source.

So this patch would let test_status_for_mkfs() to only skip
check_mounted() error if @force_overwrite is true.

This would still keep the old strict checks on whether the target is
already mounted, but if the end user really knows that certain mount
source do not need to be checked, they can always pass "-f" option to
skip the false alerts.

Link: https://bugzilla.suse.com/show_bug.cgi?id=1223799
Reported-by: Jiri Belka <jiri.belka@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mkfs/common.c b/mkfs/common.c
index 3c48a6c120e7..314520397662 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -1129,6 +1129,12 @@ bool test_status_for_mkfs(const char *file, bool force_overwrite)
 	ret = check_mounted(file);
 	if (ret < 0) {
 		errno = -ret;
+		if (force_overwrite) {
+			error(
+		"cannot check mount status of %s (%m), skipping the check.",
+			      file);
+			return false;
+		}
 		error("cannot check mount status of %s: %m", file);
 		return true;
 	}
-- 
2.45.0


