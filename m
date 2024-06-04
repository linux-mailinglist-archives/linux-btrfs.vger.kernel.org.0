Return-Path: <linux-btrfs+bounces-5432-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B98FA96B
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 06:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD7EB25F21
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Jun 2024 04:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62C130A49;
	Tue,  4 Jun 2024 04:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Uz/lBXZl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Uz/lBXZl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4352D12EBC7
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717476579; cv=none; b=e5fRVG0PlcD7BSqMb58S3C10zxlTzQ2sRy/N0YBBMg3pbGR62xFr56GgTdpNRBa/oE2/ixPCndkXRDxNjbKeTX3vCOZnrMTba3HInvv6jslYW0OqNPSAwPoLk+sVgpMYuwn2uaYNdBiNlXiTbWnIw0qTj/2uBma3XSzWuViZAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717476579; c=relaxed/simple;
	bh=PZ2HDVSZ4VyYwCx3VZhoCHK401SnUK5LxvjLJMs73M4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=TgLzuwyRtg0fvudQ27Cu7hGXmfdmes2cctWZNJCVzbWdapJ0+cwPocbzma8CR11QLW6PN43O9Gl18Vgmr33TXQVoWWZLL+O7lsXO5VEmZqWqkZI8wsn//ycnqMWgVILXZiN+sOhEVXXkC2ObA2X4YlguYTIOYDKV0ZAuL36XEqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Uz/lBXZl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Uz/lBXZl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51B9621999
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717476575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6kvOLK3RdeCOYkMxQh3BqwinpGm3EViPpx7E5ZPvm9U=;
	b=Uz/lBXZlnF15MH9i2wvGSjAse3XIHv6fnAStzeqt9aik5d6BZpBcALW+cbhjnJr3YZ4vvU
	tCOmGGunk9yRpzJ18WuImpc4Oli8bDtImPPWUlcGNOxBh8FslLNV3FT5oj92AOyqu3Al7r
	hPLMVg6E+9gT03T5M3keeNV5M9vGD6U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1717476575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6kvOLK3RdeCOYkMxQh3BqwinpGm3EViPpx7E5ZPvm9U=;
	b=Uz/lBXZlnF15MH9i2wvGSjAse3XIHv6fnAStzeqt9aik5d6BZpBcALW+cbhjnJr3YZ4vvU
	tCOmGGunk9yRpzJ18WuImpc4Oli8bDtImPPWUlcGNOxBh8FslLNV3FT5oj92AOyqu3Al7r
	hPLMVg6E+9gT03T5M3keeNV5M9vGD6U=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EE8D1398F
	for <linux-btrfs@vger.kernel.org>; Tue,  4 Jun 2024 04:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ryj/BN6cXmbaVAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 04 Jun 2024 04:49:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: print-tree: do sanity checks for dir items
Date: Tue,  4 Jun 2024 14:19:08 +0930
Message-ID: <0279bccaf02bbc09d6ac685b37e36aacb60bf9b0.1717476533.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -1.89
X-Spam-Level: 
X-Spamd-Result: default: False [-1.89 / 50.00];
	BAYES_HAM(-2.09)[95.56%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

There is a bug report that with UBSAN enabled, fuzz/006 test case would
crash.

It turns out that the image bko-154021-invalid-drop-level.raw has
invalid dir items, that the name/data len is beyond the item.

And if we try to read beyond the eb boundary, UBSAN got triggered.

Normally in kernel tree-checker would reject such metadata in the first
place, but in btrfs-progs we can not go that strict or we can not do a
lot of repair.

So here just enhance print_dir_item() to do extra sanity checks for
data/name len before reading the contents.

Issue: #805
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/print-tree.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 1b9386d87a0a..9a72ba39b426 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -78,6 +78,11 @@ static void print_dir_item(struct extent_buffer *eb, u32 size,
 		printf("\n");
 		name_len = btrfs_dir_name_len(eb, di);
 		data_len = btrfs_dir_data_len(eb, di);
+		if (data_len + name_len + cur > size) {
+			error("invalid length, cur=%u name_len=%u data_len=%u size=%u\n",
+				cur, name_len, data_len, size);
+			break;
+		}
 		len = (name_len <= sizeof(namebuf))? name_len: sizeof(namebuf);
 		printf("\t\ttransid %llu data_len %u name_len %u\n",
 				btrfs_dir_transid(eb, di),
-- 
2.45.2


