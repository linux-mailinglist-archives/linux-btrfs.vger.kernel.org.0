Return-Path: <linux-btrfs+bounces-15071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D42AED218
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916383B46E9
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 01:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F2634EC;
	Mon, 30 Jun 2025 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jegJijsS";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hdMWUY0S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225823CB
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751245400; cv=none; b=J/EY3bQbGe4KxKQtChFpxFmYY03nmMuxwz9fxaRjNMdmMVZZrJhrvWvu8B2MAg5Eor+uHdcht8XjMpZXQVyKe2/MTPORowd/ufJVMDTr4sG4vPRvk2rCy+28UuS+KV1DHnFS64MxtB051JlU6V8l+YJaLApgR7lQG/+/Kr3jcyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751245400; c=relaxed/simple;
	bh=SEa/0c+X9U0vG+KH4a7y7+yoeAX4p+rS7xCm6TQo1Os=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=dw01mEkgkmQfm/osSUSaDTPOOCYnLM9DTjnbR8YomwwE/ZX4qkKHkhkaDdqrNAjLuaruFdl5SdxcpRq36nmzQsDfAbJH/YlcSBJhigYbn5E0vneU63vAN4A39hlFlaz5ABfJYQcuTTFo8qPLy2ujCW9u6tYrHkzxUqB1iA20kYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jegJijsS; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hdMWUY0S; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D36201F390;
	Mon, 30 Jun 2025 01:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751245396; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1Msxn02wfSYghSKw3RVk1xzcWgP/tRxhG+du95QF1p0=;
	b=jegJijsSE5K5Hu+P/UrMcry4e+hvoBUy6TJ7q5lWLlgzq2nNvyhTfCsO85OVJQOteA8cty
	Hi8TQB6fcb4dUvvQodQvu4i9Ti51HCo4uoqKG/+mWZqWM+EPGfgHiSiQbYRXmVJNcuxWJl
	RQuLHyZR6V1NJBX4KNAgBoXBUAuG8CQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hdMWUY0S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751245395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=1Msxn02wfSYghSKw3RVk1xzcWgP/tRxhG+du95QF1p0=;
	b=hdMWUY0Saq0v2+wvUp822bDQt/ABttOgWSRkW5zcsvGX9jaU/zQwx/jF9URjCVXsWg8dOW
	x+qEqwMuFWKQi3Qrk0Lr9RV5KAnSA7WKm/m0kv28OOcLXJEb/Vr2/tk33tu3+DlAJp1Ux4
	KXicaMc7m/jFwNZqFwWWf5TGpfJWpgU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFD111369C;
	Mon, 30 Jun 2025 01:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pRGjI1LiYWjCCAAAD6G6ig
	(envelope-from <wqu@suse.com>); Mon, 30 Jun 2025 01:03:14 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Subject: [PATCH] common: add proper btrfs log tree detection to _has_metadata_journaling
Date: Mon, 30 Jun 2025 10:32:53 +0930
Message-ID: <20250630010253.30075-1-wqu@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D36201F390
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:dkim,suse.com:email]
X-Spam-Score: -3.01
X-Spam-Level: 

[BUG]
With the incoming btrfs shutdown ioctl/remove_bdev callback support,
btrfs can be tested with the shutdown group.

But test case generic/050 still fails on btrfs with shutdown support:

generic/050 1s ... - output mismatch (see /home/adam/xfstests/results//generic/050.out.bad)
    --- tests/generic/050.out	2022-05-11 11:25:30.763333331 +0930
    +++ /home/adam/xfstests/results//generic/050.out.bad	2025-06-30 10:22:21.752068622 +0930
    @@ -13,9 +13,7 @@
     setting device read-only
     mounting filesystem that needs recovery on a read-only device:
     mount: device write-protected, mounting read-only
    -mount: cannot mount device read-only
     unmounting read-only filesystem
    -umount: SCRATCH_DEV: not mounted
     mounting filesystem with -o norecovery on a read-only device:
    ...
    (Run 'diff -u /home/adam/xfstests/tests/generic/050.out /home/adam/xfstests/results//generic/050.out.bad'  to see the entire diff)
Ran: generic/050

[CAUSE]
The test case generic/050 has several different golden output depending
on the fs features.

For fses which requires data write (e.g. replay the journal) during
mount, mounting a read-only block device should fail.
And that is the default golden output.

However there are cases that the fs doesn't need to write anything, e.g.
the fs has no metadata journal support at all, or the fs has no dirty
journal to replay.

In that case, there is the generic/050.nojournal golden output.

The test case is using the helper _has_metadata_journaling() to
determine the feature.

Unfortunately that helper doesn't support btrfs, thus the default
behavior is to assume the fs has journal to replay, thus for btrfs it
always assume there is a journal to replay and results the wrong golden
output to be used.

[FIX]
Add btrfs specific log tree check into _has_metadata_journaling(), so
that if there is no log tree to replay, expose the "nojournal" feature
correctly to pass generic/050.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/rc | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/common/rc b/common/rc
index 2d8e7167..a78b779a 100644
--- a/common/rc
+++ b/common/rc
@@ -4283,6 +4283,14 @@ _has_metadata_journaling()
 			return 1
 		fi
 		;;
+	btrfs)
+		_require_btrfs_command inspect-internal dump-super
+		if "$BTRFS_UTIL_PROG" inspect-internal dump-super $dev | \
+		   grep -q "log_root\s\+0" ; then
+			echo "$FSTYPE on $dev has empty log tree"
+			return 1
+		fi
+		;;
 	*)
 		# by default we pass; if you need to, add your fs above!
 		;;
-- 
2.50.0


