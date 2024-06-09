Return-Path: <linux-btrfs+bounces-5582-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700CB901832
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 23:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC6EB20F67
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1613F1CAB9;
	Sun,  9 Jun 2024 21:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LgsgMB3y";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="biaBwvN2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D914295
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 21:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717966957; cv=none; b=P3LPbqplqF7rbUGwq0n67iYoVRaoOB8Lq3dnEFy5N4TUB1Gl1B6sZmFqAovqs0gknGQkz723/VYo971DTgINKi0cx7Md2H9V/a/HylfWLaOE/65SfFUBfdwqVOFszWnNOQK91sAlQ5ioDWfCoMHrBlyRdKmvHv9BWrx4lS2W9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717966957; c=relaxed/simple;
	bh=Li5UtRw8T4tfVDapexh6oQTEJavrzESTniuR8CV55i0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GV1X25FAnKp/T2reKQUwXVKwp8y9UcO9CtnfBib8eNBoXg7v06ZS/JpC3Xi6aJeOs+XU9ipEqPtMLip8strXO6eoHhI0i5W0sB2DmMpoeXvw2FlqwOEww8Jj8+nDsmwjrCdwRs+M9b3FXL3RvbVyTyWOJyKpKemlOFzUFH6xFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LgsgMB3y; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=biaBwvN2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB1B221A4A
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 21:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717966948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Udc7tOpeReATE1SY74mI1yr92hiKhRmOB7ucuNkF1sM=;
	b=LgsgMB3yYPxrO7nfCcDBzZJl7yQYY7AquoRdew3lFx44+uSNgx+z47opjUFrz2ywqTvvxK
	Es+PVPuCRY643HvMGSEybnIQFHd8YfVW84flhizDaOAe+nU1rfgojtLuvC+UMlB213+a5u
	cLF3UZJ9MCkL3UB4Qwlle3XmFCOrtGg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=biaBwvN2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717966946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=Udc7tOpeReATE1SY74mI1yr92hiKhRmOB7ucuNkF1sM=;
	b=biaBwvN2giSaqU2YitTzDpo2fp0QrYjfLxfpFGK3qCLH3xCeuS4LDv2ZJnXW4DclId+rXY
	130ty2EEswjbQLZ1oFSitifLPcRK0pTWR/J4404pNGlqrvr9H4LYhdKFBDtrYlLGFRdqwm
	KOwr9T65RwvDYDxOBqu3bcTERJEiCSo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C746C13A97
	for <linux-btrfs@vger.kernel.org>; Sun,  9 Jun 2024 21:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y5JnHWEYZmaFNAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 09 Jun 2024 21:02:25 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: subpage: remove the unused error bitmap dumpping
Date: Mon, 10 Jun 2024 06:32:07 +0930
Message-ID: <b965322f7a4825bc5f4a094f3138e1369534f8bb.1717966923.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-0.24 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	BAYES_HAM(-0.23)[72.39%];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: BB1B221A4A
X-Spam-Flag: NO
X-Spam-Score: -0.24
X-Spamd-Bar: /

Since commit 2b2553f12355 ("btrfs: stop setting PageError in the data I/O
path") btrfs no longer utilize subpage error bitmaps anymore, but the
commit forgot to remove the error bitmap in btrfs_subpage_dump_bitmap(),
resulting possible meaningless result for the error bitmap.

Fix it by just removing the error bitmap dumping.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/subpage.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index fc7db52e8f58..1a4717bcce23 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -909,7 +909,6 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 	struct btrfs_subpage_info *subpage_info = fs_info->subpage_info;
 	struct btrfs_subpage *subpage;
 	unsigned long uptodate_bitmap;
-	unsigned long error_bitmap;
 	unsigned long dirty_bitmap;
 	unsigned long writeback_bitmap;
 	unsigned long ordered_bitmap;
@@ -931,10 +930,9 @@ void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 
 	dump_page(folio_page(folio, 0), "btrfs subpage dump");
 	btrfs_warn(fs_info,
-"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl error=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
+"start=%llu len=%u page=%llu, bitmaps uptodate=%*pbl dirty=%*pbl writeback=%*pbl ordered=%*pbl checked=%*pbl",
 		    start, len, folio_pos(folio),
 		    subpage_info->bitmap_nr_bits, &uptodate_bitmap,
-		    subpage_info->bitmap_nr_bits, &error_bitmap,
 		    subpage_info->bitmap_nr_bits, &dirty_bitmap,
 		    subpage_info->bitmap_nr_bits, &writeback_bitmap,
 		    subpage_info->bitmap_nr_bits, &ordered_bitmap,
-- 
2.45.2


