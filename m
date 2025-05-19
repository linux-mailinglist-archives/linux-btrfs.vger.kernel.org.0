Return-Path: <linux-btrfs+bounces-14126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E35D7ABCB3B
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 May 2025 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2201F1B68284
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 May 2025 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F672868B;
	Mon, 19 May 2025 23:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LqLCjSfn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LqLCjSfn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD372603
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 23:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747695641; cv=none; b=mXhJo+Mw7O4gbDrE/GbBVMsSyJW4l54pE8LanuDf0bBa/VG0q4YFRZ14i905WSyZlkLpHIvMS5PehQ1niNtHbShyt9Zi1GzBdVHoAHoM0CiOizh94BYOXMsqjwhn5rrV5E6LSAVI2GFI02jR+4QBW/2coUAP7jHJh3YPIk78bZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747695641; c=relaxed/simple;
	bh=kVuluIW1bStKzn+/fHEgdrwBSyK5fFXo9m2ovprPpt0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CCVM/76UARld7o8BDCfa+E0JqIYVuijJAG7ALk6lEXmQAW+J+tSeLhSyNIkaqTrkR/IzlvSu3sn48265o/57rGuGZ5Mo/o72WqVvOgMfW3DEAL/oQORSGrcmgr1Q9iVHs7CikBO5RM2+dRuTEgk5DuioDhehh38WG41ZGn2nlGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LqLCjSfn; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LqLCjSfn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 942B120519
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 23:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747695636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v9APqp6Trb/fogIBDDWIKd0bsMEXivjHnPDTfhsRIMU=;
	b=LqLCjSfnCu87PuZQikXdroTz1N2SfV0h+SbkG83JHPX+SUWFwXoQNtjAOuJfgTMBV5iqNF
	F+3bflztQuqw6r5tZH6bgNZYYkkSKTN9zFZLq85DaHhyYjcmAV4rFBgIcNAlJyL/yDVXVs
	WuEz+x7hJJXu8ObX4ehNKWA1/zLYnjc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=LqLCjSfn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1747695636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v9APqp6Trb/fogIBDDWIKd0bsMEXivjHnPDTfhsRIMU=;
	b=LqLCjSfnCu87PuZQikXdroTz1N2SfV0h+SbkG83JHPX+SUWFwXoQNtjAOuJfgTMBV5iqNF
	F+3bflztQuqw6r5tZH6bgNZYYkkSKTN9zFZLq85DaHhyYjcmAV4rFBgIcNAlJyL/yDVXVs
	WuEz+x7hJJXu8ObX4ehNKWA1/zLYnjc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C878713A30
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 23:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Llq7IRO4K2jFPQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 19 May 2025 23:00:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: add root id output for direct IO error messages
Date: Tue, 20 May 2025 08:30:32 +0930
Message-ID: <af31c7ae4ba5c76d57527f5a774f3816f69b54d8.1747695628.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 942B120519
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]

When debugging a kernel warning caused by generic/475, the error
messages from direct IO lacks the subvolume id, meanwhile th error
messages from buffered IO contains both subvolume id and inode number.

This makes debugging much harder to grasp which inode (and its
subvolume) is causing the problem.

Add the subvolume id for direct IO failure message.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/direct-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index fe9a4bd7e6e6..983b8cb9f688 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -649,8 +649,8 @@ static void btrfs_dio_end_io(struct btrfs_bio *bbio)
 
 	if (bio->bi_status) {
 		btrfs_warn(inode->root->fs_info,
-		"direct IO failed ino %llu op 0x%0x offset %#llx len %u err no %d",
-			   btrfs_ino(inode), bio->bi_opf,
+		"direct IO failed root %llu ino %llu op 0x%0x offset %#llx len %u err no %d",
+			   btrfs_root_id(inode->root), btrfs_ino(inode), bio->bi_opf,
 			   dip->file_offset, dip->bytes, bio->bi_status);
 	}
 
-- 
2.49.0


