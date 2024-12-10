Return-Path: <linux-btrfs+bounces-10180-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2381B9EA75E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 05:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8FC2891B6
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6331AAA27;
	Tue, 10 Dec 2024 04:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hI4GVgrH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hI4GVgrH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6834279FD;
	Tue, 10 Dec 2024 04:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733806414; cv=none; b=d/0HjhA/XgUUM+O12YaTzvXabzihe0GtZ35XHcI+ydsPxyOmuO81LzdYkq1JgxHWdKVyUZyIm10EBBBRoTnKk9Zm4s/UD69fE+ANKmzLqGoLxy2E4mzjULS/oUwolGq1mPQJhKxIS7HEW740SV+vKrOPwO0n+t5pGillwhLMFTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733806414; c=relaxed/simple;
	bh=Jf5hAoULbz7XdfGVuQZNRKPzgcLUJk4W9Rndb9zUECM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s3VaKok+R/M7Cw4aYSx23TikfvgK5W7eFEFrEdbfDFDtSg/h38O7ubeL72KDK9ZZ9qbg3g3YsDBFky8GOwbnsI4hEWbVhb2/muPf0vtaKPif5VkzVR84KFkpYB9JNylloDSLWQDzBf0YjUsqv7pSH2uzKX7ARs7Q+0lRr6f2Djw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hI4GVgrH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hI4GVgrH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 835B9210FA;
	Tue, 10 Dec 2024 04:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733806409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3pOlLSf9dbQWdZiE22RVzIENh2P2qiOHKPJQkG+7cFY=;
	b=hI4GVgrHwfQauXa8Ze1HkMRAIjBp2LGoqMFXNJuqzCiOWdP7SE0lCM6UUuEqAefKGCTVhP
	N2pyxx1+Ke2ryWCzYx/SNdmy6Bc2XVaHUgfiHP6Tur78ExJueOf2wfWrYPsYtphBhhJ5kZ
	Xc9sYAxKFeQZf1fcAeWrkoG7rUHhUTc=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733806409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3pOlLSf9dbQWdZiE22RVzIENh2P2qiOHKPJQkG+7cFY=;
	b=hI4GVgrHwfQauXa8Ze1HkMRAIjBp2LGoqMFXNJuqzCiOWdP7SE0lCM6UUuEqAefKGCTVhP
	N2pyxx1+Ke2ryWCzYx/SNdmy6Bc2XVaHUgfiHP6Tur78ExJueOf2wfWrYPsYtphBhhJ5kZ
	Xc9sYAxKFeQZf1fcAeWrkoG7rUHhUTc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36DEB138D2;
	Tue, 10 Dec 2024 04:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cLntOUfJV2eAZwAAD6G6ig
	(envelope-from <wqu@suse.com>); Tue, 10 Dec 2024 04:53:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Christoph Anton Mitterer <calestyo@scientia.org>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: output the reason for open_ctree() failure
Date: Tue, 10 Dec 2024 15:23:06 +1030
Message-ID: <037d2532a0f9ef545cf20fee903fc22936ad1bdc.1733806379.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

There is a recent ML report that mounting a large fs backed by hardware
RAID56 controller (with one device missing) took too much time, and
systemd seems to kill the mount attempt.

In that case, the only error message is:

  BTRFS error (device sdj): open_ctree failed

There is no reason on why the failure happened, making it very hard to
understand the reason.

At least output the error number (in the particular case it should be
-EINTR) to provide some clue.

Link: https://lore.kernel.org/linux-btrfs/9b9c4d2810abcca2f9f76e32220ed9a90febb235.camel@scientia.org/
Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7dfe5005129a..f6eaaf20229d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -971,7 +971,7 @@ static int btrfs_fill_super(struct super_block *sb,
 
 	err = open_ctree(sb, fs_devices);
 	if (err) {
-		btrfs_err(fs_info, "open_ctree failed");
+		btrfs_err(fs_info, "open_ctree failed: %d", err);
 		return err;
 	}
 
-- 
2.47.1


