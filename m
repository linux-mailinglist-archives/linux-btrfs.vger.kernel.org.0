Return-Path: <linux-btrfs+bounces-12302-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A388A62945
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 09:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09899189BA71
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Mar 2025 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD561E491B;
	Sat, 15 Mar 2025 08:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nJmoz051";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="nJmoz051"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4F2192B8F
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742028596; cv=none; b=rWeUBt/5LwKfBG1dbP/ZZ/FfBFhilaUg+3qqfFa8IRlFDd3hxK6K6XArsfuFPE550eq4M94CrNm0M36eQoNr4aLIufFveOsLSjcjVKYlRICm5TEit2JeaFAf/tZ0LHYF91bL8vrV9m6YRyuq8G6Yh2HHAsk4KxScQdBW0nW4s+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742028596; c=relaxed/simple;
	bh=1zpyCy3dgIpVk/pV1IF+wQA6eMlRt+lwGl0PFRFxnlU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tQfzXuSbx2vnhkEEhC9z33JfO4bBEByCDiv4qNH5TnFoEVn4Q7hQJMyVnV5k89VTG8SKxlq8MS5nQB1477glyExG5LosH545ir4ox2tV70es4I1EkDvH9RVRfTnLS6Jkdrrp6OsWHQr6kGVprCThKYlSUiD7pz0NbrtOETQVhUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nJmoz051; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=nJmoz051; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7556721187
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 08:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742028586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iboY0lJyvFpWThhkVFWOXL7HxHHFEwvsULDOow7pgzU=;
	b=nJmoz051UEWMzdG9QEavxeLMorLHGC8hiQLrgPng2AppZd2uJgU0Amqh+9AL2eF31vcILp
	tuX3nH+k2UNNN8ViLQS/61JE179TsgIak0/PomQZV5mab1q5QaSM+HkomxQynNMAG65s1b
	6SXbN7BwpTlMYWmXs7YiAL19/kXKKWo=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=nJmoz051
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1742028586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=iboY0lJyvFpWThhkVFWOXL7HxHHFEwvsULDOow7pgzU=;
	b=nJmoz051UEWMzdG9QEavxeLMorLHGC8hiQLrgPng2AppZd2uJgU0Amqh+9AL2eF31vcILp
	tuX3nH+k2UNNN8ViLQS/61JE179TsgIak0/PomQZV5mab1q5QaSM+HkomxQynNMAG65s1b
	6SXbN7BwpTlMYWmXs7YiAL19/kXKKWo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A9D713797
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 08:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A5Z0BSk/1WcpSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Mar 2025 08:49:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: move block perfect compression out of experimental features
Date: Sat, 15 Mar 2025 19:19:26 +1030
Message-ID: <d79b3627f9b2aed116c930bad3048da3aabcb2bd.1742028548.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7556721187
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Commit 1d2fbb7f1f9e ("btrfs: allow compression even if the range is not
page aligned") introduced the block perfect compression for block size <
page size cases.

Before that commit, if the fs block size is smaller than page size (aka
subpage cases), compressed write is only enabled if the dirty range is
fully page aligned.

This block perfect compression support is introduced in v6.13, and has
been tested for two kernel releases.
I believe it's time to move it out of experimental features so that we
can get more tests in the real world.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ae2846b9f666..f47307b885e7 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -785,21 +785,6 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
 			btrfs_ino(inode));
 		return 0;
 	}
-	/*
-	 * Only enable sector perfect compression for experimental builds.
-	 *
-	 * This is a big feature change for subpage cases, and can hit
-	 * different corner cases, so only limit this feature for
-	 * experimental build for now.
-	 *
-	 * ETA for moving this out of experimental builds is 6.15.
-	 */
-	if (fs_info->sectorsize < PAGE_SIZE &&
-	    !IS_ENABLED(CONFIG_BTRFS_EXPERIMENTAL)) {
-		if (!PAGE_ALIGNED(start) ||
-		    !PAGE_ALIGNED(end + 1))
-			return 0;
-	}
 
 	/* force compress */
 	if (btrfs_test_opt(fs_info, FORCE_COMPRESS))
-- 
2.48.1


