Return-Path: <linux-btrfs+bounces-8994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 953E69A318B
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 02:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32E471C22BF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Oct 2024 00:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0DFECC;
	Fri, 18 Oct 2024 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="k8BTfOap";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="dikLlO8v"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20A2195;
	Fri, 18 Oct 2024 00:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209902; cv=none; b=i47LsYmO4tA8a/W7cXm5//uWjkTswnhbgx4V4WN/knO4teVPkOlpsQO/cL/OLHrNPpSMSQgGeSsRL6psL3eiMrXWBXprpCDC4I9aNmPi4W6iqfzIeoB8yYHyS47pwez4NC/h7yNXJcCEao274SHoax1GYgOdjcHgeZEqn818dz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209902; c=relaxed/simple;
	bh=+mVBjkJxOTXD/X42uHZhHhjN7+hfXLf0wWDiEDblY1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQawZUEY0+nzhQSqrxa7D+MdaqBsITvdr29M8yMT+Cakji0cxriwZv/AdQD0kNlhlSaLrO94dxw/8UjW5TTlr8Xc+UgUewsKABV57gbKxmtk8Y5PKV5N38APFmuCS7+onWXKugJC1RyC3S8H6uX60H2JQJwpJY2uWcp4kgoZYSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=k8BTfOap; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=dikLlO8v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE41721B52;
	Fri, 18 Oct 2024 00:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729209898; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGKbWenH4TwUqdTkt96S1dttn+aA19oCeBAzNy+cgvw=;
	b=k8BTfOapaGr+Bc2AgrCzUDaa0p3J76dD4l5Pm86GbWC00b6brhiC7t34tGvaHLqJyDJcPX
	jUoFf6ABHX+fxT96MqrasV+nnRbaJOybmCXpAbv1y9eGrDCmcBJEKwPXDXxLeJBskJ8sjv
	nSEF/GdEd1KF68IuxZnmlTB02rqL4+U=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=dikLlO8v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1729209897; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGKbWenH4TwUqdTkt96S1dttn+aA19oCeBAzNy+cgvw=;
	b=dikLlO8vFDcgZ/0bQA/A2ylmF/oxXHheePnyR9TCSZ/IyVgyG2wsd7suXIv9u0cRbP2gsq
	E5AFVy7lE9Yky5WPs38qfarAU/1ciCjaC2WRFPonw5tLgypOAcAzjM/OdXGGNUgM+iAkaW
	wOalfRpgm6eHiKxDoyfgGEholEfMcEI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86D341349D;
	Fri, 18 Oct 2024 00:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9UxcESimEWejQAAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 18 Oct 2024 00:04:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org
Cc: Long An <lan@suse.com>
Subject: [PATCH] btrfs/012: fix false alerts when SELinux is enabled
Date: Fri, 18 Oct 2024 10:34:53 +1030
Message-ID: <5538c72ca7c1bf2eb0ff3dbaa73903869ba47e95.1729209889.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE41721B52
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[FALSE FAILURE]
If SELinux is enabled, the test btrfs/012 will fail due to metadata
mismatch:

FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 localhost 6.4.0-150600.23.25-default #1 SMP PREEMPT_DYNAMIC Tue Oct  1 10:54:01 UTC 2024 (ea7c56d)
MKFS_OPTIONS  -- /dev/loop1
MOUNT_OPTIONS -- -o context=system_u:object_r:root_t:s0 /dev/loop1 /mnt/scratch

btrfs/012       - output mismatch (see /home/adam/xfstests-dev/results//btrfs/012.out.bad)
    --- tests/btrfs/012.out	2024-10-18 10:15:29.132894338 +1030
    +++ /home/adam/xfstests-dev/results//btrfs/012.out.bad	2024-10-18 10:25:51.834819708 +1030
    @@ -1,6 +1,1390 @@
     QA output created by 012
     Checking converted btrfs against the original one:
    -OK
    +metadata mismatch in /p0/d2/f4
    +metadata mismatch in /p0/d2/f5
    +metadata and data mismatch in /p0/d2/
    +metadata and data mismatch in /p0/
    ...

[CAUSE]
All the mismatch happens in the metadata, to be more especific, it's the
security xattrs.

Although btrfs-convert properly convert all xattrs including the
security ones, at mount time we will get new SELinux labels, causing the
mismatch between the converted and original fs.

[FIX]
Override SELINUX_MOUNT_OPTIONS so that we will not touch the security
xattrs, and that should fix the false alert.

Reported-by: Long An <lan@suse.com>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1231524
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 tests/btrfs/012 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index b23e039f4c9f..5811b3b339cb 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -32,6 +32,11 @@ _require_extra_fs ext4
 BASENAME="stressdir"
 BLOCK_SIZE=`_get_block_size $TEST_DIR`
 
+# Override the SELinux mount options, or it will lead to unexpected
+# different security.selinux between the original and converted fs,
+# causing false metadata mismatch during fssum.
+export SELINUX_MOUNT_OPTIONS=""
+
 # Create & populate an ext4 filesystem
 $MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 	_notrun "Could not create ext4 filesystem"
-- 
2.47.0


