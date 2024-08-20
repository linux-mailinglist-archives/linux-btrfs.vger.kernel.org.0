Return-Path: <linux-btrfs+bounces-7352-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD8959138
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Aug 2024 01:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC2B285A45
	for <lists+linux-btrfs@lfdr.de>; Tue, 20 Aug 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A311C7B72;
	Tue, 20 Aug 2024 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j78hUO1+";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="j78hUO1+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2D14A4F0
	for <linux-btrfs@vger.kernel.org>; Tue, 20 Aug 2024 23:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196707; cv=none; b=SxTrvTTUEMRAqtRmXMg2B5CGy1sFd3VsP07wX5A7j7A5aHW8WAGF+TlTDbQUGMM1SvxYK+oHhZ7QTfOd98/IpGshZ8KbO8oNcSmh5cJgPxw4GyjBm28++5MyZd7HqiroZ/hQJ18s/iDjvWyEoxzW8PZGybhtoNb8LQeFulnUzfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196707; c=relaxed/simple;
	bh=xB+jw9qVDi220WJJwmbbdAnHeJUrxfhu0iFY8t5hM88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drmQOrr2C8qxQyHo+2Styjs6/pxcezeJvzSet2Dnfaz/HcszyrISFlkDZzGIce7AkWequiYgLRXzKhuyQ32xWHRUCA602Lwzd1rQHpvuQcLzXNqyhWzz9GEOwkBqgMsc2Juzn8AhZXpE71k2LR1SJY7OLZmnIrsrBDLnT0jurvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j78hUO1+; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=j78hUO1+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6658E1FD5C;
	Tue, 20 Aug 2024 23:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724196703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=STJAG0shWRV6hxoOJkX+y7JOSarU8U71e5Pa0uJWa2Q=;
	b=j78hUO1+HgHyIpqzdGd6Q8o6KtjY36Iljjauqt7XH4mKfDr8vhJWyc4PRqVWQtpb9txT17
	YqfB7zj6J7OCHqPoNnBCkFSAuJl0sR/FISr17Ua+EzNSRf2z4qtMdVd1BTDp0+Mlu99XK7
	+cBEoGdU30rZIGioYOPsDfsAS59XtF4=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=j78hUO1+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1724196703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=STJAG0shWRV6hxoOJkX+y7JOSarU8U71e5Pa0uJWa2Q=;
	b=j78hUO1+HgHyIpqzdGd6Q8o6KtjY36Iljjauqt7XH4mKfDr8vhJWyc4PRqVWQtpb9txT17
	YqfB7zj6J7OCHqPoNnBCkFSAuJl0sR/FISr17Ua+EzNSRf2z4qtMdVd1BTDp0+Mlu99XK7
	+cBEoGdU30rZIGioYOPsDfsAS59XtF4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C22D13A17;
	Tue, 20 Aug 2024 23:31:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KhExFl8nxWYuNQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 20 Aug 2024 23:31:43 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] btrfs: initialize last_extent_end to fix -Wmaybe-uninitialized warning in extent_fiemap()
Date: Wed, 21 Aug 2024 01:31:32 +0200
Message-ID: <20240820233132.24652-1-dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6658E1FD5C
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

There's a warning (probably on some older compiler version):

fs/btrfs/fiemap.c: warning: 'last_extent_end' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 822:19

Initialize the variable to 0 although it's not necessary as it's either
properly set or not used after an error. The called function is in the
same file so this is a false alert but we want to fix all
-Wmaybe-uninitialized reports.

Link: https://lore.kernel.org/all/20240819070639.2558629-1-geert@linux-m68k.org/
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/fiemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index 8f95f3e44e99..df7f09f3b02e 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -637,7 +637,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	struct btrfs_path *path;
 	struct fiemap_cache cache = { 0 };
 	struct btrfs_backref_share_check_ctx *backref_ctx;
-	u64 last_extent_end;
+	u64 last_extent_end = 0;
 	u64 prev_extent_end;
 	u64 range_start;
 	u64 range_end;
-- 
2.45.0


