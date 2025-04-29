Return-Path: <linux-btrfs+bounces-13484-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D3AA0220
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524361B6312D
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 05:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B1927055B;
	Tue, 29 Apr 2025 05:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d5YLG0YB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kdS+yYYL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16661F6694
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 05:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745906120; cv=none; b=UcqirBa89NnBMIsDRlvuAlnH+hEQ9EtuzgN5XTiDlVbI9tIxCaTsICpj9OyZK9OdalaAIfjAQz8/7ToMcXhRfzpGVk7WKNqhLhbqSRwyINCURnw1QNOYgVmtpcqYXxMy9+P/nIIcZ0ub/5GpXZT7HBoylHUtrlOdCynSSxHDMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745906120; c=relaxed/simple;
	bh=4RTVx1vCBfImp9b8K9qBQcLSK2Rn+MlT1WW6LyQPGw8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AYuFDxByoz3nVI1Yrrwe/4Blw2qEdOkXti3zClt9DF0EdQN1uMfIde8/TroWm9wOBcatvUAFb1MV+JXi3EZC4T7dtl1EKgi8CT8vfqjG9EgIXAscH+NaBaOd/GyLi7IsFBKRJr/xrDRKkEzqYWIkobLyoipt27zq5YekldSJIIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d5YLG0YB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kdS+yYYL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9612621B09
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 05:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745906114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h+zxav+teAiOhM3itFDnmDDB6+O1CcZy2jQ9e02JAbk=;
	b=d5YLG0YBi2StCu+oGT7CKH4oVR8rUnACF61gCVM/m8mT8kmVnZH96MpPT4z6opZpoRafAi
	qgJvjZ+LSGUsVsKxsFJYGIaUyIfIadtDwUcAQAgq9TCVXW6UgTunUiyY3opJJMLW/b3u9p
	Q3TqoXoQLMqHSUPciv9Hw82iNWQnAvg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kdS+yYYL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745906113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=h+zxav+teAiOhM3itFDnmDDB6+O1CcZy2jQ9e02JAbk=;
	b=kdS+yYYLS8JymqbnpWy9lxAVope0enffil8veqjcTrXEd1Nw3F/AG/QklSVBLJgTvG7GEw
	/t29CiVAA3aldaxCQe2FlRWYUMqbHmXH1uYsen/NUKRtQdJrV5gn5rOhMlkcgHJugfBuBr
	OEb3dlBIMWGECP5oO1MyH86yWDZhA0Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D35A513931
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 05:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ycbrJMBpEGhPVwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 05:55:12 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: avoid NULL pointer dereference if no valid csum tree
Date: Tue, 29 Apr 2025 15:24:47 +0930
Message-ID: <94df43cea8d2ea0cac8152d0996a64bda30758ae.1745906085.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9612621B09
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

[BUG]
When trying read-only scrub on a btrfs with rescue=idatacsums mount
option, it will crash with the following call trace:

 BUG: kernel NULL pointer dereference, address: 0000000000000208
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 CPU: 1 UID: 0 PID: 835 Comm: btrfs Tainted: G           O        6.15.0-rc3-custom+ #236 PREEMPT(full)
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 02/02/2022
 RIP: 0010:btrfs_lookup_csums_bitmap+0x49/0x480 [btrfs]
 Call Trace:
  <TASK>
  scrub_find_fill_first_stripe+0x35b/0x3d0 [btrfs]
  scrub_simple_mirror+0x175/0x290 [btrfs]
  scrub_stripe+0x5f7/0x6f0 [btrfs]
  scrub_chunk+0x9a/0x150 [btrfs]
  scrub_enumerate_chunks+0x333/0x660 [btrfs]
  btrfs_scrub_dev+0x23e/0x600 [btrfs]
  btrfs_ioctl+0x1dcf/0x2f80 [btrfs]
  __x64_sys_ioctl+0x97/0xc0
  do_syscall_64+0x4f/0x120
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[CAUSE]
Mount option "rescue=idatacsums" will completely skip loading the csum
tree, so that any data read will not find any data csum thus we will
ignore data checksum verification.

Normally call sites utilizing csum tree will check the fs state flag
NO_DATA_CSUMS bit, but unfortunately scrub is not check that bit at all.

This results make scrub to call btrfs_search_slot() on a NULL pointer
and triggered above crash.

[FIX]
Check both extent and csum tree root before doing any tree search.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/scrub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index d58132447c7c..5d6166fd917e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1535,8 +1535,8 @@ static int scrub_find_fill_first_stripe(struct btrfs_block_group *bg,
 	u64 extent_gen;
 	int ret;
 
-	if (unlikely(!extent_root)) {
-		btrfs_err(fs_info, "no valid extent root for scrub");
+	if (unlikely(!extent_root || !csum_root)) {
+		btrfs_err(fs_info, "no valid extent or csum root for scrub");
 		return -EUCLEAN;
 	}
 	memset(stripe->sectors, 0, sizeof(struct scrub_sector_verification) *
-- 
2.49.0


