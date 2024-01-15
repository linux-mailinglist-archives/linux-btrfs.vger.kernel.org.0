Return-Path: <linux-btrfs+bounces-1455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376F782E0CA
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1847283205
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 19:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A40B18C21;
	Mon, 15 Jan 2024 19:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="saHgx8RO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="saHgx8RO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18B18E08;
	Mon, 15 Jan 2024 19:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 01B3721F89;
	Mon, 15 Jan 2024 19:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705347564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xPddsAhoUIJjKHEVphr4Es22DeusDXsUbfRQwQezHfs=;
	b=saHgx8ROksqrbJyHiqQ+5biI/Z+Oj2PIvnEUNRXkyccbm8IFyFtAilUpphGQ7jMCnREhix
	mgJbcNiQrgnS1hEhBMXA/+mEcZa27WpQFRTtAKxc+fD0bx2m2GYUcbq3mPYBofVYRMcV0U
	oLPYFq27jPQzodmgDTEzkE2C7vRdanA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1705347564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=xPddsAhoUIJjKHEVphr4Es22DeusDXsUbfRQwQezHfs=;
	b=saHgx8ROksqrbJyHiqQ+5biI/Z+Oj2PIvnEUNRXkyccbm8IFyFtAilUpphGQ7jMCnREhix
	mgJbcNiQrgnS1hEhBMXA/+mEcZa27WpQFRTtAKxc+fD0bx2m2GYUcbq3mPYBofVYRMcV0U
	oLPYFq27jPQzodmgDTEzkE2C7vRdanA=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EC2E713BF6;
	Mon, 15 Jan 2024 19:39:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id JoFlOeuJpWVMFAAAn2gu4w
	(envelope-from <dsterba@suse.com>); Mon, 15 Jan 2024 19:39:23 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	stable@vger.kernel.org,
	syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: don't warn if discard range is not aligned to sector
Date: Mon, 15 Jan 2024 20:38:59 +0100
Message-ID: <20240115193859.1521-1-dsterba@suse.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[4a4f1eba14eb5c3417d1];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[22.33%]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

There's a warning in btrfs_issue_discard() when the range is not aligned
to 512 bytes, originally added in 4d89d377bbb0 ("btrfs:
btrfs_issue_discard ensure offset/length are aligned to sector
boundaries"). We can't do sub-sector writes anyway so the adjustment is
the only thing that we can do and the warning is unnecessary.

CC: stable@vger.kernel.org # 4.19+
Reported-by: syzbot+4a4f1eba14eb5c3417d1@syzkaller.appspotmail.com
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent-tree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 6d680031211a..8e8cc1111277 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1260,7 +1260,8 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
 	u64 bytes_left, end;
 	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
 
-	if (WARN_ON(start != aligned_start)) {
+	/* Adjust the range to be aligned to 512B sectors if necessary. */
+	if (start != aligned_start) {
 		len -= aligned_start - start;
 		len = round_down(len, 1 << SECTOR_SHIFT);
 		start = aligned_start;
-- 
2.42.1


