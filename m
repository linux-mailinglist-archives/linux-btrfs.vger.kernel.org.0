Return-Path: <linux-btrfs+bounces-19823-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 037E1CC682E
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 09:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2319F3064E58
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Dec 2025 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97CB339878;
	Wed, 17 Dec 2025 08:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ArZeu79d";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KBJmZ1MH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0D3336EEA
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765958918; cv=none; b=d8IWcgYMsJlL0U4JfuTOQMLNs61wjHZqMoXcyeTxGtRQWYuwQz7VNvpxyXkHeEJ0g9DrKySuat93hRoDZGu0CF2fJ1WDWoEzYQRfK1HejIhNh6JwAQY/d/eJt+SQWyp8CP2oWQ+rznYAPhKpZgeae+g9Mo0dq5pVVCGJKPhUbXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765958918; c=relaxed/simple;
	bh=qzoTpoDj26WD6ODNjOyxcTzHUDE58QSjeji70evo15I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsTrsjJLSlCPLaf44XUlB/OmJQ4Z+AM+/q+LkG06RHPbjhEWnDTmtEfjISt13JnxKn+6uicTHPZP1dBnef8+ot+7OyXd6zSg85t/kblF2QZahyCSXFJykx26w4kJe/QQaMgXWLKuHtfWTjJ36Zlv5zTK7wXeO9h62TCo7gC7EaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ArZeu79d; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KBJmZ1MH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA73F336C6
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFr0gr+4dta4UuyHLIht5Yq/r6lrq7BGPDvxRPftglo=;
	b=ArZeu79dfkgHogwo0VWn3NLIGcFRiPG/yJMqeFBNQQjJ6ti52L4t/ms+wg+2svIQxfH83i
	ha/HfqZU0J2IX8s0IG+yL4hViU9h4ycaMEzaPhYL83sQcgX0qcLeOr/wgnLlYAEi/v/Kms
	z++Cupb0isnYYepcxwU6b23+s6L/uMM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KBJmZ1MH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1765958901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DFr0gr+4dta4UuyHLIht5Yq/r6lrq7BGPDvxRPftglo=;
	b=KBJmZ1MH5ZY0z7DCE+vFR1oEBSQ5mR/C6SIQW096KdypwysJSrXv1Z94VB86L/tWlZOchE
	RJpZ5k0kypXkCI1y2Lr2EWuIlLWxL2+ZKrddJWEkXeo+lfQ7fvbH6lNMeAQpSQ8MWSKMrK
	GOZAdEQ9msZPL+8n3BDDLG9nlXVMwnM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A9713EA63
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kDYaOPRkQmmoGQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Dec 2025 08:08:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] btrfs-progs: check/lowmem: fix INODE_REF repair
Date: Wed, 17 Dec 2025 18:38:14 +1030
Message-ID: <c634cd92dd6c6da05dc1be1444f1c98f85d9c4f6.1765958753.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1765958753.git.wqu@suse.com>
References: <cover.1765958753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: DA73F336C6
X-Spam-Flag: NO
X-Spam-Score: -3.01

[BUG]
Although lowmem has the logical to repair one missing
INODE_REF/DIR_INDEX/DIR_ITEM, there is a catch in missing INODE_REF.

If we're checking an DIR_ITEM (which we normally hits first), and failed
to find the INODE_REF, we are in a situation where there is no @index to
delete the original DIR_INDEX/DIR_ITEM pair.

This can cause further damage to the fs, without really improving
anything.

[CAUSE]
There is a minimal example where there is missing INODE_ITEM:

	item 0 key (256 INODE_ITEM 0) itemoff 16123 itemsize 160
		generation 3 transid 9 size 12 nbytes 16384
		block group 0 mode 40755 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)
	item 1 key (256 INODE_REF 256) itemoff 16111 itemsize 12
		index 0 namelen 2 name: ..
	item 2 key (256 DIR_ITEM 496027801) itemoff 16075 itemsize 36
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 6
		name: foobar
	item 3 key (256 DIR_INDEX 2) itemoff 16039 itemsize 36
		location key (257 INODE_ITEM 0) type FILE
		transid 9 data_len 0 name_len 6
		name: foobar
	item 4 key (257 INODE_ITEM 0) itemoff 15879 itemsize 160
		generation 9 transid 9 size 0 nbytes 0
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 1 flags 0x0(none)

For above case, if we're check the DIR_ITEM, we can find the INODE_ITEM
but not the INODE_REF.

So we need to repair it, but at this stage we haven't checked DIR_INDEX,
this means we have no idea which index we should delete, leaving the
default @index as (-1).

If we call btrfs_unlink() with that (-1) as index, it will not delete
the (256 DIR_INDEX 2) one, then re-add a link using -1 as index, causing
more damage.

[FIX]
Before calling btrfs_unlink(), do an extra check on if we're called from
DIR_ITEM checks (aka, @index is -1) and we only detected a missing
INODE_REF yet.

If so, do find_dir_index() call to determine the DIR_INDEX, if that
failed it means we have missing both DIR_INDEX and INODE_REF, thus
should remove the lone DIR_ITEM instead.

With this enhancement, lowmem mode can properly fix the missing
INODE_REF by adding it back.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 8a4c5bc1e10d..dcec6cc06510 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1015,6 +1015,17 @@ static int repair_ternary_lowmem(struct btrfs_root *root, u64 dir_ino, u64 ino,
 	int stage = 0;
 	int ret = 0;
 
+	/*
+	 * We miss an INODE_REF, and we're checking DIR_ITEM and hasn't yet
+	 * find the DIR_INDEX, thus there is no reliable index.
+	 * Try to locate one, this can be slow as we need to locate the DIR_INDEX
+	 * item from the directory.
+	 */
+	if (index == (u64)-1 && (err & INODE_REF_MISSING)) {
+		ret = find_dir_index(root, dir_ino, ino, &index, name, name_len, filetype);
+		if (ret < 0)
+			err |= DIR_INDEX_MISSING;
+	}
 	/*
 	 * stage shall be one of following valild values:
 	 *	0: Fine, nothing to do.
-- 
2.52.0


