Return-Path: <linux-btrfs+bounces-16521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D1FB3B148
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 05:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE0563E21
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Aug 2025 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69683211A28;
	Fri, 29 Aug 2025 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kn57ksdx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kn57ksdx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E52D1DFD8F
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756436577; cv=none; b=ao6Wt/D436NMQYdg/x0Je9RykfO9CpmY5ptgVCLD3ayAUWx4ZZNjWYtUbr8jDU3otVDeXlAqOvH6zbTZM0pedN97DZ+pt58T8Z4Ie1iGpvqmJenioQPW3MqUN1TI5o0xdnrEEY3lVX7k2ETi6RpMFUZc4rbcmduT4VZ7VWRVtHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756436577; c=relaxed/simple;
	bh=Y8gVFdvsCZ35iiwZT6pVMnawxsWS6Oi5Ms2j552Mu0o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LS7I+lRF5sqmgP/0hB6+/o2l6zo28DH7ouQX2aWfVSKOnBpGZiBR1l9kuvIGKffzzCKFe98gsoqO6SxRUIsfy+RUUFtJWX8rhyelXBlFq3AcrKj2BvgK8TohEPFD8wlcuLjQKAbCa+eSHSawc3G1XOZtu79R7jHPiQZSj2v8GKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kn57ksdx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kn57ksdx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 58C1233AD5
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 03:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756436573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pFgofpc/7433L0XgWfoFkK7dN+xPGj5SevU0Gwd+ZXs=;
	b=kn57ksdxe74hKCyvj+rZUKPpEUtcZe62v4FCaEyLLVWYGwAl61ngOwQRtOUt2SsBux5Wyc
	6KGl5NqF7wRj/ymp1WUPwDSp7NcjbtFT2frE2Z6qwiXUlKjv8pKlZH5iW/TQT6pQ+CbP2G
	LUbpwMUATOzoW8hRfK+K69JIR26zXRc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kn57ksdx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1756436573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pFgofpc/7433L0XgWfoFkK7dN+xPGj5SevU0Gwd+ZXs=;
	b=kn57ksdxe74hKCyvj+rZUKPpEUtcZe62v4FCaEyLLVWYGwAl61ngOwQRtOUt2SsBux5Wyc
	6KGl5NqF7wRj/ymp1WUPwDSp7NcjbtFT2frE2Z6qwiXUlKjv8pKlZH5iW/TQT6pQ+CbP2G
	LUbpwMUATOzoW8hRfK+K69JIR26zXRc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9038313326
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 03:02:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w0A6FFwYsWhFIgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Aug 2025 03:02:52 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix lzo compression level output
Date: Fri, 29 Aug 2025 12:32:34 +0930
Message-ID: <9182b66aba2db19b939fdd3ceaafb07217210c1a.1756436553.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 58C1233AD5
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

[BUG]
Since commit "btrfs: accept and ignore compression level for lzo", we
will always set the lzo compress level to the default one.

This makes test case btrfs/220 fail with the following messages:

 FSTYP         -- btrfs
 PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc3-custom+ #281 SMP PREEMPT_DYNAMIC Thu Aug 28 11:15:21 ACST 2025
 MKFS_OPTIONS  -- /dev/mapper/test-scratch1
 MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch

 btrfs/220 5s ... - output mismatch (see /home/adam/xfstests/results//btrfs/220.out.bad)
     --- tests/btrfs/220.out	2022-05-11 11:25:30.749999997 +0930
     +++ /home/adam/xfstests/results//btrfs/220.out.bad	2025-08-29 12:26:54.215307784 +0930
     @@ -1,2 +1,8 @@
      QA output created by 220
     +Unexepcted mount options, checking for 'compress=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress=lzo'
     +Unexepcted mount options, checking for 'compress=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress=lzo'
     +Unexepcted mount options, checking for 'compress=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress=lzo'
     +Unexepcted mount options, checking for 'compress-force=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress-force=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress-force=lzo'
     +Unexepcted mount options, checking for 'compress-force=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress-force=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress-force=lzo'
     +Unexepcted mount options, checking for 'compress-force=lzo,relatime,space_cache=v2,ssd,subvol=/,subvolid=5' in 'rw,relatime,compress-force=lzo:1,ssd,space_cache=v2,subvolid=5,subvol=/' using 'compress-force=lzo'
     ...
     (Run 'diff -u /home/adam/xfstests/tests/btrfs/220.out /home/adam/xfstests/results//btrfs/220.out.bad'  to see the entire diff)

[CAUSE]
That commit changes lzo parsing use btrfs_compress_str2level() all time.
This means even lzo doesn't support compress level, we will still set
the default level, which is 1 for lzo.

And btrfs_show_options() will use compress_level for every compression
algorithm, causing the mount option output change thus the test case
failure.

[FIX]
Just change btrfs_show_options() to skip the compress level for lzo.

Please fold this one into the original commit.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b607c606fcfe..25df563abc6c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1081,7 +1081,7 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 			seq_printf(seq, ",compress-force=%s", compress_type);
 		else
 			seq_printf(seq, ",compress=%s", compress_type);
-		if (info->compress_level)
+		if (info->compress_level && info->compress_type != BTRFS_COMPRESS_LZO)
 			seq_printf(seq, ":%d", info->compress_level);
 	}
 	if (btrfs_test_opt(info, NOSSD))
-- 
2.50.1


