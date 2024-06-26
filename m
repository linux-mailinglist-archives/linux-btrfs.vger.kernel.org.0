Return-Path: <linux-btrfs+bounces-5983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF439175E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 03:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9354B281470
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jun 2024 01:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98708219FC;
	Wed, 26 Jun 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cZ5DSO6i";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="cZ5DSO6i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73941C6A0
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Jun 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719366482; cv=none; b=jQSaGlRoB1mi/JVwy5zayksn+hizceMgOMWmLj90Ml1lGQoao4/1hDs/EzIdq8R16D7/OpR9lukVzWgxOUfxOzAz0kRk8RfP2MLyXXpJ8lyg9NIaIXcubC7bRjoLdYtMV1P93+YaW5GKAaLZCeFFR5m86l5G8y5DULJkolxTEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719366482; c=relaxed/simple;
	bh=/PAcXQtAWiVaZTagNtYFNVksqB4t2LFb7V60Bt2zJIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIPa43lfky+W7zJjMAXtllz7kLC9dVPC486TDhW39VewvYGMcZjNgP3OcB2jJrYVWZhPt0BtnpXAvOp5p3Yfk4h1waacUnPtW/aCfg7Gvd68Mi97cgB1TRh7EkfrWtRlhLk9YfeA0ihaeFRPQOTTQF/PsxK4qJWW2c6uuLYVQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cZ5DSO6i; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=cZ5DSO6i; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 031191F8C5;
	Wed, 26 Jun 2024 01:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIJT1RU+Zlvt5g/BAWTJCGAssQp1hfCMn5odrxIjwVg=;
	b=cZ5DSO6i8JHjERphuq6fQET/z3I4WHJ8z7OnTje64KnGIdMa0QnZda6D1xhVw9v4v0kjzh
	LMAn6pnk52GmCJ/iBvsZxPXqMxaJkEDVj0Wm+4mqHG0b5Ye66llqy1JSEye4DadnGPCVcc
	GbpoRLar691pGGD4t98lnP3N1z6RII0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=cZ5DSO6i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1719366479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIJT1RU+Zlvt5g/BAWTJCGAssQp1hfCMn5odrxIjwVg=;
	b=cZ5DSO6i8JHjERphuq6fQET/z3I4WHJ8z7OnTje64KnGIdMa0QnZda6D1xhVw9v4v0kjzh
	LMAn6pnk52GmCJ/iBvsZxPXqMxaJkEDVj0Wm+4mqHG0b5Ye66llqy1JSEye4DadnGPCVcc
	GbpoRLar691pGGD4t98lnP3N1z6RII0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB440139C2;
	Wed, 26 Jun 2024 01:47:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MHY9HE1ze2ZtbgAAD6G6ig
	(envelope-from <wqu@suse.com>); Wed, 26 Jun 2024 01:47:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v2 4/5] btrfs: fix the ram_bytes assignment for truncated ordered extents
Date: Wed, 26 Jun 2024 11:17:32 +0930
Message-ID: <374f255621253a6bc487cc38435be1130bce76be.1719366258.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719366258.git.wqu@suse.com>
References: <cover.1719366258.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 031191F8C5
X-Spam-Score: -5.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

[HICCUP]
After adding extra checks on btrfs_file_extent_item::ram_bytes to
tree-checker, running fsstress leads to tree-checker warning at write time,
as we created file extent items with an invalid ram_bytes.

All those offending file extents have offset 0, and ram_bytes matching
num_bytes, and smaller than disk_num_bytes.

This would also trigger the recently enhanced btrfs-check, which catches
such mismatches and report them as minor errors.

[CAUSE]
When a folio/page is invalidated and it is part of a submitted OE, we
mark the OE truncated just to the beginning of the folio/page.

And for truncated OE, we insert the file extent item with incorrect
value for ram_bytes (using num_bytes instead of the usual value).

This is not a big deal for end users, as we do not utilize the ram_bytes
field for regular non-compressed extents.
This mismatch is just a small violation against on-disk format.

[FIX]
Fix it by removing the override on btrfs_file_extent_item::ram_bytes.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d6c43120c5d3..45f77ae8963f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3018,10 +3018,8 @@ static int insert_ordered_extent_file_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi,
 						   oe->disk_num_bytes);
 	btrfs_set_stack_file_extent_offset(&stack_fi, oe->offset);
-	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags)) {
+	if (test_bit(BTRFS_ORDERED_TRUNCATED, &oe->flags))
 		num_bytes = oe->truncated_len;
-		ram_bytes = num_bytes;
-	}
 	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
 	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, ram_bytes);
 	btrfs_set_stack_file_extent_compression(&stack_fi, oe->compress_type);
-- 
2.45.2


