Return-Path: <linux-btrfs+bounces-7678-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A87E965315
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 00:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF521F214E3
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF718E745;
	Thu, 29 Aug 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ufoJ3IPI";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ufoJ3IPI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777B71898E5
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971178; cv=none; b=Fc1NkwYXDVB+tSvBtX+LPACEn+jRMpPn25i5PW9S9WGXf6uY5GN68lhqreoa2oU+MqJkLSN+PtFCWnsK7C7a6geTMvo+4/woTRuCTZlH3vGgicEaimqUklHgrhG+QwYuXrmWcyLPod53NmlMIp5JJgyx77E8m/ujqWx3qDU+MSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971178; c=relaxed/simple;
	bh=NAAu26VMURmOk6cMgB//db7xXspTAbMZPFbOrtTi1ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3Rx95wyneT9LFeWsv0Q885CXh9AwF/ivU9vyglluYHXWnJ2Z0CGY6vzYBRIRPUds4m74+oq+QYOjIYDXr6ppMgjTi4v2gxK0BHS8LZ11vYnvdu3CXbllW9msapH00ORScaaXnaZLNk3ZZ13lbskTT3mAI5qpqKaE1NpQ7VTvgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ufoJ3IPI; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ufoJ3IPI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76011219C6;
	Thu, 29 Aug 2024 22:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724971174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G/86Tlh28u4hjnQiCxNbTehQyhXFLxKVXdI/dS7BCBE=;
	b=ufoJ3IPIjTmO6F3qkMlhrHMEVbqMAsGMkKojShoUB3T0RJ2WB2CVBsaiIqB+C4v+IY6Frz
	XlWKHJoZlki5hiT/yeYvmWZZupRv9UwtEXaM5ATTxvQ+nryntaCDyLPNu4VQhHzZwRBwyc
	unJ6O6b12+Sf4sUOyeKKAjvzR0Aze/o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=ufoJ3IPI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724971174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G/86Tlh28u4hjnQiCxNbTehQyhXFLxKVXdI/dS7BCBE=;
	b=ufoJ3IPIjTmO6F3qkMlhrHMEVbqMAsGMkKojShoUB3T0RJ2WB2CVBsaiIqB+C4v+IY6Frz
	XlWKHJoZlki5hiT/yeYvmWZZupRv9UwtEXaM5ATTxvQ+nryntaCDyLPNu4VQhHzZwRBwyc
	unJ6O6b12+Sf4sUOyeKKAjvzR0Aze/o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7258E13408;
	Thu, 29 Aug 2024 22:39:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id emfXDKX40Gb5WgAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 29 Aug 2024 22:39:33 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Rolf Wentland <R.Wentland@gmx.de>
Subject: [PATCH v3] btrfs: interrupt fstrim if the current process is freezing
Date: Fri, 30 Aug 2024 08:09:11 +0930
Message-ID: <eeffae0b8beecb3406f43ff48e788fd9d88fb2e2.1724971143.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 76011219C6
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.com:email,suse.com:dkim,suse.com:mid,gmx.de:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

[BUG]
There is a bug report that running fstrim will prevent the system from
hibernation, result the following dmesg:

 PM: suspend entry (deep)
 Filesystems sync: 0.060 seconds
 Freezing user space processes
 Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
 task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1      flags:0x00004006
 Call Trace:
  <TASK>
  __schedule+0x381/0x1540
  schedule+0x24/0xb0
  schedule_timeout+0x1ea/0x2a0
  io_schedule_timeout+0x19/0x50
  wait_for_completion_io+0x78/0x140
  submit_bio_wait+0xaa/0xc0
  blkdev_issue_discard+0x65/0xb0
  btrfs_issue_discard+0xcf/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_discard_extent+0x120/0x2a0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_trim_block_group+0xcb/0x130 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_trim_fs+0x119/0x460 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  btrfs_ioctl+0x11cc/0x29f0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
  __x64_sys_ioctl+0x92/0xd0
  do_syscall_64+0x5b/0x80
  entry_SYSCALL_64_after_hwframe+0x7c/0xe6
 RIP: 0033:0x7f5f3b529f9b
 RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
 RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
 RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
 R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
 R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
  </TASK>
 OOM killer enabled.
 Restarting tasks ... done.
 random: crng reseeded on system resumption
 PM: suspend exit
 PM: suspend entry (s2idle)
 Filesystems sync: 0.047 seconds

[CAUSE]
PM code is freezing all user space processes before entering
hibernation/suspension, but if a user space process is trapping into the
kernel for a long running operation, it will not be frozen since it's
still inside kernel.

Normally those long running operations check for fatal signals and exit
early, but freezing user space processes is not done by signals but a
different infrastructure.

Unfortunately btrfs only checks fatal signals but not if the current
task is being frozen for fstrim.

[FIX]
For now just do the extra freezing() check at a per-block-group basis.

Reported-by: Rolf Wentland <R.Wentland@gmx.de>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v3:
- Only check the freezing status for fstrim
  As David still has concerns on all the other long running operations.

v2:
- Rename the helper to btrfs_task_interrupted()
---
 fs/btrfs/extent-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index feec49e6f9c8..1768628d68da 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5,6 +5,7 @@
 
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
+#include <linux/freezer.h>
 #include <linux/pagemap.h>
 #include <linux/writeback.h>
 #include <linux/blkdev.h>
@@ -6459,7 +6460,7 @@ static int btrfs_trim_free_extents(struct btrfs_device *device, u64 *trimmed)
 		start += len;
 		*trimmed += bytes;
 
-		if (fatal_signal_pending(current)) {
+		if (fatal_signal_pending(current) || freezing(current)) {
 			ret = -ERESTARTSYS;
 			break;
 		}
-- 
2.46.0


