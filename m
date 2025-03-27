Return-Path: <linux-btrfs+bounces-12631-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1697CA7404D
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 22:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B92073B77CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 21:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ABD1DB365;
	Thu, 27 Mar 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q2eEq2Qk";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q2eEq2Qk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8612A1C6FF3
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110975; cv=none; b=C3lvOYWJbKNA+7EgpZRHkfbzfExihtq2I1m4A66+RpKSoRFlFYXYQayWBCV+F8EarRxNp3PhsNIyffLJ8IfXwc9vvQZLqizQhAk94cXo1L5qWk9WbI6cU9gyRrAtrjkEFEj1mCPFt5x7y30B9Y9qfAnDe71xnA+kt+ifoDoS2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110975; c=relaxed/simple;
	bh=6CYe0olLt3nBTM4cYvyfRTykB1xRsAJWXSVS2EIogD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hz3M4TLB15Dyr74qL0UiSkih5TMpYMBrDhwhgMxs7wLa0PjinMP4JcgpZlOF6ACRpTz/LeTkHPxQKkcLW171DbmEyABIUKJQwLtyo5SLT314U4J09OGi/dnBbmO8yuL1E7l02OxzVET/cFOGsrge+nh9rkhi7aYg61NKfqp4SdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q2eEq2Qk; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q2eEq2Qk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AED5211A2;
	Thu, 27 Mar 2025 21:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743110971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VmqRh/eEirIIYS50HaQXZB8tdKLbW6HNyryNCfgiUK4=;
	b=Q2eEq2QkZNcOPo0Uet6QYcytQ8XkJZFSJ7DVbs7HyUJ1CTxiGY2W8zV0+4eTreCV5NmKBT
	mZsPvX6WLleu6+j2iBAVTYr7Q8kmMJpmlpW3AgqZWg2bXbOGK94j9MqdsF+mNwaISWpGd4
	gr+eDYaJMWDpynYlhgJ8W2HkiFOyb90=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Q2eEq2Qk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743110971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VmqRh/eEirIIYS50HaQXZB8tdKLbW6HNyryNCfgiUK4=;
	b=Q2eEq2QkZNcOPo0Uet6QYcytQ8XkJZFSJ7DVbs7HyUJ1CTxiGY2W8zV0+4eTreCV5NmKBT
	mZsPvX6WLleu6+j2iBAVTYr7Q8kmMJpmlpW3AgqZWg2bXbOGK94j9MqdsF+mNwaISWpGd4
	gr+eDYaJMWDpynYlhgJ8W2HkiFOyb90=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B5951376E;
	Thu, 27 Mar 2025 21:29:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iEDZAzrD5Wd8WwAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 27 Mar 2025 21:29:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: syzbot+34122898a11ab689518a@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: remove folio order ASSERT()s in super block writeback path
Date: Fri, 28 Mar 2025 07:59:12 +1030
Message-ID: <92a474470c6230241d7ebff3673c3d624c38ae6a.1743110853.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4AED5211A2
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,suse.com:dkim,suse.com:mid,suse.com:email];
	TAGGED_RCPT(0.00)[34122898a11ab689518a];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
There is a syzbot report that the ASSERT() inside write_dev_supers() got
triggered:

  assertion failed: folio_order(folio) == 0, in fs/btrfs/disk-io.c:3858
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/disk-io.c:3858!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 0 UID: 0 PID: 6730 Comm: syz-executor378 Not tainted 6.14.0-syzkaller-03565-gf6e0150b2003 #0 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
  RIP: 0010:write_dev_supers fs/btrfs/disk-io.c:3858 [inline]
  RIP: 0010:write_all_supers+0x400f/0x4090 fs/btrfs/disk-io.c:4155
  Call Trace:
   <TASK>
   btrfs_commit_transaction+0x1eda/0x3750 fs/btrfs/transaction.c:2528
   btrfs_quota_enable+0xfcc/0x21a0 fs/btrfs/qgroup.c:1226
   btrfs_ioctl_quota_ctl+0x144/0x1c0 fs/btrfs/ioctl.c:3677
   vfs_ioctl fs/ioctl.c:51 [inline]
   __do_sys_ioctl fs/ioctl.c:906 [inline]
   __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
  RIP: 0033:0x7f5ad1f20289
   </TASK>
  ---[ end trace 0000000000000000 ]---

[CAUSE]
Since commit f93ee0df5139 ("btrfs: convert super block writes to folio
in write_dev_supers()") and commit c94b7349b859 ("btrfs: convert super
block writes to folio in wait_dev_supers()"), the super block writeback
path is converted to use folio.

Since the original code is using page based interfaces, we have an
"ASSERT(folio_order(folio) == 0);" added to make sure everything is not
changed.

But the folio here is not from any btrfs inode, but from the block
device, and we have no control on the folio order in bdev, the device
can choose whatever folio size they want/need.

E.g. the bdev may even have a block size of multiple pages.

So the ASSERT() is triggered.

[FIX]
The super block writeback path has taken larger folios into
consideration, so there is no need for the ASSERT().

And since commit bc00965dbff7 ("btrfs: count super block write errors in
device instead of tracking folio error state"), the wait path no longer
checks the folio status but only wait for the folio writeback to finish,
there is nothing requiring the ASSERT() either.

So we can remove both ASSERT()s safely now.

Reported-by: syzbot+34122898a11ab689518a@syzkaller.appspotmail.com
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Our super block read path is still using page interfaces, and I believe
it's better to migrate to the folio interfaces with large folio support.
---
 fs/btrfs/disk-io.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 1a916716cefe..d0da9988ea48 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3853,7 +3853,6 @@ static int write_dev_supers(struct btrfs_device *device,
 			atomic_inc(&device->sb_write_errors);
 			continue;
 		}
-		ASSERT(folio_order(folio) == 0);
 
 		offset = offset_in_folio(folio, bytenr);
 		disk_super = folio_address(folio) + offset;
@@ -3926,7 +3925,6 @@ static int wait_dev_supers(struct btrfs_device *device, int max_mirrors)
 		/* If the folio has been removed, then we know it completed. */
 		if (IS_ERR(folio))
 			continue;
-		ASSERT(folio_order(folio) == 0);
 
 		/* Folio will be unlocked once the write completes. */
 		folio_wait_locked(folio);
-- 
2.49.0


