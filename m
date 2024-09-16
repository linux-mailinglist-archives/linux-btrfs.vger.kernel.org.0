Return-Path: <linux-btrfs+bounces-8045-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709A9979DD5
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 11:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EAE1C22A7A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9478B1487F4;
	Mon, 16 Sep 2024 09:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SGf8I4e7";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SGf8I4e7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FE21465BD
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726477557; cv=none; b=n9xVFMrW7+Z7v6vxfwElRieJUNocHs9jwBm5RjIQYJ2QIuQxlGn/kU2QKEBMQSKwqvTlDfZKvWhpBGw9Bh5GbSOUB60AULwFEZdAj7meqdiNndaUM/FNC67Cq2g7Dy7Xkemo9TLOJxH1oAWeZZHyMDR3grZMjMlwNigeP41xvnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726477557; c=relaxed/simple;
	bh=GZk/xzCoDzbgKupV2ZvKmIyBboyvzjUneDB4FDtT3mM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyro3uNVdp4hdKGzCEhyAjpCe7LWpRZADeYJ1uKvqKVDRN+YS8UYH9VFrCbNA6jikLExPPhO3sytpAMEOZW6jGKFYhdV4Zl4BFqw9cmH3m2ihECiAamY3oSu9MWkqk1oXZll9WRhWNnjocVpp+l3AuOWPUBPdLaDkEeUN9uWiNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SGf8I4e7; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SGf8I4e7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3FB71FD57
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726477552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4WFSKFCz7HtVZQQUwDs8UzYngAdQ7mjCOlgEsoPEM4=;
	b=SGf8I4e7+CQV2XFsQ4Pc8M57aEpTXjwHIs2oTDgJT4nu/MaCXh6w+aoy0XskKqFKRn3RW8
	3p1WO3+3DKeJnIVA/tcBdcVqXbyvdvRd5C4OyOBJDgGSH7DvF/Y8Dwx3vUO1IMd2F40TkR
	IV2ADFhejC3eihIa7whwQJv7z9Fv1yE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SGf8I4e7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1726477552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4WFSKFCz7HtVZQQUwDs8UzYngAdQ7mjCOlgEsoPEM4=;
	b=SGf8I4e7+CQV2XFsQ4Pc8M57aEpTXjwHIs2oTDgJT4nu/MaCXh6w+aoy0XskKqFKRn3RW8
	3p1WO3+3DKeJnIVA/tcBdcVqXbyvdvRd5C4OyOBJDgGSH7DvF/Y8Dwx3vUO1IMd2F40TkR
	IV2ADFhejC3eihIa7whwQJv7z9Fv1yE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1092813A91
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aLF9Me/052bTSgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Sep 2024 09:05:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make assert_rbio() to only check CONFIG_BTRFS_DEBUG
Date: Mon, 16 Sep 2024 18:35:28 +0930
Message-ID: <98779174312bea75b3158e8caa555833f10c94e3.1726477365.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726477365.git.wqu@suse.com>
References: <cover.1726477365.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C3FB71FD57
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
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -5.01
X-Spam-Flag: NO

According to the description, CONFIG_BTRFS_DEBUG is only for extra
debug info, meanwhile sanity checks should be managed by
CONFIG_BTRFS_ASSERT.

There is no need to check both to enable assert_rbio().

Just remove the check for CONFIG_BTRFS_DEBUG.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/raid56.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 39bec672df0c..cdd373c27784 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1272,8 +1272,7 @@ static inline void bio_list_put(struct bio_list *bio_list)
 
 static void assert_rbio(struct btrfs_raid_bio *rbio)
 {
-	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG) ||
-	    !IS_ENABLED(CONFIG_BTRFS_ASSERT))
+	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
 		return;
 
 	/*
-- 
2.46.0


