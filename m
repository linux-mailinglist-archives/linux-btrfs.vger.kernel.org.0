Return-Path: <linux-btrfs+bounces-14470-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F35ACE71E
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jun 2025 01:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2392164CA3
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D78C22AE7A;
	Wed,  4 Jun 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UD1AQhXG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UD1AQhXG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4058F49659
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 23:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749079059; cv=none; b=jlC4hW2ZV0I/Kgu1rXHS0RjwMC38HMftQBxHkB2KZ4yp8n+S3LPZMFWIdpmPmqbvESKEF35u0LIY5tVDzYrl/An2WRzB5Cq+DvUEnvvP1kWw+eFff1oYRHVWrb86OewynSSP53MKMESxLm94rkTP6QU5z9T+Q0LoSfMI5m8KdAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749079059; c=relaxed/simple;
	bh=MapfJZ5hIOrzMqWR89r8SV9GZwkqICh5BcCPd1OloPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CXhDccJT+f1IMMAvDcZf7sJu7ya5e5j2idKnqoXjL7WzVlFHllVf8bP3AWx2TTKXt7fKLt+f/3BJ85I08k7wowQy08CAlMbiBrFyh16ibJz9ORlYSUgZzd9yS+l9Q/JXapsdp73KkpJ5LrqyKo1d1nnndMBNhsONOlUavEmtccA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UD1AQhXG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UD1AQhXG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 42ACF22C53
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749079055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0TgAqi+TpROS+//QswTJX8IQkXD9MrvP5t4UjKxe9gA=;
	b=UD1AQhXGefF8YR8MaEDe7DbaHdecyfsKyotjE7/sGiZUDTRZwUDZEmTC6gvghUcCoI222s
	+AEGOQ9L3Rri8vwacjTAQ0M8gRh2Ps9gCyvaHb26i7GyzeWUIW4uPRMvK0z48Xslf6SwH0
	zwj7lS3OsqODn+ta6d1M2w22Zxr3NcU=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=UD1AQhXG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749079055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0TgAqi+TpROS+//QswTJX8IQkXD9MrvP5t4UjKxe9gA=;
	b=UD1AQhXGefF8YR8MaEDe7DbaHdecyfsKyotjE7/sGiZUDTRZwUDZEmTC6gvghUcCoI222s
	+AEGOQ9L3Rri8vwacjTAQ0M8gRh2Ps9gCyvaHb26i7GyzeWUIW4uPRMvK0z48Xslf6SwH0
	zwj7lS3OsqODn+ta6d1M2w22Zxr3NcU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CB0A1369A
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 23:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jW3VDw7UQGiFIQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 23:17:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: add the missing help strings for inode-flags
Date: Thu,  5 Jun 2025 08:47:16 +0930
Message-ID: <ea6db46271a985175784196cb1079948677cf8ca.1749079032.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 42ACF22C53
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.976];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01
X-Spam-Level: 

Although there is man page entry for the "--inode-flags" option, it's
not in the "mkfs.btrfs --help" output.

Fix it by adding the help strings into mkfs.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
If there is still enough time before the next progs release, this can be
folded in the patch which introduced the new option.
---
 mkfs/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index 9fa1f8d108e3..a06b111a3dd1 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -463,6 +463,10 @@ static const char * const mkfs_usage[] = {
 	OPTLINE("", "- ro - create the subvolume as read-only"),
 	OPTLINE("", "- default - the SUBDIR will be a subvolume and also set as default (can be specified only once)"),
 	OPTLINE("", "- default-ro - like 'default' and is created as read-only subvolume (can be specified only once)"),
+	OPTLINE("--inode-flags FLAGS:PATH", "specify that path to have inode flags, can be specified multiple times"),
+	OPTLINE("", "FLAGS is one of:"),
+	OPTLINE("", "- nodatacow - disable data CoW, implies nodatasum for regular files"),
+	OPTLINE("", "- nodatasum - disable data checksum only"),
 	OPTLINE("--shrink", "(with --rootdir) shrink the filled filesystem to minimal size"),
 	OPTLINE("-K|--nodiscard", "do not perform whole device TRIM"),
 	OPTLINE("-f|--force", "force overwrite of existing filesystem"),
-- 
2.49.0


