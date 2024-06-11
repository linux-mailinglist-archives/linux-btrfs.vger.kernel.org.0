Return-Path: <linux-btrfs+bounces-5629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1074903114
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 07:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522F7B25CC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 05:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FA0172777;
	Tue, 11 Jun 2024 05:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tJpD6uJv";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tJpD6uJv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F307C17085D
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083328; cv=none; b=Mo4e1rQsyE4VBMCUV10i0MQ2Yf7771A5mZTbx6U4l7S4mp5uvZ15XP2UY7/yJJxZM4DQpcMM9XKJXJgGaJ2f7QiY5VgONFtrfvn0QBcOcjzWlyrMrEcmG0fnutCsBD1rCDBJdEEUkwpdagqUk1Bs6KzQulOd41c5C+y1Mmg9eDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083328; c=relaxed/simple;
	bh=38YehV5ViUoXhixsFThqre0s9Mt3q4lX1B1q4KzhodY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoZf0dfF5KQ+X1h6XgLv/KVvfrCwG0haUcyI1vpxR3YIwoxrnVe4/heC5wr5zL8t4Y5C5/U2VSlRh5VbIPaKHeE9rLnysVPqSL/gmhLhry4Y9fV6nNj0WsYjvA/KgFqoJPH+n0HVPxxOXiMx9N9byLa+DXR5T9e5VGTNMnOmJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tJpD6uJv; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tJpD6uJv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D4AAB22B3C
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUs9Qtp3zcg7NszS6uA0jNmj5klqau9afNA9ztZx6Gw=;
	b=tJpD6uJvKDoWx4KSPW/9/6Mw51dDJSxn4cx0J/kPuJE11e5pI9XlchPnrwpgPRNDnc5585
	CfOptXY5STfdAPAO+05HA6sKLXEMNIJyIzqQMEidTUlhqkjPLSa3lpY4U7nyeCBwhhw2kT
	hBFWJOw4pXxoNTmBO+FZRvJxvyGkiT8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=tJpD6uJv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1718083324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUs9Qtp3zcg7NszS6uA0jNmj5klqau9afNA9ztZx6Gw=;
	b=tJpD6uJvKDoWx4KSPW/9/6Mw51dDJSxn4cx0J/kPuJE11e5pI9XlchPnrwpgPRNDnc5585
	CfOptXY5STfdAPAO+05HA6sKLXEMNIJyIzqQMEidTUlhqkjPLSa3lpY4U7nyeCBwhhw2kT
	hBFWJOw4pXxoNTmBO+FZRvJxvyGkiT8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9B0513A51
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wAH8HvveZ2Y6KAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 05:22:03 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/4] btrfs: output the unrecognized super flags as hex
Date: Tue, 11 Jun 2024 14:51:36 +0930
Message-ID: <046695c9d31b00c63683bb7feb089f11c0dfc798.1718082585.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718082585.git.wqu@suse.com>
References: <cover.1718082585.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	BAYES_HAM(-0.78)[84.49%];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D4AAB22B3C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -2.79

Most of the extra suepr flags are beyond 32bits (from CHANGING_FSID_V2
to CHANGING_*_CSUMS), thus using %llu is not only too long and pretty
hard to read.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index ffc9129e23d2..78a11f9357ed 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2351,7 +2351,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
 		ret = -EINVAL;
 	}
 	if (btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP) {
-		btrfs_err(fs_info, "unrecognized or unsupported super flag: %llu",
+		btrfs_err(fs_info, "unrecognized or unsupported super flag: 0x%llx",
 				btrfs_super_flags(sb) & ~BTRFS_SUPER_FLAG_SUPP);
 		ret = -EINVAL;
 	}
-- 
2.45.2


